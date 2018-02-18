<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: IndexController.php 10075 2013-07-30 21:51:18Z jung $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class User_IndexController extends Core_Controller_Action_Standard
{
  public function indexAction()
  {

  }

  public function homeAction()
  {
    // check public settings
    $require_check = Engine_Api::_()->getApi('settings', 'core')->getSetting('core.general.portal', 1);
    if(!$require_check){
      if( !$this->_helper->requireUser()->isValid() ) return;
    }

    if( !Engine_Api::_()->user()->getViewer()->getIdentity() ) {
      return $this->_helper->redirector->gotoRoute(array(), 'default', true);
    }
    $this->_helper->redirector->gotoRoute(array(), 'dashboard_general', true);
    
     
    // Render
    /*$this->_helper->content
        ->setNoRender()
        ->setEnabled()
        ;*/
  }

  public function browseAction()
  {
    $require_check = Engine_Api::_()->getApi('settings', 'core')->getSetting('core.general.browse', 1);
    if(!$require_check){
      if( !$this->_helper->requireUser()->isValid() ) return;
    }
    if( !$this->_executeSearch() ) {
      // throw new Exception('error');
    }

    if( $this->_getParam('ajax') ) {
      $this->renderScript('_browseUsers.tpl');
    }

    if( !$this->_getParam('ajax') ) {
    // Render
    $this->_helper->content
        ->setEnabled()
        ;
    }
        $table = Engine_Api::_()->getItemTable('user');
    $onlineTable = Engine_Api::_()->getDbtable('online', 'user');

    $tableName = $table->info('name');
    $onlineTableName = $onlineTable->info('name');


    $viewer = Engine_Api::_()->user()->getViewer();
    $viewerId   =   $viewer->getIdentity();

    $online_select = $table->select()
      ->from($tableName)
      ->joinRight($onlineTableName, $onlineTableName.'.user_id = '.$tableName.'.user_id', null)
      ->where($onlineTableName.'.user_id > ?', 0)
      ->where($onlineTableName.'.active > ?', new Zend_Db_Expr('DATE_SUB(NOW(),INTERVAL 20 MINUTE)'))
      ->where($tableName.'.search = ?', 1)
      ->where($tableName.'.enabled = ?', 1)
      ->where($onlineTableName.'.user_id != ?', $viewerId) // to hide logged in user from showing in member online widget
      ->order($onlineTableName.'.active DESC')
      ->group($onlineTableName.'.user_id')
      ;

     $online_users_Data=$table->fetchAll($online_select);



  $this->view->online_users =$online_users_Data;

  }

  protected function _executeSearch()
  {
    // Check form
    $form = new User_Form_Search(array(
      'type' => 'user',
      'ptype' => 'user'
    ));

    if( !$form->isValid($this->_getAllParams()) ) {
      $this->view->error = true;
      $this->view->totalUsers = 0;
      $this->view->userCount = 0;
      $this->view->page = 1;
      return false;
    }

    $this->view->form = $form;

    // Get search params
    $page = (int)  $this->_getParam('page', 1);
    $ajax = (bool) $this->_getParam('ajax', false);
    $options = $form->getValues();

    // Process options
    $tmp = array();
    $originalOptions = $options;
    foreach( $options as $k => $v ) {
      if( null == $v || '' == $v || (is_array($v) && count(array_filter($v)) == 0) ) {
        continue;
      } else if( false !== strpos($k, '_field_') ) {
        list($null, $field) = explode('_field_', $k);
        $tmp['field_' . $field] = $v;
      } else if( false !== strpos($k, '_alias_') ) {
        list($null, $alias) = explode('_alias_', $k);
        $tmp[$alias] = $v;
      } else {
        $tmp[$k] = $v;
      }
    }
    $options = $tmp;

    // Get table info
    $table = Engine_Api::_()->getItemTable('user');
    $userTableName = $table->info('name');

    $searchTable = Engine_Api::_()->fields()->getTable('user', 'search');
    $searchTableName = $searchTable->info('name');

    //extract($options); // displayname
    $profile_type = @$options['profile_type'];
    $displayname = @$options['displayname'];
    if (!empty($options['extra'])) {
      extract($options['extra']); // is_online, has_photo, submit
    }

    // Contruct query
    $select = $table->select()
      //->setIntegrityCheck(false)
      ->from($userTableName)
      ->joinLeft($searchTableName, "`{$searchTableName}`.`item_id` = `{$userTableName}`.`user_id`", null)
      //->group("{$userTableName}.user_id")
      ->where("{$userTableName}.search = ?", 1)
      ->where("{$userTableName}.enabled = ?", 1);

    $searchDefault = true;

    // Build the photo and is online part of query
    if( isset($has_photo) && !empty($has_photo) ) {
      $select->where($userTableName.'.photo_id != ?', "0");
      $searchDefault = false;
    }

    if( isset($is_online) && !empty($is_online) ) {
      $select
        ->joinRight("engine4_user_online", "engine4_user_online.user_id = `{$userTableName}`.user_id", null)
        ->group("engine4_user_online.user_id")
        ->where($userTableName.'.user_id != ?', "0");
      $searchDefault = false;
    }

    // Add displayname
    if( !empty($displayname) ) {
      $select->where("(`{$userTableName}`.`username` LIKE ? || `{$userTableName}`.`displayname` LIKE ?)", "%{$displayname}%");
      $searchDefault = false;
    }

    // Build search part of query
    $searchParts = Engine_Api::_()->fields()->getSearchQuery('user', $options);
    foreach( $searchParts as $k => $v ) {
      $select->where("`{$searchTableName}`.{$k}", $v);

      if(isset($v) && $v != ""){
        $searchDefault = false;
      }
    }

    if($searchDefault){
      $select->order("{$userTableName}.lastlogin_date DESC");
    } else {
      $select->order("{$userTableName}.displayname ASC");
    }

    // Build paginator
    $paginator = Zend_Paginator::factory($select);
    $paginator->setItemCountPerPage(10);
    $paginator->setCurrentPageNumber($page);

    $this->view->page = $page;
    $this->view->ajax = $ajax;
    $this->view->users = $paginator;
    $this->view->totalUsers = $paginator->getTotalItemCount();
    $this->view->userCount = $paginator->getCurrentItemCount();
    $this->view->topLevelId = $form->getTopLevelId();
    $this->view->topLevelValue = $form->getTopLevelValue();
    $this->view->formValues = array_filter($originalOptions);

    return true;
  }
  protected function old_executeSearch()
  {
    // Check form
    $form = new User_Form_Search(array(
      'type' => 'user',
      'ptype' => 'user'
    ));

    if( !$form->isValid($this->_getAllParams()) ) {
      $this->view->error = true;
      $this->view->totalUsers = 0;
      $this->view->userCount = 0;
      $this->view->page = 1;
      return false;
    }

    $this->view->form = $form;

    // Get search params
    $page = (int)  $this->_getParam('page', 1);
    $ajax = (bool) $this->_getParam('ajax', false);
    $options = $form->getValues();

    // Process options
    $tmp = array();
    $originalOptions = $options;
    foreach( $options as $k => $v ) {
      if( null == $v || '' == $v || (is_array($v) && count(array_filter($v)) == 0) ) {
        continue;
      } else if( false !== strpos($k, '_field_') ) {
        list($null, $field) = explode('_field_', $k);
        $tmp['field_' . $field] = $v;
      } else if( false !== strpos($k, '_alias_') ) {
        list($null, $alias) = explode('_alias_', $k);
        $tmp[$alias] = $v;
      } else {
        $tmp[$k] = $v;
      }
    }
    $options = $tmp;

    // Get table info
    $table = Engine_Api::_()->getItemTable('user');
    $userTableName = $table->info('name');

    $searchTable = Engine_Api::_()->fields()->getTable('user', 'search');
    $searchTableName = $searchTable->info('name');

    //extract($options); // displayname
    $profile_type = @$options['profile_type'];
    $displayname = @$options['displayname'];
    if (!empty($options['extra'])) {
      extract($options['extra']); // is_online, has_photo, submit
    }

    // Contruct query
    $select = $table->select()
      //->setIntegrityCheck(false)
      ->from($userTableName)
      ->joinLeft($searchTableName, "`{$searchTableName}`.`item_id` = `{$userTableName}`.`user_id`", null)
      //->group("{$userTableName}.user_id")
      ->where("{$userTableName}.search = ?", 1)
      ->where("{$userTableName}.enabled = ?", 1);

    $searchDefault = true;

    // Build the photo and is online part of query
    if( isset($has_photo) && !empty($has_photo) ) {
      $select->where($userTableName.'.photo_id != ?', "0");
      $searchDefault = false;
    }

    if( isset($is_online) && !empty($is_online) ) {
      $select
        ->joinRight("engine4_user_online", "engine4_user_online.user_id = `{$userTableName}`.user_id", null)
        ->group("engine4_user_online.user_id")
        ->where($userTableName.'.user_id != ?', "0");
      $searchDefault = false;
    }

    // Add displayname
    if( !empty($displayname) ) {
      $select->where("(`{$userTableName}`.`username` LIKE ? || `{$userTableName}`.`displayname` LIKE ?)", "%{$displayname}%");
      $searchDefault = false;
    }

    // Build search part of query
    $searchParts = Engine_Api::_()->fields()->getSearchQuery('user', $options);
    foreach( $searchParts as $k => $v ) {
      $select->where("`{$searchTableName}`.{$k}", $v);

      if(isset($v) && $v != ""){
        $searchDefault = false;
      }
    }

    if($searchDefault){
      $select->order("{$userTableName}.lastlogin_date DESC");
    } else {
      $select->order("{$userTableName}.displayname ASC");
    }

    // Build paginator
    $paginator = Zend_Paginator::factory($select);
    $paginator->setItemCountPerPage(10);
    $paginator->setCurrentPageNumber($page);

    $this->view->page = $page;
    $this->view->ajax = $ajax;
    $this->view->users = $paginator;
    $this->view->totalUsers = $paginator->getTotalItemCount();
    $this->view->userCount = $paginator->getCurrentItemCount();
    $this->view->topLevelId = $form->getTopLevelId();
    $this->view->topLevelValue = $form->getTopLevelValue();
    $this->view->formValues = array_filter($originalOptions);

    return true;
  }

  // function for list tenants

public function tenantsAction() {

    if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
    $this->_helper->viewRenderer->setNoRender(false);
    $this->_helper->layout->setLayout('property_detail');
     $form = new User_Form_Search(array(
      'type' => 'user',
      'ptype' => 'tenants'
       ));

    if( !$form->isValid($this->_getAllParams()) ) {
      $this->view->error = true;
      $this->view->totalUsers = 0;
      $this->view->userCount = 0;
      $this->view->page = 1;
      return false;
    }

    $this->view->form = $form;


    $page = (int)  $this->_getParam('page', 1);
    $ajax = (bool) $this->_getParam('ajax', false);

     $options = $form->getValues();

    // Process options
    $tmp = array();
    $originalOptions = $options;
    foreach( $options as $k => $v ) {
      if( null == $v || '' == $v || (is_array($v) && count(array_filter($v)) == 0) ) {
        continue;
      } else if( false !== strpos($k, '_field_') ) {
        list($null, $field) = explode('_field_', $k);
        $tmp['field_' . $field] = $v;
      } else if( false !== strpos($k, '_alias_') ) {
        list($null, $alias) = explode('_alias_', $k);
        $tmp[$alias] = $v;
      } else {
        $tmp[$k] = $v;
      }
    }
    $options = $tmp;

    // Get table info
    $table = Engine_Api::_()->getItemTable('user');
    $userTableName = $table->info('name');

    $searchTable = Engine_Api::_()->fields()->getTable('user', 'search');
    $searchTableName = $searchTable->info('name');
//print_r($options);
//exit;
    extract($options); // displayname
    $profile_type = @$options['profile_type'];
    $displayname = @$options['displayname'];
    $keyword = @$options['keyword'];

    if (!empty($options['extra'])) {
      extract($options['extra']); // is_online, has_photo, submit


    }


    $select   =   $table->select()
                        ->setIntegrityCheck(false)
                        ->from(array('user'=>'engine4_users',))
                        ->joinLeft(array('search_field'=>'engine4_user_fields_search'),'search_field.item_id=user.user_id',null)
                        ->joinLeft(array('fields_value'=>'engine4_user_fields_values'),'fields_value.item_id=user.user_id',array('value'))
                        ->joinLeft(array('state'=>'engine4_state_list',),'state.state_id=search_field.field_76',array('state'))
                        ->joinLeft(array('city'=>'engine4_city_list',),'city.city_id=search_field.field_77',array('city'))
                        ->where('user.search=?' , 1)
                      //  ->where('user.level_id=?' , 7)
                        ->where('user.enabled=?' , 1)
                        ->where('search_field.profile_type =?' , '1')
                        ->where('fields_value.field_id=?' , 13)
                        ->group('user.user_id');

    $searchDefault = true;

    // Build the photo and is online part of query
    if( isset($has_photo) && !empty($has_photo) ) {
      $select->where('user.photo_id !=?' , 0);
      $searchDefault = false;
    }

    if( isset($is_online) && !empty($is_online) ) {
      $select
        ->joinRight(array('user_online'=>'engine4_user_online',),'user_online.user_id=user.user_id',null)
        ->group('user_online.user_id')
         ->where('user.user_id !=?' , 0);
      $searchDefault = false;
    }

    // Add displayname
    if( !empty($displayname) ) {
      $select->where('user.username LIKE ?' , '%{$displayname}%');
      $searchDefault = false;
    }
    if( !empty($keyword) ) {
        $select->joinLeft(array('core_search'=>'engine4_core_search',),'core_search.id=user.user_id',null)
        ->where('core_search.title LIKE ?' , "%{$keyword}%");

      $searchDefault = false;
    }

    // Build search part of query
    $searchParts = Engine_Api::_()->fields()->getSearchQuery('user', $options);
 //  print_r($options); exit;
   foreach( $options as $k => $v ) {
       if($k!='keyword') {
      $select->where('search_field.'.$k.' =?' ,  $v);
    }

    if(isset($v) && $v != ""){
        $searchDefault = false;
      }
    }
    //$select->where('search_field.profile_type =?' , 1);  echo $select;exit;
      //  $select->where('search_field.profile_type =?' , "1");

    if($searchDefault){
      $select->order('user.lastlogin_date DESC');
    } else {
      $select->order('user.displayname ASC');
    }
    //echo $select;
    //exit();
    // Build paginator
    $paginator = Zend_Paginator::factory($select);
    $paginator->setItemCountPerPage(10);
    $paginator->setCurrentPageNumber($page);


    $this->view->page = $page;
    $this->view->ajax = $ajax;
    $this->view->users = $paginator;
    $this->view->totalUsers = $paginator->getTotalItemCount();
    $this->view->userCount = $paginator->getCurrentItemCount();

     if( $this->_getParam('ajax') ) {
      $this->renderScript('_browseTenants.tpl');
    }

    if( !$this->_getParam('ajax') ) {
    // Render
    $this->_helper->content
        ->setEnabled()
        ;
    }
    $this->view->metaTitle        = 'Renters';

    $table = Engine_Api::_()->getItemTable('user');
    $onlineTable = Engine_Api::_()->getDbtable('online', 'user');

    $tableName = $table->info('name');
    $onlineTableName = $onlineTable->info('name');


    $viewer = Engine_Api::_()->user()->getViewer();
    $viewerId   =   $viewer->getIdentity();

    $online_select = $table->select()
      ->from($tableName)
      ->joinRight($onlineTableName, $onlineTableName.'.user_id = '.$tableName.'.user_id', null)
      ->where($onlineTableName.'.user_id > ?', 0)
      ->where($onlineTableName.'.active > ?', new Zend_Db_Expr('DATE_SUB(NOW(),INTERVAL 20 MINUTE)'))
      ->where($tableName.'.search = ?', 1)
      ->where($tableName.'.enabled = ?', 1)
      ->where($onlineTableName.'.user_id != ?', $viewerId) // to hide logged in user from showing in member online widget
      ->order($onlineTableName.'.active DESC')
      ->group($onlineTableName.'.user_id')
      ;

     $online_users_Data=$table->fetchAll($online_select);



  $this->view->online_users =$online_users_Data;


    }

    public function old_tenantsAction() {

    if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

     $form = new User_Form_Search(array(
      'type' => 'user',
      'ptype' => 'tenants'
       ));

    if( !$form->isValid($this->_getAllParams()) ) {
      $this->view->error = true;
      $this->view->totalUsers = 0;
      $this->view->userCount = 0;
      $this->view->page = 1;
      return false;
    }

    $this->view->form = $form;


    $page = (int)  $this->_getParam('page', 1);
    $ajax = (bool) $this->_getParam('ajax', false);

     $options = $form->getValues();

    // Process options
    $tmp = array();
    $originalOptions = $options;
    foreach( $options as $k => $v ) {
      if( null == $v || '' == $v || (is_array($v) && count(array_filter($v)) == 0) ) {
        continue;
      } else if( false !== strpos($k, '_field_') ) {
        list($null, $field) = explode('_field_', $k);
        $tmp['field_' . $field] = $v;
      } else if( false !== strpos($k, '_alias_') ) {
        list($null, $alias) = explode('_alias_', $k);
        $tmp[$alias] = $v;
      } else {
        $tmp[$k] = $v;
      }
    }
    $options = $tmp;

    // Get table info
    $table = Engine_Api::_()->getItemTable('user');
    $userTableName = $table->info('name');

    $searchTable = Engine_Api::_()->fields()->getTable('user', 'search');
    $searchTableName = $searchTable->info('name');

    //extract($options); // displayname
    $profile_type = @$options['profile_type'];
    $displayname = @$options['displayname'];
    if (!empty($options['extra'])) {
      extract($options['extra']); // is_online, has_photo, submit
    }

    // Contruct query
    $select = $table->select()
      //->setIntegrityCheck(false)
      ->from($userTableName)
      ->joinLeft($searchTableName, "`{$searchTableName}`.`item_id` = `{$userTableName}`.`user_id`", null)
      //->group("{$userTableName}.user_id")
      ->where("{$userTableName}.search = ?", 1)
      ->where("{$userTableName}.level_id = ?", 7)
      ->where("{$userTableName}.enabled = ?", 1);

    $searchDefault = true;

    // Build the photo and is online part of query
    if( isset($has_photo) && !empty($has_photo) ) {
      $select->where($userTableName.'.photo_id != ?', "0");
      $searchDefault = false;
    }

    if( isset($is_online) && !empty($is_online) ) {
      $select
        ->joinRight("engine4_user_online", "engine4_user_online.user_id = `{$userTableName}`.user_id", null)
        ->group("engine4_user_online.user_id")
        ->where($userTableName.'.user_id != ?', "0");
      $searchDefault = false;
    }

    // Add displayname
    if( !empty($displayname) ) {
      $select->where("(`{$userTableName}`.`username` LIKE ? || `{$userTableName}`.`displayname` LIKE ?)", "%{$displayname}%");
      $searchDefault = false;
    }

    // Build search part of query
    $searchParts = Engine_Api::_()->fields()->getSearchQuery('user', $options);
   foreach( $options as $k => $v ) {
      $select->where("`{$searchTableName}`.{$k} = ?" , $v);

      if(isset($v) && $v != ""){
        $searchDefault = false;
      }
    }

    if($searchDefault){
      $select->order("{$userTableName}.lastlogin_date DESC");
    } else {
      $select->order("{$userTableName}.displayname ASC");
    }

    // Build paginator
    $paginator = Zend_Paginator::factory($select);
    $paginator->setItemCountPerPage(10);
    $paginator->setCurrentPageNumber($page);


    $this->view->page = $page;
    $this->view->ajax = $ajax;
    $this->view->users = $paginator;
    $this->view->totalUsers = $paginator->getTotalItemCount();
    $this->view->userCount = $paginator->getCurrentItemCount();

     if( $this->_getParam('ajax') ) {
      $this->renderScript('_browseTenants.tpl');
    }

    if( !$this->_getParam('ajax') ) {
    // Render
    $this->_helper->content
        ->setEnabled()
        ;
    }
    $this->view->metaTitle        = 'Tenants';
    }

     // function for list landlords

    public function landlordsAction() {

    $viewer_id              =   Engine_Api::_()->user()->getViewer()->getIdentity();
    $this->view->viewer     =   $viewer = Engine_Api::_()->user()->getViewer();
    $this->view->viewerId   =   $viewerId = $viewer->getIdentity();

    if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

    $this->_helper->viewRenderer->setNoRender(false);
    $this->_helper->layout->setLayout('property_detail');

    $form = new User_Form_Search(array(
      'type' => 'user',
      'ptype' => 'landlords'
    ));

    if( !$form->isValid($this->_getAllParams()) ) {
      $this->view->error = true;
      $this->view->totalUsers = 0;
      $this->view->userCount = 0;
      $this->view->page = 1;
      return false;
    }

    $this->view->form = $form;




    $page = (int)  $this->_getParam('page', 1);
    $ajax = (bool) $this->_getParam('ajax', false);

    $options = $form->getValues();

        // Process options
    $tmp = array();
    $originalOptions = $options;
    foreach( $options as $k => $v ) {
      if( null == $v || '' == $v || (is_array($v) && count(array_filter($v)) == 0) ) {
        continue;
      } else if( false !== strpos($k, '_field_') ) {
        list($null, $field) = explode('_field_', $k);
        $tmp['field_' . $field] = $v;
      } else if( false !== strpos($k, '_alias_') ) {
        list($null, $alias) = explode('_alias_', $k);
        $tmp[$alias] = $v;
      } else {
        $tmp[$k] = $v;
      }
    }
    $options = $tmp;



    // Get table info
    $table = Engine_Api::_()->getItemTable('user');
    $userTableName = $table->info('name');

    $searchTable = Engine_Api::_()->fields()->getTable('user', 'search');
    $searchTableName = $searchTable->info('name');

    $stateTable = Engine_Api::_()->getDbtable('state', 'user');
     $stateTableName = $stateTable->info('name');
   // extract($options); exit; // displayname
    $profile_type = @$options['profile_type'];
    $displayname = @$options['displayname'];
    $keyword = @$options['keyword'];

    if (!empty($options['extra'])) {
      extract($options['extra']); // is_online, has_photo, submit
    }

    $select   =   $table->select()
                        ->setIntegrityCheck(false)
                        ->from(array('user'=>'engine4_users',))
                        ->joinLeft(array('search_field'=>'engine4_user_fields_search'),'search_field.item_id=user.user_id',null)
                        ->joinLeft(array('country'=>'engine4_country_list',),'country.id=search_field.field_33',array('country'))
                        ->joinLeft(array('state'=>'engine4_state_list',),'state.state_id=search_field.field_30',array('state'))
                        ->joinLeft(array('city'=>'engine4_city_list',),'city.city_id=search_field.field_31',array('city'))
                        ->where('user.search=?' , 1)
                        ->where('user.enabled=?' , 1)
                        ->where('search_field.profile_type =?' , '4');





    $searchDefault = true;

    // Build the photo and is online part of query
    if( isset($has_photo) && !empty($has_photo) ) {
      $select->where('user.photo_id=?' , 0);
      $searchDefault = false;
    }

    if( isset($is_online) && !empty($is_online) ) {
      $select
        ->joinRight(array('user_online'=>'engine4_user_online'),'user_online.user_id=user.user_id',null)
        ->group('user_online.user_id')
        ->where('user.user_id !=?' , 0);
      $searchDefault = false;
    }

    // Add displayname
    if( !empty($displayname) ) {

      $select->where('user.username LIKE ?' , '%{$displayname}%');


      $searchDefault = false;
    }
   if( !empty($keyword) ) {
        $select->joinLeft(array('core_search'=>'engine4_core_search',),'core_search.id=user.user_id',null)
        ->where('core_search.title LIKE ?' , "%{$keyword}%");

      $searchDefault = false;
    }

    // Build search part of query
    $searchParts = Engine_Api::_()->fields()->getSearchQuery('user', $options);

    foreach( $options as $k => $v ) {
     if($k!='keyword') {
      $select->where('search_field.'.$k.' =?' ,  $v);

                       }
      if(isset($v) && $v != ""){
        $searchDefault = false;
      }
    }


    if($searchDefault){
      $select->order('user.lastlogin_date DESC');
    } else {
      $select->order('user.displayname ASC');
    }


    // Build paginator
    $paginator = Zend_Paginator::factory($select);
    $paginator->setItemCountPerPage(10);
    $paginator->setCurrentPageNumber($page);


    $this->view->page = $page;
    $this->view->ajax = $ajax;
    $this->view->users = $paginator;
    $this->view->totalUsers = $paginator->getTotalItemCount();
    $this->view->userCount = $paginator->getCurrentItemCount();

     if( $this->_getParam('ajax') ) {
      $this->renderScript('_browseLandlords.tpl');
    }

    if( !$this->_getParam('ajax') ) {
    // Render
    $this->_helper->content
        ->setEnabled()
        ;
    }
    $this->view->metaTitle        = 'Landlords';

    $table = Engine_Api::_()->getItemTable('user');
    $onlineTable = Engine_Api::_()->getDbtable('online', 'user');

    $tableName = $table->info('name');
    $onlineTableName = $onlineTable->info('name');


    $viewer = Engine_Api::_()->user()->getViewer();
    $viewerId   =   $viewer->getIdentity();

    $online_select = $table->select()
      ->from($tableName)
      ->joinRight($onlineTableName, $onlineTableName.'.user_id = '.$tableName.'.user_id', null)
      ->where($onlineTableName.'.user_id > ?', 0)
      ->where($onlineTableName.'.active > ?', new Zend_Db_Expr('DATE_SUB(NOW(),INTERVAL 20 MINUTE)'))
      ->where($tableName.'.search = ?', 1)
      ->where($tableName.'.enabled = ?', 1)
      ->where($onlineTableName.'.user_id != ?', $viewerId) // to hide logged in user from showing in member online widget
      ->order($onlineTableName.'.active DESC')
      ->group($onlineTableName.'.user_id')
      ;

     $online_users_Data=$table->fetchAll($online_select);

     $this->view->online_users =$online_users_Data;
    }



    public function old_landlordsAction() {

    if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
    $form = new User_Form_Search(array(
      'type' => 'user',
      'ptype' => 'landlords'
    ));

    if( !$form->isValid($this->_getAllParams()) ) {
      $this->view->error = true;
      $this->view->totalUsers = 0;
      $this->view->userCount = 0;
      $this->view->page = 1;
      return false;
    }

    $this->view->form = $form;




    $page = (int)  $this->_getParam('page', 1);
    $ajax = (bool) $this->_getParam('ajax', false);

    $options = $form->getValues();

        // Process options
    $tmp = array();
    $originalOptions = $options;
    foreach( $options as $k => $v ) {
      if( null == $v || '' == $v || (is_array($v) && count(array_filter($v)) == 0) ) {
        continue;
      } else if( false !== strpos($k, '_field_') ) {
        list($null, $field) = explode('_field_', $k);
        $tmp['field_' . $field] = $v;
      } else if( false !== strpos($k, '_alias_') ) {
        list($null, $alias) = explode('_alias_', $k);
        $tmp[$alias] = $v;
      } else {
        $tmp[$k] = $v;
      }
    }
    $options = $tmp;



    // Get table info
    $table = Engine_Api::_()->getItemTable('user');
    $userTableName = $table->info('name');

    $searchTable = Engine_Api::_()->fields()->getTable('user', 'search');
    $searchTableName = $searchTable->info('name');

    $stateTable = Engine_Api::_()->getDbtable('state', 'user');
    $stateTableName = $stateTable->info('name');

    //extract($options); // displayname
    $profile_type = @$options['profile_type'];
    $displayname = @$options['displayname'];
    if (!empty($options['extra'])) {
      extract($options['extra']); // is_online, has_photo, submit
    }

    // Contruct query
    $select = $table->select()
      //->setIntegrityCheck(false)
      ->from($userTableName)
      ->joinLeft($searchTableName, "`{$searchTableName}`.`item_id` = `{$userTableName}`.`user_id`", null)
      //->group("{$userTableName}.user_id")
      ->where("{$userTableName}.search = ?", 1)
      ->where("{$userTableName}.level_id = ?", 6)
      ->where("{$userTableName}.enabled = ?", 1);

    $searchDefault = true;

    // Build the photo and is online part of query
    if( isset($has_photo) && !empty($has_photo) ) {
      $select->where($userTableName.'.photo_id != ?', "0");
      $searchDefault = false;
    }

    if( isset($is_online) && !empty($is_online) ) {
      $select
        ->joinRight("engine4_user_online", "engine4_user_online.user_id = `{$userTableName}`.user_id", null)
        ->group("engine4_user_online.user_id")
        ->where($userTableName.'.user_id != ?', "0");
      $searchDefault = false;
    }

    // Add displayname
    if( !empty($displayname) ) {
      $select->where("(`{$userTableName}`.`username` LIKE ? || `{$userTableName}`.`displayname` LIKE ?)", "%{$displayname}%");
      $searchDefault = false;
    }

    // Build search part of query
    $searchParts = Engine_Api::_()->fields()->getSearchQuery('user', $options);
   // print_r($options); exit;
    foreach( $options as $k => $v ) {
      $select->where("`{$searchTableName}`.{$k} = ?" , $v);
     // $select->where($propertyTableName.'.country_id = ?', $country);

      if(isset($v) && $v != ""){
        $searchDefault = false;
      }
    }


    if($searchDefault){
      $select->order("{$userTableName}.lastlogin_date DESC");
    } else {
      $select->order("{$userTableName}.displayname ASC");
    }

    // Build paginator
    $paginator = Zend_Paginator::factory($select);
    $paginator->setItemCountPerPage(10);
    $paginator->setCurrentPageNumber($page);


    $this->view->page = $page;
    $this->view->ajax = $ajax;
    $this->view->users = $paginator;
    $this->view->totalUsers = $paginator->getTotalItemCount();
    $this->view->userCount = $paginator->getCurrentItemCount();

     if( $this->_getParam('ajax') ) {
      $this->renderScript('_browseLandlords.tpl');
    }

    if( !$this->_getParam('ajax') ) {
    // Render
    $this->_helper->content
        ->setEnabled()
        ;
    }
    $this->view->metaTitle        = 'Landlords';
    }

    // function for list services

    public function servicesAction() {

    if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
    $this->_helper->viewRenderer->setNoRender(false);
    $this->_helper->layout->setLayout('property_detail');


    $form = new User_Form_Search(array(
      'type' => 'user',
      'ptype' => 'services'
    ));

    if( !$form->isValid($this->_getAllParams()) ) {
      $this->view->error = true;
      $this->view->totalUsers = 0;
      $this->view->userCount = 0;
      $this->view->page = 1;
      return false;
    }

    $this->view->form = $form;

    $page = (int)  $this->_getParam('page', 1);
    $ajax = (bool) $this->_getParam('ajax', false);

    $options = $form->getValues();



        // Process options
    $tmp = array();
    $originalOptions = $options;

    foreach( $options as $k => $v ) {

      if( null == $v || '' == $v || (is_array($v) && count(array_filter($v)) == 0) ) {
        continue;
      } else if( false !== strpos($k, '_field_') ) {
        list($null, $field) = explode('_field_', $k);
        $tmp['field_' . $field] = $v;
      } else if( false !== strpos($k, '_alias_') ) {
        list($null, $alias) = explode('_alias_', $k);
        $tmp[$alias] = $v;
      } else {
        $tmp[$k] = $v;
      }
    }
    $options = $tmp;
    // Get table info
    $table = Engine_Api::_()->getItemTable('user');
    $userTableName = $table->info('name');

    $searchTable = Engine_Api::_()->fields()->getTable('user', 'search');
    $searchTableName = $searchTable->info('name');
    $profile_type = @$options['profile_type'];
    $displayname = @$options['displayname'];
    $servicetype = @$options['services_type_id'];
    $companyname = @$options['field_62'];
    $country = @$options['field_53'];
    $state = @$options['field_54'];
    $city = @$options['field_55'];
    $zipcode = @$options['field_68'];
    $keyword = @$options['keyword'];
    if (!empty($options['extra'])) {
      extract($options['extra']); // is_online, has_photo, submit
    }

  $select = $table->select()
        ->setIntegrityCheck(false)
        ->from(array('user'=>'engine4_users',))
        ->joinLeft(array('search_field'=>'engine4_user_fields_search'),'search_field.item_id=user.user_id',null)
        ->joinLeft(array('fields_value'=>'engine4_user_fields_values'),'fields_value.item_id=user.user_id',array('value'))
        ->joinLeft(array('state'=>'engine4_state_list',),'state.state_id=search_field.field_54',array('state'))
        ->joinLeft(array('city'=>'engine4_city_list',),'city.city_id=search_field.field_55',array('city'))
        ->where('user.search=?' , 1)
        ->Where('search_field.profile_type = ?', '6')
        ->where('user.enabled=?' , 1)
        ->where('fields_value.field_id=?' , 62);

    $searchDefault = true;

    // Build the photo and is online part of query
    if( isset($has_photo) && !empty($has_photo) ) {
      $select->where('user.photo_id !=?' , 0);
      $searchDefault = false;
    }

    if( isset($is_online) && !empty($is_online) ) {

    $select->joinRight(array('user_online'=>'engine4_user_online',),'user_online.user_id=user.user_id',null)
        ->group('user_online.user_id')
         ->where('user.user_id !=?' , 0);
    $searchDefault = false;
    }

    // Add displayname
    if( !empty($displayname) ) {
      $select->where('user.username LIKE ?' , '%{$displayname}%');
      $searchDefault = false;
    }
    if( !empty($keyword) ) {
        $select->joinLeft(array('core_search'=>'engine4_core_search',),'core_search.id=user.user_id',null)
        ->where('core_search.title LIKE ?' , "%{$keyword}%");

      $searchDefault = false;
    }

    // Add displayname
    if( !empty($servicetype) ) {

      $select->where('user.services_type_id = ?' , $servicetype);
      $searchDefault = false;
    }

    // Build search part of query
    $searchParts = Engine_Api::_()->fields()->getSearchQuery('user', $options);
    foreach( $options as $k => $v ) {
        if($k!='keyword' && $k!='services_type_id') {
      $select->where('search_field.'.$k.' =?' ,  $v);
  }
      if(isset($v) && $v != ""){
        $searchDefault = false;
      }
    }

    if($searchDefault){
      $select->order('user.lastlogin_date DESC');
    } else {
      $select->order('user.displayname ASC');
    }

    // Build paginator
    $paginator = Zend_Paginator::factory($select);
    $paginator->setItemCountPerPage(10);
    $paginator->setCurrentPageNumber($page);


    $this->view->page = $page;
    $this->view->ajax = $ajax;
    $this->view->users = $paginator;
    $this->view->totalUsers = $paginator->getTotalItemCount();
    $this->view->userCount = $paginator->getCurrentItemCount();

     if( $this->_getParam('ajax') ) {
      $this->renderScript('_browseServices.tpl');
    }

    if( !$this->_getParam('ajax') ) {
    // Render
    $this->_helper->content
        ->setEnabled()
        ;
    }
    $this->view->metaTitle        = 'Services';


    $table = Engine_Api::_()->getItemTable('user');
    $onlineTable = Engine_Api::_()->getDbtable('online', 'user');

    $tableName = $table->info('name');
    $onlineTableName = $onlineTable->info('name');


    $viewer = Engine_Api::_()->user()->getViewer();
    $viewerId   =   $viewer->getIdentity();

    $online_select = $table->select()
      ->from($tableName)
      ->joinRight($onlineTableName, $onlineTableName.'.user_id = '.$tableName.'.user_id', null)
      ->where($onlineTableName.'.user_id > ?', 0)
      ->where($onlineTableName.'.active > ?', new Zend_Db_Expr('DATE_SUB(NOW(),INTERVAL 20 MINUTE)'))
      ->where($tableName.'.search = ?', 1)
      ->where($tableName.'.enabled = ?', 1)
      ->where($onlineTableName.'.user_id != ?', $viewerId) // to hide logged in user from showing in member online widget
      ->order($onlineTableName.'.active DESC')
      ->group($onlineTableName.'.user_id')
      ;

     $online_users_Data=$table->fetchAll($online_select);



  $this->view->online_users =$online_users_Data;

    }


    public function addpropertyAction() {

    if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
     $viewer        = Engine_Api::_()->user()->getViewer();
     $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
        if( !empty($fieldsByAlias['profile_type']) ){
              $optionId        = $fieldsByAlias['profile_type']->getValue($viewer);
              $profile_type_id = $optionId->value;
        }
        if($profile_type_id != 4){ //if not landlord
            return $this->_forward('notfound');
        }
        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('property_detail');
        if(isset($_SESSION['video_ids'])){
            unset($_SESSION['video_ids']);
        }
    $SmartmoveApiManageTable = Engine_Api::_()->getDbtable('smartmoveapimanage', 'user');
    $select                  =   $SmartmoveApiManageTable->fetchRow($SmartmoveApiManageTable->select());
    $this->view->smartmoveApiEnable = $select-> enable;
    Engine_Api::_()->getApi('core', 'activity')->initGlobalVars();
    $this->view->shareupload= $shareupload=Engine_Api::_()->getApi('core', 'activity')->getGlobalVars('shareupload');
    $this->view->feeduploads= $feeduploads=Engine_Api::_()->getApi('core', 'activity')->getGlobalVars('feeduploads');
    $this->view->metaTitle        = 'Property Add Form';

    $propertyTable      =  Engine_Api::_()->getDbtable('propertylist', 'user');
    $propertylists       = $propertyTable->fetchAll($propertyTable->select()->where('property_owner_id = ?', $viewer ->getIdentity()));
    $this->view->propertylistsCount = count($propertylists);
    }

    public function savepropertyAction(){

        if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        $aData     = $this->_request->getPost();
        if($aData){
        $user_id   = Engine_Api::_()->user()->getViewer()->getIdentity();
        $viewer    = Engine_Api::_()->user()->getViewer();
        $fileids   = json_decode(stripslashes($aData['file_id']));
        $uptypes   = json_decode(stripslashes($aData['upload_type']));
        $fileids   = $aData['file_id'];
        $fileids   = explode(",",$fileids); //print_r($fileids);
        $aResult   = array();
        $shareupload  = $this->_getParam('shareuploads');
        $feeduploads  = $this->_getParam('feeduploads');
        $aAttachment  = array();
        date_default_timezone_set($viewer->timezone);

        $feedupload_session   =  json_decode($this->user_readsession($feeduploads), true);
        $shareupload_session  =  json_decode($this->user_readsession($shareupload), true);
        if(sizeof($feedupload_session) > 0) {
            $aAttachment    =  $feedupload_session;
            foreach( $feedupload_session as $iImage) {
                $path     =  dirname($_SERVER['SCRIPT_FILENAME']).'/public/feed/';
                $filename =  $iImage['name'];
                if(file_exists($path.$filename)){unlink($path.$filename);unlink($path.'small-'.$filename);}
            }
            $this->user_writesession($feeduploads,array());
            unset($_SESSION[$feeduploads]);
        }

        $propertyTable          =  Engine_Api::_()->getDbtable('propertylist', 'user');
        $propertyimageTable     =  Engine_Api::_()->getDbtable('propertyimages', 'user');
        $propertycountrtyTable  =  Engine_Api::_()->getDbtable('propertycountry', 'user');
        $propertystateTable     =  Engine_Api::_()->getDbtable('propertystate', 'user');
        $propertycityable       =  Engine_Api::_()->getDbtable('propertycity', 'user');
        try{
                $propertycountryData = $propertycountrtyTable->fetchRow($propertycountrtyTable->select()->where('prty_country = ?', $aData['prty_country']));
                if(count($propertycountryData) == 0){
                    $propertycountryid  =   $propertycountrtyTable->insert(array(
                    'prty_country'  => $aData['prty_country']
                    ));
                }
                else{
                    $propertycountryid =  $propertycountryData->country_id;
                }

                $propertystateDataSelect = $propertystateTable->select()
                    ->where('country_id = ?', $propertycountryid)
                    ->where('prty_state = ?', $aData['prty_state']);

                $propertystateData = $propertystateTable->fetchRow($propertystateDataSelect);
                if(count($propertystateData) == 0){
                    $propertystateid =   $propertystateTable->insert(array(
                    'country_id'  => $propertycountryid,
                    'prty_state'  => $aData['prty_state']
                    ));
                }
                else{
                    $propertystateid =  $propertystateData->state_id;
                }
                $propertycityDataSelect = $propertycityable->select()
                    ->where('country_id = ?', $propertycountryid)
                    ->where('state_id = ?',   $propertystateid)
                    ->where('prty_city = ?',  $aData['prty_city']);

                $propertycityData = $propertycityable->fetchRow($propertycityDataSelect);
                if(count($propertycityData) == 0){
                    $propertycityid=   $propertycityable->insert(array(
                    'country_id'  => $propertycountryid,
                    'state_id'    => $propertystateid,
                    'prty_city'   => $aData['prty_city'],
                    'zipcode'     => $aData['prty_zipcode'],
                    'latitude'    => $aData['prty_latitude'],
                    'longitude'   => $aData['prty_longitude']
                    ));

                }
                else{
                    $propertycityid =  $propertycityData->city_id;
                }
                if($viewer -> bg_verified == 1){
                    $admin_enable = 1;
                }
                else{
                    $admin_enable  = 0;
                }


                $propertyid=   $propertyTable->insert(array(
                    'property_owner_id'       => $user_id,
                    'property_name'           => $aData['property_name'],
                    'prty_country_id'         => $propertycountryid,
                    'prty_state_id'           => $propertystateid,
                    'prty_city_id'            => $propertycityid,
                    'prty_county'             => $aData['prty_county'],
                    'prty_neighborhood'       => $aData['prty_neighborhood'],
                    'zip'                     => $aData['prty_zipcode'],
                    'rental_type'             => $aData['rental_type'],
                    'description'             => $aData['description'],
                    'price'                   => $aData['price'],
                  //  'vouchers'                => $aData['accept_vouchers'],
                    'wheelchair_accessible'   => $aData['wheel_chair_accessible'],
                    'months_of_deposits'      => $aData['months_of_deposits'],
                    'property_manager'        => $aData['have_property_manager'],
                    'provide_parking'         => $aData['parking'],
                    'no_of_rooms'             => $aData['number_of_rooms'],
                    'housing_type'            => $aData['housing_type'],
                    'has_pets'                => $aData['allowed_pets'],
                    'pets_type'               => $aData['pets_type'],
                    'landlord_enable'         => 1,
                    'enable'                  => $admin_enable,
                    'created_at'              => date('Y-m-d H:i:s'),
                ));
                $vcount    =   count($_SESSION['video_ids']);
                    if(!empty($_SESSION['video_ids']))
                    {
                       for($v = 0; $v < count($fileids); $v++)
                        {
                            $propertyimageid=   $propertyimageTable->insert(array(
                                'property_id' => $propertyid,
                                'type' => 'video',
                                'storage_file_id' => $fileids[$v],
                            ));
                        }
                        unset($_SESSION['video_ids']);
                    }
        $body          = "has added a new <span class='feed_property_status'>".$aData['housing_type']." for ".$aData['rental_type']."</span>";
        $type          = 'property';
        $sponsor_id    = null;
        $sponsor_type  = null;
        $action        = Engine_Api::_()->getDbtable('actions', 'activity')->addActivity($viewer, $viewer, $type, $body);
        $searchTable   = Engine_Api::_()->getDbtable('search', 'core');
        $oStream       = Engine_Api::_()->getDbtable('stream', 'activity');
        $searchTableInsert    = array(
                                            'type'      => 'activity',
                                            'id'        =>  $action->action_id,
                                            'keywords'  => 'Property',
                                            'title'     => $aData['property_name'],
                                            );
        $searchTable->insert($searchTableInsert);
            if(count($aAttachment) > 0 ) {
                $aUpdatePhoto   = array();
                        if(count($aExistingTags)) {
                            $aUpdatePhoto['photo_tags']    = implode(",", $aExistingTags);
                        }
                        if(trim($aData['property_name']) != '')
                            $aUpdatePhoto['photo_caption']    = $aData['property_name'];

                        $sPostCount = "{\"count\":".count($aAttachment)."}";
                        $aUpdate    = array(
                                                'attachment_count' => count($aAttachment),
                                                'params'       =>  $sPostCount
                                            );
                        $oAction    = Engine_Api::_()->getDbtable('actions', 'activity');
                        $sWhere = $oAction->getAdapter()->quoteInto('action_id = ?', $action->action_id);
                        $oAction->update($aUpdate, $sWhere);
                        $oAttach    = Engine_Api::_()->getDbtable('attachments', 'activity');


                        $oPhotos        = Engine_Api::_()->getDbtable('photos', 'album');
                        $table = Engine_Api::_()->getDbtable('albums', 'album');
             foreach($aAttachment as $iAttachment) {
                            //Saving the photos
                        $filePath=dirname($_SERVER['SCRIPT_FILENAME']).'/public/share/'.$viewer->getIdentity().'/' . $iAttachment['name'];

                        if(file_exists($filePath)){
                        $album = $table->getSpecialAlbum($viewer, 'wall');

                        $photoTable = Engine_Api::_()->getDbtable('photos', 'album');
                            $photo = $photoTable->createRow();
                            $photo->setFromArray(array(
                                'owner_type' => 'user',
                                'owner_id' => $viewer->getIdentity(),
                                'photo_tags'      => $aUpdatePhoto['photo_tags'],
                                'photo_caption'   => $aUpdatePhoto['photo_caption']
                            ));
                        $photo->save();
                        $photo->setPhoto($filePath, $viewer);
                        $photo->album_id = $album->album_id;
                        $photo->save();
                        if( !$album->photo_id ) {
                              $album->photo_id = $photo->getIdentity();
                              $album->save();
                            }
                        $aAttachmentInsert    = array(
                                                    'action_id'     => $action->action_id,
                                                    'type'      => 'album_photo',
                                                    'id'        => $photo->getIdentity(),
                                                    'mode'      => 1

                                                    );
                        $oAttach->insert($aAttachmentInsert);
                       }
                       if(file_exists($filePath)){
                            $i    = $i+1;
                            $path = dirname($_SERVER['SCRIPT_FILENAME']).'/public/images/property/'.$viewer->getIdentity().'/';
                            if(!is_dir($path)){
                                mkdir($path,0777,true);
                            }
                        $image = $_SERVER['HTTP_HOST'].'/public/share/'.$viewer->getIdentity().'/' . $iAttachment['name'];
                                    $image_link = $image;//Direct link to image
                                    $split_image = pathinfo($image_link);
                                    $ch = curl_init();
                                    curl_setopt($ch, CURLOPT_URL , $image_link);
                                    curl_setopt($ch, CURLOPT_USERAGENT, "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.13 (KHTML, like Gecko) Chrome/0.A.B.C Safari/525.13");
                                    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
                                    $response= curl_exec ($ch);
                                    curl_close($ch);
                                    $image_name = uniqid().".".$split_image['extension'];
                                    $file_name = $path.$image_name;
                                   /* $file = fopen($file_name , 'w') or die("X_x");
                                    fwrite($file, $response);
                                    fclose($file);*/
                                    $imagePath =   dirname($_SERVER['SCRIPT_FILENAME']). '/public/share/'.$viewer->getIdentity().'/' . $iAttachment['name'];
                                    $destination =   $path.$image_name;
                                    copy($imagePath, $destination);

                                    $propertyimageid=   $propertyimageTable->insert(array(
                                                'property_id' => $propertyid,
                                                'type' => 'image',
                                                'image' => 'public/images/property/'.$viewer->getIdentity().'/'.$image_name,
                                            ));
                            }
                            //Deleting the temp. images after save
                            if(is_file($filePath) && file_exists($filePath)) {
                                unlink($filePath);
                            }
                        }
                    $property = $propertyTable->fetchRow($propertyTable->select()->where('id = ?', $propertyid));
                    $property->attachment_count = $i;
                    $property->video_count = $vcount;
                    $property->action_id = $action->action_id;
                    $property->save();
            }
            /*******************mail to admin************************/

             if($viewer -> bg_verified == 0){

                $userTable      = Engine_Api::_()->getDbtable('users', 'user');
                $adminDetails   = $userTable->fetchAll($userTable->select()->where('level_id = ?', '1'));
                $from_email     = Engine_Api::_()->getApi('settings', 'core')->core_mail_from;
                $landlord_email = $viewer->email;
                $landlord_name  = $viewer->displayname;
                $red_url        = $_SERVER['HTTP_HOST']."/admin/user/manage/propertylist";
                foreach($adminDetails as $admin){
                     $admin_email       = $admin['email'];
                     $admin_displayname = $admin['displayname'];
                     $bodyTextContent = '';
                         if (file_exists("emailtemplates/property_add_email_admin.html")) {
                            $htmlExist = true;
                            $file = fopen("emailtemplates/property_add_email_admin.html", "r");
                            while(!feof($file))
                            {
                                $bodyTextContent .= fgets($file);
                            }
                            fclose($file);
                        }
                            if($htmlExist){
                              $landlordname  = '{landlord_name}';
                              $redirect_url  = '{redirect_url}';
                              $property_name = '{property_name}';
                              $display_name  = '{display_name}';
                              $bodyTextTemplate = '';
                              $bodyHtmlTemplate = $bodyTextContent;
                          foreach( $rParams as $var => $val ) {
                              $raw = trim($var, '[]');
                              $var = '[' . $var . ']';
                              if( !$val ) {
                                $val = $var;
                              }
                              // Fix nbsp
                              $val = str_replace('&amp;nbsp;', ' ', $val);
                              $val = str_replace('&nbsp;', ' ', $val);
                              // Replace

                             $bodyTextTemplate = str_replace($var, $val, $bodyTextTemplate);
                             $bodyHtmlTemplate = str_replace($var, $val, $bodyHtmlTemplate);
                            }
                            $bodyTextTemplate = strip_tags($bodyTextTemplate);
                            $bodyHtmlTemplate = str_replace($landlordname, $landlord_name, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($display_name, $admin_displayname, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($redirect_url, $red_url, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($property_name, $aData['property_name'], $bodyHtmlTemplate);
                         }
                    $subject = "Approval request for new property.";
                    $header  = "From: ".'Rentstarz'." <".$from_email.">\r\n";
                    $header .= "MIME-Version: 1.0\r\n";
                    $header .= 'Content-type: text/html; charset=iso-8859-1' ."\"\r\n\r\n";
                    mail($admin_email, $subject, $bodyHtmlTemplate, $header);
                }
            }
                /************************************************/
             $aResult['status'] = true;
        }catch (Exception $e) {//exit($e->getMessage());
                                $aResult['status'] = false;
                            }
      }
      else{
		  $aResult['status'] = false;
	  }
        echo json_encode($aResult);
    }


    public function deletepropertyAction()
    {
    if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
    $this->_helper->viewRenderer->setNoRender(true);
    $this->_helper->layout->disableLayout();
    $aData = $this->_request->getPost();

    if($aData){

    $pid       = $aData['property_id'];
    $action_id = $aData['action_id'];
      try {
         Engine_Db_Table::getDefaultAdapter()->delete('engine4_property_list', array('id = ?'=>$pid) );
         Engine_Db_Table::getDefaultAdapter()->delete('engine4_property_images', array('property_id = ?'=>$pid) );
         Engine_Db_Table::getDefaultAdapter()->delete('engine4_property_granted', array('property_id = ?'=>$pid) );
         Engine_Db_Table::getDefaultAdapter()->delete('engine4_property_request', array('property_id = ?'=>$pid) );
         Engine_Db_Table::getDefaultAdapter()->delete('engine4_activity_actions', array('action_id = ?'=>$action_id) );
         Engine_Db_Table::getDefaultAdapter()->delete('engine4_post_comments', array('action_id = ?'=>$pid,'type'=>'property_feed') );
         Engine_Db_Table::getDefaultAdapter()->delete('engine4_like_user', array('object_id = ?'=>$pid,'type'=>'property') );
      } catch( Exception $e ) {
        throw $e;
      }
      $aResult['status'] = true;
     }
     else
     {
      $aResult['status'] = false;
     }
     echo json_encode($aResult);
    }

    public function user_readsession($file,$data=''){
        if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $viewer_id  = Engine_Api::_()->user()->getViewer()->getIdentity();
        $filepath   = 'public/session_data/'.$viewer_id.'/'.$file;
        if(!is_file($filepath)){
            $this->user_writesession($file,$data);
        } else {
            $fh         = fopen('public/session_data/'.$viewer_id.'/'.$file, 'r');
            $data       = fread($fh, filesize('public/session_data/'.$viewer_id.'/'.$file));
        }
     return $data;

    }

    public function user_writesession($file,$data=''){
    if( !$this->_helper->requireUser()->isValid() ) {
          return;
        } 
    $viewer_id     = Engine_Api::_()->user()->getViewer()->getIdentity();
    $filepath      = 'public/session_data/'.$viewer_id.'/'.$file;
          if(!is_dir('public/session_data')){
            mkdir('public/session_data');
          }
          if(!is_dir('public/session_data/'.$viewer_id))
          {
           mkdir('public/session_data/'.$viewer_id, 0777);
          }
      $fh           = fopen($filepath, 'w') or die("can't open file ".$filepath);
      chmod($filepath,0777);
      fwrite($fh, json_encode($data));

    }

    public function propertylistAction() {

    if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('property_detail');
        $subjectid      =   $this->_getParam('id');
        if($subjectid){
        $viewer     = Engine_Api::_()->user()->getViewer();
        $viewer_id  = Engine_Api::_()->user()->getViewer()->getIdentity();
        $propertyTable =  Engine_Api::_()->getDbtable('propertylist', 'user');
        $propertyimageTable =  Engine_Api::_()->getDbtable('propertyimages', 'user');
        $propertySelect   =   $propertyTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('plist'=>'engine4_property_list',))
                        ->joinLeft(array('user'=>'engine4_users',),'plist.property_owner_id=user.user_id',array('displayname'))
                        ->joinLeft(array('pimages'=>'engine4_property_images'),'plist.id=pimages.property_id',array('image'))
                       ->joinLeft(array('country'=>'engine4_property_countries',),'plist.prty_country_id=country.country_id',array('prty_country'))
                        ->joinLeft(array('state'=>'engine4_property_states',),'plist.prty_state_id=state.state_id',array('prty_state'))
                        ->joinLeft(array('city'=>'engine4_property_city',),'plist.prty_city_id=city.city_id',array('prty_city','latitude','longitude'))
                        ->joinLeft(array('grant'=>'engine4_property_granted',),'grant.property_id=plist.id AND grant.end_date =""',array('granted','status'))
                        ->where('plist.property_owner_id=?' , $subjectid)
                        ->where('(plist.enable = ?', 1)
                        ->orWhere('user.bg_verified  = ?)', 1)
                        ->where('plist.landlord_enable=?' , 1)
                        ->where('pimages.type =?' , 'image')
                        ->group('plist.id')
                        ->order('plist.id DESC');

        $propertyData=$propertyTable->fetchAll($propertySelect);
        $userTable = Engine_Api::_()->getDbtable('users', 'user');
        $this->view->landlordetails = $userTable->fetchRow($userTable->select()->where('user_id = ?', $subjectid));
        $this->view->propertyData = $propertyData;
        $this->view->metaTitle        = 'Properties';
	  }

    }
     public function getlocationAction(){
     if( !$this->_helper->requireUser()->isValid() ) {
          return;
        } 
      $this->_helper->layout->disableLayout();
      $this->_helper->viewRenderer->setNoRender(true);
         //header("Content-Type: application/json");
       $aResult =   array();
       $aData = $this->_request->getPost();
       if($aData){
       $countryId   =   $aData['countryId'];
       $state_id    =   $aData['state_id'];
       $city_id     =   $aData['city_id'];
       $country_table   =  Engine_Api::_()->getDbtable('countries', 'user');

       $locationSelect   =   $country_table->select()
                        ->setIntegrityCheck(false)
                        ->from(array('city'=>'engine4_city_list',))
                        ->joinLeft(array('state'=>'engine4_state_list',),'city.state_id=state.state_id',array('state','state_id'))
                        ->joinLeft(array('clist'=>'engine4_country_list',),'city.country_id=clist.id',array('country','id'))
                        ->where('city.city_id   =?' , $city_id);

       $locationData=$country_table->fetchRow($locationSelect);
       $aResult['id'] = $locationData->id;
       $aResult['country'] = $locationData->country;
       $aResult['state_id'] = $locationData->state_id;
       $aResult['state'] = $locationData->state;
       $aResult['state'] = $locationData->state;
       $aResult['city_id'] = $locationData->city_id;
       $aResult['city'] = $locationData->city;
    }
    else{
		$aResult['status'] = false;
	}

    echo json_encode($aResult);
    }

    public function propertydetailAction($pid) {

    if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('property_detail');
        $viewer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
        $property_id        =   $this->_getParam('id');
        $admin              =   $this->_getParam('admin');
        if($property_id){
        if($admin == 1){
            $this->view->is_from_admin = 1;
        }
        else{
            $this->view->is_from_admin = 0;
        }
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $propertyTable        =  Engine_Api::_()->getDbtable('propertylist', 'user');
        $propertyimageTable   =  Engine_Api::_()->getDbtable('propertyimages', 'user');
        $propertyRequestTable =  Engine_Api::_()->getDbtable('propertyrequest', 'user');
        $propertySelect       =   $propertyTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('plist'=>'engine4_property_list',))
                        ->joinLeft(array('user'=>'engine4_users'),'plist.property_owner_id=user.user_id',array('bg_verified'))
                        ->joinLeft(array('country'=>'engine4_property_countries',),'plist.prty_country_id=country.country_id',array('prty_country'))
                        ->joinLeft(array('state'=>'engine4_property_states',),'plist.prty_state_id=state.state_id',array('prty_state'))
                        ->joinLeft(array('city'=>'engine4_property_city',),'plist.prty_city_id=city.city_id',array('prty_city'))
                        ->joinLeft(array('pimages'=>'engine4_property_images'),'plist.id=pimages.property_id',array('image'))
                        ->joinLeft(array('smartmovePrty'=>'engine4_smartmoveapi_property'),'plist.id=smartmovePrty.Pid',array('UnitNumber'))
                        ->where('plist.id=?' , $property_id)
                        ->where('pimages.type=?' , 'image');

        $propertyData    =   $propertyTable->fetchRow($propertySelect);
        if(empty($propertyData)){
                return $this->_forward('notfound');
        }
        if($viewer->level_id  != 1 ){
            if($propertyData -> property_owner_id != $viewer_id){
                if($propertyData -> landlord_enable == 0 || $propertyData -> enable == 0){
                    return $this->_forward('notfound');
                }
            }
        }
        if($viewer_id){
            $propertyReq_select = $propertyRequestTable->select()
                        ->where('property_id = ?', $property_id)
                        ->where('tenant_id = ?', $viewer_id);
            $propertyRequest = $propertyRequestTable->fetchRow($propertyReq_select);
            if(($propertyData -> enable == 1 || $propertyData -> bg_verified == 1) && ($propertyData -> landlord_enable == 1)){
                $this->view->is_property_approved = 1;
            }
            if(!empty($propertyRequest)){
                if(($propertyRequest->landlord_approve==1 && $propertyRequest->admin_approve ==1) ||($propertyRequest->landlord_approve==1 && $viewer->bg_verified ==1)){
                    $this->view->is_request_approved = 1;
                }
                elseif($propertyRequest->landlord_approve==2){
                    $this->view->is_request_approved = 2;
                }
                else{
                    $this->view->is_request_approved = 0;
                }
                 $this->view->is_Requested =1;
            }
            else{
                $this->view->is_Requested =0;
            }
            // entry for property view log
            $propertyViewLogTable   =  Engine_Api::_()->getDbtable('propertyviewlog', 'user');
            $propertyViewLog_select = $propertyViewLogTable->select()
                        ->where('property_id = ?', $property_id)
                        ->where('user_id = ?', $viewer_id);
            $propertyViewLogData = $propertyRequestTable->fetchRow($propertyViewLog_select);
            if(count($propertyViewLogData)==0){
                $propertyViewLogId=   $propertyViewLogTable->insert(array(
                            'property_id' => $property_id,
                            'user_id'     => $viewer_id,
                            'updated_at'  => date('Y-m-d'),
                        ));
                $property_select = $propertyTable->select()
                            ->where('id = ?', $property_id);
                $prtyData        = $propertyTable->fetchRow($property_select);
                $prtyData->view_count =  $prtyData->view_count + 1;
                $prtyData->save();
            }
        }
        $userTable    = Engine_Api::_()->getDbtable('users', 'user');
        $userselect   =   $userTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('user'=>'engine4_users',))
                        ->joinLeft(array('search_field'=>'engine4_user_fields_search'),'search_field.item_id=user.user_id',null)
                        ->joinLeft(array('country'=>'engine4_country_list',),'country.id=search_field.field_33',array('country'))
                        ->joinLeft(array('state'=>'engine4_state_list',),'state.state_id=search_field.field_30',array('state'))
                        ->joinLeft(array('city'=>'engine4_city_list',),'city.city_id=search_field.field_31',array('city'))
                        ->where('user.search=?' , 1)
                        ->where('user.user_id =?' , $propertyData -> property_owner_id)
                        ->where('search_field.profile_type =?' , '4');

        $this->view->landlordUser = $userTable->fetchRow($userselect); //print_r($this->view->landlordUser); exit;
        $property_lists = $propertyTable->select()
                         ->setIntegrityCheck(false)
                        ->from(array('plist'=>'engine4_property_list',))
                        ->joinLeft(array('user'=>'engine4_users',),'plist.property_owner_id=user.user_id',array('displayname'))
                        ->where('plist.property_owner_id=?' , $propertyData -> property_owner_id)
                        ->where('(plist.enable = ?', 1)
                        ->orWhere('user.bg_verified  = ?)', 1) ;

        $this->view->propertycount = count($property_lists);
        $propertyImageData         = $propertyimageTable->fetchAll($propertyimageTable->select()->where('property_id = ?', $property_id)->where('type = "image"'));

        $propertyVideoSelect   =   $propertyimageTable->select()
                ->setIntegrityCheck(false)
                ->from(array('pimages'=>'engine4_property_images'))
                ->joinLeft(array('file'=>'engine4_storage_files'),'pimages.storage_file_id=file.file_id',array('file_id','storage_path'))
                ->where('pimages.type=?' , 'video')
                ->where('pimages.storage_file_id !=?' , 0)
                ->where('pimages.property_id=?' , $property_id);

        $propertyVideoData             = $propertyimageTable->fetchAll($propertyVideoSelect);
        $this->view->propertyData      = $propertyData; // echo '<pre>'; print_r($propertyData); exit;
        $this->view->propertyImageData = $propertyImageData;
        $this->view->propertyVideoData = $propertyVideoData;
        // check property is granted or not
        $propertyGrantedTable =  Engine_Api::_()->getDbtable('propertygranted', 'user');
        $propertyGranted_select = $propertyGrantedTable->select()
                        ->where('property_id = ?', $property_id)
                        ->where('status = ?', 1);
        $oData = $propertyGrantedTable->fetchRow($propertyGranted_select);
        if(count($oData)>0){
            $this->view->is_granted = 1;
            $property_granted_tenent_id = $oData->tenant_id;
            $userTable               = Engine_Api::_()->getDbtable('users', 'user');
            $property_granted_tenent = $userTable->fetchRow($userTable->select()->where('user_id = ?', $property_granted_tenent_id));
            $this->view->property_granted_tenent =$property_granted_tenent;
        }else{
            $this->view->is_granted = 0;
        }
        $this->view->metaTitle        = $propertyData->property_name;
        $actionTable                  =  Engine_Api::_()->getDbtable('actions', 'activity');
        $this->view->action           =  $actionTable->fetchRow($actionTable->select()->where('action_id = ?', $propertyData->action_id));

        $postcommentTable =  Engine_Api::_()->getDbtable('Postcomments', 'user');
        $commentDataSelect             = $postcommentTable->select()
                        ->where('actionId = ?', $propertyData->id);

        $commentData = $postcommentTable->fetchAll($commentDataSelect);
        $this->view->commentcount= count($commentData);
        $smartmoveapiRenters_table           =  Engine_Api::_()->getDbtable('Smartmoveapirenters', 'user');
        $this->view->smartmoveapiRentersData = $smartmoveapiRenters = $smartmoveapiRenters_table->fetchRow($smartmoveapiRenters_table->select()->where('tenant_id = ?', $viewer_id));
        if(!empty($smartmoveapiRenters)){
            $this->view->isSmartmoveRenter = 1;
        }
        else{
            $this->view->isSmartmoveRenter = 0;
        }
        $rentalApplicationsTable             =  Engine_Api::_()->getDbtable('rentalapplications', 'user');
        $rentalApplicationsData = $rentalApplicationsTable->fetchRow($rentalApplicationsTable->select()->where('tenant_id = ?', $viewer_id));
        if(!empty($rentalApplicationsData)){  $this->view->isOneTimeApplicationCreatedUser = 1; }
        else{ $this->view->isOneTimeApplicationCreatedUser = 0; }
	    $postcommentTable       =  Engine_Api::_()->getDbtable('Postcomments', 'user');
	    $this->view->postcommentData = $postcommentData = $postcommentTable->fetchAll($postcommentTable->select()
	                               ->where('actionId = ?', $propertyData->id)
	                               ->order('commentId DESC')
								   ->limit(2)
	                               );


	 
	 
	 
	 }
	 else{
		  return $this->_forward('notfound');
	 }
	 
     }



    public function propertyrequestslistAction() {

        if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $viewer        = Engine_Api::_()->user()->getViewer();
        $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
        if( !empty($fieldsByAlias['profile_type']) ){
              $optionId        = $fieldsByAlias['profile_type']->getValue($viewer);
              $profile_type_id = $optionId->value;
        }
        if($profile_type_id != 4){ //if not landlord
            return $this->_forward('notfound');
        }
        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('common_layout');
        $viewer_id            =  Engine_Api::_()->user()->getViewer()->getIdentity();
        $propertyRequestTable =  Engine_Api::_()->getDbtable('propertyrequest', 'user');

        $propertyReq_select = $propertyRequestTable->select()
                              ->setIntegrityCheck(false)
                               ->from(array('prequest'=>'engine4_property_request',))
                               ->joinLeft(array('plist'=>'engine4_property_list',),'plist.id=prequest.property_id',array('property_name','rental_type','granted'))
                               ->joinLeft(array('user'=>'engine4_users'),'plist.property_owner_id=user.user_id',array('bg_verified'))
                               ->joinLeft(array('fields'=>'engine4_user_fields_values',),'prequest.tenant_id=fields.item_id',array('value'))
                               ->where('prequest.landlord_id = ?', $viewer_id)
                               ->where('plist.landlord_enable    = ?', 1)
                               ->where('(plist.enable = ?', 1)
                               ->orWhere('user.bg_verified   = ?)', 1)
                               ->where('plist.granted    = ?', 0)
                               ->where('fields.field_id      = ?', 13)
                               ->order('prequest.id DESC');

        $propertyRequest    =  $propertyRequestTable->fetchAll($propertyReq_select);
        $coverletter_table  =  Engine_Api::_()->getDbtable('coverletter', 'user');
        $userTable          =  Engine_Api::_()->getDbtable('users', 'user');
        foreach($propertyRequest as $data){
            $tenantData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $data['tenant_id']));
            $req_lists[$data['property_id']]['property_name'] = $data['property_name'];
            $req_lists[$data['property_id']]['property_id']   = $data['property_id'];
            $req_lists[$data['property_id']][] =array('id'=>$data['id'],'tenantuser_id' =>$data['tenant_id'],'tenantdisplay_name' => $tenantData->displayname,
                'property_id'=>$data['property_id'],'property_name'=>$data['property_name'],
                'rental_type' =>$data['rental_type'],'created_at'=>$data['created_at'],'landlord_approve'=>$data['landlord_approve'],
                'bio'=>$data['value']);
        }
        $this->view->propertyRequestList = $req_lists;
        $this->view->metaTitle           = 'Property Request List';
        $table                           = Engine_Api::_()->getItemTable('user');
        $onlineTable                     = Engine_Api::_()->getDbtable('online', 'user');
        $tableName       = $table->info('name');
        $onlineTableName = $onlineTable->info('name');
        $viewer          = Engine_Api::_()->user()->getViewer();
        $viewerId        = $viewer->getIdentity();
        $online_select = $table->select()
          ->from($tableName)
          ->joinRight($onlineTableName, $onlineTableName.'.user_id = '.$tableName.'.user_id', null)
          ->where($onlineTableName.'.user_id > ?', 0)
          ->where($onlineTableName.'.active > ?', new Zend_Db_Expr('DATE_SUB(NOW(),INTERVAL 20 MINUTE)'))
          ->where($tableName.'.search = ?', 1)
          ->where($tableName.'.enabled = ?', 1)
          ->where($onlineTableName.'.user_id != ?', $viewerId) // to hide logged in user from showing in member online widget
          ->order($onlineTableName.'.active DESC')
          ->group($onlineTableName.'.user_id')
          ;
      $online_users_Data=$table->fetchAll($online_select);
      $this->view->online_users =$online_users_Data;

    }

    public function propertyrequestapproveAction() {
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        $viewer     = Engine_Api::_()->user()->getViewer();
        $viwer_id   = Engine_Api::_()->user()->getViewer()->getIdentity();
        date_default_timezone_set($viewer->timezone);
        $aResult    =  array();
        $aData      = $this->_request->getPost();
        try{
            $propertyRequestTable =  Engine_Api::_()->getDbtable('propertyrequest', 'user');
            $propertyRequestTable->update(array('landlord_approve' =>1,'landlord_approve_date'=>date('Y-m-d H:i:s')),array('property_id = ?' => $aData['property_id'],'tenant_id = ?' => $aData['tenant_id'],));
            $userTable     = Engine_Api::_()->getDbtable('users', 'user');
            $tenantData    = $userTable->fetchRow($userTable->select()->where('user_id = ?', $aData['tenant_id']));
            $tenant_name   = $tenantData->displayname;
            $tenant_email  = $tenantData->email;
            $propertyTable = Engine_Api::_()->getDbtable('propertylist', 'user');
            $propertyData  =  $propertyTable->fetchRow($propertyTable->select()->where('id = ?', $aData['property_id']));
            $rental_type   = $propertyData->rental_type;
            $property_name = $propertyData->property_name;
            $landlord_name = $viewer->displayname;
            $property_url  = $_SERVER['HTTP_HOST']."/property/".$aData['property_id'];
            $red_url       = $_SERVER['HTTP_HOST'];
            $from_email    = Engine_Api::_()->getApi('settings', 'core')->core_mail_from;
            $bodyTextContent = '';
            if (file_exists("emailtemplates/property_request_approved_email.html")) {
                    $htmlExist = true;
                    $file = fopen("emailtemplates/property_request_approved_email.html", "r");
                    while(!feof($file))
                    {
                        $bodyTextContent .= fgets($file);
                    }
                    fclose($file);
            }
            if($htmlExist){
              $landlordname='{landlordname}';
              $tenantname='{tenantname}';
              $rentaltype='{rentaltype}';
              $redirecturl='{property_url}';
              $propertyname='{property_name}';
              $redurl='{red_url}';
              $bodyTextTemplate = '';
              $bodyHtmlTemplate = $bodyTextContent;
              foreach( $rParams as $var => $val ) {
                  $raw = trim($var, '[]');
                  $var = '[' . $var . ']';
                  if( !$val ) {
                    $val = $var;
                  }
                  // Fix nbsp
                  $val = str_replace('&amp;nbsp;', ' ', $val);
                  $val = str_replace('&nbsp;', ' ', $val);
                  // Replace
                  $bodyTextTemplate = str_replace($var, $val, $bodyTextTemplate);
                  $bodyHtmlTemplate = str_replace($var, $val, $bodyHtmlTemplate);
             }
             $bodyTextTemplate = strip_tags($bodyTextTemplate);
             $bodyHtmlTemplate = str_replace($landlordname, $landlord_name, $bodyHtmlTemplate);
             $bodyHtmlTemplate = str_replace($tenantname, $tenant_name, $bodyHtmlTemplate);
             $bodyHtmlTemplate = str_replace($rentaltype, $rental_type, $bodyHtmlTemplate);
             $bodyHtmlTemplate = str_replace($redirecturl, $property_url, $bodyHtmlTemplate);
             $bodyHtmlTemplate = str_replace($propertyname, $property_name, $bodyHtmlTemplate);
             $bodyHtmlTemplate = str_replace($redurl, $red_url, $bodyHtmlTemplate);
            }
            $subject = "Rentstarz property request accepted";
            $header  = "From: ".'Rentstarz'." <".$from_email.">\r\n";
            $header .= "MIME-Version: 1.0\r\n";
            $header .= 'Content-type: text/html; charset=iso-8859-1' ."\"\r\n\r\n";
            mail($tenant_email, $subject, $bodyHtmlTemplate, $header);
                         // send notification
            Engine_Api::_()->getDbtable('notifications', 'activity')
                    ->addNotification($tenantData, $viewer, $tenantData, 'application_accept',array(
                  'label' => $property_name,'pid' => $aData['property_id']));
                  $aResult['status'] = true;

        }catch (Exception $e) {exit($e->getMessage());
                                $aResult['status'] = false;
                            }
        echo json_encode($aResult);

    }

    public function propertyrequestrejectAction() {
		
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        $viewer     =   Engine_Api::_()->user()->getViewer();
        $viwer_id   =   Engine_Api::_()->user()->getViewer()->getIdentity();
        $aResult    =   array();
        $aData      =   $this->_request->getPost();
        try{
            $propertyRequestTable   =  Engine_Api::_()->getDbtable('propertyrequest', 'user');
            $propertyRequestData    =  $propertyRequestTable->fetchRow($propertyRequestTable->select()->where('id = ?', $aData['req_id']));
            $propertyTable          =  Engine_Api::_()->getDbtable('propertylist', 'user');
            $propertyData           =  $propertyTable->fetchRow($propertyTable->select()->where('id = ?', $propertyRequestData->property_id));
            $rental_type            =  $propertyData->rental_type;
            $property_name          =  $propertyData->property_name;
            $userTable              =  Engine_Api::_()->getDbtable('users', 'user');
            $tenantData             =  $userTable->fetchRow($userTable->select()->where('user_id = ?', $propertyRequestData->tenant_id));
            $tenant_name            =  $tenantData->displayname;
            $tenant_email           =  $tenantData->email;
            $landlord_name          =  $viewer->displayname;
            $property_url           =  $_SERVER['HTTP_HOST']."/property/".$propertyRequestData->property_id;
            $red_url                =  $_SERVER['HTTP_HOST'];
            $from_email             =  Engine_Api::_()->getApi('settings', 'core')->core_mail_from;
            $bodyTextContent        = '';

             if (file_exists("emailtemplates/property_request_rejected_email.html")) {
                $htmlExist = true;
                $file = fopen("emailtemplates/property_request_rejected_email.html", "r");
                while(!feof($file))
                {
                    $bodyTextContent .= fgets($file);
                }
                fclose($file);
             }
             if($htmlExist){
              $landlordname='{landlordname}';
              $tenantname='{tenantname}';
              $rentaltype='{rentaltype}';
              $redirecturl='{property_url}';
              $propertyname='{property_name}';
              $bodyTextTemplate = '';
              $bodyHtmlTemplate = $bodyTextContent;
              foreach( $rParams as $var => $val ) {
                  $raw = trim($var, '[]');
                  $var = '[' . $var . ']';
                  if( !$val ) {
                    $val = $var;
                  }
                  // Fix nbsp
                  $val = str_replace('&amp;nbsp;', ' ', $val);
                  $val = str_replace('&nbsp;', ' ', $val);
                  // Replace

                 $bodyTextTemplate = str_replace($var, $val, $bodyTextTemplate);
                 $bodyHtmlTemplate = str_replace($var, $val, $bodyHtmlTemplate);
            }
             $bodyTextTemplate = strip_tags($bodyTextTemplate);
             $bodyHtmlTemplate = str_replace($landlordname, $landlord_name, $bodyHtmlTemplate);
             $bodyHtmlTemplate = str_replace($tenantname, $tenant_name, $bodyHtmlTemplate);
             $bodyHtmlTemplate = str_replace($rentaltype, $rental_type, $bodyHtmlTemplate);
             $bodyHtmlTemplate = str_replace($redirecturl, $property_url, $bodyHtmlTemplate);
             $bodyHtmlTemplate = str_replace($propertyname, $property_name, $bodyHtmlTemplate);
            }
             $subject = "Rentstarz property updates";
             $header  = "From: ".'Rentstarz'." <".$from_email.">\r\n";
             $header .= "MIME-Version: 1.0\r\n";
             $header .= 'Content-type: text/html; charset=iso-8859-1' ."\"\r\n\r\n";
             mail($tenant_email, $subject, $bodyHtmlTemplate, $header);
                          // send notification
            Engine_Api::_()->getDbtable('notifications', 'activity')
                    ->addNotification($tenantData, $viewer, $tenantData, 'application_reject',array(
                  'label' => $property_name,'pid' => $aData['property_id']));
            //0-waiting,1-approved,2-rejected

            $propertyRequestData->landlord_approve  = 2;
            $propertyRequestData->save();

            $aResult['status'] = true;
        }catch (Exception $e) {exit($e->getMessage());
                                $aResult['status'] = false;
                            }
        echo json_encode($aResult);
    }

    public function getdefaultcoverlettersAction(){
		
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        $aResult    =   array();
        $coverletter_table =  Engine_Api::_()->getDbtable('coverletter', 'user');
        $oData             = $coverletter_table->getAdapter()->select()
                        ->from(array('cover'=>'engine4_cover_letter',))
                        ->where('cover.status = ?', 'default')
                        ->query()->fetchAll();
        $i             =  0;
        foreach($oData as $list)
        {
            $aResult[$i]['id']      =   $list['id'];
            $aResult[$i]['title']   =   $list['title'];
            $aResult[$i]['content'] =   $list['content'];
            $i++;
        }
        echo json_encode($aResult);
    }

    public function mypropertiesAction() {

    if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('common_layout');
        $viewer        = Engine_Api::_()->user()->getViewer();
        $viewer_id     = Engine_Api::_()->user()->getViewer()->getIdentity();
        $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
        if( !empty($fieldsByAlias['profile_type']) ){
              $optionId        = $fieldsByAlias['profile_type']->getValue($viewer);
              $profile_type_id = $optionId->value;
        }
        if($profile_type_id != 4){ //if not landlord
            return $this->_forward('notfound');
        }
        $propertyvideos     =  array();
        $subjectid          =  $viewer_id;
        $propertyTable      =  Engine_Api::_()->getDbtable('propertylist', 'user');
        $propertyimageTable =  Engine_Api::_()->getDbtable('propertyimages', 'user');
        if($viewer_id == $subjectid){
              $propertySelect   =   $propertyTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('plist'=>'engine4_property_list',))
                        ->joinLeft(array('pimages'=>'engine4_property_images'),'plist.id=pimages.property_id',array('image'))
                        ->joinLeft(array('country'=>'engine4_property_countries',),'plist.prty_country_id=country.country_id',array('prty_country'))
                        ->joinLeft(array('state'=>'engine4_property_states',),'plist.prty_state_id=state.state_id',array('prty_state'))
                        ->joinLeft(array('city'=>'engine4_property_city',),'plist.prty_city_id=city.city_id',array('prty_city','latitude','longitude'))
                        ->joinLeft(array('grant'=>'engine4_property_granted',),'grant.property_id=plist.id AND grant.end_date =""',array('granted','status'))
                        ->where('plist.property_owner_id=?' , $subjectid)
                        ->where('pimages.type =?' , 'image')
                        ->group('plist.id')
                        ->order('plist.id DESC');
        }
        //echo $propertySelect;exit;
        $propertyData                 = $propertyTable->fetchAll($propertySelect);
        $this->view->propertyData     = $propertyData;
        $this->view->metaTitle        = 'My properties';

    }

    public function searchpropertiesAction()
    {
    if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('property_detail');
        $limit         =  10;
        $offset        =  0;
        $propertyTable =  Engine_Api::_()->getDbtable('propertylist', 'user');
        $table         =  Engine_Api::_()->getItemTable('user');

        if($this->_request->getPost()){

            $aData       = $this->_request->getPost();
            //print_r($aData); exit;
            $keyword     = $aData['keyword'];
            $is_search   = $aData['is_search'];
            $country     = $aData['country'];
            $state       = $aData['state'];
            $city        = $aData['city'];
            $no_of_rooms = $aData['no_of_rooms'];
            $rental_type = $aData['rental_type'];
            $housing_type= $aData['housing_type'];
            $zipcode     = $aData['zipcode'];
            $price       = $aData['price'];
            $allowed_pets = $aData['allowed_pets'];
            $pets_type    = $aData['pets_type'];

            $select   =   $propertyTable->select()
                            ->setIntegrityCheck(false)
                            ->from(array('plist'=>'engine4_property_list',))
                            ->joinLeft(array('pimages'=>'engine4_property_images'),'plist.id=pimages.property_id',array('image'))
                            ->joinLeft(array('user'=>'engine4_users'),'plist.property_owner_id=user.user_id',array('email','displayname'))
                            ->joinLeft(array('country'=>'engine4_property_countries',),'plist.prty_country_id=country.country_id',array('prty_country'))
                            ->joinLeft(array('state'=>'engine4_property_states',),'plist.prty_state_id=state.state_id',array('prty_state'))
                            ->joinLeft(array('city'=>'engine4_property_city',),'plist.prty_city_id=city.city_id',array('prty_city','latitude','longitude'))
                            ->joinLeft(array('grant'=>'engine4_property_granted',),'grant.property_id=plist.id AND grant.end_date =""',array('granted','status'))
                            ->where('(plist.enable = ?', 1)
                            ->orWhere('user.bg_verified  = ?)', 1)
                            ->where('pimages.type=?' , 'image')
                            ->where('plist.landlord_enable=?' , 1)
                            ->group('plist.id')
                            ->order('plist.id DESC');

            $searchDefault = true;
            if( isset($country) && !empty($country) ) {
                 $select->where('plist.prty_country_id =?' , $country);
            }
            if( isset($state) && !empty($state) ) {
                $select->where('plist.prty_state_id =?' , $state);
            }
            if( isset($city) && !empty($city) ) {
                $select->where('plist.prty_city_id =?' , $city);
            }
            if( isset($no_of_rooms) && !empty($no_of_rooms) ) {
                $select->where('plist.no_of_rooms =?' , $no_of_rooms);
            }
            if( isset($housing_type) && !empty($housing_type) ) {
                $select->where('plist.housing_type =?' , $housing_type);
            }
            if( isset($rental_type) && !empty($rental_type) ) {
                $select->where('plist.rental_type =?' , $rental_type);
            }
            if( isset($zipcode) && !empty($zipcode) ) {
                $select->where('plist.zipcode =?' , $zipcode);
            }
            if( isset($keyword) && !empty($keyword) ) {
              $select->where('plist.property_name LIKE ?' ,  "%{$keyword}%");
            }

            if( isset($price) && !empty($price) ) {
                    if($price == "500 - 1,000")
                    {
                      $select->where('plist.price >=?' , 500);
                      $select->where('plist.price <=?' , 1000);
                   }
                   elseif($price=="1,001 - 1,800")
                   {
                      $select->where('plist.price >=?' , 1001);
                      $select->where('plist.price <=?' , 1800);
                   }
                   elseif($price=="1,801- 2,000")
                   {
                      $select->where('plist.price >=?' , 1801);
                      $select->where('plist.price <=?' , 2000);
                   }
                   elseif($price=="2,001- 2,800")
                   {
                      $select->where('plist.price >=?' , 2001);
                      $select->where('plist.price <=?' , 2800);
                   }
                   elseif($price=="2,801- 3,000")
                   {
                      $select->where('plist.price >=?' , 2801);
                      $select->where('plist.price <=?' , 3000);
                   }
                   elseif($price=="3,001- 3,800")
                   {
                      $select->where('plist.price >=?' , 3001);
                      $select->where('plist.price <=?' , 3800);
                   }
                   elseif($price=="3,801- 4,000")
                   {
                      $select->where('plist.price >=?' , 3801);
                      $select->where('plist.price <=?' , 4000);
                   }
                   elseif($price=="4,001- 4,800")
                   {
                      $select->where('plist.price >=?' , 4001);
                      $select->where('plist.price <=?' , 4800);
                   }
                   elseif($price=="4,801- 5,000")
                   {
                      $select->where('plist.price >=?' , 4801);
                      $select->where('plist.price <=?' , 5000);
                   }
                   elseif($price =="5,000")
                   {
                        $select->where('plist.price >?' , 5000);
                   }
                   else{ $select->where('plist.price >?' , 5000); }
            }
            if( isset($allowed_pets) && !empty($allowed_pets) ) {
                $select->where('plist.has_pets =?' , $allowed_pets);
            }
            if( isset($pets_type) && !empty($pets_type) ) {
                $select->where('plist.pets_type =?' , $pets_type);
            }
            $totalpaginator = Zend_Paginator::factory($select);
            $this->view->totalproperties = $totalpaginator->getTotalItemCount();
            $select->limit($limit,$offset);
            $propertyData=$propertyTable->fetchAll($select);
            $this->view->propertyData = $propertyData;
            $this->view->is_search = 1;
            $this->view->country = $aData['country'];
            $this->view->state = $aData['state'];
            $this->view->city = $aData['city'];
            $this->view->no_of_rooms = $aData['no_of_rooms'];
            $this->view->rental_type = $aData['rental_type'];
            $this->view->housing_type = $aData['housing_type'];
            $this->view->price = $aData['price'];
            $this->view->zipcode = $aData['zipcode'];
            $this->view->allowed_pets = $aData['allowed_pets'];
            $this->view->pets_type = $aData['pets_type'];
            $this->view->keyword = $aData['keyword'];
        }
        else{
        $properties= $propertyTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('plist'=>'engine4_property_list',array()))
                        ->joinLeft(array('user'=>'engine4_users'),'plist.property_owner_id=user.user_id',array('email','displayname'))
                        ->where('(plist.enable = ?', 1)
                        ->orWhere('user.bg_verified  = ?)', 1)
                        ->where('plist.landlord_enable=?' , 1)
                        ->query()->fetchAll();
        $this->view->totalproperties = count($properties);
        $propertySelect   = $propertyTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('plist'=>'engine4_property_list',))
                        ->joinLeft(array('pimages'=>'engine4_property_images'),'plist.id=pimages.property_id',array('image'))
                        ->joinLeft(array('user'=>'engine4_users'),'plist.property_owner_id=user.user_id',array('email','displayname'))
                        ->joinLeft(array('country'=>'engine4_property_countries',),'plist.prty_country_id=country.country_id',array('prty_country'))
                        ->joinLeft(array('state'=>'engine4_property_states',),'plist.prty_state_id=state.state_id',array('prty_state'))
                        ->joinLeft(array('city'=>'engine4_property_city',),'plist.prty_city_id=city.city_id',array('prty_city','latitude','longitude'))
                        ->joinLeft(array('grant'=>'engine4_property_granted',),'grant.property_id=plist.id AND grant.end_date =""',array('granted','status'))
                         ->where('(plist.enable = ?', 1)
                        ->orWhere('user.bg_verified  = ?)', 1)
                        ->where('pimages.type=?' , 'image')
                        ->where('plist.landlord_enable=?' , 1)
                        ->group('plist.id')
                        ->order('plist.created_at DESC')->limit($limit,$offset);

        $propertyData=$propertyTable->fetchAll($propertySelect);
        $this->view->propertyData = $propertyData;
        $this->view->is_search    = 0;
    }
    $table           = Engine_Api::_()->getItemTable('user');
    $onlineTable     = Engine_Api::_()->getDbtable('online', 'user');
    $tableName       = $table->info('name');
    $onlineTableName = $onlineTable->info('name');
    $viewer          = Engine_Api::_()->user()->getViewer();
    $viewerId        = $viewer->getIdentity();

    $select = $table->select()
      ->from($tableName)
      ->joinRight($onlineTableName, $onlineTableName.'.user_id = '.$tableName.'.user_id', null)
      ->where($onlineTableName.'.user_id > ?', 0)
      ->where($onlineTableName.'.active > ?', new Zend_Db_Expr('DATE_SUB(NOW(),INTERVAL 20 MINUTE)'))
      ->where($tableName.'.search = ?', 1)
      ->where($tableName.'.enabled = ?', 1)
      ->where($onlineTableName.'.user_id != ?', $viewerId) // to hide logged in user from showing in member online widget
      ->order($onlineTableName.'.active DESC')
      ->group($onlineTableName.'.user_id')
      ;
    $online_users_Data            =  $table->fetchAll($select);
    $this->view->online_users     =  $online_users_Data;
    $this->view->metaTitle        =  'Properties';

   }

    public function searchpropertiesajaxAction() {
		
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        $limit    = $this->_getParam('limit');
        $offset   = $this->_getParam('offset');
        $oData    = $this->_request->getPost();
        $user_id  = Engine_Api::_()->user()->getViewer()->getIdentity();
        $connectionApi  =   Engine_Api::_()->getApi('connections', 'user');
        $html           =   $connectionApi->searchpropertyajaxResults($limit,$offset,$oData);
        return $html;
    }

    public function enablepropertyAction() {
		
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);

        $viewer     =   Engine_Api::_()->user()->getViewer();
        $viwer_id   =   Engine_Api::_()->user()->getViewer()->getIdentity();
        $aResult    =   array();
        $aData      =   $this->_request->getPost();
        try{
        $propertyTable =  Engine_Api::_()->getDbtable('propertylist', 'user');
        $propertyTable->update(array('landlord_enable' =>1),array('id = ?' => $aData['property_id'],));
        $aResult['status'] = true;
        }catch (Exception $e) {exit($e->getMessage());
                                $aResult['status'] = false;
                            }
        echo json_encode($aResult);

    }

    public function disablepropertyAction() {
		
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);

        $viewer     = Engine_Api::_()->user()->getViewer();
        $viwer_id   = Engine_Api::_()->user()->getViewer()->getIdentity();
        $aResult    = array();
        $aData      = $this->_request->getPost();
        try{
        $propertyTable =  Engine_Api::_()->getDbtable('propertylist', 'user');
        $propertyTable->update(array('landlord_enable' =>0),array('id = ?' => $aData['property_id'],));
        Engine_Db_Table::getDefaultAdapter()->delete('engine4_property_request', array('property_id = ?'=>$aData['property_id']) ); //cancel all request to this property
        $aResult['status'] = true;
        }catch (Exception $e) {exit($e->getMessage());
                                $aResult['status'] = false;
                            }
        echo json_encode($aResult);
    }

    public function getdefaultcoverletterbyidAction(){
		
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        $id         =   $this->_getParam('id');
        if($id){
        $aResult    =   array();
        $coverletter_table =  Engine_Api::_()->getDbtable('coverletter', 'user');
        $oData             =  $coverletter_table->fetchRow($coverletter_table->select()->where('id = ?', $id));
            $aResult['id']      =      $oData->id;
            $aResult['title']   =   $oData->title;
            $aResult['content'] =   $oData->content;
		}
		else{
			$aResult['status']  = false;
		}
        echo json_encode($aResult);
    }

    public function editpropertyAction() {

    if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('property_detail');
        $property_id          =  $this->_getParam('id');
        $viewerId    = Engine_Api::_()->user()->getViewer()->getIdentity();
        if($property_id){
        $propertyTable        =  Engine_Api::_()->getDbtable('propertylist', 'user');
        $propertyimageTable   =  Engine_Api::_()->getDbtable('propertyimages', 'user');
        $propertyRequestTable =  Engine_Api::_()->getDbtable('propertyrequest', 'user');
        
        $property               =  $propertyTable->fetchRow($propertyTable->select()->where('id = ?', $property_id));
        if(empty($property)){return $this->_forward('notfound');}
        $propertyOwnerId        =  $property->property_owner_id;
        $userTable              =  Engine_Api::_()->getDbtable('users', 'user');

        $UserData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $viewerId));

        
        if(($property->property_owner_id == $viewerId) || ($UserData->level_id == 1 )){ // edit previlege only for both property owner and admin
			

        $propertySelect   =   $propertyTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('plist'=>'engine4_property_list',))
                        ->joinLeft(array('country'=>'engine4_property_countries',),'plist.prty_country_id=country.country_id',array('prty_country'))
                        ->joinLeft(array('state'=>'engine4_property_states',),'plist.prty_state_id=state.state_id',array('prty_state'))
                        ->joinLeft(array('city'=>'engine4_property_city',),'plist.prty_city_id=city.city_id',array('prty_city','zipcode','latitude','longitude'))
                        ->joinLeft(array('pimages'=>'engine4_property_images'),'plist.id=pimages.property_id',array('image'))
                        ->where('plist.id=?' , $property_id);

        $this->view->propertyData = $propertyTable->fetchRow($propertySelect);
        $propertyImageData        = $propertyimageTable->fetchAll($propertyimageTable->select()->where('property_id = ?', $property_id)->where('type="image"'));
        $this->view->propertyImageData = $propertyImageData;
        $propertyVideoSelect   =   $propertyimageTable->select()
                ->setIntegrityCheck(false)
                ->from(array('pimages'=>'engine4_property_images'))
                ->joinLeft(array('file'=>'engine4_storage_files'),'pimages.storage_file_id=file.file_id',array('file_id','storage_path','parent_id'))
                ->where('pimages.type=?' , 'video')
                ->where('pimages.storage_file_id !=?' , 0)
                ->where('pimages.property_id=?' , $property_id);
        $propertyVideoData             = $propertyimageTable->fetchAll($propertyVideoSelect);
        $this->view->propertyVideoData = $propertyVideoData;
        $videoidArray                  =   array();
        foreach($this->view->propertyVideoData as $videodata)
        {
            array_push($videoidArray,$videodata['parent_id']);
        }
        $_SESSION['video_ids']  =   $videoidArray;
        if(count($videoidArray)>0){
            $_SESSION['edit']   = 1;
        }
        $smartmoveapiProperty_table           = Engine_Api::_()->getDbtable('Smartmoveapiproperty', 'user');
        $this->view->smartmoveapiPropertyData = $smartmoveapiPropertyData  = $smartmoveapiProperty_table->fetchRow($smartmoveapiProperty_table->select()->where('Pid     = ?', $property_id));
        $landlordData                         = $smartmoveapiPropertyData->landlordData;
        $landlordData                         = json_decode($landlordData); //print_r($landlordaData); exit;
        $landlordData                         = json_decode(json_encode($landlordData),true);
        $this->view->landlordData             = $landlordData;
        $SmartmoveApiManageTable              = Engine_Api::_()->getDbtable('smartmoveapimanage', 'user');
        $select                               = $SmartmoveApiManageTable->fetchRow($SmartmoveApiManageTable->select());
        $this->view->smartmoveApiEnable = $select-> enable;
        Engine_Api::_()->getApi('core', 'activity')->initGlobalVars();
        $this->view->shareupload   = $shareupload=Engine_Api::_()->getApi('core', 'activity')->getGlobalVars('shareupload');
        $this->view->feeduploads   = $feeduploads=Engine_Api::_()->getApi('core', 'activity')->getGlobalVars('feeduploads');
        $this->view->metaTitle     = 'Property Edit Form';
	}
	else{
		return $this->_forward('notfound');
	}
    }
	
	else{
		 return $this->_forward('notfound');
	}

    }

     public function saveedittedpropertyAction() {
		 
		 if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        $aData      = $this->_request->getPost();
        if($aData){
        $fileids    = json_decode(stripslashes($aData['file_id']));
        $uptypes    = json_decode(stripslashes($aData['upload_type']));
        $fileids    = $aData['file_id'];
        $fileids    = explode(",",$fileids);
        $user_id    = Engine_Api::_()->user()->getViewer()->getIdentity();
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $aResult=array();
        $shareupload   = $this->_getParam('shareuploads');
        $feeduploads   = $this->_getParam('feeduploads');
        $aAttachment   = array();
        $feedupload_session  =   json_decode($this->user_readsession($feeduploads), true);
        $shareupload_session =   json_decode($this->user_readsession($shareupload), true);
        if(sizeof($feedupload_session) > 0) {
            $aAttachment    =  $feedupload_session;
           // unset($_SESSION['feeduploads']);
            foreach( $feedupload_session as $iImage) {
                $path      =  dirname($_SERVER['SCRIPT_FILENAME']).'/public/feed/';
                $filename  =  $iImage['name'];
                if(file_exists($path.$filename)){unlink($path.$filename);unlink($path.'small-'.$filename);}
            }
            $this->user_writesession($feeduploads,array());
            unset($_SESSION[$feeduploads]);
        }
        $propertyTable          =  Engine_Api::_()->getDbtable('propertylist', 'user');
        $propertyimageTable     =  Engine_Api::_()->getDbtable('propertyimages', 'user');
        $propertycountrtyTable  =  Engine_Api::_()->getDbtable('propertycountry', 'user');
        $propertystateTable     =  Engine_Api::_()->getDbtable('propertystate', 'user');
        $propertycityable       =  Engine_Api::_()->getDbtable('propertycity', 'user');
        $property               =  $propertyTable->fetchRow($propertyTable->select()->where('id = ?', $aData['property_id']));
        $vcount                 =  count($_SESSION['video_ids']);
        try{
            $propertycountryData = $propertycountrtyTable->fetchRow($propertycountrtyTable->select()->where('prty_country = ?', $aData['prty_country']));
            if(count($propertycountryData) == 0){
                    $propertycountryid =   $propertycountrtyTable->insert(array(
                    'prty_country'  => $aData['prty_country']
                    ));
            }
            else{
                  $propertycountryid =  $propertycountryData->country_id;
            }
            $propertystateDataSelect = $propertystateTable->select()
                    ->where('country_id = ?', $propertycountryid)
                    ->where('prty_state = ?', $aData['prty_state']);
            $propertystateData = $propertystateTable->fetchRow($propertystateDataSelect);
            if(count($propertystateData) == 0){
                 $propertystateid =   $propertystateTable->insert(array(
                    'country_id'  => $propertycountryid,
                    'prty_state'  => $aData['prty_state']
                    ));
             }
             else{

                    $propertystateid =  $propertystateData->state_id;
             }
             $propertycityDataSelect = $propertycityable->select()
                    ->where('country_id = ?', $propertycountryid)
                    ->where('state_id = ?',   $propertystateid)
                    ->where('prty_city = ?',  $aData['prty_city']);

             $propertycityData = $propertycityable->fetchRow($propertycityDataSelect);
             if(count($propertycityData) == 0){
                 $propertycityid =   $propertycityable->insert(array(
                    'country_id'  => $propertycountryid,
                    'state_id'    => $propertystateid,
                    'prty_city'   => $aData['prty_city'],
                    'zipcode'     => $aData['prty_zipcode'],
                    'latitude'    => $aData['prty_latitude'],
                    'longitude'   => $aData['prty_longitude'],
                    ));
              }
              else{
                    $propertycityid =  $propertycityData->city_id;
              }
                $property->property_owner_id     = $aData['property_owner_id'];
                $property->property_name         = $aData['property_name'];
                $property->prty_country_id       = $propertycountryid;
                $property->prty_state_id         = $propertystateid;
                $property->prty_city_id          = $propertycityid;
                $property->prty_county           = $aData['prty_county'];
                $property->prty_neighborhood     = $aData['prty_neighborhood'];
                $property->zip                   = $aData['prty_zipcode'];
                $property->rental_type           = $aData['rental_type'];
                $property->description           = $aData['description'];
                $property->price                 = $aData['price'];
                $property->no_of_rooms           = $aData['number_of_rooms'];
                $property->housing_type          = $aData['housing_type'];
                $property->has_pets              = $aData['allowed_pets'];
                $property->pets_type             = $aData['pets_type'];
               // $property->vouchers              = $aData['accept_vouchers'];
                $property->wheelchair_accessible = $aData['wheel_chair_accessible'];
                $property->months_of_deposits    = $aData['months_of_deposits'];
                $property->property_manager      = $aData['have_property_manager'];
                $property->provide_parking       = $aData['parking'];
                $property->video_count           = $vcount;
                $property->landlord_enable       = 1;
                $property->created_at            =date('Y-m-d H:i:s');
                $property->save();
            if(!empty($fileids))
            {
                if(!empty($_SESSION['video_ids'])){
                    for($v = 0; $v < count($fileids); $v++)
                    {
                        $propertyimageid=   $propertyimageTable->insert(array(

                            'property_id' => $aData['property_id'],
                            'type' => 'video',
                            'storage_file_id' => $fileids[$v],
                        ));
                    }
                }
            unset($_SESSION['video_ids']);
            }
            if(isset($_SESSION['edit'])){
                    unset($_SESSION['edit']);
            }
            $i  =  0;
            if(count($aAttachment) > 0 ) {
            foreach($aAttachment as $iAttachment) {
                //Saving the photos
                $filePath=dirname($_SERVER['SCRIPT_FILENAME']).'/public/share/'.$viewer->getIdentity().'/' . $iAttachment['name'];
                if(file_exists($filePath)) {
                $i++;
                $path=dirname($_SERVER['SCRIPT_FILENAME']).'/public/images/property/'.$viewer->getIdentity().'/';
                if(!is_dir($path)){
                    mkdir($path,0777,true);
                }
                $image = $_SERVER['HTTP_HOST'].'/public/share/'.$viewer->getIdentity().'/' . $iAttachment['name'];
                        $image_link = $image;//Direct link to image
                        $split_image = pathinfo($image_link);
                        $ch = curl_init();
                        curl_setopt($ch, CURLOPT_URL , $image_link);
                        curl_setopt($ch, CURLOPT_USERAGENT, "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.13 (KHTML, like Gecko) Chrome/0.A.B.C Safari/525.13");
                        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
                        $response= curl_exec ($ch);
                        curl_close($ch);
                        $image_name = uniqid().".".$split_image['extension'];
                        $file_name = $path.$image_name;
                        $file = fopen($file_name , 'w') or die("X_x");
                        fwrite($file, $response);
                        fclose($file);
                $propertyimageid=   $propertyimageTable->insert(array(
                        'property_id' => $aData['property_id'],
                        'type' => 'image',
                        'image' => 'public/images/property/'.$viewer->getIdentity().'/'.$image_name,
                    ));
                }
              }
             $property->attachment_count=$i + $property->attachment_count;
             $property->save();
            }

                /************************************************/

            if($aData['removed_images'] != ''){

            $arr                        =  explode(",",$aData['removed_images']);
            $count_of_removed_images    = count($arr)-1;
            $property->attachment_count = $property->attachment_count-$count_of_removed_images;
            $property->save();
                for($i=0;$i<count($arr);$i++){
                     Engine_Db_Table::getDefaultAdapter()->delete('engine4_property_images', array('id = ?'=>$arr[$i]) );
                }
            }
            if($aData['removed_videos'] != ''){

               $videoarr = explode(",",$aData['removed_videos']);
               for($i=0;$i<count($videoarr);$i++){
                    $videoid    =   $videoarr[$i];
                    $video      = Engine_Api::_()->getItem('video', $videoid);
                    $db         = $video->getTable()->getAdapter();
                    $db->beginTransaction();
                    try
                    {
                      Engine_Api::_()->getApi('core', 'video')->deleteVideo($video);
                      $db->commit();
                    }
                    catch( Exception $e )
                    {
                      $db->rollBack();
                      throw $e;
                    }
                    $key = array_search($videoid, $_SESSION['video_ids']);
                    if(isset($_SESSION['video_ids'][$key])){
                            unset($_SESSION['video_ids'][$key]);
                    }
               }
           }

         if($aData['removed_fileids'] != ''){
            $filearr =  explode(",",$aData['removed_fileids']);
            for($i=0;$i<count($filearr);$i++){
                Engine_Db_Table::getDefaultAdapter()->delete('engine4_property_images', array('storage_file_id = ?'=>$filearr[$i]));
            }
         }
         if($aData['removed_videos'] != ''){
            $videoarr = explode(",",$aData['removed_videos']);
            for($i=0;$i<count($videoarr);$i++){
                $videoid    =   $videoarr[$i];
                $video      = Engine_Api::_()->getItem('video', $videoid);
                $db         = $video->getTable()->getAdapter();
                $db->beginTransaction();
                try
                {
                  Engine_Api::_()->getApi('core', 'video')->deleteVideo($video);
                  $db->commit();
                }
                catch( Exception $e )
                {
                  $db->rollBack();
                  throw $e;
                }
                $key = array_search($videoid, $_SESSION['video_ids']);
                if(isset($_SESSION['video_ids'][$key])){
                    unset($_SESSION['video_ids'][$key]);
                }
            }
        }
        if($aData['removed_fileids'] != ''){
            $filearr =  explode(",",$aData['removed_fileids']);
            for($i=0;$i<count($filearr);$i++){
                Engine_Db_Table::getDefaultAdapter()->delete('engine4_property_images', array('storage_file_id = ?'=>$filearr[$i]));
            }
        }
        $aResult['status'] = true;
    }catch (Exception $e) {exit($e->getMessage());
                                $aResult['status'] = false;
                            }
	}
	else{$aResult['status'] = false;
	}
     echo json_encode($aResult);
 }

   public function removepropertyimageAction() {
	   
	   if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        $aResult    =   array();
        $aData      = $this->_request->getPost();
        try{
        $propertyimageTable =  Engine_Api::_()->getDbtable('propertyimages', 'user');
        Engine_Db_Table::getDefaultAdapter()->delete('engine4_property_images', array('id = ?'=>$aData['imageid']) );
        $aResult['status'] = true;
        }catch (Exception $e) {exit($e->getMessage());
                                $aResult['status'] = false;
                            }
        echo json_encode($aResult);
    }

   public function getdirectorycontentsAction(){ // get directory contents for document widget
	   
	   if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        $user_id    = Engine_Api::_()->user()->getViewer()->getIdentity();
        $viewer     = Engine_Api::_()->user()->getViewer();
        $aData      = $this->_request->getPost();
        if($aData){
        
        $dirname                =   $aData['dirname'];
        $current_directory      =   $aData['current_directory'];
        $subject_id             =   $aData['subject_id'];
        $userTable              = Engine_Api::_()->getDbtable('users', 'user');
        $subject                = $userTable->fetchRow($userTable->select()->where('user_id = ?',$subject_id));
        $fieldsByAlias    = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
        if( !empty($fieldsByAlias['profile_type']) )
        {
           $optionId        = $fieldsByAlias['profile_type']->getValue($viewer);
           $profile_type_id = $optionId->value;
        }
        if($profile_type_id  == 4){ //profile type is landlord or not
            $is_landlord = 1;
        }
        else{
            $is_landlord = 0;
        }
        $user_dir =   $subject->getIdentity().'_'.$subject->displayname;
        if($current_directory == ''){
            $dir     = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$user_dir.'/'.$dirname;
            $doc_dir = $user_dir.'/'.$dirname;
            if($dirname == ''){
                 $doc_dir = $user_dir;
            }
        }
        else{
        $dir      = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$user_dir.'/'.$current_directory.'/'.$dirname;
        $doc_dir  = $user_dir.$current_directory.'/'.$dirname;
        }
        $files             =    $this->loaddirectory($dir);
        $this->view->files =    $files;
        $tmpArrayFile      =    array();
        $tmpArrayDir       =    array();
        $resultData        =    array();

       $documentreqTable    = Engine_Api::_()->getDbtable('documentrequests', 'user');
       $dropboxfileTable    = Engine_Api::_()->getDbtable('dropboxfiles', 'user');
       $documentshareTable  = Engine_Api::_()->getDbtable('documentshare', 'user');

    foreach($files['directories'] as $file){
        $doc_path = $doc_dir.'/'.$file['dirname'];
        $docReq_select = $documentreqTable->select()
                        ->where('doc_requested_user_id = ?', $user_id)
                        ->where('doc_path = ?', $doc_path);
        $oData         = $documentreqTable->fetchRow($docReq_select);
        if(count($oData)>0){
            $is_docRequested =1;
            if($oData->doc_owner_approve ==1){
                $is_docReqApproved =1;
            }
            else{
                $is_docReqApproved =0;
            }
        }
        else{
            $is_docRequested    = 0;
            $is_docReqApproved  = 0;
        }
         $tmpArrayDir[] =   array('dirname'=>$file['dirname'],'is_docRequested'=>$is_docRequested,'is_docReqApproved'=> $is_docReqApproved);
       }
       foreach($files['files'] as $file){
        $doc_path        = $doc_dir.'/'.$file['filename'];
        $dropboxfileData = $dropboxfileTable->fetchRow($dropboxfileTable->select()->where('file_path = ?', $doc_path));
        $docShare_select = $documentshareTable->select()   // shared or not
                    ->where('reciever_id = ?', $user_id)
                    ->where('share_file_id = ?', $dropboxfileData->id);
        $shareoData = $documentshareTable->fetchRow($docShare_select);
        $docReq_select = $documentreqTable->select()
                    ->where('doc_requested_user_id = ?', $user_id)
                    ->where('file_id = ?', $dropboxfileData->id);
        $oData        = $documentreqTable->fetchRow($docReq_select);

        if(count($oData)>0){
            $is_docRequested =1;
            if($oData->doc_owner_approve ==1){
                $is_docReqApproved =1;
            }
            else{
                $is_docReqApproved =0;
            }
        }
        else{
            $is_docRequested =0;
            $is_docReqApproved =0;
        }
        if(count($shareoData)>0){
            $is_docRequested =1;
            $is_docReqApproved =1;
        }
         $tmpArrayFile[]    =   array('filename'=>$file['filename'],'filetitle'=>$dropboxfileData->file_title,'file_id'=>$dropboxfileData->id,'is_docRequested'=>$is_docRequested,'is_docReqApproved'=> $is_docReqApproved);
       }
        $tmpResultData['directories'] = $tmpArrayDir;
        $tmpResultData['files']       = $tmpArrayFile;
        $resultData                   = array_merge($resultData,$tmpResultData);
        $results_file                 = $resultData;
        $a   = '';
        $b   = '';
        $i   = 1;
        if(count($results_file['directories'])>0){
        foreach($results_file['directories'] as $dir){
            $doc_path =  $doc_dir.'/'.$dir['dirname'];
            $a        = $a .'<li class="dir_li list'.$i.'" dir-name="'.$dir['dirname'].'"><a href="javascript:void(0)" class="dir_open" dir-name="'.$dir['dirname'].'"><img src="/application/modules/User/externals/images/document_folder.svg">&nbsp;&nbsp;'.$dir['dirname'].'</a>';
            $a        = $a.'<hr></li>';
           $i++;
         }
        }
        if(count($results_file['files'])>0){
         foreach($results_file['files'] as $dir){
            $doc_path  =  $doc_dir.'/'.$dir['filename'];
            $file_name =  dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$doc_path;
            if(@is_array(getimagesize($file_name))){
            $is_image = 1;
            }
            else{
                $is_image = 0;
            }
            if($subject_id == $viewer->getIdentity()){
                if($is_image == 1){
                    $b = $b . '<li class="file_li list 12'.$i.'" file-name="'.$dir['filename'].'"><a href="/filemanager/'.$doc_path.'" target="_blank" data-lightbox="image1"><img src="/application/modules/User/externals/images/document_file.svg">&nbsp;&nbsp;'.$dir['filetitle'].'</a>';
                }
                else{
                    $b = $b . '<li class="file_li list3'.$i.'" file-name="'.$dir['filename'].'"><a href="/filemanager/'.$doc_path.'" target="_blank"><img src="/application/modules/User/externals/images/document_file.svg">&nbsp;&nbsp;'.$dir['filetitle'].'</a>';
                }
            }
            if($subject_id != $viewer->getIdentity()){
                if($dir['is_docRequested'] == 0 ){
                $b = $b . '<li class="file_li list'.$i.'" file-name="'.$dir['filename'].'">'.$dir['filetitle'].'';
                $b = $b. '<span class="document_access_span reqst_doc_access_btn docbtn_'.$dir['file_id'].'"  doc-path="'.$doc_path.'" doc-name="'.$dir['filetitle'].'" file-id ="'.$dir['file_id'].'">Ask to view</span>';
                }
                elseif($dir['is_docReqApproved'] == 0){
                $b = $b . '<li class="file_li list'.$i.'" file-name="'.$dir['filename'].'">'.$dir['filetitle'].'';
                $b = $b. '<span class="document_access_span waiting_for_reqst_btn docbtn_'.$dir['file_id'].'"  doc-path="'.$doc_path.'" doc-name="'.$dir['filetitle'].'" file-id ="'.$dir['file_id'].'">Waiting for approval</span>';
                }
                else{
                    if($is_image == 1){
                        $b = $b . '<li class="file_li list'.$i.'" file-name="'.$dir['filename'].'"><a href="/filemanager/'.$doc_path.'" target="_blank" data-lightbox="image1"><img src="/application/modules/User/externals/images/document_file.svg">&nbsp;&nbsp;'.$dir['filetitle'].'</a>';
                    }
                    else{
                        $b = $b . '<li class="file_li list'.$i.'" file-name="'.$dir['filename'].'"><a href="/filemanager/'.$doc_path.'" target="_blank">'.$dir['filetitle'].'</a>';
                    }
                    $b = $b. '<span class="document_access_span approved_reqst_btn" doc-path="'.$doc_path.'" doc-name="'.$dir['filetitle'].'" file-id ="'.$dir['file_id'].'">Approved</span>';
                }
            }
         $b = $b.'<hr></li>';
         $i++;
         }
        }
        $content                 = $a.$b;
        $aResult['html']         = $content;
        $aResult['cur_dir']      = $current_directory.'/'.$dirname ;
        $aResult['cur_dir_menu'] = $current_directory.' / '.$dirname ;
	}
	else{
		$aResult['status'] = false;
	}
        echo json_encode($aResult);

    }
    public function loaddirectory($path) {
    if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

            $files = scandir($path);
            $files = array_diff($files, array('.', '..'));
            $files = array_values($files);
            $tmpResultData= array();
            $tmpArrayFile= array();
            $tmpArrayDir= array();
            $resultData= array();

        for($i=0;$i<count($files);$i++){

            if (is_dir($path.'/'.$files[$i])) {

                $tmpArrayDir[]  =   array('dirname'=>$files[$i]);
            }
            else{

                $tmpArrayFile[] =   array('filename'=>$files[$i]);
            }

        }

        $tmpResultData['directories'] = $tmpArrayDir;
        $tmpResultData['files'] = $tmpArrayFile;
        $resultData = array_merge($resultData,$tmpResultData);
        return $resultData;

    }

    public function documentsharedwithmeAction(){

        if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('common_layout');
        $viewer     =   Engine_Api::_()->user()->getViewer();
        $viewer_id  =   Engine_Api::_()->user()->getViewer()->getIdentity();
        $dirname    =   $viewer->getIdentity().'_'.$viewer->displayname;
        $dir        =   dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dirname;
        if (!is_dir($dir)) {
            mkdir($dir, 0777, true);
        }
        $paths      =   $this->loaddirrecursively($dir);
        //print_r($paths);
        $folder_paths = array();
        for($i = 0; $i < count($paths); $i++){
            $removed_strng = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dirname.'/';
            if($paths[$i] != $dir){
            $folder_paths[] = str_replace($removed_strng,'',$paths[$i]);
           }
        }
        //print_r($folder_paths); exit;
        //echo count($folder_paths) ; exit;
        $this->view->folder_paths = $folder_paths;
        $documentshareTable       = Engine_Api::_()->getDbtable('documentshare', 'user');
        $dropboxfileTable         = Engine_Api::_()->getDbtable('dropboxfiles', 'user');
        $sharedwithmedocs         = $documentshareTable->fetchAll($documentshareTable->select()->where('reciever_id = ?',$viewer_id));
        $userTable                = Engine_Api::_()->getDbtable('users', 'user');
        $tmpResultData            = array();
        $tmpArrayFile             = array();
        $tmpArrayDir              = array();
        $resultData               = array();

        foreach($sharedwithmedocs as $docs){
            $shared_user_data  =   $userTable->fetchRow($userTable->select()->where('user_id = ?',$docs['sender_id']));
            $dropboxfileData   =   $dropboxfileTable->fetchRow($dropboxfileTable->select()->where('id = ?', $docs->share_file_id));
            $doc_path          =   dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$docs['shared_document'];
            $path              =   '/filemanager/'.$docs['shared_document'];
            if (is_dir($doc_path)) {
                $tmpArrayDir[]  =   array('dirname'=>$docs['shared_document_name'],'docpath'=>$path,'shared_usered_id' =>$docs['sender_id'],'shared_usered_name' =>$shared_user_data->displayname);
            }
            else{
				if(file_exists($doc_path)):
                if(@is_array(getimagesize($doc_path))){
                $is_image = 1;
                }
                else{
                    $is_image = 0;
                }
                $path           = '/filemanager/'.$dropboxfileData->file_path;
                $tmpArrayFile[] =   array('is_image'=>$is_image,'file_id' =>$dropboxfileData->id, 'filename'=>$dropboxfileData->file_title,'docpath'=>$path,'shared_usered_id' =>$docs['sender_id'],'shared_usered_name' =>$shared_user_data->displayname);
                endif;
            }
        }
        $tmpResultData['directories'] = $tmpArrayDir;
        $tmpResultData['files']       = $tmpArrayFile;
        $resultData                   = array_merge($resultData,$tmpResultData);
        $this->view->sharedwithmedocs = $resultData;
        $this->view->metaTitle        = 'Documents';

    }

    public function getdirectorycontentsforlandlordsAction(){
		
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        $user_id                =   Engine_Api::_()->user()->getViewer()->getIdentity();
        $viewer                 =   Engine_Api::_()->user()->getViewer();
        $aData                  =   $this->_request->getPost();
        if($aData){
        
        $doc_path               =   $aData['doc_path'];
        $shared_user            =   $aData['shared_user'];
        $dir                    =   dirname($_SERVER['SCRIPT_FILENAME']).'/'.$doc_path;
        $files                  =   $this->loaddirectory($dir);
        $a    = '';
        $b    = '';
        $i    = 1;
        if(count($files['directories'])>0){
            foreach($files['directories'] as $dir){
            $newdoc_path  = $doc_path.'/'.$dir['dirname'];
            $a            = $a .'<li class="dir_li list'.$i.'" dir-name="'.$dir['dirname'].'"><a href="javascript:void(0)" class="dir_open" dir-name="'.$dir['dirname'].'" doc-path="'.$newdoc_path.'" shared_user = "'.$shared_user.'"><img src="/application/modules/User/externals/images/document_folder.svg">&nbsp;&nbsp;'.$dir['dirname'].'</a><hr></li>';
            $i++;
             }
        }
        if(count($files['files'])>0){
            foreach($files['files'] as $dir){
              $file_path = $doc_path.'/'.$dir['filename'];
              $b         = $b . '<li class="file_li list'.$i.'" file-name="'.$dir['filename'].'"><a href="'.$file_path.'" target="_blank">'.$dir['filename'].'</a><hr></li>';
              $i++;
            }
        }
        $content                 = $a.$b;
        $aResult['html']         = $content;
        $aResult['cur_dir']      = $current_directory.'/'.$dirname ;
        $aResult['cur_dir_menu'] = $current_directory.' / '.$dirname ;
	   }
	   else{
		   $aResult['status'] = false;
	   }
        echo json_encode($aResult);
    }

    public function documentrequestsaveAction(){
		
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        $viewerid   = Engine_Api::_()->user()->getViewer()->getIdentity();
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $aData                  =   $this->_request->getPost();
        $doc_path               =   $aData['doc_path'];
        $subject_id             =   $aData['subject_id'];
        $doc_name               =   $aData['doc_name'];
        $file_id                =   $aData['file_id'];
        try{
            $dropboxfileTable = Engine_Api::_()->getDbtable('dropboxfiles', 'user');
            $dropboxfileData  = $dropboxfileTable->fetchRow($dropboxfileTable->select()->where('id = ?', $file_id));
            $documentreqTable = Engine_Api::_()->getDbtable('documentrequests', 'user');
            $documentreqTableId  =   $documentreqTable->insert(array(
                  'doc_requested_user_id' => $viewerid,
                  'doc_owner_id'          => $subject_id,
                  'doc_path'              => $dropboxfileData->file_path,
                  'doc_name'              => $dropboxfileData->file_title,
                  'file_id'               => $file_id,
                  'requested_date'        => date('Y-m-d H:i:s'),
                ));
        $userTable    = Engine_Api::_()->getDbtable('users', 'user');
        $docowner     = $userTable->fetchRow($userTable->select()->where('user_id = ?', $subject_id));
        $docReq       = $documentreqTable->fetchRow($documentreqTable->select()->where('id = ?', $documentreqTableId));

    // send notification
        Engine_Api::_()->getDbtable('notifications', 'activity')
            ->addNotification($docowner, $viewer, $docowner, 'document_request',array(
          'label' => $dropboxfileData->file_title));
    /******mail to docowner***/
                $from_email     = Engine_Api::_()->getApi('settings', 'core')->core_mail_from;
                $docowner_email = $docowner->email;
                $docowner_name  = $docowner->displayname;
                $doc_ReqUser    = $viewer->displayname;
                $doc_name       = $dropboxfileData->file_title;
                $doc_path       = $dropboxfileData->file_path;
                $red_url        =  $_SERVER['HTTP_HOST']."/documents/requests";
                         $bodyTextContent = '';
                         if (file_exists("emailtemplates/document_request_notify_email.html")) {
                            $htmlExist = true;
                            $file = fopen("emailtemplates/document_request_notify_email.html", "r");
                            while(!feof($file))
                            {
                                $bodyTextContent .= fgets($file);
                            }
                            fclose($file);
                        }
                            if($htmlExist){
                              $docowneremail    = '{docowner_email}';
                              $docownername     = '{docowner_name}';
                              $docReqUser       = '{doc_ReqUser}';
                              $redirect_url     = '{redirect_url}';
                              $docname          = '{doc_name}';
                              $docpath          = '{doc_path}';
                              $bodyTextTemplate = '';
                              $bodyHtmlTemplate = $bodyTextContent;
                          foreach( $rParams as $var => $val ) {
                              $raw = trim($var, '[]');
                              $var = '[' . $var . ']';
                              if( !$val ) {
                                $val = $var;
                              }
                              // Fix nbsp
                              $val = str_replace('&amp;nbsp;', ' ', $val);
                              $val = str_replace('&nbsp;', ' ', $val);
                              // Replace

                             $bodyTextTemplate = str_replace($var, $val, $bodyTextTemplate);
                             $bodyHtmlTemplate = str_replace($var, $val, $bodyHtmlTemplate);
                            }
                            $bodyTextTemplate = strip_tags($bodyTextTemplate);
                            $bodyHtmlTemplate = str_replace($docownername, $docowner_name, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($docReqUser, $doc_ReqUser, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($redirect_url, $red_url, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($docname, $doc_name, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($doc_path, $doc_path, $bodyHtmlTemplate);
                         }

                    $subject = "Request for a document";
                    $header  = "From: ".'Rentstarz'." <".$from_email.">\r\n";
                    $header .= "MIME-Version: 1.0\r\n";
                    $header .= 'Content-type: text/html; charset=iso-8859-1' ."\"\r\n\r\n";
                    mail($docowner_email, $subject, $bodyHtmlTemplate, $header);

                /******mail to docowner***/
            $aResult['status'] = true;

        }catch( Exception $e ) { $aResult['status'] = false; }
        echo json_encode($aResult);

    }

     /*public function importstatesAction() {

        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        $user_name = "root";
        $password = "root";
        $database = "social_rentstarz";
        $server = "localhost";

        $db_handle = mysql_connect($server, $user_name, $password);
        $db_found = mysql_select_db($database, $db_handle);

        $selectstates   =   "SELECT name from states WHERE country_id = '231'";
        $statequery     =   mysql_query($selectstates) or die(mysql_error());

        while($row  =   mysql_fetch_array($statequery))
        {

            $stateinsert = "INSERT into engine4_state_list (country_id, state) VALUES ('1','".$row['name']."')";
            mysql_query($stateinsert) or die(mysql_error());

        }

    }

    public function importcitiesAction() {

        ini_set('max_execution_time', 0);

        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        $user_name = "root";
        $password = "root";
        $database = "social_rentstarz";
        $server = "localhost";

        $db_handle = mysql_connect($server, $user_name, $password);
        $db_found = mysql_select_db($database, $db_handle);

        $selectstates   =   "SELECT S.id AS tempstateid,ES.state_id AS stateid from states S LEFT JOIN engine4_state_list ES ON S.name = ES.state WHERE S.country_id = '231'";
        $statequery     =   mysql_query($selectstates) or die(mysql_error());

        while($row  =   mysql_fetch_array($statequery))
        {

            $selectcities   =   "SELECT name from cities WHERE state_id = '".$row['tempstateid']."'";
            $cityquery      =   mysql_query($selectcities) or die(mysql_error());

            while($cityrow  =   mysql_fetch_array($cityquery))
            {
                $cityinsert = "INSERT into engine4_city_list (country_id, state_id, city) VALUES ('1','".$row['stateid']."','".addslashes($cityrow['name'])."')";
                echo "INSERT into engine4_city_list (country_id, state_id, city) VALUES ('1','".$row['stateid']."','".addslashes($cityrow['name'])."')";
                mysql_query($cityinsert) or die(mysql_error());
            }

        }

    }

     public function csvreadAction(){
        //ini_set('max_execution_time', 0); //0=NOLIMIT

        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);

        $user_name = "root";
        $password = "root";
        $database = "social_rentstarz";
        $server = "localhost";

        $db_handle = mysql_connect($server, $user_name, $password);
        $db_found = mysql_select_db($database, $db_handle);

      //define('CSV_PATH',APPLICATION_PATH.'/temporary/csvfile');
      define('CSV_PATH',APPLICATION_PATH.'/temporary');

      $csv_file = CSV_PATH . "/northhampshirecities.csv"; // Name of your CSV file


     if(file_exists($csv_file)) {

         $handle = fopen($csv_file, "r");
         $data = fgetcsv($handle, 1000, ",");
         //print_r($data);exit;
         $insert_csv = array(); $i=0;

        while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) {

                 $insert_csv['cityname']            = $data[0];

                //print_r($insert_csv); exit;

                   $query = "INSERT INTO engine4_city_list(country_id, state_id, city)
                                    VALUES('1','34','".addslashes($insert_csv['cityname'])."')";
                    echo    "INSERT INTO engine4_city_list(country_id, state_id, city)
                                    VALUES('1','34','".addslashes($insert_csv['cityname'])."')";
                       mysql_query($query) or die(mysql_error());


        }

     fclose($handle);
     //rename($csv_file,CSV_PATH."/dealers-".date("Y-m-d H:i").".csv");
    }

}*/


    public function docrequestapproveAction(){
		
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viwer_id         =  Engine_Api::_()->user()->getViewer()->getIdentity();
        $aResult          =  array();
        $aData            =  $this->_request->getPost();
        try{
        $documentreqTable  = Engine_Api::_()->getDbtable('documentrequests', 'user');
        $documentreqTable->update(array('doc_owner_approve' =>1,'req_approve_date'=>date('Y-m-d H:i:s')),array('id = ?' => $aData['req_id']));
        $documentreqTable   = Engine_Api::_()->getDbtable('documentrequests', 'user');
        $docrqststData      = $documentreqTable->fetchRow($documentreqTable->select()->where('id = ?', $aData['req_id']));
        $documentshareTable = Engine_Api::_()->getDbtable('documentshare', 'user');
        $documentshareTableId  =   $documentshareTable->insert(array(  //share doc
                  'sender_id'            => $docrqststData->doc_owner_id,
                  'reciever_id'          => $docrqststData->doc_requested_user_id,
                  'shared_document'      => $docrqststData->doc_path,
                  'shared_document_name' => $docrqststData->doc_name,
                  'share_file_id'        => $docrqststData->file_id,
                  'shared_date'          => date('Y-m-d H:i:s'),
                ));
         // send notification
        $userTable             = Engine_Api::_()->getDbtable('users', 'user');
        $doc_requestedUserData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $docrqststData->doc_requested_user_id));
        Engine_Api::_()->getDbtable('notifications', 'activity')
            ->addNotification($doc_requestedUserData, $viewer, $doc_requestedUserData, 'document_request_approve',array(
          'label' => $docrqststData->doc_name));
        $aResult['status'] = true;
        }catch (Exception $e) {exit($e->getMessage());
                                $aResult['status'] = false;
                            }
        echo json_encode($aResult);

    }

    public function documentAction(){

    if( !$this->_helper->requireUser()->isValid() ) {
          return;
    }
    $this->_helper->viewRenderer->setNoRender(false);
    $this->_helper->layout->setLayout('common_layout');
    $this->view->viewer = $viewer = Engine_Api::_()->user()->getViewer();
    date_default_timezone_set($viewer->timezone);
    $tmpResultData     =  array();
    $tmpArrayFile      =  array();
    $resultData        =  array();
    $dirname           =  $viewer->getIdentity().'_'.$viewer->displayname;
    $dir               =  dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dirname;
    if (!is_dir($dir)) {
            mkdir($dir, 0777, true);
    }
    $dropboxlogTable   = Engine_Api::_()->getDbtable('dropboxlog', 'user');
    $dropboxlogData    = $dropboxlogTable->fetchRow($dropboxlogTable->select()->where('path = ?', $dirname));
    if(count($dropboxlogData) == 0){
    try{
        $dropboxlogTableId    =   $dropboxlogTable->insert(array(
                  'subject_id' => $viewer->getIdentity(),
                  'path'       => $dirname,
                  'action'     => 'root folder created',
                  'created_at' => date('Y-m-d H:i:s'),
                  'updated_at' => date('Y-m-d H:i:s'),
                ));
        }catch (Exception $e) {exit($e->getMessage());
                            }
    }
    $dir     = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dirname;
    $paths   = $this->loaddirrecursively($dir);
    for($i = 0; $i < count($paths); $i++){// echo $i;
        $removed_strng = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dirname.'/';
        if($paths[$i] != $dir){//echo $i;
         $folder_paths[] = str_replace($removed_strng,'',$paths[$i]);
        }
    }
    $this->view->folder_paths = $folder_paths;
    $viewer                   = Engine_Api::_()->user()->getViewer();
    // member type
    $fieldsByAlias            = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
    if( !empty($fieldsByAlias['profile_type']) )
    {
      $optionId                = $fieldsByAlias['profile_type']->getValue($viewer);
      $this->view->profiletype = $profile_type_id = $optionId->value;
    }
   $files            = $this->loaddirectory($dir);
   $dropboxfileTable = Engine_Api::_()->getDbtable('dropboxfiles', 'user');
   foreach($files['files'] as $file){
           $doc_path        = $dirname.'/'.$file['filename'];
           $dropboxfileData = $dropboxfileTable->fetchRow($dropboxfileTable->select()->where('file_path = ?', $doc_path));
           $file_path       = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dropboxfileData->file_path ;
            if(@is_array(getimagesize($file_path))){
            $is_image = 1;
            }
            else{
                $is_image = 0;
            }
          $tmpArrayFile[]    =   array('aa'=>$file_path,'file_id'=>$dropboxfileData->id,'is_image'=>$is_image,'filename'=>$file['filename'],'file_title'=>$dropboxfileData->file_title,'file_owner_id'=> $dropboxfileData->file_owner_id,'file_path'=> $dropboxfileData->file_path,'created_at'=> $dropboxfileData->created_at);
       }
    $tmpResultData['directories'] = $files['directories'];
    $tmpResultData['files']       = $tmpArrayFile;
    $this->view->files            = $tmpResultData;
    $propertyRequestTable         =  Engine_Api::_()->getDbtable('propertyrequest', 'user');
    $userTable                    = Engine_Api::_()->getDbtable('users', 'user');
    if($profile_type_id == 1){ //tenant
    $propertyReq_select      = $propertyRequestTable->select()
                                ->setIntegrityCheck(false)
                                ->from(array('prequest'=>'engine4_property_request',))
                                ->joinLeft(array('user'=>'engine4_users',),'prequest.landlord_id=user.user_id',array('displayname'))
                                ->where('prequest.tenant_id = ?', $viewer->getIdentity())
                                ->where('prequest.landlord_approve    = ?', 1)
                                ->group('user.user_id')
                                ->order('prequest.id DESC');
    $propertyRequest                      = $propertyRequestTable->fetchAll($propertyReq_select);
    $this->view->requestApprovedLandlords = $propertyRequest; // property requested by tenant and approved landlords data
    }
    if($profile_type_id == 4){ //landlord
            $propertyReq_select = $propertyRequestTable->select()
                               ->setIntegrityCheck(false)
                               ->from(array('prequest'=>'engine4_property_request',))
                               ->joinLeft(array('user'=>'engine4_users',),'prequest.tenant_id=user.user_id',array('displayname'))
                               ->where('prequest.landlord_id = ?', $viewer->getIdentity())
                               ->where('prequest.landlord_approve    = ?', 1)
                               ->group('user.user_id')
                               ->order('prequest.id DESC');
    $propertyRequest                      = $propertyRequestTable->fetchAll($propertyReq_select);
    $this->view->propertyRequestedTenants = $propertyRequest;
    }
    if($profile_type_id == 6){ // services
    $selectUsers       = $userTable->getAdapter()->select()
                         ->from(array('user'=>'engine4_users'))
                         ->where('user.user_id   != ?', $viewer->getIdentity())
                         ->query()->fetchAll();
    $this->view->allusers =  $selectUsers;
    }
    //fetch services
    $selectservices          = $userTable->getAdapter()->select()
                        ->from(array('user'=>'engine4_users'))
                        ->where('user.level_id = ?', 8)
                        ->query()->fetchAll();
    $this->view->allservices      =  $selectservices;
    $this->view->metaTitle        = 'Documents';
    }

     public function createdirectoryAction() {
		 
		 if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        $user_id    = Engine_Api::_()->user()->getViewer()->getIdentity();
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);        
        $aData           = $this->_request->getPost();
        if($aData){
		$subject         = Engine_Api::_()->core()->getSubject();
        $folder_name     = $aData['folder_name'];
        $cur_dir         = $aData['cur_dir'];
        $li_count        = $aData['li_count']+1;
        $dirname         = $subject->getIdentity().'_'.$subject->displayname;
        if($cur_dir ==''){
        $dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dirname.'/'.$folder_name;
        }
       else{
           $dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dirname.'/'.$cur_dir.'/'.$folder_name;
       }
        if (!is_dir($dir)) {
                mkdir($dir, 0777, true);
                $dropboxlogTable     = Engine_Api::_()->getDbtable('dropboxlog', 'user');
                $dropboxlogTableId   =   $dropboxlogTable->insert(array(
                          'subject_id' => $viewer->getIdentity(),
                          'path'       => $dir,
                          'action'     => 'folder created',
                          'created_at' => date('Y-m-d H:i:s'),
                          'updated_at' => date('Y-m-d H:i:s'),
                        ));
                $aResult['msg'] ='Folder created successfully';
                $aResult['content'] = '<li class="dir_li list'.$li_count.'" dir-name="'.$folder_name.'"><a href="javascript:void(0)" class="dir_open" dir-name="'.$folder_name.'"><img src="/application/modules/User/externals/images/document_folder.svg">&nbsp;&nbsp;'.$folder_name.'</a><span class="option_links"><a href="javascript:void(0)" class="dir_rename" dir-name="'.$folder_name.'" li-count="'.$li_count.'">Rename</a> | <a href="javascript:void(0)" class="dir_delete" dir-name="'.$folder_name.'" li-count="'.$li_count.'">Delete</a></span><hr></li>';
        }
        else{
            $aResult['msg']     = 'This folder is already existed.';
            $aResult['content'] = '';
        }
	   }
	   else{
		   $aResult['status'] = false;
	   }
        echo json_encode($aResult);

    }
    public function savefileAction(){
		
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        if( $this->getRequest()->isPost()){
            $aData             = $this->_request->getPost();
            $cur_dir           = $aData['cur_dir'];
            $upload_file_title = $aData['upload_file_title'];
            $dirname           =   $viewer->getIdentity().'_'.$viewer->displayname;
            $random_filename   =  $this->random_string(8);
            if($cur_dir ==''){
            $dir           = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dirname;
            $filepath      = $dirname.'/'. $random_filename;
            $dir_structure = $dirname;
            }
            else{
               $dir           = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dirname.$cur_dir;
               $filepath      = $dirname.$cur_dir.'/'. $random_filename;
               $dir_structure = $dirname.$cur_dir;
            }

            $target_file      = $dir .'/'. basename($_FILES["upload_files"]["name"]);
            $imageFileType    = pathinfo($target_file,PATHINFO_EXTENSION);
            $random_filename  = $random_filename.'.'.$imageFileType;
            $filepath         = $filepath.'.'.$imageFileType;
            if($imageFileType != "JPG" && $imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg" &&  $imageFileType != "JPEG" &&  $imageFileType != "PNG" && $imageFileType != "pdf") {

                $aResult['msg']    = "Sorry, only PDF, JPG, JPEG, & PNG  files are allowed.";
                $aResult['status'] = false;
            }
            else{
            $target_file = $dir .'/'. $random_filename;
            if (move_uploaded_file($_FILES["upload_files"]["tmp_name"], $target_file)) {

                $aResult['status']     = $_FILES["upload_files"]["name"];
                $aResult['msg']        = "File is successfully uploaded.";
                $dropboxfileTable      = Engine_Api::_()->getDbtable('dropboxfiles', 'user');
                $dropboxfileTableId    = $dropboxfileTable->insert(array(
                  'dir_structure' => $dir,
                  'file_path'     => $filepath,
                  'file_title'    => $upload_file_title,
                  'file_owner_id' => $viewer->getIdentity(),
                  'created_at'    => date('Y-m-d H:i:s'),
                ));
                $dropboxlogTable     =   Engine_Api::_()->getDbtable('dropboxlog', 'user');
                $dropboxlogTableId   =   $dropboxlogTable->insert(array(
                          'subject_id' => $viewer->getIdentity(),
                          'path'       => $dir,
                          'action'     => 'file created',
                          'created_at' => date('Y-m-d H:i:s'),
                          'updated_at' => date('Y-m-d H:i:s'),
                        ));

                $aResult['status']  = true;
                $aResult['file_id'] = $dropboxfileTableId.'_'.$random_filename;
            } else {
                $aResult['status']  = false;
                $aResult['file_id'] = '';
             }
         }
        echo json_encode($aResult['file_id']);
       }
       else{echo json_encode($aResult['status']  = false);
	   }
        
    }

    public function deletefileAction(){
		
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        $user_id     = Engine_Api::_()->user()->getViewer()->getIdentity();
        $viewer      = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $aData              = $this->_request->getPost();
        if($aData){
        $filename           = $aData['file_name'];
        $current_directory  = $aData['current_directory'];
        $file_id            = $aData['file_id'];
        $dirname            = $viewer->getIdentity().'_'.$viewer->displayname;
        $dropboxfileTable   = Engine_Api::_()->getDbtable('dropboxfiles', 'user');
        $dropboxfileData    = $dropboxfileTable->fetchRow($dropboxfileTable->select()->where('id = ?', $file_id));

        if($current_directory ==''){
         $dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dropboxfileData->file_path;
        }
        else{
         $dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dropboxfileData->file_path;
        }
        if (file_exists($dir)){
            Engine_Db_Table::getDefaultAdapter()->delete('engine4_document_requests', array('file_id = ?' => $file_id) );
            Engine_Db_Table::getDefaultAdapter()->delete('engine4_document_share', array('share_file_id = ?' => $file_id) );
            Engine_Db_Table::getDefaultAdapter()->delete('engine4_dropbox_files', array('id = ?' => $file_id) );
            unlink($dir);
            $dropboxlogTable     = Engine_Api::_()->getDbtable('dropboxlog', 'user');
            $dropboxlogTableId   = $dropboxlogTable->insert(array(
                          'subject_id'   => $user_id,
                          'path'         => $dir,
                          'action'       => 'file deleted',
                          'created_at'   => date('Y-m-d H:i:s'),
                          'updated_at'   => date('Y-m-d H:i:s'),
                        ));
           $aResult['msg'] ='This file is succesfully deleted.';
        }
	}
	else{
		$aResult['status']  = false;
	}
        echo json_encode($aResult);

    }

    public function deletedirAction(){
		
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        $user_id            = Engine_Api::_()->user()->getViewer()->getIdentity();
        $viewer             = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $aData              = $this->_request->getPost();
        if($aData){
        $deleteddir_name    = $aData['dir_name'];
        $current_directory  = $aData['current_directory'];
        $dirname            = $viewer->getIdentity().'_'.$viewer->displayname;
        if($current_directory ==''){
         $dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dirname.'/'.$current_directory.$deleteddir_name;
        }
        else{
         $dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dirname.'/'.$current_directory.'/'.$deleteddir_name;
        }
        if (is_dir($dir)){

        system('/bin/rm -rf ' . escapeshellarg($dir));
        $aResult['msg'] ='This folder is succesfully deleted.';
        }
	    }
	    else{
			$aResult['status']  = false;
		}
        echo json_encode($aResult);
    }

    public function renamefileAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        $user_id    = Engine_Api::_()->user()->getViewer()->getIdentity();
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $aData = $this->_request->getPost();
        if($aData){
        $new_name           =   $aData['new_name'];
        $old_name           =   $aData['old_name'];
        $current_directory  =   $aData['current_directory'];
        $file_id            =   $aData['file_id'];
        $root_dirname       =   $viewer->getIdentity().'_'.$viewer->displayname;
        if($current_directory ==''){
          $old_dir_name = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$root_dirname.'/'.$current_directory.$old_name;
          $new_dir_name = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$root_dirname.'/'.$current_directory.$new_name;
          $new_dir      = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$root_dirname.'/'.$current_directory;
          $doc_path     = $root_dirname.'/'.$old_name;
        }
        else{
          $old_dir_name = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$root_dirname.$current_directory.'/'.$old_name;
          $new_dir_name = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$root_dirname.$current_directory.'/'.$new_name;
          $new_dir      = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$root_dirname.'/'.$current_directory;
          $doc_path     = $root_dirname.$current_directory.'/'.$old_name;
        }
        if(is_dir($old_dir_name)){

            // $files = $this->loaddirectory($old_dir_name);
        $paths = $this->loaddirrecursively($old_dir_name);
        rename($old_dir_name, $new_dir_name);
        $paths1           = $this->loaddirrecursively($new_dir_name);
        $dropboxfileTable = Engine_Api::_()->getDbtable('dropboxfiles', 'user');

        for($i=0;$i<count($paths);$i++){
            $dropboxfileData = $dropboxfileTable->fetchAll($dropboxfileTable->select()->where('dir_structure = ?', $paths[$i]));

            foreach($dropboxfileData as $data){
            $dropboxfile                = $dropboxfileTable->fetchRow($dropboxfileTable->select()->where('id = ?', $data['id']));
            $dropboxfile->dir_structure = $paths1[$i];
            $file_name                  = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$data['file_path'];
            $file_name                  = basename($file_name).PHP_EOL;
            $removed_path               = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/';
            $new_filepath               = str_replace($removed_path,"",$paths1[$i]).'/'.$file_name;
            $dropboxfile->file_path     = $new_filepath;
            $dropboxfile->save();
            }
            $dropboxlogTable   = Engine_Api::_()->getDbtable('dropboxlog', 'user');
            $dropboxlogTableId =   $dropboxlogTable->insert(array(
                          'subject_id' => $viewer->getIdentity(),
                          'path'       => $old_dir_name,
                          'action'     => 'folder renamed to '.$new_name,
                          'created_at' => date('Y-m-d H:i:s'),
                          'updated_at' => date('Y-m-d H:i:s'),
                        ));
        }
        $aResult['msg']  ='Succesfully renamed.';
        $aResult['type'] ='dir';
        }
        if(file_exists($old_dir_name)){

            $dropboxfileTable  = Engine_Api::_()->getDbtable('dropboxfiles', 'user');
            $dropboxfileData   = $dropboxfileTable->fetchRow($dropboxfileTable->select()->where('id = ?', $file_id));
            $dropboxfileData->file_title = $new_name;
            $dropboxfileData->save();
            $dropboxlogTable   = Engine_Api::_()->getDbtable('dropboxlog', 'user');
            $dropboxlogTableId =   $dropboxlogTable->insert(array(
                          'subject_id' => $viewer->getIdentity(),
                          'path'       => $old_dir_name,
                          'action'     => 'file renamed to '.$new_name,
                          'created_at' => date('Y-m-d H:i:s'),
                          'updated_at' => date('Y-m-d H:i:s'),
                        ));
        //rename($old_dir_name, $new_dir_name);
         $file_name = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dropboxfileData->file_path;
         if(@is_array(getimagesize($file_name))){
            $is_image = 1;
            }
            else{
                $is_image = 0;
            }
        $aResult['msg']       =  'Succesfully renamed.';
        $aResult['type']      =  'file';
        $aResult['file_id']   =  $dropboxfileData->id;
        $aResult['file_path'] =  $dropboxfileData->file_path;
        $aResult['is_image']  =  $is_image;
        }
	}
	else{
			$aResult['status']  = false;
		}
        echo json_encode($aResult);

    }

    public function sharedocumentAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();

        $user_id=Engine_Api::_()->user()->getViewer()->getIdentity();
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $aData = $this->_request->getPost();
        if($aData){
        
        $share_dir_name     =   $aData['share_dir_name'];
        $current_directory  =   $aData['current_directory'];
        $reciever_ids       =   $aData['reciever_ids'];
        $share_file_id      =   $aData['share_file_id'];
        $sender_id          =   $viewer->getIdentity();
        $recieverids = explode(",",$reciever_ids);


        $dropboxfileTable = Engine_Api::_()->getDbtable('dropboxfiles', 'user');

        $dropboxfileData = $dropboxfileTable->fetchRow($dropboxfileTable->select()->where('id = ?', $share_file_id));


        $root_dirname =   $viewer->getIdentity().'_'.$viewer->displayname;
        if($current_directory ==''){
            // $shared_document_path = $root_dirname.'/'.$current_directory.$share_dir_name;
             $shared_document_path = $dropboxfileData->file_path;
        }
        else{
            // $shared_document_path = $root_dirname.$current_directory.'/'.$share_dir_name;
             $shared_document_path = $dropboxfileData->file_path;
        }
        try{
            $documentshareTable = Engine_Api::_()->getDbtable('documentshare', 'user');

            $dropboxlogTable = Engine_Api::_()->getDbtable('dropboxlog', 'user');

            $userTable = Engine_Api::_()->getDbtable('users', 'user');

            if($recieverids[0] != ''){

            for($i=0;$i<count($recieverids);$i++){

            $documentshareTable_select = $documentshareTable->select()
                    ->where('reciever_id = ?', $recieverids[$i])
                    ->where('share_file_id = ?', $share_file_id);
            $is_shared = $documentshareTable->fetchRow($documentshareTable_select);

            if(count($is_shared)== 0){


            $documentshareTableId=   $documentshareTable->insert(array(

                  'sender_id' => $sender_id,
                  'reciever_id' => $recieverids[$i],
                  'shared_document' => $dropboxfileData->file_path,
                  'shared_document_name' => $dropboxfileData->file_title,
                  'share_file_id' => $share_file_id,
                  'shared_date' => date('Y-m-d H:i:s'),


                ));

            $dropboxlogTableId=   $dropboxlogTable->insert(array(

                          'subject_id' => $sender_id,
                          'object_id' => $recieverids[$i],
                          'path' => $dropboxfileData->file_path,
                          'action' => 'file shared',
                          'created_at' => date('Y-m-d H:i:s'),
                          'updated_at' => date('Y-m-d H:i:s'),


                        ));

            /******mail***/

                $receiverData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $recieverids[$i]));

                $from_email    = Engine_Api::_()->getApi('settings', 'core')->core_mail_from;

                $docowner_name = $viewer->displayname;
                $recevedUserName   = $receiverData->displayname;
                $recevedUserEmail   = $receiverData->email;
                $doc_name   = $dropboxfileData->file_title;

                //$red_url =    $_SERVER['HTTP_HOST']."/documents/sharedwithme";
                //$red_url =    $_SERVER['HTTP_HOST']."/filemanager/".$dropboxfileData->file_path;
                $red_url =  $_SERVER['HTTP_HOST']."/fileopen/".$share_file_id;



                         $bodyTextContent = '';

                         if (file_exists("emailtemplates/document_share_notify_email.html")) {
                            $htmlExist = true;
                            $file = fopen("emailtemplates/document_share_notify_email.html", "r");
                            while(!feof($file))
                            {
                                $bodyTextContent .= fgets($file);
                            }
                            fclose($file);
                        }

                            if($htmlExist){

                              $docownername='{docowner_name}';
                              $reciveduser='{recivedusername}';
                              $redirect_url='{redirect_url}';
                              $docname='{doc_name}';


                              $bodyTextTemplate = '';
                              $bodyHtmlTemplate = $bodyTextContent;


                          foreach( $rParams as $var => $val ) {
                              $raw = trim($var, '[]');
                              $var = '[' . $var . ']';
                              if( !$val ) {
                                $val = $var;
                              }
                              // Fix nbsp
                              $val = str_replace('&amp;nbsp;', ' ', $val);
                              $val = str_replace('&nbsp;', ' ', $val);
                              // Replace

                             $bodyTextTemplate = str_replace($var, $val, $bodyTextTemplate);
                             $bodyHtmlTemplate = str_replace($var, $val, $bodyHtmlTemplate);
                            }
                            $bodyTextTemplate = strip_tags($bodyTextTemplate);
                            $bodyHtmlTemplate = str_replace($docownername, $docowner_name, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($reciveduser, $recevedUserName, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($redirect_url, $red_url, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($docname, $doc_name, $bodyHtmlTemplate);

                         }

                    $subject = "New document is shared";

                    $header  = "From: ".'Rentstarz'." <".$from_email.">\r\n";
                    $header .= "MIME-Version: 1.0\r\n";
                    $header .= 'Content-type: text/html; charset=iso-8859-1' ."\"\r\n\r\n";

                     mail($recevedUserEmail, $subject, $bodyHtmlTemplate, $header);

                /******mail***/


                             // send notification

          Engine_Api::_()->getDbtable('notifications', 'activity')
            ->addNotification($receiverData, $viewer, $receiverData, 'document_share',array(
          'label' => $doc_name));

            }
            }
            $aResult['msg'] ='Succesfully shared.';
            $aResult['status'] =true;
        }

        else{

            $aResult['msg'] ='Please select users to share document';
            $aResult['status'] =false;
        }

        }catch( Exception $e ) { echo $e; die(); }
	}
	else{
			$aResult['status']  = false;
		}

        echo json_encode($aResult);

    }

    public function documentrequestsAction(){ //document req list page
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('common_layout');

    $viewer_id=Engine_Api::_()->user()->getViewer()->getIdentity();

    $documentreqTable = Engine_Api::_()->getDbtable('documentrequests', 'user');

   $docReq_select = $documentreqTable->select()
                              ->setIntegrityCheck(false)
                               ->from(array('docrequest'=>'engine4_document_requests',))
                               ->joinLeft(array('user'=>'engine4_users',),'docrequest.doc_requested_user_id=user.user_id',array('displayname'))
                               ->where('docrequest.doc_owner_id = ?', $viewer_id)
                               ->order('docrequest.id DESC');
    $oData = $documentreqTable->fetchAll($docReq_select);
    $this->view->docRequests = $oData;

    $this->view->metaTitle        = 'Documents';


   }

   public function loaddirrecursively($path){

if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
         $root =$path;

            $iter = new RecursiveIteratorIterator(
                new RecursiveDirectoryIterator($root, RecursiveDirectoryIterator::SKIP_DOTS),
                RecursiveIteratorIterator::SELF_FIRST,
                RecursiveIteratorIterator::CATCH_GET_CHILD // Ignore "Permission denied"
            );

            $paths = array($root);
            foreach ($iter as $path => $dir) {
                if ($dir->isDir()) {
                    $paths[] = $path;

                }
                else{

                }
            }


    return  $paths;

   }

   public function documentfileAction(){

        if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();

        $user_id=Engine_Api::_()->user()->getViewer()->getIdentity();
        $viewer     = Engine_Api::_()->user()->getViewer() ;
        date_default_timezone_set($viewer->timezone);

        $aData = $this->_request->getPost();
        if($aData){
        $file_id        =   $aData['file_id'];

        $dropboxfileTable = Engine_Api::_()->getDbtable('dropboxfiles', 'user');

        $dropboxfileData = $dropboxfileTable->fetchRow($dropboxfileTable->select()->where('id = ?', $file_id));

        $file_name =dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dropboxfileData->file_path;

         if(@is_array(getimagesize($file_name))){
            $is_image = 1;
            }
            else{
                $is_image = 0;
            }



        $file_name = basename($file_name).PHP_EOL;

        $filetitle = $dropboxfileData-> file_title;

        $content ='';

        $content = $content.'<div class="pop_up_title">';
        $content = $content. '<div class="div_attachment_title">'.$filetitle.'</div>';
        $content = $content. '<div class="div_attachment_cancel"><img src="/application/modules/User/externals/images/GREYcancel.png"></div>';
        $content = $content.'</div>';
        $content = $content.'<div class="popup_content">';
        if($is_image == 0){
        //$content = $content. '<div class="div_attachment_name">Attachment  : </div> <span><a href="/filemanager/'.$dropboxfileData->file_path.'" target="_blank">'. $file_name.'</a></span>';
        }
        else{
        //  $content = $content. '<div class="div_attachment_name">Attachment  : </div> <span><a href="/filemanager/'.$dropboxfileData->file_path.'"  data-lightbox="image1">'. $file_name.'</a></span>';
        }
        $documentshareTable = Engine_Api::_()->getDbtable('documentshare', 'user');
        $documentShareDataSelect = $documentshareTable->select()
                              ->setIntegrityCheck(false)
                               ->from(array('share'=>'engine4_document_share',))
                               ->joinLeft(array('user'=>'engine4_users',),'share.reciever_id=user.user_id',array('displayname'))
                               ->where('share.share_file_id = ?', $file_id);

        $documentShareData = $documentshareTable->fetchAll($documentShareDataSelect);

        $content =$content .'<div>';
        $content =$content .'<div class="attachment_label"  style="font-weight:bold;">Document shared with   :</div>';
        if(count($documentShareData) > 0){
        $content = $content.'<ul>';
        $i=1;
        foreach($documentShareData as $data){

        $content = $content.'<li class="li_count_'.$i.'"><span class="cnt" style="float: left; margin-right: 8px;">'.$i.'</span><div> '.$data['displayname'].'</div></li>';
        $i++;
        }
        $content = $content.'</ul>';
        }
        else{

        $content =$content .'Nobody yet';
        }
        $content =$content .'</div>';
        $content =$content .'<div class="confirm_btns" style="text-align: left;">';
        if($is_image == 0){
        $content =$content .'<a href="/filemanager/'.$dropboxfileData->file_path.'" target="_blank"><button class="cancel">View Document</button></a>';
        }
        else{
        $content =$content .'<a href="/filemanager/'.$dropboxfileData->file_path.'" data-lightbox="image1"><button>View Document</button></a>';
        }
        if(count($documentShareData) > 0){
        $content =$content .'<button class="revoke_access_btn" file-id='.$file_id.'">Revoke Access</button>';
        }
        $content =$content .'</div>';
        $content =$content .'</div>';



        $aResult['html'] = $content;
	}
	else{
		$aResult['status']  = false;
	}

        echo json_encode($aResult);

   }

   public function docrequestrejectAction(){
	   if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

    $this->_helper->layout->disableLayout();
    $this->_helper->viewRenderer->setNoRender(true);

    $viewer     = Engine_Api::_()->user()->getViewer();
    date_default_timezone_set($viewer->timezone);
    $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
    $aResult    =   array();
    $aData = $this->_request->getPost();

    try{
         $documentreqTable = Engine_Api::_()->getDbtable('documentrequests', 'user');

        $docrqststData = $documentreqTable->fetchRow($documentreqTable->select()->where('id = ?', $aData['req_id']));
         // send notification
        $userTable = Engine_Api::_()->getDbtable('users', 'user');

        $doc_rejectedUserData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $docrqststData['doc_requested_user_id']));

        Engine_Api::_()->getDbtable('notifications', 'activity')
            ->addNotification($doc_rejectedUserData, $viewer, $doc_rejectedUserData, 'document_request_reject',array(
          'label' => $docrqststData->doc_name));

        Engine_Db_Table::getDefaultAdapter()->delete('engine4_document_requests', array('id = ?'=>$aData['req_id']) );
        $aResult['status'] = true;
        }catch (Exception $e) {exit($e->getMessage());
                                $aResult['status'] = false;
                            }
        echo json_encode($aResult);

   }

    public function revokefileaccessAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

    $this->_helper->layout->disableLayout();
    $this->_helper->viewRenderer->setNoRender(true);

    $viewer     = Engine_Api::_()->user()->getViewer();
    date_default_timezone_set($viewer->timezone);
    $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
    $aResult    =   array();
    $aData = $this->_request->getPost();
    if($aData){
    $reciever_ids       =   $aData['reciever_ids'];
    $recieverids = explode(",",$reciever_ids);
    try{
    for($i=0;$i<count($recieverids);$i++){
        Engine_Db_Table::getDefaultAdapter()->delete('engine4_document_requests', array('file_id = ?'=>$aData['file_id'],'doc_requested_user_id = ?'=>$recieverids[$i]) );
        Engine_Db_Table::getDefaultAdapter()->delete('engine4_document_share', array('  share_file_id = ?'=>$aData['file_id'],'reciever_id = ?'=>$recieverids[$i]) );
    }
        $aResult['status'] = true;
        }catch (Exception $e) {exit($e->getMessage());
                                $aResult['status'] = false;
                            }
    }
    else{
		$aResult['status'] = false;
	}
        echo json_encode($aResult);

    }
    public function getuserstoshareAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

    $this->_helper->layout->disableLayout();
    $this->_helper->viewRenderer->setNoRender(true);

    $viewer     = Engine_Api::_()->user()->getViewer();
    date_default_timezone_set($viewer->timezone);
    $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
    $aResult    =   array();
    $aData = $this->_request->getPost();
    if($aData){
    $file_id        =   $aData['file_id'];

    // member type

    $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
    if( !empty($fieldsByAlias['profile_type']) )
    {
      $optionId = $fieldsByAlias['profile_type']->getValue($viewer);
      $this->view->profiletype = $profile_type_id = $optionId->value;
    }

    $documentshareTable = Engine_Api::_()->getDbtable('documentshare', 'user');


    $propertyRequestTable =  Engine_Api::_()->getDbtable('propertyrequest', 'user');

    $userTable = Engine_Api::_()->getDbtable('users', 'user');


    $dropboxfileTable = Engine_Api::_()->getDbtable('dropboxfiles', 'user');

    $dropboxfileData = $dropboxfileTable->fetchRow($dropboxfileTable->select()->where('id = ?', $file_id));
    $filetitle = $dropboxfileData-> file_title;

    $file_name =dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dropboxfileData->file_path;

         if(@is_array(getimagesize($file_name))){
            $is_image = 1;
            }
            else{
                $is_image = 0;
            }

        //fetch services

/*  $selectservices = $userTable->getAdapter()->select()
                        ->from(array('user'=>'engine4_users'))
                        ->where('user.level_id = ?', 8)
                        ->query()->fetchAll();
    */

    $a ='';

    $a = $a.'<div class="pop_up_title">';
    $a = $a.'<div class="div_attachment_title">'. $filetitle.'</div><ul>';
    $a = $a. '<div class="div_attachment_cancel"><img src="/application/modules/User/externals/images/GREYcancel.png"></div>';
    $a = $a.'</div>';
    $a = $a.'<div class="popup_content">';
    $a = $a.'<div class="share_popup_label_div" style="margin-bottom: 7px; font-size: 15px;font-weight: bold;">Select users to share document with</div>';
    $a = $a.'<div class="users_to_check_div">';
    if($profile_type_id == 1){ //tenant

    $propertyReq_select = $propertyRequestTable->select()
                              ->setIntegrityCheck(false)
                               ->from(array('prequest'=>'engine4_property_request',))
                               ->joinLeft(array('user'=>'engine4_users',),'prequest.landlord_id=user.user_id',array('displayname'))
                               ->where('prequest.tenant_id = ?', $viewer->getIdentity())
                               ->where('prequest.landlord_approve    = ?', 1)
                               ->group('user.user_id')
                               ->order('prequest.id DESC');



    $propertyRequest = $propertyRequestTable->fetchAll($propertyReq_select);
     // property requested by tenant and approved landlords data
    if(count($propertyRequest)>0){
    foreach($propertyRequest as $data){

    $documentshareTable_select = $documentshareTable->select()
                    ->where('reciever_id = ?', $data['landlord_id'])
                    ->where('share_file_id = ?', $file_id);
    $is_shared = $documentshareTable->fetchAll($documentshareTable_select);

    if(count($is_shared)  == 0){

    $a = $a.'<li><label><span class="chk_shared_users"><input type="checkbox" name="recievers[]" class="recievers" value="'.$data['landlord_id'].'" /></span>'.$data['displayname'].'</label></li>';

    }

    }
    }
  /*  if(count($selectservices)>0){
    foreach($selectservices as $data){

            $documentshareTable_select = $documentshareTable->select()
                    ->where('reciever_id = ?', $data['user_id'])
                    ->where('share_file_id = ?', $file_id);
    $is_shared = $documentshareTable->fetchRow($documentshareTable_select);

     if(count($is_shared)  == 0){

    $a = $a.'<li><label><span class="chk_shared_users"><input type="checkbox" name="recievers[]" class="recievers" value="'.$data['user_id'].'" /></span>'.$data['displayname'].'</label></li>';

    }

    }
    }*/
    $a = $a.'</ul>';

    if(count($propertyRequest) == 0 && count($selectservices) == 0){

        $aResult['status'] = 'no matching users';

    }
    else{
        $aResult['status'] ='';
    }

    }
    if($profile_type_id == 4){ //landlord

            $propertyReq_select = $propertyRequestTable->select()
                              ->setIntegrityCheck(false)
                               ->from(array('prequest'=>'engine4_property_request',))
                               ->joinLeft(array('user'=>'engine4_users',),'prequest.tenant_id=user.user_id',array('displayname'))
                               ->where('prequest.landlord_id = ?', $viewer->getIdentity())
                               ->where('prequest.landlord_approve    = ?', 1)
                               ->group('user.user_id')
                               ->order('prequest.id DESC');

    $propertyRequest = $propertyRequestTable->fetchAll($propertyReq_select);

    //$a = $a.'<div><h2>Select Users</h2></div><ul>';
    if(count($propertyRequest)>0){
    foreach($propertyRequest as $data){

    $documentshareTable_select = $documentshareTable->select()
                    ->where('reciever_id = ?', $data['tenant_id'])
                    ->where('share_file_id = ?', $file_id);
    $is_shared = $documentshareTable->fetchRow($documentshareTable_select);


      if(count($is_shared)  == 0){


        $a = $a.'<li><label><span class="chk_shared_users"><input type="checkbox" name="recievers[]" class="recievers" value="'.$data['tenant_id'].'" /></span>'.$data['displayname'].'</label></li>';

     }
   }
   }
   if(count($selectservices)>0){
   foreach($selectservices as $data){

    $documentshareTable_select = $documentshareTable->select()
                    ->where('reciever_id = ?', $data['user_id'])
                    ->where('share_file_id = ?', $file_id);
    $is_shared = $documentshareTable->fetchRow($documentshareTable_select);

    if(count($is_shared)  == 0){

    $a = $a.'<li><label><span class="chk_shared_users"><input type="checkbox" name="recievers[]" class="recievers" value="'.$data['user_id'].'" /></span>'.$data['displayname'].'</label></li>';

    }

    }
    }
    $a = $a.'</ul>';

     if(count($propertyRequest) == 0 && count($selectservices) == 0){

        $aResult['status'] = 'no matching users';

    }
    else{
        $aResult['status'] ='';
    }
    }
    if($profile_type_id == 6){ // services


    $selectUsers = $userTable->getAdapter()->select()
                        ->from(array('user'=>'engine4_users'))
                         ->where('user.user_id   != ?', $viewer->getIdentity())
                        ->query()->fetchAll();



    //$a = $a.'<div><h2>Select Users</h2></div><ul>';
    if(count($selectservices)>0){
    foreach($selectUsers as $data){


    $documentshareTable_select = $documentshareTable->select()
                    ->where('reciever_id = ?', $data['user_id'])
                    ->where('share_file_id = ?', $file_id);
    $is_shared = $documentshareTable->fetchRow($documentshareTable_select);

    if(count($is_shared)  == 0){


    $a = $a.'<li><label><span class="chk_shared_users"><input type="checkbox" name="recievers[]" class="recievers" value="'.$data['user_id'].'" /></span>'.$data['displayname'].'</label></li>';

    }


    }
    }
    if(count($selectservices) == 0){

        $aResult['status'] = 'no matching users';

    }
    else{
        $aResult['status'] ='';
    }


    }

    $a = $a.'<input type="hidden" class="share_file_id" value="'.$file_id.'">';
    //$a = $a.'<div style="margin-top: 15px;">';
    $a =$a .'<div class="confirm_btns" style="text-align: left;">';
    if($is_image == 0){
        $a =$a .'<a href="/filemanager/'.$dropboxfileData->file_path.'" target="_blank"><button class="cancel">View Document</button></a>';
        }
        else{
        $a =$a .'<a href="/filemanager/'.$dropboxfileData->file_path.'" data-lightbox="image1" style="margin-right: 15px;"><button>View Document</button></a>';
        }

    $a = $a.'<span class="confirm_btns"><button class="share_document" style="width: 99px;">Share</button></span>';

    $a = $a.'</div>';
    $a = $a.'</div>';
    $a = $a.'</div>';

    $aResult['html'] = $a;
	}
	else{
		$aResult['status'] = false;
	}
        echo json_encode($aResult);

    }


    function random_string($length) {
    $key = '';
    $keys = array_merge(range(0, 9), range('a', 'z'));

    for ($i = 0; $i < $length; $i++) {
        $key .= $keys[array_rand($keys)];
    }

    return $key;
   }

   public function getsharedusersAction(){
    if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();

        $user_id=Engine_Api::_()->user()->getViewer()->getIdentity();
        $viewer     = Engine_Api::_()->user()->getViewer() ;
        date_default_timezone_set($viewer->timezone);
        $aData = $this->_request->getPost();
        
        if($aData){
        $file_id        =   $aData['file_id'];

        $documentshareTable = Engine_Api::_()->getDbtable('documentshare', 'user');
        $documentShareDataSelect = $documentshareTable->select()
                              ->setIntegrityCheck(false)
                               ->from(array('share'=>'engine4_document_share',))
                               ->joinLeft(array('user'=>'engine4_users',),'share.reciever_id=user.user_id',array('displayname','user_id'))
                               ->where('share.share_file_id = ?', $file_id);

        $documentShareData = $documentshareTable->fetchAll($documentShareDataSelect);

        $dropboxfileTable = Engine_Api::_()->getDbtable('dropboxfiles', 'user');

        $dropboxfileData = $dropboxfileTable->fetchRow($dropboxfileTable->select()->where('id = ?', $file_id));

        $filetitle = $dropboxfileData-> file_title;

        $content ='';

        $content = $content.'<div class="pop_up_title">';
        $content = $content. '<div class="div_attachment_title">'.$filetitle.'</div>';
        $content = $content. '<div class="div_attachment_cancel"><img src="/application/modules/User/externals/images/GREYcancel.png"></div>';
        $content = $content.'</div>';

        $content = $content.'<div class="popup_content">';
        $content = $content.'<div class="revoke_err_msg" style="color: red;"></div>';

        $content =$content .'<div>';
        $content =$content .'<div class="attachment_label" style="font-weight:bold;">Document shared with   :</div>';
        if(count($documentShareData) > 0){
        $content = $content.'<ul>';
        $i=1;
        foreach($documentShareData as $data){

        $content = $content.'<li class="li_count_'.$i.'"><span class="chk_shared_users"><input type="checkbox" name="recievers[]" class="recievers" value="'.$data['user_id'].'"></span><div> '.$data['displayname'].'</div></li>';
        $i++;
        }
        $content = $content.'</ul>';

         $content =$content .'<div class="popup_actionbtns"><button class="revoke_access_action" file-id='.$file_id.'>Revoke Access</button></div>';

        }
        else{

        $content =$content .'Nobody yet';
        }
        $content =$content .'</div>';

        $content = $content.'</div>';

        $aResult['html'] = $content;
	}
	else{
		$aResult['status'] = false;
	}
        echo json_encode($aResult);
   }

   public function getfiledataAction(){
	   if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();

        $user_id=Engine_Api::_()->user()->getViewer()->getIdentity();
        $viewer     = Engine_Api::_()->user()->getViewer() ;
        date_default_timezone_set($viewer->timezone);
        $aData = $this->_request->getPost();
        if($aData){
        $file_id        =   $aData['file_id'];

        $dropboxfileTable = Engine_Api::_()->getDbtable('dropboxfiles', 'user');

        $dropboxfileData = $dropboxfileTable->fetchRow($dropboxfileTable->select()->where('id = ?', $file_id));

        $filetitle = $dropboxfileData-> file_title;
        $aResult['filetitle'] = $filetitle;
	   }
	   else{
		   $aResult['status'] = false;
	   }

        echo json_encode($aResult);
   }


    public function copyfileAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();

        $user_id=Engine_Api::_()->user()->getViewer()->getIdentity();
        $viewer     = Engine_Api::_()->user()->getViewer() ;
        date_default_timezone_set($viewer->timezone);
        $aData = $this->_request->getPost();
        if($aData){
        $file_id            =   $aData['file_id'];
        $destination        =   $aData['destination'];
        $root_dirname       =   $viewer->getIdentity().'_'.$viewer->displayname;
        $dropboxfileTable   =   Engine_Api::_()->getDbtable('dropboxfiles', 'user');
        $dropboxfileData    =   $dropboxfileTable->fetchRow($dropboxfileTable->select()->where('id = ?', $file_id));
        $copy_file          =   dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dropboxfileData->file_path;
        $copy_file_name     =   basename($copy_file);
        $destination_path   =   dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$root_dirname.'/'.$destination;

        if(is_dir($destination_path)){
            $destination_file = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$root_dirname.'/'.$destination.'/'.$copy_file_name;
            copy($copy_file, $destination_file);
            $filepath         = $root_dirname.'/'.$destination.'/'.$copy_file_name;
            $dropboxfileTable = Engine_Api::_()->getDbtable('dropboxfiles', 'user');
            $dropboxfileTableId  =   $dropboxfileTable->insert(array(
                  'dir_structure' => $destination_path,
                  'file_path' => $filepath,
                  'file_title' => $dropboxfileData->file_title,
                  'file_owner_id' => $viewer->getIdentity(),
                  'created_at' => date('Y-m-d H:i:s'),
                ));
            $dropboxlogTable   =   Engine_Api::_()->getDbtable('dropboxlog', 'user');
            $dropboxlogTableId =   $dropboxlogTable->insert(array(
                          'subject_id' => $viewer->getIdentity(),
                          'path' => $destination_path,
                          'action' => 'file coped',
                          'created_at' => date('Y-m-d H:i:s'),
                          'updated_at' => date('Y-m-d H:i:s'),
                        ));
            $aResult['status'] = true;
        }
        else{

            $aResult['status'] = false;
        }
	}else{

            $aResult['status'] = false;
        }
        echo json_encode($aResult);

   }

    public function fileopenAction($id){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        else{

        $file_id = $this->_getParam('id');
        if($file_id){

        $dropboxfileTable = Engine_Api::_()->getDbtable('dropboxfiles', 'user');

        $dropboxfileData = $dropboxfileTable->fetchRow($dropboxfileTable->select()->where('id = ?', $file_id));

        $filepath = '/filemanager/'.$dropboxfileData->file_path;
        header("Location: ".$filepath);
		}
		else{
			 return $this->_forward('notfound');
		}
       }

    }
    public function getfoldersAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

    $this->_helper->viewRenderer->setNoRender(true);
    $this->_helper->layout->disableLayout();
    $user_id    = Engine_Api::_()->user()->getViewer()->getIdentity();
    $viewer     = Engine_Api::_()->user()->getViewer() ;
    date_default_timezone_set($viewer->timezone);
    $dirname =   $viewer->getIdentity().'_'.$viewer->displayname;
    $dir     = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dirname;
    if (is_dir($dir)) {
        $paths = $this->loaddirrecursively($dir);
        //print_r($paths);
        for($i = 0; $i < count($paths); $i++){// echo $i;
            $removed_strng = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dirname.'/';
            if($paths[$i] != $dir){//echo $i;
             $folder_paths[] = str_replace($removed_strng,'',$paths[$i]);
            }
        }//print_r($folder_paths); exit;
        $content = '';
        if(count($folder_paths) > 0){
            $content = $content.'<div class="folder_name_input">';
            $content = $content.'<select class="destination"   style="width:100%">';
            $content = $content.'<option value="">Select folder</option>';
            for($i=0;$i<count($folder_paths);$i++){
                 $content = $content.'<option value="'.$folder_paths[$i].'">'.$folder_paths[$i].'</option>';
            }
            $content = $content.'</select>';
            $content = $content.'<div class="confirm_btns" style="text-align: left;">';
            $content = $content.'<span class="confirm_btns"><button class="yes_file_copy" style="width: 134px;">Copy</button></span>';
        }
        else{
        $content = $content.'<div><span>You have no folders created to copy this document</span></div>';
        $content = $content.'<div class="menu_bar_create_folder">';
        $content = $content.'<button class="new_folder_btn">Create Folder</button>';
        $content = $content.'</div>';
        }
    }
    $aResult['html'] = $content;
    echo json_encode($aResult);

 }

public function propertyapprovedrequestslistAction() {

        if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
        if( !empty($fieldsByAlias['profile_type']) )
            {
              $optionId = $fieldsByAlias['profile_type']->getValue($viewer);
              $profile_type_id = $optionId->value;
            }
        if($profile_type_id != 4){
            return $this->_forward('notfound');
        }

        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('common_layout');
        $viewer_id            =  Engine_Api::_()->user()->getViewer()->getIdentity();
        $propertyRequestTable =  Engine_Api::_()->getDbtable('propertyrequest', 'user');
        $propertyReq_select   = $propertyRequestTable->select()
                              ->setIntegrityCheck(false)
                               ->from(array('prequest'=>'engine4_property_request',))
                               ->joinLeft(array('plist'=>'engine4_property_list',),'plist.id=prequest.property_id',array('property_name','rental_type'))
                               ->joinLeft(array('user'=>'engine4_users'),'plist.property_owner_id=user.user_id',array('bg_verified'))
                                ->joinLeft(array('smartmoveapi_application'=>'engine4_smartmoveapi_application'),'smartmoveapi_application.rental_application_id=prequest.id',array('SmartmoveApplicationId','ApplicationStatus','IdmaVerificationStatus','rental_application_id'))
                               ->joinLeft(array('smartmoveapi_report'=>'engine4_smartmoveapi_report'),'smartmoveapi_report. SmartmoveApplicationId=smartmoveapi_application.SmartmoveApplicationId',array('isReportRequest','isPaid','updated_at','reportResponse'))
                               ->where('prequest.landlord_id = ?', $viewer_id)
                               ->where('plist.landlord_enable    = ?', 1)
                               ->where('(plist.enable = ?', 1)
                               ->orWhere('user.bg_verified   = ?)', 1)
                               ->where('prequest.landlord_approve    = ?', 1)
                               ->where('prequest.admin_approve   = ?', 1)
                               ->order('prequest.property_id DESC');

        $propertyRequestApproved = $propertyRequestTable->fetchAll($propertyReq_select);
        $userTable               = Engine_Api::_()->getDbtable('users', 'user');
        foreach($propertyRequestApproved as $data){
            $tenantData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $data['tenant_id']));
            $approved_lists[$data['property_id']]['property_name'] = $data->property_name;
            $approved_lists[$data['property_id']]['property_id']   = $data['property_id'];
            $approved_lists[$data['property_id']][] =array('request_id'=>$data['id'],'user_id' =>$tenantData->user_id,'display_name' => $tenantData->displayname,'property_id'=>$data['property_id'],'property_name'=>$data->property_name,
            'SmartmoveApplicationId'=>$data->SmartmoveApplicationId,'isReportRequest'=>$data->isReportRequest,
            'isPaid'=>$data->isPaid,'reportUpdated_at'=>$data->updated_at,
            'reportResponse'=>$data->reportResponse,
            );
        }
        //echo '<pre>'; print_r($approved_lists); exit;
        $this->view->propertyRequestApproved = $approved_lists;
        $this->view->metaTitle               = 'Property Approved Request List';
        $table                               = Engine_Api::_()->getItemTable('user');
        $onlineTable                         = Engine_Api::_()->getDbtable('online', 'user');
        $tableName                           = $table->info('name');
        $onlineTableName                     = $onlineTable->info('name');
        $viewer = Engine_Api::_()->user()->getViewer();
        $viewerId   =   $viewer->getIdentity();
        $online_select = $table->select()
          ->from($tableName)
          ->joinRight($onlineTableName, $onlineTableName.'.user_id = '.$tableName.'.user_id', null)
          ->where($onlineTableName.'.user_id > ?', 0)
          ->where($onlineTableName.'.active > ?', new Zend_Db_Expr('DATE_SUB(NOW(),INTERVAL 20 MINUTE)'))
          ->where($tableName.'.search = ?', 1)
          ->where($tableName.'.enabled = ?', 1)
          ->where($onlineTableName.'.user_id != ?', $viewerId) // to hide logged in user from showing in member online widget
          ->order($onlineTableName.'.active DESC')
          ->group($onlineTableName.'.user_id')
          ;
    $online_users_Data=$table->fetchAll($online_select);



    $StripeSettingsTable =  Engine_Api::_()->getDbtable('Stripesettings', 'user');
    $this->view->StripeSettingsData = $StripeSettingsTable->fetchRow($StripeSettingsTable->select());



    $this->view->online_users =$online_users_Data;
    }


    public function propertyrequestapprovedgrantAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
        $aResult    =   array();
        $aData = $this->_request->getPost();
        date_default_timezone_set($viewer->timezone);
        try{
        $selected_tenant    =   $aData['selected_tenant'];
        $unselected_tenants =   $aData['unselected_tenants'];
        $propertyid         =   $aData['propertyid'];
        $ratingintervalTable = Engine_Api::_()->getDbtable('ratinginterval', 'user');
        $ratingintervalTable_select =   $ratingintervalTable->fetchRow($ratingintervalTable->select());
        if($ratingintervalTable_select->days ==0){
            $ratingdays =date('Y-m-d');
        }
        else{
             $days = "+".$ratingintervalTable_select->days." days";
             $ratingdays = date('Y-m-d', strtotime($days));
        }
        $propertyGrantedTable =  Engine_Api::_()->getDbtable('propertygranted', 'user');
        $propertyGrantedTableid =   $propertyGrantedTable->insert(array(
                        'property_id' => $propertyid,
                        'tenant_id'   => $selected_tenant,
                        'landlord_id' => $viwer_id,
                        'granted'     => 1,
                        'status'     => 1,
                        'granted_date'     => date('Y-m-d')
                    ));
        $propertyRequestTable =  Engine_Api::_()->getDbtable('propertyrequest', 'user');
        $propertyReq_select = $propertyRequestTable->select()
                        ->where('property_id = ?', $propertyid)
                        ->where('tenant_id = ?', $selected_tenant);
        $oData = $propertyRequestTable->fetchRow($propertyReq_select);
        $oData->granted          = 1;
        $oData->granted_date     = date('Y-m-d');
        $oData->save();
        $propertyTable =  Engine_Api::_()->getDbtable('propertylist', 'user');
        $property_select = $propertyTable->select()
                        ->where('id = ?', $propertyid);
        $propertyData = $propertyTable->fetchRow($property_select);
        $propertyData->granted       = 1;
        $propertyData->granted_date  = date('Y-m-d');
        $propertyData->save();
        // add entry to rating table for both users tenant and lanlord to find rating date
        $ratingValueTable =  Engine_Api::_()->getDbtable('ratingvalue', 'user');
        try{
        $ratingvalue_select = $ratingValueTable->select()
                        ->where('subject_id = ?', $viwer_id)
                        ->where('object_id = ?', $selected_tenant);
        $ratingvalueData = $ratingValueTable->fetchRow($ratingvalue_select);
        if(count($ratingvalueData) == 0){
        $ratingValueTable->insert(array( //for landlord
                    'subject_id' => $viwer_id,
                    'object_id'  => $selected_tenant,
                    'rate_value'  => 0,
                    'rated_date'  => '',
                    'next_rating_date'  => $ratingdays,
                ));
        }
        else{
            $ratingvalueData -> next_rating_date =$ratingdays;
            $ratingvalueData -> save();
        }
        $ratingvalue_select = $ratingValueTable->select()
                        ->where('subject_id = ?', $selected_tenant)
                        ->where('object_id = ?', $viwer_id);

        $ratingvalueData = $ratingValueTable->fetchRow($ratingvalue_select);
        if(count($ratingvalueData) == 0){
        $ratingValueTable->insert(array( // for tenant
                    'subject_id' => $selected_tenant,
                    'object_id'  => $viwer_id,
                    'rate_value'  => 0,
                    'rated_date'  => '',
                    'next_rating_date'  => $ratingdays,
                    //'next_rating_date'  => date('Y-m-d')
                ));
            }
            else{
            $ratingvalueData -> next_rating_date = $ratingdays;
            $ratingvalueData -> save();
            }
        // entry for rating log table
        $ratinglogTable =  Engine_Api::_()->getDbtable('ratinglog', 'user');
        $ratinglog_select = $ratinglogTable->select()
                        ->where('property_id = ?', $propertyid)
                        ->where('subject_id = ?', $viwer_id)
                        ->where('object_id = ?', $selected_tenant);
        $ratinglogData = $ratinglogTable->fetchRow($ratinglog_select);
        if($ratinglogData == 0){
            $ratinglogTable->insert(array( //for landlord
                    'subject_id' => $viwer_id,
                    'object_id'  => $selected_tenant,
                    'property_id'  => $propertyid,
                    'next_rating_date'  => $ratingdays,
                ));
        }
        else{
            $ratinglogData -> next_rating_date = $ratingdays;
            $ratinglogData -> save();
        }
        $ratinglog_select = $ratinglogTable->select()
                        ->where('property_id = ?', $propertyid)
                        ->where('subject_id = ?', $selected_tenant)
                        ->where('object_id = ?', $viwer_id);
        $ratinglogData = $ratinglogTable->fetchRow($ratinglog_select);
        if($ratinglogData == 0){
            $ratinglogTable->insert(array( //for landlord
                    'subject_id' => $selected_tenant,
                    'object_id'  => $viwer_id,
                    'property_id'  => $propertyid,
                    'next_rating_date'  => $ratingdays,
                ));
        }
        else{
            $ratinglogData -> next_rating_date = $ratingdays;
            $ratinglogData -> save();
        }
        }catch (Exception $e) {exit($e->getMessage());                            }
        
        
      $userTable     = Engine_Api::_()->getDbtable('users', 'user');
      $tenantData    = $userTable->fetchRow($userTable->select()->where('user_id = ?', $selected_tenant));  
      $propertyData  = $propertyTable->fetchRow($propertyTable->select()->where('id = ?', $propertyid));
      
      
       $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer); //print_r($fieldsByAlias); exit("1111111");
                 $gender_id = $fieldsByAlias['gender']->getValue($viewer);
                if( $gender_id ) {
                    $genderObj = Engine_Api::_()->fields()
                      ->getFieldsOptions($viewer)
                      ->getRowMatching('option_id', $gender_id->value);
                      if( $genderObj ) {
                      $this->view->gender = $genderObj->label;
                      $gender = $genderObj->label;

                      if($gender == 'Male'){
                          $gen = 'his';
                      }
                      else{
                          $gen = 'her';
                      }
                    }
                }
         // send notification

     Engine_Api::_()->getDbtable('notifications', 'activity')
            ->addNotification($tenantData, $viewer, $tenantData, 'property_granted',array(
          'label' => $viewer->displayname,'pid' => $propertyid ,'pname'=> $propertyData->property_name,'gender_of_propertyowner' => $gen,'rentaltype'=>$propertyData->rental_type));
        
        
        
        /******mail to selected tenant***/

        $propertyTable = Engine_Api::_()->getDbtable('propertylist', 'user');
        
        
        $from_email    = Engine_Api::_()->getApi('settings', 'core')->core_mail_from;
               
                $landlord_name   = $viewer->displayname;
                $landlord_email  = $viewer->email;
                $tenant_name     = $tenantData->displayname;
                $tenant_email    = $tenantData->email;
                $property_name   = $propertyData->property_name;
                $rental_type     = $propertyData->rental_type;
                $red_url = $_SERVER['HTTP_HOST']."/property/".$propertyid;
                         $bodyTextContent = '';
                         if (file_exists("emailtemplates/property_request_granted_email.html")) {
                            $htmlExist = true;
                            $file = fopen("emailtemplates/property_request_granted_email.html", "r");
                            while(!feof($file))
                            {
                                $bodyTextContent .= fgets($file);
                            }
                            fclose($file);
                        }
                            if($htmlExist){
                              $landlordname='{landlordname}';
                              $landlordgen='{landlordgen}';
                              $tenantname='{tenantname}';
                              $rentaltype='{rentaltype}';
                              $redirecturl='{redirect_url}';
                              $propertyname='{property_name}';
                              $bodyTextTemplate = '';
                              $bodyHtmlTemplate = $bodyTextContent;
                          foreach( $rParams as $var => $val ) {
                              $raw = trim($var, '[]');
                              $var = '[' . $var . ']';
                              if( !$val ) {
                                $val = $var;
                              }
                              // Fix nbsp
                              $val = str_replace('&amp;nbsp;', ' ', $val);
                              $val = str_replace('&nbsp;', ' ', $val);
                              // Replace

                             $bodyTextTemplate = str_replace($var, $val, $bodyTextTemplate);
                             $bodyHtmlTemplate = str_replace($var, $val, $bodyHtmlTemplate);
                            }
                            $bodyTextTemplate = strip_tags($bodyTextTemplate);
                            $bodyHtmlTemplate = str_replace($landlordname, $landlord_name, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($tenantname, $tenant_name, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($rentaltype, $rental_type, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($redirecturl, $red_url, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($landlordgen, $gen, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($propertyname, $property_name, $bodyHtmlTemplate);
                         }
                    $subject = "Property ".$rental_type." granted";
                    $header  = "From: ".'Rentstarz'." <".$from_email.">\r\n";
                    $header .= "MIME-Version: 1.0\r\n";
                    $header .= 'Content-type: text/html; charset=iso-8859-1' ."\"\r\n\r\n";
                    mail($tenant_email, $subject, $bodyHtmlTemplate, $header);
        //remove the property request from the unselected tenants
        $propertyRequestTable    =  Engine_Api::_()->getDbtable('propertyrequest', 'user');
        $unselected_tenantsArray =  explode(",",$unselected_tenants);
        //print_r($unselected_tenantsArray); exit;
        for($i=0; $i<count($unselected_tenantsArray)-1;$i++){
             $userTable             = Engine_Api::_()->getDbtable('users', 'user');
             $unselected_tenantData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $unselected_tenantsArray[$i]));
             $unselected_tenant_name      = $unselected_tenantData->displayname;
             $unselected_tenant_email     = $unselected_tenantData->email;
             $landlord_name               = $viewer->displayname;
             $property_name               = $propertyData->property_name;
             $property_url                = $_SERVER['HTTP_HOST']."/property/".$propertyid;
             $rental_type                 = $propertyData->rental_type;
             $bodyTextContent = '';
                         if (file_exists("emailtemplates/property_request_granted_rejected_email.html")) {
                            $htmlExist = true;
                            $file = fopen("emailtemplates/property_request_granted_rejected_email.html", "r");
                            while(!feof($file))
                            {
                                $bodyTextContent .= fgets($file);
                            }
                            fclose($file);
                        }
                            if($htmlExist){
                              $landlordname='{landlordname}';
                              $tenantname='{tenantname}';
                              $rentaltype='{rentaltype}';
                              $propertyurl='{property_url}';
                              $propertyname='{property_name}';
                              $bodyTextTemplate = '';
                              $bodyHtmlTemplate = $bodyTextContent;
                          foreach( $rParams as $var => $val ) {
                              $raw = trim($var, '[]');
                              $var = '[' . $var . ']';
                              if( !$val ) {
                                $val = $var;
                              }
                              // Fix nbsp
                              $val = str_replace('&amp;nbsp;', ' ', $val);
                              $val = str_replace('&nbsp;', ' ', $val);
                              // Replace
                             $bodyTextTemplate = str_replace($var, $val, $bodyTextTemplate);
                             $bodyHtmlTemplate = str_replace($var, $val, $bodyHtmlTemplate);
                            }
                            $bodyTextTemplate = strip_tags($bodyTextTemplate);
                            $bodyHtmlTemplate = str_replace($landlordname, $landlord_name, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($tenantname, $unselected_tenant_name, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($rentaltype, $rental_type, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($propertyurl, $property_url, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($propertyname, $property_name, $bodyHtmlTemplate);
                         }
                    $subject = "Rentstarz property updates";
                    $header  = "From: ".'Rentstarz'." <".$from_email.">\r\n";
                    $header .= "MIME-Version: 1.0\r\n";
                    $header .= 'Content-type: text/html; charset=iso-8859-1' ."\"\r\n\r\n";

                    mail($unselected_tenant_email, $subject, $bodyHtmlTemplate, $header);
          Engine_Db_Table::getDefaultAdapter()->delete('engine4_property_request', array('property_id = ?'=>$propertyid ,'tenant_id = ?' => $unselected_tenantsArray[$i]) );

        }
        $aResult['status'] = true;
        }catch (Exception $e) {exit($e->getMessage());
                                $aResult['status'] = false;
                            }
        echo json_encode($aResult);

    }

    public function propertyapproveduserslistAction(){

    if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
        if( !empty($fieldsByAlias['profile_type']) )
            {
              $optionId = $fieldsByAlias['profile_type']->getValue($viewer);
              $profile_type_id = $optionId->value;
            }
        if($profile_type_id != 4){
            return $this->_forward('notfound');
        }
        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('property_detail');
        $viewer_id     = Engine_Api::_()->user()->getViewer()->getIdentity();
        $property_id   = $this->_getParam('id');
        $propertyTable =  Engine_Api::_()->getDbtable('propertylist', 'user');
        $propertyimageTable =  Engine_Api::_()->getDbtable('propertyimages', 'user');
        $propertySelect   =   $propertyTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('plist'=>'engine4_property_list',))
                        ->joinLeft(array('country'=>'engine4_property_countries',),'plist.prty_country_id=country.country_id',array('prty_country'))
                        ->joinLeft(array('state'=>'engine4_property_states',),'plist.prty_state_id=state.state_id',array('prty_state'))
                        ->joinLeft(array('city'=>'engine4_property_city',),'plist.prty_city_id=city.city_id',array('prty_city'))
                        ->joinLeft(array('pimages'=>'engine4_property_images'),'plist.id=pimages.property_id',array('image'))
                        ->where('plist.id=?' , $property_id)
                        ->where('pimages.type=?' , 'image');

        $propertyData             = $propertyTable->fetchRow($propertySelect);
        $this->view->propertyData = $propertyData;
        $userTable                = Engine_Api::_()->getDbtable('users', 'user');
        $this->view->landlordUser = $userTable->fetchRow($userTable->select()->where('user_id = ?', $propertyData -> property_owner_id));
        $propertyGrantedTable =  Engine_Api::_()->getDbtable('propertygranted', 'user');
        //$propertyGrantedTableData = $propertyGrantedTable->fetchRow($propertyGrantedTable->select()->where('property_id = ?', $property_id,'status = ?', 1));
        $propertyGranted_select = $propertyGrantedTable->select()
                        ->where('property_id = ?', $property_id)
                        ->where('status = ?', 1);
        $propertyGrantedTableData = $propertyGrantedTable->fetchRow($propertyGranted_select);
        if(count($propertyGrantedTableData)>0){
            $this->view->is_granted = 1;
            $this->view->propertygrantedTenant = $userTable->fetchRow($userTable->select()->where('user_id = ?', $propertyGrantedTableData -> tenant_id));
        }
        else{
        $this->view->is_granted  = 0;
        $propertyRequestTable    =  Engine_Api::_()->getDbtable('propertyrequest', 'user');
        $propertyReq_select = $propertyRequestTable->select()
                              ->setIntegrityCheck(false)
                               ->from(array('prequest'=>'engine4_property_request',))
                               ->joinLeft(array('plist'=>'engine4_property_list',),'plist.id=prequest.property_id',array('property_name','rental_type'))
                               ->joinLeft(array('user'=>'engine4_users',),'prequest.tenant_id=user.user_id',array('displayname'))
                               ->where('prequest.landlord_id = ?', $viewer_id)
                               ->where('plist.id     = ?', $property_id)
                               ->where('prequest.landlord_approve    = ?', 1)
                               ->where('prequest.admin_approve   = ?', 1)
                               ->order('prequest.property_id DESC');

        $propertyRequestApproved = $propertyRequestTable->fetchAll($propertyReq_select);
        $this->view->propertyRequestApproved = $propertyRequestApproved;
       }

    $table       = Engine_Api::_()->getItemTable('user');
    $onlineTable = Engine_Api::_()->getDbtable('online', 'user');
    $tableName   = $table->info('name');
    $onlineTableName = $onlineTable->info('name');
    $viewer          = Engine_Api::_()->user()->getViewer();
    $viewerId        =   $viewer->getIdentity();
    $online_select = $table->select()
      ->from($tableName)
      ->joinRight($onlineTableName, $onlineTableName.'.user_id = '.$tableName.'.user_id', null)
      ->where($onlineTableName.'.user_id > ?', 0)
      ->where($onlineTableName.'.active > ?', new Zend_Db_Expr('DATE_SUB(NOW(),INTERVAL 20 MINUTE)'))
      ->where($tableName.'.search = ?', 1)
      ->where($tableName.'.enabled = ?', 1)
      ->where($onlineTableName.'.user_id != ?', $viewerId) // to hide logged in user from showing in member online widget
      ->order($onlineTableName.'.active DESC')
      ->group($onlineTableName.'.user_id')
      ;
     $online_users_Data=$table->fetchAll($online_select);
     $this->view->online_users =$online_users_Data;
    }

    public function completegrantedpropertyAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
        $aResult    =   array();
        $aData = $this->_request->getPost();
    try{

        $property_id          =  $aData['property_id'];
        $propertyGrantedTable =  Engine_Api::_()->getDbtable('propertygranted', 'user');
        $propertyGranted_select = $propertyGrantedTable->select()
                        ->where('property_id = ?', $property_id)
                        ->where('status = ?', 1);
        $oData = $propertyGrantedTable->fetchRow($propertyGranted_select);
        $oData->status   = 0;
        $oData->end_date = date('Y-m-d H:i:s');
        $oData->save();
        $propertyTable   =  Engine_Api::_()->getDbtable('propertylist', 'user');
        $property_select = $propertyTable->select()
                        ->where('id = ?', $property_id);
        $propertyData    = $propertyTable->fetchRow($property_select);
        $propertyData->granted       = 0;
        $propertyData->granted_date  = '';
        $propertyData->save();
        Engine_Db_Table::getDefaultAdapter()->delete('engine4_property_request', array('property_id = ?'=>$property_id , 'granted = ?'=>1) );
        $aResult['status'] = true;

    }catch (Exception $e) {exit($e->getMessage());
                                $aResult['status'] = false;
                            }
        echo json_encode($aResult);
    }

    public function rateAction(){


        if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
        if( !empty($fieldsByAlias['profile_type']) )
            {
              $optionId = $fieldsByAlias['profile_type']->getValue($viewer);
              $profile_type_id = $optionId->value;
            }
        if($profile_type_id == 6){ // service
            return $this->_forward('notfound');
        }
        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('default');
        $viewer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
        $propertyGrantedTable =  Engine_Api::_()->getDbtable('propertygranted', 'user');
        if($profile_type_id == 4){ // landlord
        $propertyGranted_select = $propertyGrantedTable->select()
                              ->setIntegrityCheck(false)
                               ->from(array('pgranted'=>'engine4_property_granted',))
                               ->joinLeft(array('plist'=>'engine4_property_list',),'plist.id=pgranted.property_id',array('property_name','rental_type','housing_type'))
                               ->joinLeft(array('user'=>'engine4_users',),'pgranted.tenant_id=user.user_id',array('displayname'))
                               ->joinLeft(array('rate'=>'engine4_rating_value',),'pgranted.tenant_id=rate.subject_id',array('rated_date','next_rating_date'))
                               ->joinLeft(array('ratelog'=>'engine4_rating_log',),'plist.id=ratelog.property_id AND pgranted.landlord_id=ratelog.subject_id',array())
                               ->where('pgranted.landlord_id = ?', $viewer_id)
                               ->where('pgranted.status = ?', 1)
                               ->where('ratelog.next_rating_date = ?', date('Y-m-d'))
                               ->group('pgranted.property_id');

        }
        if($profile_type_id == 1)   { // tenant
        $propertyGranted_select = $propertyGrantedTable->select()
                               ->setIntegrityCheck(false)
                               ->from(array('pgranted'=>'engine4_property_granted',))
                               ->joinLeft(array('plist'=>'engine4_property_list',),'plist.id=pgranted.property_id',array('property_name','rental_type','housing_type'))
                               ->joinLeft(array('user'=>'engine4_users',),'pgranted.landlord_id=user.user_id',array('displayname'))
                               ->joinLeft(array('rate'=>'engine4_rating_value',),'pgranted.landlord_id=rate.subject_id',array('rated_date','next_rating_date'))
                               ->joinLeft(array('ratelog'=>'engine4_rating_log',),'plist.id=ratelog.property_id AND pgranted.tenant_id=ratelog.subject_id',array())
                               ->where('pgranted.tenant_id = ?', $viewer_id)
                               ->where('pgranted.status = ?', 1)
                               ->where('ratelog.next_rating_date = ?', date('Y-m-d'))
                               ->group('pgranted.property_id');
        }

        $propertyGrantedDAta             = $propertyGrantedTable->fetchAll($propertyGranted_select);
        $this->view->propertyGrantedDAta = $propertyGrantedDAta;
        $this->view->profile_type        = $profile_type_id;
        $ratingquestions_table           =  Engine_Api::_()->getDbtable('ratingquestions', 'user');
        if($profile_type_id == 1){ // if tenant
        $ratingquestions_select = $ratingquestions_table->select()
                        ->where('profile_type = ?', 4);
                    }
        if($profile_type_id == 4){ // if landlord
        $ratingquestions_select = $ratingquestions_table->select()
                        ->where('profile_type = ?', 1);
                    }
        $ratingquestions_oData        = $ratingquestions_table->fetchAll($ratingquestions_select);
        $this->view->rating_questions = $ratingquestions_oData;

    }

    public function saverateAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);

        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
        $aResult    =   array();
        $aData = $this->_request->getPost();
        $star_array = $aData['star_array'];
        $qn_array   = $aData['qn_array'];
        $user_id    = $aData['user_id'];
        $profile_type    = $aData['profile_type'];
        $propertyname    = $aData['propertyname'];
        $housingtype     = $aData['housingtype'];
        $granted_date     = $aData['granted_date'];
        $propertyid    = $aData['propertyid'];

        try{
        $ratingintervalTable = Engine_Api::_()->getDbtable('ratinginterval', 'user');
        $ratingintervalTable_select =   $ratingintervalTable->fetchRow($ratingintervalTable->select());
        if($ratingintervalTable_select->days == 0){
            $ratingdays =date('Y-m-d');
        }
        else{
             $days = "+".$ratingintervalTable_select->days." days";
             $ratingdays = date('Y-m-d', strtotime($days));
        }
            $star_array    =   explode(",",$star_array);
            $qn_array      =   explode(",",$qn_array);
            $total_star    =   0;
            $cnt_qns       =   count($star_array)-1;
            // save rating for individual questions
            $ratingQuestionValueTable =  Engine_Api::_()->getDbtable('Ratingquestionsvalue', 'user');
            for($i=0;$i<$cnt_qns;$i++){
                 $total_star = $total_star+$star_array[$i];
                //echo $qn_array[$i];
                 $ratingQuestionValueTable_select = $ratingQuestionValueTable->select()
                        ->where('subject_id = ?', $viwer_id)
                        ->where('object_id = ?', $user_id)
                        ->where('question_id = ?', $qn_array[$i])
                        ->where('property_id = ?', $propertyid);
            $is_rated_qn           = $ratingQuestionValueTable->fetchRow($ratingQuestionValueTable_select);
            $ratingquestions_table =  Engine_Api::_()->getDbtable('ratingquestions', 'user');
            $ratingQuestionTable_select = $ratingquestions_table->select()
                        ->where('id = ?', $qn_array[$i]);
            $question = $ratingquestions_table->fetchRow($ratingQuestionTable_select);
            if($question->status == -1){
                if($star_array[$i] == 4){
                    $star_array[$i] =0;
                }
                elseif($star_array[$i] == 3){
                    $star_array[$i] =1;
                }
                elseif($star_array[$i] == 2){
                    $star_array[$i] =2;
                }
                elseif($star_array[$i] == 1){
                    $star_array[$i] =3;
                }
                else
                {
                    $star_array[$i] =4;
                }
            }
            if(count($is_rated_qn) >0){
                $is_rated_qn->qn_rate_value    = $star_array[$i];
                $is_rated_qn->rated_date       = date('Y-m-d');
                $is_rated_qn->next_rating_date = $ratingdays;
                $is_rated_qn->save();
            }
            else{
                 $qn_value_table_id =   $ratingQuestionValueTable->insert(array(
                    'subject_id' => $viwer_id,
                    'object_id'  => $user_id,
                    'question_id'  => $qn_array[$i],
                    'property_id'  => $propertyid,
                    'qn_rate_value'  => $star_array[$i],
                    'rated_date'  => date('Y-m-d'),
                    'next_rating_date'  => $ratingdays,
                ));
                }
            }
            $avg_star         = $total_star/ $cnt_qns;
            $ratingValueTable =  Engine_Api::_()->getDbtable('ratingvalue', 'user');
            $ratingValue_select = $ratingValueTable->select()
                        ->where('subject_id = ?', $viwer_id)
                        ->where('object_id = ?', $user_id);
            $is_rated = $ratingValueTable->fetchRow($ratingValue_select);
            if(count($is_rated)>0){
                $is_rated->rate_value = $avg_star;
                $is_rated->rated_date = date('Y-m-d');
                $is_rated->next_rating_date = $ratingdays;
                $is_rated->save();
            }
            else{
            $rating_id =   $ratingValueTable->insert(array(
                    'subject_id' => $viwer_id,
                    'object_id'  => $user_id,
                    'rate_value'  => $avg_star,
                    'rated_date'  => date('Y-m-d'),
                    'next_rating_date'  => $ratingdays,
                ));
            }
            $userTable = Engine_Api::_()->getDbtable('users', 'user');
            $objectData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $user_id));
            // find total rate of object
            $rating_select = $ratingValueTable->select()
                        ->where('object_id = ?', $user_id)
                        ->where('rated_date  != ?', '');
            $rateData = $ratingValueTable->fetchAll($rating_select);
            $total_rate =0;
            foreach($rateData as $data){
                $total_rate     = $total_rate + $data['rate_value'];
            }
             $average_total_rate               = $total_rate/count($rateData);
             $objectData->rating_value        =   $average_total_rate;
             $objectData->enable_rating_value =   1;
             $objectData->save();
            // entry for rating log table
        $ratinglogTable =  Engine_Api::_()->getDbtable('ratinglog', 'user');
        $ratinglog_select = $ratinglogTable->select()
                        ->where('property_id = ?', $propertyid)
                        ->where('subject_id = ?', $viwer_id);
        $ratinglogData = $ratinglogTable->fetchRow($ratinglog_select);
            $ratinglogData -> next_rating_date = $ratingdays;
            $ratinglogData -> save();
        /******mail to object***/

        //rating for individual questions
        $ratingQuestionValueTable_select = $ratingQuestionValueTable->select()
                               ->setIntegrityCheck(false)
                               ->from(array('rating_qn_value'=>'engine4_rating_questionsvalue',))
                               ->joinLeft(array('rating_qns'=>'engine4_rating_questions',),'rating_qn_value.question_id=rating_qns.id',array('questions',))
                               ->where('rating_qn_value.subject_id = ?', $viwer_id)
                               ->where('rating_qn_value.object_id = ?', $user_id);

        $rated_qns = $ratingQuestionValueTable->fetchAll($ratingQuestionValueTable_select);
        if($profile_type == 1){
        $text_msg = ' who\'s '.$housingtype.' '.'<a href="http://'.$_SERVER['HTTP_HOST'].'/property/'.$propertyid.'">'.$propertyname.'</a> you have rented since '.$granted_date.'. Here\'s the report in detail.';
        }
        if($profile_type == 4){
        $text_msg = ' who have rented your '.$housingtype.' '.'<a href="http://'.$_SERVER['HTTP_HOST'].'/property/'.$propertyid.'">'.$propertyname.'</a> since '.$granted_date.'. Here\'s the report in detail.';
        }
        $qn_msg   = '';
        foreach($rated_qns as $qns){
            $qn_msg = $qn_msg. 'Question: ' .$qns['questions'] .'<br><br>' ;
            $qn_msg = $qn_msg. ' Star: ' .$qns['qn_rate_value'].'<br><br>';
        }
            $from_email    = Engine_Api::_()->getApi('settings', 'core')->core_mail_from;
                $object_name     = $objectData->displayname;
                $object_email    = $objectData->email;
                $subject_name    = $viewer->displayname;
                $rating_value    = $avg_star;
                $text_message    = $text_msg;
                $question_message    = $qn_msg;
                $red_url = $_SERVER['HTTP_HOST'];
                         $bodyTextContent = '';
                         if (file_exists("emailtemplates/notify_rated_value_email.html")) {
                            $htmlExist = true;
                            $file = fopen("emailtemplates/notify_rated_value_email.html", "r");
                            while(!feof($file))
                            {
                                $bodyTextContent .= fgets($file);
                            }
                            fclose($file);
                        }
                            if($htmlExist){
                              $objectname='{objectname}';
                              $objectemail='{objectemail}';
                              $subjectname='{subjectname}';
                              $textmessage='{textmessage}';
                              $questionmessage='{questionmessage}';
                              $redurl='{redurl}';
                              $ratingvalue ='{ratingvalue}';
                              $bodyTextTemplate = '';
                              $bodyHtmlTemplate = $bodyTextContent;

                          foreach( $rParams as $var => $val ) {
                              $raw = trim($var, '[]');
                              $var = '[' . $var . ']';
                              if( !$val ) {
                                $val = $var;
                              }
                              // Fix nbsp
                              $val = str_replace('&amp;nbsp;', ' ', $val);
                              $val = str_replace('&nbsp;', ' ', $val);
                              // Replace

                             $bodyTextTemplate = str_replace($var, $val, $bodyTextTemplate);
                             $bodyHtmlTemplate = str_replace($var, $val, $bodyHtmlTemplate);
                            }
                            $bodyTextTemplate = strip_tags($bodyTextTemplate);
                            $bodyHtmlTemplate = str_replace($objectname, $object_name, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($objectemail, $object_email, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($subjectname, $subject_name, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($ratingvalue, $rating_value, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($textmessage, $text_message, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($questionmessage, $question_message, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($redurl, $red_url, $bodyHtmlTemplate);

                         }
                    $subject = "Profile Rating";
                    $header  = "From: ".'Rentstarz'." <".$from_email.">\r\n";
                    $header .= "MIME-Version: 1.0\r\n";
                    $header .= 'Content-type: text/html; charset=iso-8859-1' ."\"\r\n\r\n";
                    mail($object_email, $subject, $bodyHtmlTemplate, $header);
    // send notification

     Engine_Api::_()->getDbtable('notifications', 'activity')
            ->addNotification($objectData, $viewer, $objectData, 'profile_rate',array(
          'label' => $avg_star,'pid' => $propertyid ,'pname'=> $propertyname));
    $aResult['status'] = true;

    }catch (Exception $e) {exit($e->getMessage());
                                $aResult['status'] = false;
                            }
        echo json_encode($aResult);
    }

    public function cancelrateAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
        $aResult    =   array();
        $ratingintervalTable = Engine_Api::_()->getDbtable('ratinginterval', 'user');
        $ratingintervalTable_select =   $ratingintervalTable->fetchRow($ratingintervalTable->select());
        if($ratingintervalTable_select->days ==0){
            $ratingdays =date('Y-m-d');
        }
        else{
             $days = "+".$ratingintervalTable_select->days." days";
             $ratingdays = date('Y-m-d', strtotime($days));
        }
        $ratingValueTable =  Engine_Api::_()->getDbtable('ratingvalue', 'user');
        $ratingValue_select = $ratingValueTable->select()
                        ->where('subject_id = ?', $viewer -> getIdentity())
                        ->where('next_rating_date = ?', date('Y-m-d'));
        $ratedData = $ratingValueTable->fetchAll($ratingValue_select);
        foreach($ratedData as $data){
            $rated_row = $ratingValueTable->fetchRow($ratingValueTable->select()->where('id = ?', $data['id']));
            $rated_row->next_rating_date = $ratingdays;
            $rated_row->save();
        }
        $aResult['status'] = true;
        echo json_encode($aResult);
    }

    public function ratebyindividualuserAction(){

        if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
        if( !empty($fieldsByAlias['profile_type']) )
            {
              $optionId = $fieldsByAlias['profile_type']->getValue($viewer);
              $profile_type_id = $optionId->value;
            }
        if($profile_type_id == 6){ // service
            return $this->_forward('notfound');
        }
        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('default');
        $viewer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
        $ratedby_user_id = $this->_getParam('id');
        $propertyId = $this->_getParam('pid');
        if($propertyId){
        //rating for individual questions
        $ratingQuestionValueTable =  Engine_Api::_()->getDbtable('Ratingquestionsvalue', 'user');
        $ratingQuestionValueTable_select = $ratingQuestionValueTable->select()
                               ->setIntegrityCheck(false)
                               ->from(array('rating_qn_value'=>'engine4_rating_questionsvalue',))
                               ->joinLeft(array('rating_qns'=>'engine4_rating_questions',),'rating_qn_value.question_id=rating_qns.id',array('questions',))
                               ->where('rating_qn_value.object_id = ?', $viewer_id)
                               ->where('rating_qn_value.subject_id = ?', $ratedby_user_id)
                               ->where('rating_qn_value.property_id  = ?', $propertyId);
        $rated_qns = $ratingQuestionValueTable->fetchAll($ratingQuestionValueTable_select);
        if(count($rated_qns) == 0){
            return $this->_forward('notfound');
        }

        $propertyTable =  Engine_Api::_()->getDbtable('propertylist', 'user');
        $this->view->propertyData = $propertyTable->fetchRow($propertyTable->select()->where('id = ?', $propertyId));
        $this->view->rated_qns = $rated_qns;
        $this->view->viewerdetails =  $viewer;
        $userTable = Engine_Api::_()->getDbtable('users', 'user');
        $ratedbyuserData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $ratedby_user_id));
        $this->view->ratedbyuserData =  $ratedbyuserData;
	}
	else{
		 return $this->_forward('notfound');
	}
    }

    public function getcoverletterAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
        $aResult    =   array();
        $aResult    =   array();
        $aData = $this->_request->getPost();
        $tenantid = $aData['tenant_id'];

        $coverletter_table =  Engine_Api::_()->getDbtable('coverletter', 'user');

        $coverletter_select = $coverletter_table->select()
                                  ->setIntegrityCheck(false)
                                  ->from(array('cover'=>'engine4_cover_letter',))
                                  ->joinLeft(array('fields'=>'engine4_user_fields_values'),'fields.value=cover.id',array('value'))
                                  ->where('fields.item_id        = ?', $tenantid)
                                  ->where('fields.field_id       = ?', 66);

        $coverData = $coverletter_table->fetchRow($coverletter_select);
        $this->view->coverData =  $coverData;

        $content ='';
        if(count($coverData)>0){
            $aResult['status'] = true;
            $content = $content.'<div class="pop_up_title"><div class="div_attachment_title">Cover Letter</div><div class="div_attachment_cancel"><img src="/application/modules/User/externals/images/GREYcancel.png"></div></div>';
            $content = $content.'<div class="popup_content">';
            $content = $content.'<div class="confirm_text">'.$coverData->content.'</div>';
            $content = $content.'</div></div>';
            $aResult['html'] = $content;
        }
        else{
            $aResult['status'] = false;
            $aResult['html'] = $content;
        }

        echo json_encode($aResult);
    }

    public function getbioAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
        $aResult    =   array();
        $aResult    =   array();
        $aData = $this->_request->getPost();
        $tenantid = $aData['tenant_id'];
        $userTable = Engine_Api::_()->getDbtable('users', 'user');
        $bio_select = $userTable->select()
                                  ->setIntegrityCheck(false)
                                  ->from(array('user'=>'engine4_users',))
                                  ->joinLeft(array('fields'=>'engine4_user_fields_values'),'fields.item_id=user.user_id',array('value'))
                                  ->where('fields.item_id        = ?', $tenantid)
                                  ->where('fields.field_id       = ?', 13);

        $bioData = $userTable->fetchRow($bio_select);
        $this->view->bioData =  $bioData;
        $content ='';

        if(count($bioData)>0){

            $aResult['status'] = true;
            $content = $content.'<div class="pop_up_title"><div class="div_attachment_title">Bio</div><div class="div_attachment_cancel"><img src="/application/modules/User/externals/images/GREYcancel.png"></div></div>';
            $content = $content.'<div class="popup_content">';
            $content = $content.'<div class="confirm_text">'.$bioData->value.'</div>';
            $content = $content.'</div></div>';
            $aResult['html'] = $content;
        }
        else{
            $aResult['status'] = false;
            $aResult['html'] = $content;
        }

        echo json_encode($aResult);
    }

    public function propertyrequirementAction(){


        if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
        if( !empty($fieldsByAlias['profile_type']) )
        {
           $optionId = $fieldsByAlias['profile_type']->getValue($viewer);
           $profile_type_id = $optionId->value;
        }
        if($profile_type_id != 1){
        return $this->_forward('notfound');

        }
        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('property_detail');
        $this->view->metaTitle        = 'Property Reqirement Form';

    }

    public function savepropertyrequirementAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();

        $aData = $this->_request->getPost();
    //    echo $aData['accept_vouchers'];exit;
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viewer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
        $aResult=array();

        $aResult=array();
        $propertyRequirementTable =  Engine_Api::_()->getDbtable('propertyrequirement', 'user');
        $propertycountrtyTable  =  Engine_Api::_()->getDbtable('propertycountry', 'user');
        $propertystateTable     =  Engine_Api::_()->getDbtable('propertystate', 'user');
        $propertycityable       =  Engine_Api::_()->getDbtable('propertycity', 'user');

        try{
        $propertycountryData = $propertycountrtyTable->fetchRow($propertycountrtyTable->select()->where('prty_country = ?', $aData['prty_country']));

               if(count($propertycountryData) == 0){
                    $propertycountryid=   $propertycountrtyTable->insert(array(
                    'prty_country'  => $aData['prty_country']
                    ));
                }
                else{
                    $propertycountryid =  $propertycountryData->country_id;
                }
                $propertystateDataSelect = $propertystateTable->select()
                    ->where('country_id = ?', $propertycountryid)
                    ->where('prty_state = ?', $aData['prty_state']);

                $propertystateData = $propertystateTable->fetchRow($propertystateDataSelect);
                if(count($propertystateData) == 0){
                    $propertystateid=   $propertystateTable->insert(array(
                    'country_id'  => $propertycountryid,
                    'prty_state'  => $aData['prty_state']
                    ));
                }
                else{
                    $propertystateid =  $propertystateData->state_id;
                }
                $propertycityDataSelect = $propertycityable->select()
                    ->where('country_id = ?', $propertycountryid)
                    ->where('state_id = ?',   $propertystateid)
                    ->where('prty_city = ?',  $aData['prty_city']);

                $propertycityData = $propertycityable->fetchRow($propertycityDataSelect);
                if(count($propertycityData) == 0){
                    $propertycityid=   $propertycityable->insert(array(
                    'country_id'  => $propertycountryid,
                    'state_id'    => $propertystateid,
                    'prty_city'   => $aData['prty_city'],
                    'zipcode'     => $aData['prty_zipcode'],
                    'latitude'    => $aData['prty_latitude'],
                    'longitude'   => $aData['prty_longitude']

                    ));
                }
                else{
                    $propertycityid =  $propertycityData->city_id;
                }

        $body = "is <span class='feed_propertyrequirement_status'>Looking for ".$aData['housing_type']." to ".$aData['rental_type']."</span>";

        $type = 'property_requirement';
        $action = Engine_Api::_()->getDbtable('actions', 'activity')->addActivity($viewer, $viewer, $type, $body);

        $propertyreqirementid=   $propertyRequirementTable->insert(array(

                    'tenant_id'          => $viewer_id,
                    'action_id'          => $action->action_id,
                    'country_id'         => $propertycountryid,
                    'state_id'           => $propertystateid,
                    'city_id'            => $propertycityid,
                    'county'             => $aData['county'],
                    'neighborhood'       => $aData['neighborhood'],
                    'zip'                => $aData['prty_zipcode'],
                    'description'        => $aData['req_description'],
                    'rental_type'        => $aData['rental_type'],
                    'vouchers'           => $aData['accept_vouchers'],
                    'wheelchair_accessible' => $aData['wheel_chair_accessible'],
                    'provide_parking'    => $aData['parking'],
                    'budget'             => $aData['price'],
                    'budget_range_from'  => $aData['price_range_from'],
                    'budget_range_to'    => $aData['price_range_to'],
                    'no_of_rooms'        => $aData['number_of_rooms'],
                    'housing_type'       => $aData['housing_type'],
                    'pets_allowed'       => $aData['allowed_pets'],
                    'pets_type'          => $aData['pets_type'],
                    'created_at'         => date('Y-m-d H:i:s'),

                ));
            $aResult['status'] = true;
        }catch (Exception $e) {exit($e->getMessage());
                                $aResult['status'] = false;
                            }

    echo json_encode($aResult);
    }

    public function getmachingpropertiesAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

    $this->_helper->viewRenderer->setNoRender(true);
    $this->_helper->layout->disableLayout();
    $aResult=array();

    $propertyRequirementTable =  Engine_Api::_()->getDbtable('propertyrequirement', 'user');
    $propertyTable =  Engine_Api::_()->getDbtable('propertylist', 'user');

    $propertymachingSelect =   $propertyTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('plist'=>'engine4_property_list'))
                        ->joinLeft(array('user'=>'engine4_users',),'plist.property_owner_id=user.user_id',array('displayname'))
                        ->joinRight(array('prty_req'=>'engine4_property_requirement'),'plist.prty_country_id=prty_req.country_id AND plist.prty_state_id=prty_req.state_id AND
                        plist.  prty_city_id    =prty_req.city_id AND
                        (plist.price=prty_req.budget OR (plist.price BETWEEN prty_req.budget AND prty_req.budget_range_to))',array('tenant_id','budget','budget_range_to'))
                        ->where('(plist.enable = ?', 1)
                        ->orWhere('user.bg_verified  = ?)', 1)
                        ->where('plist.landlord_enable=?' ,  1)
                        ->order('plist.id DESC');

    $propertymachingData=$propertyTable->fetchAll($propertymachingSelect);
    $userTable = Engine_Api::_()->getDbtable('users', 'user');
    $PropertymatchinglogTable = Engine_Api::_()->getDbtable('Propertymatchinglog', 'user');
    foreach($propertymachingData as $data){
            $propertymaching_lists[$data['tenant_id']][] =array('tenant_id' =>$data['tenant_id'],'landlord_id' => $data['property_owner_id'],'property_id'=>$data['id'],'property_name'=>$data->property_name);
    }   //echo '<pre>'; print_r($propertymaching_lists); exit;


    foreach($propertymaching_lists as $key => $value){
        $arr = array();
        $mailcontent = '';
        for($i=0;$i<count($value);$i++){
            $landlordData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $value[$i]['landlord_id']));
            $landlordName = $landlordData->displayname;

            $propertymatchinglogData = $PropertymatchinglogTable->getAdapter()->select()
                        ->from(array('log'=>'engine4_propertymatching_log',))
                        ->where('log.tenant_id = ?', $key)
                        ->where('log.property_id = ?', $value[$i]['property_id'])
                        ->query()->fetchAll();
            if(count($propertymatchinglogData) == 0 ){
                $mailcontent = $mailcontent.$landlordName. ' has added a property <a href="http://'.$_SERVER['HTTP_HOST'].'/property/'.$value[$i]['property_id'].'">'.$value[$i]['property_name'].'</a> that matches with your requirement <br><br>';

                $PropertymatchinglogTableId=   $PropertymatchinglogTable->insert(array(

                            'tenant_id' => $value[$i]['tenant_id'],
                            'property_id' => $value[$i]['property_id'],
                            'created_at' => date('Y-m-d'),
                        ));
                // send notification
            $tenantData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $key));
            Engine_Api::_()->getDbtable('notifications', 'activity')
                ->addNotification($tenantData, $landlordData, $tenantData, 'matching_property',array(
              'label' => $value[$i]['property_name'],'pid' => $value[$i]['property_id']));
            }
        }
        if($mailcontent !=''){
                    $from_email    = Engine_Api::_()->getApi('settings', 'core')->core_mail_from;
                    $tenantData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $key));
                    $tenantName  =  $tenantData->displayname;
                    $tenantEmail =  $tenantData->email;
        $bodyTextContent = '';

                         if (file_exists("emailtemplates/property_matching_email.html")) {
                            $htmlExist = true;
                            $file = fopen("emailtemplates/property_matching_email.html", "r");
                            while(!feof($file))
                            {
                                $bodyTextContent .= fgets($file);
                            }
                            fclose($file);
                        }
                        if($htmlExist){
                              $tenantname='{tenantname}';
                              $content='{content}';
                              $bodyTextTemplate = '';
                              $bodyHtmlTemplate = $bodyTextContent;


                          foreach( $rParams as $var => $val ) {
                              $raw = trim($var, '[]');
                              $var = '[' . $var . ']';
                              if( !$val ) {
                                $val = $var;
                              }
                              // Fix nbsp
                              $val = str_replace('&amp;nbsp;', ' ', $val);
                              $val = str_replace('&nbsp;', ' ', $val);
                              // Replace
                             $bodyTextTemplate = str_replace($var, $val, $bodyTextTemplate);
                             $bodyHtmlTemplate = str_replace($var, $val, $bodyHtmlTemplate);
                            }
                            $bodyTextTemplate = strip_tags($bodyTextTemplate);

                            $bodyHtmlTemplate = str_replace($tenantname, $tenantName, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($content, $mailcontent, $bodyHtmlTemplate);

                        }
                    $subject = "Rentstarz matching properties";
                    $header  = "From: ".'Rentstarz'." <".$from_email.">\r\n";
                    $header .= "MIME-Version: 1.0\r\n";
                    $header .= 'Content-type: text/html; charset=iso-8859-1' ."\"\r\n\r\n";
                    mail($tenantEmail, $subject, $bodyHtmlTemplate, $header);
        }
    }

    // entry for cron log

    $cronlogTable =  Engine_Api::_()->getDbtable('cronlog', 'user');
    $cronlogData = $cronlogTable->fetchRow($cronlogTable->select()->where('type = ?', 'matching_properties'));
    if(count($cronlogData) > 0){
        $cronlogData->execution_count = $cronlogData->execution_count +1;
        $cronlogData->created_at = date('Y-m-d');
        $cronlogData->save();
    }
    else{
    $cronlogTableId=   $cronlogTable->insert(array(
                            'type' => 'matching_properties',
                            'execution_count' => 1,
                            'created_at' => date('Y-m-d'),

                        ));
    }
        exit("success");

    }

    public function editrequirementAction(){

        if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('property_detail');
        $viewer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
        $id=$this->_getParam('id');
        if($id){
        $propertyRequirementTable =  Engine_Api::_()->getDbtable('propertyrequirement', 'user');
        $propertyRequirementSelect   =   $propertyRequirementTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('property_req'=>'engine4_property_requirement',))
                        ->joinLeft(array('country'=>'engine4_property_countries',),'property_req.country_id=country.country_id',array('prty_country'))
                        ->joinLeft(array('state'=>'engine4_property_states',),'property_req.state_id=state.state_id',array('prty_state'))
                        ->joinLeft(array('city'=>'engine4_property_city',),'property_req.city_id=city.city_id',array('prty_city','zipcode','latitude','longitude'))
                        ->where('property_req.id=?' ,  $id);
        $propertyRequirementData=$propertyRequirementTable->fetchRow($propertyRequirementSelect);
        if($propertyRequirementData->tenant_id != $viewer_id){ return $this->_forward('notfound');}
        
        $this->view->propertyRequirementData = $propertyRequirementData;
	   }
	   else{
		    return $this->_forward('notfound');
	   }

    }

    public function saveedittedrequirementAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        $aData = $this->_request->getPost();
        $propertyRequirementTable =  Engine_Api::_()->getDbtable('propertyrequirement', 'user');
        $propertycountrtyTable  =  Engine_Api::_()->getDbtable('propertycountry', 'user');
        $propertystateTable     =  Engine_Api::_()->getDbtable('propertystate', 'user');
        $propertycityable       =  Engine_Api::_()->getDbtable('propertycity', 'user');

        $propertyRequirementData = $propertyRequirementTable->fetchRow($propertyRequirementTable->select()->where('id = ?', $aData['id']));

        if($aData){
            $propertycountryData = $propertycountrtyTable->fetchRow($propertycountrtyTable->select()->where('prty_country = ?', $aData['prty_country']));

                if(count($propertycountryData) == 0){
                    $propertycountryid=   $propertycountrtyTable->insert(array(
                    'prty_country'  => $aData['prty_country']
                    ));
                }
                else{
                    $propertycountryid =  $propertycountryData->country_id;
                }
                $propertystateDataSelect = $propertystateTable->select()
                    ->where('country_id = ?', $propertycountryid)
                    ->where('prty_state = ?', $aData['prty_state']);

                $propertystateData = $propertystateTable->fetchRow($propertystateDataSelect);

                if(count($propertystateData) == 0){

                    $propertystateid=   $propertystateTable->insert(array(

                    'country_id'  => $propertycountryid,
                    'prty_state'  => $aData['prty_state']

                    ));
                }
                else{
                    $propertystateid =  $propertystateData->state_id;
                }

                $propertycityDataSelect = $propertycityable->select()
                    ->where('country_id = ?', $propertycountryid)
                    ->where('state_id = ?',   $propertystateid)
                    ->where('prty_city = ?',  $aData['prty_city']);

                $propertycityData = $propertycityable->fetchRow($propertycityDataSelect);

                if(count($propertycityData) == 0){

                    $propertycityid=   $propertycityable->insert(array(

                    'country_id'  => $propertycountryid,
                    'state_id'    => $propertystateid,
                    'prty_city'   => $aData['prty_city'],
                    'zipcode'     => $aData['prty_zipcode'],
                    'latitude'    => $aData['prty_latitude'],
                    'longitude'   => $aData['prty_longitude']

                    ));

                }
                else{
                    $propertycityid =  $propertycityData->city_id;
                }

            $propertyRequirementData->country_id       = $aData['country'];
            $propertyRequirementData->state_id         = $aData['state'];
            $propertyRequirementData->city_id          = $aData['city'];
            $propertyRequirementData->county           = $aData['county'];
            $propertyRequirementData->neighborhood     = $aData['neighborhood'];
            $propertyRequirementData->zip              = $aData['prty_zipcode'];
            $propertyRequirementData->country_id       = $propertycountryid;
            $propertyRequirementData->state_id         = $propertystateid;
            $propertyRequirementData->city_id          = $propertycityid;
            $propertyRequirementData->pets_allowed     = $aData['allowed_pets'];
            $propertyRequirementData->pets_type        = $aData['pets_type'];
            $propertyRequirementData->rental_type      = $aData['rental_type'];
            $propertyRequirementData->description      = $aData['req_description'];

            $propertyRequirementData->vouchers      = $aData['accept_vouchers'];
            $propertyRequirementData->wheelchair_accessible      = $aData['wheel_chair_accessible'];
            $propertyRequirementData->provide_parking      = $aData['parking'];

            $propertyRequirementData->housing_type     = $aData['housing_type'];
            $propertyRequirementData->no_of_rooms      = $aData['number_of_rooms'];
            $propertyRequirementData->budget           = $aData['price'];
            $propertyRequirementData->budget_range_from     = $aData['price_range_from'];
            $propertyRequirementData->budget_range_to       = $aData['price_range_to'];

            if($propertyRequirementData->save()){

                $aResult['status'] = true;

            }
            else{
                $aResult['status'] = false;
            }


        }
        echo json_encode($aResult);
    }

    public function propertyviewlogAction(){

        if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('default');
        $viewer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
        date_default_timezone_set($viewer->timezone);
        $property_id        =   $this->_getParam('id');

        $propertyTable =  Engine_Api::_()->getDbtable('propertylist', 'user');
        $propertyimageTable =  Engine_Api::_()->getDbtable('propertyimages', 'user');
        $propertyRequestTable =  Engine_Api::_()->getDbtable('propertyrequest', 'user');
        $userTable = Engine_Api::_()->getDbtable('users', 'user');


       $propertySelect   =   $propertyTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('plist'=>'engine4_property_list',))
                        ->joinLeft(array('user'=>'engine4_users'),'plist.property_owner_id=user.user_id',array('bg_verified'))
                        ->joinLeft(array('country'=>'engine4_property_countries',),'plist.prty_country_id=country.country_id',array('prty_country'))
                        ->joinLeft(array('state'=>'engine4_property_states',),'plist.prty_state_id=state.state_id',array('prty_state'))
                        ->joinLeft(array('city'=>'engine4_property_city',),'plist.prty_city_id=city.city_id',array('prty_city'))
                        ->joinLeft(array('pimages'=>'engine4_property_images'),'plist.id=pimages.property_id',array('image'))
                        ->where('plist.id=?' , $property_id)
                        ->where('pimages.type=?' , 'image');
                        //->where('plist.enable=?' , 1);

        $this->view->propertyData = $propertyData =$propertyTable->fetchRow($propertySelect);


        $this->view->landlordUser = $userTable->fetchRow($userTable->select()->where('user_id = ?', $propertyData -> property_owner_id));

        $propertyViewLogTable =  Engine_Api::_()->getDbtable('propertyviewlog', 'user');

        $propertyViewLog_select = $propertyViewLogTable->select()
                    ->where('property_id = ?', $property_id);

        $this->view->propertyViewLogData = $propertyViewLogData = $propertyRequestTable->fetchAll($propertyViewLog_select);
    }

    public function tenantpropertyrequestlistAction() {

        if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('property_detail');
        $viewer        = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
        if( !empty($fieldsByAlias['profile_type']) )
            {
              $optionId        = $fieldsByAlias['profile_type']->getValue($viewer);
              $profile_type_id = $optionId->value;
            }
       if($profile_type_id !=1){
           return $this->_forward('notfound');
       }
       $viewer_id             = Engine_Api::_()->user()->getViewer()->getIdentity();
       $propertyRequestTable  =  Engine_Api::_()->getDbtable('propertyrequest', 'user');
       $propertyReq_select    = $propertyRequestTable->select()
                               ->setIntegrityCheck(false)
                               ->from(array('prequest'=>'engine4_property_request',))
                               ->joinLeft(array('plist'=>'engine4_property_list',),'plist.id=prequest.property_id',array('property_owner_id','property_name','rental_type','granted','no_of_rooms','housing_type','has_pets','pets_type','price'))
                               ->joinLeft(array('pimages'=>'engine4_property_images'),'plist.id=pimages.property_id',array('image'))
                               ->joinLeft(array('country'=>'engine4_property_countries',),'plist.prty_country_id=country.country_id',array('prty_country'))
                               ->joinLeft(array('state'=>'engine4_property_states',),'plist.prty_state_id=state.state_id',array('prty_state'))
                               ->joinLeft(array('city'=>'engine4_property_city',),'plist.prty_city_id=city.city_id',array('prty_city','latitude','longitude'))
                               ->joinLeft(array('user'=>'engine4_users'),'plist.property_owner_id=user.user_id',null)
                               ->where('prequest.tenant_id = ?', $viewer_id)
                               ->order('prequest.id DESC')
                               ->group('plist.id');

       $propertyRequest                 = $propertyRequestTable->fetchAll($propertyReq_select);
       $this->view->propertyRequestList = $propertyRequest;
       $table                           = Engine_Api::_()->getItemTable('user');
       $onlineTable                     = Engine_Api::_()->getDbtable('online', 'user');
       $tableName                       = $table->info('name');
       $onlineTableName                 = $onlineTable->info('name');
       $viewer                          = Engine_Api::_()->user()->getViewer();
       $viewerId                        = $viewer->getIdentity();

       $online_select = $table->select()
                  ->from($tableName)
                  ->joinRight($onlineTableName, $onlineTableName.'.user_id = '.$tableName.'.user_id', null)
                  ->where($onlineTableName.'.user_id > ?', 0)
                  ->where($onlineTableName.'.active > ?', new Zend_Db_Expr('DATE_SUB(NOW(),INTERVAL 20 MINUTE)'))
                  ->where($tableName.'.search = ?', 1)
                  ->where($tableName.'.enabled = ?', 1)
                  ->where($onlineTableName.'.user_id != ?', $viewerId) // to hide logged in user from showing in member online widget
                  ->order($onlineTableName.'.active DESC')
                  ->group($onlineTableName.'.user_id')
                  ;
     $online_users_Data                  =  $table->fetchAll($online_select);
     $this->view->online_users           =  $online_users_Data;
     $rentalApplicationsTable            =  Engine_Api::_()->getDbtable('rentalapplications', 'user');
     $this->view->rentalApplicationsData =  $rentalApplicationsData = $rentalApplicationsTable->fetchRow($rentalApplicationsTable->select()->where('tenant_id = ?', $viewerId));

    }

    public function tenantpropertyapprovedAction() {

        if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('property_detail');
        $viewer        = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
        if( !empty($fieldsByAlias['profile_type']) )
            {
              $optionId        = $fieldsByAlias['profile_type']->getValue($viewer);
              $profile_type_id = $optionId->value;
            }
        if($profile_type_id !=1){
           return $this->_forward('notfound');
        }
        $viewer_id            =   Engine_Api::_()->user()->getViewer()->getIdentity();
        $propertyRequestTable =  Engine_Api::_()->getDbtable('propertyrequest', 'user');
        $propertyReq_select   = $propertyRequestTable->select()
                              ->setIntegrityCheck(false)
                               ->from(array('prequest'=>'engine4_property_request',))
                               ->joinLeft(array('plist'=>'engine4_property_list',),'plist.id=prequest.property_id')
                               ->joinLeft(array('pimages'=>'engine4_property_images'),'plist.id=pimages.property_id',array('image'))
                               ->joinLeft(array('country'=>'engine4_property_countries',),'plist.prty_country_id=country.country_id',array('prty_country'))
                               ->joinLeft(array('state'=>'engine4_property_states',),'plist.prty_state_id=state.state_id',array('prty_state'))
                               ->joinLeft(array('city'=>'engine4_property_city',),'plist.prty_city_id=city.city_id',array('prty_city','latitude','longitude'))
                               ->joinLeft(array('user'=>'engine4_users'),'plist.property_owner_id=user.user_id',null)
                               ->joinLeft(array('smartmoveapi_application'=>'engine4_smartmoveapi_application'),'smartmoveapi_application.rental_application_id=prequest.id',array('SmartmoveApplicationId','ApplicationStatus','IdmaVerificationStatus','rental_application_id'))
                               ->joinLeft(array('smartmoveapi_report'=>'engine4_smartmoveapi_report'),'smartmoveapi_report. SmartmoveApplicationId=smartmoveapi_application.SmartmoveApplicationId',array('isReportRequest','isPaid','updated_at','reportResponse'))
                               ->where('prequest.tenant_id = ?', $viewer_id)
                               ->where('prequest.landlord_approve    = ?', 1)
                               ->where('prequest.admin_approve   = ?', 1)
                               ->order('prequest.id DESC')
                               ->group('plist.id');

        $propertyRequest                 = $propertyRequestTable->fetchAll($propertyReq_select);
        $this->view->propertyRequestList = $propertyRequest;
        $table                           = Engine_Api::_()->getItemTable('user');
        $onlineTable                     = Engine_Api::_()->getDbtable('online', 'user');
        $tableName                       = $table->info('name');
        $onlineTableName                 = $onlineTable->info('name');
        $viewer                          = Engine_Api::_()->user()->getViewer();
        $viewerId                        =   $viewer->getIdentity();

        $online_select                   = $table->select()
                                          ->from($tableName)
                                          ->joinRight($onlineTableName, $onlineTableName.'.user_id = '.$tableName.'.user_id', null)
                                          ->where($onlineTableName.'.user_id > ?', 0)
                                          ->where($onlineTableName.'.active > ?', new Zend_Db_Expr('DATE_SUB(NOW(),INTERVAL 20 MINUTE)'))
                                          ->where($tableName.'.search = ?', 1)
                                          ->where($tableName.'.enabled = ?', 1)
                                          ->where($onlineTableName.'.user_id != ?', $viewerId) // to hide logged in user from showing in member online widget
                                          ->order($onlineTableName.'.active DESC')
                                          ->group($onlineTableName.'.user_id')
                                          ;
      $online_users_Data                  =    $table->fetchAll($online_select);
      $this->view->online_users           =    $online_users_Data;
      $StripeSettingsTable                =  Engine_Api::_()->getDbtable('Stripesettings', 'user');
      $this->view->StripeSettingsData     = $StripeSettingsTable->fetchRow($StripeSettingsTable->select());
      $rentalApplicationsTable            =  Engine_Api::_()->getDbtable('rentalapplications', 'user');
      $this->view->rentalApplicationsData = $rentalApplicationsData = $rentalApplicationsTable->fetchRow($rentalApplicationsTable->select()->where('tenant_id = ?', $viewerId));

    }

    public function getpropertycountriesAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

      $this->_helper->layout->disableLayout();
      $this->_helper->viewRenderer->setNoRender(true);
      $aResult         =  array();
      $country_table   =  Engine_Api::_()->getDbtable('propertycountry', 'user');
      $country_list    = $country_table->fetchAll();
      $i=0;
      foreach($country_list as $list)
     {
            $aResult[$i]['id']      =   $list['country_id'];
            $aResult[$i]['country'] =   $list['prty_country'];
            $i++;
     }
     echo json_encode($aResult);

    }

    public function getpropertystatesAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

      $this->_helper->layout->disableLayout();
      $this->_helper->viewRenderer->setNoRender(true);
      $aResult  =   array();
      $id   =   $this->_getParam('countryId');
      if($id){

		  $state_table   = Engine_Api::_()->getDbtable('propertystate', 'user');
		  $state_list = $state_table->fetchAll(array(
		  'country_id = ?' => $id,
		));
		$i=0;
		foreach($state_list as $list)
		{
			$aResult[$i]['id']      =   $list['state_id'];
			$aResult[$i]['state']   =   $list['prty_state'];
			$i++;
		}
     }
	else{
		$aResult['status'] = false;
	}
    echo json_encode($aResult);
    }

    public function getpropertycityAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

      $this->_helper->layout->disableLayout();
      $this->_helper->viewRenderer->setNoRender(true);
      $aResult      =   array();
      $id           =   $this->_getParam('stateId');
      if($id){
		  $city_table   =  Engine_Api::_()->getDbtable('propertycity', 'user');
		  $city_list    = $city_table->fetchAll(array(
							  'state_id = ?' => $id,
							));
		  $i=0;
		 foreach($city_list as $list)
			{
				$aResult[$i]['id']  =   $list['city_id'];
				$aResult[$i]['city']    =   $list['prty_city'];
				$i++;
			}
	 }else{
		$aResult['status'] = false;
	}
     echo json_encode($aResult);
    }


    public function propertymapAction(){

        if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('default');
        $viewer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
        $property_id        =  $this->_getParam('id');
        $viewer             =  Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $propertyTable      =  Engine_Api::_()->getDbtable('propertylist', 'user');
        $propertySelect     =  $propertyTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('plist'=>'engine4_property_list',))
                        ->joinLeft(array('user'=>'engine4_users'),'plist.property_owner_id=user.user_id',array('bg_verified'))
                        ->joinLeft(array('country'=>'engine4_property_countries',),'plist.prty_country_id=country.country_id',array('prty_country'))
                        ->joinLeft(array('state'=>'engine4_property_states',),'plist.prty_state_id=state.state_id',array('prty_state'))
                        ->joinLeft(array('city'=>'engine4_property_city',),'plist.prty_city_id=city.city_id',array('prty_city','latitude','longitude'))
                        ->joinLeft(array('pimages'=>'engine4_property_images'),'plist.id=pimages.property_id',array('image'))
                        ->where('plist.id=?' , $property_id)
                        ->where('pimages.type=?' , 'image');
        $propertyData     =  $propertyTable->fetchRow($propertySelect);
        if(empty($propertyData)){
                return $this->_forward('notfound');
        }
        $userTable                = Engine_Api::_()->getDbtable('users', 'user');
        $this->view->landlordUser = $userTable->fetchRow($userTable->select()->where('user_id = ?', $propertyData -> property_owner_id));
        $this->view->propertyData = $propertyData;
        $this->view->metaTitle    = $propertyData->property_name;
    }


    public function propertyrequirementmapAction(){

        if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('default');
        $id          =      $this->_getParam('id');
        $propertyRequirementTable    =  Engine_Api::_()->getDbtable('propertyrequirement', 'user');
        $propertyRequirementSelect   =  $propertyRequirementTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('property_req'=>'engine4_property_requirement',))
                        ->joinLeft(array('country'=>'engine4_property_countries',),'property_req.country_id=country.country_id',array('prty_country'))
                        ->joinLeft(array('state'=>'engine4_property_states',),'property_req.state_id=state.state_id',array('prty_state'))
                        ->joinLeft(array('city'=>'engine4_property_city',),'property_req.city_id=city.city_id',array('prty_city','latitude','longitude'))
                        ->where('property_req.id=?' ,  $id);
        $propertyRequirementData             =  $propertyRequirementTable->fetchRow($propertyRequirementSelect);
        $this->view->propertyRequirementData = $propertyRequirementData;
        $userTable                           = Engine_Api::_()->getDbtable('users', 'user');
        $this->view->tenantUser              = $userTable->fetchRow($userTable->select()->where('user_id = ?', $propertyRequirementData -> tenant_id));

    }

    public function setlocationAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $viewer     = Engine_Api::_()->user()->getViewer();
        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();

        $propertycountrtyTable  =  Engine_Api::_()->getDbtable('propertycountry', 'user');
        $propertystateTable     =  Engine_Api::_()->getDbtable('propertystate', 'user');
        $propertycityable       =  Engine_Api::_()->getDbtable('propertycity', 'user');
        $userTable              =  Engine_Api::_()->getDbtable('users', 'user');
        $propertyTable          =  Engine_Api::_()->getDbtable('propertylist', 'user');
        $propertyRequirementTable =  Engine_Api::_()->getDbtable('propertyrequirement', 'user');


        $location_mode_array    =  [];

        if(isset($_SESSION['countryId'])){
            unset($_SESSION['countryId']);
            unset($_SESSION['stateId']);
            unset($_SESSION['cityId']);
            unset($_SESSION['zipcode']);
        }
        unset($_SESSION['set_to_usa']);
        unset($_SESSION['matching_array']);
        unset($_SESSION['feedicon']);
        unset($_SESSION['feedpreferenceunit']);
        if( $this->getRequest()->isPost()){
             $aData = $this->_request->getPost();
             if($aData['set_to_usa'] == '')    {

                 if($aData['prty_country'] !=''){
                     $propertycountryData = $propertycountrtyTable->fetchRow($propertycountrtyTable->select()->where('prty_country = ?', $aData['prty_country']));
                      if(count($propertycountryData) > 0){
                          $propertycountryid =  $propertycountryData->country_id;
                      }
                      else{
                          $propertycountryid = '';
                      }
                 }
                  if($aData['prty_state'] != ''){
                     $propertystateData = $propertystateTable->fetchRow($propertystateTable->select()->where('prty_state = ?', $aData['prty_state']));
                     if(count($propertystateData) > 0){
                         $propertystateid =  $propertystateData->state_id;
                      }
                      else{
                          $propertystateid  = '';
                      }
                  }

                  if($aData['prty_city'] != ''){
                     $propertycityData = $propertycityable->fetchRow($propertycityable->select()->where('prty_city = ?', $aData['prty_city']));
                      if(count($propertycityData) > 0){
                         $propertycityid =  $propertycityData->city_id;
                      }
                      else{
                          $propertycityid  = '';
                      }
                  }


                    $_SESSION['countryId'] = $propertycountryid;
                    $_SESSION['stateId']   = $propertystateid;
                    $_SESSION['cityId']    = $propertycityid;
                    $_SESSION['zipcode']   = $aData['prty_zipcode'];
                    $_SESSION['country_name']   = $aData['prty_country'];
                    $_SESSION['state_name']     = $aData['prty_state'];
                    $_SESSION['city_name']      = $aData['prty_city'];
                    $_SESSION['county_name']       = $aData['prty_county'];
                    $_SESSION['neighborhood_name'] = $aData['prty_neighborhood'];
                    if($aData['is_prefered_location'] == 'true'){           }
                         $set_to_usa  = '';
            }
            else{
                $_SESSION['set_to_usa'] =1;
                $set_to_usa  = 1;
            }
              $location_mode_array['pets_type']       = $aData['pets_type'];
              $location_mode_array['price']           = $aData['price'];
//echo $location_mode_array['price'];
              $pricearray =  explode('-', $location_mode_array['price']);
              $location_mode_array['price_from']      = (int)$pricearray['0'];
              $location_mode_array['price_to']        = (int)$pricearray['1'];

              $location_mode_array['no_of_bedrooms']  = $aData['no_of_bedrooms'];
              $location_mode_array['countryId']       = $propertycountryid;
              $location_mode_array['stateId']         = $propertystateid;
              $location_mode_array['cityId']          = $propertycityid;
              $location_mode_array['zipcode']         = $aData['prty_zipcode'];
              $location_mode_array['set_to_usa']      = $set_to_usa;
              $location_mode_array['country_name']    = $aData['prty_country'];
              $location_mode_array['state_name']      = $aData['prty_state'];
              $location_mode_array['city_name']       = $aData['prty_city'];
              $location_mode_array['county_name']     = $aData['prty_county'];
              $location_mode_array['neighborhood_name']  = $aData['prty_neighborhood'];
              $_SESSION['location_mode_array']        = $location_mode_array;
              $_SESSION['feedicon']                   = 1;
        $aResult['status'] = true;
        }
        else{
            $aResult['status'] = false;
        }$_SESSION['location_mode_array']        = $location_mode_array;
        echo json_encode($aResult['status']);
    }


    public function settousaAction(){
    if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

       if(isset($_SESSION['countryId'])){
            unset($_SESSION['countryId']);
            unset($_SESSION['stateId']);
            unset($_SESSION['cityId']);
            unset($_SESSION['zipcode']);
        }
        unset($_SESSION['matching_array']);
        unset($_SESSION['feedicon']);
        unset($_SESSION['feedpreferenceunit']);
        unset($_SESSION['feedpreferenceunitmore']);
        if( $this->getRequest()->isPost()){
              $aData = $this->_request->getPost();
              if($aData['set_to_usa'] == 1){
              $_SESSION['set_to_usa'] =1;
              }
        }

        $aResult['status'] = true;
        exit($aResult['status']);

    }


    public function changelocationAction(){

    if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('default');
        $viewer_id          =   Engine_Api::_()->user()->getViewer()->getIdentity();
        $property_id        =   $this->_getParam('id');
        $viewer     = Engine_Api::_()->user()->getViewer();
    }


    public function createapplicationAction(){

        if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('property_detail');
        $viewer             = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viewer_id          = Engine_Api::_()->user()->getViewer()->getIdentity();
        $property_id        = $this->_getParam('id');
        if($property_id ==''){
            return $this->_forward('notfound');
        }
        $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
        if( !empty($fieldsByAlias['profile_type']) ){
              $optionId        = $fieldsByAlias['profile_type']->getValue($viewer);
              $profile_type_id = $optionId->value;
        }
        if($profile_type_id != 1){ //if not tenant
            return $this->_forward('notfound');
        }
        unset($_SESSION['about_me_array']);
        unset($_SESSION['residence_array']);
        unset($_SESSION['occupation_array']);
        unset($_SESSION['references_array']);
        unset($_SESSION['smartmove_rent_array']);
        $propertyTable          =  Engine_Api::_()->getDbtable('propertylist', 'user');
        $propertyimageTable     =  Engine_Api::_()->getDbtable('propertyimages', 'user');
        $propertyRequestTable   =  Engine_Api::_()->getDbtable('propertyrequest', 'user');
        $fieldsTable            =  Engine_Api::_()->fields()->getTable('user', 'values');
        $propertySelect         =   $propertyTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('plist'=>'engine4_property_list',))
                        ->joinLeft(array('user'=>'engine4_users'),'plist.property_owner_id=user.user_id',array('bg_verified'))
                        ->joinLeft(array('country'=>'engine4_property_countries',),'plist.prty_country_id=country.country_id',array('prty_country'))
                        ->joinLeft(array('state'=>'engine4_property_states',),'plist.prty_state_id=state.state_id',array('prty_state'))
                        ->joinLeft(array('city'=>'engine4_property_city',),'plist.prty_city_id=city.city_id',array('prty_city'))
                        ->joinLeft(array('pimages'=>'engine4_property_images'),'plist.id=pimages.property_id',array('image'))
                        ->where('plist.id=?' , $property_id)
                        ->where('pimages.type=?' , 'image');
        $propertyData             = $this->view->propertyData = $propertyTable->fetchRow($propertySelect);
        $userTable                = Engine_Api::_()->getDbtable('users', 'user');
        $this->view->landlordUser = $userTable->fetchRow($userTable->select()->where('user_id = ?', $propertyData -> property_owner_id));
        $tenantFieldsSelect       =   $fieldsTable->select()
                                        ->setIntegrityCheck(false)
                                        ->from(array('fields'=>'engine4_user_fields_values'))
                                        ->where('fields.item_id=?' , $viewer_id);
        $fieldsData               = $this->view->fieldsData = $fieldsTable->fetchAll($tenantFieldsSelect);
        foreach($fieldsData as $data){
            if($data['field_id'] == 3){
                $this->view->firstname = $data['value'];
            }
            if($data['field_id'] == 4){
                $this->view->lastname = $data['value'];
            }
            if($data['field_id'] == 6){
                $this->view->bdate = $data['value'];
            }
        }
        $rentalApplicationsTable             =  Engine_Api::_()->getDbtable('rentalapplications', 'user');
        $this->view->rentalApplicationsData  =  $rentalApplicationsData = $rentalApplicationsTable->fetchRow($rentalApplicationsTable->select()->where('tenant_id = ?', $viewer_id));
        $smartmoveapiRenters_table           =  Engine_Api::_()->getDbtable('Smartmoveapirenters', 'user');
        $this->view->smartmoveapiRentersData = $smartmoveapiRenters = $smartmoveapiRenters_table->fetchRow($smartmoveapiRenters_table->select()->where('tenant_id = ?', $viewer_id));
        if(!empty($smartmoveapiRenters)){
            $this->view->isSmartmoveRenter = 1;
        }
        else{
            $this->view->isSmartmoveRenter = 0;
        }

    }

    public function saveapplicationaboutmeAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viewer_id  = Engine_Api::_()->user()->getViewer()->getIdentity();
        $aData      = $this->_request->getPost();
        if(!empty($aData)){
        $about_me_array = array('tenant_first_name' => $aData['tenant_first_name'],'tenant_last_name' => $aData['tenant_last_name'],
        'tenant_email' => $aData['tenant_email'],'tenant_phone_no' => $aData['tenant_phone_no'],
        'tennat_driver_license_no' => $aData['tennat_driver_license_no']
        );
        $_SESSION['about_me_array'] = $about_me_array;
        $aResult['status']          = true;
        }
        else{
            $aResult['status'] = false;
        }

        echo json_encode($aResult);

    }

    public function saveapplicationresidenceAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viewer_id  = Engine_Api::_()->user()->getViewer()->getIdentity();
        $aData      = $this->_request->getPost();
        if(!empty($aData)){
        $residence_array = array('current_residence_housing_type' => $aData['current_residence_housing_type'],
        'current_residence_address'      => $aData['current_residence_address'],
        'current_residence_move_in_date' => $aData['current_residence_move_in_date'],
        'current_residence_monthly_rent' => $aData['current_residence_monthly_rent'],
        'current_residence_landlord_name'=> $aData['current_residence_landlord_name'],
        'current_residence_landlord_pno' => $aData['current_residence_landlord_pno'],
        'current_residence_reson_for_leaving' => $aData['current_residence_reson_for_leaving'],
        'previous_residence_housing_type'     => $aData['previous_residence_housing_type'],
        'previous_residence_address'     => $aData['previous_residence_address'],
        'previous_residence_move_in_date'      => $aData['previous_residence_move_in_date'],
        'previous_residence_monthly_rent'      => $aData['previous_residence_monthly_rent'],
        'previous_residence_landlord_name'     => $aData['previous_residence_landlord_name'],
        'previous_residence_landlord_pno'      => $aData['previous_residence_landlord_pno'],
        'previous_residence_reson_for_leaving'     => $aData['previous_residence_reson_for_leaving'],
        );

        $_SESSION['residence_array'] = $residence_array;
        $aResult['status']           = true;
        }
        else{
            $aResult['status'] = false;
        }

        echo json_encode($aResult);


    }


    public function saveapplicationoccupationAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viewer_id  = Engine_Api::_()->user()->getViewer()->getIdentity();
        $aData      = $this->_request->getPost();
        if(!empty($aData)){
        $occupation_array = array(
        'current_status' => $aData['current_status'],
        'current_occupation_employer' => $aData['current_occupation_employer'],
        'current_occupation_job_title' => $aData['current_occupation_job_title'],
        'current_occupation_monthly_salary' => $aData['current_occupation_monthly_salary'],
        'current_occupation_work_type' => $aData['current_occupation_work_type'],
        'current_occupation_manager_name' => $aData['current_occupation_manager_name'],
        'current_occupation_pno' => $aData['current_occupation_pno'],
        'current_occupation_work_address' => $aData['current_occupation_work_address'],
        'current_occupation_start_date' => $aData['current_occupation_start_date'],
        'current_income_source' => $aData['current_income_source'],
        'current_monthly_income' => $aData['current_monthly_income'],
        'previous_status' => $aData['previous_status'],
        'previous_occupation_employer' => $aData['previous_occupation_employer'],
        'previous_occupation_job_title' => $aData['previous_occupation_job_title'],
        'previous_occupation_monthly_salary' => $aData['previous_occupation_monthly_salary'],
        'previous_occupation_work_type' => $aData['previous_occupation_work_type'],
        'previous_occupation_manager_name' => $aData['previous_occupation_manager_name'],
        'previous_occupation_pno' => $aData['previous_occupation_pno'],
        'previous_occupation_work_address' => $aData['previous_occupation_work_address'],
        'previous_occupation_end_date' => $aData['previous_occupation_end_date'],
        'previous_occupation_income_source' => $aData['previous_occupation_income_source'],
        'previous_occupation__monthly_income' => $aData['previous_occupation__monthly_income'],
        'additional_income_source' => $aData['additional_income_source'],
        'additional_income_amount' => $aData['additional_income_amount'],
        'total_monthly_income' => $aData['total_monthly_income']
        );

        $_SESSION['occupation_array'] = $occupation_array;
        $aResult['status']            = true;
        }
        else{
            $aResult['status'] = false;
        }
        echo json_encode($aResult);

    }

    public function saveapplicationreferencesAction(){

        if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viewer_id  = Engine_Api::_()->user()->getViewer()->getIdentity();
        $aData      = $this->_request->getPost();
        if(!empty($aData)){
        $_SESSION['references_array'] =json_encode($aData);
        $aResult['status']            = true;
        }
        else{
            $aResult['status'] = false;
        }

        echo json_encode($aResult);

    }

    public function createapplicationdoneAction() {

    if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        $viewer      = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viwer_id    = Engine_Api::_()->user()->getViewer()->getIdentity();
        $aResult     =   array();
        $aData       = $this->_request->getPost();
        $userTable            = Engine_Api::_()->getDbtable('users', 'user');
        $lanlordDetails       = $userTable->fetchRow($userTable->select()->where('user_id = ?', $aData['landlord_id']));
        $propertyRequestTable =  Engine_Api::_()->getDbtable('propertyrequest', 'user');
        $propertyTable        =  Engine_Api::_()->getDbtable('propertylist', 'user');
        $propertyData         = $propertyTable->fetchRow($propertyTable->select()->where('id = ?', $aData['property_id']));
        try{
            $about_me_array   = $_SESSION['about_me_array'];
            $residence_array  = $_SESSION['residence_array'];
            $occupation_array = $_SESSION['occupation_array'];
            $references_array = $_SESSION['references_array'];
            if(isset($_SESSION['about_me_array'])){
            $about_me_array   = $_SESSION['about_me_array'];
            }
            else{
                $about_me_array = array(
                'tenant_first_name' => '',
                'tenant_last_name' => '',
                'tenant_email' => '',
                'tenant_phone_no' => '',
                'tennat_driver_license_no' => ''
                );
            }
            if(isset($_SESSION['residence_array'])){
                $residence_array  = $_SESSION['residence_array'];
            }
            else{
                $residence_array = array(
                'current_residence_housing_type' => '',
                'current_residence_address'      => '',
                'current_residence_move_in_date' => '',
                'current_residence_monthly_rent' => '',
                'current_residence_landlord_name'=> '',
                'current_residence_landlord_pno' => '',
                'current_residence_reson_for_leaving' => '',
                'previous_residence_housing_type'     => '',
                'previous_residence_address'     => '',
                'previous_residence_move_in_date'      => '',
                'previous_residence_monthly_rent'      => '',
                'previous_residence_landlord_name'     => '',
                'previous_residence_landlord_pno'      => '',
                'previous_residence_reson_for_leaving'     => '',
               );
            }
            if(isset($_SESSION['occupation_array'])){
                $occupation_array = $_SESSION['occupation_array'];
            }
            else{
                $occupation_array = array(
                'current_status' => '',
                'current_occupation_employer' => '',
                'current_occupation_job_title' => '',
                'current_occupation_monthly_salary' => '',
                'current_occupation_work_type' => '',
                'current_occupation_manager_name' => '',
                'current_occupation_pno' => '',
                'current_occupation_work_address' => '',
                'current_occupation_start_date' => '',
                'current_income_source' => '',
                'current_monthly_income' => '',
                'previous_status' => '',
                'previous_occupation_employer' => '',
                'previous_occupation_job_title' => '',
                'previous_occupation_monthly_salary' => '',
                'previous_occupation_work_type' => '',
                'previous_occupation_manager_name' => '',
                'previous_occupation_pno' => '',
                'previous_occupation_work_address' => '',
                'previous_occupation_end_date' => '',
                'previous_occupation_income_source' => '',
                'previous_occupation__monthly_income' => '',
                'additional_income_source' => '',
                'additional_income_amount' => '',
                'total_monthly_income' => ''
                );
            }
            if(isset($_SESSION['references_array'])){
                $references_array = $_SESSION['references_array'];
            }
            else{
                $references_array ="";
            }
        $propertyReq_select = $propertyRequestTable->select()
                               ->setIntegrityCheck(false)
                               ->from(array('prequest'=>'engine4_property_request',))
                               ->where('prequest.tenant_id = ?', $viwer_id)
                               ->where('prequest.property_id     = ?', $aData['property_id']);
        $propertyRequest = $propertyRequestTable->fetchAll($propertyReq_select);
        if(count($propertyRequest) == 0){

            if($viewer->bg_verified == 1){
                $admin_approve = 1;
                $admin_approve_date =date('Y-m-d H:i:s');
            }
            else{
                $admin_approve = 0;
                $admin_approve_date ='';
            }

                $propertyRequestId=   $propertyRequestTable->insert(array(
                    'property_id' => $aData['property_id'],
                    'landlord_id' => $aData['landlord_id'],
                    'tenant_id' => $viwer_id,
                    'admin_approve' => $admin_approve,
                    'admin_approve_date' => $admin_approve_date,
                    'created_at' => date('Y-m-d H:i:s'),
                    'tenant_firstname' => $about_me_array['tenant_first_name'],
                    'tenant_last_name' => $about_me_array['tenant_last_name'],
                    'tenant_email' => $about_me_array['tenant_email'],
                    'tenant_pno' => $about_me_array['tenant_phone_no'],
                    'driver_license_no' => $about_me_array['tennat_driver_license_no'],
                    'current_residence_housing_type' => $residence_array['current_residence_housing_type'],
                    'current_residence_address' => $residence_array['current_residence_address'],
                    'current_residence_move_in_date' => $residence_array['current_residence_move_in_date'],
                    'current_residence_monthly_rent' => $residence_array['current_residence_monthly_rent'],
                    'current_residence_landlordname' => $residence_array['current_residence_landlord_name'],
                    'current_residence_landlord_pno' => $residence_array['current_residence_landlord_pno'],
                    'current_residence_leaving_reason' => $residence_array['current_residence_reson_for_leaving'],
                    'previous_residence_housing_type' => $residence_array['previous_residence_housing_type'],
                    'previous_residence_address' => $residence_array['previous_residence_address'],
                    'previous_residence_move_in_date' => $residence_array['previous_residence_move_in_date'],
                    'previous_residence_monthly_rent' => $residence_array['previous_residence_monthly_rent'],
                    'previous_residence_landlord_name' => $residence_array['previous_residence_landlord_name'],
                    'previous_residence_landlord_pno' => $residence_array['previous_residence_landlord_pno'],
                    'previous_residence_leaving_reason' => $residence_array['previous_residence_reson_for_leaving'],
                    'current_occupation_status' => $occupation_array['current_status'],
                    'current_occupation_employer' => $occupation_array['current_occupation_employer'],
                    'current_occupation_job_title' => $occupation_array['current_occupation_job_title'],
                    'current_occupation_monthly_salary' => $occupation_array['current_occupation_monthly_salary'],
                    'current_occupation_work_type' => $occupation_array['current_occupation_work_type'],
                    'current_occupation_manager_name' => $occupation_array['current_occupation_manager_name'],
                    'current_occupation_pno' => $occupation_array['current_occupation_pno'],
                    'current_occupation_work_address' => $occupation_array['current_occupation_work_address'],
                    'current_occupation_start_date' => $occupation_array['current_occupation_start_date'],
                    'current_occupation_income_source' => $occupation_array['current_income_source'],
                    'current_occupation_monthly_income' => $occupation_array['current_monthly_income'],
                    'previous_occupation_monthly_status' => $occupation_array['previous_status'],
                    'previous_occupation_employer' => $occupation_array['previous_occupation_employer'],
                    'previous_occupation_job_title' => $occupation_array['previous_occupation_job_title'],
                    'previous_occupation_monthly_salary' => $occupation_array['previous_occupation_monthly_salary'],
                    'previous_occupation_work_type' => $occupation_array['previous_occupation_work_type'],
                    'previous_occupation_manager_name' => $occupation_array['previous_occupation_manager_name'],
                    'previous_occupation_pno' => $occupation_array['previous_occupation_pno'],
                    'previous_occupation_work_address' => $occupation_array['previous_occupation_work_address'],
                    'previous_occupation_end_date' => $occupation_array['previous_occupation_end_date'],
                    'previous_occupation_income_source' => $occupation_array['previous_occupation_income_source'],
                    'previous_occupation__monthly_income' => $occupation_array['previous_occupation__monthly_income'],
                    'additional_income_sources' => $occupation_array['additional_income_source'],
                    'additional_income_amount' => $occupation_array['additional_income_amount'],
                    'total_monthly_income' => $occupation_array['total_monthly_income'],
                    'personal_reference_json' => $references_array,
                ));

               if($viewer->bg_verified == 0){
                    /*******************mail to admin************************/


                $userTable     = Engine_Api::_()->getDbtable('users', 'user');
                $adminDetails  = $userTable->fetchAll($userTable->select()->where('level_id = ?', '1'));
                $from_email    = Engine_Api::_()->getApi('settings', 'core')->core_mail_from;
                $tenant_name   = $viewer->displayname;
                $red_url       = $_SERVER['HTTP_HOST']."/admin/user/manage/propertyrequestlist";
                foreach($adminDetails as $admin){
                     $admin_email       = $admin['email'];
                     $admin_displayname = $admin['displayname'];
                     $bodyTextContent   = '';
                         if (file_exists("emailtemplates/property_request_email_admin.html")) {
                            $htmlExist = true;
                            $file = fopen("emailtemplates/property_request_email_admin.html", "r");
                            while(!feof($file))
                            {
                                $bodyTextContent .= fgets($file);
                            }
                            fclose($file);
                        }
                            if($htmlExist){
                              $tenantname   = '{tenantname}';
                              $rentaltype   = '{rentaltype}';
                              $redirect_url = '{redirect_url}';
                              $property_name= '{property_name}';
                              $display_name = '{display_name}';
                              $bodyTextTemplate = '';
                              $bodyHtmlTemplate = $bodyTextContent;
                          foreach( $rParams as $var => $val ) {
                              $raw = trim($var, '[]');
                              $var = '[' . $var . ']';
                              if( !$val ) {
                                $val = $var;
                              }
                              // Fix nbsp
                              $val = str_replace('&amp;nbsp;', ' ', $val);
                              $val = str_replace('&nbsp;', ' ', $val);
                              // Replace
                             $bodyTextTemplate = str_replace($var, $val, $bodyTextTemplate);
                             $bodyHtmlTemplate = str_replace($var, $val, $bodyHtmlTemplate);
                            }
                            $bodyTextTemplate = strip_tags($bodyTextTemplate);
                            $bodyHtmlTemplate = str_replace($tenantname, $tenant_name, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($rentaltype, $propertyData->rental_type, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($redirect_url, $red_url, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($property_name, $propertyData->property_name, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($display_name, $admin_displayname, $bodyHtmlTemplate);
                         }
                    $subject = "Request for a property for ".$propertyData->rental_type;
                    $header  = "From: ".'Rentstarz'." <".$from_email.">\r\n";
                    $header .= "MIME-Version: 1.0\r\n";
                    $header .= 'Content-type: text/html; charset=iso-8859-1' ."\"\r\n\r\n";
                    mail($admin_email, $subject, $bodyHtmlTemplate, $header);
                }
                /************************************************/
            }
            unset($_SESSION['about_me_array']);
            unset($_SESSION['residence_array']);
            unset($_SESSION['occupation_array']);
            unset($_SESSION['references_array']);

               /******mail to landlord***/

                $from_email     = Engine_Api::_()->getApi('settings', 'core')->core_mail_from;

                $landlord_name  = $lanlordDetails->displayname;
                $landlord_email = $lanlordDetails->email;
                $tenant_name    = $viewer->displayname;
                $bio_content    = '';
                $bio_select = $userTable->select()
                                  ->setIntegrityCheck(false)
                                  ->from(array('user'=>'engine4_users',))
                                  ->joinLeft(array('fields'=>'engine4_user_fields_values'),'fields.item_id=user.user_id',array('value'))
                                  ->where('fields.item_id        = ?', $viwer_id)
                                  ->where('fields.field_id       = ?', 13);
                $bioData = $userTable->fetchRow($bio_select);
                if(count($bioData)>0){
                    $bioData_content  = $bioData->value;
                    $tenant_firstname = explode(" ", $tenant_name);
                    $tenant_firstname = $tenant_firstname[0];
                    $bio_content      = '<br/><br />'.$tenant_firstname.'\'s profile : '.$bioData_content;
                }
                else{
                    $bio_content ='';
                }

                $red_url =  $_SERVER['HTTP_HOST']."/propertyrequestslist";
                $login_url =$_SERVER['HTTP_HOST']."/login";
                         $bodyTextContent = '';
                         if (file_exists("emailtemplates/property_request_email.html")) {
                            $htmlExist = true;
                            $file = fopen("emailtemplates/property_request_email.html", "r");
                            while(!feof($file))
                            {
                                $bodyTextContent .= fgets($file);
                            }
                            fclose($file);
                        }

                            if($htmlExist){
                              $landlordname='{landlordname}';
                              $tenantname='{tenantname}';
                              $rentaltype='{rentaltype}';
                              $redirect_url='{redirect_url}';
                              $property_name='{property_name}';
                              $loginurl='{loginurl}';
                              $biocontent='{coverlettercontent}';

                              $bodyTextTemplate = '';
                              $bodyHtmlTemplate = $bodyTextContent;
                          foreach( $rParams as $var => $val ) {
                              $raw = trim($var, '[]');
                              $var = '[' . $var . ']';
                              if( !$val ) {
                                $val = $var;
                              }
                              // Fix nbsp
                              $val = str_replace('&amp;nbsp;', ' ', $val);
                              $val = str_replace('&nbsp;', ' ', $val);
                              // Replace

                             $bodyTextTemplate = str_replace($var, $val, $bodyTextTemplate);
                             $bodyHtmlTemplate = str_replace($var, $val, $bodyHtmlTemplate);
                            }
                            $bodyTextTemplate = strip_tags($bodyTextTemplate);
                            $bodyHtmlTemplate = str_replace($landlordname, $landlord_name, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($tenantname, $tenant_name, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($rentaltype, $propertyData->rental_type, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($redirect_url, $red_url, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($property_name, $propertyData->property_name, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($loginurl, $login_url, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($biocontent, $bio_content, $bodyHtmlTemplate);
                         }
                    $subject = "Request for a property for ".$propertyData->rental_type;
                    $header  = "From: ".'Rentstarz'." <".$from_email.">\r\n";
                    $header .= "MIME-Version: 1.0\r\n";
                    $header .= 'Content-type: text/html; charset=iso-8859-1' ."\"\r\n\r\n";

                     mail($landlord_email, $subject, $bodyHtmlTemplate, $header);
                /******mail to landlord***/
                // send notification
        Engine_Api::_()->getDbtable('notifications', 'activity')
                ->addNotification($lanlordDetails, $viewer, $lanlordDetails, 'application_request',array(
              'label' => $propertyData->property_name,'pid' => $aData['property_id']));
                                $aResult['status'] = true;
                                $aResult['message'] = 'Success';
                }

                else{
                    $aResult['status'] = false;
                    $aResult['errors'] = $data['Errors'];
                }
        }catch (Exception $e) {exit($e->getMessage());
                                $aResult['status'] = false;
                                $aResult['message'] = 'Failed';
                            }
        echo json_encode($aResult);

    }


    public function viewapplicationAction() {

        if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('property_detail');
        $viewer_id                  =   Engine_Api::_()->user()->getViewer()->getIdentity();
        $applicationRequest_id      =   $this->_getParam('id');
        $fieldsByAlias              =   Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
        if( !empty($fieldsByAlias['profile_type']) ){
              $optionId = $fieldsByAlias['profile_type']->getValue($viewer);
              $profile_type_id = $optionId->value;
        }
        $this->view->profile_type_id    = $profile_type_id;
        if($applicationRequest_id ==''){
            return $this->_forward('notfound');
        }
        $propertyRequestTable =  Engine_Api::_()->getDbtable('propertyrequest', 'user');
        $propertyReq_select   = $propertyRequestTable->select()
                              ->setIntegrityCheck(false)
                               ->from(array('prequest'=>'engine4_property_request',))
                               ->joinLeft(array('plist'=>'engine4_property_list',),'plist.id=prequest.property_id',array('property_name','rental_type','granted'))
                               ->where('prequest.id = ?', $applicationRequest_id);
        $propertyRequest                   = $propertyRequestTable->fetchRow($propertyReq_select);
        $this->view->applicationRequest_id = $applicationRequest_id;
        if(empty($propertyRequest)){
            return $this->_forward('notfound');
        }

    //to check application view
     if(($propertyRequest->application_view_status==0) && ($propertyRequest->landlord_id==$viewer_id)){
        $propertyRequestData    =  $propertyRequestTable->fetchRow($propertyRequestTable->select()->where('id = ?', $applicationRequest_id));
        $propertyRequestData->application_view_status=1;
        $propertyRequestData->save();
        $userTable  = Engine_Api::_()->getDbtable('users', 'user');
        $tenantData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $propertyRequest['tenant_id']));
         // send notification
        Engine_Api::_()->getDbtable('notifications', 'activity')
                ->addNotification($tenantData, $viewer, $tenantData, 'application_review',array(
              'label' => $propertyRequest['property_name'],'pid' => $propertyRequest['property_id'],'property_request_id'=>$applicationRequest_id));

        }
        /* smartmove api  application renter status start*/
        $smartmoveapiApplication_table =  Engine_Api::_()->getDbtable('Smartmoveapiapplication', 'user');
        $smartmoveapiApplicationData   = $smartmoveapiApplication_table->fetchRow($smartmoveapiApplication_table->select()->where('rental_application_id   = ?', $applicationRequest_id));
        if(!empty($smartmoveapiApplicationData)){
            $email         =  $smartmoveapiApplicationData->Applicants;
            $applicationId =  $smartmoveapiApplicationData->SmartmoveApplicationId;
            $viewHelperObj = $this->view->getHelper('SmartmoveApi125');
            $response      = $viewHelperObj->getApplicationStatus($email,$applicationId);
            if ($response === false)
            {
                $aResult['status'] = false;
                $aResult['errors'] = curl_error($crl);
            }
            $data    = json_decode($response, true);
            if(empty($data['Errors'])){
                $this->view->applicationStatus = $data;
                $applicationResponse = $viewHelperObj->getApplication($applicationId);
                if ($applicationResponse === false)
                {
                    $aResult['status'] = false;
                    $aResult['errors'] = curl_error($crl);
                }
                $applicationData = json_decode($applicationResponse, true);
                if(empty($applicationData['Errors'])){  //print_r($applicationData); exit;
                    $this->view->applicationData = $applicationData;
                }
            }
        }
        $smartmoveapiRenters_table =  Engine_Api::_()->getDbtable('Smartmoveapirenters', 'user');
        $smartmoveapiRentersData   = $smartmoveapiRenters_table->fetchRow($smartmoveapiRenters_table->select()->where('tenant_id   = ?', $propertyRequest->tenant_id));
        $this->view->smartmoveapiRentersData = $smartmoveapiRentersData;
        if($viewer_id == $propertyRequest->tenant_id){
            $this->view->is_edit = 1;
        }
        else{
            $this->view->is_edit = 0;
        }
        /* smartmove api  application renter status end*/
        $this->view->application = $propertyRequest;

    }

    public function editapplicationAction() {

        if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('property_detail');
        $viewer_id          =   Engine_Api::_()->user()->getViewer()->getIdentity();
        $application_id     =   $this->_getParam('id');
        unset($_SESSION['about_me_array']);
        unset($_SESSION['residence_array']);
        unset($_SESSION['occupation_array']);
        unset($_SESSION['references_array']);
        unset($_SESSION['smartmove_rent_array']);

        $propertyRequestTable =  Engine_Api::_()->getDbtable('propertyrequest', 'user');
        $propertyReq_select = $propertyRequestTable->select()
                              ->setIntegrityCheck(false)
                               ->from(array('prequest'=>'engine4_property_request',))
                               ->joinLeft(array('plist'=>'engine4_property_list',),'plist.id=prequest.property_id',array('property_owner_id','property_name','rental_type','granted','no_of_rooms','housing_type','has_pets','pets_type','price'))
                               ->joinLeft(array('country'=>'engine4_property_countries',),'plist.prty_country_id=country.country_id',array('prty_country'))
                               ->joinLeft(array('state'=>'engine4_property_states',),'plist.prty_state_id=state.state_id',array('prty_state'))
                               ->joinLeft(array('city'=>'engine4_property_city',),'plist.prty_city_id=city.city_id',array('prty_city'))
                               ->joinLeft(array('pimages'=>'engine4_property_images'),'plist.id=pimages.property_id',array('image'))
                               ->where('prequest.id = ?', $application_id)
                               ->where('pimages.type=?' , 'image');
        $propertyRequest         = $propertyRequestTable->fetchRow($propertyReq_select);
        $this->view->application = $propertyRequest;
        $fieldsTable = Engine_Api::_()->fields()->getTable('user', 'values');
        $userTable = Engine_Api::_()->getDbtable('users', 'user');
        $this->view->landlordUser = $userTable->fetchRow($userTable->select()->where('user_id = ?', $propertyRequest->landlord_id));
        $tenantFieldsSelect   =   $fieldsTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('fields'=>'engine4_user_fields_values'))
                        ->where('fields.item_id=?' , $viewer_id);
        $fieldsData=$this->view->fieldsData = $fieldsTable->fetchAll($tenantFieldsSelect);
        foreach($fieldsData as $data){
            if($data['field_id'] == 3){
                $this->view->firstname = $data['value'];
            }
            if($data['field_id'] == 4){
                $this->view->lastname = $data['value'];
            }
            if($data['field_id'] == 6){
                $this->view->bdate = $data['value'];
            }
        }
        $smartmoveapiApplication_table =  Engine_Api::_()->getDbtable('Smartmoveapiapplication', 'user');
        $smartmoveapiApplicationData   = $smartmoveapiApplication_table->fetchRow($smartmoveapiApplication_table->select()->where('rental_application_id   = ?', $application_id));
        $this->view->smartmoveapiApplicationData = $smartmoveapiApplicationData; //print_r($smartmoveapiApplicationData); exit;
    }

    public function editapplicationdoneAction() {

        if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }


        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);

        $viewer     = Engine_Api::_()->user()->getViewer();
        $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
        $aResult    =   array();
        $aData = $this->_request->getPost();

        $propertyRequestTable =  Engine_Api::_()->getDbtable('propertyrequest', 'user');


        $propertyRequestData = $propertyRequestTable->fetchRow($propertyRequestTable->select()->where('id = ?', $aData['property_reqst_id']));
       try{
        if(count($propertyRequestData > 0)){

            $about_me_array   = $_SESSION['about_me_array'];
            $residence_array  = $_SESSION['residence_array'];
            $occupation_array = $_SESSION['occupation_array'];
            $references_array = $_SESSION['references_array'];
            if(isset($_SESSION['about_me_array'])){
            $about_me_array   = $_SESSION['about_me_array'];
            $propertyRequestData-> tenant_firstname = $about_me_array['tenant_first_name'];
            $propertyRequestData-> tenant_last_name = $about_me_array['tenant_last_name'];
            $propertyRequestData-> tenant_email = $about_me_array['tenant_email'];
            $propertyRequestData-> tenant_pno = $about_me_array['tenant_phone_no'];
            $propertyRequestData-> driver_license_no = $about_me_array['tennat_driver_license_no'];
            $propertyRequestData->save();
            }
            if(isset($_SESSION['residence_array'])){
                $residence_array  = $_SESSION['residence_array'];
                $propertyRequestData-> current_residence_housing_type = $residence_array['current_residence_housing_type'];
                $propertyRequestData-> current_residence_address = $residence_array['current_residence_address'];
                $propertyRequestData-> current_residence_move_in_date = $residence_array['current_residence_move_in_date'];
                $propertyRequestData-> current_residence_monthly_rent = $residence_array['current_residence_monthly_rent'];
                $propertyRequestData-> current_residence_landlordname = $residence_array['current_residence_landlord_name'];
                $propertyRequestData-> current_residence_landlord_pno = $residence_array['current_residence_landlord_pno'];
                $propertyRequestData-> current_residence_leaving_reason = $residence_array['current_residence_reson_for_leaving'];
                $propertyRequestData-> previous_residence_housing_type = $residence_array['previous_residence_housing_type'];
                $propertyRequestData-> previous_residence_address = $residence_array['previous_residence_address'];
                $propertyRequestData-> previous_residence_move_in_date = $residence_array['previous_residence_move_in_date'];
                $propertyRequestData-> previous_residence_monthly_rent = $residence_array['previous_residence_monthly_rent'];
                $propertyRequestData-> previous_residence_landlord_name = $residence_array['previous_residence_landlord_name'];
                $propertyRequestData-> previous_residence_landlord_pno = $residence_array['previous_residence_landlord_pno'];
                $propertyRequestData-> previous_residence_leaving_reason = $residence_array['previous_residence_reson_for_leaving'];

                $propertyRequestData->save();
            }
            if(isset($_SESSION['occupation_array'])){
                $occupation_array = $_SESSION['occupation_array'];
                $propertyRequestData-> current_occupation_status = $occupation_array['current_status'];
                $propertyRequestData-> current_occupation_employer = $occupation_array['current_occupation_employer'];
                $propertyRequestData-> current_occupation_job_title = $occupation_array['current_occupation_job_title'];
                $propertyRequestData-> current_occupation_monthly_salary = $occupation_array['current_occupation_monthly_salary'];
                $propertyRequestData-> current_occupation_work_type = $occupation_array['current_occupation_work_type'];
                $propertyRequestData-> current_occupation_manager_name = $occupation_array['current_occupation_manager_name'];
                $propertyRequestData-> current_occupation_pno = $occupation_array['current_occupation_pno'];
                $propertyRequestData-> current_occupation_work_address = $occupation_array['current_occupation_work_address'];
                $propertyRequestData-> current_occupation_start_date = $occupation_array['current_occupation_start_date'];
                $propertyRequestData-> current_occupation_start_date = $occupation_array['current_occupation_start_date'];
                $propertyRequestData-> current_occupation_income_source = $occupation_array['current_income_source'];
                $propertyRequestData-> current_occupation_monthly_income = $occupation_array['current_monthly_income'];
                $propertyRequestData-> previous_occupation_monthly_status = $occupation_array['previous_status'];
                $propertyRequestData-> previous_occupation_employer = $occupation_array['previous_occupation_employer'];
                $propertyRequestData-> previous_occupation_job_title = $occupation_array['previous_occupation_job_title'];
                $propertyRequestData-> previous_occupation_monthly_salary = $occupation_array['previous_occupation_monthly_salary'];
                $propertyRequestData-> previous_occupation_work_type = $occupation_array['previous_occupation_work_type'];
                $propertyRequestData-> previous_occupation_manager_name = $occupation_array['previous_occupation_manager_name'];
                $propertyRequestData-> previous_occupation_pno = $occupation_array['previous_occupation_pno'];
                $propertyRequestData-> previous_occupation_work_address = $occupation_array['previous_occupation_work_address'];
                $propertyRequestData-> previous_occupation_end_date = $occupation_array['previous_occupation_end_date'];
                $propertyRequestData-> previous_occupation_income_source = $occupation_array['previous_occupation_income_source'];
                $propertyRequestData-> previous_occupation__monthly_income = $occupation_array['previous_occupation__monthly_income'];
                $propertyRequestData-> additional_income_sources = $occupation_array['additional_income_source'];
                $propertyRequestData-> additional_income_amount = $occupation_array['additional_income_amount'];
                $propertyRequestData-> total_monthly_income = $occupation_array['total_monthly_income'];
                $propertyRequestData->save();
            }
            if(isset($_SESSION['references_array'])){
                $references_array = $_SESSION['references_array'];
                $propertyRequestData-> personal_reference_json   = $references_array;
                $propertyRequestData->save();
            }
            unset($_SESSION['about_me_array']);
            unset($_SESSION['residence_array']);
            unset($_SESSION['occupation_array']);
            unset($_SESSION['references_array']);
            /* smartmove api update application start*/
        $smartmoveapiApplication_table =  Engine_Api::_()->getDbtable('Smartmoveapiapplication', 'user');
        $smartmoveapiApplicationData   = $smartmoveapiApplication_table->fetchRow($smartmoveapiApplication_table->select()->where('rental_application_id   = ?', $aData['property_reqst_id']));
        if(!empty($smartmoveapiApplicationData))    {
                $smartmove_rent_array = $_SESSION['smartmove_rent_array'];
                $ApplicationId        = $smartmoveapiApplicationData->SmartmoveApplicationId;
                $PropertyId           = $smartmoveapiApplicationData->SmartmovePropertyId;
                $UnitNumber           = $smartmoveapiApplicationData->UnitNumber;
                $Deposit              = $smartmove_rent_array['Deposit'];
                $Rent                 = $smartmove_rent_array['Rent'];
                $LeaseTermInMonths    = $smartmove_rent_array['LeaseTermInMonths'];
                $LandlordPays         = $smartmove_rent_array['LandlordPays'];
                $ProductBundle        = $smartmove_rent_array['ProductBundle'];
                $Applicants           = array($viewer->email);
                $params = array(
                'PropertyId'        => $PropertyId,
                'ApplicationId'     => $ApplicationId,
                'UnitNumber'        => $UnitNumber,
                'Deposit'           => $Deposit,
                'Rent'              => $Rent,
                'LeaseTermInMonths' => $LeaseTermInMonths,
                'LandlordPays'      => $LandlordPays,
                );
                //echo print_r($params); exit;
            $params=json_encode($params);
            $viewHelperObj  = $this->view->getHelper('SmartmoveApi125');
            $servertime     = $viewHelperObj->getServertime();
            $partnerId      = 408;
            $SecurityKey    ='Hs3+FsK/Sh/MyLvGIW3TtsMtkTc1C9mJd11EFeHt1LNOpjT4+pLl/BSpChyK/w/nHDZU+IwAosgfrk4jcRQnEg==';
            // Get the security signature
            $securityToken = $viewHelperObj->GetSignature($partnerId, $SecurityKey, $servertime);
            $header = array();
            $header[] = 'Content-type: application/json';
            $header[] = 'Authorization: smartmovepartner partnerId="408",serverTime="'.$servertime.'",securityToken="'.$securityToken.'"';
            $posturl  = "https://www.mysmgateway.com/LandLordApi/v2/Application";
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $posturl);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
            curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
            curl_setopt($ch, CURLOPT_HEADER, 1);
            curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'PUT');
            curl_setopt($ch, CURLOPT_POSTFIELDS, $params);
            curl_setopt($ch, CURLOPT_HEADER, 0);
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
            $response = curl_exec($ch);
            if ($response === false)
            {
                $aResult['status'] = false;
                $aResult['errors'] = curl_error($crl);
            }
            else{
                $data = json_decode($response, true);
                if(empty($data['Errors'])){
                $smartmoveapiApplicationData -> Deposit = $data['Deposit'];
                $smartmoveapiApplicationData -> Rent = $data['Rent'];
                $smartmoveapiApplicationData -> LeaseTermInMonths = $data['LeaseTermInMonths'];
                $smartmoveapiApplicationData -> updated_at = date('Y-m-d');
                $smartmoveapiApplicationData -> save();
                $aResult['status'] = true;
                unset($_SESSION['smartmove_rent_array']);
                }
                else{
                $aResult['status'] = false;
                $aResult['errors'] = $data['Errors'];
                }
            }
        }
        /* smartmove api update application end*/
        }
      }catch (Exception $e) {exit($e->getMessage());
                                $aResult['status'] = false;
                                $aResult['message'] = 'Failed';
                            }
        echo json_encode($aResult);
    }

    public function createrentalapplicationAction() {

        if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('property_detail');
        $viewer     =  Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viewer_id  =  Engine_Api::_()->user()->getViewer()->getIdentity();
        $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
        if( !empty($fieldsByAlias['profile_type']) ){
              $optionId        = $fieldsByAlias['profile_type']->getValue($viewer);
              $profile_type_id = $optionId->value;
        }
        if($profile_type_id != 1){ //if not tenant
            return $this->_forward('notfound');
        }
        $rentalApplicationsTable            =  Engine_Api::_()->getDbtable('rentalapplications', 'user');
        $this->view->rentalApplicationsData = $rentalApplicationsData = $rentalApplicationsTable->fetchRow($rentalApplicationsTable->select()->where('tenant_id = ?', $viewer_id));
        $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);

        if( !empty($fieldsByAlias['profile_type']) ){
              $optionId        = $fieldsByAlias['profile_type']->getValue($viewer);
              $profile_type_id = $optionId->value;
        }
        if($profile_type_id != 1){ //if not tenant
            return $this->_forward('notfound');
        }
        unset($_SESSION['about_me_array']);
        unset($_SESSION['residence_array']);
        unset($_SESSION['occupation_array']);
        unset($_SESSION['references_array']);
        $fieldsTable          = Engine_Api::_()->fields()->getTable('user', 'values');
        $tenantFieldsSelect   =   $fieldsTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('fields'=>'engine4_user_fields_values'))
                        ->where('fields.item_id=?' , $viewer_id);
        $fieldsData=$this->view->fieldsData = $fieldsTable->fetchAll($tenantFieldsSelect);
        foreach($fieldsData as $data){
            if($data['field_id'] == 3){
                $this->view->firstname = $data['value'];
            }
            if($data['field_id'] == 4){
                $this->view->lastname = $data['value'];
            }
            if($data['field_id'] == 6){
                $this->view->bdate = $data['value'];
            }
        }
    }

    public function createrentalapplicationdoneAction() {

    if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
        $aResult    =   array();
        $aData = $this->_request->getPost();
        $userTable = Engine_Api::_()->getDbtable('users', 'user');
        $rentalApplicationsTable =  Engine_Api::_()->getDbtable('rentalapplications', 'user');
        try{
            $about_me_array   = $_SESSION['about_me_array'];
            $residence_array  = $_SESSION['residence_array'];
            $occupation_array = $_SESSION['occupation_array'];
            $references_array = $_SESSION['references_array'];

        $rentalApplicationsData = $rentalApplicationsTable->fetchRow($rentalApplicationsTable->select()->where('tenant_id = ?', $viwer_id));

        if(count($rentalApplicationsData) == 0){
        if($about_me_array['tenant_first_name'] !='' &&  $about_me_array['tenant_last_name'] !='' && $about_me_array['tenant_email'] !=''){

            if(isset($_SESSION['about_me_array'])){
            $about_me_array   = $_SESSION['about_me_array'];
            }
            else{
                $about_me_array = array(
                'tenant_first_name' => '',
                'tenant_last_name' => '',
                'tenant_email' => '',
                'tenant_phone_no' => '',
                'tennat_driver_license_no' => ''
                );
            }
            if(isset($_SESSION['residence_array'])){
                $residence_array  = $_SESSION['residence_array'];
            }
            else{

                $residence_array = array(
                'current_residence_housing_type' => '',
                'current_residence_address'      => '',
                'current_residence_move_in_date' => '',
                'current_residence_monthly_rent' => '',
                'current_residence_landlord_name'=> '',
                'current_residence_landlord_pno' => '',
                'current_residence_reson_for_leaving' => '',
                'previous_residence_housing_type'     => '',
                'previous_residence_address'     => '',
                'previous_residence_move_in_date'      => '',
                'previous_residence_monthly_rent'      => '',
                'previous_residence_landlord_name'     => '',
                'previous_residence_landlord_pno'      => '',
                'previous_residence_reson_for_leaving'     => '',
               );

            }

            if(isset($_SESSION['occupation_array'])){

                $occupation_array = $_SESSION['occupation_array'];

            }
            else{

                $occupation_array = array(

                'current_status' => '',
                'current_occupation_employer' => '',
                'current_occupation_job_title' => '',
                'current_occupation_monthly_salary' => '',
                'current_occupation_work_type' => '',
                'current_occupation_manager_name' => '',
                'current_occupation_pno' => '',
                'current_occupation_work_address' => '',
                'current_occupation_start_date' => '',
                'current_income_source' => '',
                'current_monthly_income' => '',
                'previous_status' => '',
                'previous_occupation_employer' => '',
                'previous_occupation_job_title' => '',
                'previous_occupation_monthly_salary' => '',
                'previous_occupation_work_type' => '',
                'previous_occupation_manager_name' => '',
                'previous_occupation_pno' => '',
                'previous_occupation_work_address' => '',
                'previous_occupation_end_date' => '',
                'previous_occupation_income_source' => '',
                'previous_occupation__monthly_income' => '',
                'additional_income_source' => '',
                'additional_income_amount' => '',
                'total_monthly_income' => ''
                );

            }

            if(isset($_SESSION['references_array'])){

                $references_array = $_SESSION['references_array'];
            }
            else{
                $references_array = "";
            }
            $rentalApplicationsId=   $rentalApplicationsTable->insert(array(
                    'tenant_id' => $viwer_id,
                    'tenant_firstname' => $about_me_array['tenant_first_name'],
                    'tenant_last_name' => $about_me_array['tenant_last_name'],
                    'tenant_email' => $about_me_array['tenant_email'],
                    'tenant_pno' => $about_me_array['tenant_phone_no'],
                    'driver_license_no' => $about_me_array['tennat_driver_license_no'],
                    'driver_license_no' => $about_me_array['tennat_driver_license_no'],
                    'current_residence_housing_type' => $residence_array['current_residence_housing_type'],
                    'current_residence_address' => $residence_array['current_residence_address'],
                    'current_residence_move_in_date' => $residence_array['current_residence_move_in_date'],
                    'current_residence_monthly_rent' => $residence_array['current_residence_monthly_rent'],
                    'current_residence_landlordname' => $residence_array['current_residence_landlord_name'],
                    'current_residence_landlord_pno' => $residence_array['current_residence_landlord_pno'],
                    'current_residence_leaving_reason' => $residence_array['current_residence_reson_for_leaving'],
                    'previous_residence_housing_type' => $residence_array['previous_residence_housing_type'],
                    'previous_residence_address' => $residence_array['previous_residence_address'],
                    'previous_residence_move_in_date' => $residence_array['previous_residence_move_in_date'],
                    'previous_residence_monthly_rent' => $residence_array['previous_residence_monthly_rent'],
                    'previous_residence_landlord_name' => $residence_array['previous_residence_landlord_name'],
                    'previous_residence_landlord_pno' => $residence_array['previous_residence_landlord_pno'],
                    'previous_residence_leaving_reason' => $residence_array['previous_residence_reson_for_leaving'],
                    'current_occupation_status' => $occupation_array['current_status'],
                    'current_occupation_employer' => $occupation_array['current_occupation_employer'],
                    'current_occupation_job_title' => $occupation_array['current_occupation_job_title'],
                    'current_occupation_monthly_salary' => $occupation_array['current_occupation_monthly_salary'],
                    'current_occupation_work_type' => $occupation_array['current_occupation_work_type'],
                    'current_occupation_manager_name' => $occupation_array['current_occupation_manager_name'],
                    'current_occupation_pno' => $occupation_array['current_occupation_pno'],
                    'current_occupation_work_address' => $occupation_array['current_occupation_work_address'],
                    'current_occupation_start_date' => $occupation_array['current_occupation_start_date'],
                    'current_occupation_income_source' => $occupation_array['current_income_source'],
                    'current_occupation_monthly_income' => $occupation_array['current_monthly_income'],
                    'previous_occupation_monthly_status' => $occupation_array['previous_status'],
                    'previous_occupation_employer' => $occupation_array['previous_occupation_employer'],
                    'previous_occupation_job_title' => $occupation_array['previous_occupation_job_title'],
                    'previous_occupation_monthly_salary' => $occupation_array['previous_occupation_monthly_salary'],
                    'previous_occupation_work_type' => $occupation_array['previous_occupation_work_type'],
                    'previous_occupation_manager_name' => $occupation_array['previous_occupation_manager_name'],
                    'previous_occupation_pno' => $occupation_array['previous_occupation_pno'],
                    'previous_occupation_work_address' => $occupation_array['previous_occupation_work_address'],
                    'previous_occupation_end_date' => $occupation_array['previous_occupation_end_date'],
                    'previous_occupation_income_source' => $occupation_array['previous_occupation_income_source'],
                    'previous_occupation__monthly_income' => $occupation_array['previous_occupation__monthly_income'],
                    'additional_income_sources' => $occupation_array['additional_income_source'],
                    'additional_income_amount' => $occupation_array['additional_income_amount'],
                    'total_monthly_income' => $occupation_array['total_monthly_income'],
                    'personal_reference_json' => $references_array,
                ));

                }
               }
               else{

                    if(isset($_SESSION['about_me_array'])){

                    $about_me_array   = $_SESSION['about_me_array'];

                    $rentalApplicationsData-> tenant_firstname = $about_me_array['tenant_first_name'];
                    $rentalApplicationsData-> tenant_last_name = $about_me_array['tenant_last_name'];
                    $rentalApplicationsData-> tenant_email = $about_me_array['tenant_email'];
                    $rentalApplicationsData-> tenant_pno = $about_me_array['tenant_phone_no'];
                    $rentalApplicationsData-> driver_license_no = $about_me_array['tennat_driver_license_no'];

                    $rentalApplicationsData->save();
                }
            if(isset($_SESSION['residence_array'])){

                $residence_array  = $_SESSION['residence_array'];

                $rentalApplicationsData-> current_residence_housing_type = $residence_array['current_residence_housing_type'];
                $rentalApplicationsData-> current_residence_address = $residence_array['current_residence_address'];
                $rentalApplicationsData-> current_residence_move_in_date = $residence_array['current_residence_move_in_date'];
                $rentalApplicationsData-> current_residence_monthly_rent = $residence_array['current_residence_monthly_rent'];
                $rentalApplicationsData-> current_residence_landlordname = $residence_array['current_residence_landlord_name'];
                $rentalApplicationsData-> current_residence_landlord_pno = $residence_array['current_residence_landlord_pno'];
                $rentalApplicationsData-> current_residence_leaving_reason = $residence_array['current_residence_reson_for_leaving'];
                $rentalApplicationsData-> previous_residence_housing_type = $residence_array['previous_residence_housing_type'];
                $rentalApplicationsData-> previous_residence_address = $residence_array['previous_residence_address'];
                $rentalApplicationsData-> previous_residence_move_in_date = $residence_array['previous_residence_move_in_date'];
                $rentalApplicationsData-> previous_residence_monthly_rent = $residence_array['previous_residence_monthly_rent'];
                $rentalApplicationsData-> previous_residence_landlord_name = $residence_array['previous_residence_landlord_name'];
                $rentalApplicationsData-> previous_residence_landlord_pno = $residence_array['previous_residence_landlord_pno'];
                $rentalApplicationsData-> previous_residence_leaving_reason = $residence_array['previous_residence_reson_for_leaving'];

                $rentalApplicationsData->save();
            }
            if(isset($_SESSION['occupation_array'])){

                $occupation_array = $_SESSION['occupation_array'];

                $rentalApplicationsData-> current_occupation_status = $occupation_array['current_status'];
                $rentalApplicationsData-> current_occupation_employer = $occupation_array['current_occupation_employer'];
                $rentalApplicationsData-> current_occupation_job_title = $occupation_array['current_occupation_job_title'];
                $rentalApplicationsData-> current_occupation_monthly_salary = $occupation_array['current_occupation_monthly_salary'];
                $rentalApplicationsData-> current_occupation_work_type = $occupation_array['current_occupation_work_type'];
                $rentalApplicationsData-> current_occupation_manager_name = $occupation_array['current_occupation_manager_name'];
                $rentalApplicationsData-> current_occupation_pno = $occupation_array['current_occupation_pno'];
                $rentalApplicationsData-> current_occupation_work_address = $occupation_array['current_occupation_work_address'];
                $rentalApplicationsData-> current_occupation_start_date = $occupation_array['current_occupation_start_date'];
                $rentalApplicationsData-> current_occupation_start_date = $occupation_array['current_occupation_start_date'];
                $rentalApplicationsData-> current_occupation_income_source = $occupation_array['current_income_source'];
                $rentalApplicationsData-> current_occupation_monthly_income = $occupation_array['current_monthly_income'];
                $rentalApplicationsData-> previous_occupation_monthly_status = $occupation_array['previous_status'];
                $rentalApplicationsData-> previous_occupation_employer = $occupation_array['previous_occupation_employer'];
                $rentalApplicationsData-> previous_occupation_job_title = $occupation_array['previous_occupation_job_title'];
                $rentalApplicationsData-> previous_occupation_monthly_salary = $occupation_array['previous_occupation_monthly_salary'];
                $rentalApplicationsData-> previous_occupation_work_type = $occupation_array['previous_occupation_work_type'];
                $rentalApplicationsData-> previous_occupation_manager_name = $occupation_array['previous_occupation_manager_name'];
                $rentalApplicationsData-> previous_occupation_pno = $occupation_array['previous_occupation_pno'];
                $rentalApplicationsData-> previous_occupation_work_address = $occupation_array['previous_occupation_work_address'];
                $rentalApplicationsData-> previous_occupation_end_date = $occupation_array['previous_occupation_end_date'];
                $rentalApplicationsData-> previous_occupation_income_source = $occupation_array['previous_occupation_income_source'];
                $rentalApplicationsData-> previous_occupation__monthly_income = $occupation_array['previous_occupation__monthly_income'];
                $rentalApplicationsData-> additional_income_sources = $occupation_array['additional_income_source'];
                $rentalApplicationsData-> additional_income_amount = $occupation_array['additional_income_amount'];
                $rentalApplicationsData-> total_monthly_income = $occupation_array['total_monthly_income'];


                $rentalApplicationsData->save();
            }


            if(isset($_SESSION['references_array'])){
                $references_array = $_SESSION['references_array'];
                $rentalApplicationsData-> personal_reference_json = $references_array;
                $rentalApplicationsData->save();
            }
            }
            unset($_SESSION['about_me_array']);
            unset($_SESSION['residence_array']);
            unset($_SESSION['occupation_array']);
            unset($_SESSION['references_array']);
        $aResult['status'] = true;
    }
        catch (Exception $e) {exit($e->getMessage());
                                $aResult['status'] = false;
                                $aResult['message'] = 'Failed';
                            }
        echo json_encode($aResult);

    }

    function insertstateabbreviationAction(){


        if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
        $stateTable = Engine_Api::_()->getDbtable('state', 'user');
        $states_arr  = array('AL'=>"Alabama",'AK'=>"Alaska",'AZ'=>"Arizona",'AR'=>"Arkansas",'CA'=>"California",'CO'=>"Colorado",'CT'=>"Connecticut",'DE'=>"Delaware",'FL'=>"Florida",'GA'=>"Georgia",'HI'=>"Hawaii",'ID'=>"Idaho",'IL'=>"Illinois", 'IN'=>"Indiana", 'IA'=>"Iowa",  'KS'=>"Kansas",'KY'=>"Kentucky",'LA'=>"Louisiana",'ME'=>"Maine",'MD'=>"Maryland", 'MA'=>"Massachusetts",'MI'=>"Michigan",'MN'=>"Minnesota",'MS'=>"Mississippi",'MO'=>"Missouri",'MT'=>"Montana",'NE'=>"Nebraska",'NV'=>"Nevada",'NH'=>"New Hampshire",'NJ'=>"New Jersey",'NM'=>"New Mexico",'NY'=>"New York",'NC'=>"North Carolina",'ND'=>"North Dakota",'OH'=>"Ohio",'OK'=>"Oklahoma", 'OR'=>"Oregon",'PA'=>"Pennsylvania",'RI'=>"Rhode Island",'SC'=>"South Carolina",'SD'=>"South Dakota",'TN'=>"Tennessee",'TX'=>"Texas",'UT'=>"Utah",'VT'=>"Vermont",'VA'=>"Virginia",'WA'=>"Washington",'DC'=>"Washington D.C.",'WV'=>"West Virginia",'WI'=>"Wisconsin",'WY'=>"Wyoming");

        foreach ($states_arr as $abbr => $state) {
                $stateData = $stateTable->fetchRow($stateTable->select()->where('state = ?', $state));
                if(!empty($stateData)){
                $stateData->state_abbr = $abbr;
                $stateData->save();
                }
        }
        exit("success");
    }


function smartmoveapicreaterenterformAction(){

    if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
        if( !empty($fieldsByAlias['profile_type']) ){
              $optionId = $fieldsByAlias['profile_type']->getValue($viewer);
              $profile_type_id = $optionId->value;
        }
        if($profile_type_id != 1){ //if not tenant
            return $this->_forward('notfound');
        }
        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('smartmove_api');
        $viewer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
        $fieldsTable = Engine_Api::_()->fields()->getTable('user', 'values');
        //get birthdate
        $birthdateData = $fieldsTable->fetchRow($fieldsTable->select()->where('item_id = ?', $viewer_id)->where('field_id = ?', 6));

        
         /* check the renter invited for background*/
                      
			$InvitedrentersbackgroundreportTable = Engine_Api::_()->getDbtable('Invitedrentersbackgroundreport', 'user');
		    $InvitedrentersbackgroundreportData      = $InvitedrentersbackgroundreportTable->fetchRow($InvitedrentersbackgroundreportTable->select()
										  ->where('renter_email  = ?', $viewer->email)
										  ->where('renter_id  = ?', $viewer_id)
										  ->where('backgroundReport  = ?', 0)                                  
										  );
										  
			if(count($InvitedrentersbackgroundreportData)>0){
				$landlordUser = Engine_Api::_()->user()->getUser($InvitedrentersbackgroundreportData->landlord_id);
						  
				$isInvitedForBackgroundReport  = 1;
				$confirmMsg  = "You are about to undergo Transunion credit and background review. This report will be sent to." .$landlordUser->displayname."when it is completed";
			}
		   else{
			   $isInvitedForBackgroundReport  = 1;
			}
							
        $this->view->birthdateData =$birthdateData;
    }

function smartmoveapicreaterentersaveAction(){
	
	if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        set_time_limit(0);
        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        $aData = $this->_request->getPost();
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viewer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
        $aResult=array();
        $City                   = $aData['City'];
        $City  = str_replace("-"," ",$City);
        $City  = str_replace("'"," ",$City);
        $AssetValue  = $aData['AssetValue'];
        $OtherIncome  = $aData['OtherIncome'];
        if($OtherIncome == ''){$OtherIncome = 0;}
        if($AssetValue == '') {$AssetValue = 0; }
        $params = array(
        'Email'                  => $aData['Email'],
        'FirstName'              => $aData['FirstName'],
        'MiddleName'             => $aData['MiddleName'],
        'LastName'               => $aData['LastName']  ,
        'DateOfBirth'            => $aData['DateOfBirth'] ,
        'SocialSecurityNumber'   => $aData['SocialSecurityNumber'],
        'EmploymentStatus'       => $aData['EmploymentStatus'],
        'StreetAddressLineOne'   => $aData['StreetAddressLineOne'],
        'StreetAddressLineTwo'   => $aData['StreetAddressLineTwo'] ,
        'City'                   => $City,
        'State'                  => $aData['State'] ,
        'Zip'                    => $aData['Zip']  ,
        'HomePhoneNumber'        => $aData['HomePhoneNumber'],
        'OfficePhoneNumber'      => $aData['OfficePhoneNumber'],
        'OfficePhoneExtension'   => $aData['OfficePhoneExtension'] ,
        'MobilePhoneNumber'      => $aData['MobilePhoneNumber'],
        'Income'                 => $aData['Income'] ,
        'IncomeFrequency'        => $aData['IncomeFrequency'],
        'OtherIncome'            => $OtherIncome,
        'OtherIncomeFrequency'   => $aData['OtherIncomeFrequency'] ,
        'AssetValue'             => $AssetValue,
        'FcraAgreementAccepted'  => $aData['FcraAgreementAccepted']
        );

        $params                           = json_encode($params);
        $viewHelperObj                    = $this->view->getHelper('SmartmoveApi125');
        $response                         = $viewHelperObj->createrenter($params);

        if ($response === false)
        {
            $aResult['status'] = false;
            $aResult['errors'] = curl_error($crl);
        }
        else{
            $data      = json_decode($response, true);
            if(empty($data['Errors'])){
                $smartmoveapiRenters_table =  Engine_Api::_()->getDbtable('Smartmoveapirenters', 'user');
                $smartmoveapiRenters_table->insert(array(

                        'tenant_id'                  => $viewer_id,
                        'Email'                      => $data['Email'],
                        'FirstName'                  => $data['FirstName'],
                        'MiddleName'                 => $data['MiddleName'],
                        'LastName'                   => $data['LastName'],
                        'DateOfBirth'                => $data['DateOfBirth'],
                        'SocialSecurityNumber'       => $data['SocialSecurityNumber'],
                        'EmploymentStatus'           => $data['EmploymentStatus'],
                        'StreetAddressLineOne'       => $data['StreetAddressLineOne'],
                        'StreetAddressLineTwo'       => $data['StreetAddressLineTwo'],
                        'City'                       => $data['City'],
                        'State'                      => $data['State'],
                        'Zip'                        => $data['Zip'],
                        'HomePhoneNumber'            => $data['HomePhoneNumber'],
                        'OfficePhoneNumber'          => $data['OfficePhoneNumber'],
                        'OfficePhoneExtension'       => $data['OfficePhoneExtension'],
                        'MobilePhoneNumber'          => $data['MobilePhoneNumber'],
                        'Income'                     => $data['Income'],
                        'IncomeFrequency'            => $data['IncomeFrequency'],
                        'OtherIncome'                => $data['OtherIncome'],
                        'OtherIncomeFrequency'       => $data['OtherIncomeFrequency'],
                        'AssetValue'                 => $data['AssetValue'],
                        'FcraAgreementAccepted'      => $data['FcraAgreementAccepted'],
                        'created_at'                 => date('Y-m-d'),
                        'updated_at'                 => date('Y-m-d')

                        ));

                        $userTable = Engine_Api::_()->getDbtable('users', 'user');
                        $userData  = $userTable->fetchRow($userTable->select()->where('user_id = ?', $viewer_id));
                        $userData->bg_verified = 1;
                        $userData->save();

                          /* smartmove api create application start*/
                       $propertyTable        =  Engine_Api::_()->getDbtable('propertylist', 'user');
                       $propertyData         =  $propertyTable->fetchRow($propertyTable->select()->where('property_type = ?', 'holding_property'));

                     $smartmoveapiProperty_table    =  Engine_Api::_()->getDbtable('Smartmoveapiproperty', 'user');

                      /* check the renter invited for background*/
                      
                     $InvitedrentersbackgroundreportTable = Engine_Api::_()->getDbtable('Invitedrentersbackgroundreport', 'user');
                     $InvitedrentersbackgroundreportData      = $InvitedrentersbackgroundreportTable->fetchRow($InvitedrentersbackgroundreportTable->select()
                                  ->where('renter_email  = ?', $viewer->email)
                                  ->where('renter_id  = ?', $viewer_id)
                                  ->where('backgroundReport  = ?', 0)                                  
                                  );
                      if(count($InvitedrentersbackgroundreportData)>0){
						  
                       $smartmoveapiPropertyData      = $smartmoveapiProperty_table->fetchRow($smartmoveapiProperty_table->select()
                          ->where('SmartmovePropertyId  = ?', $InvitedrentersbackgroundreportData->smartmovePid));	                         
                        $application_type = 'invited_property_application';  					  					  
					  }
					  else{
			          $smartmoveapiPropertyData      = $smartmoveapiProperty_table->fetchRow($smartmoveapiProperty_table->select()->where('Pid  = ?', $propertyData->id));
					  $application_type = 'holding_application';
					  }


                            $params = array(
                            'PropertyId'        => $smartmoveapiPropertyData->SmartmovePropertyId,
                            'UnitNumber'        => $smartmoveapiPropertyData->UnitNumber,
                            'Deposit'           => $smartmoveapiPropertyData->Deposit,
                            'Rent'              => $smartmoveapiPropertyData->Rent,
                            'LeaseTermInMonths' => $smartmoveapiPropertyData->LeaseTermInMonths,
                            'LandlordPays'      => $smartmoveapiPropertyData->LandlordPays,
                            'ProductBundle'     => $smartmoveapiPropertyData->ProductBundle,
                            'Applicants'        => array($viewer->email),
                            );
                            
                        // $res =   $viewHelperObj->getProperty($smartmoveapiPropertyData->SmartmovePropertyId);
                         // echo "<pre>"; print_r($res); exit;
                      $params   =   json_encode($params);
                      $response                         = $viewHelperObj->createapplication($params);
                      if ($response === false)
                        {
                            $aResult['status'] = false;
                            $aResult['errors'] = curl_error($crl);
                        }
                     else{
                         $data = json_decode($response, true);

                        if(empty($data['Errors'])){
                                $smartmoveapiApplication_table =  Engine_Api::_()->getDbtable('Smartmoveapiapplication', 'user');
                                $SmartmoveApplicationTableId =  $smartmoveapiApplication_table->insert(array(
                                            'rental_application_id'            => '',
                                            'SmartmovePropertyId'              => $smartmoveapiPropertyData->SmartmovePropertyId,
                                            'application_type'                 => $application_type,
                                            'SmartmoveApplicationId'           => $data['ApplicationId'],
                                            'UnitNumber'                       => $data['UnitNumber'],
                                            'Deposit'                          => $data['Deposit'],
                                            'Rent'                             => $data['Rent'],
                                            'LeaseTermInMonths'                => $data['LeaseTermInMonths'],
                                            'LandlordPays'                     => $data['LandlordPays'],
                                            'ProductBundle'                    => $data['ProductBundle'],
                                            'ApplicationStatus'                => 'NoActivity',
                                            'IdmaVerificationStatus'           => 'Unverified',
                                            'Applicants'                       => $viewer->email,
                                            'created_at'                       => date('Y-m-d'),
                                            'updated_at'                       => date('Y-m-d')

                                            ));
                                    /* smartmove api call for accept holding application*/
                                        $email         =  $viewer->email;
                                        $applicationId =  $data['ApplicationId'];
                                        $response      =  $viewHelperObj->AcceptApplicationRenterStatus($email,$applicationId);
                                        if ($response === false)
                                        {
                                            $aResult['status'] = false;
                                            $aResult['errors'] = curl_error($crl);
                                        }
                                        else{
                                           $data = json_decode($response, true);
                                           if(empty($data['Errors'])){
                                            $smartmoveapiApplicationData   = $smartmoveapiApplication_table->fetchRow($smartmoveapiApplication_table->select()->where('id      = ?', $SmartmoveApplicationTableId));

                                                $smartmoveapiApplicationData -> ApplicationStatus      = $data['ApplicationStatus'];
                                                $smartmoveapiApplicationData -> IdmaVerificationStatus = $data['IdmaVerificationStatus'];
                                                $smartmoveapiApplicationData -> updated_at             = date('Y-m-d');
                                                $smartmoveapiApplicationData -> save();                                             
                                                
                                                $aResult['status'] = true;
                                                
                                           }
                                           else{
                                                $aResult['status'] = false;
                                                $aResult['errors'] = $data['Errors'];
                                            }
                                        }
                                }
                                else{
                                    $aResult['status'] = false;
                                    $aResult['errors'] = $data['Errors'];
                                }
               }
            }
            else{
                  $aResult['status'] = false;
                  $aResult['errors'] = $data['Errors'];
           }
       }
      echo json_encode($aResult);

    }

    function smartmoveapiupdaterenterformAction(){

    if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);

        if( !empty($fieldsByAlias['profile_type']) ){

              $optionId = $fieldsByAlias['profile_type']->getValue($viewer);
              $profile_type_id = $optionId->value;

        }
        if($profile_type_id != 1){ //if not tenant

            return $this->_forward('notfound');

        }
        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('smartmove_api');
        $viewer_id                 =  Engine_Api::_()->user()->getViewer()->getIdentity();
        $smartmoveapiRenters_table =  Engine_Api::_()->getDbtable('Smartmoveapirenters', 'user');
        $smartmoveapiRentersData   =  $smartmoveapiRenters_table->fetchRow($smartmoveapiRenters_table->select()->where('tenant_id   = ?', $viewer_id));
        $this->view->smartmoveapiRentersData = $smartmoveapiRentersData;

    }

    function smartmoveapicreaterenterupdateAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        set_time_limit(0);
        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();

        $aData = $this->_request->getPost();

        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viewer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
        $aResult=array();

        $FirstName              = $aData['FirstName'];
        $MiddleName             = $aData['MiddleName'];
        $LastName               = $aData['LastName'];
        $Email                  = $aData['Email'];
        $DateOfBirth            = $aData['DateOfBirth'];
        $SocialSecurityNumber   = $aData['SocialSecurityNumber'];
        $EmploymentStatus       = $aData['EmploymentStatus'];
        $StreetAddressLineOne   = $aData['StreetAddressLineOne'];
        $StreetAddressLineTwo   = $aData['StreetAddressLineTwo'];
        $State                  = $aData['State'];
        $City                   = $aData['City'];
        $Zip                    = $aData['Zip'];
        $HomePhoneNumber        = $aData['HomePhoneNumber'];
        $OfficePhoneNumber      = $aData['OfficePhoneNumber'];
        $OfficePhoneExtension   = $aData['OfficePhoneExtension'];
        $MobilePhoneNumber      = $aData['MobilePhoneNumber'];
        $Income                 = $aData['Income'];
        $IncomeFrequency        = $aData['IncomeFrequency'];
        $OtherIncome            = $aData['OtherIncome'];
        $OtherIncomeFrequency   = $aData['OtherIncomeFrequency'];
        $AssetValue             = $aData['AssetValue'];
        $FcraAgreementAccepted  = $aData['FcraAgreementAccepted'];

        $City  = str_replace("-"," ",$City);
        $City  = str_replace("'"," ",$City);

       if($OtherIncome == ''){

            $OtherIncome = 0;
        }
        if($AssetValue == ''){

            $AssetValue = 0;
        }


        $params = array(

        'Email'                  => $Email,
        'FirstName'              => $FirstName,
        'MiddleName'             => $MiddleName,
        'LastName'               => $LastName  ,
        'DateOfBirth'            => $DateOfBirth ,
        'SocialSecurityNumber'   => $SocialSecurityNumber,
        'EmploymentStatus'       => $EmploymentStatus,
        'StreetAddressLineOne'   => $StreetAddressLineOne,
        'StreetAddressLineTwo'   => $StreetAddressLineTwo ,
        'City'                   => $City,
        'State'                  => $State ,
        'Zip'                    => $Zip  ,
        'HomePhoneNumber'        => $HomePhoneNumber,
        'OfficePhoneNumber'      => $OfficePhoneNumber,
        'OfficePhoneExtension'   => $OfficePhoneExtension ,
        'MobilePhoneNumber'      => $MobilePhoneNumber,
        'Income'                 => $Income ,
        'IncomeFrequency'        => $IncomeFrequency,
        'OtherIncome'            => $OtherIncome,
        'OtherIncomeFrequency'   => $OtherIncomeFrequency ,
        'AssetValue'             => $AssetValue,
        'FcraAgreementAccepted'  => $FcraAgreementAccepted


        );

        $params=json_encode($params); //print_r($params);

        $viewHelperObj = $this->view->getHelper('SmartmoveApi125');
        $response      = $viewHelperObj->updaterenter($params);




        if ($response === false)
        {
            $aResult['status'] = false;
            $aResult['errors'] = curl_error($crl);
        }
        else{

        $data = json_decode($response, true);

        if(empty($data['Errors'])){

        $smartmoveapiRenters_table =  Engine_Api::_()->getDbtable('Smartmoveapirenters', 'user');
        $smartmoveapiRentersData = $smartmoveapiRenters_table->fetchRow($smartmoveapiRenters_table->select()->where('tenant_id   = ?', $viewer_id));

        $smartmoveapiRentersData  -> Email                    = $data['Email'];
        $smartmoveapiRentersData  -> FirstName                = $data['FirstName'];
        $smartmoveapiRentersData  -> MiddleName               = $data['MiddleName'];
        $smartmoveapiRentersData  -> LastName                 = $data['LastName'];
        $smartmoveapiRentersData  -> DateOfBirth              = $data['DateOfBirth'];
        $smartmoveapiRentersData  -> SocialSecurityNumber     = $data['SocialSecurityNumber'];
        $smartmoveapiRentersData  -> EmploymentStatus         = $data['EmploymentStatus'];
        $smartmoveapiRentersData  -> StreetAddressLineOne     = $data['StreetAddressLineOne'];
        $smartmoveapiRentersData  -> StreetAddressLineTwo     = $data['StreetAddressLineTwo'];
        $smartmoveapiRentersData  -> City                     = $data['City'];
        $smartmoveapiRentersData  -> State                    = $data['State'];
        $smartmoveapiRentersData  -> Zip                      = $data['Zip'];
        $smartmoveapiRentersData  -> HomePhoneNumber          = $data['HomePhoneNumber'];
        $smartmoveapiRentersData  -> OfficePhoneNumber        = $data['OfficePhoneNumber'];
        $smartmoveapiRentersData  -> OfficePhoneExtension     = $data['OfficePhoneExtension'];
        $smartmoveapiRentersData  -> Income                   = $data['Income'];
        $smartmoveapiRentersData  -> IncomeFrequency          = $data['IncomeFrequency'];
        $smartmoveapiRentersData  -> OtherIncome              = $data['OtherIncome'];
        $smartmoveapiRentersData  -> OtherIncomeFrequency     = $data['OtherIncomeFrequency'];
        $smartmoveapiRentersData  -> AssetValue               = $data['AssetValue'];
        $smartmoveapiRentersData  -> FcraAgreementAccepted    = $data['FcraAgreementAccepted'];
        $smartmoveapiRentersData  -> updated_at               = date('Y-m-d');
        $smartmoveapiRentersData  -> save();
        $aResult['status'] = true;
         }
         else{
                    $aResult['status'] = false;
                    $aResult['errors'] = $data['Errors'];
         }
        }
        echo json_encode($aResult);
    }

    public function savesmartmoverentAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();

        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viewer_id=Engine_Api::_()->user()->getViewer()->getIdentity();

        $aData = $this->_request->getPost();
        if(!empty($aData)){

        $smartmove_rent_array = array('Deposit' => $aData['Deposit'],'Rent' => $aData['Rent'],
        'LeaseTermInMonths' => $aData['LeaseTermInMonths'],'LandlordPays' => $aData['LandlordPays'],
        'ProductBundle' => $aData['ProductBundle']
        );

        $_SESSION['smartmove_rent_array'] = $smartmove_rent_array;
        $aResult['status'] = true;
        }

       else{
            $aResult['status'] = false;
        }

        echo json_encode($aResult);

    }

    public function getcitywithstateabbreviationsAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

    $this->_helper->layout->disableLayout();
    $this->_helper->viewRenderer->setNoRender(true);
    $aResult       =  array();
    $state_abbr    =  $this->_getParam('state_abbr');
    if($state_abbr){
    $city_table    =  Engine_Api::_()->getDbtable('city', 'user');
    $citySelect    =  $city_table->select()
                        ->setIntegrityCheck(false)
                        ->from(array('city'=>'engine4_city_list',))
                        ->joinLeft(array('state'=>'engine4_state_list',),'state.state_id=city.state_id',array('state'))
                        ->where('state.state_abbr=?' , $state_abbr);
    $cityData     = $city_table->fetchAll($citySelect);
    $i            = 0;
    foreach($cityData as $list)
    {
        $aResult[$i]['id']  =   $list['city_id'];
        $aResult[$i]['city']    =   $list['city'];
        $i++;
    }
    
    }
    else{
		$aResult['status'] = 'false';
	}
    echo json_encode($aResult);
    }

    public function smartmoveapicreatereportAction(){

    if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $viewer        = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
        if( !empty($fieldsByAlias['profile_type']) ){
              $optionId        = $fieldsByAlias['profile_type']->getValue($viewer);
              $profile_type_id = $optionId->value;
        }
        if($profile_type_id != 1){ //if not tenant
            return $this->_forward('notfound');
        }
        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('smartmove_api');
        $viewer_id              =   Engine_Api::_()->user()->getViewer()->getIdentity();
        $smartmoveapiApplication_table =  Engine_Api::_()->getDbtable('Smartmoveapiapplication', 'user');
        $smartmoveapiApplicationData   = $smartmoveapiApplication_table->fetchRow($smartmoveapiApplication_table->select()->where('Applicants      = ?', $viewer->email));
        $SmartmoveApplicationId =   $smartmoveapiApplicationData->SmartmoveApplicationId;


        $viewHelperObj          =   $this->view->getHelper('SmartmoveApi125');
        $Email                  =   $viewer->email;
        $ApplicationStatusResponse = $viewHelperObj->getApplicationStatus($Email,$SmartmoveApplicationId);
        $ApplicationStatusResponse = json_decode($ApplicationStatusResponse, true);

        if($ApplicationStatusResponse['IdmaVerificationStatus'] == 'ManualVerificationRequired'){
            $this->view->message = 'You need manual verification to generate report. Please contact with Relationship Manager.';
        }
            if($ApplicationStatusResponse['IdmaVerificationStatus'] == 'Unverified'){

                $smartmoveapiRenters_table      =  Engine_Api::_()->getDbtable('Smartmoveapirenters', 'user');
                $smartmoveapiRentersData        = $smartmoveapiRenters_table->fetchRow($smartmoveapiRenters_table->select()->where('tenant_id   = ?', $viewer_id));
                $Smartmoveapiexamretrieve_table =  Engine_Api::_()->getDbtable('Smartmoveapiexamretrieve', 'user');
                $SmartmoveapiexamretrievesData  = $Smartmoveapiexamretrieve_table->fetchRow($Smartmoveapiexamretrieve_table->select()
                                                     ->where('Email     = ?', $smartmoveapiRentersData->Email)
                                                     ->order('id DESC'));
                $retreve_exam        = 0;
                $this->view->message = '';

                if(count($SmartmoveapiexamretrievesData) == 0){
                    $retreve_exam =1;
                }
                if(count($SmartmoveapiexamretrievesData) > 0){
                    if($SmartmoveapiexamretrievesData-> Evaluation == 'Fail'){
                        $retreve_exam        = 1;
                        $this->view->message = 'You are failed because you have not successfully completed IDMA for the application request. Please try again !';
                    }
                    elseif($SmartmoveapiexamretrievesData-> Evaluation == 'AdditionalQuestions'){
                        $retreve_exam       = 0;
                        $this->view->message = 'You are failed because you have not successfully completed IDMA for the application request. Please try again !';
                    }
                    else{
                        $retreve_exam =0;
                    }
                }

                if($retreve_exam == 1){
                    $OfficePhoneNumber            = $smartmoveapiRentersData->OfficePhoneNumber;
                    $OfficePhoneExtension         = $smartmoveapiRentersData->OfficePhoneNumber;
                    $MobilePhoneNumber            = $smartmoveapiRentersData->MobilePhoneNumber;
                    $OtherIncome                  = $smartmoveapiRentersData->OtherIncome;
                    $StreetAddressLineTwo         = $smartmoveapiRentersData->StreetAddressLineTwo;
                    $AssetValue                   = $smartmoveapiRentersData->AssetValue;
                    $OtherIncomeFrequency         = $smartmoveapiRentersData->OtherIncomeFrequency;
                    if($OfficePhoneNumber == '0'){
                        $OfficePhoneNumber = '';
                    }
                    if($OfficePhoneExtension == '0'){
                        $OfficePhoneExtension = '';
                    }
                    if($MobilePhoneNumber == '0'){
                        $MobilePhoneNumber ='';
                    }
                    if($OtherIncomeFrequency == 'Unknown'){
                        $OtherIncomeFrequency ='';
                    }
                    if($StreetAddressLineTwo == ''){
                        $StreetAddressLineTwo ='';
                    }
                    $params = array(
                        'Email'                             => $smartmoveapiRentersData->Email,
                        'FirstName'                         => $smartmoveapiRentersData->FirstName,
                        'MiddleName'                        => $smartmoveapiRentersData->MiddleName,
                        'LastName'                          => $smartmoveapiRentersData->LastName,
                        'DateOfBirth'                       => $smartmoveapiRentersData->DateOfBirth,
                        'SocialSecurityNumber'              => $smartmoveapiRentersData->SocialSecurityNumber,
                        'EmploymentStatus'                  => $smartmoveapiRentersData->EmploymentStatus,
                        'StreetAddressLineOne'              => $smartmoveapiRentersData->StreetAddressLineOne,
                        'StreetAddressLineTwo'              => $StreetAddressLineTwo,
                        'City'                              => $smartmoveapiRentersData->City,
                        'State'                             => $smartmoveapiRentersData->State,
                        'Zip'                               => $smartmoveapiRentersData->Zip,
                        'HomePhoneNumber'                   => $smartmoveapiRentersData->HomePhoneNumber,
                        'OfficePhoneNumber'                 => $OfficePhoneNumber,
                        'OfficePhoneExtension'              => $OfficePhoneExtension,
                        'MobilePhoneNumber'                 => $MobilePhoneNumber ,
                        'Income'                            => $smartmoveapiRentersData->Income,
                        'IncomeFrequency'                   => $smartmoveapiRentersData->IncomeFrequency,
                        'OtherIncome'                       => $OtherIncome,
                        'OtherIncomeFrequency'              => $OtherIncomeFrequency,
                        'AssetValue'                        => $AssetValue,
                        'FcraAgreementAccepted'             => true
                        );
                    $viewHelperObj = $this->view->getHelper('SmartmoveApi125');
                    $params        = json_encode($params);
                    $response      = $viewHelperObj->ExamRetrieve($params);
                    //print_r($response);exit("22");
                    if ($response === false)
                    {
                        $aResult['status'] = false;
                        $aResult['errors'] = curl_error($crl);
                    }
                    else{
                        $data = json_decode($response, true);
                        if(empty($data['Errors'])){
                            $Smartmoveapiexamretrieve_table =  Engine_Api::_()->getDbtable('Smartmoveapiexamretrieve', 'user');
                            $QuestionsJson                  = json_encode($data['Questions']);
                            $SmartmoveapiexamretrievesData  = $Smartmoveapiexamretrieve_table->fetchRow($Smartmoveapiexamretrieve_table->select()->where('Email   = ?', $data['Email']));

                                    $record_id = $Smartmoveapiexamretrieve_table->insert(array(
                                    'responseId'                   => $data['Id'],
                                    'SecurityToken'                => $data['SecurityToken'],
                                    'TimeOfRequest'                => $data['TimeOfRequest'],
                                    'Email'                        => $data['Email'],
                                    'Evaluation'                   => $data['Evaluation'],
                                    'QuestionsJson'                => $QuestionsJson,
                                    'created_at'                   => date('Y-m-d'),
                                    'updated_at'                   => date('Y-m-d')
                                    ));

                                $smartmoveapiRentersData->exam_retrieve_responseId = $data['Id'];
                                $smartmoveapiRentersData->save();
                                $aResult['status'] = true;
                        }
                        else{

                             $aResult['status'] = false;

                        }
                    }
                }
            }
        $smartmoveapiRenters_table      =  Engine_Api::_()->getDbtable('Smartmoveapirenters', 'user');
        $smartmoveapiRentersData        = $smartmoveapiRenters_table->fetchRow($smartmoveapiRenters_table->select()->where('tenant_id   = ?', $viewer_id));
        $Smartmoveapiexamretrieve_table =  Engine_Api::_()->getDbtable('Smartmoveapiexamretrieve', 'user');
        $SmartmoveapiexamretrievesData  = $Smartmoveapiexamretrieve_table->fetchRow($Smartmoveapiexamretrieve_table->select()->where('responseId  = ?', $smartmoveapiRentersData->exam_retrieve_responseId));
        $this->view->SmartmoveapiexamretrievesData = $SmartmoveapiexamretrievesData;
        $QuestionsJson                             = $SmartmoveapiexamretrievesData ->QuestionsJson;
        $QuestionArray                             = json_decode($QuestionsJson);
        $this->view->QuestionArray                 = json_decode(json_encode($QuestionArray),true);
        $this->view->SmartmoveApplicationId        = $SmartmoveApplicationId;
        $smartmoveapiApplication_table             =  Engine_Api::_()->getDbtable('Smartmoveapiapplication', 'user');
        $this->view->smartmoveapiApplicationData   =  $smartmoveapiApplicationData =  $smartmoveapiApplication_table->fetchRow($smartmoveapiApplication_table->select()->where('SmartmoveApplicationId      = ?', $SmartmoveApplicationId));
    }

    public function smartmoveapireportdoneAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        $aData         = $this->_request->getPost();
        $viewer        = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viewer_id     = Engine_Api::_()->user()->getViewer()->getIdentity();
        $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
        if( !empty($fieldsByAlias['profile_type']) ){
              $optionId        = $fieldsByAlias['profile_type']->getValue($viewer);
              $profile_type_id = $optionId->value;
        }
        if($profile_type_id != 1){ //if not tenant
            return $this->_forward('notfound');
        }
        $viewHelperObj     = $this->view->getHelper('SmartmoveApi125');
        $aResult           = array();
        $answerIds         = $aData['answer_ids'];
        $answerIds         = explode(',',$aData['answer_ids']); //print_r($answerIds); exit;
        $SmartmoveApplicationId    = $aData['SmartmoveApplicationId'];
        $smartmoveapiRenters_table      = Engine_Api::_()->getDbtable('Smartmoveapirenters', 'user');
        $smartmoveapiRentersData        = $smartmoveapiRenters_table->fetchRow($smartmoveapiRenters_table->select()->where('tenant_id   = ?', $viewer_id));
        $Smartmoveapiexamretrieve_table = Engine_Api::_()->getDbtable('Smartmoveapiexamretrieve', 'user');
        $SmartmoveapiexamretrievesData  = $Smartmoveapiexamretrieve_table->fetchRow($Smartmoveapiexamretrieve_table->select()->where('responseId  = ?', $smartmoveapiRentersData->exam_retrieve_responseId));
        $Id                             = $SmartmoveapiexamretrievesData->responseId;
        $SecurityToken                  = $SmartmoveapiexamretrievesData->SecurityToken;
        $TimeOfRequest                  = $SmartmoveapiexamretrievesData->TimeOfRequest;
        $Email                          = $SmartmoveapiexamretrievesData->Email;
        $Evaluation                     = $SmartmoveapiexamretrievesData->Evaluation;
        $QuestionsJson                  = $SmartmoveapiexamretrievesData->QuestionsJson;
        $QuestionsJson                  = $SmartmoveapiexamretrievesData ->QuestionsJson;
        $QuestionArray                  = json_decode($QuestionsJson);
        $QuestionArray                  = json_decode(json_encode($QuestionArray),true);
        $ResultData['Id']               = $Id;
        $ResultData['SecurityToken']    = $SecurityToken;
        $ResultData['TimeOfRequest']    = $TimeOfRequest;
        $ResultData['Email']            = $Email;
        $ResultData['Evaluation']       = null;
        $i                              = 0;
        $QuestionresultData             = array();
        $questionData                   = array();
            foreach($QuestionArray as $question){
            $i++;
            $tmpAnswerInfo                  = array();
            $questionData[0]['Id']          = $question['Id'];
            $questionData[0]['Text']        = $question['Text'];
            foreach($question['Answers'] as $answer) {
                        $answerInfo =   array(
                                                            'Id'  =>  $answer['Id'],
                                                            'Text'=>  $answer['Text']
                                            );
                        $tmpAnswerInfo[]    =   $answerInfo;
            }
            $questionData[0]['Answers']                 = $tmpAnswerInfo;
            $questionData[0]['SelectedAnswerId']        = $answerIds[$i];
            $QuestionresultData = array_merge($QuestionresultData,$questionData);
            }
            $ResultData['Questions'] = $QuestionresultData;
            $Exam                    = json_encode($ResultData,JSON_UNESCAPED_SLASHES);
            $examEvaluateResponse    = $viewHelperObj->evaluateExam($Exam,$Email,$SmartmoveApplicationId); // smartmove api exam evaluate
            if ($examEvaluateResponse === false)
            {
            $aResult['status'] = false;
            $aResult['errors'] = curl_error($crl);
            $aResult['Evaluation'] = 'Fail';
            }
            else{
                $examEvaluateResponse  = json_decode($examEvaluateResponse);
                $examEvaluateResponse  = json_decode(json_encode($examEvaluateResponse),true);
               // print_r($examEvaluateResponse); exit;

                if(empty($examEvaluateResponse['Errors'])){
                    $SmartmoveapiexamretrievesData->Evaluation = $examEvaluateResponse['Evaluation'];
                    $SmartmoveapiexamretrievesData->save();
                    if($examEvaluateResponse['Evaluation'] == 'Fail' ){
                    $aResult['status']     = true;
                    $aResult['Evaluation'] = $examEvaluateResponse['Evaluation'];
                    }
                    else if($examEvaluateResponse['Evaluation'] == 'AdditionalQuestions' ){
                        $Smartmoveapiexamretrieve_table =  Engine_Api::_()->getDbtable('Smartmoveapiexamretrieve', 'user');
                        $QuestionsJson                  = json_encode($examEvaluateResponse['Questions']);
                        $record_id = $Smartmoveapiexamretrieve_table->insert(array(
                                        'responseId'                   => $examEvaluateResponse['Id'],
                                        'SecurityToken'                => $examEvaluateResponse['SecurityToken'],
                                        'TimeOfRequest'                => $examEvaluateResponse['TimeOfRequest'],
                                        'Email'                        => $examEvaluateResponse['Email'],
                                        'Evaluation'                   => $examEvaluateResponse['Evaluation'],
                                        'QuestionsJson'                => $QuestionsJson,
                                        'created_at'                   => date('Y-m-d'),
                                        'updated_at'                   => date('Y-m-d')
                                        ));
                        $smartmoveapiRentersData->exam_retrieve_responseId = $examEvaluateResponse['Id'];
                        $smartmoveapiRentersData->save();
                        $aResult['status'] = true;
                        $aResult['Evaluation'] = $examEvaluateResponse['Evaluation'];
                    }
                    else if($examEvaluateResponse['Evaluation'] == 'Pass' ){
                                $aResult['status'] = true;
                                $aResult['errors'] = '';
                                $aResult['Evaluation'] = $examEvaluateResponse['Evaluation'];
                    }
                    else{
                                $SmartmoveapiexamretrievesData->Evaluation = 'Fail';
                                $SmartmoveapiexamretrievesData->save();
                                $aResult['status'] = false;
                                $aResult['errors'] = $examEvaluateResponse['Errors'];
                                $aResult['Evaluation'] = 'Fail';
                    }
                }
                else{

                    $SmartmoveapiexamretrievesData->Evaluation = 'Fail';
                    $SmartmoveapiexamretrievesData->save();
                    $aResult['status'] = false;
                    $aResult['errors'] = $examEvaluateResponse['Errors'];
                    $aResult['Evaluation'] = 'Fail';
                }
                $Email                         =  $viewer->email;
                $ApplicationStatusResponse     = $viewHelperObj->getApplicationStatus($Email,$SmartmoveApplicationId);
                $ApplicationStatusResponse     = json_decode($ApplicationStatusResponse, true);
                $smartmoveapiApplication_table =  Engine_Api::_()->getDbtable('Smartmoveapiapplication', 'user');
                $smartmoveapiApplicationData   = $smartmoveapiApplication_table->fetchRow($smartmoveapiApplication_table->select()->where('SmartmoveApplicationId      = ?', $SmartmoveApplicationId));
                $smartmoveapiApplicationData ->  ApplicationStatus      = $ApplicationStatusResponse['ApplicationStatus'];
                $smartmoveapiApplicationData ->  IdmaVerificationStatus = $ApplicationStatusResponse['IdmaVerificationStatus'];
                $smartmoveapiApplicationData -> updated_at              = date('Y-m-d');
                $smartmoveapiApplicationData -> save();
                $aResult['IdmaVerificationStatus']  = $ApplicationStatusResponse['IdmaVerificationStatus'];
            }
         echo json_encode($aResult);
    }

    public function requestreportAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        $aData      = $this->_request->getPost();
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viewer_id  = Engine_Api::_()->user()->getViewer()->getIdentity();
        $prtyId     = $aData['prtyId'];
        $renterId   = $aData['renterId'];
        $prtyName   = $aData['prtyName'];
        $requestId  = $aData['requestId'];
        $userTable                     =  Engine_Api::_()->getDbtable('users', 'user');
        $SmartmoveapireportTable       =  Engine_Api::_()->getDbtable('Smartmoveapireport', 'user');
        $smartmoveapiApplication_table =  Engine_Api::_()->getDbtable('Smartmoveapiapplication', 'user');
        $Reportrequest_table           =  Engine_Api::_()->getDbtable('Reportrequest', 'user');
        $renterData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $renterId));
        $settings                      = Engine_Api::_()->getApi('settings', 'core');
        $duration        = $settings->user_backgroundReportExpiry;
        $days            = "+".$duration." days";
        $expiry_date     = date('d-m-Y', strtotime($days));
        $ReportrequestId =   $Reportrequest_table->insert(array(
                   // 'SmartmoveApplicationId'  => $smartmoveapiApplicationData->SmartmoveApplicationId,
                    'renter_id'               => $renterId,
                    'landlord_id'             => $viewer_id,
                    'status'                  => 'Requested',
                    'expiry_date'             => $expiry_date,
                    'requested_date'          => date('Y-m-d H:i:s'),
                    'created_at'              =>  date('Y-m-d'),
                    'updated_at'              =>  date('Y-m-d')
                    ));
           // send notification

        Engine_Api::_()->getDbtable('notifications', 'activity')
                ->addNotification($renterData, $viewer, $renterData, 'report_request',array(
              'label' => $prtyName,'pid' => $aData['prtyId']));
        $aResult['status'] = true;
        echo json_encode($aResult);
    }

    public function reportpaymentAction(){

        if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $viewer        = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
        if( !empty($fieldsByAlias['profile_type']) ){
              $optionId        = $fieldsByAlias['profile_type']->getValue($viewer);
              $profile_type_id = $optionId->value;
        }
        if($profile_type_id != 1){ //if not tenant
            return $this->_forward('notfound');
        }
        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('smartmove_api');
        $viewer_id   =   Engine_Api::_()->user()->getViewer()->getIdentity();
        $smartmoveApplicationId                 =  $this->_getParam('id');
        $viewHelperObj                          =  $this->view->getHelper('SmartmoveApi125');
        $PaymentpackageTable                    =  Engine_Api::_()->getDbtable('Paymentpackage', 'user');
        $StripeSettingsTable                    =  Engine_Api::_()->getDbtable('Stripesettings', 'user');
        $StripeSettingsData                     =  $StripeSettingsTable->fetchRow($StripeSettingsTable->select()->where('id = ?', 1));
        $PaymentpackageData                     =  $PaymentpackageTable->fetchAll($PaymentpackageTable->select()->where('user_id = ?', $viewer_id));
        $payment_count                          =  count($PaymentpackageData);        
        $settings                      = Engine_Api::_()->getApi('settings', 'core');


        
        $credit_and_background_payment_amount         =  $settings->user_creditAndBackgroundPaymentAmount;
        $creditbackground_eviction_payment_amount     =  $settings->user_creditAndBackgroundPlusEvictionPaymentAmount;
        $creditscore_payment_amount                   =  $settings->user_creditScorePaymentAmount;
        $deduction_per_each_payment                   =  $settings->user_deductionPerEachPayment;
        $payment_duration                             =  $settings->user_backgroundReportExpiry;
        if(isset($_SESSION['err_message'])){
            $this->view->message = $_SESSION['err_message'];
        }

        if($payment_count > 0){
            $credit_and_background_payment_amount       = $credit_and_background_payment_amount-($deduction_per_each_payment * $payment_count);
            $creditbackground_eviction_payment_amount   = $creditbackground_eviction_payment_amount-($deduction_per_each_payment * $payment_count);
        }
        $this->view->credit_and_background_payment_amount     = $credit_and_background_payment_amount;
        $this->view->creditbackground_eviction_payment_amount = $creditbackground_eviction_payment_amount;
        $this->view->creditscore_payment_amount               = $creditscore_payment_amount;
        $this->view->payment_duration                         = $payment_duration;
        $stripefiles     = $viewHelperObj->getStripeFiles(); // smartmove api exam evaluate
        $params = array(
            "testmode"   => "on",
            "private_live_key" => "sk_live_bcnF3vdwkx2Q405aOq7POiep",
            "public_live_key"  => "pk_live_evBvNtpwiJlCwieyHNPKsQLO",
            "private_test_key" => "sk_test_K2gnuPgv5SH1P3lkvw86TJIQ",
            "public_test_key"  => "pk_test_kCahdc8oaSK65WPNb3iClcF1"
        );

        if ($params['testmode'] == "on") {
        Stripe::setApiKey($params['private_test_key']);
        $pubkey = $params['public_test_key'];
        } else {
        Stripe::setApiKey($params['private_live_key']);
        $pubkey = $params['public_live_key'];
        }
        $this->view->params = $params;
        if(isset($_POST['stripeToken']))
        {
            $selected_packagerate = $_POST['selected_packagerate'];
            $selected_package     = $_POST['selected_package'];
            $score                = $_POST['score'];
            $cardholder_name      = $_POST['cardholder_name'];
            $last_name            = $_POST['last_name'];
            $street               = $_POST['street'];
            $city                 = $_POST['LandlordCity'];
            $state                = $_POST['LandlordState'];
            $zipcode              = $_POST['zipcode'];
     //       $billing_address      = $_POST['billing_address'];

            if($score == 1){
                $transunion_score_rate = $creditscore_payment_amount;
                $package_rate = $selected_packagerate + $creditscore_payment_amount;
            }
            else{
                $transunion_score_rate = 0;
                $package_rate = $selected_packagerate;
            }
            $amount_cents = str_replace(".","",$package_rate);  // Chargeble amount
            $amount_cents = (int)($package_rate * 100) ;
            $invoiceid = "14526321";                      // Invoice ID
            $description = "Invoice #" . $invoiceid . " - " . $invoiceid;
            try {
            $charge = Stripe_Charge::create(array(
                  "amount"      => $amount_cents,
                  "currency"    => "usd",
                  "source"      => $_POST['stripeToken'],
                  "description" => $description
                  )
            );

                if ($charge->card->address_zip_check == "fail") {
                    throw new Exception("zip_check_invalid");
                } else if ($charge->card->address_line1_check == "fail") {
                    throw new Exception("address_check_invalid");
                } else if ($charge->card->cvc_check == "fail") {
                    throw new Exception("cvc_check_invalid");
                }
            // Payment has succeeded, no exceptions were thrown or otherwise caught
            $result = "success";
            }
            catch(Stripe_CardError $e) {

            $error = $e->getMessage();
                $result = "declined";

            } catch (Stripe_InvalidRequestError $e) {
                $result = "declined";
                $err = $e->getMessage();
            } catch (Stripe_AuthenticationError $e) {
                $result = "declined";
                 $err = $e->getMessage();
            } catch (Stripe_ApiConnectionError $e) {
                $result = "declined";
                 $err = $e->getMessage();
            } catch (Stripe_Error $e) {
                $result = "declined";
                 $err = $e->getMessage();
            } catch (Exception $e) {

                if ($e->getMessage() == "zip_check_invalid") {
                    $result = "declined";
                } else if ($e->getMessage() == "address_check_invalid") {
                    $result = "declined";
                } else if ($e->getMessage() == "cvc_check_invalid") {
                    $result = "declined";
                } else {
                    $result = "declined";
                }
                 $err = $e->getMessage();
            }

            //echo '<pre>'; print_r($response1); exit;
            if($result == 'success'){
				
            $paymentResponse =  $charge->__toJSON();
            $response1 =json_decode($response);
            $response2 = json_decode(json_encode($response1));
                unset($_SESSION['err_message']);
                $PaymentpackageTable  =  Engine_Api::_()->getDbtable('Paymentpackage', 'user');
                $duration             = $payment_duration;
                $days                 = "+".$duration." days";
                $expiry_date          = date('d-m-Y', strtotime($days));



                $PaymentpackageTableId=   $PaymentpackageTable->insert(array(
                    'user_id'                         => $viewer_id,
                    'cardholder_name'                 => $cardholder_name,
                    'last_name'                       => $last_name,
                    'street'                          => $street,
                    'city'                            => $city,
                    'state'                           => $state,
                    'zipcode'                         => $zipcode,
                 //   'billing_address'                 => $billing_address,
                    'package_name'                    => $selected_package,
                    'package_rate'                    => $selected_packagerate,
                    'transunion_score_rate'           => $transunion_score_rate,
                    'score'                           => $score,
                    'active'                          => 1,
                    'expiry_date'                     => $expiry_date,
                    'paymentResponse'                 => $paymentResponse,
                    'payment_date'                    => date('d-m-Y'),
                    'created_at'                      => date('Y-m-d'),
                    'updated_at'                      => date('Y-m-d')
                    ));
                $SmartmoveapireportPaymentTable = Engine_Api::_()->getDbtable('Smartmoveapireportpayment', 'user');
                $SmartmoveapireportPaymentId    =   $SmartmoveapireportPaymentTable->insert(array(
                    'paidUserId'                 => $viewer_id,
                    'paymentAmount'              => $package_rate,
                    'paymentResponse'            => $paymentResponse,
                    'created_at'                 => date('Y-m-d'),
                    'updated_at'                 => date('Y-m-d')
                ));
             echo "<script language='javascript' type='text/javascript'>";
             echo "jQuery('#successModal .success_message').text('');";
             echo "jQuery('#successModal .success_message').text('You have successfully submitted your payment');";
             echo "jQuery('#successModal').modal('show');";
             echo "</script>";
            }
            else{
                $_SESSION['err_message'] = $err;
                return $this->_helper->redirector->gotoRoute(array(), 'smartmoveapi_reportpayment', true);
            }
       }
    }

    public function reportAction(){

        if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $viewer        = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('smartmove_api');
        $viewer_id     =  Engine_Api::_()->user()->getViewer()->getIdentity();
        //$smartmoveApplicationId = $this->_getParam('id');
        $renter_id     = $this->_getParam('id');

        $SmartmoveapireportTable   = Engine_Api::_()->getDbtable('Smartmoveapireport', 'user');
        $SmartmoveapireportData    = $SmartmoveapireportTable->fetchRow($SmartmoveapireportTable->select()->where('RenterId = ?', $renter_id)->where('status =? ','Active'));
        $report_response           =  $SmartmoveapireportData -> reportResponse;
        $reportData                = json_decode($report_response, true);
        foreach($reportData['Applicants'] as $applicant):
         $ApplicantStatus = $applicant['ApplicantStatus'];
        endforeach;
        if($ApplicantStatus =='ReportsRequested'){
            $viewHelperObj       = $this->view->getHelper('SmartmoveApi125');
            $applicationResponse = $viewHelperObj->getApplication($SmartmoveapireportData -> SmartmoveApplicationId);

                            if ($applicationResponse === false)
                            {
                                $aResult['status'] = false;
                                $aResult['errors'] = curl_error($crl);
                            }
                            $applicationData = json_decode($applicationResponse, true);
                            if(empty($applicationData['Errors'])){  //print_r($applicationData); exit;
                                $SmartmoveapireportData->reportResponse = $applicationResponse;
                                $SmartmoveapireportData->save();
                            }
        }
        $PaymentpackageTable    =  Engine_Api::_()->getDbtable('Paymentpackage', 'user');
        $PaymentpackageData     = $PaymentpackageTable->fetchRow($PaymentpackageTable->select()->where('user_id = ?', $renter_id));
        $SmartmoveapireportData = $SmartmoveapireportTable->fetchRow($SmartmoveapireportTable->select()->where('RenterId = ?', $renter_id)->where('status =? ','Active'));
        $report_response        =  $SmartmoveapireportData -> reportResponse;
        $reportData             = json_decode($report_response, true);

        $this->view->reportData         =  $reportData;
        $this->view->PaymentpackageData =  $PaymentpackageData;
       // print_r($reportData); exit;
    }

    public function filterfeedbymatchesAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();

        if(isset($_SESSION['countryId'])){
            unset($_SESSION['countryId']);
            unset($_SESSION['stateId']);
            unset($_SESSION['cityId']);
        }
        unset($_SESSION['set_to_usa']);
        unset($_SESSION['feedicon']);
        unset($_SESSION['matching_array']);
        unset($_SESSION['feedpreferenceunit']);
        unset($_SESSION['feedpreferenceunitmore']);
        unset($_SESSION['location_mode_array']);
        unset($_SESSION['zipcode']);
        unset($_SESSION['country_name']);
        unset($_SESSION['state_name']);
        unset($_SESSION['city_name']);
        unset($_SESSION['county_name']);
        unset($_SESSION['neighborhood_name']);

        if( $this->getRequest()->isPost()){
        $propertycountrtyTable  =  Engine_Api::_()->getDbtable('propertycountry', 'user');
        $propertystateTable     =  Engine_Api::_()->getDbtable('propertystate', 'user');
        $propertycityable       =  Engine_Api::_()->getDbtable('propertycity', 'user');

        $housing_types     = '';
        $is_petsallowd     = '';
        $pets_type         = '';
        $price             = '';
        $number_of_rooms   = 0;
        $viewer_id         = $viewer->getIdentity();
        $aData             = $this->_request->getPost();
        $housing_types     = $aData['housing_types'];
        $is_petsallowd     = $aData['is_petsallowd'];
        $pets_type         = $aData['pets_type'];
        $price             = $aData['price'];
        $price_to          = $aData['price_to'];
        $number_of_rooms   = $aData['number_of_rooms'];
        $countryName       = $aData['PreferenceCountry'];
        $stateName         = $aData['PreferenceState'];
        $cityName          = $aData['PreferenceCity'];
        $countyName        = $aData['PreferenceCounty'];
        $neighborhoodName  = $aData['PreferenceNeighborhood'];
        $zip               = $aData['PreferenceZip'];
        $scout_name        = $aData['scout_name'];
        $countryId = 0;
        $stateId   = 0;
        $cityId    = 0;

        $FeedPreferenceUnitTable = Engine_Api::_()->getDbtable('Feedpreferenceunit', 'user');

        $FeedPreferenceUnitDataSelect = $FeedPreferenceUnitTable->select()
                                    ->where('userid = ?', $viewer_id)
                                    ->where('housing_type = ?',   $housing_types)
                                    ->where('is_petsallowd = ?',   $is_petsallowd)
                                    ->where('pets_type = ?',   $pets_type)
                                    ->where('price = ?',   $price)
                                    ->where('price_to = ?',   $price_to)
                                    ->where('number_of_rooms = ?',   $number_of_rooms)
                                    ->where('countryId = ?',   $countryId)
                                    ->where('stateId = ?',   $stateId)
                                    ->where('cityId = ?',   $cityId)
                                    ->where('countryName = ?',   $countryName)
                                    ->where('stateName = ?',   $stateName)
                                    ->where('cityName = ?',   $cityName)
                                    ->where('countyName = ?',   $countyName)
                                    ->where('neighborhoodName = ?',   $neighborhoodName)
                                    ->where('zip = ?',   $zip);

                $FeedPreferenceUnitData    = $FeedPreferenceUnitTable->fetchRow($FeedPreferenceUnitDataSelect);
                if(empty($FeedPreferenceUnitData)){
                    $FeedPreferenceUnitId  =   $FeedPreferenceUnitTable->insert(array(
                    'userid'          => $viewer_id,
                    'housing_type'    => $housing_types,
                    'is_petsallowd'   => $is_petsallowd,
                    'pets_type'       => $pets_type,
                    'price'           => $price,
                    'price_to'        => $price_to,
                    'number_of_rooms' => $number_of_rooms,
                    'countryId'       => $countryId,
                    'stateId'         => $stateId,
                    'cityId'          => $cityId,
                    'countryName'     => $countryName,
                    'stateName'       => $stateName,
                    'cityName'        => $cityName,
                    'countyName'      => $countyName,
                    'neighborhoodName'=> $neighborhoodName,
                    'zip'             => $zip,
                    'scout_name'      => $scout_name,
                    'created_at'      => date('Y-m-d'),
                    'updated_at'      => date('Y-m-d')
                    ));
                
              $matching_array =[];

              $matching_array['housing_types']     = $housing_types;
              $matching_array['is_petsallowd']     = $is_petsallowd;
              $matching_array['pets_type']         = $pets_type;
              $matching_array['price']             = $price;
             // $pricearray =  explode('-', $matching_array['price']);
             // $matching_array['price_from']      = (int)$pricearray['0'];
             // $matching_array['price_to']        = (int)$pricearray['1'];
              $matching_array['price_from']        = $price;
              $matching_array['price_to']          = $price_to;
              $matching_array['no_of_bedrooms']    = $number_of_rooms;
              $matching_array['countryId']         = $countryId;
              $matching_array['stateId']           = $stateId;
              $matching_array['cityId']            = $cityId;
              $matching_array['countryName']       = $countryName;
              $matching_array['stateName']         = $stateName;
              $matching_array['cityName']          = $cityName;
              $matching_array['countyName']        = $countyName;
              $matching_array['neighborhoodName']  = $neighborhoodName;
              $matching_array['zip']               = $zip;

              $FeedPreferenceSelect = $FeedPreferenceUnitTable->select()
                                                ->where('userid = ?', $viewer_id);
              $FeedPreferenceUnitData              =   $FeedPreferenceUnitTable->fetchAll($FeedPreferenceSelect);
              $data_count                          =   count($FeedPreferenceUnitData);
              $matching_array['preference_name']   =  "Preference ".$data_count;
              $_SESSION['matching_array']          =   $matching_array;
              //print_r($matching_array); exit;
              $aResult['status'] = true;
              $aResult['message'] = 'success';
		  }
		  else{
			  $aResult['status'] = false;
			  $aResult['message'] = 'already added';
			  
		  }
        }
        else{
              $aResult['status'] = false;
        }
        echo json_encode($aResult['status']);
    }
    public function requirementlistAction(){

        if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('property_detail');
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viewer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
        $userid                   =   $this->_getParam('id');
        $propertyRequirementTable =  Engine_Api::_()->getDbtable('propertyrequirement', 'user');

        $propertyRequirementSelect   =   $propertyRequirementTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('property_req'=>'engine4_property_requirement',))
                        ->joinLeft(array('country'=>'engine4_property_countries',),'property_req.country_id=country.country_id',array('prty_country'))
                        ->joinLeft(array('state'=>'engine4_property_states',),'property_req.state_id=state.state_id',array('prty_state'))
                        ->joinLeft(array('city'=>'engine4_property_city',),'property_req.city_id=city.city_id',array('prty_city','latitude','longitude'))
                        ->where('property_req.tenant_id =?' ,  $userid)
                        ->order('property_req.id DESC');
        $this->view->propertyRequirementData = $propertyRequirementTable->fetchAll($propertyRequirementSelect);

        $this->view->userid                  = $userid;

        $userTable                           = Engine_Api::_()->getDbtable('users', 'user');

        $this->view->UserData                = $userTable->fetchRow($userTable->select()->where('user_id = ?',$userid));
        //echo '<pre>'; print_r($propertyRequirementData); exit;
    }
    public function tipdismisstimeAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

    $viewer     = Engine_Api::_()->user()->getViewer();
    $this->_helper->viewRenderer->setNoRender(true);
    $this->_helper->layout->disableLayout();
   // date_default_timezone_set('Asia/Calcutta');
    date_default_timezone_set($viewer->timezone);
    $dismissdatetime        = date('H:i:s d-m-Y');
    $viewer                 = Engine_Api::_()->user()->getViewer();
    $viewerId               =   $viewer->getIdentity();
    $userTable              = Engine_Api::_()->getDbtable('users', 'user');
    $UserData               = $userTable->fetchRow($userTable->select()->where('user_id = ?', $viewerId));

        try{
             $datetime               =  $UserData->tip_dismiss_time = $dismissdatetime;
             $UserData->save();
             $_SESSION['tipdismiss'] = 1;
             $aResult['status']      = true;
         }
        catch (Exception $e) {
            exit($e->getMessage());
            $aResult['status'] = false;
        }
    echo json_encode($aResult);

    }


    public function gettipdismisstimeAction()
    {
    if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
    $viewer     = Engine_Api::_()->user()->getViewer();
    date_default_timezone_set($viewer->timezone);
    $this->_helper->viewRenderer->setNoRender(true);
    $this->_helper->layout->disableLayout();
    $common_settings_table =  Engine_Api::_()->getDbtable('commonsettings', 'user');
    $common_settings = $common_settings_table->fetchRow($common_settings_table->select()->where('type =?', 'tip_duration'));

    if($viewer->tip_dismiss_time=='')
    {
    $aResult['tipemty']=1;
    }
    if($viewer->tip_dismiss_time !=''){
        $tipdismisdatetime= $viewer->tip_dismiss_time;
        //date_default_timezone_set('Asia/Calcutta');
        date_default_timezone_set($viewer->timezone);
        $currentdatetime = date('H:i:s d-m-Y');
        $currentdatetime = DateTime::createFromFormat('H:i:s d-m-Y', $currentdatetime);
        $tipdismisdatetime = DateTime::createFromFormat('H:i:s d-m-Y', $tipdismisdatetime);
        $interval = $currentdatetime->diff($tipdismisdatetime);
        $current_tipdismiss_difference = ($interval->days * 24) + $interval->h+ ($interval->i / 60) + ($interval->s / 3600);

        if($current_tipdismiss_difference>=$common_settings->value)
        {
        $aResult['block']=1;
        }
        else
        {
        $aResult['block']=0;
        }
         $aResult['status'] = true;
     }
     else{
         $aResult['status'] = false;
    }
    echo json_encode($aResult);

    }

    public function schedulerAction(){

        if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('property_detail');
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viewer_id  = Engine_Api::_()->user()->getViewer()->getIdentity();
        $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
        $userTable     = Engine_Api::_()->getDbtable('users', 'user');
        if( !empty($fieldsByAlias['profile_type']) ){
              $optionId = $fieldsByAlias['profile_type']->getValue($viewer);
              $profile_type_id = $optionId->value;
        }

        if($profile_type_id == 1){ // if renter
		
		 return $this->_forward('notfound');	
			
        $propertyRequestTable       =  Engine_Api::_()->getDbtable('propertyrequest', 'user');
        $userSelect                 = $propertyRequestTable->select()
                              ->setIntegrityCheck(false)
                               ->from(array('prequest'=>'engine4_property_request',))
                               ->joinLeft(array('user'=>'engine4_users'),'prequest.landlord_id  = user.user_id',array('bg_verified','user_id','displayname'))
                               ->where('prequest.tenant_id = ?', $viewer_id)
                               ->order('prequest.id DESC')
                               ->group('user.user_id');         // fetch landlords
        }
        if($profile_type_id == 4){ // if landlord
        $propertyRequestTable =  Engine_Api::_()->getDbtable('propertyrequest', 'user');
        $userSelect = $propertyRequestTable->select()
                              ->setIntegrityCheck(false)
                               ->from(array('prequest'=>'engine4_property_request',))
                               ->joinLeft(array('user'=>'engine4_users'),'prequest.tenant_id    = user.user_id',array('bg_verified','user_id','displayname'))
                               ->where('prequest.landlord_id = ?', $viewer_id)
                               ->order('prequest.id DESC')
                               ->group('user.user_id'); // fetch renters who request property
     }
        $this->view->usersData = $propertyRequestTable->fetchAll($userSelect);
    }
    public function saveschedulerAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viewer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();

        if( $this->getRequest()->isPost()){
            $aData = $this->_request->getPost();
            $scheduled_with = $aData['scheduled_with'];
            $scheduled_date = $aData['scheduled_date'];
            $scheduled_time = $aData['scheduled_time'];


            $meetingSchedulerTable =  Engine_Api::_()->getDbtable('meetingscheduler', 'user');
            
            $meetingSchedulerData = $meetingSchedulerTable->fetchRow($meetingSchedulerTable->select()
                                               ->where('scheduled_by = ?',   $viewer_id)
                                               ->where('scheduled_date = ?', $aData['scheduled_date'])
                                               ->where('scheduled_time = ?', $aData['scheduled_time'])
            );
            if(count($meetingSchedulerData)>0){
				$aResult['status'] = false;
				$aResult['message'] = 'You have already scheduled a meeting with someone at same time';
			}
			else{
            
            $meetingSchedulerid=   $meetingSchedulerTable->insert(array(

                    'scheduled_by'         => $viewer_id,
                    'scheduled_with'       => $aData['scheduled_with'],
                    'sheduledby_usertype'  => 'landlord',
                    'scheduled_date'  => $aData['scheduled_date'],
                    'scheduled_time'  => $aData['scheduled_time'],
                    'survey_notification_status'  => '0',
                    'approved'                    => '1',
                    'created_at'      => date('Y-m-d'),
                    'updated_at'      => date('Y-m-d')

                    ));

                     // send notification

        $userTable = Engine_Api::_()->getDbtable('users', 'user');
        $resciverData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $scheduled_with));
        Engine_Api::_()->getDbtable('notifications', 'activity')
                ->addNotification($resciverData, $viewer, $resciverData, 'meeting_scheduler',array(
              'scheduled_date' => $scheduled_date,'scheduled_time' => $scheduled_time));
              // send mail
        $from_email    = Engine_Api::_()->getApi('settings', 'core')->core_mail_from;

        $bodyTextContent = '';

                         if (file_exists("emailtemplates/meeting_scheduler_email.html")) {
                            $htmlExist = true;
                            $file = fopen("emailtemplates/meeting_scheduler_email.html", "r");
                            while(!feof($file))
                            {
                                $bodyTextContent .= fgets($file);
                            }
                            fclose($file);
                        }

                            if($htmlExist){
                              $sendername       = '{sendername}';
                              $rescivername     = '{rescivername}';
                              $senderurl        = '{senderurl}';
                              $scheduleddate    = '{scheduleddate}';
                              $scheduled_time   = '{scheduledtime}';
                              $redirectUrl      = '{redirectUrl}';
                              $sender_url       = $_SERVER['HTTP_HOST']."/profile/".$viewer_id;
                              $redirect_url     = $_SERVER['HTTP_HOST']."/scheduler/meetings/requests";
                              $bodyTextTemplate = '';
                              $bodyHtmlTemplate = $bodyTextContent;
                            foreach( $rParams as $var => $val ) {
                              $raw = trim($var, '[]');
                              $var = '[' . $var . ']';
                              if( !$val ) {
                                $val = $var;
                              }
                              // Fix nbsp
                              $val = str_replace('&amp;nbsp;', ' ', $val);
                              $val = str_replace('&nbsp;', ' ', $val);
                              // Replace
                             $bodyTextTemplate = str_replace($var, $val, $bodyTextTemplate);
                             $bodyHtmlTemplate = str_replace($var, $val, $bodyHtmlTemplate);
                            }
                            $bodyTextTemplate = strip_tags($bodyTextTemplate);
                            $bodyHtmlTemplate = str_replace($sendername, $viewer->displayname, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($rescivername, $resciverData->displayname, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($senderurl, $sender_url, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($redirectUrl, $redirect_url, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($scheduleddate, $aData['scheduled_date'], $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($scheduled_time, $aData['scheduled_time'], $bodyHtmlTemplate);

                            }
                    $subject = "Meeting Scheduler";
                    $header  = "From: ".'Rentstarz'." <".$from_email.">\r\n";
                    $header .= "MIME-Version: 1.0\r\n";
                    $header .= 'Content-type: text/html; charset=iso-8859-1' ."\"\r\n\r\n";
                    mail($resciverData->email, $subject, $bodyHtmlTemplate, $header);
                    $aResult['status'] = true;
                    $aResult['message'] = 'success';
				}
        }
        else{
              $aResult['status'] = false;
              $aResult['message'] = 'failed';
        }
        echo json_encode($aResult);

    }

    public function scheduledmeetingsAction(){
        if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('property_detail');
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viewer_id  = Engine_Api::_()->user()->getViewer()->getIdentity();
        $meetingSchedulerTable   =  Engine_Api::_()->getDbtable('meetingscheduler', 'user');

        $scheduledMeetingsSelect = $meetingSchedulerTable->select()    
                               ->setIntegrityCheck(false)
                               ->from(array('scheduler'=>'engine4_meeting_scheduler',))
                               ->joinLeft(array('user'=>'engine4_users'),'scheduler.scheduled_by    = user.user_id',array('user_id','displayname'))
                               ->joinLeft(array('plist'=>'engine4_property_list'),'plist.id    = scheduler.property_id',array('property_name'))
                               ->where('scheduler.scheduled_by = ?', $viewer_id)
                               ->where('scheduler.approved != ?', 'completed')
                               ->order('scheduler.scheduled_date DESC');                              
                               
        $scheduledMeetingsData = $meetingSchedulerTable->fetchAll($scheduledMeetingsSelect);
        $this->view->scheduledMeetingsData = $scheduledMeetingsData;
    }
    public function meetingrequestsAction(){


        if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('property_detail');
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viewer_id  = Engine_Api::_()->user()->getViewer()->getIdentity();
        $meetingSchedulerTable   =  Engine_Api::_()->getDbtable('meetingscheduler', 'user');
        $scheduledMeetingsSelect = $meetingSchedulerTable->select()    
                               ->setIntegrityCheck(false)
                               ->from(array('scheduler'=>'engine4_meeting_scheduler',))
                               ->joinLeft(array('user'=>'engine4_users'),'scheduler.scheduled_by    = user.user_id',array('user_id','displayname'))
                               ->joinLeft(array('plist'=>'engine4_property_list'),'plist.id    = scheduler.property_id',array('property_name'))
                               ->where('scheduler.scheduled_with = ?', $viewer_id)
                               ->where('scheduler.approved != ?', 'completed')
                               ->order('scheduler.id DESC'); 
        $scheduledMeetingsData = $meetingSchedulerTable->fetchAll($scheduledMeetingsSelect);
        $this->view->scheduledMeetingsData = $scheduledMeetingsData;
    }

    public function joinedmeetingsAction(){

        if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }        
	 
        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('property_detail');
        $viewer     = Engine_Api::_()->user()->getViewer();
        $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
         if( !empty($fieldsByAlias['profile_type']) ){
              $optionId = $fieldsByAlias['profile_type']->getValue($viewer);
              $profile_type_id = $optionId->value;
        }
        if($profile_type_id == 1){ // if renter		
		 return $this->_forward('notfound');
	    }
        date_default_timezone_set($viewer->timezone);
        $viewer_id               =  Engine_Api::_()->user()->getViewer()->getIdentity();
        $meetingSchedulerTable   =  Engine_Api::_()->getDbtable('meetingscheduler', 'user');
        $scheduledMeetingsSelect = $meetingSchedulerTable->select()
                              ->setIntegrityCheck(false)
                               ->from(array('scheduler'=>'engine4_meeting_scheduler',))
                               ->joinLeft(array('user'=>'engine4_users'),'scheduler.scheduled_by    = user.user_id',array('user_id','displayname'))
                               ->where('(scheduler.scheduled_with = ?', $viewer_id)
                               ->orWhere('scheduler.scheduled_by = ?)', $viewer_id)                               
                               ->where('scheduler.approved = ?', 1)
                               ->order('scheduler.scheduled_date DESC');
        $scheduledMeetingsData = $meetingSchedulerTable->fetchAll($scheduledMeetingsSelect);
        $this->view->scheduledMeetingsData = $scheduledMeetingsData;
    } 

 /*   public function approvemeetingAction(){
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viewer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        if( $this->getRequest()->isPost()){
            $aData        = $this->_request->getPost();
            $id           = $aData['id'];
            $meetingSchedulerTable =  Engine_Api::_()->getDbtable('meetingscheduler', 'user');
            $scheduledMeetingsData = $meetingSchedulerTable->fetchRow($meetingSchedulerTable->select()->where('id = ?', $id));
            $scheduledMeetingsData->approved  = 1;
            $scheduledMeetingsData->save();
                 // send notification
            $userTable    = Engine_Api::_()->getDbtable('users', 'user');
            $resciverData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $scheduledMeetingsData->scheduled_by));
            Engine_Api::_()->getDbtable('notifications', 'activity')
                    ->addNotification($resciverData, $viewer, $resciverData, 'approve_scheduler',array(
                  'scheduled_date' => $scheduledMeetingsData->scheduled_date,'scheduled_time' => $scheduledMeetingsData->scheduled_time));


                   // send mail
        $from_email    = Engine_Api::_()->getApi('settings', 'core')->core_mail_from;

        $bodyTextContent = '';

                         if (file_exists("emailtemplates/meeting_notification_email.html")) {
                            $htmlExist = true;
                            $file = fopen("emailtemplates/meeting_notification_email.html", "r");
                            while(!feof($file))
                            {
                                $bodyTextContent .= fgets($file);
                            }
                            fclose($file);
                        }

                            if($htmlExist){

                              $rescivername     = '{rescivername}';
                              $redirectUrl      = '{redirectUrl}';
                              $redirect_url     = $_SERVER['HTTP_HOST']."/scheduler/meetings/joined";
                              $contentData      = '{Contents}';
                              $content = ''.
                              $content = $content.'<a href="'.$_SERVER['HTTP_HOST'].'/profile/'.$viewer_id.'">'.$viewer->displayname.'</a> has approved your meeting request on ';
                              $content = $content. $scheduledMeetingsData->scheduled_date ." " .$scheduledMeetingsData->scheduled_time;
                              
                              $bodyTextTemplate = '';
                              $bodyHtmlTemplate = $bodyTextContent;
                            foreach( $rParams as $var => $val ) {
                              $raw = trim($var, '[]');
                              $var = '[' . $var . ']';
                              if( !$val ) {
                                $val = $var;
                              }
                              // Fix nbsp
                              $val = str_replace('&amp;nbsp;', ' ', $val);
                              $val = str_replace('&nbsp;', ' ', $val);
                              // Replace
                             $bodyTextTemplate = str_replace($var, $val, $bodyTextTemplate);
                             $bodyHtmlTemplate = str_replace($var, $val, $bodyHtmlTemplate);
                            }
                            $bodyTextTemplate = strip_tags($bodyTextTemplate);
                            $bodyHtmlTemplate = str_replace($rescivername, $resciverData->displayname, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($redirectUrl, $redirect_url, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($contentData, $content, $bodyHtmlTemplate);


                            }
                    $subject = "Approved meeting";
                    $header  = "From: ".'Rentstarz'." <".$from_email.">\r\n";
                    $header .= "MIME-Version: 1.0\r\n";
                    $header .= 'Content-type: text/html; charset=iso-8859-1' ."\"\r\n\r\n";
                    mail($resciverData->email, $subject, $bodyHtmlTemplate, $header);

            $aResult['status'] = true;
        }
        else{
              $aResult['status'] = false;
        }
        echo json_encode($aResult);

    }*/
    public function declinemeetingAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viewer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();

        if( $this->getRequest()->isPost()){
            $aData     = $this->_request->getPost();
            $id        = $aData['id'];
            
            $meetingSchedulerTable =  Engine_Api::_()->getDbtable('meetingscheduler', 'user');
            $scheduledMeetingsData = $meetingSchedulerTable->fetchRow($meetingSchedulerTable->select()->where('id = ?', $id));
            $scheduledMeetingsData->approved = 'rejected';
            $scheduledMeetingsData->save();
            
           $propertyTable        =  Engine_Api::_()->getDbtable('propertylist', 'user');
           $propertyData         =  $propertyTable->fetchRow($propertyTable->select()->where('id = ?', $scheduledMeetingsData->property_id));


                   // send notification
            $userTable    = Engine_Api::_()->getDbtable('users', 'user');
            $resciverData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $scheduledMeetingsData->scheduled_by));
            Engine_Api::_()->getDbtable('notifications', 'activity')
                    ->addNotification($resciverData, $viewer, $resciverData, 'decline_meeting',array(
                  'pname' => $propertyData->property_name));

                   // send mail
        $from_email    = Engine_Api::_()->getApi('settings', 'core')->core_mail_from;

        $bodyTextContent = '';

                         if (file_exists("emailtemplates/meeting_notification_email.html")) {
                            $htmlExist = true;
                            $file = fopen("emailtemplates/meeting_notification_email.html", "r");
                            while(!feof($file))
                            {
                                $bodyTextContent .= fgets($file);
                            }
                            fclose($file);
                        }

                            if($htmlExist){

                              $rescivername     = '{rescivername}';
                              $redirectUrl      = '{redirectUrl}';
                              $redirect_url     = $_SERVER['HTTP_HOST']."/scheduler";
                              $contentData      = '{Contents}';
                              $content = ''.
                              $content = $content.'<a href="'.$_SERVER['HTTP_HOST'].'/profile/'.$viewer_id.'">'.$viewer->displayname.'</a> has declined your meeting request against the property ';
                              $content = $content. $propertyData->property_name;
                              
                              $bodyTextTemplate = '';
                              $bodyHtmlTemplate = $bodyTextContent;
                            foreach( $rParams as $var => $val ) {
                              $raw = trim($var, '[]');
                              $var = '[' . $var . ']';
                              if( !$val ) {
                                $val = $var;
                              }
                              // Fix nbsp
                              $val = str_replace('&amp;nbsp;', ' ', $val);
                              $val = str_replace('&nbsp;', ' ', $val);
                              // Replace
                             $bodyTextTemplate = str_replace($var, $val, $bodyTextTemplate);
                             $bodyHtmlTemplate = str_replace($var, $val, $bodyHtmlTemplate);
                            }
                            $bodyTextTemplate = strip_tags($bodyTextTemplate);
                            $bodyHtmlTemplate = str_replace($rescivername, $resciverData->displayname, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($redirectUrl, $redirect_url, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($contentData, $content, $bodyHtmlTemplate);


                            }
                    $subject = "Decline meeting";
                    $header  = "From: ".'Rentstarz'." <".$from_email.">\r\n";
                    $header .= "MIME-Version: 1.0\r\n";
                    $header .= 'Content-type: text/html; charset=iso-8859-1' ."\"\r\n\r\n";
                    mail($resciverData->email, $subject, $bodyHtmlTemplate, $header);

            
            $aResult['status'] = true;
        }
        else{
              $aResult['status'] = false;
        }
        echo json_encode($aResult);

    }

    public function supportAction(){


        if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        unset($_SESSION['userpackage']);



        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('common_layout');
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viewer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
    }

    public function filterfeedbypriceAction(){
        if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        unset($_SESSION['matching_array']);
        unset($_SESSION['feedicon']);
        unset($_SESSION['feedpreferenceunit']);
        unset($_SESSION['feedpreferenceunitmore']);

        if( $this->getRequest()->isPost()){

              $aData = $this->_request->getPost();
              $price         = $aData['price'];

              $matching_array =[];

              $matching_array['housing_types']   = '';
              $matching_array['is_petsallowd']   = '';
              $matching_array['pets_type']       = '';
              $matching_array['price']           = $price;
              $pricearray =  explode('-', $matching_array['price']);
              $matching_array['price_from']      = (int)$pricearray['0'];
              $matching_array['price_to']        = (int)$pricearray['1'];
              $matching_array['no_of_bedrooms']  = '';
             // $_SESSION['matching_array'] = $matching_array;
              $_SESSION['feedicon']              = 1;

  $location_mode_array =[];

    if($aData['location_country_name'] !='' || $aData['location_state_name'] != '' ||$aData['location_city_name'] != '' ||$aData['location_zipcode'] !='' || $aData['set_to_usa'] !=''){

              $location_mode_array['pets_type']      = $aData['pets_type'];
              $location_mode_array['price']          = $aData['price'];
              $location_mode_array['price_from']     = (int)$pricearray['0'];
              $location_mode_array['price_to']       = (int)$pricearray['1'];
              $location_mode_array['no_of_bedrooms'] = $aData['no_of_bedrooms'];
              $location_mode_array['country_name']   = $aData['location_country_name'];
              $location_mode_array['state_name']     = $aData['location_state_name'];
              $location_mode_array['city_name']      = $aData['location_city_name'];
              $location_mode_array['zipcode']        = $aData['location_zipcode'];
              $location_mode_array['set_to_usa']     = $aData['location_set_to_usa'];
              $location_mode_array['countryId']      = $aData['location_countryId'];
              $location_mode_array['stateId']        = $aData['location_stateId'];
              $location_mode_array['cityId']         = $aData['location_cityId'];
              $location_mode_array['county_name']        = $aData['location_county'];
              $location_mode_array['neighborhood_name']  = $aData['location_neighborhood'];

                        $_SESSION['countryId']    = $aData['location_countryId'];
                        $_SESSION['stateId']      = $aData['location_stateId'];
                        $_SESSION['cityId']       = $aData['location_cityId'];
                        $_SESSION['country_name'] = $aData['location_country_name'];
                        $_SESSION['state_name']   = $aData['location_state_name'];
                        $_SESSION['city_name']    = $aData['location_city_name'];
                        $_SESSION['county_name']    = $aData['location_county'];
                        $_SESSION['neighborhood_name']      = $aData['location_neighborhood'];
            }
            else{
                 if($viewer->prefered_location != '' ){
                    if($viewer->prefered_location == 'United States'){
                        $propertycountryTable       =  Engine_Api::_()->getDbtable('propertycountry', 'user');
                        $locationSelect             =   $propertycountryTable->select()
                                                        ->setIntegrityCheck(false)
                                                        ->from(array('country'=>'engine4_property_countries'))
                                                        ->where('country.prty_country = ?', 'United States');

                        $locationData             = $propertycountryTable->fetchRow($locationSelect);
                        $this->view->locationData = $locationData;
                        $country_id               = $this->view->country_id =$locationData->country_id;
                        $location_text = 'United States';
                        $_SESSION['set_to_usa'] = 1;
                    }
                    else{

                        $location   = explode(",",$viewer->prefered_location);
                        $country_id = $location[0];
                        $state_id   = $location[1];
                        $city_id    = $location[2];

                        $propertycityable =  Engine_Api::_()->getDbtable('propertycity', 'user');
                        $locationSelect   =   $propertycityable->select()
                                        ->setIntegrityCheck(false)
                                        ->from(array('city'=>'engine4_property_city'))
                                        ->joinLeft(array('country'=>'engine4_property_countries'),'city.country_id=country.country_id',array('prty_country'))
                                        ->joinLeft(array('state'=>'engine4_property_states'),'city.state_id=state.state_id',array('prty_state'))
                                        ->where('city.city_id = ?', $location[2]);

                        $locationData=$propertycityable->fetchRow($locationSelect);

                        $this->view->locationData = $locationData;

                        $country_id = $this->view->country_id = $locationData->country_id;
                        $state_id   = $this->view->state_id = $locationData->state_id;
                        $city_id    = $this->view->city_id = $locationData->city_id;

                        $location_text = $locationData->prty_city;

                        $_SESSION['countryId'] = $country_id;
                        $_SESSION['stateId']   = $state_id;
                        $_SESSION['cityId']    = $city_id;
                        $_SESSION['country_name'] = $locationData->prty_country;
                        $_SESSION['state_name'] = $locationData->prty_state;
                        $_SESSION['city_name'] = $locationData->prty_city;
                    }
                  }
              $location_mode_array['pets_type']      = $aData['pets_type'];
              $location_mode_array['price']          = $aData['price'];
              $location_mode_array['price_from']     = (int)$pricearray['0'];
              $location_mode_array['price_to']       = (int)$pricearray['1'];
              $location_mode_array['no_of_bedrooms'] = $aData['no_of_bedrooms'];
              $location_mode_array['country_name']   = $_SESSION['country_name'];
              $location_mode_array['state_name']     = $_SESSION['state_name'];
              $location_mode_array['city_name']      = $_SESSION['city_name'];
              $location_mode_array['zipcode']        = $_SESSION['zipcode'];
              $location_mode_array['set_to_usa']     = $_SESSION['set_to_usa'];
              $location_mode_array['countryId']      = $_SESSION['countryId'];
              $location_mode_array['stateId']        = $_SESSION['stateId'];
              $location_mode_array['cityId']         = $_SESSION['cityId'];
              $location_mode_array['county_name']        = $aData['location_county'];
              $location_mode_array['neighborhood_name']  = $aData['location_neighborhood'];
              }
              $_SESSION['location_mode_array'] = $location_mode_array;
      //        echo $location_mode_array['price_from'] ;
      //        echo $location_mode_array['price_to'] ;
      //       exit;
              $aResult['status'] = true;
        }
        else{
              $aResult['status'] = false;
        }
        echo json_encode($aResult['status']);

    }
public function filterfeedbynoofbedroomsAction(){
	if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $viewer     = Engine_Api::_()->user()->getViewer();
        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();

        unset($_SESSION['matching_array']);
        unset($_SESSION['feedicon']);
        unset($_SESSION['feedpreferenceunit']);
        unset($_SESSION['feedpreferenceunitmore']);

        if( $this->getRequest()->isPost()){
              $aData                  = $this->_request->getPost();
              $no_of_bedrooms         = $aData['no_of_bedrooms'];
              $_SESSION['feedicon']   = 1;
            // print_r($_SESSION['location_mode_array']); exit("ll");
    $location_mode_array =[];

    if($aData['location_country_name'] !='' || $aData['location_state_name'] != '' ||$aData['location_city_name'] != '' ||$aData['location_zipcode'] !='' || $aData['set_to_usa'] !=''){

              $location_mode_array['pets_type']          = $aData['pets_type'];
              $location_mode_array['price']              = $aData['price'];
              $pricearray =  explode('-', $location_mode_array['price']);
              $location_mode_array['price_from']      = (int)$pricearray['0'];
              $location_mode_array['price_to']        = (int)$pricearray['1'];
              $location_mode_array['no_of_bedrooms']     = $aData['no_of_bedrooms'];
              $location_mode_array['country_name']       = $aData['location_country_name'];
              $location_mode_array['state_name']         = $aData['location_state_name'];
              $location_mode_array['city_name']          = $aData['location_city_name'];
              $location_mode_array['zipcode']            = $aData['location_zipcode'];
              $location_mode_array['set_to_usa']         = $aData['location_set_to_usa'];
              $location_mode_array['countryId']          = $aData['location_countryId'];
              $location_mode_array['stateId']            = $aData['location_stateId'];
              $location_mode_array['cityId']             = $aData['location_cityId'];
              $location_mode_array['county_name']        = $aData['location_county'];
              $location_mode_array['neighborhood_name']  = $aData['location_neighborhood'];

                        $_SESSION['countryId']    = $aData['location_countryId'];
                        $_SESSION['stateId']      = $aData['location_stateId'];
                        $_SESSION['cityId']       = $aData['location_cityId'];
                        $_SESSION['country_name'] = $aData['location_country_name'];
                        $_SESSION['state_name']   = $aData['location_state_name'];
                        $_SESSION['city_name']    = $aData['location_city_name'];
                        $_SESSION['county_name']    = $aData['location_county'];
                        $_SESSION['neighborhood_name']      = $aData['location_neighborhood'];

            }
            else {
                 if($viewer->prefered_location != '' ){
                    if($viewer->prefered_location == 'United States'){
                        $propertycountryTable       =  Engine_Api::_()->getDbtable('propertycountry', 'user');
                        $locationSelect   =   $propertycountryTable->select()
                                        ->setIntegrityCheck(false)
                                        ->from(array('country'=>'engine4_property_countries'))
                                        ->where('country.prty_country = ?', 'United States');

                        $locationData=$propertycountryTable->fetchRow($locationSelect);
                        $this->view->locationData = $locationData;
                    $country_id = $this->view->country_id =$locationData->country_id;
                    $location_text = 'United States';
                    $_SESSION['set_to_usa'] = 1;
                    }
                    else{
                        $location   = explode(",",$viewer->prefered_location);
                        $country_id = $location[0];
                        $state_id   = $location[1];
                        $city_id    = $location[2];

                        $propertycityable =  Engine_Api::_()->getDbtable('propertycity', 'user');
                        $locationSelect   =   $propertycityable->select()
                                        ->setIntegrityCheck(false)
                                        ->from(array('city'=>'engine4_property_city'))
                                        ->joinLeft(array('country'=>'engine4_property_countries'),'city.country_id=country.country_id',array('prty_country'))
                                        ->joinLeft(array('state'=>'engine4_property_states'),'city.state_id=state.state_id',array('prty_state'))
                                        ->where('city.city_id = ?', $location[2]);

                        $locationData=$propertycityable->fetchRow($locationSelect);

                        $this->view->locationData = $locationData;

                        $country_id = $this->view->country_id    = $locationData->country_id;
                        $state_id   = $this->view->state_id      = $locationData->state_id;
                        $city_id    = $this->view->city_id       = $locationData->city_id;

                        $location_text = $locationData->prty_city;

                        $_SESSION['countryId']    = $country_id;
                        $_SESSION['stateId']      = $state_id;
                        $_SESSION['cityId']       = $city_id;
                        $_SESSION['country_name'] = $locationData->prty_country;
                        $_SESSION['state_name']   = $locationData->prty_state;
                        $_SESSION['city_name']    = $locationData->prty_city;
                    }
                  }
              $location_mode_array['pets_type']       = $aData['pets_type'];
              $location_mode_array['price']           = $aData['price'];
              $pricearray                             =  explode('-', $location_mode_array['price']);
              $location_mode_array['price_from']      = (int)$pricearray['0'];
              $location_mode_array['price_to']        = (int)$pricearray['1'];
              $location_mode_array['no_of_bedrooms']  = $aData['no_of_bedrooms'];
              $location_mode_array['country_name']    = $_SESSION['country_name'];
              $location_mode_array['state_name']      = $_SESSION['state_name'];
              $location_mode_array['city_name']       = $_SESSION['city_name'];
              $location_mode_array['zipcode']         = $_SESSION['zipcode'];
              $location_mode_array['set_to_usa']      = $_SESSION['set_to_usa'];
              $location_mode_array['countryId']       = $_SESSION['countryId'];
              $location_mode_array['stateId']         = $_SESSION['stateId'];
              $location_mode_array['cityId']          = $_SESSION['cityId'];
              $location_mode_array['county_name']        = $aData['location_county'];
              $location_mode_array['neighborhood_name']  = $aData['location_neighborhood'];
              }
              $_SESSION['location_mode_array'] = $location_mode_array;
             // print_r($_SESSION['location_mode_array']); exit;
              $aResult['status'] = true;
        }
        else{
              $aResult['status'] = false;
        }
        echo json_encode($aResult['status']);
    }
public function filterfeedbypetstypeAction(){
	
	if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();

        unset($_SESSION['matching_array']);
        unset($_SESSION['feedicon']);
        unset($_SESSION['feedpreferenceunit']);
        unset($_SESSION['feedpreferenceunitmore']);
        if( $this->getRequest()->isPost()){
              $aData                  = $this->_request->getPost();
              $pets_type              = $aData['pets_type'];
              $_SESSION['feedicon']   = 1;
              $location_mode_array =[];

             if($aData['location_country_name'] !='' || $aData['location_state_name'] != '' ||$aData['location_city_name'] != '' ||$aData['location_zipcode'] !='' || $aData['set_to_usa'] !=''){

                      $location_mode_array['pets_type']     = $aData['pets_type'];
                      $location_mode_array['price']         = $aData['price'];
                      $pricearray =  explode('-', $location_mode_array['price']);
                      $location_mode_array['price_from']      = (int)$pricearray['0'];
                      $location_mode_array['price_to']        = (int)$pricearray['1'];
                      $location_mode_array['no_of_bedrooms']= $aData['no_of_bedrooms'];
                      $location_mode_array['country_name']  = $aData['location_country_name'];
                      $location_mode_array['state_name']    = $aData['location_state_name'];
                      $location_mode_array['city_name']     = $aData['location_city_name'];
                      $location_mode_array['zipcode']       = $aData['location_zipcode'];
                      $location_mode_array['set_to_usa']    = $aData['location_set_to_usa'];
                      $location_mode_array['countryId']     = $aData['location_countryId'];
                      $location_mode_array['stateId']       = $aData['location_stateId'];
                      $location_mode_array['cityId']        = $aData['location_cityId'];
                      $location_mode_array['county_name']        = $aData['location_county'];
                      $location_mode_array['neighborhood_name']  = $aData['location_neighborhood'];

                        $_SESSION['countryId']    = $aData['location_countryId'];
                        $_SESSION['stateId']      = $aData['location_stateId'];
                        $_SESSION['cityId']       = $aData['location_cityId'];
                        $_SESSION['country_name'] = $aData['location_country_name'];
                        $_SESSION['state_name']   = $aData['location_state_name'];
                        $_SESSION['city_name']    = $aData['location_city_name'];
                        $_SESSION['county_name']    = $aData['location_county'];
                        $_SESSION['neighborhood_name']      = $aData['location_neighborhood'];
              }
            else{
                 if($viewer->prefered_location != '' ){
                    if($viewer->prefered_location == 'United States'){
                        $propertycountryTable       =  Engine_Api::_()->getDbtable('propertycountry', 'user');
                        $locationSelect   =   $propertycountryTable->select()
                                        ->setIntegrityCheck(false)
                                        ->from(array('country'=>'engine4_property_countries'))
                                        ->where('country.prty_country = ?', 'United States');

                        $locationData             = $propertycountryTable->fetchRow($locationSelect);

                        $this->view->locationData = $locationData;

                    $country_id             = $this->view->country_id = $locationData->country_id;
                    $location_text          = 'United States';
                    $_SESSION['set_to_usa'] = 1;


                    }
                    else{
                        $location   = explode(",",$viewer->prefered_location);
                        $country_id = $location[0];
                        $state_id   = $location[1];
                        $city_id    = $location[2];

                        $propertycityable       =  Engine_Api::_()->getDbtable('propertycity', 'user');
                        $locationSelect   =   $propertycityable->select()
                                        ->setIntegrityCheck(false)
                                        ->from(array('city'=>'engine4_property_city'))
                                        ->joinLeft(array('country'=>'engine4_property_countries'),'city.country_id=country.country_id',array('prty_country'))
                                        ->joinLeft(array('state'=>'engine4_property_states'),'city.state_id=state.state_id',array('prty_state'))
                                        ->where('city.city_id = ?', $location[2]);

                        $locationData=$propertycityable->fetchRow($locationSelect);

                        $this->view->locationData = $locationData;

                        $country_id = $this->view->country_id  = $locationData->country_id;
                        $state_id   = $this->view->state_id    = $locationData->state_id;
                        $city_id    = $this->view->city_id     = $locationData->city_id;
                        $location_text                         = $locationData->prty_city;

                        $_SESSION['countryId']   = $country_id;
                        $_SESSION['stateId']     = $state_id;
                        $_SESSION['cityId']      = $city_id;
                        $_SESSION['country_name']= $locationData->prty_country;
                        $_SESSION['state_name']  = $locationData->prty_state;
                        $_SESSION['city_name']   = $locationData->prty_city;
                    }
                  }
              $location_mode_array['pets_type']        = $aData['pets_type'];
              $location_mode_array['price']            = $aData['price'];
              $pricearray                              =  explode('-', $location_mode_array['price']);
              $location_mode_array['price_from']       = (int)$pricearray['0'];
              $location_mode_array['price_to']         = (int)$pricearray['1'];
              $location_mode_array['no_of_bedrooms']   = $aData['no_of_bedrooms'];
              $location_mode_array['country_name']     = $_SESSION['country_name'];
              $location_mode_array['state_name']       = $_SESSION['state_name'];
              $location_mode_array['city_name']        = $_SESSION['city_name'];
              $location_mode_array['zipcode']          = $_SESSION['zipcode'];
              $location_mode_array['set_to_usa']       = $_SESSION['set_to_usa'];
              $location_mode_array['countryId']        = $_SESSION['countryId'];
              $location_mode_array['stateId']          = $_SESSION['stateId'];
              $location_mode_array['cityId']           = $_SESSION['cityId'];
              $location_mode_array['county_name']        = $aData['location_county'];
              $location_mode_array['neighborhood_name']  = $aData['location_neighborhood'];
              }
              $_SESSION['location_mode_array'] = $location_mode_array; //print_r($_SESSION['location_mode_array']); exit;
              $aResult['status']               = true;
        }
        else{
              $aResult['status'] = false;
        }
        echo json_encode($aResult['status']);
    }

    public function filterfeedbyfeedpreferenceunitAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();

        if(isset($_SESSION['countryId'])){
            unset($_SESSION['countryId']);
            unset($_SESSION['stateId']);
            unset($_SESSION['cityId']);
        }
        unset($_SESSION['set_to_usa']);
        unset($_SESSION['feedicon']);
        unset($_SESSION['matching_array']);
        unset($_SESSION['feedpreferenceunit']);
        unset($_SESSION['feedpreferenceunitmore']);

        if( $this->getRequest()->isPost()){
            $viewer_id            = $viewer->getIdentity();
            $aData                = $this->_request->getPost();
            $feedpreferenceUnitid = $aData['feedpreferenceUnitid'];
            $count                = $aData['count'];

            if($count !=''){
                $FeedPreferenceUnitTable      = Engine_Api::_()->getDbtable('Feedpreferenceunit', 'user');
                $FeedPreferenceUnitDataSelect = $FeedPreferenceUnitTable->select()
                                    ->where('id = ?', $feedpreferenceUnitid);
                $FeedPreferenceUnitData       = $FeedPreferenceUnitTable->fetchRow($FeedPreferenceUnitDataSelect);

                $matching_array =[];
                $matching_array['housing_types']        = $FeedPreferenceUnitData->housing_type;
                $matching_array['is_petsallowd']        = $FeedPreferenceUnitData->is_petsallowd;
                $matching_array['pets_type']            = $FeedPreferenceUnitData->pets_type;
                $matching_array['price']                = $FeedPreferenceUnitData->price;
                $matching_array['no_of_bedrooms']       = $FeedPreferenceUnitData->number_of_rooms;

                $_SESSION['matching_array']     = $matching_array;
                $_SESSION['feedicon']           = 1;
                $_SESSION['feedpreferenceunit'] = $count;

                if($aData['feedpreferencemore'] == 2){
                    $_SESSION['feedpreferenceunitmore'] =2;
                }
            }
                $aResult['status'] = true;
        }
        else{
              $aResult['status'] = false;
        }
        echo json_encode($aResult['status']);

    }
    public function landlordhomefeedajaxAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        unset($_SESSION['limit']);
        unset($_SESSION['offset']);
             $limit              = $this->_getParam('limit');
             $offset             = $this->_getParam('offset');
             $_SESSION['limit']  = $limit;
             $_SESSION['offset'] = $offset;
             $aResult['status']  = true;
             echo json_encode($aResult['status']);
    }

    public function savegalleryphotoAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        if( $this->getRequest()->isPost()){
            $aData           = $this->_request->getPost();
            $photo_title     = $aData['upload_image_title'];
            $subject_id      = $aData['subject_id'];
            $random_filename = $this->random_string(8);
            $dir             = dirname($_SERVER['SCRIPT_FILENAME']).'/public/images/gallery/'.$viewer->getIdentity();
                            if(!is_dir($dir)){
                                mkdir($dir,0777,true);
                            }
            $target_file     = $dir .'/'. basename($_FILES["upload_image"]["name"]);
            $imageFileType   = pathinfo($target_file,PATHINFO_EXTENSION);
            $random_filename =  $random_filename.'.'.$imageFileType;
            if($imageFileType != "JPG" && $imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg" &&  $imageFileType != "JPEG" &&  $imageFileType != "PNG") {

                $aResult['msg']    = "Sorry, only JPG, JPEG, & PNG  files are allowed.";
                $aResult['status'] = false;
            }
            else{

                $target_file   = $dir .'/'. $random_filename;
                if (move_uploaded_file($_FILES["upload_image"]["tmp_name"], $target_file)) {
                    $PhotogalleryTable     = Engine_Api::_()->getDbtable('photogallery', 'user');
                    $PhotogalleryTableId   = $PhotogalleryTable->insert(array(
                      'user_id'         => $viewer->getIdentity(),
                      'photo_title'     => $photo_title,
                      'path'            => 'public/images/gallery/'.$viewer->getIdentity().'/'.$random_filename,
                      'created_at'      => date('Y-m-d H:i:s'),
                      'updated_at'      => date('Y-m-d H:i:s'),

                    ));
                    // update html in deletephotoModal
            $PhotogallerySelect = $PhotogalleryTable->select()
                                    ->where('user_id = ?', $subject_id);
            $PhotogalleryData   = $PhotogalleryTable->fetchAll($PhotogallerySelect);
            $html ='';
            foreach($PhotogalleryData as $data){

                $html = $html.'<div class="photo_grid">';
                $html = $html.'<input type="checkbox" name="deletephotochk" value="'.$data['id'].'" id="deletephotochk"/> ';
                $html = $html.'<img src="'.$data['path'].'" width="120px" height="120px" style="margin-bottom: 12px;margin-left: 12px;">';
                $html = $html.'</div>';
            }
           $aResult['PhotogallerydeleteModalHtml'] = $html ;
           $aResult['status']                      = true;
           }
           else {
                 $aResult['status'] = false;
                }
            }
            echo json_encode($aResult);
         }
    }

    public function galleryphotoajaxAction() {
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        $oData         = $this->_request->getPost();
        $user_id       = Engine_Api::_()->user()->getViewer()->getIdentity();
        $connectionApi = Engine_Api::_()->getApi('connections', 'user');
        $html          = $connectionApi->galleryphotoajaxResults($oData);
        return $html;

    }

    public function deletegalleryphotoAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $viewer         = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        if( $this->getRequest()->isPost()){
            $aData             = $this->_request->getPost();
            $photoIds          = $aData['photoIds'];
            $subjectId         = $aData['subjectId'];
            $PhotogalleryTable = Engine_Api::_()->getDbtable('photogallery', 'user');
            if(count($photoIds) > 0){
               for($i=0; $i<count($photoIds);$i++){
                     $PhotogallerySelect = $PhotogalleryTable->select()
                                    ->where('id = ?', $photoIds[$i]);
                     $PhotogalleryData = $PhotogalleryTable->fetchRow($PhotogallerySelect);
                     $filePath         = dirname($_SERVER['SCRIPT_FILENAME']).'/'.$PhotogalleryData->path;
                    if(is_file($filePath) && file_exists($filePath)) {
                            unlink($filePath);
                    }
                    Engine_Db_Table::getDefaultAdapter()->delete('engine4_photo_gallery', array('id = ?'=>$photoIds[$i]) );
                }
            }
            $PhotogallerySelect = $PhotogalleryTable->select()
                                    ->where('user_id = ?', $subjectId);
            $PhotogalleryData   = $PhotogalleryTable->fetchAll($PhotogallerySelect);
            $html               = '';
            foreach($PhotogalleryData as $data){
                $html = $html.'<div class="photo_grid">';
                $html = $html.'<input type="checkbox" name="deletephotochk" value="'.$data['id'].'" id="deletephotochk"/> ';
                $html = $html.'<img src="'.$data['path'].'" width="120px" height="120px" style="margin-bottom: 12px;margin-left: 12px;">';
                $html = $html.'</div>';
            }
            $aResult['PhotogallerydeleteModalHtml'] = $html ;
            $aResult['status']                      = true;
        }
        echo json_encode($aResult);
    }

    // cron set per day for remainder before 2 day to scheduled appointment

    public function scheduledappoinmentremaindertwodaybeforeAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        date_default_timezone_set("Asia/Kolkata");
        $today = date('d-m-Y');
        $time  = time();
        $meetingSchedulerTable =  Engine_Api::_()->getDbtable('meetingscheduler', 'user');
        $userTable = Engine_Api::_()->getDbtable('users', 'user');

        $scheduledMeetingsData = $meetingSchedulerTable->fetchAll($meetingSchedulerTable->select());

        foreach($scheduledMeetingsData as $data){
                $today_date     = strtotime($today);
                $scheduled_date = strtotime($data['scheduled_date']);
                if ($scheduled_date >= $today_date) {
                        $remainder_mail = 0;
                        $diff           = $scheduled_date -$today_date;
                        $day_diif       = round($diff / 86400);
                        if($day_diif == 1){
                            $time_now   =  date("g:i A", $time);
                            $fromTime   = $time_now;
                            $toTime     = $data['scheduled_time'];
                            $timediff   =   (strtotime($toTime)-strtotime($fromTime))/(60*60);
                            $timediff >= 0 ?  $timediff : (24 + $timediff);
                            if( $timediff == 3){
                                $remainder_mail = 1;
                            }
                        }
                        if($day_diif == 2){
                            $remainder_mail = 1;
                        }
                        if($remainder_mail == 1){
                            $scheduledByUserData  =  $userTable->fetchRow($userTable->select()->where('user_id = ?', $data['scheduled_by']));
                            $scheduledToUserData  =  $userTable->fetchRow($userTable->select()->where('user_id = ?', $data['scheduled_with']));
                            $from_email           =  Engine_Api::_()->getApi('settings', 'core')->core_mail_from;
                            $bodyTextContent      =  '';

                                 if (file_exists("emailtemplates/scheduler_remainder_email.html")) {
                                    $htmlExist  = true;
                                    $file       = fopen("emailtemplates/scheduler_remainder_email.html", "r");
                                    while(!feof($file))
                                    {
                                        $bodyTextContent .= fgets($file);
                                    }
                                    fclose($file);
                                }

                                if($htmlExist){
                                      $schedulerByUserName   = '{schedulerByUserName}';
                                      $schedulerToUserName   = '{schedulerToUserName}';
                                      $scheduledDate         = '{scheduledDate}';
                                      $schedulerpageUrl      = '{schedulerpageUrl}';
                                      if($data['approved'] == 0){
                                          $schedulerUrl  = $_SERVER['HTTP_HOST']."/scheduler/meetings/requests";
                                      }
                                      else{
                                          $schedulerUrl  = $_SERVER['HTTP_HOST']."/scheduler/meetings/joined";
                                      }
                                      $bodyTextTemplate = '';
                                      $bodyHtmlTemplate = $bodyTextContent;
                                    foreach( $rParams as $var => $val ) {
                                          $raw = trim($var, '[]');
                                          $var = '[' . $var . ']';
                                          if( !$val ) {
                                            $val = $var;
                                          }
                                          // Fix nbsp
                                          $val = str_replace('&amp;nbsp;', ' ', $val);
                                          $val = str_replace('&nbsp;', ' ', $val);
                                          // Replace

                                         $bodyTextTemplate = str_replace($var, $val, $bodyTextTemplate);
                                         $bodyHtmlTemplate = str_replace($var, $val, $bodyHtmlTemplate);
                                    }
                                    $bodyTextTemplate = strip_tags($bodyTextTemplate);
                                    $bodyHtmlTemplate = str_replace($schedulerByUserName, $scheduledByUserData->displayname, $bodyHtmlTemplate);
                                    $bodyHtmlTemplate = str_replace($schedulerToUserName, $scheduledToUserData->displayname, $bodyHtmlTemplate);
                                    $bodyHtmlTemplate = str_replace($scheduledDate, $data['scheduled_date'], $bodyHtmlTemplate);
                                    $bodyHtmlTemplate = str_replace($schedulerpageUrl, $schedulerUrl, $bodyHtmlTemplate);
                                }
                                    $subject = "Scheduled Meeting Remainder";
                                    $header  = "From: ".'Rentstarz'." <".$from_email.">\r\n";
                                    $header .= "MIME-Version: 1.0\r\n";
                                    $header .= 'Content-type: text/html; charset=iso-8859-1' ."\"\r\n\r\n";
                                     mail($scheduledToUserData->email, $subject, $bodyHtmlTemplate, $header);
                                     // send notification

                               Engine_Api::_()->getDbtable('notifications', 'activity')
                                ->addNotification($scheduledToUserData, $scheduledByUserData, $scheduledToUserData, 'scheduled_appoinment_remainder',array(
                              'schedulerUrl' => $schedulerUrl,'scheduledDate' => $data['scheduled_date']));
                          }
                   }
        }
            // entry for cron log

    $cronlogTable =  Engine_Api::_()->getDbtable('cronlog', 'user');
    $cronlogData = $cronlogTable->fetchRow($cronlogTable->select()->where('type = ?', 'remainder_before_2day_to_scheduled_appointment'));
    if(count($cronlogData) > 0){
        $cronlogData->execution_count = $cronlogData->execution_count +1;
        $cronlogData->created_at = date('Y-m-d');
        $cronlogData->save();
    }
    else{
    $cronlogTableId=   $cronlogTable->insert(array(
                            'type' => 'remainder_before_2day_to_scheduled_appointment',
                            'execution_count' => 1,
                            'created_at' => date('Y-m-d'),
                        ));
    }
        exit("success");
    }


// cron set per hour for remainder before 3 hr to scheduled appointment

        public function scheduledappoinmentremainderthreehrbeforeAction(){
			if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();

       
        $meetingSchedulerTable  =  Engine_Api::_()->getDbtable('meetingscheduler', 'user');
        $userTable              = Engine_Api::_()->getDbtable('users', 'user');
        $scheduledMeetingsData = $meetingSchedulerTable->fetchAll($meetingSchedulerTable->select());
        foreach($scheduledMeetingsData as $data){
			// date_default_timezone_set("Asia/Kolkata");
			$scheduledToUserData  =  $userTable->fetchRow($userTable->select()->where('user_id = ?', $data['scheduled_with']));
			date_default_timezone_set($scheduledToUserData->timezone);

			$today = date('d-m-Y');
			$time  = time();
			
			
            $today_date     = strtotime($today);
            $scheduled_date = strtotime($data['scheduled_date']);
            if ($scheduled_date >= $today_date) {
                    $remainder_mail = 0;
                    $diff           = $scheduled_date -$today_date;
                    $day_diif       =  round($diff / 86400);
                    if($day_diif == 1){
                        $time_now =  date("g:i A", $time);
                        $fromTime = $time_now;
                        $toTime   = $data['scheduled_time'];
                        $timediff =   (strtotime($toTime)-strtotime($fromTime))/(60*60);
                        $timediff >= 0 ?  $timediff : (24 + $timediff);
                        if( $timediff == 3){
                            $remainder_mail = 1;
                        }
                    }
                    if($remainder_mail == 1){
                    $scheduledByUserData  =  $userTable->fetchRow($userTable->select()->where('user_id = ?', $data['scheduled_by']));
                   
                    $from_email           =  Engine_Api::_()->getApi('settings', 'core')->core_mail_from;
                    $bodyTextContent      =  '';
                                     if (file_exists("emailtemplates/scheduler_remainder_email.html")) {
                                        $htmlExist = true;
                                        $file      = fopen("emailtemplates/scheduler_remainder_email.html", "r");
                                        while(!feof($file))
                                        {
                                            $bodyTextContent .= fgets($file);
                                        }
                                        fclose($file);
                                     }
                                        if($htmlExist){
                                          $schedulerByUserName  = '{schedulerByUserName}';
                                          $schedulerToUserName  = '{schedulerToUserName}';
                                          $scheduledDate        = '{scheduledDate}';
                                          $schedulerpageUrl     = '{schedulerpageUrl}';
                                          if($data['approved'] == 0){
                                              $schedulerUrl = $_SERVER['HTTP_HOST']."/scheduler/meetings/requests";
                                          }
                                          else{
                                              $schedulerUrl = $_SERVER['HTTP_HOST']."/scheduler/meetings/joined";
                                          }
                                          $bodyTextTemplate = '';
                                          $bodyHtmlTemplate = $bodyTextContent;
                                        foreach( $rParams as $var => $val ) {
                                              $raw = trim($var, '[]');
                                              $var = '[' . $var . ']';
                                              if( !$val ) {
                                                $val = $var;
                                              }
                                              // Fix nbsp
                                              $val = str_replace('&amp;nbsp;', ' ', $val);
                                              $val = str_replace('&nbsp;', ' ', $val);
                                              // Replace

                                             $bodyTextTemplate = str_replace($var, $val, $bodyTextTemplate);
                                             $bodyHtmlTemplate = str_replace($var, $val, $bodyHtmlTemplate);
                                        }
                                        $bodyTextTemplate = strip_tags($bodyTextTemplate);
                                        $bodyHtmlTemplate = str_replace($schedulerByUserName, $scheduledByUserData->displayname, $bodyHtmlTemplate);
                                        $bodyHtmlTemplate = str_replace($schedulerToUserName, $scheduledToUserData->displayname, $bodyHtmlTemplate);
                                        $bodyHtmlTemplate = str_replace($scheduledDate, $data['scheduled_date'], $bodyHtmlTemplate);
                                        $bodyHtmlTemplate = str_replace($schedulerpageUrl, $schedulerUrl, $bodyHtmlTemplate);
                                        }
                                $subject = "Scheduled Meeting Remainder";
                                $header  = "From: ".'Rentstarz'." <".$from_email.">\r\n";
                                $header .= "MIME-Version: 1.0\r\n";
                                $header .= 'Content-type: text/html; charset=iso-8859-1' ."\"\r\n\r\n";
                                 mail($scheduledToUserData->email, $subject, $bodyHtmlTemplate, $header);
                                 // send notification

                           Engine_Api::_()->getDbtable('notifications', 'activity')
                            ->addNotification($scheduledToUserData, $scheduledByUserData, $scheduledToUserData, 'scheduled_appoinment_remainder',array(
                          'schedulerUrl' => $schedulerUrl,'scheduledDate' => $data['scheduled_date']));
                            }
                       }
                }
                        // entry for cron log

    $cronlogTable =  Engine_Api::_()->getDbtable('cronlog', 'user');
    $cronlogData = $cronlogTable->fetchRow($cronlogTable->select()->where('type = ?', 'remainder_before_3hr_to_scheduled_appointment'));
    if(count($cronlogData) > 0){
        $cronlogData->execution_count = $cronlogData->execution_count +1;
        $cronlogData->created_at = date('Y-m-d');
        $cronlogData->save();
    }
    else{
    $cronlogTableId=   $cronlogTable->insert(array(
                            'type' => 'remainder_before_3hr_to_scheduled_appointment',
                            'execution_count' => 1,
                            'created_at' => date('Y-m-d'),
                        ));
    }
        exit("success");
    }

// cron set per day for survey notification after scheduled meeting


    public function surveynotificationAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        $meetingSchedulerTable =  Engine_Api::_()->getDbtable('meetingscheduler', 'user');
        $userTable             = Engine_Api::_()->getDbtable('users', 'user');
        date_default_timezone_set("Asia/Kolkata");
        $today                 = date('d-m-Y');
        $scheduledMeetingsData = $meetingSchedulerTable->fetchAll($meetingSchedulerTable->select());
        foreach($scheduledMeetingsData as $data){
            $notification_status    =  0;

            if($data['survey_notification_status'] == '0'){
                $today_date     = strtotime($today);
                $scheduled_date = strtotime($data['scheduled_date']);

                if ($scheduled_date < $today_date) { // one after scheduled date
                    $diff         = $scheduled_date -$today_date;
                    $day_diif     =  round($diff / 86400);
                    if($day_diif == 1){
                        $notification_status = 'survey_notification';
                    }
                }
            }
            if($data['survey_notification_status'] == 'survey_respond_later'){ // later
                $survey_notification_later_date = $data['survey_notification_later'];
                $today_date     = strtotime($today);
                if($today_date == $survey_notification_later_date){
                    $notification_status = 'survey_notification';
                }
            }
                if($notification_status == 'survey_notification'){
                    $scheduledByUserData  =  $userTable->fetchRow($userTable->select()->where('user_id = ?', $data['scheduled_by']));
                    $scheduledToUserData  =  $userTable->fetchRow($userTable->select()->where('user_id = ?', $data['scheduled_with']));
                    $from_email           = Engine_Api::_()->getApi('settings', 'core')->core_mail_from;
                    $bodyTextContent = '';
                         if (file_exists("emailtemplates/survey_notification_email.html")) {
                            $htmlExist = true;
                            $file = fopen("emailtemplates/survey_notification_email.html", "r");
                                while(!feof($file))
                                {
                                    $bodyTextContent .= fgets($file);
                                }
                            fclose($file);
                            }
                            if($htmlExist){
                              $schedulerByUserName   = '{schedulerByUserName}';
                              $schedulerToUserName   = '{schedulerToUserName}';
                              $scheduledDate         = '{scheduledDate}';
                              $Url                   = '{url}';
                              $pageUrl               = $_SERVER['HTTP_HOST']."/members/home";
                              $bodyTextTemplate      = '';
                              $bodyHtmlTemplate      = $bodyTextContent;
                            foreach( $rParams as $var => $val ) {
                              $raw = trim($var, '[]');
                              $var = '[' . $var . ']';
                              if( !$val ) {
                                $val = $var;
                              }
                              // Fix nbsp
                              $val = str_replace('&amp;nbsp;', ' ', $val);
                              $val = str_replace('&nbsp;', ' ', $val);
                              // Replace

                             $bodyTextTemplate = str_replace($var, $val, $bodyTextTemplate);
                             $bodyHtmlTemplate = str_replace($var, $val, $bodyHtmlTemplate);
                            }
                            $bodyTextTemplate = strip_tags($bodyTextTemplate);
                            $bodyHtmlTemplate = str_replace($schedulerByUserName, $scheduledByUserData->displayname, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($schedulerToUserName, $scheduledToUserData->displayname, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($scheduledDate, $data['scheduled_date'], $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($Url, $pageUrl, $bodyHtmlTemplate);
                            }

                    $subject = "Survey Notification";
                    $header  = "From: ".'Rentstarz'." <".$from_email.">\r\n";
                    $header .= "MIME-Version: 1.0\r\n";
                    $header .= 'Content-type: text/html; charset=iso-8859-1' ."\"\r\n\r\n";
                    mail($scheduledToUserData->email, $subject, $bodyHtmlTemplate, $header);
                     // survey notification status
                    $meetingSchedulerData = $meetingSchedulerTable->fetchRow($meetingSchedulerTable->select()->where('id = ?', $data['id']));
                    $meetingSchedulerData -> survey_notification_status = 'survey_notification';
                    $meetingSchedulerData -> updated_at = date('Y-m-d');
                    $meetingSchedulerData->save();
                     // send notification
               Engine_Api::_()->getDbtable('notifications', 'activity')
                ->addNotification($scheduledToUserData, $scheduledByUserData, $scheduledToUserData, 'survey_notification',array(
              'schedulerByUserName' => $scheduledByUserData->displayname,'scheduledDate' => $data['scheduled_date']));
                }
        }
                           // entry for cron log

    $cronlogTable =  Engine_Api::_()->getDbtable('cronlog', 'user');
    $cronlogData = $cronlogTable->fetchRow($cronlogTable->select()->where('type = ?', 'survey_notification_after_scheduled_meeting'));
    if(count($cronlogData) > 0){
        $cronlogData->execution_count = $cronlogData->execution_count +1;
        $cronlogData->created_at = date('Y-m-d');
        $cronlogData->save();
    }
    else{
    $cronlogTableId=   $cronlogTable->insert(array(
                            'type' => 'survey_notification_after_scheduled_meeting',
                            'execution_count' => 1,
                            'created_at' => date('Y-m-d'),
                        ));
    }
    exit("success");
    }

    public function surveyrespondlaterAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();

        if( $this->getRequest()->isPost()){
            $aData                         = $this->_request->getPost();
            $meetingSchedulerTable         =  Engine_Api::_()->getDbtable('meetingscheduler', 'user');
            $meetingSchedulerData          = $meetingSchedulerTable->fetchRow($meetingSchedulerTable->select()->where('id = ?', $aData['scheduler_id']));
            $common_settings_table         =  Engine_Api::_()->getDbtable('commonsettings', 'user');
            $common_settings               = $common_settings_table->fetchRow($common_settings_table->select()->where('type =?', 'survey_respond_later_duration'));
            $survey_respond_later_duration = $common_settings-> value;
            $days                          = "+".$survey_respond_later_duration." days";
            $later_date                    = date('d-m-Y', strtotime($days));
            $meetingSchedulerData -> survey_notification_status = 'survey_respond_later'; //later
            $meetingSchedulerData -> survey_notification_later  = $later_date;
            $meetingSchedulerData -> updated_at                 = date('Y-m-d');
            $meetingSchedulerData->save();
            $aResult['status'] =true;
        }
        else{
            $aResult['status'] =false;
        }
        echo json_encode($aResult);
    }

    public function surveyrespondnotinterestedAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        if( $this->getRequest()->isPost()){
            $aData                 = $this->_request->getPost();
            $meetingSchedulerTable =  Engine_Api::_()->getDbtable('meetingscheduler', 'user');
            $meetingSchedulerData = $meetingSchedulerTable->fetchRow($meetingSchedulerTable->select()->where('id = ?', $aData['scheduler_id']));
            $meetingSchedulerData -> survey_notification_status = 'survey_not_respond'; //not respond
            $meetingSchedulerData -> survey_notification_later  = $later_date;
            $meetingSchedulerData -> updated_at                 = date('Y-m-d');
            $meetingSchedulerData->save();
            $aResult['status'] =true;
        }
        else{
            $aResult['status'] =false;
        }
        echo json_encode($aResult);
    }

    public function surveyrespondsubmitAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        if( $this->getRequest()->isPost()){
            $aData                         = $this->_request->getPost();
            $scheduler_id                  = $aData['scheduler_id'];
            $surveyansArray                = $aData['surveyansArray'];
            $meetingSchedulerTable         =  Engine_Api::_()->getDbtable('meetingscheduler', 'user');
            $survey_question_answerTable   =  Engine_Api::_()->getDbtable('Surveyquestionsansweroptions', 'user');
            $SurveyquestionsresponseTable  =  Engine_Api::_()->getDbtable('Surveyquestionsresponse', 'user');
            $meetingSchedulerData          = $meetingSchedulerTable->fetchRow($meetingSchedulerTable->select()->where('id = ?', $scheduler_id));
            $respondent_id                 = $meetingSchedulerData->scheduled_with;
            for($i=0;$i<count($surveyansArray);$i++){
                $surveyQuestionAnswerData      = $survey_question_answerTable->fetchRow($survey_question_answerTable->select()->where('id = ?', $surveyansArray[$i]));
                $Surveyquestionsresponseid     = $SurveyquestionsresponseTable->insert(array(
                        'scheduler_id'    => $scheduler_id,
                        'survey_question_id'  => $surveyQuestionAnswerData->survey_question_id,
                        'respondent_id'  => $respondent_id,
                        'response'  => $surveyansArray[$i],
                        'created_at'      => date('Y-m-d'),
                        'updated_at'      => date('Y-m-d')
                        ));
            }
            $meetingSchedulerData -> survey_notification_status  = 'survey_responded';
            $meetingSchedulerData -> updated_at                  = date('Y-m-d');
            $meetingSchedulerData -> save();
            $aResult['status'] =true;
        }
        else{
            $aResult['status'] =false;
        }
        echo json_encode($aResult);
    }

    public function likeuserAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        $viewer         = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viewer_id  = Engine_Api::_()->user()->getViewer()->getIdentity();
        if( $this->getRequest()->isPost()){
            $aData            = $this->_request->getPost();
            $user_id          = $aData['user_id'];
            $likeuserTable    =  Engine_Api::_()->getDbtable('likeuser', 'user');
            $likeuserTableid  =   $likeuserTable->insert(array(
                    'subject_id'      => $viewer_id,
                    'object_id'       => $user_id,
                    'type'            => 'user',
                    'created_at'      => date('Y-m-d'),
                    'updated_at'      => date('Y-m-d')
                    ));
            $aResult['status'] =true;
        }
        else{
            $aResult['status'] =false;
        }
        echo json_encode($aResult);
    }

    public function unlikeuserAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        $viewer         = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viewer_id     = Engine_Api::_()->user()->getViewer()->getIdentity();
        if( $this->getRequest()->isPost()){
        $aData       = $this->_request->getPost();
        $user_id     = $aData['user_id'];
        Engine_Db_Table::getDefaultAdapter()->delete('engine4_like_user', array('subject_id = ?'=>$viewer_id,'object_id = ?'=>$user_id) );
        $aResult['status'] = true;
        }
        else{
            $aResult['status'] =false;
        }
        echo json_encode($aResult);

    }

    public function getlikedusersAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        $viewer_id      = Engine_Api::_()->user()->getViewer()->getIdentity();
        $connectionApi  =   Engine_Api::_()->getApi('connections', 'user');
        $html           =   $connectionApi->getlikedusersajaxResults($viewer_id);
        return $html;
    }
    public function defaultapplicationviewAction(){

        if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('property_detail');
        $viewer          = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viewer_id       = Engine_Api::_()->user()->getViewer()->getIdentity();
        $fieldsByAlias   = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
        if( !empty($fieldsByAlias['profile_type']) ){
              $optionId        = $fieldsByAlias['profile_type']->getValue($viewer);
              $profile_type_id = $optionId->value;
        }
        if($profile_type_id != 1){ //if not tenant
            return $this->_forward('notfound');
        }
        $rentalApplicationsTable =  Engine_Api::_()->getDbtable('rentalapplications', 'user');
        $this->view->application = $rentalApplicationsData = $rentalApplicationsTable->fetchRow($rentalApplicationsTable->select()->where('tenant_id = ?', $viewer_id));

       //echo '<pre>'; print_r($this->view->application); exit;
    }

    public function packageAction(){

        if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('smartmove_api');
        $viewer            = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viewer_id         = Engine_Api::_()->user()->getViewer()->getIdentity();
        $fieldsByAlias     = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
        if( !empty($fieldsByAlias['profile_type']) ){
              $optionId        = $fieldsByAlias['profile_type']->getValue($viewer);
              $profile_type_id = $optionId->value;
        }
        if($profile_type_id != 1){ //if not tenant
            return $this->_forward('notfound');
        }

        $viewHelperObj   = $this->view->getHelper('SmartmoveApi125');
        $stripefiles     = $viewHelperObj->getStripeFiles(); // smartmove api exam evaluate
      $params = array(
            "testmode"   => "off",
            "private_live_key" => "sk_live_bcnF3vdwkx2Q405aOq7POiep",
            "public_live_key"  => "pk_live_evBvNtpwiJlCwieyHNPKsQLO",
            "private_test_key" => "sk_test_K2gnuPgv5SH1P3lkvw86TJIQ",
            "public_test_key"  => "pk_test_kCahdc8oaSK65WPNb3iClcF1"
        );

        if ($params['testmode'] == "on") {
        Stripe::setApiKey($params['private_test_key']);
        $pubkey = $params['public_test_key'];
        } else {
        Stripe::setApiKey($params['private_live_key']);
        $pubkey = $params['public_live_key'];
        }
        $this->view->params = $params;
        if(isset($_POST['stripeToken']))
        {
            $selected_packagerate = $_POST['selected_packagerate'];
            $selected_package     = $_POST['selected_package'];
            $score                = $_POST['score'];
            if($score == 1){
                $transunion_score_rate = 9.99;
                $package_rate          = $selected_packagerate + $transunion_score_rate;
            }
            else{
                $transunion_score_rate = 0;
                $package_rate = $selected_packagerate;
            }
            if($selected_packagerate !='' && $selected_package !=''){
            //$amount_cents = str_replace(".","",20.2);  // Chargeble amount
            $amount_cents = str_replace(".","",$package_rate);  // Chargeble amount
            $invoiceid    = "14526321";                      // Invoice ID
            $description  = "Invoice #" . $invoiceid . " - " . $invoiceid;
            try {
            $charge = Stripe_Charge::create(array(
                  "amount" => $amount_cents,
                  "currency" => "usd",
                  "source" => $_POST['stripeToken'],
                  "description" => $description
                  )
            );
                if ($charge->card->address_zip_check == "fail") {
                    throw new Exception("zip_check_invalid");
                } else if ($charge->card->address_line1_check == "fail") {
                    throw new Exception("address_check_invalid");
                } else if ($charge->card->cvc_check == "fail") {
                    throw new Exception("cvc_check_invalid");
                }
            // Payment has succeeded, no exceptions were thrown or otherwise caught
            $result = "success";
            }
            catch(Stripe_CardError $e) {

            $error = $e->getMessage();
                $result = "declined";

            } catch (Stripe_InvalidRequestError $e) {
                $result = "declined";
            } catch (Stripe_AuthenticationError $e) {
                $result = "declined";
            } catch (Stripe_ApiConnectionError $e) {
                $result = "declined";
            } catch (Stripe_Error $e) {
                $result = "declined";
            } catch (Exception $e) {

                if ($e->getMessage() == "zip_check_invalid") {
                    $result = "declined";
                } else if ($e->getMessage() == "address_check_invalid") {
                    $result = "declined";
                } else if ($e->getMessage() == "cvc_check_invalid") {
                    $result = "declined";
                } else {
                    $result = "declined";
                }
            }
            //echo "<BR>Stripe Payment Status : ".$result;

            //echo "<BR>Stripe Response : ";

            //echo '<pre>'; print_r($e);
            //echo '<pre>'; print_r($charge);


            if($result == 'success'){
                $PaymentpackageTable   =  Engine_Api::_()->getDbtable('Paymentpackage', 'user');
                $PaymentpackageTableId =   $PaymentpackageTable->insert(array(
                    'user_id'                 => $viewer_id,
                    'package_name'            => $selected_package,
                    'package_rate'            => $selected_packagerate,
                    'transunion_score_rate'   => $transunion_score_rate,
                    'score'                   => $score,
                    'active'                  => 1,
                    'created_at'              => date('Y-m-d'),
                    'updated_at'              => date('Y-m-d')
                    ));
            }
         }
       }
    }
    public function sharereportAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        $viewer          = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viewer_id       = Engine_Api::_()->user()->getViewer()->getIdentity();
        $fieldsByAlias   = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
        if( !empty($fieldsByAlias['profile_type']) ){
              $optionId        = $fieldsByAlias['profile_type']->getValue($viewer);
              $profile_type_id = $optionId->value;
        }
        if($profile_type_id != 1){ //if not tenant
            return $this->_forward('notfound');
        }
        if( $this->getRequest()->isPost()){
            $aData                      = $this->_request->getPost();
            $report_shared_with         = $aData['report_shared_with'];
            $ReportshareTable           = Engine_Api::_()->getDbtable('Reportshare', 'user');
            $SmartmoveapireportTable    = Engine_Api::_()->getDbtable('Smartmoveapireport', 'user');
            $Reportrequest_table        = Engine_Api::_()->getDbtable('Reportrequest', 'user');
            $SmartmoveapireportData     = $SmartmoveapireportTable->fetchRow($SmartmoveapireportTable->select()->where('RenterId = ?', $viewer_id)->where('status   = ?', 'Active'));

            $today                            = date('Y-m-d H:i:s');
            // Today shared report lists
            $ReportshareAtTodayData            = $ReportshareTable->fetchAll($ReportshareTable->select()
                                                                                       ->where('report_shared_by     = ?', $viewer_id)
                                                                                       ->where('created_at     = ?', $today)
                                                                                       ->where('status  = ?', 'Active'));

            if(count($ReportshareAtTodayData) > 5){
                 $aResult['status'] =false;
                 $aResult['message'] = 'You can share  report upto five landlords per day , Your limit is over';
            }
            else{
            $ReportshareData            = $ReportshareTable->fetchRow($ReportshareTable->select()->where('report_shared_with    = ?', $report_shared_with)
                                                                                       ->where('report_shared_by     = ?', $viewer_id)
                                                                                       ->where('status  = ?', 'Active'));
            if(count($ReportshareData) == 0){
                $ReportshareTableId                =  $ReportshareTable->insert(array(
                        'report_shared_by'         => $viewer_id,
                        'report_shared_with'       => $report_shared_with,
                        'report_id'                => $SmartmoveapireportData->id,
                        'status'                   => $SmartmoveapireportData->status,
                        'created_at'               => date('Y-m-d'),
                        'updated_at'               => date('Y-m-d')
                        ));

                $ReportrequestData = $Reportrequest_table->fetchRow($Reportrequest_table->select()->where('renter_id = ?', $viewer_id)
                                                                                                ->where('landlord_id = ?', $report_shared_with)
                                                                                                ->where('status = ?', 'Requested'));
               
               if(count($ReportrequestData) >0){               
                $ReportrequestData->status = 'Shared';
                $ReportrequestData->save();
			   }
                $aResult['status'] =true;
                    // send notification
                $userTable               = Engine_Api::_()->getDbtable('users', 'user');
                $report_shared_with_data = $userTable->fetchRow($userTable->select()->where('user_id = ?', $report_shared_with));
                Engine_Api::_()->getDbtable('notifications', 'activity')
                        ->addNotification($report_shared_with_data, $viewer, $report_shared_with_data, 'share_report',array(
                      'label' => $viewer_id,'user_id' => $viewer_id));
            }
            else{
                $aResult['status']  =   false;
                $aResult['message'] = 'Report has been already shared';
            }
        }
       }
        echo json_encode($aResult);
    }

    public function roomdetailsAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

    $this->_helper->viewRenderer->setNoRender(true);
    $this->_helper->layout->disableLayout();
    $aData                          =  $this->_request->getPost();
    $tenant_id                      =  $aData['tenantid'];
    $propertyRequirementTable       =  Engine_Api::_()->getDbtable('propertyrequirement', 'user');
    $propertyRequirementVillaselect = $propertyRequirementTable->select()
                    ->setIntegrityCheck(false)
                    ->from(array('property_req'=>'engine4_property_requirement',))
                    ->where('tenant_id = ?', $tenant_id)
                    ->where('housing_type = ?', 'Room')
                    ->joinLeft(array('state'=>'engine4_state_list',),'state.state_id=property_req.state_id',array('state'))
                    ->joinLeft(array('city'=>'engine4_city_list',),'city.city_id=property_req.city_id',array('city'))
                    ;
   $propertyRequirementVillaData       = $propertyRequirementTable->fetchAll($propertyRequirementVillaselect);
   $propertyRequirementApartmentselect = $propertyRequirementTable->select()
                    ->setIntegrityCheck(false)
                    ->from(array('property_req'=>'engine4_property_requirement',))
                    ->where('tenant_id = ?', $tenant_id)
                    ->where('housing_type = ?', 'Apartment')
                    ->where('no_of_rooms!=?','0')
                    ->joinLeft(array('state'=>'engine4_state_list',),'state.state_id=property_req.state_id',array('state'))
                    ->joinLeft(array('city'=>'engine4_city_list',),'city.city_id=property_req.city_id',array('city'))
                    ;
   $propertyRequirementApartmentData  = $propertyRequirementTable->fetchAll($propertyRequirementApartmentselect);
   $propertyRequirementHouseselect    = $propertyRequirementTable->select()
                    ->setIntegrityCheck(false)
                    ->from(array('property_req'=>'engine4_property_requirement',))
                    ->where('tenant_id = ?', $tenant_id)
                    ->where('housing_type = ?', 'House')
                    ->joinLeft(array('state'=>'engine4_state_list',),'state.state_id=property_req.state_id',array('state'))
                    ->joinLeft(array('city'=>'engine4_city_list',),'city.city_id=property_req.city_id',array('city'))
                    ;
   $propertyRequirementHouseData      = $propertyRequirementTable->fetchAll($propertyRequirementHouseselect);
   $roomappartmenthouselocationselect = $propertyRequirementTable->select()
                    ->setIntegrityCheck(false)
                    ->from(array('property_req'=>'engine4_property_requirement',))
                    ->joinLeft(array('state'=>'engine4_state_list',),'state.state_id=property_req.state_id',array('state'))
                    ->joinLeft(array('city'=>'engine4_city_list',),'city.city_id=property_req.city_id',array('city'))
                    ->where('property_req.tenant_id = ?', $tenant_id)
                    ->where('(property_req.housing_type = ?', 'House' )
                    ->orWhere('property_req.housing_type = ?', 'Apartment')
                    ->orWhere('property_req.housing_type = ?)', 'Room')
                    ->group(array('city.city_id'))
                    ;
      $roomappartmenthouselocationData = $propertyRequirementTable->fetchAll($roomappartmenthouselocationselect);

      $content = $content.'';
      $content = $content.'<div class="room_div">';
      $content = $content.' <span style="float:left; width:33%;" class="mob_details" >';
      if(count($propertyRequirementApartmentData)>0):

      $content = $content.count($propertyRequirementApartmentData).'Apartment &nbsp;' ;
      endif ;

      $content =  $content.'</span>&nbsp;&nbsp;&nbsp;&nbsp;';

      $content =  $content.'<div style="float:left;">';
      foreach ($propertyRequirementApartmentData as $row){

      $content =  $content.$row['no_of_rooms'].' Bedroom</br>';
      }

      $content =  $content.'</div>';

      $content =  $content.'<div style="float:left;margin-left:22%;" >';

        foreach ($propertyRequirementApartmentData as $row)
    {
        $content =  $content.$row['state'].','.$row['city'].'</br>';
    }

    $content =  $content.'</div>';

    $content =  $content.'<span style="float:left; width:33%;" class="mob_details">';
    if(count($propertyRequirementHouseData)>0):
    $content = $content.count($propertyRequirementHouseData);
    $content = $content.'House &nbsp';
    endif ;
    $content = $content.'</span>&nbsp;&nbsp;&nbsp;&nbsp';

    $content = $content.'<div style="float:left;"> ';

    foreach ($propertyRequirementHouseData as $row)
    {
        $content = $content.$row['no_of_rooms'].' Bedroom'.'</br>';
    }
    $content = $content.'</div>';
    $content = $content.'<span style="float:left;margin-left:22%;" > ';

        foreach ($propertyRequirementHouseData as $row)
    {
        $content = $content.$row['state'].','.$row['city'].'</br>';
    }
    $content = $content.'</span>';

    $content =  $content.'<span style="float:left; width:33%;" class="mob_details">';
    if(count($propertyRequirementVillaData)>0):
    $content = $content.count($propertyRequirementVillaData);
    $content = $content.'Room &nbsp';
    endif ;
    $content = $content.'</span>&nbsp;&nbsp;&nbsp;&nbsp';
    $content = $content.'<span class="villa" >';

        foreach ($propertyRequirementVillaData as $row)
    {
        $content = $content.$row['state'].','.$row['city'].'</br>';
    }

    $content = $content.'</span>';

    $content = $content.'</div>';

    $aResult['html'] = $content;
    json_encode($aResult);
    echo json_encode($aResult);

}
    public function creditbackgroundAction(){

        if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $viewer        = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
        if( !empty($fieldsByAlias['profile_type']) ){
              $optionId        = $fieldsByAlias['profile_type']->getValue($viewer);
              $profile_type_id = $optionId->value;
        }
        if($profile_type_id != 1){ //if not tenant
            return $this->_forward('notfound');
        }
        $error_status=0;
        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('smartmove_api');
        $viewer_id                           =  Engine_Api::_()->user()->getViewer()->getIdentity();
        $ReportshareTable                    =  Engine_Api::_()->getDbtable('Reportshare', 'user');
        $smartmoveapiRenters_table           =  Engine_Api::_()->getDbtable('Smartmoveapirenters', 'user');
        $PaymentpackageTable                 =  Engine_Api::_()->getDbtable('Paymentpackage', 'user');
        $SmartmoveapireportTable             =  Engine_Api::_()->getDbtable('Smartmoveapireport', 'user');
        $viewHelperObj                       = $this->view->getHelper('SmartmoveApi125');
        $smartmoveapiRentersData             = $smartmoveapiRenters_table->fetchRow($smartmoveapiRenters_table->select()->where('tenant_id   = ?', $viewer_id));
        $this->view->smartmoveapiRentersData = $smartmoveapiRentersData;
        $smartmoveapiApplication_table       =  Engine_Api::_()->getDbtable('Smartmoveapiapplication', 'user');
        $smartmoveapiApplicationData         =  $smartmoveapiApplication_table->fetchRow($smartmoveapiApplication_table->select()
                                                                   -> where('Applicants      = ?', $smartmoveapiRentersData->   Email)
                                                                   -> order('id  Desc'));
        $this->view->PaymentpackageData      = $PaymentpackageData = $PaymentpackageTable->fetchRow($PaymentpackageTable->select()->where('user_id  = ?', $viewer_id)->where('active   = ?', 1));


        if(count($smartmoveapiApplicationData) > 0 )  {

            $ApplicationStatusResponse = $viewHelperObj->getApplicationStatus($smartmoveapiRentersData->Email,$smartmoveapiApplicationData->SmartmoveApplicationId);
            $ApplicationStatusResponse = json_decode($ApplicationStatusResponse, true);

            if($ApplicationStatusResponse['IdmaVerificationStatus'] == 'Verified'){

                 if(empty($PaymentpackageData)){

                    return $this->_helper->redirector->gotoRoute(array(), 'smartmoveapi_reportpayment', true);
                 }

                $smartmoveapiApplicationData->  IdmaVerificationStatus = $ApplicationStatusResponse['IdmaVerificationStatus'];
                $smartmoveapiApplicationData->  ApplicationStatus      = $ApplicationStatusResponse['ApplicationStatus'];
                $smartmoveapiApplicationData->  save();

                $SmartmoveapireportData                      = $SmartmoveapireportTable->fetchRow($SmartmoveapireportTable->select()->where('RenterId = ?', $viewer_id)->where('status =? ','Active'));

                if(count($SmartmoveapireportData) == 0){

                $reportResponse              = $viewHelperObj->createReport($smartmoveapiRentersData->Email,$smartmoveapiApplicationData->SmartmoveApplicationId);  // smartmove api create report

                if ($reportResponse === false)
                        {
                        $aResult['status'] = false;
                        $aResult['errors'] = curl_error($crl);
                        }
                else{
                        $reportResponse = json_decode($reportResponse,true);
                        if(empty($reportResponse['Errors'])){
						
                            $ApplicationStatusResponse = $viewHelperObj->getApplicationStatus($smartmoveapiRentersData->Email,$smartmoveapiApplicationData->SmartmoveApplicationId);
                            $ApplicationStatusResponse = json_decode($ApplicationStatusResponse, true);
                        //  print_r($ApplicationStatusResponse);
                            $applicationResponse       = $viewHelperObj->getApplication($smartmoveapiApplicationData->SmartmoveApplicationId);
                            if ($applicationResponse === false)
                            {
                                $aResult['status'] = false;
                                $aResult['errors'] = curl_error($crl);
                            }
                            $applicationData    = json_decode($applicationResponse, true);
                            if(empty($applicationData['Errors'])){  //print_r($applicationData); exit;
						        $settings                      = Engine_Api::_()->getApi('settings', 'core');
                                $this->view->applicationData   =  $applicationData;
                                $SmartmoveapireportTable       = Engine_Api::_()->getDbtable('Smartmoveapireport', 'user');
                                $duration                      = $settings->user_backgroundReportExpiry;
                                $days                          = "+".$duration." days";
                                $expiry_date                   = date('d-m-Y', strtotime($days));
                                $SmartmoveapireportTable->insert(array(
                                    'SmartmoveApplicationId'  => $smartmoveapiApplicationData->SmartmoveApplicationId,
                                    'RenterId'                => $viewer_id,
                                    'reportResponse'          => $applicationResponse,
                                    'status'                  => 'Active',
                                    'expiry_date'             =>  $expiry_date,
                                    'created_date'            =>  date('d-m-Y'),
                                    'created_at'              =>  date('Y-m-d'),
                                    'updated_at'              =>  date('Y-m-d')
                                    ));
                                    
                               $InvitedrentersbackgroundreportTable = Engine_Api::_()->getDbtable('Invitedrentersbackgroundreport', 'user');
                               $InvitedrentersbackgroundreportData      = $InvitedrentersbackgroundreportTable->fetchRow($InvitedrentersbackgroundreportTable->select()
                                  ->where('renter_email  = ?', $viewer->email)
                                  ->where('renter_id  = ?', $viewer_id)
                                  ->where('backgroundReport  = ?', 0)                                  
                                  );
							if(count($InvitedrentersbackgroundreportData)>0){
								$InvitedrentersbackgroundreportData->backgroundReport = 1;
								$InvitedrentersbackgroundreportData->save();
					        }
					
                            }
                        }
                        else{ 
							if(in_array("Reports not available. Please contact your Account Representative. (Error Code: 203052)",$reportResponse['Errors'])):
							$error_status = 1 ;
						    $error_msg = "Reports not available. Please contact your Account Representative.Contact Number is 866.775.0961";
						//echo  $error_msg;exit;
							endif;
							  }
                    }


                 }
                 else{
                            $applicationResponse       = $viewHelperObj->getApplication($smartmoveapiApplicationData->SmartmoveApplicationId);
                            if ($applicationResponse === false)
                            {
                                $aResult['status'] = false;
                                $aResult['errors'] = curl_error($crl);
                            }
                            $applicationData    = json_decode($applicationResponse, true);
                            if(empty($applicationData['Errors'])){  //print_r($applicationData); exit;
								$settings                      = Engine_Api::_()->getApi('settings', 'core');
                                $this->view->applicationData   =  $applicationData;
                                $SmartmoveapireportTable       = Engine_Api::_()->getDbtable('Smartmoveapireport', 'user');
                                $duration                      = $settings->user_backgroundReportExpiry;
                                $days                          = "+".$duration." days";
                                $expiry_date                   = date('d-m-Y', strtotime($days));
                                $SmartmoveapireportTable->insert(array(
                                    'SmartmoveApplicationId'  => $smartmoveapiApplicationData->SmartmoveApplicationId,
                                    'RenterId'                => $viewer_id,
                                    'reportResponse'          => $applicationResponse,
                                    'status'                  => 'Active',
                                    'expiry_date'             =>  $expiry_date,
                                    'created_date'            =>  date('d-m-Y'),
                                    'created_at'              =>  date('Y-m-d'),
                                    'updated_at'              =>  date('Y-m-d')
                                    ));
                            }


                 }


              }
             elseif($ApplicationStatusResponse['IdmaVerificationStatus'] == 'Unverified'){
                return $this->_helper->redirector->gotoRoute(array(), 'smartmoveapi_evaluateexam', true);
             }
             else{
                 return $this->_helper->redirector->gotoRoute(array(), 'smartmoveapi_updaterenter', true);
             }


        }
        else{
            return $this->_helper->redirector->gotoRoute(array(), 'smartmoveapi_evaluateexam', true);

        }
        $this->view->ReportshareData      = $ReportshareData    = $ReportshareTable->fetchAll($ReportshareTable->select()->where('report_shared_by     = ?', $viewer_id)->where('status   = ?', 'Active'));
        $this->view->PaymentpackageData   = $PaymentpackageData = $PaymentpackageTable->fetchRow($PaymentpackageTable->select()->where('user_id  = ?', $viewer_id)->where('active   = ?', 1));
        $today                            = date('d-m-Y');
        $today_date                       = strtotime($today);
        $expiry_date                      = strtotime($PaymentpackageData->expiry_date);
        $remainder_mail                   = 0;
        $diff                             = $expiry_date - $today_date;
        $this->view->Time_left_before_report_expires = $day_diif =  round($diff / 86400);
        $SmartmoveapireportData                      = $SmartmoveapireportTable->fetchRow($SmartmoveapireportTable->select()->where('RenterId = ?', $viewer_id)->where('status =? ','Active'));
        if(count($SmartmoveapireportData) == 0){
         //    return $this->_helper->redirector->gotoRoute(array(), 'smartmoveapi_updaterenter', true);
         
         
        }
        $report_response =  $SmartmoveapireportData -> reportResponse;
        $reportData      = json_decode($report_response, true);
        foreach($reportData['Applicants'] as $applicant):
         $ApplicantStatus = $applicant['ApplicantStatus'];
        endforeach;
        if($ApplicantStatus =='ReportsRequested'){
            $applicationResponse = $viewHelperObj->getApplication($SmartmoveapireportData -> SmartmoveApplicationId);
                            if ($applicationResponse === false)
                            {
                                $aResult['status'] = false;
                                $aResult['errors'] = curl_error($crl);
                            }
                            $applicationData = json_decode($applicationResponse, true);
                            if(empty($applicationData['Errors'])){  //print_r($applicationData); exit;
                                $SmartmoveapireportData->reportResponse = $applicationResponse;
                                $SmartmoveapireportData->save();
                            }

        }
        $SmartmoveapireportData  =  $SmartmoveapireportTable->fetchRow($SmartmoveapireportTable->select()->where('RenterId = ?', $viewer_id)->where('status =? ','Active'));
        $report_response         =  $SmartmoveapireportData -> reportResponse;
        $reportData              = json_decode($report_response, true);
        $this->view->reportData  = $reportData = json_decode($report_response, true);
        $Reportrequest_table     =  Engine_Api::_()->getDbtable('Reportrequest', 'user');
        $ReportrequestDataSelect = $Reportrequest_table->select()
                                    ->where('renter_id = ?', $viewer_id)
                                    ->where('status = ?', 'Requested')
                                    ->group('renter_id');
        $this->view->ReportrequestData  = $ReportrequestData = $Reportrequest_table->fetchAll($ReportrequestDataSelect);
        $ReportsharedDataSelect         = $Reportrequest_table->select()
                                            ->where('renter_id = ?', $viewer_id)
                                            ->where('status = ?', 'Shared')
                                            ->group('renter_id');
        $this->view->ReportsharedData  = $ReportsharedData = $Reportrequest_table->fetchAll($ReportsharedDataSelect);

        $ReportshareTable                      = Engine_Api::_()->getDbtable('Reportshare', 'user');

        $this->view->ReportsharedActiveData    = $ReportshareTable->fetchAll($ReportshareTable->select()
                                                                                       ->where('report_shared_by     = ?', $viewer_id)
                                                                                       ->where('status  = ?', 'Active'));
                                                                                  
        $today                                 = date('Y-m-d');
        $this->view->ReportshareAtTodayData    = $ReportshareTable->fetchAll($ReportshareTable->select()
                                                                                       ->where('report_shared_by     = ?', $viewer_id)
                                                                                       ->where('created_at     = ?', $today)
                                                                                       ->where('status  = ?', 'Active'));
      
        $this->view->error_status=$error_status;
        $this->view->error_message=$error_msg;
   
    }

    public function deletepreferenceAction()
    {
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
    $viewer     = Engine_Api::_()->user()->getViewer();
    date_default_timezone_set($viewer->timezone);
    $this->_helper->viewRenderer->setNoRender(true);
    $this->_helper->layout->disableLayout();
    $oData          = $this->_request->getPost();
    $preference_id  = $oData['preference_id'];
    $user_id        = $oData['user_id'];
    $preferencename        = $oData['preferencename'];
    try{

        $FeedPreferenceUnitTable = Engine_Api::_()->getDbtable('Feedpreferenceunit', 'user');
        Engine_Db_Table::getDefaultAdapter()->delete('engine4_feedpreference_unit', array('id = ?'=>$preference_id) );

        if($preferencename == $_SESSION['matching_array']['preference_name']){
            unset($_SESSION['matching_array']);
        }
        $FeedPreferenceUnitDataSelect = $FeedPreferenceUnitTable->select()
                                        ->where('userid = ?', $user_id);

        $FeedPreferenceUnitData       = $FeedPreferenceUnitTable->fetchAll($FeedPreferenceUnitDataSelect);
        $preference_count             = count($FeedPreferenceUnitData);
            $aResult['status'] = true;
            $aResult['preference_count'] = $preference_count;
       }catch (Exception $e)
       {//exit($e->getMessage());
                                $aResult['status'] = false;
       }
       echo json_encode($aResult);
   }

    public function filterpreferenceunitAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();

        if(isset($_SESSION['countryId'])){
            unset($_SESSION['countryId']);
            unset($_SESSION['stateId']);
            unset($_SESSION['cityId']);
        }
        unset($_SESSION['set_to_usa']);
        unset($_SESSION['feedicon']);
        unset($_SESSION['matching_array']);
        unset($_SESSION['feedpreferenceunit']);
        unset($_SESSION['feedpreferenceunitmore']);
        unset($_SESSION['location_mode_array']);
        unset($_SESSION['zipcode']);
        unset($_SESSION['country_name']);
        unset($_SESSION['state_name']);
        unset($_SESSION['city_name']);
        unset($_SESSION['county_name']);
        unset($_SESSION['neighborhood_name']);

        if( $this->getRequest()->isPost()){
            $viewer_id = $viewer->getIdentity();
            $aData     = $this->_request->getPost();
            $feedpreferenceUnitid    = $aData['feedpreferenceUnitid'];
            $FeedPreferenceUnitTable = Engine_Api::_()->getDbtable('Feedpreferenceunit', 'user');

            $FeedPreferenceUnitDataSelect = $FeedPreferenceUnitTable->select()
                                    ->where('id = ?', $feedpreferenceUnitid);
            $FeedPreferenceUnitData = $FeedPreferenceUnitTable->fetchRow($FeedPreferenceUnitDataSelect);
                $matching_array =[];

                $matching_array['housing_types']   =  $FeedPreferenceUnitData->housing_type;
                $matching_array['is_petsallowd']   = $FeedPreferenceUnitData->is_petsallowd;
                $matching_array['pets_type']       = $FeedPreferenceUnitData->pets_type;
               /* $matching_array['price']           = $FeedPreferenceUnitData->price;
                $pricearray =  explode('-', $matching_array['price']);
                $matching_array['price_from']      = (int)$pricearray['0'];
                $matching_array['price_to']        = (int)$pricearray['1'];*/
                $matching_array['price_from']           = $FeedPreferenceUnitData->price;
                $matching_array['price_to']        = $FeedPreferenceUnitData->price_to;
                $matching_array['no_of_bedrooms']  = $FeedPreferenceUnitData->number_of_rooms;
                $matching_array['countryId']       = $FeedPreferenceUnitData->countryId;
                $matching_array['stateId']         = $FeedPreferenceUnitData->stateId;
                $matching_array['cityId']          = $FeedPreferenceUnitData->cityId;
                $matching_array['countryName']     = $FeedPreferenceUnitData->countryName;
                $matching_array['stateName']       = $FeedPreferenceUnitData->stateName;
                $matching_array['cityName']        = $FeedPreferenceUnitData->cityName;
                $matching_array['countyName']        = $FeedPreferenceUnitData->countyName;
                $matching_array['neighborhoodName']        = $FeedPreferenceUnitData->neighborhoodName;
                $matching_array['zip']             = $FeedPreferenceUnitData->zip;
                $matching_array['preference_name']   =  "Preference ".$aData['preference_number'];
                $_SESSION['matching_array']     = $matching_array;
                $_SESSION['feedicon']           = 1;
                $_SESSION['feedpreferenceunit'] = $count;
                $aResult['status'] = true;
        }
        else{
              $aResult['status'] = false;
        }
        echo json_encode($aResult['status']);
    }

    public function tichatappAction(){
        if( !$this->_helper->requireUser()->isValid() ) {
                return;
        }
        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('default');
        $viewer_id  = Engine_Api::_()->user()->getViewer()->getIdentity();
        $this->view->viewer =$viewer = Engine_Api::_()->user()->getViewer();
        $this->view->viewerId     =  $viewerId = $viewer->getIdentity();
    }
    public function fcraagreementAction(){
        if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('common_layout');
        $viewer     = Engine_Api::_()->user()->getViewer();
        $viewer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
    }

    /* cron set per day for report enable disable */
    public function reportstatusupdatesAction(){

        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        $userTable = Engine_Api::_()->getDbtable('users', 'user');
        $usersdata = $userTable->getAdapter()->select()
                        ->from(array('user'=>'engine4_users'))
                        ->query()->fetchAll();
        $PaymentpackageTable        =  Engine_Api::_()->getDbtable('Paymentpackage', 'user');
        $SmartmoveapireportTable    = Engine_Api::_()->getDbtable('Smartmoveapireport', 'user');
        $ReportshareTable           =  Engine_Api::_()->getDbtable('Reportshare', 'user');
        $Reportrequest_table        =  Engine_Api::_()->getDbtable('Reportrequest', 'user');
        $today = date('d-m-Y');
        foreach($usersdata as $user){
            $UserData             =  $userTable->fetchRow($userTable->select()->where('user_id = ?', $user['user_id']));
            $fieldsByAlias        = Engine_Api::_()->fields()->getFieldsObjectsByAlias($UserData);
            if( !empty($fieldsByAlias['profile_type']) )
            {
                  $optionId        = $fieldsByAlias['profile_type']->getValue($UserData);
                  $profile_type_id = $optionId->value;
            }
            if($profile_type_id == 1){ // renter
                $PaymentpackageData  = $PaymentpackageTable->fetchRow($PaymentpackageTable->select()->where('user_id = ?', $user['user_id'])->where('active= ?', 1));
                if(count($PaymentpackageData)>0){
                    $today          = date('d-m-Y');
                    $today_date     = strtotime($today);
                    $expiry_date    = strtotime($PaymentpackageData->expiry_date);
                        if($today_date>$expiry_date){
                        $PaymentpackageData->   active = 0;
                        $PaymentpackageData->   save();
                        }
                }
                $SmartmoveapireportData = $SmartmoveapireportTable->fetchRow($SmartmoveapireportTable->select()->where('RenterId     = ?', $user['user_id'])->where('status = ?', 'Active'));

                if(count($SmartmoveapireportData)>0){
                    $today          = date('d-m-Y');
                    $today_date     = strtotime($today);
                    $expiry_date    = strtotime($SmartmoveapireportData->expiry_date);
                    if($today_date>$expiry_date){
                    $SmartmoveapireportData->   status = 'Closed';
                    $SmartmoveapireportData->   save();
                    $ReportshareData = $ReportshareTable->fetchAll($ReportshareTable->select()->where('report_shared_by = ?', $user['user_id'])
                                                                                                  ->where('status   = ?', 'Active'));

                        if(count($ReportshareData) >0){
                            foreach($ReportshareData as $reportshare)   {
                                $ReportshareData1 = $ReportshareTable->fetchRow($ReportshareTable->select()->where('report_shared_by    = ?', $reportshare['report_shared_by']));
                                $ReportshareData1-> status = 'Closed';
                                $ReportshareData1-> save();
                            }
                        }
                    }
                }
            }
            if($profile_type_id == 4){  // landlord
                $ReportrequestData = $Reportrequest_table->fetchAll($Reportrequest_table->select()->where('landlord_id = ?', $user['user_id']));
                foreach($ReportrequestData  as $data){
                $today_date     = strtotime($today);
                $expiry_date    = strtotime($data['expiry_date']);
                    if($today_date>$expiry_date){
                    $ReportrequestData1 = $Reportrequest_table->fetchRow($Reportrequest_table->select()->where('id = ?', $data['id']));
                    $ReportrequestData1->   status = 'Closed';
                    $ReportrequestData1->   save();
                    }
                }
            }
        }

                                   // entry for cron log

            $cronlogTable =  Engine_Api::_()->getDbtable('cronlog', 'user');
            $cronlogData = $cronlogTable->fetchRow($cronlogTable->select()->where('type = ?', 'report_enable_disable'));
            if(count($cronlogData) > 0){
                $cronlogData->execution_count = $cronlogData->execution_count +1;
                $cronlogData->created_at = date('Y-m-d');
                $cronlogData->save();
            }
            else{
            $cronlogTableId=   $cronlogTable->insert(array(
                                    'type' => 'report_enable_disable',
                                    'execution_count' => 1,
                                    'created_at' => date('Y-m-d'),
                                ));
            }
    exit("success");
    }

    public function deleterequirementAction()
    {
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

    $this->_helper->viewRenderer->setNoRender(true);
    $this->_helper->layout->disableLayout();
    $viewer     = Engine_Api::_()->user()->getViewer();
    date_default_timezone_set($viewer->timezone);
    $oData          = $this->_request->getPost();
    $preference_id  = $oData['requirement_id'];
    try{
    $propertyRequirementTable =  Engine_Api::_()->getDbtable('propertyrequirement', 'user');
    Engine_Db_Table::getDefaultAdapter()->delete('engine4_property_requirement', array('id = ?'=>$preference_id) );
        $aResult['status'] = true;
       }catch (Exception $e)
       {exit($e->getMessage());
                                $aResult['status'] = false;
       }
        echo json_encode($aResult);
   }
    public function likepropertyAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

     $this->_helper->viewRenderer->setNoRender(true);
     $this->_helper->layout->disableLayout();
     $viewer     = Engine_Api::_()->user()->getViewer();
     date_default_timezone_set($viewer->timezone);
     $viewer_id  = Engine_Api::_()->user()->getViewer()->getIdentity();
     if( $this->getRequest()->isPost()){
            $aData           = $this->_request->getPost();
            $property_id     = $aData['property_id'];
            $likeuserTable   =  Engine_Api::_()->getDbtable('likeuser', 'user');
            $likeuserTableid =   $likeuserTable->insert(array(
                    'subject_id'      => $viewer_id,
                    'object_id'       => $property_id,
                    'type'            => 'property',
                    'created_at'      => date('Y-m-d'),
                    'updated_at'      => date('Y-m-d')
                    ));
            $aResult['status'] =true;
        }
        else{
            $aResult['status'] =false;
        }

        echo json_encode($aResult);
    }

     public function unlikepropertyAction(){
		 if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viewer_id  = Engine_Api::_()->user()->getViewer()->getIdentity();
        if( $this->getRequest()->isPost()){
        $aData         = $this->_request->getPost();
        $property_id   = $aData['property_id'];
        Engine_Db_Table::getDefaultAdapter()->delete('engine4_like_user', array('subject_id = ?'=>$viewer_id,'object_id = ?'=>$property_id) );
        $aResult['status'] =true;
        }
        else{
            $aResult['status'] =false;
        }
        echo json_encode($aResult);
     }


      public function getlikedpropertiesAction(){
		  if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        $viewer_id      = Engine_Api::_()->user()->getViewer()->getIdentity();
        $connectionApi  =   Engine_Api::_()->getApi('connections', 'user');
        $html           =   $connectionApi->getlikedpropertiesajaxResults($viewer_id);
        return $html;
    }


      public function smartmovenotificationAction(){
		  if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }


          $this->_helper->viewRenderer->setNoRender(true);
          $this->_helper->layout->disableLayout();
          $this->_helper->viewRenderer->setNoRender(false);
          $this->_helper->layout->setLayout('smartmove_notification');
          $viewer_id  = Engine_Api::_()->user()->getViewer()->getIdentity();
          $this->view->viewer =$viewer = Engine_Api::_()->user()->getViewer();
          $this->view->viewerId     =  $viewerId = $viewer->getIdentity();

      }


       public function postfeedcommentAction(){
		   if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);

        $viewer_id  = Engine_Api::_()->user()->getViewer()->getIdentity();
        $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
        if( !empty($fieldsByAlias['profile_type']) ){
              $optionId        = $fieldsByAlias['profile_type']->getValue($viewer);
              $profile_type_id = $optionId->value;
        }
        
        if( $this->getRequest()->isPost()){
            $aData                  = $this->_request->getPost();
            $action_id              = $aData['action_id'];
            $poster_id              = $aData['poster_id'];
            $status                 = $aData['status'];
            $propertyid             = $aData['propertyid'];
            $article_comment_body   = $aData['feed_comment_body'];
            $postcommentTable       =  Engine_Api::_()->getDbtable('Postcomments', 'user');
            $postcommentTableId     =   $postcommentTable->insert(array(

                        'type'            => 'property_feed',
                        'actionId'        => $propertyid,
                        'posterId'        => $viewer_id,
                        'body'            => $article_comment_body,
                        'created_at'      => date('Y-m-d H:i:s'),
                        'updated_at'      => date('Y-m-d H:i:s'),

                        ));
           $connectionApi                 =   Engine_Api::_()->getApi('connections', 'user');
           $aResult['commenthtml']        =   $connectionApi->getviewallcommentsajaxResults($aData['action_id'],$aData['poster_id'],$aData['status'],$aData['actionSubjectId']);
          
           $propertyTable        =  Engine_Api::_()->getDbtable('propertylist', 'user');   
	       $userTable            =  Engine_Api::_()->getDbtable('users', 'user');
           $propertyData         =  $propertyTable->fetchRow($propertyTable->select()->where('id = ?', $propertyid ));
           if($profile_type_id  == 1)  { // if renter
			 

               $resciverData         =  $userTable->fetchRow($userTable->select()->where('user_id = ?', $propertyData->property_owner_id));

               $from_email           =  Engine_Api::_()->getApi('settings', 'core')->core_mail_from;
               $bodyTextContent      =  '';
                             if (file_exists("emailtemplates/common_email.html")) {
                                    $htmlExist  = true;
                                    $file       = fopen("emailtemplates/common_email.html", "r");
                                    while(!feof($file))
                                    {
                                        $bodyTextContent .= fgets($file);
                                    }
                                    fclose($file);
                                }
                                if($htmlExist){
                                      $resciverName   = '{resciver_name}';
                                      $content        = '{content}';                                      
                                      $mainContent    =  'A renter, '.$viewer->displayname.' has commented on your property '.$propertyData->property_name.'.'; 
                                      $mainContent    =  $mainContent.' To see the comment, please login to  <a href="'.$_SERVER['HTTP_HOST'].'/property/'.$propertyData->id.'">Rentstarz</a>'; 
                                      $bodyTextTemplate = '';
                                      $bodyHtmlTemplate = $bodyTextContent;
                                    foreach( $rParams as $var => $val ) {
                                          $raw = trim($var, '[]');
                                          $var = '[' . $var . ']';
                                          if( !$val ) {
                                            $val = $var;
                                          }
                                          // Fix nbsp
                                          $val = str_replace('&amp;nbsp;', ' ', $val);
                                          $val = str_replace('&nbsp;', ' ', $val);
                                          // Replace

                                         $bodyTextTemplate = str_replace($var, $val, $bodyTextTemplate);
                                         $bodyHtmlTemplate = str_replace($var, $val, $bodyHtmlTemplate);
                                    }
                                    $bodyTextTemplate = strip_tags($bodyTextTemplate);
                                    $bodyHtmlTemplate = str_replace($resciverName, $resciverData->displayname, $bodyHtmlTemplate);
                                    $bodyHtmlTemplate = str_replace($content, $mainContent, $bodyHtmlTemplate);
                                }
                                    $subject = "Comment Notification";
                                    $header  = "From: ".'Rentstarz'." <".$from_email.">\r\n";
                                    $header .= "MIME-Version: 1.0\r\n";
                                    $header .= 'Content-type: text/html; charset=iso-8859-1' ."\"\r\n\r\n";
                                    mail($resciverData->email, $subject, $bodyHtmlTemplate, $header); 
                              
                                     // send notification

               Engine_Api::_()->getDbtable('notifications', 'activity')
                ->addNotification($resciverData, $viewer, $resciverData, 'comment_notification_to_pOwner',array(
              'pname' => $propertyData->property_name,'pid' => $propertyData->id));                 
	            }
	               else{ // if landlord
					  if($viewer_id == $propertyData->property_owner_id){
						  
						$allpostcommentData = $postcommentTable->fetchAll($postcommentTable->select()
									 ->where('actionId = ?',$propertyid )
									 ->group('posterId'));
									 
						foreach($allpostcommentData as $data){  // mail to all renters who have commented on this property
							
						if($data['posterId'] != $propertyData->property_owner_id){							
							
						   $resciverData         =  $userTable->fetchRow($userTable->select()->where('user_id = ?', $data['posterId']));

						   $from_email           =  Engine_Api::_()->getApi('settings', 'core')->core_mail_from;
						   $bodyTextContent      =  '';
                             if (file_exists("emailtemplates/common_email.html")) {
                                    $htmlExist  = true;
                                    $file       = fopen("emailtemplates/common_email.html", "r");
                                    while(!feof($file))
                                    {
                                        $bodyTextContent .= fgets($file);
                                    }
                                    fclose($file);
                                }

                                if($htmlExist){
                                      $resciverName   = '{resciver_name}';
                                      $content        = '{content}';                                      
                                      $mainContent    =  'A landlord, '.$viewer->displayname.' has replied to your comment on '.$propertyData->property_name.'.'; 
                                      $mainContent    =  $mainContent.' To see the comment, please login to  <a href="'.$_SERVER['HTTP_HOST'].'/property/'.$propertyData->id.'">Rentstarz</a>'; 
                                      $bodyTextTemplate = '';
                                      $bodyHtmlTemplate = $bodyTextContent;
                                    foreach( $rParams as $var => $val ) {
                                          $raw = trim($var, '[]');
                                          $var = '[' . $var . ']';
                                          if( !$val ) {
                                            $val = $var;
                                          }
                                          // Fix nbsp
                                          $val = str_replace('&amp;nbsp;', ' ', $val);
                                          $val = str_replace('&nbsp;', ' ', $val);
                                          // Replace

                                         $bodyTextTemplate = str_replace($var, $val, $bodyTextTemplate);
                                         $bodyHtmlTemplate = str_replace($var, $val, $bodyHtmlTemplate);
                                    }
                                    $bodyTextTemplate = strip_tags($bodyTextTemplate);
                                    $bodyHtmlTemplate = str_replace($resciverName, $resciverData->displayname, $bodyHtmlTemplate);
                                    $bodyHtmlTemplate = str_replace($content, $mainContent, $bodyHtmlTemplate);
                                }
                                    $subject = "Comment Notification";
                                    $header  = "From: ".'Rentstarz'." <".$from_email.">\r\n";
                                    $header .= "MIME-Version: 1.0\r\n";
                                    $header .= 'Content-type: text/html; charset=iso-8859-1' ."\"\r\n\r\n";
                                    mail($resciverData->email, $subject, $bodyHtmlTemplate, $header);  
                                    
                                     // send notification

               Engine_Api::_()->getDbtable('notifications', 'activity')
                ->addNotification($resciverData, $viewer, $resciverData, 'comment_notification_to_renter',array(
              'pname' => $propertyData->property_name,'pid' => $propertyData->id));      
								}
						}	   
					  }   
				   }

           $aResult['status'] =true;
        }
        else{
            $aResult['status'] =false;
        }
        return json_encode($aResult);
      }

      public function viewcommentsAction(){
		  if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viewer_id=Engine_Api::_()->user()->getViewer()->getIdentity();

        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();

        $viewer_id  = Engine_Api::_()->user()->getViewer()->getIdentity();
        if( $this->getRequest()->isPost()){
            $aData                        =  $this->_request->getPost();
            $connectionApi                =  Engine_Api::_()->getApi('connections', 'user');
            $aResult['commenthtml']       =  $connectionApi->getviewallcommentsajaxResults($aData['action_id'],$viewer_id,$aData['status']);
            $aResult['status']            =  true;
        }
        else{
            $aResult['status'] =false;
        }
        return json_encode($aResult);
      }

    public function deletecommentAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

    $viewer     = Engine_Api::_()->user()->getViewer();
    date_default_timezone_set($viewer->timezone);
    $this->_helper->viewRenderer->setNoRender(true);
    $this->_helper->layout->disableLayout();
    $oData       =  $this->_request->getPost();
    $comment_id  =  $oData['comment_id'];
    try{
      $postcommentTable =  Engine_Api::_()->getDbtable('Postcomments', 'user');
      Engine_Db_Table::getDefaultAdapter()->delete('engine4_post_comments', array('commentId = ?'=>$comment_id) );
      $aResult['status'] = true;
      }catch (Exception $e)
       {exit($e->getMessage());
                                $aResult['status'] = false;
       }
     echo json_encode($aResult);
   }
      public function submitapplicationAction(){
		  if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        $aData       =  $this->_request->getPost();

        $rentalApplicationsTable             =  Engine_Api::_()->getDbtable('rentalapplications', 'user');
        $propertyRequestTable =  Engine_Api::_()->getDbtable('propertyrequest', 'user');
         $propertyTable        =  Engine_Api::_()->getDbtable('propertylist', 'user');
         $propertyData         =  $propertyTable->fetchRow($propertyTable->select()->where('id = ?', $aData['property_id']));

        $this->view->rentalApplicationsData  =  $rentalApplicationsData = $rentalApplicationsTable->fetchRow($rentalApplicationsTable->select()->where('tenant_id = ?', $viewer->getIdentity()));

        $userTable            = Engine_Api::_()->getDbtable('users', 'user');
        $lanlordDetails       = $userTable->fetchRow($userTable->select()->where('user_id = ?', $aData['landlord_id']));
        $propertyReq_select = $propertyRequestTable->select()
                               ->setIntegrityCheck(false)
                               ->from(array('prequest'=>'engine4_property_request',))
                               ->where('prequest.tenant_id = ?', $viewer->getIdentity())
                               ->where('prequest.property_id     = ?', $aData['property_id']);
        $propertyRequest = $propertyRequestTable->fetchAll($propertyReq_select);

        if(count($propertyRequest) == 0){

            if($viewer->bg_verified == 1){
                $admin_approve = 1;
                $admin_approve_date =date('Y-m-d H:i:s');
            }
            else{
                $admin_approve = 0;
                $admin_approve_date ='';
            }


        $propertyRequestId=   $propertyRequestTable->insert(array(
                    'property_id' => $aData['property_id'],
                    'landlord_id' => $aData['landlord_id'],
                    'tenant_id' => $viewer->getIdentity(),
                    'admin_approve' => $admin_approve,
                    'admin_approve_date' => $admin_approve_date,
                    'created_at' => date('Y-m-d H:i:s'),
                    'tenant_firstname' => $rentalApplicationsData->tenant_firstname,
                    'tenant_last_name' => $rentalApplicationsData->tenant_last_name,
                    'tenant_email' => $rentalApplicationsData->tenant_email,
                    'tenant_pno' => $rentalApplicationsData->tenant_pno,
                    'driver_license_no' => $rentalApplicationsData->driver_license_no,
                    'current_residence_housing_type' => $rentalApplicationsData->current_residence_housing_type,
                    'current_residence_address' => $rentalApplicationsData->current_residence_address,
                    'current_residence_move_in_date' => $rentalApplicationsData->current_residence_move_in_date,
                    'current_residence_monthly_rent' => $rentalApplicationsData->current_residence_monthly_rent,
                    'current_residence_landlordname' => $rentalApplicationsData->current_residence_landlordname,
                    'current_residence_landlord_pno' => $rentalApplicationsData->current_residence_landlord_pno,
                    'current_residence_leaving_reason' => $rentalApplicationsData->current_residence_leaving_reason,
                    'previous_residence_housing_type' => $rentalApplicationsData->previous_residence_housing_type,
                    'previous_residence_address' => $rentalApplicationsData->previous_residence_address,
                    'previous_residence_move_in_date' => $rentalApplicationsData->previous_residence_move_in_date,
                    'previous_residence_monthly_rent' => $rentalApplicationsData->previous_residence_monthly_rent,
                    'previous_residence_landlord_name' => $rentalApplicationsData->previous_residence_landlord_name,
                    'previous_residence_landlord_pno' => $rentalApplicationsData->previous_residence_landlord_pno,
                    'previous_residence_leaving_reason' => $rentalApplicationsData->previous_residence_leaving_reason,
                    'current_occupation_status' => $rentalApplicationsData->current_occupation_status,
                    'current_occupation_employer' => $rentalApplicationsData->current_occupation_employer,
                    'current_occupation_job_title' => $rentalApplicationsData->current_occupation_job_title,
                    'current_occupation_monthly_salary' => $rentalApplicationsData->current_occupation_monthly_salary,
                    'current_occupation_work_type' => $rentalApplicationsData->current_occupation_work_type,
                    'current_occupation_manager_name' => $rentalApplicationsData->current_occupation_manager_name,
                    'current_occupation_pno' => $rentalApplicationsData->current_occupation_pno,
                    'current_occupation_work_address' => $rentalApplicationsData->current_occupation_work_address,
                    'current_occupation_start_date' => $rentalApplicationsData->current_occupation_start_date,
                    'current_occupation_income_source' => $rentalApplicationsData->current_occupation_income_source,
                    'current_occupation_monthly_income' => $rentalApplicationsData->current_occupation_monthly_income,
                    'previous_occupation_monthly_status' => $rentalApplicationsData->previous_occupation_monthly_status,
                    'previous_occupation_employer' => $rentalApplicationsData->previous_occupation_employer,
                    'previous_occupation_job_title' => $rentalApplicationsData->previous_occupation_job_title,
                    'previous_occupation_monthly_salary' => $rentalApplicationsData->previous_occupation_monthly_salary,
                    'previous_occupation_work_type' => $rentalApplicationsData->previous_occupation_work_type,
                    'previous_occupation_manager_name' => $rentalApplicationsData->previous_occupation_manager_name,
                    'previous_occupation_pno' => $rentalApplicationsData->previous_occupation_pno,
                    'previous_occupation_work_address' => $rentalApplicationsData->previous_occupation_work_address,
                    'previous_occupation_end_date' => $rentalApplicationsData->previous_occupation_end_date,
                    'previous_occupation_income_source' => $rentalApplicationsData->previous_occupation_income_source,
                    'previous_occupation__monthly_income' => $rentalApplicationsData->previous_occupation__monthly_income,
                    'additional_income_sources' => $rentalApplicationsData->additional_income_sources,
                    'additional_income_amount' => $rentalApplicationsData->additional_income_amount,
                    'total_monthly_income' => $rentalApplicationsData->total_monthly_income,
                    'personal_reference_json' =>  $rentalApplicationsData->personal_reference_json,
                ));

                   if($viewer->bg_verified == 0){
                    /*******************mail to admin************************/


                $userTable     = Engine_Api::_()->getDbtable('users', 'user');
                $adminDetails  = $userTable->fetchAll($userTable->select()->where('level_id = ?', '1'));
                $from_email    = Engine_Api::_()->getApi('settings', 'core')->core_mail_from;
                $tenant_name   = $viewer->displayname;
                $red_url       = $_SERVER['HTTP_HOST']."/admin/user/manage/propertyrequestlist";
                foreach($adminDetails as $admin){
                     $admin_email       = $admin['email'];
                     $admin_displayname = $admin['displayname'];
                     $bodyTextContent   = '';
                         if (file_exists("emailtemplates/property_request_email_admin.html")) {
                            $htmlExist = true;
                            $file = fopen("emailtemplates/property_request_email_admin.html", "r");
                            while(!feof($file))
                            {
                                $bodyTextContent .= fgets($file);
                            }
                            fclose($file);
                        }
                            if($htmlExist){
                              $tenantname   = '{tenantname}';
                              $rentaltype   = '{rentaltype}';
                              $redirect_url = '{redirect_url}';
                              $property_name= '{property_name}';
                              $display_name = '{display_name}';
                              $bodyTextTemplate = '';
                              $bodyHtmlTemplate = $bodyTextContent;
                          foreach( $rParams as $var => $val ) {
                              $raw = trim($var, '[]');
                              $var = '[' . $var . ']';
                              if( !$val ) {
                                $val = $var;
                              }
                              // Fix nbsp
                              $val = str_replace('&amp;nbsp;', ' ', $val);
                              $val = str_replace('&nbsp;', ' ', $val);
                              // Replace
                             $bodyTextTemplate = str_replace($var, $val, $bodyTextTemplate);
                             $bodyHtmlTemplate = str_replace($var, $val, $bodyHtmlTemplate);
                            }
                            $bodyTextTemplate = strip_tags($bodyTextTemplate);
                            $bodyHtmlTemplate = str_replace($tenantname, $tenant_name, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($rentaltype, $propertyData->rental_type, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($redirect_url, $red_url, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($property_name, $propertyData->property_name, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($display_name, $admin_displayname, $bodyHtmlTemplate);
                         }
                    $subject = "Request for a property for ".$propertyData->rental_type;
                    $header  = "From: ".'Rentstarz'." <".$from_email.">\r\n";
                    $header .= "MIME-Version: 1.0\r\n";
                    $header .= 'Content-type: text/html; charset=iso-8859-1' ."\"\r\n\r\n";
                    mail($admin_email, $subject, $bodyHtmlTemplate, $header);
                }
                /************************************************/
            }

                 /******mail to landlord***/

                $from_email     = Engine_Api::_()->getApi('settings', 'core')->core_mail_from;

                $landlord_name  = $lanlordDetails->displayname;
                $landlord_email = $lanlordDetails->email;
                $tenant_name    = $viewer->displayname;
                $bio_content    = '';
                $bio_select = $userTable->select()
                                  ->setIntegrityCheck(false)
                                  ->from(array('user'=>'engine4_users',))
                                  ->joinLeft(array('fields'=>'engine4_user_fields_values'),'fields.item_id=user.user_id',array('value'))
                                  ->where('fields.item_id        = ?', $viewer->getIdentity())
                                  ->where('fields.field_id       = ?', 13);
                $bioData = $userTable->fetchRow($bio_select);
                if(count($bioData)>0){
                    $bioData_content  = $bioData->value;
                    $tenant_firstname = explode(" ", $tenant_name);
                    $tenant_firstname = $tenant_firstname[0];
                    $bio_content      = '<br/><br />'.$tenant_firstname.'\'s profile : '.$bioData_content;
                }
                else{
                    $bio_content ='';
                }

                $red_url =  $_SERVER['HTTP_HOST']."/propertyrequestslist";
                $login_url =$_SERVER['HTTP_HOST']."/login";
                         $bodyTextContent = '';
                         if (file_exists("emailtemplates/property_request_email.html")) {
                            $htmlExist = true;
                            $file = fopen("emailtemplates/property_request_email.html", "r");
                            while(!feof($file))
                            {
                                $bodyTextContent .= fgets($file);
                            }
                            fclose($file);
                        }

                            if($htmlExist){
                              $landlordname='{landlordname}';
                              $tenantname='{tenantname}';
                              $rentaltype='{rentaltype}';
                              $redirect_url='{redirect_url}';
                              $property_name='{property_name}';
                              $loginurl='{loginurl}';
                              $biocontent='{coverlettercontent}';

                              $bodyTextTemplate = '';
                              $bodyHtmlTemplate = $bodyTextContent;
                          foreach( $rParams as $var => $val ) {
                              $raw = trim($var, '[]');
                              $var = '[' . $var . ']';
                              if( !$val ) {
                                $val = $var;
                              }
                              // Fix nbsp
                              $val = str_replace('&amp;nbsp;', ' ', $val);
                              $val = str_replace('&nbsp;', ' ', $val);
                              // Replace

                             $bodyTextTemplate = str_replace($var, $val, $bodyTextTemplate);
                             $bodyHtmlTemplate = str_replace($var, $val, $bodyHtmlTemplate);
                            }
                            $bodyTextTemplate = strip_tags($bodyTextTemplate);
                            $bodyHtmlTemplate = str_replace($landlordname, $landlord_name, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($tenantname, $tenant_name, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($rentaltype, $propertyData->rental_type, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($redirect_url, $red_url, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($property_name, $propertyData->property_name, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($loginurl, $login_url, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($biocontent, $bio_content, $bodyHtmlTemplate);
                         }
                    $subject = "Application for your property for ".$propertyData->rental_type;
                    $header  = "From: ".'Rentstarz'." <".$from_email.">\r\n";
                    $header .= "MIME-Version: 1.0\r\n";
                    $header .= 'Content-type: text/html; charset=iso-8859-1' ."\"\r\n\r\n";

                     mail($landlord_email, $subject, $bodyHtmlTemplate, $header);
                /******mail to landlord***/


                 // send notification

               Engine_Api::_()->getDbtable('notifications', 'activity')
                ->addNotification($lanlordDetails, $viewer, $lanlordDetails, 'application_request',array(
              'label' => $aData['property_name'],'pid' => $aData['property_id']));
                                $aResult['status'] = true;
                                $aResult['message'] = 'Success';


        }
        else{
                                $aResult['status'] = false;
                                $aResult['message'] = 'You already submitted application against this property';
        }
        echo json_encode($aResult);
      }



    public function rentalapplicationsearchAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

    $this->_helper->viewRenderer->setNoRender(true);
    $this->_helper->layout->disableLayout();
    $viewer     = Engine_Api::_()->user()->getViewer();
    $viewer_id  = Engine_Api::_()->user()->getViewer()->getIdentity();

    if( $this->getRequest()->isPost()){
            $aData                  = $this->_request->getPost();
        //    echo $aData['property_id'];exit;

           $connectionApi                 =   Engine_Api::_()->getApi('connections', 'user');
           $aResult['searchhtml']        =   $connectionApi->getrentalapplicationsearchajaxResults($viewer_id,$aData['property_id']);
           $aResult['status'] =true;
    }
    else{
            $aResult['status'] =false;
    }
     return json_encode($aResult);
    }


    public function rentalapplicationapprovedsearchAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

    $this->_helper->viewRenderer->setNoRender(true);
    $this->_helper->layout->disableLayout();
    $viewer     = Engine_Api::_()->user()->getViewer();
    $viewer_id  = Engine_Api::_()->user()->getViewer()->getIdentity();

    if( $this->getRequest()->isPost()){

           $aData                  = $this->_request->getPost();
           $connectionApi                 =   Engine_Api::_()->getApi('connections', 'user');
           $aResult['searchhtml']        =   $connectionApi->getapplicationsearchajaxResults($viewer_id,$aData['property_id']);
           $aResult['status'] =true;
    }
    else{
            $aResult['status'] =false;
    }
     return json_encode($aResult);



    }

    public function singlechatmobAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
			return;
		}
        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('default');
        $viewer_id = Engine_Api::_()->user()->getViewer()->getIdentity();
        $this->view->viewer =$viewer = Engine_Api::_()->user()->getViewer();
        $this->view->viewerId = $viewerId = $viewer->getIdentity();
    }
    public function renterfeedajaxAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        $limit    = $this->_getParam('limit');
        $offset   = $this->_getParam('offset');
        $oData    = $this->_request->getPost();
        $user_id  = Engine_Api::_()->user()->getViewer()->getIdentity();
        $connectionApi  =   Engine_Api::_()->getApi('connections', 'user');
        $html           =   $connectionApi->renterfeedajaxResults($limit,$offset,$oData);
        return $html;

    }

    public function landlordfeedajaxAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        $limit    = $this->_getParam('limit');
        $offset   = $this->_getParam('offset');
        $oData    = $this->_request->getPost();
        $user_id  = Engine_Api::_()->user()->getViewer()->getIdentity();
        $connectionApi  =   Engine_Api::_()->getApi('connections', 'user');
        $html           =   $connectionApi->landlordfeedajaxResults($limit,$offset,$oData);
        return $html;

    }
    public function unsetsessionsAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        unset($_SESSION['matching_array']);
        unset($_SESSION['feedicon']);
        unset($_SESSION['feedpreferenceunit']);
        unset($_SESSION['feedpreferenceunitmore']);
        unset($_SESSION['location_mode_array']);
        unset($_SESSION['countryId']);
        unset($_SESSION['stateId']);
        unset($_SESSION['cityId']);
        unset($_SESSION['zipcode']);
        unset($_SESSION['country_name']);
        unset($_SESSION['state_name']);
        unset($_SESSION['city_name']);
        unset($_SESSION['userpackage']);
        $aResult['status'] =true;
        echo json_encode($aResult);
    }

    public function packagesessionsetAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        if( $this->getRequest()->isPost()){

           $aData                  = $this->_request->getPost();
           $_SESSION['userpackage'] = $aData['pacakage'];
           $aResult['status'] =true;
       }
       else{
           $aResult['status'] =false;
       }
        echo json_encode($aResult);
    }


    public function memberpackagepaymentAction(){


        if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('common_layout');
        $viewer     = Engine_Api::_()->user()->getViewer();
        $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
        if( !empty($fieldsByAlias['profile_type']) ){
              $optionId        = $fieldsByAlias['profile_type']->getValue($viewer);
              $profile_type_id = $optionId->value;
        }
        if($profile_type_id != 4){ //if not landlord
            return $this->_forward('notfound');
        }

        if(!isset($_SESSION['userpackage'])){return $this->_forward('notfound');}

        date_default_timezone_set($viewer->timezone);
        $viewer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
        $CardholderdetailsTable =  Engine_Api::_()->getDbtable('Cardholderdetails', 'user');
	    $this->view->CardholderdetailsData  =  $CardholderdetailsTable->fetchRow($CardholderdetailsTable->select()->where('userId = ?',  $viewer_id));

        /*$viewHelperObj                          =  $this->view->getHelper('SmartmoveApi');
        $stripefiles     = $viewHelperObj->getStripeFiles(); // smartmove api exam evaluate
        $params = array(
            "testmode"   => "on",
            "private_live_key" => "sk_live_E6EzS7m9mFwTqBaIzeJ8oncE",
            "public_live_key"  => "pk_live_tw2xDCscdH3PIDJXPAoJgAvW",
            "private_test_key" => "sk_test_JAXt6hCKmufYbTHg020cemPy",
            "public_test_key"  => "pk_test_cxmNjXoEWEuUWT8U4t1jEdW4"
        );

        if ($params['testmode'] == "on") {
        Stripe::setApiKey($params['private_test_key']);
        $pubkey = $params['public_test_key'];
        } else {
        Stripe::setApiKey($params['private_live_key']);
        $pubkey = $params['public_live_key'];
        }
        $this->view->params = $params;*/

    }
    public function saveuserpacakgepaymentAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        $viewer     = Engine_Api::_()->user()->getViewer();
        $viewer_id=Engine_Api::_()->user()->getViewer()->getIdentity();

        date_default_timezone_set($viewer->timezone);
        if( $this->getRequest()->isPost()){

            $aData                  = $this->_request->getPost();
            $cardholder_name      = $aData['cardholder_name'];
            $last_name            = $aData['last_name'];
            $street               = $aData['street'];
            $city                 = $aData['city'];
            $state                = $aData['state'];
            $zipcode              = $aData['zipcode'];
            $package              = $_SESSION['userpackage'];
            $stripeToken          = $aData['stripeToken'];

            $settings = Engine_Api::_()->getApi('settings', 'core');

            if($package == 'landlord_pro_package'){  $packageRate = $settings->user_landlordProPrice; }
            if($package == 'management_gold_package'){  $packageRate = $settings->user_managementGoldPrice; }
            $viewHelperObj                          =  $this->view->getHelper('SmartmoveApi125');
            $stripefiles     = $viewHelperObj->getStripeFiles();
           $params = array(
            "testmode"   => "on",
            "private_live_key" => "sk_live_bcnF3vdwkx2Q405aOq7POiep",
            "public_live_key"  => "pk_live_evBvNtpwiJlCwieyHNPKsQLO",
            "private_test_key" => "sk_test_K2gnuPgv5SH1P3lkvw86TJIQ",
            "public_test_key"  => "pk_test_kCahdc8oaSK65WPNb3iClcF1"
        );

        if ($params['testmode'] == "on") {
        Stripe::setApiKey($params['private_test_key']);
        $pubkey = $params['public_test_key'];
        } else {
        Stripe::setApiKey($params['private_live_key']);
        $pubkey = $params['public_live_key'];
        }

            $amount_cents = str_replace(".","",$packageRate);  // Chargeble amount
            $amount_cents = (int)($packageRate * 100) ;
            $invoiceid = "14526321";                      // Invoice ID
            $description = "Invoice #" . $invoiceid . " - " . $invoiceid;
            try {
            $charge = Stripe_Charge::create(array(
                  "amount"      => $amount_cents,
                  "currency"    => "usd",
                  "source"      => $stripeToken,
                  "description" => $description
                  )
            );

                if ($charge->card->address_zip_check == "fail") {
                    throw new Exception("zip_check_invalid");
                } else if ($charge->card->address_line1_check == "fail") {
                    throw new Exception("address_check_invalid");
                } else if ($charge->card->cvc_check == "fail") {
                    throw new Exception("cvc_check_invalid");
                }
            // Payment has succeeded, no exceptions were thrown or otherwise caught
            $result = "success";
            }
            catch(Stripe_CardError $e) {

            $error = $e->getMessage();
                $result = "declined";

            } catch (Stripe_InvalidRequestError $e) {
                $result = "declined";
            } catch (Stripe_AuthenticationError $e) {
                $result = "declined";
            } catch (Stripe_ApiConnectionError $e) {
                $result = "declined";
            } catch (Stripe_Error $e) {
                $result = "declined";
            } catch (Exception $e) {

                if ($e->getMessage() == "zip_check_invalid") {
                    $result = "declined";
                } else if ($e->getMessage() == "address_check_invalid") {
                    $result = "declined";
                } else if ($e->getMessage() == "cvc_check_invalid") {
                    $result = "declined";
                } else {
                    $result = "declined";
                }
            }

            $paymentResponse =  $charge->__toJSON();  //echo '<pre>';print_r($paymentResponse); exit("kk");
            $response1 =json_decode($response);
            $response2 = json_decode(json_encode($response1));

            if($result == 'success'){

                 $userPackagesTable             =  Engine_Api::_()->getDbtable('Userpackages', 'user');
                 
		         $userPackagesData       = $userPackagesTable->fetchRow($userPackagesTable->select()
		                                     ->where('user_id = ?', $viewer_id)
		                                     ->order('payment_id DESC')
		                                     );
		         if(count($userPackagesData) > 0){
					 $userPackagesData->status      = 'expired';					 
					 $userPackagesData->updated_at  = date('Y-m-d H:i:s');	
					 $userPackagesData->save();				 
				 }                          

                 $duration  = 30;
                 $days            = "+".$duration." days";
                 $expiry_date     = date('Y-m-d', strtotime($days));

                 $userPackagesId  =   $userPackagesTable->insert(array(
                    'user_id'        => $viewer_id,
                    'first_name'     => $cardholder_name,
                    'last_name'      => $last_name,
                    'street'         => $street,
                    'city'           => $city,
                    'state'          => $state,
                    'zipcode'        => $zipcode,
                    'card_number'    => $aData['card_number'],
                    'expiration_month' => $aData['expiration_month'],
                    'expiration_year'  => $aData['expiration_year'],
                    'cvc'            => $aData['cvc'],
                    'status'         => 'active',
                    'expiry_date'    => $expiry_date,                    
                    'package_type'   => $package,
                    'payment_amount' => $packageRate,
                    'payment_response'  => $paymentResponse,
                    'created_at'  =>  date('Y-m-d'),
                    'updated_at'  =>  date('Y-m-d H:i:s')
                    ));
                  $CardholderdetailsTable =  Engine_Api::_()->getDbtable('Cardholderdetails', 'user');
	              $CardholderdetailsData  =  $CardholderdetailsTable->fetchRow($CardholderdetailsTable->select()->where('userId = ?',  $viewer_id));
                  if(empty($CardholderdetailsData)){
				 
				 $CardholderdetailsTable->insert(array(
                    'userId'         => $viewer_id,
                    'first_name'     => $cardholder_name,
                    'last_name'      => $last_name,
                    'street'         => $street,
                    'city'           => $city,
                    'state'          => $state,
                    'zipcode'        => $zipcode,
                    'card_number'    => $aData['card_number'],
                    'expiration_month' => $aData['expiration_month'],
                    'expiration_year'  => $aData['expiration_year'],
                    'cvc'            => $aData['cvc'],
                    'updated_at'     =>  date('Y-m-d H:i:s')
                    )); 
					  
				  }
				  else{
					  $CardholderdetailsData->userId       = $viewer_id;
					  $CardholderdetailsData->first_name   = $cardholder_name;
					  $CardholderdetailsData->last_name    = $last_name;
					  $CardholderdetailsData->street       = $street;
					  $CardholderdetailsData->city         = $city;
					  $CardholderdetailsData->state        = $state;
					  $CardholderdetailsData->zipcode      = $zipcode;
					  $CardholderdetailsData->card_number  = $aData['card_number'];
					  $CardholderdetailsData->expiration_month   = $aData['expiration_month'];
					  $CardholderdetailsData->expiration_year    = $aData['expiration_year'];
					  $CardholderdetailsData->cvc                = $aData['cvc'];
					  $CardholderdetailsData->updated_at         = date('Y-m-d H:i:s');	
					  $CardholderdetailsData->save();				  
				  }

                $aResult['status'] =true;

            }
            else{
                $aResult['status'] =false;
            }
       }
         echo json_encode($aResult);
    }


     public function matchingrequirementpreferencesAction() {
		 if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        $user_id       = Engine_Api::_()->user()->getViewer()->getIdentity();
        if( $this->getRequest()->isPost()){
        $aData                         = $this->_request->getPost();
        $connectionApi = Engine_Api::_()->getApi('connections', 'user');
        $html          = $connectionApi->matchingrequirementpreferences($aData);
        return $html;
        }
        else{
			$aResult['status'] =false;
			echo json_encode($aResult);
		}


    }
     public function getpreferencebyidAction() {
		 if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        $user_id       = Engine_Api::_()->user()->getViewer()->getIdentity();
        if( $this->getRequest()->isPost()){
        $aData                         = $this->_request->getPost();
        $connectionApi = Engine_Api::_()->getApi('connections', 'user');
        $html          = $connectionApi->getpreferencebyidModal($aData);
        return $html;
        }
        else{
			$aResult['status'] =false;
			echo json_encode($aResult);
		}
    }
     public function getpreferencebyscoutnameAction() {
		 if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        $user_id       = Engine_Api::_()->user()->getViewer()->getIdentity();
        if( $this->getRequest()->isPost()){
        $aData                         = $this->_request->getPost();
        $connectionApi = Engine_Api::_()->getApi('connections', 'user');
        $html          = $connectionApi->getpreferencebyscoutnameModal($aData);
        return $html;
        }
        else{
			$aResult['status'] =false;
			echo json_encode($aResult);
		}
    }
     public function editpreferenceAction() {
		 if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        $user_id       = Engine_Api::_()->user()->getViewer()->getIdentity();
        $viewer     = Engine_Api::_()->user()->getViewer();
        $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer); 

		if( !empty($fieldsByAlias['profile_type']) )
		{
		   $optionId = $fieldsByAlias['profile_type']->getValue($viewer);
		   $profile_type_id = $optionId->value; 
		}

        if( $this->getRequest()->isPost()){
        $aData                         = $this->_request->getPost();
        $edit_preference_id    = $aData['edit_preference_id'];
        $edit_scout_name       = $aData['edit_scout_name'];
        $edit_housing_type     = $aData['edit_housing_type'];
        $edit_is_petsallowd    = $aData['edit_is_petsallowd'];
        $edit_number_of_rooms  = $aData['edit_number_of_rooms'];
        $edit_pets_type     = $aData['edit_pets_type'];
        $edit_price         = $aData['edit_price'];
        $edit_price_to      = $aData['edit_price_to'];
        $neighborhood       = $aData['neighborhood'];
        $cityName           = $aData['cityName'];
        $countyName         = $aData['countyName'];
        $stateName          = $aData['stateName'];
        $postal_code        = $aData['postal_code'];

        $FeedPreferenceUnitTable            = Engine_Api::_()->getDbtable('Feedpreferenceunit', 'user');
        $FeedPreferenceUnitDataSelect       = $FeedPreferenceUnitTable->select()
                                                  ->where('id = ?', $edit_preference_id);
        $FeedPreferenceUnitData = $FeedPreferenceUnitTable->fetchRow($FeedPreferenceUnitDataSelect);

        $FeedPreferenceUnitData->housing_type  = $edit_housing_type;
        $FeedPreferenceUnitData->is_petsallowd  = $edit_is_petsallowd;
        if($edit_is_petsallowd == 'No'){
            $edit_pets_type = '';
        }
        $FeedPreferenceUnitData->pets_type          = $edit_pets_type;
        $FeedPreferenceUnitData->scout_name         = $edit_scout_name;
        $FeedPreferenceUnitData->price              = $edit_price;
        $FeedPreferenceUnitData->price_to           = $edit_price_to;
        $FeedPreferenceUnitData->number_of_rooms    = $edit_number_of_rooms;
        $FeedPreferenceUnitData->countryName        = $countryName;
        $FeedPreferenceUnitData->stateName          = $stateName;
        $FeedPreferenceUnitData->cityName           = $cityName;
        $FeedPreferenceUnitData->zip                = $postal_code;
        $FeedPreferenceUnitData->countyName         = $countyName;
        $FeedPreferenceUnitData->neighborhoodName   = $neighborhood;
        $FeedPreferenceUnitData->save();
        
        

            $FeedPreferenceUnitDataSelect123       = $FeedPreferenceUnitTable->select()
                                                  ->where('id = ?', $edit_preference_id);
            $FeedPreferenceUnitData123 = $FeedPreferenceUnitTable->fetchRow($FeedPreferenceUnitDataSelect123);

            $content=  '';
            if($profile_type_id  == 4){ // landlord
            
            $content=$content.'<span style="margin-right: 12px;">' ;
            if($FeedPreferenceUnitData123 ->stateName !=''):
            $content=$content.$FeedPreferenceUnitData123 ->stateName." ";
            endif;
            if($FeedPreferenceUnitData123 ->cityName !=''):
            $content=$content.$FeedPreferenceUnitData123 ->cityName." ";
            endif;
            if($FeedPreferenceUnitData123 ->countyName !='' && $FeedPreferenceUnitData123 ->countyName != $FeedPreferenceUnitData123 ->cityName):
            $content=$content.$FeedPreferenceUnitData123 ->countyName." ";
            endif;
            if($FeedPreferenceUnitData ->neighborhoodName !=''):
            $content=$content.$FeedPreferenceUnitData123 ->neighborhoodName." ";
            endif;
            $content=$content.'</span>';

            $content=$content.'<span style="margin-right: 12px;">' ;
            if($FeedPreferenceUnitData123 ->number_of_rooms !=''):
            $content=$content.$FeedPreferenceUnitData123 ->number_of_rooms." ";
            endif;
            if($FeedPreferenceUnitData123 ->housing_type !=''):
            $content=$content.$FeedPreferenceUnitData123 ->housing_type." ";
            endif;
            $content=$content.'</span>';

            $content=$content.'<span style="margin-right: 12px;">' ;
            if($FeedPreferenceUnitData123 ->is_petsallowd !=''):
               if($FeedPreferenceUnitData123 ->is_petsallowd =='No'):
                   $content=$content."No pets ";
                else:
                   $content=$content."Pets ";
                endif;
            endif;
            $content=$content.'</span>';

            $content=$content.'<span style="margin-right: 12px;">' ;
            if($FeedPreferenceUnitData123 ->pets_type !=''):
            $content=$content.$FeedPreferenceUnitData123 ->pets_type." ";
            endif;
            $content=$content.'</span>';

            $content=$content.'<span style="margin-right: 12px;">' ;
            if($FeedPreferenceUnitData123 ->price !='0' && $FeedPreferenceUnitData123 ->price_to =='0'):
            $content=$content."$".$FeedPreferenceUnitData123 ->price." ";
            endif;
            if($FeedPreferenceUnitData123 ->price !='0' && $FeedPreferenceUnitData123 ->price_to !='0'):
            $content=$content."$".$FeedPreferenceUnitData123 ->price." - $".$FeedPreferenceUnitData123 ->price_to." ";
            endif;
            $content=$content.'</span>';

		   }
		   else{
			   $content = $FeedPreferenceUnitData123 ->scout_name;
		   }  
            $aResult['content']   = $content;
            $aResult['scoutname'] = $FeedPreferenceUnitData123 ->scout_name. " : ";
            $aResult['status'] =true;

        }
        else{
            $aResult['status'] =false;
        }
        echo json_encode($aResult);
     }




    public function videopaymentAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();

        $viewer     = Engine_Api::_()->user()->getViewer();
        $viewer_id=Engine_Api::_()->user()->getViewer()->getIdentity();

        $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
        if( !empty($fieldsByAlias['profile_type']) )
        {
          $optionId = $fieldsByAlias['profile_type']->getValue($viewer);
           $profile_type_id = $optionId->value;
        }
        if($profile_type_id == 4){

        date_default_timezone_set($viewer->timezone);
        if( $this->getRequest()->isPost()){
            $aData                = $this->_request->getPost();
            $cardholder_name      = $aData['cardholder_name'];
            $last_name            = $aData['last_name'];
            $street               = $aData['street'];
            $city                 = $aData['city'];
            $state                = $aData['state'];
            $zipcode              = $aData['zipcode'];
            $stripeToken          = $aData['stripeToken'];
            $settings = Engine_Api::_()->getApi('settings', 'core');
            $videocallRate = $settings->user_videoPrice;





            $viewHelperObj                          =  $this->view->getHelper('SmartmoveApi125');
            $stripefiles     = $viewHelperObj->getStripeFiles(); // smartmove api exam evaluate
           $params = array(
            "testmode"   => "off",
            "private_live_key" => "sk_live_bcnF3vdwkx2Q405aOq7POiep",
            "public_live_key"  => "pk_live_evBvNtpwiJlCwieyHNPKsQLO",
            "private_test_key" => "sk_test_K2gnuPgv5SH1P3lkvw86TJIQ",
            "public_test_key"  => "pk_test_kCahdc8oaSK65WPNb3iClcF1"
        );

            if ($params['testmode'] == "on") {
            Stripe::setApiKey($params['private_test_key']);
            $pubkey = $params['public_test_key'];
            } else {
            Stripe::setApiKey($params['private_live_key']);
            $pubkey = $params['public_live_key'];
            }

            $amount_cents = str_replace(".","",$videocallRate);  // Chargeble amount
            $amount_cents = (int)($videocallRate * 100) ;
            $invoiceid = "14526321";                      // Invoice ID
            $description = "Invoice #" . $invoiceid . " - " . $invoiceid;
            try {

            $charge = Stripe_Charge::create(array(
                  "amount"      => $amount_cents,
                  "currency"    => "usd",
                  "source"      => $stripeToken,
                  "description" => $description
                  )
            );



                if ($charge->card->address_zip_check == "fail") {
                    throw new Exception("zip_check_invalid");
                } else if ($charge->card->address_line1_check == "fail") {
                    throw new Exception("address_check_invalid");
                } else if ($charge->card->cvc_check == "fail") {
                    throw new Exception("cvc_check_invalid");
                }
            // Payment has succeeded, no exceptions were thrown or otherwise caught
            $result = "success";

            }
            catch(Stripe_CardError $e) {

            $error = $e->getMessage();
                $result = "declined";
            } catch (Stripe_InvalidRequestError $e) {
                $result = "declined";
            } catch (Stripe_AuthenticationError $e) {
                $result = "declined";
            } catch (Stripe_ApiConnectionError $e) {
                $result = "declined";
            } catch (Stripe_Error $e) {
                $result = "declined";
            } catch (Exception $e) {
                if ($e->getMessage() == "zip_check_invalid") {
                    $result = "declined";
                } else if ($e->getMessage() == "address_check_invalid") {
                    $result = "declined";
                } else if ($e->getMessage() == "cvc_check_invalid") {
                    $result = "declined";
                } else {
                    $result = "declined";
                }
            }



            if($result == 'success'){
				$paymentResponse =  $charge->__toJSON();  //echo '<pre>';print_r($paymentResponse); exit("kk");
				$response1 =json_decode($response);
				$response2 = json_decode(json_encode($response1));
            
                 $videoPaymentTable             =  Engine_Api::_()->getDbtable('Videopayment', 'user');

                 $videopaymnetId  =   $videoPaymentTable->insert(array(
                    'user_id'        => $viewer_id,
                    'first_name'     => $cardholder_name,
                    'last_name'      => $last_name,
                    'street'         => $street,
                    'city'           => $city,
                    'state'          => $state,
                    'zipcode'        => $zipcode,
                    'payment_amount' => $videocallRate,
                    'payment_response'  => $paymentResponse,
                    'created_at'  =>  date('Y-m-d H:i:s'),
                    'updated_at'  =>  date('Y-m-d H:i:s')
                    ));

                $aResult['status'] =true;

            }
            else{
                $aResult['status'] =false;
            }
        }
        else{
			 $aResult['status'] =false;
		}
         echo json_encode($aResult);


        }


    }
    public function specialdocumentsAction(){
         if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('common_layout');
        $this->view->viewer = $viewer = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);

        $spclDir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/specialdocuments';

        if (!is_dir($dir)) {
                mkdir($spclDir, 0777, true);
        }

        $dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/specialdocuments/';
        if (is_dir($dir)) {

        $files =    $this->loaddirectory($dir);

           $dropboxfileTable = Engine_Api::_()->getDbtable('dropboxfiles', 'user');

           foreach($files['files'] as $file){

                   $doc_path = 'specialdocuments/'.$file['filename'];
                   $dropboxfileData = $dropboxfileTable->fetchRow($dropboxfileTable->select()->where('file_path = ?', $doc_path));
                    $file_path       = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dropboxfileData->file_path ;
                    if(@is_array(getimagesize($file_path))){
                    $is_image = 1;
                    }
                    else{
                        $is_image = 0;
                    }
                   $tmpArrayFile[]  =   array('file_id'=>$dropboxfileData->id,'filename'=>$file['filename'],'is_image'=>$is_image,'file_title'=>$dropboxfileData->file_title,'file_owner_id'=> $dropboxfileData->file_owner_id,'file_path'=> $dropboxfileData->file_path,'created_at'=> $dropboxfileData->created_at);

               }


    $tmpResultData['directories'] = $files['directories'];
    $tmpResultData['files'] = $tmpArrayFile;
   // echo '<pre>'; print_r($tmpResultData); exit;
    $this->view->files = $tmpResultData;
    $this->view->status = true;
    }
    else{
         $this->view->status = false;

    }

    }

    public function getspecialdocumentdirectorycontentsAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();

        $user_id=Engine_Api::_()->user()->getViewer()->getIdentity();
        $viewer     = Engine_Api::_()->user()->getViewer();
        $aData = $this->_request->getPost();
        $dirname                =   $aData['dirname'];
        $current_directory      =   $aData['current_directory'];
        $menu_open      =   $aData['menu_open'];
        $root_dir       =   $aData['rootdir'];
        $aResult['par_dir'] =  dirname($current_directory);
        if($current_directory == ''){
            if($menu_open == 0){
            $dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$root_dir.'/'.$dirname;
           }
           else{
               $dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$root_dir;
           }
            $file_path = '/filemanager/'.$root_dir.'/'.$dirname.'/';
            $doc_path = $root_dir.'/'.$dirname.'/';
        }
        else{
        if($menu_open == 0){
        $dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$root_dir.'/'.$current_directory.'/'.$dirname;
        }
        else{
            $dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$root_dir.$current_directory;
        }
        $file_path = '/filemanager/'.$root_dir.'/'.$current_directory.'/'.$dirname.'/';
        if($menu_open == 0){
        $doc_path =  $root_dir.$current_directory.'/'.$dirname.'/';
        }
        else{
            $doc_path =  $root_dir.$current_directory.'/';
        }
        }

        $files =    $this->loaddirectory($dir); //echo '<pre>' print_r($files) ;exit;
        $dropboxfileTable = Engine_Api::_()->getDbtable('dropboxfiles', 'user');

        foreach($files['files'] as $file){

           $doc_path1 = $doc_path.$file['filename'];
           $dropboxfileData = $dropboxfileTable->fetchRow($dropboxfileTable->select()->where('file_path LIKE ?', $doc_path1.'%'));
           $tmpArrayFile[]  =   array('file_id'=>$dropboxfileData->id,'filename'=>$file['filename'],'file_title'=>$dropboxfileData->file_title,'file_owner_id'=> $dropboxfileData->file_owner_id,'file_path'=> $dropboxfileData->file_path,'created_at'=> $dropboxfileData->created_at);

        }

        $tmpResultData['directories'] = $files['directories'];
        $tmpResultData['files'] = $tmpArrayFile;
        //echo '<pre>'; print_r($tmpResultData); exit;
        $files = $tmpResultData;

        $a= '';
        $b= '';
        $i=1;
         if(count($files['directories'])>0){
        foreach($files['directories'] as $dir){
        $a = $a .'<li class="dir_li list'.$i.'" dir-name="'.$dir['dirname'].'"><a href="javascript:void(0)" class="dir_open" dir-name="'.$dir['dirname'].'"><img src="/application/modules/User/externals/images/document_folder.svg">&nbsp;&nbsp;'.$dir['dirname'].'</a><span class="option_links"></span><hr></li>';
         $i++;
         }
        }

        //print_r($files['files']); exit;
            if(count($files['files'])>0){
            foreach($files['files'] as $dir){
            $b = $b . '<li class="file_li list'.$i.'" file-name="'.$dir['filename'].'">';
            $file_path =dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dir['file_path'];

             if(@is_array(getimagesize($file_path))){
                 $is_image = 1;
                }
                else{
                $is_image = 0;
                }

             if($is_image == 1){

            $b = $b.'<a href="/filemanager/'.$dir['file_path'].'" is-image="'.$is_image.'"  class="file_link1" file-id="'.$dir['file_id'].'"  target="_blank" data-lightbox="image1"><img src="/application/modules/User/externals/images/document_file.svg">&nbsp;&nbsp;'.$dir['file_title'].'</a>';
            }
            else{
            $b = $b.'<a href="/filemanager/'.$dir['file_path'].'" is-image="'.$is_image.'" class="file_link1" file-id="'.$dir['file_id'].'"  target="_blank"><img src="/application/modules/User/externals/images/document_file.svg">&nbsp;&nbsp;'.$dir['file_title'].'</a>';
            }
        //  $b = $b.'<span class="option_links"><a href="javascript:void(0)" file-name="'.$dir['filename'].'" li-count="'.$i.'" class="file_details" file-id="'.$dir['file_id'].'">Details</a> | <a href="javascript:void(0)" file-name="'.$dir['filename'].'" li-count="'.$i.'" class="file_share" file-id="'.$dir['file_id'].'">Share</a> | <a href="javascript:void(0)" class="file_rename" file-name="'.$dir['filename'].'" li-count="'.$i.'" file-id="'.$dir['file_id'].'">Rename</a> | <a href="javascript:void(0)" class="file_copy" file-name="'.$dir['filename'].'" li-count="'.$i.'" file-id="'.$dir['file_id'].'">Copy</a> | <a href="javascript:void(0)" class="file_delete" file-name="'.$dir['filename'].'" li-count="'.$i.'" file-id="'.$dir['file_id'].'">Delete</a></span><hr></li>';
            $b = $b.'<hr></li>';
          $i++;
         }
        }

    $content= $a.$b;
        $aResult['html'] = $content;
        if($menu_open == 0){
        $aResult['cur_dir'] = $current_directory.'/'.$dirname ;
        }
        else{
            $aResult['cur_dir'] = $current_directory;
        }
        //echo $current_directory; exit;
        $arr = explode("/",$current_directory);
        $menu ='';
        $arr_i='';
        for($i=0;$i<count($arr);$i++){
            if($i !=0 ){
                $arr_i =$arr_i.'/'.$arr[$i];
            $menu= $menu.'<a href="javascript:void(0)" class="menu_dir_open 55" dir_path ="'.$arr_i.'" > / '.$arr[$i].'</a>';
        }
        }
        //echo $menu;
        if($menu_open == 0){
        $aResult['cur_dir_menu'] = $menu. ' / <a href="javascript:void(0)" class="menu_dir_open" dir_path="'.$current_directory.'/'.$dirname.'">'.$dirname.'</a>' ;
        }
        else{

        $aResult['cur_dir_menu'] = $menu;
        }
        echo json_encode($aResult);

    }
        public function autocompletescoutAction(){
			if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
			 $this->_helper->viewRenderer->setNoRender(true);
             $this->_helper->layout->disableLayout();
			 $aData = $this->_request->getPost();
             $term                =   $aData['inputTerm'];
             $viewer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
             $FeedPreferenceUnitTable = Engine_Api::_()->getDbtable('Feedpreferenceunit', 'user');
             
             $FeedPreferenceSelect = $FeedPreferenceUnitTable->select()
                                                ->where('userid = ?', $viewer_id);
                                                
             $FeedPreferenceSelect->where('scout_name LIKE ?' , "%{$term}%");
             $FeedPreferenceUnitData              =   $FeedPreferenceUnitTable->fetchAll($FeedPreferenceSelect);
             
             $resultData  = array();
             
             foreach($FeedPreferenceUnitData as $data):
             
             $resultData[] = $data['scout_name']; 
             
             endforeach;
             echo json_encode($resultData); 
		}

		  	public function userpackagestatusAction()
  	{
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
		$this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();

		$aData = $this->_request->getPost();
		$userId=$aData['user_id'];
		
		$aResult	=	array();

		if($userId): 
		
		//echo  $userId;exit;
		$userTable      = Engine_Api::_()->getDbtable('users', 'user');
        $userDetails   = $userTable->fetchRow($userTable->select()->where('user_id = ?', $userId));
		date_default_timezone_set($userDetails->timezone);
		
		 //profile type 
     	$fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($userDetails); 

		if( !empty($fieldsByAlias['profile_type']) )
		{
		  $optionId = $fieldsByAlias['profile_type']->getValue($userDetails);
		   $profile_type_id = $optionId->value; 
		}
		
		if($profile_type_id  == 4){ //profile type is landlord or not
			$is_landlord = 1;
			$aResult['profile_type'] =landlord;
		}
		if($profile_type_id  == 1){ //profile type is tenant or not
			$is_landlord = 1;
			$aResult['profile_type'] =tenant;
		}
	    
		// package
		$userPackagesTable             =  Engine_Api::_()->getDbtable('Userpackages', 'user');
		$userPackagesData              = $userPackagesTable->fetchRow($userPackagesTable->select()
		                                     ->where('user_id = ?', $userId)
		                                     ->order('payment_id DESC')
		                                     );
		$aResult['user_package']       =     $userPackagesData->package_type;                                

       
       
		// video payment
		$current_date=date("Y-m-d");
		$videoPaymentTable =  Engine_Api::_()->getDbtable('Videopayment', 'user');
	    $videoPayment_select = $videoPaymentTable->select()
	                                             ->where('user_id = ?', $userId)
	                                             ->where('DATE(created_at) = ?',$current_date )
	    ;	
	    $videoPaymentData = $videoPaymentTable->fetchAll($videoPayment_select);

        if(count($videoPaymentData)>0)
        {
             $aResult['video_payment'] ="paid";
		}else{
			
		     $aResult['video_payment'] ="not_paid";
		}
		else:
         $aResult['status']= false;
		endif;
		//return $aResult;
        echo json_encode($aResult); 
	 
	 
	
	}
	public function rentermeetingrequestAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
		    $this->_helper->viewRenderer->setNoRender(true);
            $this->_helper->layout->disableLayout();
			$aData = $this->_request->getPost();
			$viewer     = Engine_Api::_()->user()->getViewer();
			date_default_timezone_set($viewer->timezone);
            $viewer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
            $viewer     = Engine_Api::_()->user()->getViewer();
	        $meetingSchedulerTable   =  Engine_Api::_()->getDbtable('meetingscheduler', 'user');
            $scheduledMeetingsSelect = $meetingSchedulerTable->select()
                              ->setIntegrityCheck(false)
                              ->from(array('scheduler'=>'engine4_meeting_scheduler',))
                              ->where('scheduler.property_id = ?', $aData['property_id'])
                              ->where('scheduler.scheduled_by = ?', $viewer_id)
                              ->where('scheduler.scheduled_with = ?', $aData['owner_id']);
            $meeting_req_Data=$meetingSchedulerTable->fetchRow($scheduledMeetingsSelect);
            
            
            $today       =  date('Y-m-d');
			$today_date  =  strtotime($today);
            $datearray   =  explode('-', $meeting_req_Data->scheduled_date);
            
            $scheduled_date      =     $datearray['2'].'-'.$datearray['0'].'-'.$datearray['1'];
            $scheduled_date_new  =     strtotime($scheduled_date);         

            if(count($meeting_req_Data)==0)
            {
				try{
                 $meetingreqId  =   $meetingSchedulerTable->insert(array(
                    'scheduled_by'        => $viewer_id,
                    'scheduled_with'      => $aData['owner_id'],
                    'sheduledby_usertype' => "renter",
                    'property_id'         => $aData['property_id'],                   
                    'created_at'          => date('Y-m-d H:i:s'),
                    'updated_at'          => date('Y-m-d H:i:s')
                    ));
				}
				catch( Exception $e ) {
                throw $e;
                }
                 $aResult['status'] = true;	
	        }
	         else
            {
            $meeting_req_Data->scheduled_date ='';
            $meeting_req_Data->scheduled_time ='';
            $meeting_req_Data->approved ='';
            $meeting_req_Data->created_at =date('Y-m-d H:i:s');
            $meeting_req_Data->updated_at =date('Y-m-d H:i:s');
            $meeting_req_Data->save();
            $aResult['status'] = true;            
		    }
		    
         // send notification

        $userTable = Engine_Api::_()->getDbtable('users', 'user');
        $resciverData = $userTable->fetchRow($userTable->select()->where('user_id = ?',  $aData['owner_id']));
       
        $propertyTable      =  Engine_Api::_()->getDbtable('propertylist', 'user');
        $propertylists       = $propertyTable->fetchRow($propertyTable->select()->where('id = ?', $aData['property_id']));
       
        Engine_Api::_()->getDbtable('notifications', 'activity')
                ->addNotification($resciverData, $viewer, $resciverData, 'meeting_request',array(
               'property' => $propertylists->property_name));            
                    
                     // send mail
        $from_email    = Engine_Api::_()->getApi('settings', 'core')->core_mail_from;

        $bodyTextContent = '';

                         if (file_exists("emailtemplates/meeting_request_email.html")) {
                            $htmlExist = true;
                            $file = fopen("emailtemplates/meeting_request_email.html", "r");
                            while(!feof($file))
                            {
                                $bodyTextContent .= fgets($file);
                            }
                            fclose($file);
                        }

                            if($htmlExist){
                              $sendername       = '{sendername}';
                              $rescivername     = '{rescivername}';
                              $senderurl        = '{senderurl}';
                              $redirectUrl      = '{redirectUrl}';
                              $Pname            = '{propertyname}';
                              $sender_url       = $_SERVER['HTTP_HOST']."/profile/".$viewer_id;
                              $redirect_url     = $_SERVER['HTTP_HOST']."/scheduler/meetings/requests";
                              $bodyTextTemplate = '';
                              $bodyHtmlTemplate = $bodyTextContent;
                            foreach( $rParams as $var => $val ) {
                              $raw = trim($var, '[]');
                              $var = '[' . $var . ']';
                              if( !$val ) {
                                $val = $var;
                              }
                              // Fix nbsp
                              $val = str_replace('&amp;nbsp;', ' ', $val);
                              $val = str_replace('&nbsp;', ' ', $val);
                              // Replace
                             $bodyTextTemplate = str_replace($var, $val, $bodyTextTemplate);
                             $bodyHtmlTemplate = str_replace($var, $val, $bodyHtmlTemplate);
                            }
                            $bodyTextTemplate = strip_tags($bodyTextTemplate);
                            $bodyHtmlTemplate = str_replace($sendername, $viewer->displayname, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($rescivername, $resciverData->displayname, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($Pname, $propertylists->property_name, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($senderurl, $sender_url, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($redirectUrl, $redirect_url, $bodyHtmlTemplate);

                            }
                    $subject = "Meeting Request";
                    $header  = "From: ".'Rentstarz'." <".$from_email.">\r\n";
                    $header .= "MIME-Version: 1.0\r\n";
                    $header .= 'Content-type: text/html; charset=iso-8859-1' ."\"\r\n\r\n";
                    mail($resciverData->email, $subject, $bodyHtmlTemplate, $header);
                   
                    
                    
                    
                    
	       /* else
            {
               $aResult['status'] = false;
            }*/
             echo json_encode($aResult);
	        
	        
	        
	}
	
	
	    public function schedulemeetingAction(){
			if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viewer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();

        if( $this->getRequest()->isPost()){
            $aData = $this->_request->getPost();
            $scheduled_with = $aData['meetingscheduled_with'];
            //echo $scheduled_with;exit;
            $scheduled_date = $aData['scheduled_date'];
            $scheduled_time = $aData['scheduled_time'];
            $property_id    = $aData['property_id'];
            $propertyTable        =  Engine_Api::_()->getDbtable('propertylist', 'user');
            $propertyData         =  $propertyTable->fetchRow($propertyTable->select()->where('id = ?', $property_id));



            $meetingSchedulerTable =  Engine_Api::_()->getDbtable('meetingscheduler', 'user');
            
            $meetingSchedulerData = $meetingSchedulerTable->fetchRow($meetingSchedulerTable->select()
                                               ->where('scheduled_with = ?', $viewer_id)
                                               ->where('scheduled_date = ?', $aData['scheduled_date'])
                                               ->where('scheduled_time = ?', $aData['scheduled_time'])
            );
            if(count($meetingSchedulerData)>0){
				$aResult['status'] = false;
				$aResult['message'] = 'You have already scheduled a meeting with someone at same time';
			}
            else{
            $meetingSchedulerTable->update(array('scheduled_date' =>$scheduled_date,'scheduled_time' =>$scheduled_time,'approved' =>1),array('property_id = ?' => $property_id,'scheduled_by = ?' => $scheduled_with));
          
         // send notification
            $userTable    = Engine_Api::_()->getDbtable('users', 'user');
            $userTable->select()->where('user_id = ?', $scheduled_with); 
            $resciverData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $scheduled_with));
            Engine_Api::_()->getDbtable('notifications', 'activity')
                    ->addNotification($resciverData, $viewer, $resciverData, 'approve_scheduler',array(
                  'scheduled_date' => $scheduled_date,'scheduled_time' => $scheduled_time));


                   // send mail
            $from_email    = Engine_Api::_()->getApi('settings', 'core')->core_mail_from;

            $bodyTextContent = '';

                         if (file_exists("emailtemplates/meeting_notification_email.html")) {
                            $htmlExist = true;
                            $file = fopen("emailtemplates/meeting_notification_email.html", "r");
                            while(!feof($file))
                            {
                                $bodyTextContent .= fgets($file);
                            }
                            fclose($file);
                        }

                            if($htmlExist){

                              $rescivername     = '{rescivername}';
                              $redirectUrl      = '{redirectUrl}';
                              $redirect_url     = $_SERVER['HTTP_HOST']."/scheduler/meetings";
                              $contentData      = '{Contents}';
                              $content = ''.
                              $content = $content.'<a href="'.$_SERVER['HTTP_HOST'].'/profile/'.$viewer_id.'">'.$viewer->displayname.'</a> has approved your meeting request on ';
                              $content = $content. $scheduled_date ." " .$scheduled_time;
                              
                              $bodyTextTemplate = '';
                              $bodyHtmlTemplate = $bodyTextContent;
                            foreach( $rParams as $var => $val ) {
                              $raw = trim($var, '[]');
                              $var = '[' . $var . ']';
                              if( !$val ) {
                                $val = $var;
                              }
                              // Fix nbsp
                              $val = str_replace('&amp;nbsp;', ' ', $val);
                              $val = str_replace('&nbsp;', ' ', $val);
                              // Replace
                             $bodyTextTemplate = str_replace($var, $val, $bodyTextTemplate);
                             $bodyHtmlTemplate = str_replace($var, $val, $bodyHtmlTemplate);
                            }
                            $bodyTextTemplate = strip_tags($bodyTextTemplate);
                            $bodyHtmlTemplate = str_replace($rescivername, $resciverData->displayname, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($redirectUrl, $redirect_url, $bodyHtmlTemplate);
                            $bodyHtmlTemplate = str_replace($contentData, $content, $bodyHtmlTemplate);


                            }
                    $subject = "Approved meeting";
                    $header  = "From: ".'Rentstarz'." <".$from_email.">\r\n";
                    $header .= "MIME-Version: 1.0\r\n";
                    $header .= 'Content-type: text/html; charset=iso-8859-1' ."\"\r\n\r\n";
                    mail($resciverData->email, $subject, $bodyHtmlTemplate, $header);

            $aResult['status']  = true;
            $aResult['message'] = 'success';
          }
	    }
        else{
              $aResult['status']  = false;
              $aResult['message'] = 'failed';
        }
        echo json_encode($aResult);

    }
		
     public function rescheduleoflandlordAction(){
		 if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
		$viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viewer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
		if( $this->getRequest()->isPost()){
            $aData = $this->_request->getPost();
            $meetingSchedulerTable =  Engine_Api::_()->getDbtable('meetingscheduler', 'user');
            
            $meetingSchedulerData = $meetingSchedulerTable->fetchRow($meetingSchedulerTable->select()
                                               ->where('scheduled_by = ?', $viewer_id)
                                               ->where('scheduled_date = ?', $aData['scheduled_date'])
                                               ->where('scheduled_time = ?', $aData['scheduled_time'])
            );
            if(count($meetingSchedulerData)>0){
				$aResult['status'] = false;
				$aResult['message'] = 'You have already scheduled a meeting with someone at same time';
			}
			else{
            $meetingSchedulerTable->update(array('scheduled_date' =>$aData['scheduled_date'],'scheduled_time' =>$aData['scheduled_time'],'approved' =>1),array('id = ?' => $aData['data_id']));
            $aResult['status'] = true;
            $aResult['message']  = 'success';
		    }
        
		}
		else{
              $aResult['status'] = false;
              $aResult['message']  = 'failed';
        }
         echo json_encode($aResult);
	}
	
	public function autocompleteusersAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
		     $this->_helper->viewRenderer->setNoRender(true);
             $this->_helper->layout->disableLayout();
             $viewer        = Engine_Api::_()->user()->getViewer();
             
             $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
             if( !empty($fieldsByAlias['profile_type']) ){
              $optionId        = $fieldsByAlias['profile_type']->getValue($viewer);
              $profile_type_id = $optionId->value;
             }
             
             
			 $aData = $this->_request->getPost();
             $term                =   $aData['inputTerm'];
             $viewer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
             $userTable     = Engine_Api::_()->getDbtable('users', 'user');
             
             if($profile_type_id  == 4){
                                                
             $userDataSelect   =   $userTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('user'=>'engine4_users',))
                        ->joinLeft(array('search_field'=>'engine4_user_fields_search'),'search_field.item_id=user.user_id',array('profile_type'))
                        ->where('user.search=?' , 1)
                        ->where('user.enabled=?' , 1)
                        ->where('search_field.profile_type =?' , '1')
                        ->group('user.user_id');
              }          
             if($profile_type_id  == 1){
                                                
             $userDataSelect   =   $userTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('user'=>'engine4_users',))
                        ->joinLeft(array('search_field'=>'engine4_user_fields_search'),'search_field.item_id=user.user_id',array('profile_type'))
                        ->where('user.search=?' , 1)
                        ->where('user.enabled=?' , 1)
                        ->where('search_field.profile_type =?' , '4')
                        ->group('user.user_id');
              }          

                                            
             $userDataSelect->where('user.displayname LIKE ?' , "%{$term}%");
             
             $userDataData              =   $userTable->fetchAll($userDataSelect);
             
             $ResultData  = array();
             
             foreach($userDataData as $data):
             
             $tmpArray['label'] = $data['displayname']; 
             $tmpArray['value'] = $data['user_id']; 
             $finaltmpArray[] = $tmpArray;
             endforeach;
             $ResultData12 = array_merge($ResultData,$finaltmpArray);
             
            // echo '<pre>'; print_r($ResultData12); exit;
             echo json_encode($ResultData12); 
	}
	
		public function completemeetingAction(){
			if( !$this->_helper->requireUser()->isValid() ) {
             return;
           }
			
			$this->_helper->viewRenderer->setNoRender(true);
            $this->_helper->layout->disableLayout();
            $viewer        = Engine_Api::_()->user()->getViewer();
            date_default_timezone_set($viewer->timezone);
			
			if( $this->getRequest()->isPost()){	
            $aData = $this->_request->getPost();
            $meetingSchedulerTable =  Engine_Api::_()->getDbtable('meetingscheduler', 'user');
            $scheduledMeetingsData = $meetingSchedulerTable->fetchRow($meetingSchedulerTable->select()->where('id = ?', $aData['data_id']));
            $scheduledMeetingsData->approved = 'completed';
            $scheduledMeetingsData->save();
            $aResult['status'] = true;        
		   }
		   else{
			  $aResult['status'] = false; 
		   }
		   echo json_encode($aResult);
			
		}
	public function featuredstoryAction(){

        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('common_layout');
        $this->view->metaTitle        = 'Featured Story';
    }
	public function reportuserAction(){
		
      if( !$this->_helper->requireUser()->isValid() ) {
             return;
           }
			
			$this->_helper->viewRenderer->setNoRender(true);
            $this->_helper->layout->disableLayout();
            $viewer        = Engine_Api::_()->user()->getViewer();
            date_default_timezone_set($viewer->timezone);
        if( $this->getRequest()->isPost()){	
            $aData             = $this->_request->getPost();
			$table = Engine_Api::_()->getItemTable('core_report');
			
			try{
			$tableId  =   $table->insert(array(
                    'subject_id'     => $aData['subjectId'],
                    'subject_type'   => 'user',
                    'user_id'        => $aData['reporterId'],
                    'category'       => $aData['reportCategory'],
                    'description'    => $aData['reportDescription'],
                    'creation_date'  => date('Y-m-d H:i:s'),
                    ));
                    $aResult['status'] = true;  
			}catch (Exception $e) {exit($e->getMessage());
                                $aResult['status'] = false;
            }
        }
		else{
			$aResult['status'] = false;     
		}
		 echo json_encode($aResult);
     
    }
    
    public function blockmemberAction(){
		
		 if( !$this->_helper->requireUser()->isValid() ) {
             return;
           }
			
			$this->_helper->viewRenderer->setNoRender(true);
            $this->_helper->layout->disableLayout();
            $viewer        = Engine_Api::_()->user()->getViewer();
            date_default_timezone_set($viewer->timezone);
		  if( $this->getRequest()->isPost()){	
            $aData             = $this->_request->getPost();
            $user_id  = $aData['subjectId'];
            
            $db = Engine_Api::_()->getDbtable('block', 'user')->getAdapter();
            $db->beginTransaction();
            try {
				$user = Engine_Api::_()->getItem('user', $user_id);      
				$viewer->addBlock($user);
				$aResult['status'] = true;
				if( $user->membership()->isMember($viewer, null) ) {
				$user->membership()->removeMember($viewer);
				} 
				try {
					// Set the requests as handled
					$notification = Engine_Api::_()->getDbtable('notifications', 'activity')
					  ->getNotificationBySubjectAndType($viewer, $user, 'friend_request');
					if( $notification ) {
					  $notification->mitigated = true;
					  $notification->read = 1;
					  $notification->save();
					}
					$notification = Engine_Api::_()->getDbtable('notifications', 'activity')
						->getNotificationBySubjectAndType($viewer, $user, 'friend_follow_request');
					if( $notification ) {
					  $notification->mitigated = true;
					  $notification->read = 1;
					  $notification->save();
					}
				 } catch( Exception $e ) {$aResult['status'] = false;}
           
             $db->commit();
		}catch (Exception $e) {exit($e->getMessage());
                                $aResult['status'] = false;
            }
	   }
	   else{
		 $aResult['status'] = false;  
	   }
	   echo json_encode($aResult);
	}
	 public function unblockmemberAction(){
		 
		if( !$this->_helper->requireUser()->isValid() ) {
             return;
           }
			
			$this->_helper->viewRenderer->setNoRender(true);
            $this->_helper->layout->disableLayout();
            $viewer        = Engine_Api::_()->user()->getViewer();
            date_default_timezone_set($viewer->timezone); 
		 	if( $this->getRequest()->isPost()){	
            $aData             = $this->_request->getPost();
            $user_id           = $aData['subjectId'];
            $db = Engine_Api::_()->getDbtable('block', 'user')->getAdapter();
            $db->beginTransaction();
             try {
				  $user = Engine_Api::_()->getItem('user', $user_id);
				  $viewer->removeBlock($user);
				  $db->commit();
                  $aResult['status'] = true;
				 
           }catch (Exception $e) {exit($e->getMessage());
                                $aResult['status'] = false;
            }
		}
		else{
		 $aResult['status'] = false;  
	    }
		echo json_encode($aResult); 
	 }
	 
	 // cron for background report expiry notification
	 
	 public function backgroundreportexpirynotificationAction(){
		 $this->_helper->viewRenderer->setNoRender(true);
         $this->_helper->layout->disableLayout();
		 $userTable = Engine_Api::_()->getDbtable('users', 'user');
         $usersdata = $userTable->getAdapter()->select()
                        ->from(array('user'=>'engine4_users'))
                        ->query()->fetchAll(); 
         $SmartmoveapireportTable             =  Engine_Api::_()->getDbtable('Smartmoveapireport', 'user');
         $smartmoveapiRenters_table           =  Engine_Api::_()->getDbtable('Smartmoveapirenters', 'user');
         $today          = date('d-m-Y');
         $today_date     = strtotime($today);      
         foreach($usersdata as $user){
			$UserData             =  $userTable->fetchRow($userTable->select()->where('user_id = ?', $user['user_id']));
            $fieldsByAlias        =  Engine_Api::_()->fields()->getFieldsObjectsByAlias($UserData);
            if( !empty($fieldsByAlias['profile_type']) )
            {
                  $optionId        = $fieldsByAlias['profile_type']->getValue($UserData);
                  $profile_type_id = $optionId->value;
            }
            if($profile_type_id == 1){ //renter
			  $smartmoveapiRentersData             = $smartmoveapiRenters_table->fetchRow($smartmoveapiRenters_table->select()->where('tenant_id   = ?', $user['user_id']));
	
			  $SmartmoveapireportData    = $SmartmoveapireportTable->fetchRow($SmartmoveapireportTable->select()->where('RenterId = ?', $user['user_id'])->where('status =? ','Active'));
	          if(count($SmartmoveapireportData) != 0){
				  $expiry_date  = $SmartmoveapireportData->expiry_date;
				 
                  $expiry_date    = strtotime($PaymentpackageData->expiry_date);
                        if($today_date<=$expiry_date){ 
                        $diff           = $expiry_date -$today_date;
                        $day_diif       = round($diff / 86400);
                        if($day_diif == 5 || $day_diif == 2){
							
                            $from_email           =  Engine_Api::_()->getApi('settings', 'core')->core_mail_from;
                            $bodyTextContent      =  '';
                            $mainContent          =  '';

                                 if (file_exists("emailtemplates/common_email.html")) {
                                    $htmlExist  = true;
                                    $file       = fopen("emailtemplates/common_email.html", "r");
                                    while(!feof($file))
                                    {
                                        $bodyTextContent .= fgets($file);
                                    }
                                    fclose($file);
                                }

                                if($htmlExist){
                                      $resciverName   = '{resciver_name}';
                                      $content        = '{content}';                                      
                                      $mainContent    = 'You have only few days remaining to expire your background report. ';
 
                                      $bodyTextTemplate = '';
                                      $bodyHtmlTemplate = $bodyTextContent;
                                    foreach( $rParams as $var => $val ) {
                                          $raw = trim($var, '[]');
                                          $var = '[' . $var . ']';
                                          if( !$val ) {
                                            $val = $var;
                                          }
                                          // Fix nbsp
                                          $val = str_replace('&amp;nbsp;', ' ', $val);
                                          $val = str_replace('&nbsp;', ' ', $val);
                                          // Replace

                                         $bodyTextTemplate = str_replace($var, $val, $bodyTextTemplate);
                                         $bodyHtmlTemplate = str_replace($var, $val, $bodyHtmlTemplate);
                                    }
                                    $bodyTextTemplate = strip_tags($bodyTextTemplate);
                                    $bodyHtmlTemplate = str_replace($resciverName, $UserData->displayname , $bodyHtmlTemplate);
                                    $bodyHtmlTemplate = str_replace($content, $mainContent, $bodyHtmlTemplate);
                                }
                                    $subject = "Background report remainder";
                                    $header  = "From: ".'Rentstarz'." <".$from_email.">\r\n";
                                    $header .= "MIME-Version: 1.0\r\n";
                                    $header .= 'Content-type: text/html; charset=iso-8859-1' ."\"\r\n\r\n";
                                    mail($UserData->email, $subject, $bodyHtmlTemplate, $header);
                                     // send notification

                               Engine_Api::_()->getDbtable('notifications', 'activity')
                                ->addNotification($UserData , $UserData , $UserData , 'backgroundreport_remainder_during_lastweek',array());	
							
						}
                        }
			  }
				
			}
			 
		 }  
		  // entry for cron log

		$cronlogTable =  Engine_Api::_()->getDbtable('cronlog', 'user');
		$cronlogData = $cronlogTable->fetchRow($cronlogTable->select()->where('type = ?', 'backgroundreport_remainder_during_lastweek'));
		if(count($cronlogData) > 0){
			$cronlogData->execution_count = $cronlogData->execution_count +1;
			$cronlogData->created_at = date('Y-m-d');
			$cronlogData->save();
		}
		else{
		$cronlogTableId=   $cronlogTable->insert(array(
								'type' => 'backgroundreport_remainder_during_lastweek',
								'execution_count' => 1,
								'created_at' => date('Y-m-d'),

							));
		}
		 exit("success");	            
		 
	 }
	public function setintrosessionAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
		 $this->_helper->viewRenderer->setNoRender(true);
         $this->_helper->layout->disableLayout();

         if( $this->getRequest()->isPost()){	
            $aData             = $this->_request->getPost();  
            if($aData['status'] == 'skipintro'){
				$_SESSION['introstatus'] = 'skipintro';
			}          
            if($aData['status'] == 'yesintro'){
				$_SESSION['introstatus'] = 'yesintro';
			}          
		}
		$aResult['status'] =true;
        echo json_encode($aResult);
	 } 
	 public function contactAction(){

         $this->_helper->viewRenderer->setNoRender(true);
         $this->_helper->layout->disableLayout();
		 if( $this->getRequest()->isPost()){	
            $aData             = $this->_request->getPost(); 
            $contactTable             =  Engine_Api::_()->getDbtable('Contact', 'user');
            try{

             $contactTableId  =   $contactTable->insert(array(
                    'name'         => $aData['yourName'],
                    'email'        => $aData['yourEmail'],
                    'message'      => $aData['yourMessage'],
                    'created_at'   => date('Y-m-d'),
                    'updated_at'   => date('Y-m-d H:i:s'),
                   ));
             //mail
                            $from_email           =  $aData['yourEmail'];
                            $bodyTextContent      =  '';
                            $mainContent          =  '';

                                 if (file_exists("emailtemplates/common_email.html")) {
                                    $htmlExist  = true;
                                    $file       = fopen("emailtemplates/common_email.html", "r");
                                    while(!feof($file))
                                    {
                                        $bodyTextContent .= fgets($file);
                                    }
                                    fclose($file);
                                }

                                if($htmlExist){
                                      $resciverName   = '{resciver_name}';
                                      $content        = '{content}';                                      
                                      $mainContent    =  $aData['yourMessage'];
 
                                      $bodyTextTemplate = '';
                                      $bodyHtmlTemplate = $bodyTextContent;
                                    foreach( $rParams as $var => $val ) {
                                          $raw = trim($var, '[]');
                                          $var = '[' . $var . ']';
                                          if( !$val ) {
                                            $val = $var;
                                          }
                                          // Fix nbsp
                                          $val = str_replace('&amp;nbsp;', ' ', $val);
                                          $val = str_replace('&nbsp;', ' ', $val);
                                          // Replace

                                         $bodyTextTemplate = str_replace($var, $val, $bodyTextTemplate);
                                         $bodyHtmlTemplate = str_replace($var, $val, $bodyHtmlTemplate);
                                    }
                                    $bodyTextTemplate = strip_tags($bodyTextTemplate);
                                    $bodyHtmlTemplate = str_replace($resciverName, '', $bodyHtmlTemplate);
                                    $bodyHtmlTemplate = str_replace($content, $mainContent, $bodyHtmlTemplate);
                                }
                                    $subject = "Contact";
                                    $header  = "From: ".'Rentstarz'." <".$from_email.">\r\n";
                                    $header .= "MIME-Version: 1.0\r\n";
                                    $header .= 'Content-type: text/html; charset=iso-8859-1' ."\"\r\n\r\n";
                                    mail('admin@rentstarz.com', $subject, $bodyHtmlTemplate, $header);
             $aResult['status'] = true;
                   
           }catch (Exception $e) {
            $aResult['status'] = false;
           }     
            
		}
		echo json_encode($aResult); 
	 }
	 // cron
	 public function automaticpackagerenewalAction(){
		$this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        $userTable = Engine_Api::_()->getDbtable('users', 'user');
        $usersdata = $userTable->getAdapter()->select()
                        ->from(array('user'=>'engine4_users'))
                        ->query()->fetchAll();

        $today = date('Y-m-d');
        foreach($usersdata as $user){
			$remainder_mail  = 0;
			$UserData             =  $userTable->fetchRow($userTable->select()->where('user_id = ?', $user['user_id']));
            $fieldsByAlias        = Engine_Api::_()->fields()->getFieldsObjectsByAlias($UserData);
            if( !empty($fieldsByAlias['profile_type']) )
            {
                  $optionId        = $fieldsByAlias['profile_type']->getValue($UserData);
                  $profile_type_id = $optionId->value;
            }
            if($profile_type_id == 4 ){ // landlord			
				 $userPackagesTable             =  Engine_Api::_()->getDbtable('Userpackages', 'user');                 
		         $userPackagesData       = $userPackagesTable->fetchRow($userPackagesTable->select()
		                                     ->where('user_id = ?', $user['user_id'])
		                                     ->where('status = ?', 'active')
		                                     ->order('payment_id DESC')
		                                     );
		         if(count($userPackagesData) > 0){					 
					$today_date     = strtotime($today) ;
                    $expiry_date    = strtotime($userPackagesData->expiry_date); 
                    if($today_date < $expiry_date){
						$diff           = $expiry_date - $today_date;
                        $day_diif       = round($diff / 86400);
                        if($day_diif == 2){
							$remainder_mail = 1;
						}
						 if($remainder_mail == 1){							
                            $resciverData  =  $userTable->fetchRow($userTable->select()->where('user_id = ?', $user['user_id']));
                            $from_email           =  Engine_Api::_()->getApi('settings', 'core')->core_mail_from;
                            $bodyTextContent      =  '';
                             if (file_exists("emailtemplates/common_email.html")) {
                                    $htmlExist  = true;
                                    $file       = fopen("emailtemplates/common_email.html", "r");
                                    while(!feof($file))
                                    {
                                        $bodyTextContent .= fgets($file);
                                    }
                                    fclose($file);
                                }
                                if($htmlExist){
                                      $resciverName   = '{resciver_name}';
                                      $content        = '{content}';                                      
                                      $mainContent    =  'You have only '.$day_diif.' days remains to expire your package'; 
                                      $bodyTextTemplate = '';
                                      $bodyHtmlTemplate = $bodyTextContent;
                                    foreach( $rParams as $var => $val ) {
                                          $raw = trim($var, '[]');
                                          $var = '[' . $var . ']';
                                          if( !$val ) {
                                            $val = $var;
                                          }
                                          // Fix nbsp
                                          $val = str_replace('&amp;nbsp;', ' ', $val);
                                          $val = str_replace('&nbsp;', ' ', $val);
                                          // Replace

                                         $bodyTextTemplate = str_replace($var, $val, $bodyTextTemplate);
                                         $bodyHtmlTemplate = str_replace($var, $val, $bodyHtmlTemplate);
                                    }
                                    $bodyTextTemplate = strip_tags($bodyTextTemplate);
                                    $bodyHtmlTemplate = str_replace($resciverName, $resciverData->displayname, $bodyHtmlTemplate);
                                    $bodyHtmlTemplate = str_replace($content, $mainContent, $bodyHtmlTemplate);
                                }
                                    $subject = "Package renewal remainder";
                                    $header  = "From: ".'Rentstarz'." <".$from_email.">\r\n";
                                    $header .= "MIME-Version: 1.0\r\n";
                                    $header .= 'Content-type: text/html; charset=iso-8859-1' ."\"\r\n\r\n";
                                    mail($resciverData->email, $subject, $bodyHtmlTemplate, $header);
                                     
                                     // send notification

                               Engine_Api::_()->getDbtable('notifications', 'activity')
                                ->addNotification($resciverData, $resciverData, $resciverData, 'package_renewal_remainder',array(
                              'day_diif' => $day_diif)); 
							 
						 }
					}
					
					if($today_date == $expiry_date){
						 $userPackagesData->status      = 'expired';					 
					     $userPackagesData->updated_at  = date('Y-m-d H:i:s');	
					     $userPackagesData->save();	
					     
						 $settings = Engine_Api::_()->getApi('settings', 'core');
						 if($userPackagesData->package_type == 'landlord_pro_package'){  $packageRate = $settings->user_landlordProPrice; }
						 if($userPackagesData->package_type == 'management_gold_package'){  $packageRate = $settings->user_managementGoldPrice; }
						 $viewHelperObj                          =  $this->view->getHelper('SmartmoveApi125');
						 $stripefiles     = $viewHelperObj->getStripeFiles();		
						 
						 
						 $CardholderdetailsTable =  Engine_Api::_()->getDbtable('Cardholderdetails', 'user');
	                     $CardholderdetailsData  =  $CardholderdetailsTable->fetchRow($CardholderdetailsTable->select()->where('userId = ?',  $user['user_id']));
						
						if(!empty($CardholderdetailsData)){
														
							$cardholderFirstname   = $CardholderdetailsData->first_name;
							$cardholderLastname    = $CardholderdetailsData->last_name;
							$cardholderStreet      = $CardholderdetailsData->street;
							$cardholderCity        = $CardholderdetailsData->city;
							$cardholderState       = $CardholderdetailsData->state;
							$cardholderZipcode     = $CardholderdetailsData->zipcode;
							$cardholderCard_number        = $CardholderdetailsData->card_number;
							$cardholderExpiration_month   = $CardholderdetailsData->expiration_month;
							$cardholderExpiration_year    = $CardholderdetailsData->expiration_year;
							$cardholdercvc                = $CardholderdetailsData->cvc;
						}
						else{
							$cardholderFirstname    = $userPackagesData->first_name;
							$cardholderLastname     = $userPackagesData->last_name;
							$cardholderStreet       = $userPackagesData->street;
							$cardholderCity         = $userPackagesData->city;
							$cardholderState        = $userPackagesData->state;
							$cardholderZipcode      = $userPackagesData->zipcode;
							$cardholderCard_number        = $userPackagesData->card_number;
							$cardholderExpiration_month   = $userPackagesData->expiration_month;
							$cardholderExpiration_year    = $userPackagesData->expiration_year;
							$cardholdercvc                = $userPackagesData->cvc;					
							
						}
						 $params = array(
							"testmode"   => "off",
							"private_live_key" => "sk_live_bcnF3vdwkx2Q405aOq7POiep",
							"public_live_key"  => "pk_live_evBvNtpwiJlCwieyHNPKsQLO",
							"private_test_key" => "sk_test_K2gnuPgv5SH1P3lkvw86TJIQ",
							"public_test_key"  => "pk_test_kCahdc8oaSK65WPNb3iClcF1"
						);
						if ($params['testmode'] == "on") {
						Stripe::setApiKey($params['private_test_key']);
						$pubkey = $params['public_test_key'];
						} else {
						Stripe::setApiKey($params['private_live_key']);
						$pubkey = $params['public_live_key'];
						}            
						$result = Stripe_Token::create(
									array(
										"card" => array(
											"name"      => $cardholderFirstname,
											"number"    => $cardholderCard_number,
											"exp_month" => $cardholderExpiration_month ,
											"exp_year"  => $cardholderExpiration_year,
											"cvc"       => $cardholdercvc
										)
									)
								);
						$stripeToken  = $result['id']; 
						$amount_cents = str_replace(".","",$packageRate);  // Chargeble amount
						$amount_cents = (int)($packageRate * 100) ;
						$invoiceid = "14526321";                      // Invoice ID
						$description = "Invoice #" . $invoiceid . " - " . $invoiceid;
						try {
							$charge = Stripe_Charge::create(array(
								  "amount"      => $amount_cents,
								  "currency"    => "usd",
								  "source"      => $stripeToken,
								  "description" => $description
								  )
							);

								if ($charge->card->address_zip_check == "fail") {
									throw new Exception("zip_check_invalid");
								} else if ($charge->card->address_line1_check == "fail") {
									throw new Exception("address_check_invalid");
								} else if ($charge->card->cvc_check == "fail") {
									throw new Exception("cvc_check_invalid");
								}
							// Payment has succeeded, no exceptions were thrown or otherwise caught
							$result = "success";
							}
							catch(Stripe_CardError $e) {

							$error = $e->getMessage();
								$result = "declined";

							} catch (Stripe_InvalidRequestError $e) {
								$result = "declined";
							} catch (Stripe_AuthenticationError $e) {
								$result = "declined";
							} catch (Stripe_ApiConnectionError $e) {
								$result = "declined";
							} catch (Stripe_Error $e) {
								$result = "declined";
							} catch (Exception $e) {

								if ($e->getMessage() == "zip_check_invalid") {
									$result = "declined";
								} else if ($e->getMessage() == "address_check_invalid") {
									$result = "declined";
								} else if ($e->getMessage() == "cvc_check_invalid") {
									$result = "declined";
								} else {
									$result = "declined";
								}
							}
							$paymentResponse =  $charge->__toJSON();  //echo '<pre>';print_r($paymentResponse); exit("kk");
							$response1 = json_decode($response);
							$response2 = json_decode(json_encode($response1));
							if($result == 'success'){
								 $duration        = 30;
								 $days            = "+".$duration." days";
								 $expiry_date     = date('Y-m-d', strtotime($days));							 
								 $userPackagesId  =   $userPackagesTable->insert(array(
									'user_id'        => $user['user_id'],
									'first_name'     => $cardholderFirstname,
									'last_name'      => $cardholderLastname,
									'street'         => $cardholderStreet,
									'city'           => $cardholderCity,
									'state'          => $cardholderState,
									'zipcode'        => $cardholderZipcode,
									'card_number'    => $cardholderCard_number,
									'expiration_month' => $cardholderExpiration_month,
									'expiration_year'  => $cardholderExpiration_year,
									'cvc'            => $cardholdercvc,
									'status'         => 'active',
									'expiry_date'    => $expiry_date,                    
									'package_type'   => $userPackagesData->package_type,
									'payment_amount' => $packageRate,
									'payment_response'  => $paymentResponse,
									'created_at'  =>  date('Y-m-d'),
									'updated_at'  =>  date('Y-m-d H:i:s')
									));
									

                            $resciverData  =  $userTable->fetchRow($userTable->select()->where('user_id = ?', $user['user_id']));
                            $from_email           =  Engine_Api::_()->getApi('settings', 'core')->core_mail_from;
                            $bodyTextContent      =  '';
                             if (file_exists("emailtemplates/common_email.html")) {
                                    $htmlExist  = true;
                                    $file       = fopen("emailtemplates/common_email.html", "r");
                                    while(!feof($file))
                                    {
                                        $bodyTextContent .= fgets($file);
                                    }
                                    fclose($file);
                                }
                                if($htmlExist){
                                      $resciverName   = '{resciver_name}';
                                      $content        = '{content}';                                      
                                      $mainContent    =  'Your package has been successfully renewed';
 
                                      $bodyTextTemplate = '';
                                      $bodyHtmlTemplate = $bodyTextContent;
                                    foreach( $rParams as $var => $val ) {
                                          $raw = trim($var, '[]');
                                          $var = '[' . $var . ']';
                                          if( !$val ) {
                                            $val = $var;
                                          }
                                          // Fix nbsp
                                          $val = str_replace('&amp;nbsp;', ' ', $val);
                                          $val = str_replace('&nbsp;', ' ', $val);
                                          // Replace

                                         $bodyTextTemplate = str_replace($var, $val, $bodyTextTemplate);
                                         $bodyHtmlTemplate = str_replace($var, $val, $bodyHtmlTemplate);
                                    }
                                    $bodyTextTemplate = strip_tags($bodyTextTemplate);
                                    $bodyHtmlTemplate = str_replace($resciverName, $resciverData->displayname, $bodyHtmlTemplate);
                                    $bodyHtmlTemplate = str_replace($content, $mainContent, $bodyHtmlTemplate);
                                }
                                    $subject = "Package renewal";
                                    $header  = "From: ".'Rentstarz'." <".$from_email.">\r\n";
                                    $header .= "MIME-Version: 1.0\r\n";
                                    $header .= 'Content-type: text/html; charset=iso-8859-1' ."\"\r\n\r\n";
                                    mail($resciverData->email, $subject, $bodyHtmlTemplate, $header);
                                     
                                     // send notification

                               Engine_Api::_()->getDbtable('notifications', 'activity')
                                ->addNotification($resciverData, $resciverData, $resciverData, 'package_renewal',array());

								$aResult['status'] =true;

							}
					}                    
				 }                            
			}
		}
		  // entry for cron log

    $cronlogTable =  Engine_Api::_()->getDbtable('cronlog', 'user');
    $cronlogData = $cronlogTable->fetchRow($cronlogTable->select()->where('type = ?', 'automaticpackage_renewal'));
    if(count($cronlogData) > 0){
        $cronlogData->execution_count = $cronlogData->execution_count +1;
        $cronlogData->created_at = date('Y-m-d');
        $cronlogData->save();
    }
    else{
    $cronlogTableId=   $cronlogTable->insert(array(
                            'type' => 'automaticpackage_renewal',
                            'execution_count' => 1,
                            'created_at' => date('Y-m-d'),

                        ));
    }
		 exit("success");		 
	 }
	 
	public function savecardholderdataAction(){
		$this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout(); $aData = $this->_request->getPost();
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viewer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
        $aResult=array();
        $aData = $this->_request->getPost();
        $CardholderdetailsTable =  Engine_Api::_()->getDbtable('Cardholderdetails', 'user');
	    $CardholderdetailsData  =  $CardholderdetailsTable->fetchRow($CardholderdetailsTable->select()->where('userId = ?',  $aData['userId']));
        try{
        
        if(empty($CardholderdetailsData)){			
			 $CardholderdetailsTable->insert(array(
                    'userId'         => $aData['userId'],
                    'first_name'     => $aData['first_name'],
                    'last_name'      => $aData['last_name'],
                    'street'         => $aData['street'],
                    'city'           => $aData['city'],
                    'state'          => $aData['state'],
                    'zipcode'        => $aData['zipcode'],
                    'card_number'    => $aData['card_number'],
                    'expiration_month' => $aData['expiration_month'],
                    'expiration_year'  => $aData['expiration_year'],
                    'cvc'              => $aData['cvc'],
                    'updated_at'       =>  date('Y-m-d H:i:s')
                    )); 					  
	   }
	   else{
			  $CardholderdetailsData->userId       = $aData['userId'];
			  $CardholderdetailsData->first_name   = $aData['first_name'];
			  $CardholderdetailsData->last_name    = $aData['last_name'];
			  $CardholderdetailsData->street       = $aData['street'];
			  $CardholderdetailsData->city         = $aData['city'];
			  $CardholderdetailsData->state        = $aData['state'];
			  $CardholderdetailsData->zipcode      = $aData['zipcode'];
			  $CardholderdetailsData->card_number  = $aData['card_number'];
			  $CardholderdetailsData->expiration_month   = $aData['expiration_month'];
			  $CardholderdetailsData->expiration_year    = $aData['expiration_year'];
			  $CardholderdetailsData->cvc                = $aData['cvc'];
			  $CardholderdetailsData->updated_at         = date('Y-m-d H:i:s');	
			  $CardholderdetailsData->save();				  
		  }
			$aResult['status'] = true;	 
		}catch (Exception $e) {
            $aResult['status'] = false;
        }
		echo json_encode($aResult);
	}
   public function cancelpackagerenewalAction(){
	    $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout(); $aData = $this->_request->getPost();
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viewer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
        $aResult=array();
        $aData = $this->_request->getPost();
        try{
        $userPackagesTable             =  Engine_Api::_()->getDbtable('Userpackages', 'user');
                 
		$userPackagesData       = $userPackagesTable->fetchRow($userPackagesTable->select()
		                                     ->where('user_id = ?', $aData['userId'])
		                                     ->where('status = ?', 'active'));
		$userPackagesData->status = 'expired_with_cancelrenewal' ;
		$userPackagesData->save(); 
		$aResult['status'] = true;
	   }catch (Exception $e) {
            $aResult['status'] = false;
        }
		echo json_encode($aResult);                                
   }
  public function savepropertyforbackgroundreportAction(){ 
	  
	  
	    $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        $aData     = $this->_request->getPost();
        
        $viewHelperObj                    =  $this->view->getHelper('SmartmoveApi125');        
        $Questions        = $viewHelperObj -> getPropertyQuestionAnsArray($aData['q1Ans'],$aData['q2Ans'],$aData['q3Ans'],$aData['q4Ans'],$aData['q5Ans']);
       // echo "<pre>"; print_r($Questions); exit;

        if($aData){
        $user_id   = Engine_Api::_()->user()->getViewer()->getIdentity();
        $viewer    = Engine_Api::_()->user()->getViewer();
        
        $aResult   = array();
        date_default_timezone_set($viewer->timezone);
        $propertyTable          =  Engine_Api::_()->getDbtable('propertylist', 'user');
        $propertyimageTable     =  Engine_Api::_()->getDbtable('propertyimages', 'user');
        $propertycountrtyTable  =  Engine_Api::_()->getDbtable('propertycountry', 'user');
        $propertystateTable     =  Engine_Api::_()->getDbtable('propertystate', 'user');
        $propertycityable       =  Engine_Api::_()->getDbtable('propertycity', 'user');
        try{
			    $propertycountryData = $propertycountrtyTable->fetchRow($propertycountrtyTable->select()->where('prty_country = ?', $aData['prty_country']));
                if(count($propertycountryData) == 0){
                    $propertycountryid  =   $propertycountrtyTable->insert(array(
                    'prty_country'  => $aData['prty_country']
                    ));
                }
                else{
                    $propertycountryid =  $propertycountryData->country_id;
                }
                
                $propertystateDataSelect = $propertystateTable->select()
                    ->where('country_id = ?', $propertycountryid)
                    ->where('prty_state = ?', $aData['prty_state']);
                    
                $propertystateData = $propertystateTable->fetchRow($propertystateDataSelect);
                if(count($propertystateData) == 0){
                    $propertystateid =   $propertystateTable->insert(array(
                    'country_id'  => $propertycountryid,
                    'prty_state'  => $aData['prty_state']
                    ));
                }
                else{
                    $propertystateid =  $propertystateData->state_id;
                }
                $propertycityDataSelect = $propertycityable->select()
                    ->where('country_id = ?', $propertycountryid)
                    ->where('state_id = ?',   $propertystateid)
                    ->where('prty_city = ?',  $aData['prty_city']);

                $propertycityData = $propertycityable->fetchRow($propertycityDataSelect);
                if(count($propertycityData) == 0){
                    $propertycityid=   $propertycityable->insert(array(
                    'country_id'  => $propertycountryid,
                    'state_id'    => $propertystateid,
                    'prty_city'   => $aData['prty_city'],
                    'zipcode'     => $aData['prty_zipcode'],
                    'latitude'    => $aData['prty_latitude'],
                    'longitude'   => $aData['prty_longitude']
                    ));
                    
                }
                else{
                    $propertycityid =  $propertycityData->city_id;
                }
                 $propertyid=   $propertyTable->insert(array(
                    'property_owner_id'       => $user_id,
                    'property_type'           => 'property_for_backgroundreport',
                    'property_name'           => $aData['property_name'],
                    'prty_country_id'         => $propertycountryid,
                    'prty_state_id'           => $propertystateid,
                    'prty_city_id'            => $propertycityid,
                    'prty_county'             => $aData['prty_county'],
                    'prty_neighborhood'       => $aData['prty_neighborhood'],
                    'zip'                     => $aData['prty_zipcode'],
                    'rental_type'             => '',
                    'description'             => '',
                    'price'                   => '',
                    'vouchers'                => '',
                    'wheelchair_accessible'   => '',
                    'months_of_deposits'      => '',
                    'property_manager'        => '',
                    'provide_parking'         => '',
                    'no_of_rooms'             => '',
                    'housing_type'            => '',
                    'has_pets'                => '',
                    'pets_type'               => '',
                    'landlord_enable'         => 1,
                    'enable'                  => 1,
                    'created_at'              => date('Y-m-d H:i:s'),
                ));
			
			    /********************smartmove api call create property start**************/
			    
			    $smartmoveapiquestions_table      =  Engine_Api::_()->getDbtable('smartmoveapiquestions', 'user');
				$smartmoveapiquestionAnswer_table =  Engine_Api::_()->getDbtable('Smartmoveapiquestionanswers', 'user');
				$viewHelperObj                    =  $this->view->getHelper('SmartmoveApi125');
			    $smartmoveQuestions_select   =   $smartmoveapiquestions_table->select()
                        ->setIntegrityCheck(false)
                        ->from(array('question'=>'engine4_smartmoveapi_questions',))
                        ->joinLeft(array('answer'=>'engine4_smartmoveapi_questionanswers',),'question.qid=answer.qid',array());
                $smartmoveQuestionsData=$smartmoveapiquestions_table->fetchAll($smartmoveQuestions_select);
				$PropertyIdentifier     = $propertyid."_".$aData['property_name'];
				$Name                   = $aData['property_name'];
				$UnitNumber             = $aData['UnitNumber'];
				$displayname            = explode(" ",$viewer->displayname);
				$FirstName              = $displayname[0];
				$LastName               = $aData['LandlordLastName'];
				$Street                 = $aData['Street'];
				$City                   = $aData['prty_city'];
				$StateArray             = $viewHelperObj->getState();
				$State                  = array_search($aData['prty_state'],$StateArray);
				$Zip                    = $aData['prty_zipcode'];
				$Phone                  = $aData['Phone'];
				$PhoneExtension         = $aData['PhoneExtension'];
				$Classification         = $aData['Classification'];
				$IR                     = $aData['IR'];        
			    $IncludeMedicalCollections       = $aData['IncludeMedicalCollections'];
				$IncludeForeclosures             = $aData['IncludeForeclosures'];
				$DeclineForOpenBankruptcies      = $aData['DeclineForOpenBankruptcies'];
				$OpenBankruptcyWindow            = $aData['OpenBankruptcyWindow'];
				$IsFcraAgreementAccepted         = $aData['IsFcraAgreementAccepted'];
				$LandlordStreetAddressLineOne         = $aData['LandlordStreetAddressLineOne'];
				$LandlordStreetAddressLineTwo         = $aData['LandlordStreetAddressLineTwo'];
				$LandlordState                        = $aData['LandlordState'];
				$LandlordCity                         = $aData['LandlordCity'];
				$LandlordZip                          = $aData['LandlordZip'];
				$LandlordPhoneNumber                  = $aData['LandlordPhoneNumber'];
				$LandlordEmail                        = $aData['LandlordEmail'];
				$LandlordData = array(
				'FirstName'                   => $FirstName,
				'LastName'                    => $LastName,
				'StreetAddressLineOne'        => $LandlordStreetAddressLineOne,
				'StreetAddressLineTwo'        => $LandlordStreetAddressLineTwo,
				'State'                       => $LandlordState,
				'City'                        => $LandlordCity,
				'Zip'                         => $LandlordZip,
				'PhoneNumber'                 => $LandlordPhoneNumber,
				'Email'                       => $LandlordEmail
				);
				$LandlordDataJson = json_encode($LandlordData);
				
				
				$params = array(
				'PropertyIdentifier' => $PropertyIdentifier,
				'OrganizationName'   => '',
				'OrganizationId'     => '',
				'Active'             => 'true',
				'Name'               => $Name,
				'UnitNumber'         => $UnitNumber,
				'Street'             => $Street,
				'State'              => $State,
				'City'               => $City,
				'Zip'                => $Zip,
				'Phone'              => $Phone,
				'PhoneExtension'     => $PhoneExtension,
				'Questions'          => $Questions,
				'Landlord'           => $LandlordData,
				'Classification'     => $Classification,
				'IR'                 => $IR,
				'IncludeMedicalCollections'  => $IncludeMedicalCollections,
				'IncludeForeclosures'        => $IncludeForeclosures,
				'DeclineForOpenBankruptcies' => $DeclineForOpenBankruptcies,
				'OpenBankruptcyWindow'       => $OpenBankruptcyWindow,
				'IsFcraAgreementAccepted'    => $IsFcraAgreementAccepted
				);
				$params          = json_encode($params);		
			    $response      = $viewHelperObj->createproperty($params);
			    $data          = json_decode($response, true); 
			    if ($response === false)
               {
				$aResult['status'] = false;
				$aResult['errors'] = curl_error($crl);
               }
               else{
				if(empty($data['Errors'])){
				$smartmoveapiProperty_table =  Engine_Api::_()->getDbtable('Smartmoveapiproperty', 'user');
				$smartmoveapiProperty_table->insert(array(
							'Pid'                        => $propertyid,
							'SmartmovePropertyId'        => $data['PropertyId'],
							'PropertyIdentifier'         => $data['PropertyIdentifier'],
							'OrganizationName'           => $data['OrganizationName'],
							'OrganizationId'             => $data['OrganizationId'],
							'Active'                     => $data['Active'],
							'Name'                       => $data['Name'],
							'FirstName'                  => $FirstName,
							'LastName'                   => $LastName,
							'Street'                     => $data['Street'],
							'City'                       => $data['City'],
							'State'                      => $data['State'],
							'Zip'                        => $data['Zip'],
							'Phone'                      => $data['Phone'],
							'PhoneExtension'             => $data['PhoneExtension'],
							'Classification'             => $data['Classification'],
							'IR'                         => $data['IR'],
							'IncludeMedicalCollections'  => $data['IncludeMedicalCollections'],
							'IncludeForeclosures'        => $data['IncludeForeclosures'],
							'DeclineForOpenBankruptcies' => $data['DeclineForOpenBankruptcies'],
							'OpenBankruptcyWindow'       => $data['OpenBankruptcyWindow'],
							'IsFcraAgreementAccepted'    => $data['IsFcraAgreementAccepted'],
							'UnitNumber'                 => $data['UnitNumber'],
							'landlordData'               => $LandlordDataJson,
							'Deposit'                    => $aData['Deposit'],
							'Rent'                       => $aData['Rent'],
							'LeaseTermInMonths'          => $aData['LeaseTermInMonths'],
							'LandlordPays'               => $aData['LandlordPays'],
							'ProductBundle'              => $aData['ProductBundle'],
							'created_at'                 => date('Y-m-d'),
							'updated_at'                 => date('Y-m-d')
							));
							
							$aResult['status'] = true;
							$aResult['smartmovePid'] = $data['PropertyId'];
							$aResult['pid'] = $propertyid;
						}
						else{
							$aResult['status'] = false;
							$aResult['errors'] = $data['Errors'];
						}
              }

			    
			    
		}catch (Exception $e) {exit($e->getMessage());
                                $aResult['status'] = false;
                            }
        
	      }
        
        echo json_encode($aResult);

        
	   }
	   
	   public function inviterentertobackgroundcheckAction(){
		   
		$this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout(); $aData = $this->_request->getPost();
        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viewer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
        $aResult=array();
        $aData = $this->_request->getPost();
        $pid = $aData['pid'];
        $renter_email = $aData['renter_email'];
        $smartmovePid = $aData['smartmovePid'];
        $userTable = Engine_Api::_()->getDbtable('users', 'user');
        $InvitedrentersbackgroundreportTable = Engine_Api::_()->getDbtable('Invitedrentersbackgroundreport', 'user');
        $userData  =  $userTable->fetchRow($userTable->select()->where('email = ?', $renter_email));
        
        if(empty($userData)){
			
			$InvitedrentersbackgroundreportTable->insert(array(
							'pid'                        => $pid,
							'smartmovePid'        =>       $smartmovePid	,
							'landlord_id'         => $viewer_id,
							'renter_id'         => 0,
							'renter_email'         => $renter_email,
							'backgroundReport'         => 0,
							'created_at'                 => date('Y-m-d')
				));
				
				$from_email           =  Engine_Api::_()->getApi('settings', 'core')->core_mail_from;
               $bodyTextContent      =  '';
                             if (file_exists("emailtemplates/common_email.html")) {
                                    $htmlExist  = true;
                                    $file       = fopen("emailtemplates/common_email.html", "r");
                                    while(!feof($file))
                                    {
                                        $bodyTextContent .= fgets($file);
                                    }
                                    fclose($file);
                                }
                                if($htmlExist){
                                      $resciverName   = '';
                                      $content        = '{content}'; 
                                      $mainContent    = '';                                     
                                      $mainContent    =  $mainContent.$viewer->displayname. 'requesting you to conduct a transunion background review for his apartment rental '; 
                                      $mainContent    =  $mainContent.'Please click the link below to verify your email and ';
                                      $mainContent    =  $mainContent.'continue with the review ';
                                      $mainContent    =  $mainContent.'For this, please register on <a href="'.$_SERVER['HTTP_HOST'].'">Rentstarz</a>'; 
                        
                                     
                                      $bodyTextTemplate = '';
                                      $bodyHtmlTemplate = $bodyTextContent;
                                    foreach( $rParams as $var => $val ) {
                                          $raw = trim($var, '[]');
                                          $var = '[' . $var . ']';
                                          if( !$val ) {
                                            $val = $var;
                                          }
                                          // Fix nbsp
                                          $val = str_replace('&amp;nbsp;', ' ', $val);
                                          $val = str_replace('&nbsp;', ' ', $val);
                                          // Replace

                                         $bodyTextTemplate = str_replace($var, $val, $bodyTextTemplate);
                                         $bodyHtmlTemplate = str_replace($var, $val, $bodyHtmlTemplate);
                                    }
                                    $bodyTextTemplate = strip_tags($bodyTextTemplate);
                                    $bodyHtmlTemplate = str_replace($resciverName, $resciverData->displayname, $bodyHtmlTemplate);
                                    $bodyHtmlTemplate = str_replace($content, $mainContent, $bodyHtmlTemplate);
                                }
                                    $subject = "Invited you for create bacground report";
                                    $header  = "From: ".'Rentstarz'." <".$from_email.">\r\n";
                                    $header .= "MIME-Version: 1.0\r\n";
                                    $header .= 'Content-type: text/html; charset=iso-8859-1' ."\"\r\n\r\n";
                                    mail($renter_email, $subject, $bodyHtmlTemplate, $header);
				
				
						$aResult['status'] = true;

		}
		
		else{
			$aResult['status'] = false;
			$aResult['error'] = "Already registered user";
		}

                echo json_encode($aResult); 
     }  
  
        
}



