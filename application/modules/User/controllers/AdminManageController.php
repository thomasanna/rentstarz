<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: AdminManageController.php 9919 2013-02-16 00:46:04Z matthew $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class User_AdminManageController extends Core_Controller_Action_Admin
{
  public function indexAction()
  {
    $this->view->formFilter = $formFilter = new User_Form_Admin_Manage_Filter();
    $page = $this->_getParam('page', 1);

    $table = Engine_Api::_()->getDbtable('users', 'user');
    $select = $table->select();

    // Process form
    $values = array();
    if( $formFilter->isValid($this->_getAllParams()) ) {
      $values = $formFilter->getValues();
    }

    foreach( $values as $key => $value ) {
      if( null === $value ) {
        unset($values[$key]);
      }
    }

    $values = array_merge(array(
      'order' => 'user_id',
      'order_direction' => 'DESC',
    ), $values);
    
    $this->view->assign($values);

    // Set up select info
    $select->order(( !empty($values['order']) ? $values['order'] : 'user_id' ) . ' ' . ( !empty($values['order_direction']) ? $values['order_direction'] : 'DESC' ));

    if( !empty($values['displayname']) ) {
      $select->where('displayname LIKE ?', '%' . $values['displayname'] . '%');
    }
    if( !empty($values['username']) ) {
      $select->where('username LIKE ?', '%' . $values['username'] . '%');
    }
    if( !empty($values['email']) ) {
      $select->where('email LIKE ?', '%' . $values['email'] . '%');
    }
    if( !empty($values['level_id']) ) {
      $select->where('level_id = ?', $values['level_id'] );
    }
    if( isset($values['enabled']) && $values['enabled'] != -1 ) {
      $select->where('enabled = ?', $values['enabled'] );
    }
    if( !empty($values['user_id']) ) {
      $select->where('user_id = ?', (int) $values['user_id']);
    }
    
    // Filter out junk
    $valuesCopy = array_filter($values);
    // Reset enabled bit
    if( isset($values['enabled']) && $values['enabled'] == 0 ) {
      $valuesCopy['enabled'] = 0;
    }
    
    // Make paginator
    $this->view->paginator = $paginator = Zend_Paginator::factory($select);
    $this->view->paginator = $paginator->setCurrentPageNumber( $page );
    $this->view->formValues = $valuesCopy;

    $this->view->superAdminCount = count(Engine_Api::_()->user()->getSuperAdmins());
    $this->view->hideEmails = _ENGINE_ADMIN_NEUTER;
    //$this->view->formDelete = new User_Form_Admin_Manage_Delete();
    
    $this->view->openUser = (bool) ( $this->_getParam('open') && $paginator->getTotalItemCount() == 1 );
  }

  public function multiModifyAction()
  {
    if( $this->getRequest()->isPost() ) {
      $values = $this->getRequest()->getPost();
      foreach ($values as $key=>$value) {
        if( $key == 'modify_' . $value ) {
          $user = Engine_Api::_()->getItem('user', (int) $value);
          if( $values['submit_button'] == 'delete' ) {
            if( $user->level_id != 1 ) {
              $user->delete();
                Engine_Db_Table::getDefaultAdapter()->delete('engine4_dropbox_log', array('subject_id = ?'=>$value) );
                Engine_Db_Table::getDefaultAdapter()->delete('engine4_dropbox_log', array('subject_id = ?'=>$value) );
				Engine_Db_Table::getDefaultAdapter()->delete('engine4_property_list', array('property_owner_id = ?'=>$value) );
				Engine_Db_Table::getDefaultAdapter()->delete('engine4_property_request', array('landlord_id = ?'=>$value) );
				Engine_Db_Table::getDefaultAdapter()->delete('engine4_property_granted', array('landlord_id	 = ?'=>$value) );
				Engine_Db_Table::getDefaultAdapter()->delete('engine4_property_granted', array('tenant_id  = ?'=>$value) );
				Engine_Db_Table::getDefaultAdapter()->delete('engine4_rating_questionsvalue', array('subject_id	= ?'=>$value) );
				Engine_Db_Table::getDefaultAdapter()->delete('engine4_rating_questionsvalue', array('object_id	= ?'=>$value) );
				Engine_Db_Table::getDefaultAdapter()->delete('engine4_rating_value', array('subject_id = ?'=>$value) );
				Engine_Db_Table::getDefaultAdapter()->delete('engine4_rating_value', array('object_id = ?'=>$value) );
				Engine_Db_Table::getDefaultAdapter()->delete('engine4_property_requirement', array('tenant_id	 = ?'=>$value) );
                Engine_Db_Table::getDefaultAdapter()->delete('engine4_property_viewlog', array('user_id	 = ?'=>$value) );
                Engine_Db_Table::getDefaultAdapter()->delete('engine4_meeting_scheduler', array('scheduled_by	 = ?'=>$value) );
                Engine_Db_Table::getDefaultAdapter()->delete('engine4_meeting_scheduler', array('scheduled_with	 = ?'=>$value) );
                Engine_Db_Table::getDefaultAdapter()->delete('engine4_report_share', array('report_shared_by	 = ?'=>$value) );
                Engine_Db_Table::getDefaultAdapter()->delete('engine4_report_share', array('report_shared_with	 = ?'=>$value) );
                Engine_Db_Table::getDefaultAdapter()->delete('engine4_report_request', array('renter_id	 = ?'=>$value) );
                Engine_Db_Table::getDefaultAdapter()->delete('engine4_report_request', array('landlord_id	 = ?'=>$value) );
                Engine_Db_Table::getDefaultAdapter()->delete('engine4_post_comments', array('posterId	 = ?'=>$value) );
            }
          } else if( $values['submit_button'] == 'approve' ) {
            $old_status = $user->enabled;
            $user->enabled = 1;
            $user->approved = 1;
            $user->save();
            
            // ORIGINAL WAY
            // Send a notification that the account was not approved previously
            if( $old_status == 0 ) {
              Engine_Api::_()->getApi('mail', 'core')->sendSystem($user, 'user_account_approved', array(
                'host' => $_SERVER['HTTP_HOST'],
                'email' => $user->email,
                'date' => time(),
                'recipient_title' => $user->getTitle(),
                'recipient_link' => $user->getHref(),
                'recipient_photo' => $user->getPhotoUrl('thumb.icon'),
                'object_link' => Zend_Controller_Front::getInstance()->getRouter()->assemble(array(), 'user_login', true),
              ));
              // Send hook to add activity
              Engine_Hooks_Dispatcher::getInstance()->callEvent('onUserEnable', $user);                           
            }
          }
        }
      }
    }

    return $this->_helper->redirector->gotoRoute(array('action' => 'index'));
  }

  public function editAction()
  {
    $id = $this->_getParam('id', null);
    $user = Engine_Api::_()->getItem('user', $id);
    $userLevel = Engine_Api::_()->getItem('authorization_level', $user->level_id);
    $viewer = Engine_Api::_()->user()->getViewer();
    $viewerLevel = Engine_Api::_()->getItem('authorization_level', $viewer->level_id);
    $superAdminLevels = Engine_Api::_()->getItemTable('authorization_level')->fetchAll(array(
      'flag = ?' => 'superadmin',
    ));
    

    
    
    
    if( !$user || !$userLevel || !$viewer || !$viewerLevel ) {
      return $this->_helper->redirector->gotoRoute(array('action' => 'index'));
    }
    
    $this->view->user = $user;
    $this->view->form = $form = new User_Form_Admin_Manage_Edit(array(
      'userIdentity' => $id,
      
    ));

    // Do not allow editing level if the last superadmin
    if( $userLevel->flag == 'superadmin' && count(Engine_Api::_()->user()->getSuperAdmins()) == 1 ) {
      $form->removeElement('level_id');
    }
    
    // Do not allow admins to change to super admin
    if( $viewerLevel->flag != 'superadmin' && $form->getElement('level_id') ) {
      if( $userLevel->flag == 'superadmin' ) {
        $form->removeElement('level_id');
      } else {
        foreach( $superAdminLevels as $superAdminLevel ) {
          unset($form->getElement('level_id')->options[$superAdminLevel->level_id]);
        }
      }
    }

    // Get values
    $values = $user->toArray();
    unset($values['password']);
    if( _ENGINE_ADMIN_NEUTER ) {
      unset($values['email']);
    }

    // Get networks
    $select = Engine_Api::_()->getDbtable('membership', 'network')->getMembershipsOfSelect($user);
    $networks = Engine_Api::_()->getDbtable('networks', 'network')->fetchAll($select);
    $values['network_id'] = $oldNetworks = array();
    foreach( $networks as $network ) {
      $values['network_id'][] = $oldNetworks[] = $network->getIdentity();
    }

    // Populate form
    $form->populate($values);
    
    // Check method/valid
    if( !$this->getRequest()->isPost() ) {
      return;
    }
    if( !$form->isValid($this->getRequest()->getPost()) ) {
      return;
    }

    $values = $form->getValues();

    // Check password validity
    if( empty($values['password']) && empty($values['password_conf']) ) {
      unset($values['password']);
      unset($values['password_conf']);
    } else if( $values['password'] != $values['password_conf'] ) {
      return $form->getElement('password')->addError('Passwords do not match.');
    } else {
      unset($values['password_conf']);
    }

    // Process
    $oldValues = $user->toArray();

    // Set new network
    $userNetworks = $values['network_id'];
    unset($values['network_id']);
    if($userNetworks == NULL) { $userNetworks = array(); }
    $joinIds = array_diff($userNetworks, $oldNetworks);
    foreach( $joinIds as $id ) {
      $network = Engine_Api::_()->getItem('network', $id);
      $network->membership()->addMember($user)
          ->setUserApproved($user)
          ->setResourceApproved($user);
    }
    $leaveIds = array_diff($oldNetworks, $userNetworks);
    foreach( $leaveIds as $id ) {
      $network = Engine_Api::_()->getItem('network', $id);
      if( !is_null($network) ){
        $network->membership()->removeMember($user);
      }
    }

    // Check for null usernames
    if ($values['username'] == '') {     
        // If value is "NULL", then set to zend Null
        $values['username'] = new Zend_Db_Expr("NULL");         
    }
    
    $user->setFromArray($values);
    $user->save();
    
    
     $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($user); 

    	if( !empty($fieldsByAlias['profile_type']) )
			{
			  $optionId = $fieldsByAlias['profile_type']->getValue($user);
			  $profile_type_id = $optionId->value; 
			}
    
   
    if($profile_type_id == 1){
	  
		$fieldsTable = Engine_Api::_()->fields()->getTable('user', 'values');
		$verifyRow = $fieldsTable->fetchRow($fieldsTable->select()->where('item_id = '.$id.' AND field_id = 16'));
		
		if($verifyRow	!=	'')
		{
			$where = array(
					'item_id = ?' => $id,
					'field_id = ?' => 16
				);
			 $fieldsTable->update(array('value' =>$values['creditscore']),$where);
		}
		else
		{
			$fieldvalues = Engine_Api::_()->fields()->getFieldsValues($user);
			$valueRow = $fieldvalues->createRow();
			$valueRow->field_id = 16;
			$valueRow->item_id = $id;
			$valueRow->value = $values['creditscore'];
			$valueRow->save();
		}
	}


    // Send a notification that the account has been approved
    if( !$oldValues['enabled'] && $values['enabled'] ) {
      Engine_Api::_()->getApi('mail', 'core')->sendSystem($user, 'user_account_approved', array(
        'host' => $_SERVER['HTTP_HOST'],
        'email' => $user->email,
        'date' => time(),
        'recipient_title' => $user->getTitle(),
        'recipient_link' => $user->getHref(),
        'recipient_photo' => $user->getPhotoUrl('thumb.icon'),
        'object_link' => Zend_Controller_Front::getInstance()->getRouter()->assemble(array(), 'user_login', true),
      ));
      // Send hook to add activity
      Engine_Hooks_Dispatcher::getInstance()
          ->callEvent('onUserEnable', $user);
    } else if( $oldValues['enabled'] && !$values['enabled'] ) {
      // @todo ?
    }

    
    // Forward
    return $this->_forward('success', 'utility', 'core', array(
      'smoothboxClose' => true,
      'parentRefresh' => true,
      'format'=> 'smoothbox',
      'messages' => array('Your changes have been saved.')
    ));
  }

  public function deleteAction()
  {
    $id = $this->_getParam('id', null);
    $this->view->user = $user = Engine_Api::_()->getItem('user', $id);
    $this->view->form = $form = new User_Form_Admin_Manage_Delete();
    // deleting user
    //$form->user_id->setValue($id);

    if( $this->getRequest()->isPost() ) {
      $db = Engine_Api::_()->getDbtable('users', 'user')->getAdapter();
      $db->beginTransaction();

      try {
        $user->delete();
        
        
        Engine_Db_Table::getDefaultAdapter()->delete('engine4_dropbox_log', array('subject_id = ?'=>$id) );
        Engine_Db_Table::getDefaultAdapter()->delete('engine4_property_list', array('property_owner_id = ?'=>$id) );
        Engine_Db_Table::getDefaultAdapter()->delete('engine4_property_request', array('landlord_id = ?'=>$id) );
        Engine_Db_Table::getDefaultAdapter()->delete('engine4_property_request', array('tenant_id = ?'=>$id) );
        Engine_Db_Table::getDefaultAdapter()->delete('engine4_property_granted', array('landlord_id	 = ?'=>$id) );
        Engine_Db_Table::getDefaultAdapter()->delete('engine4_property_granted', array('tenant_id  = ?'=>$id) );
        Engine_Db_Table::getDefaultAdapter()->delete('engine4_rating_questionsvalue', array('subject_id	= ?'=>$id) );
        Engine_Db_Table::getDefaultAdapter()->delete('engine4_rating_questionsvalue', array('object_id	= ?'=>$id) );
        Engine_Db_Table::getDefaultAdapter()->delete('engine4_rating_value', array('subject_id = ?'=>$id) );
        Engine_Db_Table::getDefaultAdapter()->delete('engine4_rating_value', array('object_id = ?'=>$id) );
        Engine_Db_Table::getDefaultAdapter()->delete('engine4_property_requirement', array('tenant_id	 = ?'=>$id) );
        Engine_Db_Table::getDefaultAdapter()->delete('engine4_property_viewlog', array('user_id	 = ?'=>$id) );
        Engine_Db_Table::getDefaultAdapter()->delete('engine4_meeting_scheduler', array('scheduled_by	 = ?'=>$id) );
        Engine_Db_Table::getDefaultAdapter()->delete('engine4_meeting_scheduler', array('scheduled_with	 = ?'=>$id) );
        Engine_Db_Table::getDefaultAdapter()->delete('engine4_report_share', array('report_shared_by	 = ?'=>$id) );
        Engine_Db_Table::getDefaultAdapter()->delete('engine4_report_share', array('report_shared_with	 = ?'=>$id) );
        Engine_Db_Table::getDefaultAdapter()->delete('engine4_report_request', array('renter_id	 = ?'=>$id) );
        Engine_Db_Table::getDefaultAdapter()->delete('engine4_report_request', array('landlord_id	 = ?'=>$id) );
        Engine_Db_Table::getDefaultAdapter()->delete('engine4_post_comments', array('posterId	 = ?'=>$id) );
        
        $db->commit();
      } catch( Exception $e ) {
        $db->rollBack();
        throw $e;
      }
      
      return $this->_forward('success', 'utility', 'core', array(
        'smoothboxClose' => true,
        'parentRefresh' => true,
        'format'=> 'smoothbox',
        'messages' => array('This member has been successfully deleted.')
      ));
    }
  }

  public function loginAction()
  {
    $id = $this->_getParam('id');
    $user = Engine_Api::_()->getItem('user', $id);
    
    // @todo change this to look up actual superadmin level
    if( $user->level_id == 1 || !$this->getRequest()->isPost() ) {
      if( null === $this->_helper->contextSwitch->getCurrentContext() ) {
        return $this->_helper->redirector->gotoRoute(array('action' => 'index', 'id' => null));
      } else {
        $this->view->status = false;
        $this->view->error = true;
        return;
      }
    }

    // Login
    Zend_Auth::getInstance()->getStorage()->write($user->getIdentity());

    // Redirect
    if( null === $this->_helper->contextSwitch->getCurrentContext() ) {
      return $this->_helper->redirector->gotoRoute(array(), 'default', true);
    } else {
      $this->view->status = true;
      return;
    }
  }

  public function statsAction()
  {
    $id = $this->_getParam('id', null);
    $this->view->user = $user = Engine_Api::_()->getItem('user', $id);

    $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($user);

    if( !empty($fieldsByAlias['profile_type']) ) {
      $optionId = $fieldsByAlias['profile_type']->getValue($user);
      if( $optionId ) {
        $optionObj = Engine_Api::_()->fields()
          ->getFieldsOptions($user)
          ->getRowMatching('option_id', $optionId->value);
        if( $optionObj ) {
          $this->view->memberType = $optionObj->label;
        }
      }
    }

    // Networks
    $select = Engine_Api::_()->getDbtable('membership', 'network')->getMembershipsOfSelect($user)
      ->where('hide = ?', 0);
    $this->view->networks = Engine_Api::_()->getDbtable('networks', 'network')->fetchAll($select);

    // Friend count
    $this->view->friendCount = $user->membership()->getMemberCount($user);
  }
  
  
    public function addcountryAction(){

	  
	  $this->view->form = $form = new User_Form_Admin_Manage_AddCountry();
	  $aData	=  $this->_request->getPost();	  
	  $country	=	$aData['country'];
	  
	  if($country !=''){
	  
	    $country_table =  Engine_Api::_()->getDbtable('countries', 'user'); 
	    $country_table_insert_id =  $country_table->insert(array(
                    'country' => $country,                   
                ));
      }
      
  }
  
  public function addstateAction(){

	  
	  $this->view->form = $form = new User_Form_Admin_Manage_AddState();
	  
	  $aData	=  $this->_request->getPost();
	  
	  $country	=	$aData['country'];
	  $state	=	$aData['state'];
	  
	  if($country !='' && $state != ''){
	  
	    $country_table =  Engine_Api::_()->getDbtable('countries', 'user'); 
	    $state_table   =  Engine_Api::_()->getDbtable('state', 'user'); 
	    
	    $state_table_insert_id =  $state_table->insert(array(
                    'country_id' => $country,                                     
                    'state'      => $state,                   
                ));
                
      }
      
  }
  
    public function addcityAction(){

	  
	  $this->view->form = $form = new User_Form_Admin_Manage_AddCity();
      $uri = Zend_Controller_Front::getInstance()->getRequest()->getRequestUri();
      $this->view->basePath	=	dirname($uri);
	  $aData	=  $this->_request->getPost();
	  
	  $country	=	$aData['country'];
	  $state	=	$aData['state'];
	  $city	=	$aData['city'];
	  
	  if($country !='' && $state != '' && $city != ''){
	  
	    $country_table =  Engine_Api::_()->getDbtable('countries', 'user'); 
	    $city_table   =  Engine_Api::_()->getDbtable('city', 'user'); 
	    
	    $state_table_insert_id =  $city_table->insert(array(
                    'country_id' => $country,                                     
                    'state_id'      => $state,    
                    'city'      => $city,               
                ));
                
      }
      
  }
  
    public function getstatesAction(){
		
	  $this->_helper->layout->disableLayout();
	  $this->_helper->viewRenderer->setNoRender(true);
		 //header("Content-Type: application/json");
	  $aResult	=	array();
	  $id	=	$this->_getParam('countryId');
	  $state_table   =  Engine_Api::_()->getDbtable('state', 'user');
	  $state_list = $state_table->fetchAll(array(
      'country_id = ?' => $id,
    )); 
    $i=0;
    foreach($state_list as $list)
    {
		$aResult[$i]['id']	=	$list['state_id'];
		$aResult[$i]['state']	=	$list['state'];
		$i++;
	}
    echo json_encode($aResult);
	}
  	
    public function countrylistAction(){ 
		
		$this->view->formFilter = $formFilter = new User_Form_Admin_Manage_Countryfilter();	

        $page = $this->_getParam('page', 1); 
        
         // Process form
		$values = array();
		if( $formFilter->isValid($this->_getAllParams()) ) {
		  $values = $formFilter->getValues();
		}
        
        foreach( $values as $key => $value ) {
		if( null === $value ) {
			unset($values[$key]);
		  }
		}

		$values = array_merge(array(
		  'order' => 'id',
		  'order_direction' => 'DESC',
		), $values);
		
		$this->view->assign($values);
		
        
        $country_table =  Engine_Api::_()->getDbtable('countries', 'user'); 

        $select = $country_table->getAdapter()->select()
						->from(array('country'=>'engine4_country_list',));
						// ->query()->fetchAll();
						 
		 $select->order(( !empty($values['order']) ? $values['order'] : 'id' ) . ' ' . ( !empty($values['order_direction']) ? $values['order_direction'] : 'DESC' ));

			if( !empty($values['countryname']) ) {
			  $select->where('country LIKE ?', '%' . $values['countryname'] . '%');
			}
		
		
    	 $valuesCopy = array_filter($values);				 
						  
		 $page = $this->_getParam('page', 1);
		 
	$this->view->paginator = $paginator = Zend_Paginator::factory($select);
    $this->view->paginator = $paginator->setCurrentPageNumber( $page );
    $this->view->paginator = $paginator->setItemCountPerPage(20);
    $this->view->formValues = $valuesCopy; 
   
      //echo '<pre>'; print_r($oData); exit;
     $this->renderScript('admin-manage/countrylist.tpl');				
	}
	
	public function editcountryAction()
    {
    $id = $this->_getParam('id', null);
    $this->view->form = $form = new User_Form_Admin_Manage_Editcountry(array(
      'countryIdentity' => $id,
    ));
    
     // Check method/valid
    if( !$this->getRequest()->isPost() ) {
      return;
    }
    if( !$form->isValid($this->getRequest()->getPost()) ) {
      return;
    }

    $values = $form->getValues();
    $country_table =  Engine_Api::_()->getDbtable('countries', 'user'); 
    $country_table->update(array('country' =>$values['country']),array('id = ?' => $values['cid']));
    
     // Forward
    return $this->_forward('success', 'utility', 'core', array(
      'smoothboxClose' => true,
      'parentRefresh' => true,
      'format'=> 'smoothbox',
      'messages' => array('Your changes have been saved.')
    ));
    
    }
	  
	public function deletecountryAction()
    {
    $id = $this->_getParam('id', null);
    $this->view->form = $form = new User_Form_Admin_Manage_Deleteitem();
    if( $this->getRequest()->isPost() ) {

      try {
         Engine_Db_Table::getDefaultAdapter()->delete('engine4_country_list', array('id = ?'=>$id) );
         Engine_Db_Table::getDefaultAdapter()->delete('engine4_state_list', array('country_id = ?'=>$id) );
         Engine_Db_Table::getDefaultAdapter()->delete('engine4_city_list', array('country_id = ?'=>$id) );
        
       
      } catch( Exception $e ) {
        throw $e;
      }
      
      return $this->_forward('success', 'utility', 'core', array(
        'smoothboxClose' => true,
        'parentRefresh' => true,
        'format'=> 'smoothbox',
        'messages' => array('This country has been successfully deleted.')
      ));
     }  

    }  
    public function statelistAction(){ 
		
		$this->view->formFilter = $formFilter = new User_Form_Admin_Manage_Statefilter();	

        $page = $this->_getParam('page', 1); 
        
         // Process form
		$values = array();
		if( $formFilter->isValid($this->_getAllParams()) ) {
		  $values = $formFilter->getValues();
		}
        
        foreach( $values as $key => $value ) {
		if( null === $value ) {
			unset($values[$key]);
		  }
		}

		$values = array_merge(array(
		  'order' => 'id',
		  'order_direction' => 'DESC',
		), $values);
		
		$this->view->assign($values);
		
		
		

        $page = $this->_getParam('page', 1); 
        
        $country_table =  Engine_Api::_()->getDbtable('countries', 'user'); 
        $state_table =  Engine_Api::_()->getDbtable('state', 'user'); 

        $select = $country_table->getAdapter()->select()
						->from(array('country'=>'engine4_country_list',array('country')))
						->join(array('state'=>'engine4_state_list',),'state.country_id=country.id',array('country_id','state_id','state'));
						//->query()->fetchAll(); //echo '<pre>'; print_r($oData); exit;
    
    $select->order(( !empty($values['order']) ? $values['order'] : 'id' ) . ' ' . ( !empty($values['order_direction']) ? $values['order_direction'] : 'DESC' ));

			if( !empty($values['countryname']) ) {
			  $select->where('country LIKE ?', '%' . $values['countryname'] . '%');
			}
			if( !empty($values['statename']) ) {
			  $select->where('state LIKE ?', '%' . $values['statename'] . '%');
			}
		
		
    $valuesCopy = array_filter($values);	
		 
	$this->view->paginator = $paginator = Zend_Paginator::factory($select);
    $this->view->paginator = $paginator->setCurrentPageNumber( $page );
    $this->view->paginator = $paginator->setItemCountPerPage(20);
    $this->view->formValues = $valuesCopy; 
   
      //echo '<pre>'; print_r($oData); exit;
     $this->renderScript('admin-manage/statelist.tpl');				
	}
	  
    public function editstateAction()
    {
    $country_id = $this->_getParam('cid', null);
    $state_id   = $this->_getParam('sid', null);
    $this->view->form = $form = new User_Form_Admin_Manage_Editstate(array(
      'countryIdentity' => $country_id,
      'stateIdentity' => $state_id,
    ));
   
     // Check method/valid
    if( !$this->getRequest()->isPost() ) {
      return;
    }
    if( !$form->isValid($this->getRequest()->getPost()) ) {
      return;
    }

    $values = $form->getValues();
    $country_table =  Engine_Api::_()->getDbtable('state', 'user'); 
    $country_table->update(array('state' =>$values['state']),array('state_id = ?' => $values['sid']));
    
     // Forward
    return $this->_forward('success', 'utility', 'core', array(
      'smoothboxClose' => true,
      'parentRefresh' => true,
      'format'=> 'smoothbox',
      'messages' => array('Your changes have been saved.')
    ));
    
    }
    
    public function deletestateAction()
    {
    $state_id = $this->_getParam('sid', null);
    
    $this->view->form = $form = new User_Form_Admin_Manage_Deleteitem();
    if( $this->getRequest()->isPost() ) {

      try {
         
         Engine_Db_Table::getDefaultAdapter()->delete('engine4_state_list', array('state_id = ?'=>$state_id) );
         Engine_Db_Table::getDefaultAdapter()->delete('engine4_city_list', array('state_id = ?'=>$state_id) );
        
       
      } catch( Exception $e ) {
        throw $e;
      }
      
      return $this->_forward('success', 'utility', 'core', array(
        'smoothboxClose' => true,
        'parentRefresh' => true,
        'format'=> 'smoothbox',
        'messages' => array('This country has been successfully deleted.')
      ));
   }

    } 
    
     public function citylistAction(){ 

		$this->view->formFilter = $formFilter = new User_Form_Admin_Manage_Cityfilter();	

        $page = $this->_getParam('page', 1); 
        
         // Process form
		$values = array();
		if( $formFilter->isValid($this->_getAllParams()) ) {
		  $values = $formFilter->getValues();
		}
        
        foreach( $values as $key => $value ) {
		if( null === $value ) {
			unset($values[$key]);
		  }
		}

		$values = array_merge(array(
		  'order' => 'id',
		  'order_direction' => 'DESC',
		), $values);
		
		$this->view->assign($values);
		
			

        $page = $this->_getParam('page', 1); 
        
        $country_table =  Engine_Api::_()->getDbtable('countries', 'user'); 
        $state_table =  Engine_Api::_()->getDbtable('state', 'user'); 

        $select = $country_table->getAdapter()->select()
						->from(array('country'=>'engine4_country_list',array('country')))
						->join(array('state'=>'engine4_state_list',),'state.country_id=country.id',array('state'))
						->join(array('city'=>'engine4_city_list',),'city.state_id=state.state_id',array('state_id','city_id','city'));
						// ->query()->fetchAll(); //echo '<pre>'; print_r($oData); exit;
		
		$select->order(( !empty($values['order']) ? $values['order'] : 'id' ) . ' ' . ( !empty($values['order_direction']) ? $values['order_direction'] : 'DESC' ));

			if( !empty($values['countryname']) ) {
			  $select->where('country LIKE ?', '%' . $values['countryname'] . '%');
			}
			if( !empty($values['statename']) ) {
			  $select->where('state LIKE ?', '%' . $values['statename'] . '%');
			}
			if( !empty($values['cityname']) ) {
			  $select->where('city LIKE ?', '%' . $values['cityname'] . '%');
			}
		
		
        $valuesCopy = array_filter($values);	

		$page = $this->_getParam('page', 1);
		 
	$this->view->paginator = $paginator = Zend_Paginator::factory($select);
    $this->view->paginator = $paginator->setCurrentPageNumber( $page );
    $this->view->paginator = $paginator->setItemCountPerPage(20);
    $this->view->formValues = $valuesCopy; 
   
      //echo '<pre>'; print_r($oData); exit;
     $this->renderScript('admin-manage/citylist.tpl');				
	} 
	
	public function editcityAction()
    {
    $country_id = $this->_getParam('country_id', null);
    $state_id   = $this->_getParam('sid', null);
    $city_id    = $this->_getParam('city_id', null);
    $this->view->form = $form = new User_Form_Admin_Manage_Editcity(array(
      'countryIdentity' => $country_id,
      'stateIdentity' => $state_id,
      'cityIdentity' => $city_id,
    ));
   
     // Check method/valid
    if( !$this->getRequest()->isPost() ) {
      return;
    }
    if( !$form->isValid($this->getRequest()->getPost()) ) {
      return;
    }

    $values = $form->getValues();
    $city_table =  Engine_Api::_()->getDbtable('city', 'user'); 
    $city_table->update(array('city' =>$values['city']),array('city_id = ?' => $values['city_id']));
    
     // Forward
    return $this->_forward('success', 'utility', 'core', array(
      'smoothboxClose' => true,
      'parentRefresh' => true,
      'format'=> 'smoothbox',
      'messages' => array('Your changes have been saved.')
    ));
    
    }
    
    public function deletecityAction()
    {
    $city_id = $this->_getParam('city_id', null);
    $this->view->form = $form = new User_Form_Admin_Manage_Deleteitem();
    if( $this->getRequest()->isPost() ) {

      try {
         
         Engine_Db_Table::getDefaultAdapter()->delete('engine4_city_list', array('city_id = ?'=>$city_id) );
        
       
      } catch( Exception $e ) {
        throw $e;
      }
      
      return $this->_forward('success', 'utility', 'core', array(
        'smoothboxClose' => true,
        'parentRefresh' => true,
        'format'=> 'smoothbox',
        'messages' => array('This country has been successfully deleted.')
      ));
      
    }

    }
    public function propertylistAction() {
		
		
		$this->view->formFilter = $formFilter = new User_Form_Admin_Manage_Propertyfilter();	

        $page = $this->_getParam('page', 1); 
        

		$propertyTable =  Engine_Api::_()->getDbtable('propertylist', 'user');
		$propertyTableName = $propertyTable->info('name');	
		$country_table =  Engine_Api::_()->getDbtable('countries', 'user'); 
		$country_tableName = $country_table->info('name');	
		$state_table   =  Engine_Api::_()->getDbtable('state', 'user'); 
		$state_tableName = $state_table->info('name');	
		$city_table   =  Engine_Api::_()->getDbtable('city', 'user'); 
		$city_tableName = $city_table->info('name');	
		
		$table = Engine_Api::_()->getItemTable('user');
        $userTableName = $table->info('name');
		

		// Process form
		$values = array();
		if( $formFilter->isValid($this->_getAllParams()) ) {
		  $values = $formFilter->getValues();
		}
        
        foreach( $values as $key => $value ) {
		if( null === $value ) {
			unset($values[$key]);
		  }
		}

		$values = array_merge(array(
		  'order' => 'id',
		  'order_direction' => 'DESC',
		), $values);
		
		$this->view->assign($values);
		
      
       $select = $propertyTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('plist'=>'engine4_property_list',))
                                             
                        ->joinLeft(array('country'=>'engine4_country_list',),'plist.country_id=country.id',array('country'))                       
                        ->joinLeft(array('state'=>'engine4_state_list',),'plist.state_id=state.state_id',array('state'))                       
                        ->joinLeft(array('city'=>'engine4_city_list',),'plist.city_id=city.city_id',array('city'))
                        ->joinLeft(array('user'=>'engine4_users'),'plist.property_owner_id=user.user_id',array('email','displayname'))                       
                        ->group('plist.id'); 

        
            // Set up select info
    $select->order(( !empty($values['order']) ? $values['order'] : 'id' ) . ' ' . ( !empty($values['order_direction']) ? $values['order_direction'] : 'DESC' ));

    if( !empty($values['propertyname']) ) {
      $select->where('property_name LIKE ?', '%' . $values['propertyname'] . '%');
    }
    if( !empty($values['landlordname']) ) {

         $select->where('displayname LIKE ?', '%' . $values['landlordname'] . '%');
         
    }
    if( !empty($values['rentaltype']) ) {
      $select->where('rental_type LIKE ?', '%' . $values['rentaltype'] . '%');
    }
    if( !empty($values['country']) ) {
      $select->where('country LIKE ?', '%' . $values['country'] . '%');
    }
    if( !empty($values['state']) ) {
      $select->where('state LIKE ?', '%' . $values['state'] . '%');
    }
    if( !empty($values['city']) ) {
      $select->where('city LIKE ?', '%' . $values['city'] . '%');
    }

    // Filter out junk
    $valuesCopy = array_filter($values);

 
        $propertyTable =  Engine_Api::_()->getDbtable('propertylist', 'user');	  
		$propertyimageTable =  Engine_Api::_()->getDbtable('propertyimages', 'user');	

    	$page = $this->_getParam('page', 1);
		 
		$this->view->paginator = $paginator = Zend_Paginator::factory($select);
		$this->view->paginator = $paginator->setCurrentPageNumber( $page );
		$this->view->paginator = $paginator->setItemCountPerPage(20);
		$this->view->formValues = $valuesCopy; 
		$this->renderScript('admin-manage/propertylist.tpl');	
    	
	} 
	
	public function editpropertyAction()
    {
    $pid = $this->_getParam('pid', null);
   
    $this->view->form = $form = new User_Form_Admin_Manage_Editproperty(array(
      'propertyIdentity' => $pid,
    ));
   
     // Check method/valid
    if( !$this->getRequest()->isPost() ) {
      return;
    }
    if( !$form->isValid($this->getRequest()->getPost()) ) {
      return;
    }

    $values = $form->getValues(); 
    $propertyTable =  Engine_Api::_()->getDbtable('propertylist', 'user');	  
    	$propertydata= $propertyTable->fetchRow($propertyTable->select()->where('id = ?',$pid));
    	if($propertydata->first_admin_enable==0)
    	{
    $propertyTable->update(array('enable' =>$values['enabled'],'first_admin_enable' =>1),array('id = ?' => $pid));
        }
      else
       {
	 $propertyTable->update(array('enable' =>$values['enabled']),array('id = ?' => $pid));
       }
     // Forward
    return $this->_forward('success', 'utility', 'core', array(
      'smoothboxClose' => true,
      'parentRefresh' => true,
      'format'=> 'smoothbox',
      'messages' => array('Your changes have been saved.')
    ));
    
    }
    public function deletepropertyAction()
    {
    $pid = $this->_getParam('pid', null);
    $action_id = $this->_getParam('action_id', null);
    $this->view->form = $form = new User_Form_Admin_Manage_Deleteitem();
    if( $this->getRequest()->isPost() ) {

      try {
         
         Engine_Db_Table::getDefaultAdapter()->delete('engine4_property_list', array('id = ?'=>$pid) );
         Engine_Db_Table::getDefaultAdapter()->delete('engine4_property_images', array('property_id = ?'=>$pid) );
         Engine_Db_Table::getDefaultAdapter()->delete('engine4_property_granted', array('property_id = ?'=>$pid) );
         Engine_Db_Table::getDefaultAdapter()->delete('engine4_property_request', array('property_id = ?'=>$pid) );
         Engine_Db_Table::getDefaultAdapter()->delete('engine4_activity_actions', array('action_id = ?'=>$action_id) );
        
       
      } catch( Exception $e ) {
        throw $e;
      }
      
      return $this->_forward('success', 'utility', 'core', array(
        'smoothboxClose' => true,
        'parentRefresh' => true,
        'format'=> 'smoothbox',
        'messages' => array('This property has been successfully deleted.')
      ));
    }

    }
    
    public function propertyrequestlistAction() {
		
		
		$this->view->formFilter = $formFilter = new User_Form_Admin_Manage_Propertyrequestfilter();	

        $page = $this->_getParam('page', 1); 
        
        // Process form
		$values = array();
		if( $formFilter->isValid($this->_getAllParams()) ) {
		  $values = $formFilter->getValues();
		}
        
        foreach( $values as $key => $value ) {
		if( null === $value ) {
			unset($values[$key]);
		  }
		}

		$values = array_merge(array(
		  'order' => 'id',
		  'order_direction' => 'DESC',
		), $values);
		
		$this->view->assign($values);
        
        
        
        $propertyRequestTable =  Engine_Api::_()->getDbtable('propertyrequest', 'user');	
	    $select = $propertyRequestTable->select()
		                      ->setIntegrityCheck(false)
		                       ->from(array('prequest'=>'engine4_property_request',)) 
		                       ->joinLeft(array('plist'=>'engine4_property_list',),'plist.id=prequest.property_id',array('property_name'))   
		                       ->joinLeft(array('user'=>'engine4_users',),'prequest.tenant_id=user.user_id',array('displayname'))
		                       ->where('plist.granted	 = ?', 0);
		//$propertyRequest = $propertyRequestTable->fetchAll($propertyReq_select);
		
		
		 $select->order(( !empty($values['order']) ? $values['order'] : 'id' ) . ' ' . ( !empty($values['order_direction']) ? $values['order_direction'] : 'DESC' ));

			if( !empty($values['propertyname']) ) {
			  $select->where('property_name LIKE ?', '%' . $values['propertyname'] . '%');
			}
			if( !empty($values['tenantname']) ) {
				 $select->where('displayname LIKE ?', '%' . $values['tenantname'] . '%');				 
			}
			if( !empty($values['landlord_approve']) ) {
			  $select->where('landlord_approve LIKE ?', '%' . $values['landlord_approve'] . '%');
			}
			if( !empty($values['admin_approve']) ) {
			  $select->where('admin_approve LIKE ?', '%' . $values['admin_approve'] . '%');
			}
		
    	 $valuesCopy = array_filter($values);
    	
    	$page = $this->_getParam('page', 1);
		 
		$this->view->paginator = $paginator = Zend_Paginator::factory($select);
		$this->view->paginator = $paginator->setCurrentPageNumber( $page );
		$this->view->paginator = $paginator->setItemCountPerPage(20);
		$this->view->formValues = $valuesCopy; 
		$this->renderScript('admin-manage/propertyrequestlist.tpl');	
    	
	}
	
	public function editpropertyrequestAction()
    {
     $request_id = $this->_getParam('id', null); 
   
    $this->view->form = $form = new User_Form_Admin_Manage_Editpropertyrequest(array(
      'propertyreqIdentity' => $request_id,
    ));
   
     // Check method/valid
    if( !$this->getRequest()->isPost() ) {
      return;
    }
    if( !$form->isValid($this->getRequest()->getPost()) ) {
      return;
    }

    $values = $form->getValues(); 
    $propertyreqTable =  Engine_Api::_()->getDbtable('propertyrequest', 'user');	  
    $propertyreqTable->update(array('admin_approve' =>$values['enabled'],'admin_approve_date' =>date("Y-m-d")),array('id = ?' => $request_id));
    
     // Forward
    return $this->_forward('success', 'utility', 'core', array(
      'smoothboxClose' => true,
      'parentRefresh' => true,
      'format'=> 'smoothbox',
      'messages' => array('Your changes have been saved.')
    ));
    
    }
    
    public function deletepropertyrequestAction()
    {
    $id = $this->_getParam('id', null);
    $this->view->form = $form = new User_Form_Admin_Manage_Deleteitem();
    if( $this->getRequest()->isPost() ) {
      try {
         
         Engine_Db_Table::getDefaultAdapter()->delete('engine4_property_request', array('id = ?'=>$id) );
        
       
      } catch( Exception $e ) {
        throw $e;
      }
      
      return $this->_forward('success', 'utility', 'core', array(
        'smoothboxClose' => true,
        'parentRefresh' => true,
        'format'=> 'smoothbox',
        'messages' => array('This property request has been successfully deleted.')
      ));
    }  

    }
    
    public function createcoverletterAction(){

	  
	  $this->view->form = $form = new User_Form_Admin_Manage_Createcoverletter();
	  
	  $aData	=  $this->_request->getPost();
	  
	  $cover_title	=	$aData['cover_title'];
	  $content	=	$aData['content'];
	  
	  if($cover_title !='' && $content!=''){
	  
	    $coverletter_table =  Engine_Api::_()->getDbtable('coverletter', 'user'); 
	    $coverletter_table_insert_id =  $coverletter_table->insert(array(
                    'title'   => $cover_title,                   
                    'content' => $content,  
                    'status'  =>'default',
                    'create_at'=> date("Y-m-d"),
                    
                ));
      }
    }
      
    public function coverletterlistAction(){ 
		
		$this->view->formFilter = $formFilter = new User_Form_Admin_Manage_Coverletterfilter();	

        $page = $this->_getParam('page', 1); 
        
         // Process form
		$values = array();
		if( $formFilter->isValid($this->_getAllParams()) ) {
		  $values = $formFilter->getValues();
		}
        
        foreach( $values as $key => $value ) {
		if( null === $value ) {
			unset($values[$key]);
		  }
		}

		$values = array_merge(array(
		  'order' => 'id',
		  'order_direction' => 'DESC',
		), $values);
		
		$this->view->assign($values);	

        $page = $this->_getParam('page', 1); 
        
        $coverletter_table =  Engine_Api::_()->getDbtable('coverletter', 'user'); 

        $select = $coverletter_table->getAdapter()->select()
						->from(array('cover'=>'engine4_cover_letter',))
						->where('cover.status = ?', 'default');
						//->query()->fetchAll(); 
						
		$select->order(( !empty($values['order']) ? $values['order'] : 'id' ) . ' ' . ( !empty($values['order_direction']) ? $values['order_direction'] : 'DESC' ));

			if( !empty($values['title']) ) {
			  $select->where('title LIKE ?', '%' . $values['title'] . '%');
			}
		
		
    	 $valuesCopy = array_filter($values);					
						
		$page = $this->_getParam('page', 1);
		 
	$this->view->paginator = $paginator = Zend_Paginator::factory($select);
    $this->view->paginator = $paginator->setCurrentPageNumber( $page );
    $this->view->paginator = $paginator->setItemCountPerPage(20);
    $this->view->formValues = $valuesCopy; 
   
   
      //echo '<pre>'; print_r($oData); exit;
     $this->renderScript('admin-manage/coverletterlist.tpl');				
	}
	  
	public function editcoverletterAction()
    {
    $id = $this->_getParam('id', null);
    $this->view->form = $form = new User_Form_Admin_Manage_Editcoverletter(array(
      'coverletterIdentity' => $id,
    ));
    
     // Check method/valid
    if( !$this->getRequest()->isPost() ) {
      return;
    }
    if( !$form->isValid($this->getRequest()->getPost()) ) {
      return;
    }

    $values = $form->getValues();
    $coverletter_table =  Engine_Api::_()->getDbtable('coverletter', 'user'); 
    $coverletter_table->update(array('title' =>$values['title'],'content' =>$values['content']),array('id = ?' => $id));
    
     // Forward
    return $this->_forward('success', 'utility', 'core', array(
      'smoothboxClose' => true,
      'parentRefresh' => true,
      'format'=> 'smoothbox',
      'messages' => array('Your changes have been saved.')
    ));
    
    } 
      
    public function deletecoverletterAction()
    {
    $id = $this->_getParam('id', null);
    $this->view->form = $form = new User_Form_Admin_Manage_Deleteitem();
    if( $this->getRequest()->isPost() ) {
    
      try {
         
         Engine_Db_Table::getDefaultAdapter()->delete('engine4_cover_letter', array('id = ?'=>$id) );
        
       
      } catch( Exception $e ) {
        throw $e;
      }
      
      return $this->_forward('success', 'utility', 'core', array(
        'smoothboxClose' => true,
        'parentRefresh' => true,
        'format'=> 'smoothbox',
        'messages' => array('This property request has been successfully deleted.')
      ));
      
     }

    }
    
    public function getFieldValueString($field, $value, $subject, $map = null,
      $partialStructure = null)
  {
    if( (!is_object($value) || !isset($value->value)) && !is_array($value) ) {
      return null;
    }
    
    // @todo This is not good practice:
    // if($field->type =='textarea'||$field->type=='about_me') $value->value = nl2br($value->value);

    $helperName = Engine_Api::_()->fields()->getFieldInfo($field->type, 'helper');
    if( !$helperName ) {
      return null;
    }

    $helper = $this->view->getHelper($helperName);
    if( !$helper ) {
      return null;
    }

    $helper->structure = $partialStructure;
    $helper->map = $map;
    $helper->field = $field;
    $helper->subject = $subject;
    $tmp = $helper->$helperName($subject, $field, $value);
    unset($helper->structure);
    unset($helper->map);
    unset($helper->field);
    unset($helper->subject);
    
    return $tmp;
  }
  public function userinfoAction()
  {
	  
	
    $id = $this->_getParam('id', null);
    $this->view->user = $user = Engine_Api::_()->getItem('user', $id);  
     $view = $this->view;
    $view->addHelperPath(APPLICATION_PATH . '/application/modules/Fields/View/Helper', 'Fields_View_Helper');

    // Values
    $this->view->fieldStructure = $fieldStructure = Engine_Api::_()->fields()->getFieldsStructurePartial($user);
    if( count($fieldStructure) <= 1 ) { // @todo figure out right logic
      return $this->setNoRender();
    }
    echo $view->fieldValueLoop($user, $fieldStructure,$stat = 1); 
    exit;
    
	  
  }
  
    public function documentsAction(){
		
		$this->view->formFilter = $formFilter = new User_Form_Admin_Manage_Documentfilter();	
		
		   // Process form
		$values = array();
		if( $formFilter->isValid($this->_getAllParams()) ) {
		  $values = $formFilter->getValues();
		}
        
        foreach( $values as $key => $value ) {
		if( null === $value ) {
			unset($values[$key]);
		  }
		}

		$values = array_merge(array(
		  'order' => 'id',
		  'order_direction' => 'DESC',
		), $values);
		
		$this->view->assign($values);

		$dropboxlogTable = Engine_Api::_()->getDbtable('dropboxlog', 'user');	

        $select = $dropboxlogTable->getAdapter()->select()
						->from(array('dropboxlog'=>'engine4_dropbox_log',))
						->joinLeft(array('user'=>'engine4_users',),'dropboxlog.subject_id = user.user_id',array('displayname'))   
					    ->where('dropboxlog.action = ?', 'root folder created');
						// ->query()->fetchAll();
						 
		 $select->order(( !empty($values['order']) ? $values['order'] : 'id' ) . ' ' . ( !empty($values['order_direction']) ? $values['order_direction'] : 'DESC' ));

			if( !empty($values['documentowner']) ) {
			  $select->where('displayname LIKE ?', '%' . $values['documentowner'] . '%');
			}
		
		
    	 $valuesCopy = array_filter($values);	
	
				  
    $page = $this->_getParam('page', 1);
		 
	$this->view->paginator = $paginator = Zend_Paginator::factory($select);
    $this->view->paginator = $paginator->setCurrentPageNumber( $page );
    $this->view->paginator = $paginator->setItemCountPerPage(20);
    $this->view->formValues = $valuesCopy; 
		

   
      //echo '<pre>'; print_r($oData); exit;
     $this->renderScript('admin-manage/documents.tpl');	
	  

    }
    public function documentlistAction(){
	
    $id = $this->_getParam('id', null); 
    
    $userTable = Engine_Api::_()->getDbtable('users', 'user');
	$user = $userTable->fetchRow($userTable->select()->where('user_id = ?',$id));
	
	$this->view->root_dir = $dirname =   $user->user_id.'_'.$user->displayname;  
			
	$dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dirname;
	if (is_dir($dir)) {
		
		$files =	$this->loaddirectory($dir);
		
		   $dropboxfileTable = Engine_Api::_()->getDbtable('dropboxfiles', 'user');
			
		   foreach($files['files'] as $file){
				   
				   $doc_path = $dirname.'/'.$file['filename']; 
				   $dropboxfileData = $dropboxfileTable->fetchRow($dropboxfileTable->select()->where('file_path = ?', $doc_path)); 	 
								
				 $tmpArrayFile[]	=	array('file_id'=>$dropboxfileData->id,'filename'=>$file['filename'],'file_title'=>$dropboxfileData->file_title,'file_owner_id'=> $dropboxfileData->file_owner_id,'file_path'=> $dropboxfileData->file_path,'created_at'=> $dropboxfileData->created_at);  
		   
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
	
	
		// member type 
	
    $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($user); 
    if( !empty($fieldsByAlias['profile_type']) )
    {
      $optionId = $fieldsByAlias['profile_type']->getValue($user);
      $this->view->profiletype = $profile_type_id = $optionId->value; 
    }
	
	
	
	$propertyRequestTable =  Engine_Api::_()->getDbtable('propertyrequest', 'user');	
   
   $userTable = Engine_Api::_()->getDbtable('users', 'user');
   

   
    if($profile_type_id == 1){ //tenant
   
    $propertyReq_select = $propertyRequestTable->select()
		                      ->setIntegrityCheck(false)
		                       ->from(array('prequest'=>'engine4_property_request',))  
		                       ->joinLeft(array('user'=>'engine4_users',),'prequest.landlord_id=user.user_id',array('displayname'))   
					           ->where('prequest.tenant_id = ?', $id)
					           ->where('prequest.landlord_approve	 = ?', 1)
					           ->order('prequest.id DESC');
					           
			           
   
    $propertyRequest = $propertyRequestTable->fetchAll($propertyReq_select);
		
	$this->view->requestApprovedLandlords = $propertyRequest; // property requested by tenant and approved landlords data
    }
    if($profile_type_id == 4){ //landlord
		
		    $propertyReq_select = $propertyRequestTable->select()
		                      ->setIntegrityCheck(false)
		                       ->from(array('prequest'=>'engine4_property_request',))  
		                       ->joinLeft(array('user'=>'engine4_users',),'prequest.tenant_id=user.user_id',array('displayname'))   
					           ->where('prequest.landlord_id = ?', $id)
					           ->where('prequest.landlord_approve	 = ?', 1)
					           ->order('prequest.id DESC');
		
	$propertyRequest = $propertyRequestTable->fetchAll($propertyReq_select);
	$this->view->propertyRequestedTenants = $propertyRequest;	

	}
	if($profile_type_id == 6){
		
		
	$selectUsers = $userTable->getAdapter()->select()
						->from(array('user'=>'engine4_users'))
						->where('user.user_id	 != ?', $id)								
						->query()->fetchAll();
    $this->view->allusers=  $selectUsers;	
		
		
		
	}
	//fetch services
	
	$selectservices = $userTable->getAdapter()->select()
						->from(array('user'=>'engine4_users'))	
						->where('user.level_id = ?', 8)					
						->query()->fetchAll();
    $this->view->allservices=  $selectservices;	
	
	 $this->view->username = $user->displayname;
	 $this->view->userid = $user->user_id;
	 $this->renderScript('admin-manage/documentlist.tpl');	
		
	}
	
	public function loaddirectory($path) { 
		

			$files = scandir($path);
			$files = array_diff($files, array('.', '..')); 
			$files = array_values($files);
			$tmpResultData= array();
			$tmpArrayFile= array();
			$tmpArrayDir= array();
			$resultData= array();
		
		for($i=0;$i<count($files);$i++){

			if (is_dir($path.'/'.$files[$i])) {
				
				$tmpArrayDir[]	=	array('dirname'=>$files[$i]);
			}
			else{
				
				$tmpArrayFile[]	=	array('filename'=>$files[$i]);
			}
			
		}
			
		$tmpResultData['directories'] = $tmpArrayDir;
		$tmpResultData['files'] = $tmpArrayFile;
		$resultData = array_merge($resultData,$tmpResultData);
		return $resultData;
		
	}
	
		public function getdirectorycontentsAction(){
		
		$this->_helper->viewRenderer->setNoRender(true);
		$this->_helper->layout->disableLayout();
 
 
		$viewer     = Engine_Api::_()->user()->getViewer();
		
		
		$aData = $this->_request->getPost(); 
		$dirname	            =	$aData['dirname'];
	    $current_directory	    =	$aData['current_directory'];
	   // $user_id	    =	$aData['user_id'];
	    $menu_open	    =	$aData['menu_open'];
	   
	   // $userTable = Engine_Api::_()->getDbtable('users', 'user');
	   // $user = $userTable->fetchRow($userTable->select()->where('user_id = ?',$user_id));
	 
		//$user_dir =   $user_id.'_'.$user->displayname; 
		$user_dir        =   $aData['root_dir']; 
	
		if($current_directory == ''){
	
			if($menu_open == 0){
			$dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$user_dir.'/'.$dirname;
		}
		else{
		$dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$user_dir.'/'.$current_directory.'/'.$dirname;
	    }
	    $file_path = '/filemanager/'.$user_dir.'/'.$current_directory.'/'.$dirname.'/';
		$doc_path =  $user_dir.$current_directory.'/'.$dirname.'/';
	    }
	
        else{
			
	    
		if($menu_open == 0){
		$dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$user_dir.'/'.$current_directory.'/'.$dirname;
	    }
		else{
			$dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$user_dir.$current_directory;
		}
		$file_path = '/filemanager/'.$user_dir.'/'.$current_directory.'/'.$dirname.'/';
		if($menu_open == 0){
		$doc_path =  $user_dir.$current_directory.'/'.$dirname.'/';
	    }
	    else{
			$doc_path =  $user_dir.$current_directory.'/';
		}
	    }
		
		
		$files =	$this->loaddirectory($dir);
	
		
		 $dropboxfileTable = Engine_Api::_()->getDbtable('dropboxfiles', 'user');
    
        foreach($files['files'] as $file){
		
		   $doc_path1 = $doc_path.$file['filename']; 
		   $dropboxfileData = $dropboxfileTable->fetchRow($dropboxfileTable->select()->where('file_path LIKE ?', $doc_path1.'%')); 	 
				
		   $tmpArrayFile[]	=	array('file_id'=>$dropboxfileData->id,'filename'=>$file['filename'],'file_title'=>$dropboxfileData->file_title,'file_owner_id'=> $dropboxfileData->file_owner_id,'file_path'=> $dropboxfileData->file_path,'created_at'=> $dropboxfileData->created_at);  

	    }
		
		$tmpResultData['directories'] = $files['directories'];
		$tmpResultData['files'] = $tmpArrayFile; 
		$files = $tmpResultData;
		
	

		$a= '';
		$b= '';
		$i=1;
		 if(count($files['directories'])>0){
		
		foreach($files['directories'] as $dir){ 
		//$a = $a .'<li class="dir_li list'.$i.'" dir-name="'.$dir['dirname'].'"><a href="javascript:void(0)" class="dir_open" dir-name="'.$dir['dirname'].'">'.$dir['dirname'].'</a><span class="option_links"><a href="javascript:void(0)" dir-name="'.$dir['dirname'].'" li-count="'.$i.'" class="dir_share">Share</a> | <a href="javascript:void(0)" class="dir_rename" dir-name="'.$dir['dirname'].'" li-count="'.$i.'">Rename</a> | <a href="javascript:void(0)" class="dir_delete" dir-name="'.$dir['dirname'].'" li-count="'.$i.'">Delete</a></span><hr></li>';
		$a = $a .'<li class="dir_li list'.$i.'" dir-name="'.$dir['dirname'].'"><a href="javascript:void(0)" class="dir_open" dir-name="'.$dir['dirname'].'">'.$dir['dirname'].'</a><span class="option_links"><a href="javascript:void(0)" class="dir_rename" dir-name="'.$dir['dirname'].'" li-count="'.$i.'">Rename  | </a>  <a href="javascript:void(0)" class="dir_delete" dir-name="'.$dir['dirname'].'" li-count="'.$i.'">Delete</a></span><hr></li>';
		 $i++;
		 }
		}
			if(count($files['files'])>0){
		    //$file_path = $_SERVER['HTTP_HOST'].'/filemanager/'.$user_dir.$current_directory.'/'.$dirname.'/'.$dir['filename']; 		
			foreach($files['files'] as $dir){
			$b = $b . '<li class="file_li list'.$i.'" file-name="'.$dir['filename'].'"><a href="javascript:void(0)"  class="file_link" file-id="'.$dir['file_id'].'">'.$dir['file_title'].'</a><span class="option_links"><a href="javascript:void(0)" file-name="'.$dir['filename'].'" li-count="'.$i.'" class="file_share" file-id="'.$dir['file_id'].'">Share  | </a>  <a href="javascript:void(0)" class="file_rename" file-name="'.$dir['filename'].'" li-count="'.$i.'" file-id="'.$dir['file_id'].'">Rename |  </a>  <a href="javascript:void(0)" class="file_delete" file-name="'.$dir['filename'].'" li-count="'.$i.'" file-id="'.$dir['file_id'].'">Delete</a></span><hr></li>';
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
		
		$arr = explode("/",$current_directory);
		$menu ='';
		$arr_i='';
		for($i=0;$i<count($arr);$i++){
			if($i !=0 ){
				$arr_i =$arr_i.'/'.$arr[$i];
			$menu= $menu.'<a href="javascript:void(0)" class="menu_dir_open 55" dir_path ="'.$arr_i.'" > / '.$arr[$i].'</a>';
		}
		}
		if($menu_open == 0){
		$aResult['cur_dir_menu'] = $menu. ' / <a href="javascript:void(0)" class="menu_dir_open" dir_path="'.$current_directory.'/'.$dirname.'">'.$dirname.'</a>' ;
	    }
	    else{
			
		$aResult['cur_dir_menu'] = $menu;
		}
		echo json_encode($aResult);
	
	}
	
	
	   public function createdirectoryAction() {
		
		$this->_helper->viewRenderer->setNoRender(true);
		$this->_helper->layout->disableLayout();
		
		$user_id=Engine_Api::_()->user()->getViewer()->getIdentity(); 
		$viewer     = Engine_Api::_()->user()->getViewer();
		
		
		$aData = $this->_request->getPost(); 
		
		$user_id	    =	$aData['user_id'];
	    
	    $userTable = Engine_Api::_()->getDbtable('users', 'user');
	    $user = $userTable->fetchRow($userTable->select()->where('user_id = ?',$user_id));
		
		
		
		$folder_name	=	$aData['folder_name'];
		$cur_dir	=	$aData['cur_dir'];
		$li_count	=	$aData['li_count']+1;
		$dirname =   $user->user_id.'_'.$user->displayname; 
		if($cur_dir ==''){

		$dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dirname.'/'.$folder_name;
	    }
	   else{
		   
		   $dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dirname.'/'.$cur_dir.'/'.$folder_name;
	   }
		if (!is_dir($dir)) {
				mkdir($dir, 0777, true);
				$aResult['msg'] ='Document is successfully created';
				//$aResult['content'] = '<li class="dir_li list'.$li_count.'" dir-name="'.$folder_name.'"><a href="javascript:void(0)" class="dir_open" dir-name="'.$folder_name.'">'.$folder_name.'</a><span class="option_links"><a href="javascript:void(0)" dir-name="'.$folder_name.'" li-count="'.$li_count.'" class="dir_share">Share</a> | <a href="javascript:void(0)" class="dir_rename" dir-name="'.$folder_name.'" li-count="'.$li_count.'">Rename</a> | <a href="javascript:void(0)" class="dir_delete" dir-name="'.$folder_name.'" li-count="'.$li_count.'">Delete</a></span><hr></li>';
				$aResult['content'] = '<li class="dir_li list'.$li_count.'" dir-name="'.$folder_name.'"><a href="javascript:void(0)" class="dir_open" dir-name="'.$folder_name.'">'.$folder_name.'</a><span class="option_links"><a href="javascript:void(0)" class="dir_rename" dir-name="'.$folder_name.'" li-count="'.$li_count.'">Rename</a> | <a href="javascript:void(0)" class="dir_delete" dir-name="'.$folder_name.'" li-count="'.$li_count.'">Delete</a></span><hr></li>';
		}
		else{
			$aResult['msg'] ='This directory is already existed.';
			$aResult['content'] ='';
		}
	
		
		echo json_encode($aResult);

	}
	
	
	public function savefileAction(){
		
		$viewer     = Engine_Api::_()->user()->getViewer();
		$this->_helper->viewRenderer->setNoRender(true);
		$this->_helper->layout->disableLayout();
		 if( $this->getRequest()->isPost()){
			 
			  $aData = $this->_request->getPost(); 
			  
			$cur_dir = $aData['cur_dir']; 
			$upload_file_title = $aData['upload_file_title']; 
			$user_id = $aData['user_id']; 
			
			 $userTable = Engine_Api::_()->getDbtable('users', 'user');
	         $user = $userTable->fetchRow($userTable->select()->where('user_id = ?',$user_id));
			
			
			$dirname =   $user->user_id.'_'.$user->displayname; 
			
			$random_filename =  $this->random_string(8);
			
			if($cur_dir ==''){

			$dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dirname;
			$filepath = $dirname.'/'. $random_filename; 
			$dir_structure = $dirname;
			}
			else{
				   
			   $dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dirname.$cur_dir; 
			   $filepath = $dirname.$cur_dir.'/'. $random_filename;  
			   $dir_structure = $dirname.$cur_dir;
			}
			  
		    $target_file = $dir .'/'. basename($_FILES["upload_files"]["name"]); 
		    $imageFileType = pathinfo($target_file,PATHINFO_EXTENSION);
		    
		    
		    $random_filename =  $random_filename.'.'.$imageFileType; 
		    
		    $filepath =$filepath.'.'.$imageFileType; 
		    
		    if($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg" && $imageFileType != "pdf" ) {
				
				$aResult['msg'] = "Sorry, only PDF, JPG, JPEG, & PNG  files are allowed.";
				$aResult['status'] = false;
			}
		    else{
				
			$target_file = $dir .'/'. $random_filename; 
		    
			if (move_uploaded_file($_FILES["upload_files"]["tmp_name"], $target_file)) {
				
				$aResult['status'] = $_FILES["upload_files"]["name"];
				$aResult['msg'] = "File is successfully uploaded.";
				
			$dropboxfileTable = Engine_Api::_()->getDbtable('dropboxfiles', 'user');
			

			
			$dropboxfileTableId=   $dropboxfileTable->insert(array(
			
                  'dir_structure' => $dir,
                  'file_path' => $filepath,
                  'file_title' => $upload_file_title,
                  'file_owner_id' => $user_id,
                  'created_at' => date('Y-m-d H:i:s'),
         
                ));
                
                
            $dropboxlogTable = Engine_Api::_()->getDbtable('dropboxlog', 'user');	
			$dropboxlogTableId=   $dropboxlogTable->insert(array(
					
						  'subject_id' => $viewer->getIdentity(),
						  'path' => $dir,
						  'action' => 'file created',
						  'created_at' => date('Y-m-d H:i:s'),
						  'updated_at' => date('Y-m-d H:i:s'),

							
						)); 

				$aResult['status'] = true;
				$aResult['file_id'] = $dropboxfileTableId.'_'.$random_filename;
			} else {
				
				$aResult['status'] = false;
				$aResult['file_id'] = '';

			}
		    }
			echo json_encode($aResult['file_id']);
		//return $this->_helper->redirector->gotoRoute(array('module'=>'user','controller'=>'edit','action' => 'document'), '', true);	  
		 }  
	}
	
	public function deletefileAction(){
		
		$this->_helper->viewRenderer->setNoRender(true);
		$this->_helper->layout->disableLayout();
		
		$user_id=Engine_Api::_()->user()->getViewer()->getIdentity(); 
		$viewer     = Engine_Api::_()->user()->getViewer();
		
		$aData = $this->_request->getPost(); 
		$filename	=	$aData['file_name'];
		$current_directory	=	$aData['current_directory'];
		$file_id	=	$aData['file_id'];
		$user_id	=	$aData['user_id']; 
		
		$userTable = Engine_Api::_()->getDbtable('users', 'user');
	    $user = $userTable->fetchRow($userTable->select()->where('user_id = ?',$user_id));
		
		
		
		$dirname =   $user_id.'_'.$user->displayname; 
		if($current_directory ==''){
		 $dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dirname.'/'.$current_directory.$filename; 
		}
		else{
		 $dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dirname.'/'.$current_directory.'/'.$filename; 
	    }
	    if (file_exists($dir)){
			
			Engine_Db_Table::getDefaultAdapter()->delete('engine4_document_requests', array('file_id = ?' => $file_id) );
			Engine_Db_Table::getDefaultAdapter()->delete('engine4_document_share', array('share_file_id = ?' => $file_id) );
			Engine_Db_Table::getDefaultAdapter()->delete('engine4_dropbox_files', array('id = ?' => $file_id) );
			
			unlink($dir);
			$aResult['msg'] ='This file is succesfully deleted.';	
		} 
        echo json_encode($aResult); 
		
	}
	
		public function deletedirAction(){
		
		$this->_helper->viewRenderer->setNoRender(true);
		$this->_helper->layout->disableLayout();
		
		$user_id=Engine_Api::_()->user()->getViewer()->getIdentity(); 
		$viewer     = Engine_Api::_()->user()->getViewer();
		
		$aData = $this->_request->getPost(); 
		
		$aData = $this->_request->getPost(); 
		$deleteddir_name	=	$aData['dir_name'];
		$current_directory	=	$aData['current_directory'];
		$user_id	=	$aData['user_id']; 
		
		$userTable = Engine_Api::_()->getDbtable('users', 'user');
	    $user = $userTable->fetchRow($userTable->select()->where('user_id = ?',$user_id));
		

		$dirname =   $user_id.'_'.$user->displayname; 
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
		
		echo json_encode($aResult); 
	}
	
	    public function renamefileAction(){
		
		$this->_helper->viewRenderer->setNoRender(true);
		$this->_helper->layout->disableLayout();
		
		$user_id=Engine_Api::_()->user()->getViewer()->getIdentity(); 
		$viewer     = Engine_Api::_()->user()->getViewer();

		
		$aData = $this->_request->getPost();

		
		$new_name	=	$aData['new_name'];
		$old_name	=	$aData['old_name'];
		$user_id	=	$aData['user_id'];
		$current_directory	=	$aData['current_directory'];
		$file_id	=	$aData['file_id'];
		
		$userTable = Engine_Api::_()->getDbtable('users', 'user');
	    $user = $userTable->fetchRow($userTable->select()->where('user_id = ?',$user_id));
		
		
		$root_dirname =   $user_id.'_'.$user->displayname; 
		if($current_directory ==''){
		  $old_dir_name = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$root_dirname.'/'.$current_directory.$old_name; 
		  $new_dir_name = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$root_dirname.'/'.$current_directory.$new_name; 
		  $new_dir= dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$root_dirname.'/'.$current_directory; 
		  $doc_path = $root_dirname.'/'.$old_name;
		}
		else{
		  $old_dir_name = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$root_dirname.'/'.$current_directory.'/'.$old_name; 
		  $new_dir_name = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$root_dirname.'/'.$current_directory.'/'.$new_name; 
		  $new_dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$root_dirname.'/'.$current_directory; 
		  $doc_path = $root_dirname.$current_directory.'/'.$old_name;
	    }
	    if(is_dir($old_dir_name)){
			
			// $files =	$this->loaddirectory($old_dir_name);

		$paths = $this->loaddirrecursively($old_dir_name);
		
		rename($old_dir_name, $new_dir_name);
		$paths1 = $this->loaddirrecursively($new_dir_name);
		
		//print_r($paths1); exit;
		$dropboxfileTable = Engine_Api::_()->getDbtable('dropboxfiles', 'user');
		
		for($i=0;$i<count($paths);$i++){

			
		
			$dropboxfileData = $dropboxfileTable->fetchAll($dropboxfileTable->select()->where('dir_structure = ?', $paths[$i])); 
			
			foreach($dropboxfileData as $data){
			//echo $data['id']; exit;
			
			$dropboxfile= $dropboxfileTable->fetchRow($dropboxfileTable->select()->where('id = ?', $data['id'])); 
			
			$dropboxfile->dir_structure = $paths1[$i];	
			$file_name =dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$data['file_path'];
			$file_name = basename($file_name).PHP_EOL;
		    $removed_path = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/';
			//$old_filepath = $removed_path.$data['file_path'];
			$new_filepath = str_replace($removed_path,"",$paths1[$i]).'/'.$file_name;
				
			$dropboxfile->file_path = $new_filepath;
			$dropboxfile->save();
			} 
			
			
			$dropboxlogTable = Engine_Api::_()->getDbtable('dropboxlog', 'user');	
		
			$dropboxlogTableId=   $dropboxlogTable->insert(array(
					
						  'subject_id' => $user_id,
						  'path' => $old_dir_name,
						  'action' => 'folder renamed to '.$new_name,
						  'created_at' => date('Y-m-d H:i:s'),
						  'updated_at' => date('Y-m-d H:i:s'),

							
						));  


	    }
		
	    $aResult['msg'] ='Succesfully renamed.';	
		$aResult['type'] ='dir';	
	    }
	    if(file_exists($old_dir_name)){
			
			$dropboxfileTable = Engine_Api::_()->getDbtable('dropboxfiles', 'user');
			$dropboxfileData = $dropboxfileTable->fetchRow($dropboxfileTable->select()->where('id = ?', $file_id)); 
			$dropboxfileData->file_title = $new_name;
			$dropboxfileData->save();
			
			$dropboxlogTable = Engine_Api::_()->getDbtable('dropboxlog', 'user');	
		
			$dropboxlogTableId=   $dropboxlogTable->insert(array(
					
						  'subject_id' => $user_id,
						  'path' => $old_dir_name,
						  'action' => 'file renamed to '.$new_name,
						  'created_at' => date('Y-m-d H:i:s'),
						  'updated_at' => date('Y-m-d H:i:s'),

							
						));  
			
			
		//rename($old_dir_name, $new_dir_name);
		$aResult['msg'] ='Succesfully renamed.';	
		$aResult['type'] ='file';	
		$aResult['file_id'] =$dropboxfileData->id;	
	    }
		echo json_encode($aResult); 
		
	}
	
	   public function loaddirrecursively($path){
	   
	   
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

			 
	return 	$paths;	 
			
	   
	   
   }
   
      public function documentfileAction(){

	   	$this->_helper->viewRenderer->setNoRender(true);
		$this->_helper->layout->disableLayout();
		
		$user_id=Engine_Api::_()->user()->getViewer()->getIdentity(); 
		$viewer     = Engine_Api::_()->user()->getViewer() ;
		
		$aData = $this->_request->getPost();
	    $file_id	    =	$aData['file_id']; 
		
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
        
        $filetitle = $dropboxfileData->	file_title;
        
        $content ='';
        
        $content = $content. '<div class="div_attachment_title">'.$filetitle.'</div>';
        if($is_image == 0){
        $content = $content. '<div class="div_attachment_name">Attachment  : </div> <span><a href="/filemanager/'.$dropboxfileData->file_path.'" target="_blank">'. $file_name.'</a></span>';
	    }
	    else{
        $content = $content. '<div class="div_attachment_name">Attachment  : </div> <span><a href="/filemanager/'.$dropboxfileData->file_path.'" data-lightbox="image1">'. $file_name.'</a></span>';
	    }
        $documentshareTable = Engine_Api::_()->getDbtable('documentshare', 'user');
        $documentShareDataSelect = $documentshareTable->select()
		                      ->setIntegrityCheck(false)
		                       ->from(array('share'=>'engine4_document_share',))  
		                       ->joinLeft(array('user'=>'engine4_users',),'share.reciever_id=user.user_id',array('displayname'))      
					           ->where('share.share_file_id = ?', $file_id); 

	    $documentShareData = $documentshareTable->fetchAll($documentShareDataSelect);
        
        $content =$content .'<div>';
        $content =$content .'<div class="attachment_label">This file is shared to   :</div>';
        if(count($documentShareData) > 0){
		$content = $content.'<ul>';
		$i=1;
        foreach($documentShareData as $data){ 
			
		$content = $content.'<li class="li_count_'.$i.'"><div style="float: left;">*  '.$data['displayname'].'</div><div  style="text-align: right;"><a href="javascript:void(0)" class="revoke_access" file-id='.$file_id.' user-id='.$data['reciever_id'].' li-count='.$i.'>Revoke access</a></div></li>';	
        $i++; 
		}
		$content = $content.'</ul>';
	    }
	    else{
			
		$content =$content .'No share';	
		}
        $content =$content .'</div>';
        $content =$content .'<div class="confirm_btns" style="text-align: center;"><button class="cancel">Cancel</button></div>';
        
		
		
		$aResult['html'] = $content;
	
		echo json_encode($aResult);

   }
   
   	public function revokefileaccessAction(){
		
    $this->_helper->layout->disableLayout();
	$this->_helper->viewRenderer->setNoRender(true);
	
	$viewer     = Engine_Api::_()->user()->getViewer();
	$viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); 
	$aResult	=	array(); 
	$aData = $this->_request->getPost(); 
	
	try{

        Engine_Db_Table::getDefaultAdapter()->delete('engine4_document_requests', array('file_id = ?'=>$aData['file_id'],'doc_requested_user_id = ?'=>$aData['user_id']) );
        Engine_Db_Table::getDefaultAdapter()->delete('engine4_document_share', array('	share_file_id = ?'=>$aData['file_id'],'reciever_id = ?'=>$aData['user_id']) );
        
		$aResult['status'] = true;
	    }catch (Exception $e) {exit($e->getMessage());
								$aResult['status'] = false;
							}
		echo json_encode($aResult);    

	}
	
	public function sharedocumentAction(){
		
		$this->_helper->viewRenderer->setNoRender(true);
		$this->_helper->layout->disableLayout();
		
		$user_id=Engine_Api::_()->user()->getViewer()->getIdentity(); 
		$viewer     = Engine_Api::_()->user()->getViewer();
		
		
		$aData = $this->_request->getPost();
		$share_dir_name	    =	$aData['share_dir_name'];
		$current_directory	=	$aData['current_directory'];
	    $reciever_ids	    =	$aData['reciever_ids'];
	    $share_file_id	    =	$aData['share_file_id'];
	    $user_id	        =	$aData['user_id'];
		$sender_id          =   $user_id;
		$recieverids = explode(",",$reciever_ids); 
		
		
		$dropboxfileTable = Engine_Api::_()->getDbtable('dropboxfiles', 'user');

		$dropboxfileData = $dropboxfileTable->fetchRow($dropboxfileTable->select()->where('id = ?', $share_file_id)); 	 
		
		$userTable = Engine_Api::_()->getDbtable('users', 'user');
	    $user = $userTable->fetchRow($userTable->select()->where('user_id = ?',$user_id));

		$root_dirname =   $user_id.'_'.$user->displayname; 
		if($current_directory ==''){
		    // $shared_document_path = $root_dirname.'/'.$current_directory.$share_dir_name;
		     $shared_document_path = $dropboxfileData->file_path;
	    }
	    else{
			 $shared_document_path = $root_dirname.$current_directory.'/'.$share_dir_name;
			 $shared_document_path = $dropboxfileData->file_path;
		} 
		try{
			$documentshareTable = Engine_Api::_()->getDbtable('documentshare', 'user');
			
			$dropboxlogTable = Engine_Api::_()->getDbtable('dropboxlog', 'user');	
			
		    $userTable = Engine_Api::_()->getDbtable('users', 'user');
		    
			for($i=0;$i<count($recieverids);$i++){
			
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
			
				$red_url =	$_SERVER['HTTP_HOST']."/documents/sharedwithme";
						
								
								
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
						

			}
			
		$aResult['msg'] ='Succesfully shared.';
			
		}catch( Exception $e ) { echo $e; die(); }
		
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
	public function landlordratingquestionslistAction(){ 
			
	$this->view->formFilter = $formFilter = new User_Form_Admin_Manage_Ratingquestionsfilter();	

    $page = $this->_getParam('page', 1); 	
    
    // Process form
		$values = array();
		if( $formFilter->isValid($this->_getAllParams()) ) {
		  $values = $formFilter->getValues();
		}
        
        foreach( $values as $key => $value ) {
		if( null === $value ) {
			unset($values[$key]);
		  }
		}

		$values = array_merge(array(
		  'order' => 'id',
		  'order_direction' => 'DESC',
		), $values);
		
		$this->view->assign($values);	
		
		$ratingquestions_table =  Engine_Api::_()->getDbtable('ratingquestions', 'user'); 

        $select = $ratingquestions_table->getAdapter()->select()
						//->from(array('questions'=>'engine4_rating_questions',));
						->from(array('questions'=>'engine4_rating_questions',))
                        ->where('questions.profile_type	 = ?', '4');
						
		$select->order(( !empty($values['order']) ? $values['order'] : 'id' ) . ' ' . ( !empty($values['order_direction']) ? $values['order_direction'] : 'DESC' ));

			if( !empty($values['questions']) ) {
			  $select->where('questions LIKE ?', '%' . $values['questions'] . '%');
			}
		
		
    	 $valuesCopy = array_filter($values);		
    	 
    	 	 
	$this->view->paginator = $paginator = Zend_Paginator::factory($select);
    $this->view->paginator = $paginator->setCurrentPageNumber( $page );
    $this->view->paginator = $paginator->setItemCountPerPage(20);
    $this->view->formValues = $valuesCopy; 
   
      //echo '<pre>'; print_r($oData); exit;
     $this->renderScript('admin-manage/landlordratingquestionslist.tpl');			
			

    }
    
	public function tenantratingquestionslistAction(){ 
			
	$this->view->formFilter = $formFilter = new User_Form_Admin_Manage_Ratingquestionsfilter();	

    $page = $this->_getParam('page', 1); 	
    
    // Process form
		$values = array();
		if( $formFilter->isValid($this->_getAllParams()) ) {
		  $values = $formFilter->getValues();
		}
        
        foreach( $values as $key => $value ) {
		if( null === $value ) {
			unset($values[$key]);
		  }
		}

		$values = array_merge(array(
		  'order' => 'id',
		  'order_direction' => 'DESC',
		), $values);
		
		$this->view->assign($values);	
		
		$ratingquestions_table =  Engine_Api::_()->getDbtable('ratingquestions', 'user'); 

        $select = $ratingquestions_table->getAdapter()->select()
						->from(array('questions'=>'engine4_rating_questions',))
						->where('questions.profile_type	 = ?', '1');		 

						
		$select->order(( !empty($values['order']) ? $values['order'] : 'id' ) . ' ' . ( !empty($values['order_direction']) ? $values['order_direction'] : 'DESC' ));

			if( !empty($values['questions']) ) {
			  $select->where('questions LIKE ?', '%' . $values['questions'] . '%');
			}
		
		
    	 $valuesCopy = array_filter($values);		
    	 
    	 	 
	$this->view->paginator = $paginator = Zend_Paginator::factory($select);
    $this->view->paginator = $paginator->setCurrentPageNumber( $page );
    $this->view->paginator = $paginator->setItemCountPerPage(20);
    $this->view->formValues = $valuesCopy; 
   
      //echo '<pre>'; print_r($oData); exit;
    $this->renderScript('admin-manage/tenantratingquestionslist.tpl');			
			

    }
    
	public function ratingquestionslistAction(){ 
			
	$this->view->formFilter = $formFilter = new User_Form_Admin_Manage_Ratingquestionsfilter();	

    $page = $this->_getParam('page', 1); 	
    
    // Process form
		$values = array();
		if( $formFilter->isValid($this->_getAllParams()) ) {
		  $values = $formFilter->getValues();
		}
        
        foreach( $values as $key => $value ) {
		if( null === $value ) {
			unset($values[$key]);
		  }
		}

		$values = array_merge(array(
		  'order' => 'id',
		  'order_direction' => 'DESC',
		), $values);
		
		$this->view->assign($values);	
		
		$ratingquestions_table =  Engine_Api::_()->getDbtable('ratingquestions', 'user'); 

        $select = $ratingquestions_table->getAdapter()->select()
						->from(array('questions'=>'engine4_rating_questions',));
							 

						
		$select->order(( !empty($values['order']) ? $values['order'] : 'id' ) . ' ' . ( !empty($values['order_direction']) ? $values['order_direction'] : 'DESC' ));

			if( !empty($values['questions']) ) {
			  $select->where('questions LIKE ?', '%' . $values['questions'] . '%');
			}
		
		
    	 $valuesCopy = array_filter($values);		
    	 
    	 	 
	$this->view->paginator = $paginator = Zend_Paginator::factory($select);
    $this->view->paginator = $paginator->setCurrentPageNumber( $page );
    $this->view->paginator = $paginator->setItemCountPerPage(20);
    $this->view->formValues = $valuesCopy; 
   
      //echo '<pre>'; print_r($oData); exit;
     $this->renderScript('admin-manage/ratingquestionslist.tpl');			
			

    }
    
    public function addratingquestionsAction(){

	  
	  $this->view->form = $form = new User_Form_Admin_Manage_Addratingquestions();
	  $aData	=  $this->_request->getPost();	  
	  $question	=	$aData['question'];
	  $profile_type	=	$aData['profile_type'];
	  $status	    =	$aData['status'];
	  
	  if($question !='' && $status !=''){
	  
	    $ratingquestions_table =  Engine_Api::_()->getDbtable('ratingquestions', 'user'); 
	    $ratingquestions_table_id =  $ratingquestions_table->insert(array(
                    'questions' => $question,                   
                    'profile_type' => $profile_type,                   
                    'status'       => $status,                   
                    'created_at' =>date('Y-m-d H:i:s'),                   
                ));
                
        return $this->_helper->redirector->gotoRoute(array('module'=>'user','controller'=>'manage','action' => 'ratingquestionslist'), '', true);
      }
      
  }
  
  public function editratingquestionsAction()
    {
    $id = $this->_getParam('id', null);
    $this->view->form = $form = new User_Form_Admin_Manage_Editratingquestions(array(
      'ratingquestionsIdentity' => $id,
    ));
    
     // Check method/valid
    if( !$this->getRequest()->isPost() ) {
      return;
    }
    if( !$form->isValid($this->getRequest()->getPost()) ) {
      return;
    }

    $values = $form->getValues();
    $ratingquestions_table =  Engine_Api::_()->getDbtable('ratingquestions', 'user'); 
    $ratingquestions_table->update(array('questions' =>$values['question'],'status' =>$values['status']),array('id = ?' => $id));
    
     // Forward
    return $this->_forward('success', 'utility', 'core', array(
      'smoothboxClose' => true,
      'parentRefresh' => true,
      'format'=> 'smoothbox',
      'messages' => array('Your changes have been saved.')
    ));
    
    } 
    
    public function deleteratingquestionsAction(){
		 
		 
	 $id = $this->_getParam('id', null);
    $this->view->form = $form = new User_Form_Admin_Manage_Deleteitem();
    if( $this->getRequest()->isPost() ) {
      try {
         
         Engine_Db_Table::getDefaultAdapter()->delete('engine4_rating_questions', array('id = ?'=>$id) );
        
       
      } catch( Exception $e ) {
        throw $e;
      }
      
      return $this->_forward('success', 'utility', 'core', array(
        'smoothboxClose' => true,
        'parentRefresh' => true,
        'format'=> 'smoothbox',
        'messages' => array('This question has been successfully deleted.')
      ));
    }	 
		 
		 
	}
	
	public function ratinglistAction(){ 
		
		
	$this->view->formFilter = $formFilter = new User_Form_Admin_Manage_Ratingfilter();	

	
	$page = $this->_getParam('page', 1); 	
    
    // Process form
		$values = array();
		if( $formFilter->isValid($this->_getAllParams()) ) {
		  $values = $formFilter->getValues();
		}
        
        foreach( $values as $key => $value ) {
		if( null === $value ) {
			unset($values[$key]);
		  }
		}

		$values = array_merge(array(
		  'order' => 'user_id',
		  'order_direction' => 'DESC',
		), $values);
		
		$this->view->assign($values);	
		
		$userTable = Engine_Api::_()->getDbtable('users', 'user');	
		
		$select = $userTable->select()
		                      ->setIntegrityCheck(false)
		                       ->from(array('user'=>'engine4_users',))
		                       ->where('user.rating_value	 != ?', '')		                      
		                       ->where('user.rating_value	 != ?', 0);		                      
		                     

		$select->order(( !empty($values['order']) ? $values['order'] : 'user_id' ) . ' ' . ( !empty($values['order_direction']) ? $values['order_direction'] : 'DESC' ));

			if( !empty($values['displayname']) ) {
			  $select->where('displayname LIKE ?', '%' . $values['displayname'] . '%');
			}			           
     $valuesCopy = array_filter($values);		
    
    
    $ratingintervalTable = Engine_Api::_()->getDbtable('ratinginterval', 'user');
    

	$ratingintervalTable_select =	$ratingintervalTable->fetchRow($ratingintervalTable->select()->where('days != ?', ''));	
	
	$this->view->ratinginterval = $ratingintervalTable_select->days; 
    	
	$this->view->paginator = $paginator = Zend_Paginator::factory($select);
    $this->view->paginator = $paginator->setCurrentPageNumber( $page );
    $this->view->paginator = $paginator->setItemCountPerPage(20);
    $this->view->formValues = $valuesCopy; 
   
     // echo '<pre>'; print_r($select); exit;
     $this->renderScript('admin-manage/ratinglist.tpl');			
			
	}
	

	public function enableratingAction()
    {
    $id = $this->_getParam('id', null);
   
    $this->view->form = $form = new User_Form_Admin_Manage_Enablerating(array(
      'userIdentity' => $id,
    ));
   
     // Check method/valid
    if( !$this->getRequest()->isPost() ) {
      return;
    }
    if( !$form->isValid($this->getRequest()->getPost()) ) {
      return;
    }

    $values = $form->getValues(); 
    $userTable = Engine_Api::_()->getDbtable('users', 'user');
    $userdata = $userTable->fetchRow($userTable->select()->where('user_id = ?', $id));	
    $userdata->enable_rating_value = $values['enabled'];
    $userdata->save();
   // $userTable->update(array('enable_rating_value' =>$values['enabled']),array('user_id = ?' => $id));

    
     // Forward
    return $this->_forward('success', 'utility', 'core', array(
      'smoothboxClose' => true,
      'parentRefresh' => true,
      'format'=> 'smoothbox',
      'messages' => array('Your changes have been saved.')
    ));
    
    }
    
    public function ratinginfoAction(){
		
		
	$id = $this->_getParam('id', null);
	
	
    $this->view->objectData = $objectData = Engine_Api::_()->getItem('user', $id);  
    
    $ratingValueTable =  Engine_Api::_()->getDbtable('ratingvalue', 'user');
		    
		    

		    
		     $ratingValue_select = $ratingValueTable->select()
		                       ->setIntegrityCheck(false)
		                       ->from(array('rating_value'=>'engine4_rating_value',)) 
		                       ->joinLeft(array('user'=>'engine4_users',),'rating_value.subject_id = user.user_id',array('displayname','level_id'))   
					           ->where('rating_value.object_id = ?', $id)
					           ->where('rating_value.rate_value != ?', 0);

		
		    $ratedData = $ratingValueTable->fetchAll($ratingValue_select);
		    
		    
	$this->view->ratedData = $ratedData;	 
	
	$page = $this->_getParam('page', 1); 
	
	$this->view->paginator = $paginator = Zend_Paginator::factory($ratedData);
    $this->view->paginator = $paginator->setCurrentPageNumber( $page );
    $this->view->paginator = $paginator->setItemCountPerPage(20);
		
	}
	public function editratingintervalAction(){
		
	$this->view->form = $form = new User_Form_Admin_Manage_Editratinginterval(array(
 
    ));
		 // Check method/valid
    if( !$this->getRequest()->isPost() ) {
      return;
    }
    if( !$form->isValid($this->getRequest()->getPost()) ) {
      return;
    }
    
    $values = $form->getValues(); 
    
    $ratingintervalTable = Engine_Api::_()->getDbtable('ratinginterval', 'user');
    

	$select =	$ratingintervalTable->fetchRow($ratingintervalTable->select());	
				
	if(count($select)>0){
		
		$select->days = $values['ratinginterval'];
		$select->created_at = date('Y-m-d');
        $select->save();
		
		
	}
	else{
		
		$ratingintervalTable_id =  $ratingintervalTable->insert(array(
                    'days' => $values['ratinginterval'], 
                    'created_at' => date('Y-m-d'), 
                                      
                ));
		
	}
	return $this->_forward('success', 'utility', 'core', array(
      'smoothboxClose' => true,
      'parentRefresh' => true,
      'format'=> 'smoothbox',
      'messages' => array('Your changes have been saved.')
    ));					
		
	}
	public function smartmoveapiquestionsAction(){
		
    $this->view->formFilter = $formFilter = new User_Form_Admin_Manage_Smartmoveapiquestionsfilter();	

    $page = $this->_getParam('page', 1); 	
    
    // Process form
		$values = array();
		if( $formFilter->isValid($this->_getAllParams()) ) {
		  $values = $formFilter->getValues();
		}
        
        foreach( $values as $key => $value ) {
		if( null === $value ) {
			unset($values[$key]);
		  }
		}

		$values = array_merge(array(
		  'order' => 'qid',
		  'order_direction' => 'DESC',
		), $values);
		
		$this->view->assign($values);	
		
		$smartmoveapiquestions_table =  Engine_Api::_()->getDbtable('smartmoveapiquestions', 'user'); 

        $select = $smartmoveapiquestions_table->getAdapter()->select()
						->from(array('smovequestions'=>'engine4_smartmoveapi_questions',));
							 

						
		$select->order(( !empty($values['order']) ? $values['order'] : 'qid' ) . ' ' . ( !empty($values['order_direction']) ? $values['order_direction'] : 'DESC' ));

			if( !empty($values['questions']) ) {
			  $select->where('qtext LIKE ?', '%' . $values['questions'] . '%');
			}
		
		
    	 $valuesCopy = array_filter($values);	
    	 
 
	$this->view->paginator  = $paginator = Zend_Paginator::factory($select);
    $this->view->paginator  = $paginator->setCurrentPageNumber( $page );
    $this->view->paginator  = $paginator->setItemCountPerPage(20);
    $this->view->formValues = $valuesCopy; 
   
      //echo '<pre>'; print_r($oData); exit;
     $this->renderScript('admin-manage/smartmoveapiquestions.tpl');		
		
	}

	public function addsmartmoveapiquestionsAction(){

	  
	  $this->view->form = $form = new User_Form_Admin_Manage_Addsmartmoveapiquestions();
	  $aData	=  $this->_request->getPost();	  
	  $QuestionText	=	$aData['QuestionText'];

	  
	  if($QuestionText !=''){
	  
	    $smartmoveapiquestions_table =  Engine_Api::_()->getDbtable('smartmoveapiquestions', 'user'); 
	    $smartmoveapiquestions_table_id =  $smartmoveapiquestions_table->insert(array(
                    'qtext' => $QuestionText,                                      
                ));
                
        return $this->_helper->redirector->gotoRoute(array('module'=>'user','controller'=>'manage','action' => 'smartmoveapiquestions'), '', true);
      }
      
  }
  public function addsmartmoveapiquestionanswerAction()
    {
    $qid = $this->_getParam('qid', null);
    $this->view->form = $form = new User_Form_Admin_Manage_Addsmartmoveapiquestionanswer(array(
      'questionsIdentity' => $qid,
    ));
    
     // Check method/valid
    if( !$this->getRequest()->isPost() ) {
      return;
    }
    if( !$form->isValid($this->getRequest()->getPost()) ) {
      return;
    }

    $values = $form->getValues();
    
 
    try{
    
    
    $smartmoveapiquestions_table =  Engine_Api::_()->getDbtable('smartmoveapiquestions', 'user'); 
    $smartmoveapiquestionAnswer_table =  Engine_Api::_()->getDbtable('Smartmoveapiquestionanswers', 'user'); 
    
    $smartmoveapiquestionAnswer_id =  $smartmoveapiquestionAnswer_table->insert(array(
                    'qid' => $qid,                   
                    'answer_text'        => $values['AnswerText'],                   
                    'answer_description' => $values['AnswerDescription']                  
                ));
                
     
    if($values['status'] == 1){  
		    
    $smartmoveapiquestionsData = $smartmoveapiquestions_table->fetchRow($smartmoveapiquestions_table->select()->where('qid = ?', $qid));            
        
    $smartmoveapiquestionsData -> selected_answer = $values['AnswerText'];  
    
    $smartmoveapiquestionsData -> save();        
    
    } 
               
    } catch (Exception $e) {exit($e->getMessage());
								
							}           
         // Forward
    return $this->_forward('success', 'utility', 'core', array(
      'smoothboxClose' => true,
      'parentRefresh' => true,
      'format'=> 'smoothbox',
      'messages' => array('Your answer have been saved.')
    ));
    
    } 
    
    public function smartmoveapiquestionanswerAction(){
		
    $this->view->formFilter = $formFilter = new User_Form_Admin_Manage_Smartmoveapiquestionanswerfilter();	
    $qid = $this->_getParam('qid', null);
    $page = $this->_getParam('page', 1); 	
    
    // Process form
		$values = array();
		if( $formFilter->isValid($this->_getAllParams()) ) {
		  $values = $formFilter->getValues();
		}
        
        foreach( $values as $key => $value ) {
		if( null === $value ) {
			unset($values[$key]);
		  }
		}

		$values = array_merge(array(
		  'order' => 'qid',
		  'order_direction' => 'DESC',
		), $values);
		
		$this->view->assign($values);	
		
		
		$smartmoveapiquestions_table =  Engine_Api::_()->getDbtable('smartmoveapiquestions', 'user'); 
		
		$this->view->smartmoveapiquestionsData = $smartmoveapiquestionsData = $smartmoveapiquestions_table->fetchRow($smartmoveapiquestions_table->select()->where('qid = ?', $qid));            

		$smartmoveapiquestionAnswer_table =  Engine_Api::_()->getDbtable('Smartmoveapiquestionanswers', 'user'); 

        $select = $smartmoveapiquestionAnswer_table->getAdapter()->select()
						->from(array('smovequestionanswer'=>'engine4_smartmoveapi_questionanswers'))
						->where('smovequestionanswer.qid =?',$qid);
							 

						
		$select->order(( !empty($values['order']) ? $values['order'] : 'qid' ) . ' ' . ( !empty($values['order_direction']) ? $values['order_direction'] : 'DESC' ));

		if( !empty($values['answertext']) ) {
			  $select->where('answer_text LIKE ?', '%' . $values['answertext'] . '%');
			}
		
		
    	 $valuesCopy = array_filter($values);	
    	 
 
	$this->view->paginator  = $paginator = Zend_Paginator::factory($select);
    $this->view->paginator  = $paginator->setCurrentPageNumber( $page );
    $this->view->paginator  = $paginator->setItemCountPerPage(20);
    $this->view->formValues = $valuesCopy; 
   
      //echo '<pre>'; print_r($oData); exit;
     $this->renderScript('admin-manage/smartmoveapiquestionanswer.tpl');		
		
	}
	
	public function editsmartmoveapiquestionAction(){
		
		
	$qid = $this->_getParam('qid', null);
    $this->view->form = $form = new User_Form_Admin_Manage_Editsmartmoveapiquestion(array(
      'questionIdentity' => $qid,
    ));
    
     // Check method/valid
    if( !$this->getRequest()->isPost() ) {
      return;
    }
    if( !$form->isValid($this->getRequest()->getPost()) ) {
      return;
    }

    $values = $form->getValues();

    
    $smartmoveapiquestions_table =  Engine_Api::_()->getDbtable('smartmoveapiquestions', 'user'); 

    if($values['QuestionText'] != ''){
		
    $smartmoveapiquestionsData = $smartmoveapiquestions_table->fetchRow($smartmoveapiquestions_table->select()->where('qid = ?', $qid));            

    $smartmoveapiquestionsData -> qtext = $values['QuestionText'];  
    
    $smartmoveapiquestionsData -> save();  
      
    }
    
     // Forward
    return $this->_forward('success', 'utility', 'core', array(
      'smoothboxClose' => true,
      'parentRefresh' => true,
      'format'=> 'smoothbox',
      'messages' => array('Your changes have been saved.')
    ));
		
		
		
	}
	public function deletesmartmoveapiquestionAction(){
		 
		 
	$qid = $this->_getParam('qid', null);
    $this->view->form = $form = new User_Form_Admin_Manage_Deleteitem();
    if( $this->getRequest()->isPost() ) {
      try {
         
         Engine_Db_Table::getDefaultAdapter()->delete('engine4_smartmoveapi_questions', array('qid = ?'=>$qid) );
         Engine_Db_Table::getDefaultAdapter()->delete('engine4_smartmoveapi_questionanswers', array('qid = ?'=>$qid) );
        
       
      } catch( Exception $e ) {
        throw $e;
      }
      
      return $this->_forward('success', 'utility', 'core', array(
        'smoothboxClose' => true,
        'parentRefresh' => true,
        'format'=> 'smoothbox',
        'messages' => array('This question has been successfully deleted.')
      ));
    }	 
		 
		 
	}
	
	public function editsmartmoveapiquestionanswerAction(){
		
	$aid = $this->_getParam('aid', null);
    $this->view->form = $form = new User_Form_Admin_Manage_Editsmartmoveapiquestionanswer(array(
      'answerIdentity' => $aid,
    ));
    
     // Check method/valid
    if( !$this->getRequest()->isPost() ) {
      return;
    }
    if( !$form->isValid($this->getRequest()->getPost()) ) {
      return;
    }

    $values = $form->getValues();

    
    $smartmoveapiquestions_table =  Engine_Api::_()->getDbtable('smartmoveapiquestions', 'user'); 
    
    $smartmoveapiquestionAnswer_table =  Engine_Api::_()->getDbtable('Smartmoveapiquestionanswers', 'user'); 

    if($values['AnswerText'] != '' && $values['AnswerDescription'] != ''){

    $smartmoveapiquestionAnswerData = $smartmoveapiquestionAnswer_table->fetchRow($smartmoveapiquestionAnswer_table->select()->where('id = ?', $aid));            
    
    $smartmoveapiquestionAnswerData -> answer_text = $values['AnswerText'];  
    $smartmoveapiquestionAnswerData -> answer_description = $values['AnswerDescription'];  
    $smartmoveapiquestionAnswerData -> save();  
    
    if($values['status'] == 1){
    
    $smartmoveapiquestionsData = $smartmoveapiquestions_table->fetchRow($smartmoveapiquestions_table->select()->where('qid = ?', $smartmoveapiquestionAnswerData->qid));            

    $smartmoveapiquestionsData -> selected_answer = $values['AnswerText'];  
    
    $smartmoveapiquestionsData -> save();  
    
    }
      
    }
    
     // Forward
    return $this->_forward('success', 'utility', 'core', array(
      'smoothboxClose' => true,
      'parentRefresh' => true,
      'format'=> 'smoothbox',
      'messages' => array('Your changes have been saved.')
    ));
		
		
		
	}
	
	public function deletesmartmoveapiquestionanswerAction(){
		 
		 
	$aid = $this->_getParam('aid', null);
    $this->view->form = $form = new User_Form_Admin_Manage_Deleteitem();
    if( $this->getRequest()->isPost() ) {
      try {
		  
        $smartmoveapiquestions_table =  Engine_Api::_()->getDbtable('smartmoveapiquestions', 'user'); 
    
        $smartmoveapiquestionAnswer_table =  Engine_Api::_()->getDbtable('Smartmoveapiquestionanswers', 'user');  
        
        $smartmoveapiquestionAnswerData = $smartmoveapiquestionAnswer_table->fetchRow($smartmoveapiquestionAnswer_table->select()->where('id = ?', $aid));            
  
         
        $smartmoveapiquestionsData = $smartmoveapiquestions_table->fetchRow($smartmoveapiquestions_table->select()->where('qid = ?', $smartmoveapiquestionAnswerData->qid));            


        if($smartmoveapiquestionsData->selected_answer == $smartmoveapiquestionAnswerData->answer_text){
      
		$smartmoveapiquestionsData -> selected_answer = '';  
		
		$smartmoveapiquestionsData -> save();  
    
        }

        Engine_Db_Table::getDefaultAdapter()->delete('engine4_smartmoveapi_questionanswers', array('id = ?'=>$aid) );
        
       
      } catch( Exception $e ) {
        throw $e;
      }
      
      return $this->_forward('success', 'utility', 'core', array(
        'smoothboxClose' => true,
        'parentRefresh' => true,
        'format'=> 'smoothbox',
        'messages' => array('This answer has been successfully deleted.')
      ));
    }	 
		 
		 
	}
	

	
	public function stripeAction(){
		
		
		
	$StripeSettingsTable =  Engine_Api::_()->getDbtable('Stripesettings', 'user'); 	
	$StripeSettingsData = $StripeSettingsTable->fetchRow($StripeSettingsTable->select()->where('id = ?', 1));
	
	$this->view->StripeSettingsData = $StripeSettingsData;

		
	}
	public function editpaymentsettingsAction(){
	
	$id = $this->_getParam('id', null); 

    $this->view->form = $form = new User_Form_Admin_Manage_Editpaymentsettings(array(
      'paymentIdentity' => $id,

    ));
   
     // Check method/valid
    if( !$this->getRequest()->isPost() ) {
      return;
    }
    if( !$form->isValid($this->getRequest()->getPost()) ) {
      return;
    }
    $StripeSettingsTable =  Engine_Api::_()->getDbtable('Stripesettings', 'user'); 	
    $values = $form->getValues(); 
    
        $payment_duration = $values['payment_duration'];
		$credit_and_background_payment_amount = $values['credit_and_background_payment_amount'];
		$creditbackground_eviction_payment_amount = $values['creditbackground_eviction_payment_amount'];
		$creditscore_payment_amount = $values['creditscore_payment_amount'];
		$deduction_per_each_payment = $values['deduction_per_each_payment'];
    
    if($id == null){
		
		$StripeSettingsTableId =  $StripeSettingsTable->insert(array(
		 
                    'payment_duration'   => $payment_duration,                   
                    'credit_and_background_payment_amount' => $credit_and_background_payment_amount,  
                    'creditbackground_eviction_payment_amount' => $creditbackground_eviction_payment_amount,  
                    'creditscore_payment_amount' => $creditscore_payment_amount,  
                    'deduction_per_each_payment' => $deduction_per_each_payment,  
                    'created_at'=> date("Y-m-d"),
                    'updated_at'=> date("Y-m-d"),
                    
                ));
		
	}
	else{
	
    $StripeSettingsData = $StripeSettingsTable->fetchRow($StripeSettingsTable->select()->where('id = ?', $id));
    
     $StripeSettingsData->payment_duration = $payment_duration;
     $StripeSettingsData->credit_and_background_payment_amount = $credit_and_background_payment_amount;
     $StripeSettingsData->creditbackground_eviction_payment_amount = $creditbackground_eviction_payment_amount;
     $StripeSettingsData->creditscore_payment_amount = $creditscore_payment_amount;
     $StripeSettingsData->deduction_per_each_payment = $deduction_per_each_payment;
     $StripeSettingsData->updated_at = date("Y-m-d");
     $StripeSettingsData->save();
    
    }
    
    
    
 
     // Forward
    return $this->_forward('success', 'utility', 'core', array(
      'smoothboxClose' => true,
      'parentRefresh' => true,
      'format'=> 'smoothbox',
      'messages' => array('Your changes have been saved.')
    ));
	}
	
    public function createtipAction(){

	  
	  $this->view->form = $form = new User_Form_Admin_Manage_Createtip();
	  
	  $aData	=  $this->_request->getPost();
	  
	  $tip_type	=	$aData['tip_type'];
	  $content	=	$aData['content'];
	 
	  $tips_table =  Engine_Api::_()->getDbtable('tips', 'user'); 
	   
	  if($tip_type !='' && $content!=''){
	  
	    $tipData = $tips_table->fetchRow($tips_table->select()->where('type = ?', $tip_type));
	    if(empty($tipData)){
	   
               
			}
	    
	    return $this->_helper->redirector->gotoRoute(array('module'=>'user','controller'=>'manage','action' => 'tiplist'), '', true);

      }
     
    }
    public function tiplistAction(){
		$tips_table =  Engine_Api::_()->getDbtable('tips', 'user');
	    $tips_select = $tips_table->select();	
	     $tipData = $tips_table->fetchAll($tips_select);
		$this->view->tipData = $tipData;
	}
		public function tipeditAction()
    {
    $id = $this->_getParam('id', null);
    $this->view->form = $form = new User_Form_Admin_Manage_Tipedit(array(
      'tipIdentity' => $id,
    ));
    
     // Check method/valid
    if( !$this->getRequest()->isPost() ) {
      return;
    }
    if( !$form->isValid($this->getRequest()->getPost()) ) {
      return;
    }

    $values = $form->getValues();
    $tips_table =  Engine_Api::_()->getDbtable('tips', 'user');
    $tips_table->update(array('content' =>$values['content']),array('id = ?' => $id));
    
     // Forward
    return $this->_forward('success', 'utility', 'core', array(
      'smoothboxClose' => true,
      'parentRefresh' => true,
      'format'=> 'smoothbox',
      'messages' => array('Your changes have been saved.')
    ));
    
    }
      public function tipdeleteAction()
    {
    $id = $this->_getParam('id', null);
    $this->view->form = $form = new User_Form_Admin_Manage_Deleteitem();
    if( $this->getRequest()->isPost() ) {
    
      try {
         
         Engine_Db_Table::getDefaultAdapter()->delete('engine4_tips', array('id = ?'=>$id) );
        
       
      } catch( Exception $e ) {
        throw $e;
      }
      
      return $this->_forward('success', 'utility', 'core', array(
        'smoothboxClose' => true,
        'parentRefresh' => true,
        'format'=> 'smoothbox',
        'messages' => array('Tip has been successfully deleted.')
      ));
      
     }

    }
      public function tipdurationAction()
    { 
      $common_settings_table =  Engine_Api::_()->getDbtable('commonsettings', 'user'); 
	  $common_settings = $common_settings_table->fetchRow($common_settings_table->select()->where('type =?', 'tip_duration'));
	    

   	  $this->view->form = $form = new User_Form_Admin_Manage_Tipduration();
   	  $aData	=  $this->_request->getPost();
	  if(!empty($aData)){
	    $tip_duration	=	$aData['value'];
	    if(empty($common_settings)){
	  
	 
	        if($tip_duration!='')
	            {
	             $tips_table_insert_id =  $common_settings_table->insert(array(
                    'type'   => 'tip_duration',                   
                    'value' => $tip_duration,  
                    'created_at'=> date("Y-m-d"),
                    'updated_at'=> date("Y-m-d"),
                ));
               
			}
			
		}
		else
		{
	    $common_settings->value=$tip_duration;
	    $common_settings->save();
		}
        return $this->_forward('success', 'utility', 'core', array(
      'smoothboxClose' => true,
      'parentRefresh' => true,
      'format'=> 'smoothbox',
      'messages' => array('Your changes have been saved.')
          ));
    }
    }
   
    public function surveyquestionsAction(){

		$survey_table =  Engine_Api::_()->getDbtable('surveyquestions', 'user');
	    $survey_select = $survey_table->select();	
	    $surveyData = $survey_table->fetchAll($survey_select);
		$this->view->surveyData = $surveyData;
	}
	    public function addsurveyquestionsAction(){

	  
	  $this->view->form = $form = new User_Form_Admin_Manage_Addsurveyquestions();
	  
	  $aData	=  $this->_request->getPost();
	  
	  $survey_question	=	$aData['question'];
	  $profile_type	=	$aData['profile_type'];
	 
	  $survey_question_table =  Engine_Api::_()->getDbtable('surveyquestions', 'user'); 
	   
	  if ($survey_question!=''){

	    $survey_question_table_insert_id =  $survey_question_table->insert(array(            
                    'questions' => $survey_question,  
                    'profile_type' => $profile_type,  
                    'created_at'=> date("Y-m-d"),
                    'updated_at'=> date("Y-m-d"),
                ));

	    return $this->_helper->redirector->gotoRoute(array('module'=>'user','controller'=>'manage','action' => 'surveyquestions'), '', true);

      }
     
    }
    public function editsurveyquestionAction()
    {
    $id = $this->_getParam('id', null);
  
    $this->view->form = $form = new User_Form_Admin_Manage_Editsurveyquestion(array(
      'surveyquestionIdentity' => $id,
    ));
    
     // Check method/valid
    if( !$this->getRequest()->isPost() ) {
      return;
    }
    if( !$form->isValid($this->getRequest()->getPost()) ) {
      return;
    }

    $values = $form->getValues();
    $survey_question_table =  Engine_Api::_()->getDbtable('surveyquestions', 'user');
    $survey_question_table->update(array('questions' =>$values['question']),array('id = ?' => $id));
    
     // Forward
    return $this->_forward('success', 'utility', 'core', array(
      'smoothboxClose' => true,
      'parentRefresh' => true,
      'format'=> 'smoothbox',
      'messages' => array('Your changes have been saved.')
    ));
    
    }
      public function deletesurveyquestionAction()
    {
    $id = $this->_getParam('id', null);
    $this->view->form = $form = new User_Form_Admin_Manage_Deletesurveyquestion();
    if( $this->getRequest()->isPost() ) {
    
      try {
         
         Engine_Db_Table::getDefaultAdapter()->delete('engine4_survey_questions', array('id = ?'=>$id) );
        
       
      } catch( Exception $e ) {
        throw $e;
      }
      
      return $this->_forward('success', 'utility', 'core', array(
        'smoothboxClose' => true,
        'parentRefresh' => true,
        'format'=> 'smoothbox',
        'messages' => array('Tip has been successfully deleted.')
      ));
      
     }

    }
    
          public function surveymailremainderAction()
    { 
      $common_settings_table =  Engine_Api::_()->getDbtable('commonsettings', 'user'); 
	  $common_settings = $common_settings_table->fetchRow($common_settings_table->select()->where('type =?', 'survey_mail_remainder'));
	    

   	  $this->view->form = $form = new User_Form_Admin_Manage_Surveymailremainder();
   	  $aData	=  $this->_request->getPost();
	  if(!empty($aData)){
	    $tip_duration	=	$aData['value'];
	    if(empty($common_settings)){
	  
	 
	        if($tip_duration!='')
	            {
	             $tips_table_insert_id =  $common_settings_table->insert(array(
                    'type'   => 'survey_mail_remainder',                   
                    'value' => $tip_duration,  
                    'created_at'=> date("Y-m-d"),
                    'updated_at'=> date("Y-m-d"),
                ));
               
			}
			
		}
		else
		{
	    $common_settings->value=$tip_duration;
	    $common_settings->save();
		}
        return $this->_forward('success', 'utility', 'core', array(
      'smoothboxClose' => true,
      'parentRefresh' => true,
      'format'=> 'smoothbox',
      'messages' => array('Your changes have been saved.')
          ));
    }
 }
 public function landlordsAction() {	 

    $table = Engine_Api::_()->getItemTable('user');
    $userTableName = $table->info('name');
    
                  
       $select   =   $table->select()
                        ->setIntegrityCheck(false)
                        ->from(array('user'=>'engine4_users',array('email','displayname','user_id')))                     
                        ->joinLeft(array('search_field'=>'engine4_user_fields_search'),'search_field.item_id=user.user_id',null)                                                                      
                        ->where('user.search=?' , 1)                      
                        ->where('search_field.profile_type =?' , '4')
                        ->group('user.user_id');

                        
                        
       $landlordData = $table->fetchAll($select);         
       $this->view->landlordData = $landlordData ;  
       
       $propertyTable =  Engine_Api::_()->getDbtable('propertylist', 'user');	 
       
       $tmpresult = array();
       $result = array();
       $tmpAnswerInfo = array();
       
       foreach($landlordData as $data){
		   
		   
		    $tmpresult['user_id']= $data['user_id'];
		    $tmpresult['email']= $data['email'];
		    $tmpresult['displayname']= $data['displayname'];
		   
		    $propertySelect   =   $propertyTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('plist'=>'engine4_property_list',))
                        ->where('plist.property_owner_id=?' , $data['user_id']); 
                        
            $propertyData = $propertyTable->fetchAll($propertySelect);                     
                       
		   
		   
		    $tmpresult['count_property']= count($propertyData);
		    
		    
		    $propertyRentedSelect   =   $propertyTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('plist'=>'engine4_property_list',))
                        ->where('plist.property_owner_id=?' , $data['user_id'])
                        ->where('plist.granted=?' , 1); 
		    $propertyRentedData = $propertyTable->fetchAll($propertyRentedSelect); 
		    
		    $tmpresult['rented_property']= count($propertyRentedData); 
		    
		    $propertyAvailableSelect   =   $propertyTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('plist'=>'engine4_property_list',))
                        ->where('plist.property_owner_id=?' , $data['user_id'])
                        ->where('plist.granted=?' , 0); 
		    $propertyAvailableData = $propertyTable->fetchAll($propertyAvailableSelect); 
		    
		    $tmpresult['available_property']= count($propertyAvailableData); 
		   
		   $tmpAnswerInfo[]	=	$tmpresult;
	   }
   
       
       
     $this->view->landlordpropertyData=$tmpAnswerInfo;
  
	 }
	 
	 public function availableAction() {
          
        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
			
		$connectionApi  =   Engine_Api::_()->getApi('connections', 'user'); 
		
		$html       =   $connectionApi->availablepropertyData();
		 
        return $html;	    
	 }
	 public function rentedAction() {
	 
	    $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
			
		$connectionApi  =   Engine_Api::_()->getApi('connections', 'user'); 
		
		$html       =   $connectionApi->rentedpropertyData();
		 
        return $html;	    
		
	 }
	 public function landlordpropertiesAction() {
	 		
	    $id = $this->_getParam('id', null);

        $this->view->formFilter = $formFilter = new User_Form_Admin_Manage_Landlordpropertiesfilter();


        $page = $this->_getParam('page', 1); 
        
        $propertyRequestTable =  Engine_Api::_()->getDbtable('propertyrequest', 'user');
		$propertyTable =  Engine_Api::_()->getDbtable('propertylist', 'user');
		$propertyTableName = $propertyTable->info('name');	
		$country_table =  Engine_Api::_()->getDbtable('countries', 'user'); 
		$country_tableName = $country_table->info('name');	
		$state_table   =  Engine_Api::_()->getDbtable('state', 'user'); 
		$state_tableName = $state_table->info('name');	
		$city_table   =  Engine_Api::_()->getDbtable('city', 'user'); 
		$city_tableName = $city_table->info('name');	
		
		$table = Engine_Api::_()->getItemTable('user');
        $userTableName = $table->info('name');
		

		// Process form
		$values = array();
		if( $formFilter->isValid($this->_getAllParams()) ) {
		  $values = $formFilter->getValues();
		}
        
        foreach( $values as $key => $value ) {
		if( null === $value ) {
			unset($values[$key]);
		  }
		}

		$values = array_merge(array(
		  'order' => 'id',
		  'order_direction' => 'DESC',
		), $values);
		
		$this->view->assign($values);
		
      
      $select = $propertyTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('plist'=>'engine4_property_list',))
                                             
                        ->joinLeft(array('country'=>'engine4_country_list',),'plist.country_id=country.id',array('country'))                       
                        ->joinLeft(array('state'=>'engine4_state_list',),'plist.state_id=state.state_id',array('state'))                       
                        ->joinLeft(array('city'=>'engine4_city_list',),'plist.city_id=city.city_id',array('city'))
                        ->joinLeft(array('user'=>'engine4_users'),'plist.property_owner_id=user.user_id',array('email','displayname'))  
                        
                        ->where('user.user_id = ?', $id)               
                        ->group('plist.id'); 

        
            // Set up select info
    $select->order(( !empty($values['order']) ? $values['order'] : 'id' ) . ' ' . ( !empty($values['order_direction']) ? $values['order_direction'] : 'DESC' ));

    if( !empty($values['propertyname']) ) {
      $select->where('property_name LIKE ?', '%' . $values['propertyname'] . '%');
    }
    if( !empty($values['landlordname']) ) {

         $select->where('displayname LIKE ?', '%' . $values['landlordname'] . '%');
         
    }
    if( !empty($values['rentaltype']) ) {
      $select->where('rental_type LIKE ?', '%' . $values['rentaltype'] . '%');
    }
    if( !empty($values['country']) ) {
      $select->where('country LIKE ?', '%' . $values['country'] . '%');
    }
    if( !empty($values['state']) ) {
      $select->where('state LIKE ?', '%' . $values['state'] . '%');
    }
    if( !empty($values['city']) ) {
      $select->where('city LIKE ?', '%' . $values['city'] . '%');
    }

    // Filter out junk
        $valuesCopy = array_filter($values);

 
        $propertyTable =  Engine_Api::_()->getDbtable('propertylist', 'user');	  
		$propertyimageTable =  Engine_Api::_()->getDbtable('propertyimages', 'user');	

    	$page = $this->_getParam('page', 1);
		 
		$this->view->paginator = $paginator = Zend_Paginator::factory($select);
		$this->view->paginator = $paginator->setCurrentPageNumber( $page );
		$this->view->paginator = $paginator->setItemCountPerPage(20);
		$this->view->formValues = $valuesCopy; 
		$this->renderScript('admin-manage/landlordproperties.tpl');	
	 }
	  public function rentersAction() {
	
		$this->view->formFilter = $formFilter = new User_Form_Admin_Manage_Renterfilter();	

        $page = $this->_getParam('page', 1); 
        
        // Process form
		$values = array();
		if( $formFilter->isValid($this->_getAllParams()) ) {
		  $values = $formFilter->getValues();
		}
        
        foreach( $values as $key => $value ) {
		if( null === $value ) {
			unset($values[$key]);
		  }
		}

		$values = array_merge(array(
		  'order' => 'user_id',
		  'order_direction' => 'DESC',
		), $values);
		
		$this->view->assign($values);
        
		$table = Engine_Api::_()->getItemTable('user');
		$userTableName = $table->info('name'); 	 		
    	$select   =   $table->select()
                        ->setIntegrityCheck(false)
                        ->from(array('user'=>'engine4_users',))
                        ->joinLeft(array('search_field'=>'engine4_user_fields_search'),'search_field.item_id=user.user_id',null)                                             
                        ->joinLeft(array('fields_value'=>'engine4_user_fields_values'),'fields_value.item_id=user.user_id',array('value'))                                             
                        ->joinLeft(array('state'=>'engine4_state_list',),'state.state_id=search_field.field_76',array('state'))                                  
                        ->joinLeft(array('city'=>'engine4_city_list',),'city.city_id=search_field.field_77',array('city'))                                  
                        ->where('user.search=?' , 1)                                         
                        ->where('user.enabled=?' , 1) 
                        ->where('search_field.profile_type =?' , '1') 
                        ->where('fields_value.field_id=?' , 13) 
                        ->group('user.user_id'); 

		 $select->order(( !empty($values['order']) ? $values['order'] : 'user_id' ) . ' ' . ( !empty($values['order_direction']) ? $values['order_direction'] : 'DESC' ));

			if( !empty($values['tenantname']) ) {
				 $select->where('displayname LIKE ?', '%' . $values['tenantname'] . '%');				 
			}
			if( !empty($values['email']) ) {
			  $select->where('email LIKE ?', '%' . $values['email'] . '%');
			}
			if( !empty($values['state']) ) {
			  $select->where('state LIKE ?', '%' . $values['state'] . '%');
			}
			if( !empty($values['city']) ) {
			  $select->where('city LIKE ?', '%' . $values['city'] . '%');
			}
		
    	 $valuesCopy = array_filter($values);
    	
    	$page = $this->_getParam('page', 1);
		 
		$this->view->paginator = $paginator = Zend_Paginator::factory($select);
		$this->view->paginator = $paginator->setCurrentPageNumber( $page );
		$this->view->paginator = $paginator->setItemCountPerPage(20);
		$this->view->formValues = $valuesCopy; 
		$this->renderScript('admin-manage/renters.tpl');	
    	
	  }
	  
	public function surveyrespondlaterdurationAction()
    { 
      $common_settings_table =  Engine_Api::_()->getDbtable('commonsettings', 'user'); 
	  $common_settings = $common_settings_table->fetchRow($common_settings_table->select()->where('type =?', 'survey_respond_later_duration'));
	    

   	  $this->view->form = $form = new User_Form_Admin_Manage_Surveyrespondlaterduration();
   	  $aData	=  $this->_request->getPost();
	  if(!empty($aData)){
	    $tip_duration	=	$aData['value'];
	    if(empty($common_settings)){
	  
	 
	        if($tip_duration!='')
	            {
	             $tips_table_insert_id =  $common_settings_table->insert(array(
                    'type'   => 'survey_respond_later_duration',                   
                    'value' => $tip_duration,  
                    'created_at'=> date("Y-m-d"),
                    'updated_at'=> date("Y-m-d"),
                ));
               
			}
			
		}
		else
		{
	    $common_settings->value=$tip_duration;
	    $common_settings->updated_at=date("Y-m-d");
	    $common_settings->save();
		}
        return $this->_forward('success', 'utility', 'core', array(
      'smoothboxClose' => true,
      'parentRefresh' => true,
      'format'=> 'smoothbox',
      'messages' => array('Your changes have been saved.')
          ));
    }
 }
 
     public function addsurveyansweroptionsAction()
    {
    $id = $this->_getParam('id', null);
  
    $this->view->form = $form = new User_Form_Admin_Manage_Addsurveyansweroptions(array(
      'surveyquestionIdentity' => $id,
    ));
    
     // Check method/valid
    if( !$this->getRequest()->isPost() ) {
      return;
    }
    if( !$form->isValid($this->getRequest()->getPost()) ) {
      return;
    }

    $values = $form->getValues();
    $survey_question_answerTable =  Engine_Api::_()->getDbtable('Surveyquestionsansweroptions', 'user');

    
    
    $answer	=	$values['answer'];
	 

	   
	if ($answer!=''){

	    $survey_question_answer_id =  $survey_question_answerTable->insert(array(            
                    'option' => $answer,  
                    'survey_question_id' => $id,  
                    'created_at'=> date("Y-m-d"),
                    'updated_at'=> date("Y-m-d"),
    ));
    
     // Forward
    return $this->_forward('success', 'utility', 'core', array(
      'smoothboxClose' => true,
      'parentRefresh' => true,
      'format'=> 'smoothbox',
      'messages' => array('Your changes have been saved.')
    ));
    
    }
 }
     public function pricelistAction(){
		$price_table =  Engine_Api::_()->getDbtable('price', 'user');
	    $price_select = $price_table->select();	
	     $priceData = $price_table->fetchAll($price_select);
		$this->view->priceData = $priceData;
	}
	public function addpriceAction(){

	  
	  $this->view->form = $form = new User_Form_Admin_Manage_Addprice();
	  
	  $aData	=  $this->_request->getPost();
	  
	  $price_from	=	$aData['price_from'];
	  $price_to	    =	$aData['price_to'];
	 
	  $price_table =  Engine_Api::_()->getDbtable('price', 'user'); 
	   
	  if($price_from !='' && $price_to!=''){
	  
	    $priceData = $price_table->fetchRow($price_table->select()->where('price_from = ?', $price_from)
	                                                              ->where('price_to = ?', $price_to));
	    if(empty($priceData)){
	   $price_id =  $price_table->insert(array(
                    'price_from' => $price_from,                   
                    'price_to' => $price_to,                                      
                    'created_at' => date('Y-m-d H:i:s'),
					'updated_at' => date('Y-m-d H:i:s'),                 
                ));
                
        return $this->_helper->redirector->gotoRoute(array('module'=>'user','controller'=>'manage','action' => 'pricelist'), '', true);
     
               
			}
      }
     
    }
    		public function editpriceAction()
    {
   $id = $this->_getParam('id', null);
    $this->view->form = $form = new User_Form_Admin_Manage_Editprice(array(
      'priceIdentity' => $id,
    ));
    
     // Check method/valid
    if( !$this->getRequest()->isPost() ) {
      return;
    }
    if( !$form->isValid($this->getRequest()->getPost()) ) {
      return;
    }

    $values = $form->getValues();
    $price_table =  Engine_Api::_()->getDbtable('price', 'user');
    $price_table->update(array('price_from' =>$values['price_from'],'price_to' =>$values['price_to']),array('id = ?' => $id));
    
     // Forward
    return $this->_forward('success', 'utility', 'core', array(
      'smoothboxClose' => true,
      'parentRefresh' => true,
      'format'=> 'smoothbox',
      'messages' => array('Your changes have been saved.')
    ));

    }
          public function deletepriceAction()
    {
    $id = $this->_getParam('id', null);
    $this->view->form = $form = new User_Form_Admin_Manage_Deleteitem();
    if( $this->getRequest()->isPost() ) {
    
      try {
         
         Engine_Db_Table::getDefaultAdapter()->delete('engine4_price', array('id = ?'=>$id) );
        
       
      } catch( Exception $e ) {
        throw $e;
      }
      
      return $this->_forward('success', 'utility', 'core', array(
        'smoothboxClose' => true,
        'parentRefresh' => true,
        'format'=> 'smoothbox',
        'messages' => array('Tip has been successfully deleted.')
      ));
      
     }

    }
    public function transunionAction(){
	  $settings = Engine_Api::_()->getApi('settings', 'core'); 
      $this->view->form = $form = new User_Form_Admin_Manage_Transunion();
      $form->getElement('user_backgroundReportExpiry')->setValue(isset($settings->user_backgroundReportExpiry) ? $settings->user_backgroundReportExpiry : '30');
      $form->getElement('user_creditAndBackgroundPaymentAmount')->setValue(isset($settings->user_creditAndBackgroundPaymentAmount) ? $settings->user_creditAndBackgroundPaymentAmount : '49.99');
      $form->getElement('user_creditAndBackgroundPlusEvictionPaymentAmount')->setValue(isset($settings->user_creditAndBackgroundPlusEvictionPaymentAmount) ? $settings->user_creditAndBackgroundPlusEvictionPaymentAmount : '59.99');
      $form->getElement('user_creditScorePaymentAmount')->setValue(isset($settings->user_creditScorePaymentAmount) ? $settings->user_creditScorePaymentAmount : '9.99');
      $form->getElement('user_deductionPerEachPayment')->setValue(isset($settings->user_deductionPerEachPayment) ? $settings->user_deductionPerEachPayment : '5');
      $form->getElement('user_numberOfReportSharePerDay')->setValue(isset($settings->user_numberOfReportSharePerDay) ? $settings->user_numberOfReportSharePerDay : '5');
     		
     if( $this->getRequest()->isPost()&& $form->isValid($this->getRequest()->getPost()))
     {
      $values = $form->getValues();
       foreach ($values as $key => $value){
        $settings->$key = $value;
      }
      $form->addNotice('Your changes have been saved.');
    }
		
	}
	public function transunionenableAction(){
		
	$SmartmoveApiManageTable = Engine_Api::_()->getDbtable('smartmoveapimanage', 'user');
    

	$select =	$SmartmoveApiManageTable->fetchRow($SmartmoveApiManageTable->select());	
	
		
	$this->view->form = $form = new User_Form_Admin_Manage_Transunion(array(
        'isEnable' => $select->enable,
    ));
		 // Check method/valid
    if( !$this->getRequest()->isPost() ) {
      return;
    }
    if( !$form->isValid($this->getRequest()->getPost()) ) {
      return;
    }
    
    $values = $form->getValues(); 
    
    
				
	if(count($select)>0){
		
		$select->enable = $values['transunion'];
		$select->updated_at = date('Y-m-d');
        $select->save();
		
		
	}
	else{
		
		$SmartmoveApiManageTable_id =  $SmartmoveApiManageTable->insert(array(
                    'enable' => $values['transunion'], 
                    'created_at' => date('Y-m-d'), 
                    'updated_at' => date('Y-m-d')
                                      
                ));
		
	}
	/*return $this->_forward('success', 'utility', 'core', array(
      'smoothboxClose' => true,
      'parentRefresh' => true,
      'format'=> 'smoothbox',
      'messages' => array('Your changes have been saved.')
    ));		*/
	return $this->_helper->redirector->gotoRoute(array('action' => 'transunion'));	
		
	}
	public function holdingpropertyAction(){
		
		$propertyTable        =  Engine_Api::_()->getDbtable('propertylist', 'user');
        $propertySelect   =   $propertyTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('plist'=>'engine4_property_list',))
                        ->joinLeft(array('country'=>'engine4_property_countries',),'plist.prty_country_id=country.country_id',array('prty_country'))
                        ->joinLeft(array('state'=>'engine4_property_states',),'plist.prty_state_id=state.state_id',array('prty_state'))
                        ->joinLeft(array('city'=>'engine4_property_city',),'plist.prty_city_id=city.city_id',array('prty_city','zipcode','latitude','longitude'))
                        ->joinLeft(array('smartmoveapi_property'=>'engine4_smartmoveapi_property'),'plist.id=smartmoveapi_property.Pid')
                        ->where('plist.property_type=?' , 'holding_property');
       //echo $propertySelect; exit;
       $this->view->PropertyData = $PropertyData  = $propertyTable->fetchRow($propertySelect);
       
	}
	public function saveholdingpropertyAction(){
		
		$this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        $aData     = $this->_request->getPost();
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
                    'property_type'           => 'holding_property',
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
                    'vouchers'                => $aData['accept_vouchers'],
                    'wheelchair_accessible'   => $aData['wheel_chair_accessible'],
                    'months_of_deposits'      => $aData['months_of_deposits'],
                    'property_manager'        => $aData['have_property_manager'],
                    'provide_parking'         => $aData['parking'],
                    'no_of_rooms'             => $aData['number_of_rooms'],
                    'housing_type'            => $aData['housing_type'],
                    'has_pets'                => $aData['allowed_pets'],
                    'pets_type'               => $aData['pets_type'],
                    'landlord_enable'         => 1,
                    'enable'                  => 1,
                    'created_at'              => date('Y-m-d H:i:s'),
                ));
			
			    /********************smartmove api call create property start**************/
			    
			    $smartmoveapiquestions_table      =  Engine_Api::_()->getDbtable('smartmoveapiquestions', 'user');
				$smartmoveapiquestionAnswer_table =  Engine_Api::_()->getDbtable('Smartmoveapiquestionanswers', 'user');
				$viewHelperObj                    =  $this->view->getHelper('SmartmoveApi');
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
				$Questions        = $viewHelperObj -> getPropertyQuestionArray();
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
						}
						else{
							$aResult['status'] = false;
							$aResult['errors'] = $data['Errors'];
						}
              }

			    
			    
		}catch (Exception $e) {exit($e->getMessage());
                                $aResult['status'] = false;
                            }
        echo json_encode($aResult);
	}
	public function saveedittedholdingpropertyAction(){
		$this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        $aData     = $this->_request->getPost();
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
			    $property               =  $propertyTable->fetchRow($propertyTable->select()->where('property_type = ?', 'holding_property'));
                $propertyid  = $property->id;  
			   
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
                

                $property->property_owner_id     = $user_id;
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
                $property->vouchers              = $aData['accept_vouchers'];
                $property->wheelchair_accessible = $aData['wheel_chair_accessible'];
                $property->months_of_deposits    = $aData['months_of_deposits'];
                $property->property_manager      = $aData['have_property_manager'];
                $property->provide_parking       = $aData['parking'];
                $property->created_at            =date('Y-m-d H:i:s');
                $property->save();
                
                
                
                /********************smartmove api call edit property start**************/
			    
			    $smartmoveapiquestions_table      =  Engine_Api::_()->getDbtable('smartmoveapiquestions', 'user');
				$smartmoveapiquestionAnswer_table =  Engine_Api::_()->getDbtable('Smartmoveapiquestionanswers', 'user');
				$viewHelperObj                    =  $this->view->getHelper('SmartmoveApi');
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
				$Questions        = $viewHelperObj -> getPropertyQuestionArray();
				$smartmoveapiProperty_table =  Engine_Api::_()->getDbtable('Smartmoveapiproperty', 'user');
                $smartmoveapiPropertyData    = $smartmoveapiProperty_table->fetchRow($smartmoveapiProperty_table->select()->where('Pid  = ?', $property->id));
 
				$params = array(
				'PropertyId'         => $smartmoveapiPropertyData ->SmartmovePropertyId,
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
			    $response        = $viewHelperObj->updateproperty($params);
			    $data            = json_decode($response, true); 

				if ($response === false)
				{ 
					$aResult['status'] = false;
					$aResult['errors'] = curl_error($crl);
				}
			   else{
					if(empty($data['Errors'])){
                    $smartmoveapiPropertyData-> PropertyIdentifier = $data['PropertyIdentifier'];
                    $smartmoveapiPropertyData-> OrganizationName   = $data['OrganizationName'];
                    $smartmoveapiPropertyData-> OrganizationId     = $data['OrganizationId'];
                    $smartmoveapiPropertyData-> Active             = $data['Active'];
                    $smartmoveapiPropertyData-> Name               = $data['Name'];
                    $smartmoveapiPropertyData-> FirstName          = $FirstName ;
                    $smartmoveapiPropertyData-> LastName           = $LastName;
                    $smartmoveapiPropertyData-> Street             = $data['Street'];
                    $smartmoveapiPropertyData-> City               = $data['City'];
                    $smartmoveapiPropertyData-> State              = $data['State'];
                    $smartmoveapiPropertyData-> Zip                = $data['Zip'];
                    $smartmoveapiPropertyData-> Phone              = $data['Phone'];
                    $smartmoveapiPropertyData-> PhoneExtension     = $data['PhoneExtension'];
                    $smartmoveapiPropertyData-> Classification     = $data['Classification'];
                    $smartmoveapiPropertyData-> IR                            = $data['IR'];
                    $smartmoveapiPropertyData-> IncludeMedicalCollections     = $data['IncludeMedicalCollections'];
                    $smartmoveapiPropertyData-> IncludeForeclosures           = $data['IncludeForeclosures'];
                    $smartmoveapiPropertyData-> DeclineForOpenBankruptcies    = $data['DeclineForOpenBankruptcies'];
                    $smartmoveapiPropertyData-> OpenBankruptcyWindow          = $data['OpenBankruptcyWindow'];
                    $smartmoveapiPropertyData-> IsFcraAgreementAccepted       = $data['IsFcraAgreementAccepted'];
                    $smartmoveapiPropertyData-> UnitNumber           = $data['UnitNumber'];
                    $smartmoveapiPropertyData-> landlordData         = $LandlordDataJson;
                    $smartmoveapiPropertyData-> Deposit              = $aData['Deposit'];
                    $smartmoveapiPropertyData-> Rent                 = $aData['Rent'];
                    $smartmoveapiPropertyData-> LandlordPays         = $aData['LandlordPays'];
                    $smartmoveapiPropertyData-> ProductBundle        = $aData['ProductBundle'];
                    $smartmoveapiPropertyData-> updated_at           = date('Y-m-d');
                    $smartmoveapiPropertyData-> save();
                    $aResult['status'] = true;
                }
                else{
                    $aResult['status'] = false;
                    $aResult['errors'] = $data['Errors'];
                }
              }
                
			 
			 }catch (Exception $e) {exit($e->getMessage());
                                $aResult['status'] = false;
                            }
		echo json_encode($aResult);
	}
	
	public function holdingapplicationAction(){
		
		
	}
	public function saveholdingapplicationAction(){
		
		$this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        $viewer      = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $viwer_id    = Engine_Api::_()->user()->getViewer()->getIdentity();
        $aResult     =   array();
        $aData       = $this->_request->getPost();
        $userTable            = Engine_Api::_()->getDbtable('users', 'user');        
        $propertyTable        =  Engine_Api::_()->getDbtable('propertylist', 'user');
        $propertyData         =  $propertyTable->fetchRow($propertyTable->select()->where('property_type = ?', 'holding_property'));
        $rentalApplicationsTable =  Engine_Api::_()->getDbtable('rentalapplications', 'user');
        
        try{               
               /* smartmove api create application start*/ 
                
              $smartmoveapiProperty_table    =  Engine_Api::_()->getDbtable('Smartmoveapiproperty', 'user');
              $smartmoveapiPropertyData      = $smartmoveapiProperty_table->fetchRow($smartmoveapiProperty_table->select()->where('Pid  = ?', $propertyData->id));
              $PropertyId           = $smartmoveapiPropertyData->SmartmovePropertyId;
              $UnitNumber           = $smartmoveapiPropertyData->UnitNumber;
              $smartmoveapiPropertyData->Deposit              = $aData['Deposit'];
              $smartmoveapiPropertyData->Rent                 = $aData['Rent'];
              $smartmoveapiPropertyData->LeaseTermInMonths    = $aData['LeaseTermInMonths'];
              $smartmoveapiPropertyData->LandlordPays         = $aData['LandlordPays'];
              $smartmoveapiPropertyData->ProductBundle        = $aData['ProductBundle'];
              $smartmoveapiPropertyData->save();
              $aResult['status'] = true;
        
        }catch (Exception $e) {exit($e->getMessage());
                                $aResult['status'] = false;
                                $aResult['message'] = 'Failed';
                            }
        echo json_encode($aResult);
	}

	public function advertisementsAction(){ 
		
		
		$this->view->formFilter = $formFilter = new User_Form_Admin_Manage_Advertisementfilter();	

		$values = array();
		if( $formFilter->isValid($this->_getAllParams()) ) {
		  $values = $formFilter->getValues();
		}
        
        foreach( $values as $key => $value ) {
		if( null === $value ) {
			unset($values[$key]);
		  }
		}

		$values = array_merge(array(
		  'order' => 'id',
		  'order_direction' => 'DESC',
		), $values);
		
		$this->view->assign($values);

		$advertisementTable = Engine_Api::_()->getDbtable('advertisement', 'user');	

        $select = $advertisementTable->getAdapter()->select()
						->from(array('advertisement'=>'engine4_advertisement',));
						 
		 $select->order(( !empty($values['order']) ? $values['order'] : 'id' ) . ' ' . ( !empty($values['order_direction']) ? $values['order_direction'] : 'DESC' ));

			if( !empty($values['advertisement_title']) ) {
			  $select->where('title LIKE ?', '%' . $values['advertisement_title'] . '%');
			}
		
		
    $valuesCopy = array_filter($values);	
	
				  
    $page = $this->_getParam('page', 1);
		 
	$this->view->paginator = $paginator = Zend_Paginator::factory($select);
    $this->view->paginator = $paginator->setCurrentPageNumber( $page );
    $this->view->paginator = $paginator->setItemCountPerPage(20);
    $this->view->formValues = $valuesCopy; 
		
    $this->renderScript('admin-manage/advertisements.tpl');	
	  

	}
	
	
	
 public function saveadvertisementphotoAction(){

        $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        if( $this->getRequest()->isPost()){
            $aData           = $this->_request->getPost();
            $photo_title     = $aData['upload_image_title'];
            $website         = $aData['website'];
            $date_from       = $aData['date_from'];
            $date_to         = $aData['date_to'];

            $random_filename = $this->random_string(8);
            $dir             = dirname($_SERVER['SCRIPT_FILENAME']).'/public/images/advertisement/';
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
                    $AdvertisementTable     = Engine_Api::_()->getDbtable('advertisement', 'user');
                    $AdvertisementTableId   = $AdvertisementTable->insert(array(
                      'user_id'         => $viewer->getIdentity(),
                      'title'     => $photo_title,
                      'ad_url'    => $website,
                      'date_from' => $date_from,
                      'date_to'   => $date_to,
                      'image'            => 'public/images/advertisement/'.$random_filename,
                      'created_at'      => date('Y-m-d H:i:s'),
                      'updated_at'      => date('Y-m-d H:i:s'),

                    ));


           $aResult['status']                      = true;
           }
           else {
                 $aResult['status'] = false;
                }
            }
            echo json_encode($aResult);
         }
 
         
     }
 public function deleteadvertisementAction(){
    $id = $this->_getParam('id', null);
    $this->view->form = $form = new User_Form_Admin_Manage_Deleteitem();
    if( $this->getRequest()->isPost() ) {
    
      try {                     
        $Advertisement_table =  Engine_Api::_()->getDbtable('advertisement', 'user'); 
	    $advertisement = $Advertisement_table->fetchRow($Advertisement_table->select()->where('id =?', $id));

        
        Engine_Db_Table::getDefaultAdapter()->delete('engine4_advertisement', array('id = ?'=>$id) );
        unlink($advertisement->image);
       
      } catch( Exception $e ) {
        throw $e;
      }
      
      return $this->_forward('success', 'utility', 'core', array(
        'smoothboxClose' => true,
        'parentRefresh' => true,
        'format'=> 'smoothbox',
        'messages' => array('Advertisement has been successfully deleted.')
      ));
      
     }
     
     }
	     
	/*public function editadvertisementAction()
    {
    $id = $this->_getParam('id', null);
    
    $this->view->form = $form = new User_Form_Admin_Manage_Editadvertisement(array(
      'advIdentity' => $id,
    ));
    
     // Check method/valid
    if( !$this->getRequest()->isPost() ) {
      return;
    }
    if( !$form->isValid($this->getRequest()->getPost()) ) {
      return;
    }

    $values = $form->getValues(); 

    $AdvertisementTable     = Engine_Api::_()->getDbtable('advertisement', 'user');
    
    $AdvertisementData      = $AdvertisementTable->fetchRow($AdvertisementTable->select()->where('id = ?', $id));
    
    if($_FILES["image"]["name"]  != ''){ //print_r($_FILES);
		
		    $random_filename = $this->random_string(8);
            $dir             = dirname($_SERVER['SCRIPT_FILENAME']).'/public/images/advertisement/';
                            if(!is_dir($dir)){
                                mkdir($dir,0777,true);
                            }
            $target_file     = $dir . basename($_FILES["image"]["name"]);
            
            $imageFileType   =  pathinfo($target_file,PATHINFO_EXTENSION);
            $random_filename =  $random_filename.'.'.$imageFileType;
		if($imageFileType != "JPG" && $imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg" &&  $imageFileType != "JPEG" &&  $imageFileType != "PNG") {				

                $aResult['msg']    = "Sorry, only JPG, JPEG, & PNG  files are allowed.";
                $aResult['status'] = false;
            }
        else{
			    echo $target_file   = $dir . $random_filename;	exit;	           
			     $result = move_uploaded_file($_FILES["image"]["tmp_name"], $target_file);
                 if ($result) {exit("ggg");					
                    $AdvertisementData->image       = 'public/images/advertisement/'.$random_filename;
                    $AdvertisementData->updated_at  = date('Y-m-d H:i:s');
                    $AdvertisementData->save();
                 }
                 else{
					 exit("hhhh");
				 }
		 }   
		
	}
    $AdvertisementData->title       = $values['title'];
    $AdvertisementData->ad_url      = $values['website'];
    $AdvertisementData->date_from   = $values['date_from'];
    $AdvertisementData->date_to     = $values['date_to'];
    $AdvertisementData->updated_at  = date('Y-m-d H:i:s');
    $AdvertisementData->save();
    
    
     // Forward
    return $this->_forward('success', 'utility', 'core', array(
      'smoothboxClose' => true,
      'parentRefresh' => true,
      'format'=> 'smoothbox',
      'messages' => array('Your changes have been saved.')
    ));
    
    }	*/
    
     public function editadvertisementAction(){ 
		$viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
		if( $this->getRequest()->isPost()){
			$aData           = $this->_request->getPost();
            $photo_title     = $aData['upload_image_title'];
            $website         = $aData['website'];
            $date_from       = $aData['date_from'];
            $date_to         = $aData['date_to'];
            $advertisementId              = $aData['advertisementId'];

            $AdvertisementTable           = Engine_Api::_()->getDbtable('advertisement', 'user');
            $advertisementData            =  $AdvertisementTable->fetchRow($AdvertisementTable->select()->where('id =?', $advertisementId));
            
            if( $_FILES["edit_upload_image"]["name"] != ''){
            
					$random_filename = $this->random_string(8);
					$dir             = dirname($_SERVER['SCRIPT_FILENAME']).'/public/images/advertisement/';
									if(!is_dir($dir)){
										mkdir($dir,0777,true);
									}
					$target_file     = $dir .'/'. basename($_FILES["edit_upload_image"]["name"]);
					
					$imageFileType   = pathinfo($target_file,PATHINFO_EXTENSION);
					$random_filename =  $random_filename.'.'.$imageFileType;

					if($imageFileType != "JPG" && $imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg" &&  $imageFileType != "JPEG" &&  $imageFileType != "PNG") {				

						$aResult['msg']    = "Sorry, only JPG, JPEG, & PNG  files are allowed.";
						$aResult['status'] = false;
					}
					else{
						$target_file   = $dir .'/'. $random_filename;
						if (move_uploaded_file($_FILES["edit_upload_image"]["tmp_name"], $target_file)) {                   
							$advertisementData->image     = 'public/images/advertisement/'.$random_filename;                   
							$aResult['status']                      = true;
				   }
				   else {
						 $aResult['status'] = false;
						}
					}
		      }           
                    $advertisementData->title     = $photo_title;
                    $advertisementData->ad_url    = $website;
                    $advertisementData->date_from = $date_from;
                    $advertisementData->date_to   = $date_to;
                    $advertisementData->updated_at=  date('Y-m-d H:i:s');
                    $advertisementData->save();
                    $aResult['status'] = true;
		}
		else {
                 $aResult['status'] = false;
                }
		echo json_encode($aResult);
	 }
	
 public function getadvertisementAction(){ 
	    $viewer     = Engine_Api::_()->user()->getViewer();
        date_default_timezone_set($viewer->timezone);
        $this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
        if( $this->getRequest()->isPost()){
            $aData           = $this->_request->getPost();
            $id     = $aData['id'];
            $Advertisement_table  =  Engine_Api::_()->getDbtable('advertisement', 'user'); 
	        $advertisement        =  $Advertisement_table->fetchRow($Advertisement_table->select()->where('id =?', $id));
	        $aResult['title']     =  $advertisement->title;
	        $aResult['ad_url']    =  $advertisement->ad_url;
	        $aResult['date_from'] =  $advertisement->date_from;
	        $aResult['date_to']   =  $advertisement->date_to;
	        $aResult['status']    =  true;
            
		}
		else{
			$aResult['status']    =  false;
		}
		echo json_encode($aResult);
 }

	public function userpackagemanageAction(){
		
      $settings = Engine_Api::_()->getApi('settings', 'core'); 
      $this->view->form = $form = new User_Form_Admin_Manage_Packagemanage();
      $form->getElement('user_landlordProPrice')->setValue(isset($settings->user_landlordProPrice) ? $settings->user_landlordProPrice : '10');
      $form->getElement('user_managementGoldPrice')->setValue(isset($settings->user_managementGoldPrice) ? $settings->user_managementGoldPrice : '10');
      $form->getElement('user_videoPrice')->setValue(isset($settings->user_videoPrice) ? $settings->user_videoPrice : '10');
      $form->getElement('user_premiumLevelProvision')->setValue(isset($settings->user_premiumLevelProvision) ? $settings->user_premiumLevelProvision : '2');
      $form->getElement('user_basicScoutLimit')->setValue(isset($settings->user_basicScoutLimit) ? $settings->user_basicScoutLimit : '1');
      $form->getElement('user_landlordProScoutLimit')->setValue(isset($settings->user_landlordProScoutLimit) ? $settings->user_landlordProScoutLimit : '10');
      $form->getElement('user_basicPropertyLimit')->setValue(isset($settings->user_basicPropertyLimit) ? $settings->user_basicPropertyLimit : '1');
      $form->getElement('user_landlordProPropertyLimit')->setValue(isset($settings->user_landlordProPropertyLimit) ? $settings->user_landlordProPropertyLimit : '10');
		
     if( $this->getRequest()->isPost()&& $form->isValid($this->getRequest()->getPost()))
     {
      $values = $form->getValues();
       foreach ($values as $key => $value){
        $settings->$key = $value;
      }
      $form->addNotice('Your changes have been saved.');
    }
		
		
	}
	
	public function userpackageAction(){

	$this->view->formFilter = $formFilter = new User_Form_Admin_Manage_Userpackagefilter();	

	$page = $this->_getParam('page', 1); 

	$userPackagesTable = Engine_Api::_()->getDbtable('Userpackages', 'user');
	$userPackagesTableName = $userPackagesTable->info('name');	
	// Process form
	$values = array();
	if( $formFilter->isValid($this->_getAllParams()) ) {
	$values = $formFilter->getValues();
	}

	foreach( $values as $key => $value ) {
	if( null === $value ) {
	unset($values[$key]);
	}
	}

	$values = array_merge(array(
	'order' => 'payment_id',
	'order_direction' => 'DESC',
	), $values);

	$this->view->assign($values);

	$select = $userPackagesTable->select()
	->setIntegrityCheck(false)
	->from(array('userpackage'=>'engine4_user_packages',)) 
	->joinLeft(array('user'=>'engine4_users',),'userpackage.user_id=user.user_id',array('displayname')); 
	// Set up select info
	$select->order(( !empty($values['order']) ? $values['order'] : 'payment_id' ) . ' ' . ( !empty($values['order_direction']) ? $values['order_direction'] : 'DESC' ));

	if( !empty($values['customername']) ) {
	$select->where('displayname LIKE ?', '%' . $values['customername'] . '%');
	}
	// Filter out junk
	$valuesCopy = array_filter($values);


	$page = $this->_getParam('page', 1);

	$this->view->paginator = $paginator = Zend_Paginator::factory($select);
	$this->view->paginator = $paginator->setCurrentPageNumber( $page );
	$this->view->paginator = $paginator->setItemCountPerPage(20);
	$this->view->formValues = $valuesCopy; 
	$this->renderScript('admin-manage/userpackage.tpl');	


	}
	
	public function videopaymentAction(){
		
	$this->view->formFilter = $formFilter = new User_Form_Admin_Manage_Videopaymentfilter();	

	$page = $this->_getParam('page', 1); 

	$videoPaymentTable = Engine_Api::_()->getDbtable('Videopayment', 'user');
	$videoPaymentTableName = $videoPaymentTable->info('name');	
	// Process form
	$values = array();
	if( $formFilter->isValid($this->_getAllParams()) ) {
	$values = $formFilter->getValues();
	}

	foreach( $values as $key => $value ) {
	if( null === $value ) {
	unset($values[$key]);
	}
	}

	$values = array_merge(array(
	'order' => 'payment_id',
	'order_direction' => 'DESC',
	), $values);

	$this->view->assign($values);

	$select = $videoPaymentTable->select()
	->setIntegrityCheck(false)
	->from(array('videopayment'=>'engine4_payment_video',)) 
	->joinLeft(array('user'=>'engine4_users',),'videopayment.user_id=user.user_id',array('displayname')); 
	// Set up select info
	$select->order(( !empty($values['order']) ? $values['order'] : 'payment_id' ) . ' ' . ( !empty($values['order_direction']) ? $values['order_direction'] : 'DESC' ));

	if( !empty($values['customername']) ) {
	$select->where('displayname LIKE ?', '%' . $values['customername'] . '%');
	}
	// Filter out junk
	$valuesCopy = array_filter($values);


	$page = $this->_getParam('page', 1);

	$this->view->paginator = $paginator = Zend_Paginator::factory($select);
	$this->view->paginator = $paginator->setCurrentPageNumber( $page );
	$this->view->paginator = $paginator->setItemCountPerPage(20);
	$this->view->formValues = $valuesCopy; 
	$this->renderScript('admin-manage/videopayment.tpl');	


		
		
		}

public function specialdocumentsAction(){
	
}
public function addspecialdocumentsAction(){
	
	$spclDir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/specialdocuments';
		
		if (!is_dir($dir)) {
				mkdir($spclDir, 0777, true);
		}
			
	$dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/specialdocuments/';
	if (is_dir($dir)) {
		
		$files =	$this->loaddirectory($dir);
		
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
				   $tmpArrayFile[]	=	array('file_id'=>$dropboxfileData->id,'filename'=>$file['filename'],'is_image'=>$is_image,'file_title'=>$dropboxfileData->file_title,'file_owner_id'=> $dropboxfileData->file_owner_id,'file_path'=> $dropboxfileData->file_path,'created_at'=> $dropboxfileData->created_at);  
		   
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
	   public function createspecialdirectoryAction() {
		
		$this->_helper->viewRenderer->setNoRender(true);
		$this->_helper->layout->disableLayout();
		
		$user_id=Engine_Api::_()->user()->getViewer()->getIdentity(); 
		$viewer     = Engine_Api::_()->user()->getViewer();		
		
		$aData = $this->_request->getPost(); 

		$folder_name	=	$aData['folder_name'];
		$cur_dir     	=	$aData['cur_dir'];
		$li_count   	=	$aData['li_count']+1;

		if($cur_dir ==''){
		   $dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/specialdocuments/'.$folder_name;
	    }
	   else{		   
		   $dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/specialdocuments/'.$cur_dir.'/'.$folder_name;
	   }
		if (!is_dir($dir)) {
				mkdir($dir, 0777, true);
				$aResult['msg'] ='Document is successfully created';
				$aResult['content'] = '<li class="dir_li list'.$li_count.'" dir-name="'.$folder_name.'"><a href="javascript:void(0)" class="dir_open" dir-name="'.$folder_name.'">'.$folder_name.'</a><span class="option_links"> <a href="javascript:void(0)" class="dir_delete" dir-name="'.$folder_name.'" li-count="'.$li_count.'">Delete</a></span><hr></li>';
		}
		else{
			$aResult['msg'] ='This directory is already existed.';
			$aResult['content'] ='';
		}
	
		
		echo json_encode($aResult);

	}
	
public function getspecialdirectorycontentsAction(){
		
		$this->_helper->viewRenderer->setNoRender(true);
		$this->_helper->layout->disableLayout();
		$viewer     = Engine_Api::_()->user()->getViewer();
		$aData = $this->_request->getPost(); 
		$dirname	            =	$aData['dirname'];
	    $current_directory	    =	$aData['current_directory'];
	    $menu_open	    =	$aData['menu_open'];
		if($current_directory == ''){	
			if($menu_open == 0){
			$dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/specialdocuments/'.$dirname;
		}
		else{
		$dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/specialdocuments/'.$current_directory.'/'.$dirname;
	    }
	    $file_path = '/filemanager/specialdocuments/'.$current_directory.'/'.$dirname.'/';
		//$doc_path =  'specialdocuments/'.$current_directory.'/'.$dirname.'/';
		$doc_path =  'specialdocuments/'.$dirname.'/';
	    }
        else{
		if($menu_open == 0){
		$dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/specialdocuments/'.$current_directory.'/'.$dirname;
	    }
		else{
			$dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/specialdocuments/'.$current_directory;
		}
		$file_path = '/filemanager/specialdocuments'.$current_directory.'/'.$dirname.'/';
		if($menu_open == 0){
		 $doc_path =  'specialdocuments'.$current_directory.'/'.$dirname.'/';
	    }
	    else{
			$doc_path =  'specialdocuments'.$current_directory.'/';
		}
	    }
		$files =	$this->loaddirectory($dir);
		$dropboxfileTable = Engine_Api::_()->getDbtable('dropboxfiles', 'user');    
        foreach($files['files'] as $file){		
		   $doc_path1 = $doc_path.$file['filename']; 
		   $dropboxfileData = $dropboxfileTable->fetchRow($dropboxfileTable->select()->where('file_path LIKE ?', $doc_path1.'%'));	 	
		   $tmpArrayFile[]	=	array('file_id'=>$dropboxfileData->id,'filename'=>$file['filename'],'file_title'=>$dropboxfileData->file_title,'file_owner_id'=> $dropboxfileData->file_owner_id,'file_path'=> $dropboxfileData->file_path,'created_at'=> $dropboxfileData->created_at);  
	    }
		
		$tmpResultData['directories'] = $files['directories'];
		$tmpResultData['files'] = $tmpArrayFile; 
		$files = $tmpResultData;
		$a= '';
		$b= '';
		$i=1;
		 if(count($files['directories'])>0){		
		foreach($files['directories'] as $dir){ 
		$a = $a .'<li class="dir_li list'.$i.'" dir-name="'.$dir['dirname'].'"><a href="javascript:void(0)" class="dir_open" dir-name="'.$dir['dirname'].'">'.$dir['dirname'].'</a><span class="option_links"> <a href="javascript:void(0)" class="dir_delete" dir-name="'.$dir['dirname'].'" li-count="'.$i.'">Delete</a></span><hr></li>';
		 $i++;
		 }
		}
			if(count($files['files'])>0){				
				
			foreach($files['files'] as $dir){
			$doc_path1  =  $doc_path.$dir['filename'];
            $file_name =  dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$doc_path1;
            if(@is_array(getimagesize($file_name))){
            $is_image = 1;
            }
            else{
                $is_image = 0;
            }
            
            if($is_image == 1){
				$b = $b . '<li class="file_li list'.$i.'" file-name="'.$dir['filename'].'"><a href="/filemanager/'.$doc_path1.'" target="_blank" data-lightbox="image1">'.$dir['file_title'].'</a><span class="option_links">  <a href="javascript:void(0)" class="file_delete" file-name="'.$dir['filename'].'" li-count="'.$i.'" file-id="'.$dir['file_id'].'">Delete</a></span><hr></li>';
			}
			else{
			  $b = $b . '<li class="file_li list'.$i.'" file-name="'.$dir['filename'].'"><a href="/filemanager/'.$doc_path1.'" target="_blank">'.$dir['filetitle'].'</a><span class="option_links">  <a href="javascript:void(0)" class="file_delete" file-name="'.$dir['filename'].'" li-count="'.$i.'" file-id="'.$dir['file_id'].'">Delete</a></span><hr></li>';

			}
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
		$arr = explode("/",$current_directory);
		$menu ='';
		$arr_i='';
		for($i=0;$i<count($arr);$i++){
			if($i !=0 ){
				$arr_i =$arr_i.'/'.$arr[$i];
			$menu= $menu.'<a href="javascript:void(0)" class="menu_dir_open 55" dir_path ="'.$arr_i.'" > / '.$arr[$i].'</a>';
		}
		}
		if($menu_open == 0){
		$aResult['cur_dir_menu'] = $menu. ' / <a href="javascript:void(0)" class="menu_dir_open" dir_path="'.$current_directory.'/'.$dirname.'">'.$dirname.'</a>' ;
	    }
	    else{
			
		$aResult['cur_dir_menu'] = $menu;
		}
		echo json_encode($aResult);
	
	}
		public function savespecialfileAction(){
		
		$viewer     = Engine_Api::_()->user()->getViewer();
		$this->_helper->viewRenderer->setNoRender(true);
		$this->_helper->layout->disableLayout();
		 if( $this->getRequest()->isPost()){
			 
			  $aData = $this->_request->getPost(); 
			  
			$cur_dir = $aData['cur_dir']; 
			$upload_file_title = $aData['upload_file_title']; 
			$user_id = $viewer->getIdentity(); 

			$dirname =   'specialdocuments'; 
			
			$random_filename =  $this->random_string(8);
			
			if($cur_dir ==''){

			$dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dirname;
			$filepath = $dirname.'/'. $random_filename; 
			$dir_structure = $dirname;
			}
			else{
				   
			   $dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dirname.$cur_dir; 
			   $filepath = $dirname.$cur_dir.'/'. $random_filename;  
			   $dir_structure = $dirname.$cur_dir;
			}
			  
		    $target_file = $dir .'/'. basename($_FILES["upload_files"]["name"]); 
		    $imageFileType = pathinfo($target_file,PATHINFO_EXTENSION);
		    
		    
		    $random_filename =  $random_filename.'.'.$imageFileType; 
		    
		    $filepath =$filepath.'.'.$imageFileType; 
		    
		    if($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg" && $imageFileType != "pdf" ) {
				
				$aResult['msg'] = "Sorry, only PDF, JPG, JPEG, & PNG  files are allowed.";
				$aResult['status'] = false;
			}
		    else{
				
			$target_file = $dir .'/'. $random_filename; 
		    
			if (move_uploaded_file($_FILES["upload_files"]["tmp_name"], $target_file)) {
				
				$aResult['status'] = $_FILES["upload_files"]["name"];
				$aResult['msg'] = "File is successfully uploaded.";
				
			$dropboxfileTable = Engine_Api::_()->getDbtable('dropboxfiles', 'user');
			

			
			$dropboxfileTableId=   $dropboxfileTable->insert(array(
			
                  'dir_structure' => $dir,
                  'file_path' => $filepath,
                  'file_title' => $upload_file_title,
                  'file_owner_id' => $user_id,
                  'created_at' => date('Y-m-d H:i:s'),
         
                ));
                
                
            $dropboxlogTable = Engine_Api::_()->getDbtable('dropboxlog', 'user');	
			$dropboxlogTableId=   $dropboxlogTable->insert(array(
					
						  'subject_id' => $viewer->getIdentity(),
						  'path' => $dir,
						  'action' => 'file created',
						  'created_at' => date('Y-m-d H:i:s'),
						  'updated_at' => date('Y-m-d H:i:s'),
							
						)); 

				$aResult['status'] = true;
				$aResult['file_id'] = $dropboxfileTableId.'_'.$random_filename;
			} else {
				
				$aResult['status'] = false;
				$aResult['file_id'] = '';

			}
		    }
			echo json_encode($aResult['file_id']);
		 }   
	}
	        
		public function deletespecialdirAction(){
		
		$this->_helper->viewRenderer->setNoRender(true);
		$this->_helper->layout->disableLayout();
		
		$user_id=Engine_Api::_()->user()->getViewer()->getIdentity(); 
		$viewer     = Engine_Api::_()->user()->getViewer();		
		$aData = $this->_request->getPost(); 		
		$aData = $this->_request->getPost(); 
		$deleteddir_name	=	$aData['dir_name'];
		$current_directory	=	$aData['current_directory'];
		$dirname =   'specialdocuments'; 
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
		
		echo json_encode($aResult); 
	}
		public function deletespecialfileAction(){
		
		$this->_helper->viewRenderer->setNoRender(true);
		$this->_helper->layout->disableLayout();
		
		$user_id=Engine_Api::_()->user()->getViewer()->getIdentity(); 
		$viewer     = Engine_Api::_()->user()->getViewer();
		
		$aData = $this->_request->getPost(); 
		$filename	=	$aData['file_name'];
		$current_directory	=	$aData['current_directory'];
		$file_id	=	$aData['file_id'];
		$user_id	=	$aData['user_id']; 

		$dirname =   'specialdocuments'; 
		if($current_directory ==''){
		 $dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dirname.'/'.$current_directory.$filename; 
		}
		else{
		 $dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dirname.'/'.$current_directory.'/'.$filename; 
	    }
	    if (file_exists($dir)){
			
			Engine_Db_Table::getDefaultAdapter()->delete('engine4_document_requests', array('file_id = ?' => $file_id) );
			Engine_Db_Table::getDefaultAdapter()->delete('engine4_document_share', array('share_file_id = ?' => $file_id) );
			Engine_Db_Table::getDefaultAdapter()->delete('engine4_dropbox_files', array('id = ?' => $file_id) );
			
			unlink($dir);
			$aResult['msg'] ='This file is succesfully deleted.';	
		} 
        echo json_encode($aResult); 
		
	}
	public function landingpageAction(){
		$this->view->form = $form = new User_Form_Admin_Manage_landingpagemanage();
		$settings = Engine_Api::_()->getApi('settings', 'core'); 
	
		$form->populate(array(
       'bodyhtml'                      => $settings->user_landingpage,
       'showLandingpagearticlesection' => $settings->user_showLandingpagearticlesection
       ));
		 if( $this->getRequest()->isPost()&& $form->isValid($this->getRequest()->getPost()))
		 {
		  $values = $form->getValues(); 
		  $settings->user_landingpage                   = $values['bodyhtml'];
		  $settings->user_showLandingpagearticlesection = $values['showLandingpagearticlesection'];
		  $form->addNotice('Your changes have been saved.');
		  }
	}
	public function featuredstoryAction(){
		$this->view->form = $form = new User_Form_Admin_Manage_Featuredstory();
		$settings = Engine_Api::_()->getApi('settings', 'core'); 

		$form->populate(array(
       'featuredstoryTitle'           => $settings->user_featuredstoryTitle,
       'bodyhtml'                     => $settings->user_featuredstory,
       'showLandingpageFeaturedstory' => $settings->user_showLandingpageFeaturedstory
       ));
		 if( $this->getRequest()->isPost()&& $form->isValid($this->getRequest()->getPost()))
		 {
			
			if( $_FILES["FeaturedstoryImage"]["name"] != ''){
            
					$random_filename = $this->random_string(8);
					$dir             = dirname($_SERVER['SCRIPT_FILENAME']).'/public/images/featuredstory/';
									if(!is_dir($dir)){
										mkdir($dir,0777,true);
									}
					$target_file     = $dir .'/'. basename($_FILES["FeaturedstoryImage"]["name"]);
					
					$imageFileType   = pathinfo($target_file,PATHINFO_EXTENSION);
					$random_filename =  $random_filename.'.'.$imageFileType;

					if($imageFileType != "JPG" && $imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg" &&  $imageFileType != "JPEG" &&  $imageFileType != "PNG") {				

						$aResult['msg']    = "Sorry, only JPG, JPEG, & PNG  files are allowed.";
						$aResult['status'] = false;
					}
					else{
						$target_file   = $dir .'/'. $random_filename;
						if (move_uploaded_file($_FILES["FeaturedstoryImage"]["tmp_name"], $target_file)) {                  
							$settings->user_FeaturedstoryImage = 'public/images/featuredstory/'.$random_filename;                 
							$aResult['status']                      = true;
				   }
				   else {
						 $aResult['status'] = false;
						}
					}
		      } 
			 
		   $values = $form->getValues();
		   
		   $settings->user_featuredstoryTitle           = $values['featuredstoryTitle'];
		   $settings->user_featuredstory                = $values['bodyhtml'];
		   $settings->user_showLandingpageFeaturedstory = $values['showLandingpageFeaturedstory'];
		   $form->addNotice('Your changes have been saved.');
		  }
	}
}
