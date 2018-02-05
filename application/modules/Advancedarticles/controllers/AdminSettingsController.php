<?php
class Advancedarticles_AdminSettingsController extends Core_Controller_Action_Admin
{
  protected $module;
  protected $ucfirst_module;
  
  public function init() 
  {
    $front = Zend_Controller_Front::getInstance();
     $this->module = $front->getRequest()->getModuleName();
	 $this->ucfirst_module = ucfirst( $this->module ); 
  }  
  	
  public function indexAction() 
  {
  	$this->view->navigation = $navigation = Engine_Api::_()->getApi('menus', 'core')
      ->getNavigation($this->module . '_admin_main', array(), $this->module . '_admin_main_settings');
	
	$class = $this->ucfirst_module.'_Form_Admin_Category';
	$form = $this->view->form = new $class();
	
	$_module = $this->module;
	$this->view->categories = $categoties = Engine_Api::_()->$_module()->loadCategory($_module); 
  }

  public function articlesAction()
  {
  	$this->view->navigation = $navigation = Engine_Api::_()->getApi('menus', 'core')
      ->getNavigation($this->module . '_admin_main', array(), $this->module . '_admin_main_category');
	$class = $this->ucfirst_module.'_Form_Admin_Filter';
    $this->view->formFilter = $formFilter = new $class();
    $page = $this->_getParam('page', 1);      
      
    $table = Engine_Api::_()->getDbtable('artarticles', $this->module);
    $TableName = $table->info('name');
    
    $select = $table->select()->from($TableName);
    
    $values = array();
    if( $formFilter->isValid($this->_getAllParams()) ) {
      $values = $formFilter->getValues();
    }

    foreach( $values as $key => $value ) {
      if( $value === null) {
        unset($values[$key]);
      }
    }

    $values = array_merge(array(
      'order' => 'created_date',
      'by' => 'DESC',
    ), $values);

    $this->view->assign($values);
    
    // Add Title
    if( !empty($values['title']) ) {
      $select->where('title LIKE ?', '%' . $values['title'] . '%' );
    }
    // Add Username
    if( isset($values['username']) && !empty($values['username']) ) {
      $userTable = Engine_Api::_()->getDbtable('users', 'user');
      $userTableName = $userTable->info('name');      

      $select
        ->joinLeft($userTableName, "`{$userTableName}`.`user_id` = `{$TableName}`.`owner_id`", null)
        ->where('username LIKE ?', '%' . $values['username'] . '%' );      
    }     
    // Add Category
    if( !empty($values['category_id']) ) {
      $select->where('category_id = ?', $values['category_id'] );
    }
    // Add Status
    if( !empty($values['status']) ) {
      $select->where('status = ?', strtolower($values['status']) );
    }
    // Add featured
    if( !empty($values['featured']) ) {
      $select->where('featured = ?', $values['featured'] );
    }
    // Add sponsored
    if( !empty($values['sponsored']) ) {
      $select->where('sponsored = ?', $values['sponsored'] );
    }            
    
    $select->order(( !empty($values['order']) ? $values['order'] : 'created_date' ) . ' ' . ( !empty($values['by']) ? $values['by'] : 'DESC' ));
       
    $this->view->paginator = $paginator = Zend_Paginator::factory($select);
    $this->view->paginator = $paginator->setCurrentPageNumber($page);
    $paginator->setItemCountPerPage(20);
    $this->view->values = array_filter($values);
  }  
  
  public function deleteAction()
  {
    $class = $this->ucfirst_module.'_Form_Delete';
    $this->view->form = $form = new $class();
    $id = (int) $this->_getParam('id', 0);

    $article = Engine_Api::_()->getItem('artarticle', $id);

    if( $this->getRequest()->isPost() )
    {
      $table = $this->_helper->api()->getDbtable('artarticles', $this->module);
      $db = $table->getAdapter();
      $db->beginTransaction();

      try {
        // delete article
        $article->delete();
        //delete other
        $article->deleteAll($id);        
        // commit
        $db->commit();

    	// Forward
    	return $this->_forward('success', 'utility', 'core', array(
      	'smoothboxClose' => true,
      	'parentRefresh' => true,
      	'format'=> 'smoothbox',
      	'messages' => array('Article has been deleted.')
    	));
      }
      catch( Exception $e ) {
        $db->rollBack();
        throw $e;
      }
    }
  }  

  public function deleteselectedAction()
  {
    $ids = $this->_getParam('ids', null);

    // Delete Articles
    if( $this->getRequest()->isPost() )
    {
      $ids_array = explode(",", $ids);

      foreach ($ids_array as $id){
        $article = Engine_Api::_()->getItem('artarticle', $id);

        // delete
        $article->delete();
      }
      return $this->_helper->redirector->gotoRoute(array('action' => 'articles'));
    }
  }  
  
  public function addcategoryAction()
  {
    $viewer = Engine_Api::_()->user()->getViewer();
	
	$class = $this->ucfirst_module.'_Form_Admin_Addcategory';
  	$this->view->form = $form = new $class();
  	
    if( $this->getRequest()->isPost() && $form->isValid($this->getRequest()->getPost()) )
    {

      $table = $this->_helper->api()->getDbtable('categories', $this->module);
      $db = $table->getAdapter();
      $db->beginTransaction();

      try
      {
        $values = $form->getValues();

        if( !empty($values['name']) ) {
		  $_module = $this->module;
		  $values['url'] = Engine_Api::_()->$_module()->checkURL($values['name']);
        }		
		
        $link = $table->createRow();
        $link->setFromArray($values);
		
		$_module = $this->module;
		$left_id = Engine_Api::_()->$_module()->checkOrder($values['parent_id'], $this->module);
		$link->left_id = $left_id;
		$link->right_id = $left_id + 1;
		$link->created_date = date('Y-m-d H:i:s');
		$link->user_id = $viewer->getIdentity();
		$link->sort = Engine_Api::_()->$_module()->maxSort() + 1;
        $link->save();

        // Commit
        $db->commit();

    	// Forward
    	return $this->_forward('success', 'utility', 'core', array(
      	'smoothboxClose' => true,
      	'parentRefresh' => true,
      	'format'=> 'smoothbox',
      	'messages' => array('Category has been added.')
    	));
      }

      catch( Exception $e )
      {
        $db->rollBack();
        throw $e;
      }

    }  	
  }  

  public function editcategoryAction()
  {
    $viewer = Engine_Api::_()->user()->getViewer();
	
    $class = $this->ucfirst_module.'_Form_Admin_Editcategory';  
  	$this->view->form = $form = new $class();
	$id = (int) $this->_getParam('id', 0);
   	
    $category = Engine_Api::_()->getItem($this->module.'_category', $id); 
    $form->populate($category->toArray());	

	$options = array('0' => '');
    $parent_category = Engine_Api::_()->getDbtable('categories', 'advancedarticles');
	$select = $parent_category->select();
	$select->where("parent_id = ?", 0);
	
	$parent_category = $parent_category->fetchAll($select);
	
    foreach( $parent_category as $category_opt ) {
      if ($id != $category_opt->category_id)
	    $options[$category_opt->category_id] = $category_opt->name;
    }
	$form->parent_id->setMultiOptions($options);
	
	$left_id = $category->left_id;
	$right_id = $category->right_id;
	$parent_id = $category->category_id;

    if( $this->getRequest()->isPost() && $form->isValid($this->getRequest()->getPost()) )
    {
      $table = $this->_helper->api()->getDbtable('categories', $this->module);
      $db = $table->getAdapter();
      $db->beginTransaction();

      try
      {
        $values = $form->getValues();
		
        if( !empty($values['name']) ) {
		  $_module = $this->module;
		  $values['url'] = Engine_Api::_()->$_module()->checkURL($values['name']);
        }	
		
		$parentId = $values['parent_id'];
		
		$parent = ($category->parent_id) ? Engine_Api::_()->getItem($this->module.'_category', $category->parent_id) : null;
				
		if ((null == $parent && 0 == $parentId) || ($parent != null && $parent->category_id == $parentId)) {
				/**
				 * User do NOT change the parent category value
				 */
			$category->setFromArray($values);
			$category->modified_date = date('Y-m-d H:i:s');
			$category->save();						
		} else {
				/**
				 * User changed parent category
				 */
			$parent_id = $parentId;
			
			$_module = $this->module;
			$left_id = Engine_Api::_()->$_module()->checkOrder($parent_id, $this->module);
			
			$category->setFromArray($values);
			
			$category->modified_date = date('Y-m-d H:i:s');
			$category->left_id = $left_id;
			$category->right_id = $left_id + 1;			
			$category->save();

			Engine_Api::_()->$_module()->migrateSubdir($id, $this->module);	
	    	// delete category
	       /* $category->delete();
			$category->delete_category($left_id, $right_id, $parent_id, $this->module);				

        	$cat = $table->createRow();
       	 	$cat->setFromArray($values);
		
			$_module = $this->module;
			$left_id = Engine_Api::_()->$_module()->checkOrder($parent_id);
			$cat->category_id = $id;
			$cat->left_id = $left_id;
			$cat->right_id = $left_id + 1;
			$cat->created_date = date('Y-m-d H:i:s');
			$cat->user_id = $viewer->getIdentity();
        	$cat->save();*/			
		}

        // Commit
        $db->commit();

    	// Forward
    	return $this->_forward('success', 'utility', 'core', array(
      	'smoothboxClose' => true,
      	'parentRefresh' => true,
      	'format'=> 'smoothbox',
      	'messages' => array('Category has been edited.')
    	));
      }

      catch( Exception $e )
      {
        $db->rollBack();
        throw $e;
      }

    }
  }  

  public function sortAction()
  {
	$id = (int) $this->_getParam('id', 0);

	if ($id) return $this->_forward('sort-category', null, null, array('format' => 'json'));
  }
  
  public function sortCategoryAction()
  {
	$id = (int) $this->_getParam('id', 0);
	$parentId = (int) $this->_getParam('parent_id', 0);
   	
	$sortID = explode(',', $this->_getParam('sortID'));
	$sortIND = explode(',', $this->_getParam('sortIND'));
	
    $category = Engine_Api::_()->getItem($this->module.'_category', $id); 

	$left_id = $category->left_id;
	$right_id = $category->right_id;
	$parent_id = $category->category_id;

    $table = $this->_helper->api()->getDbtable('categories', $this->module);
    $db = $table->getAdapter();
    $db->beginTransaction();

    try
    {
	  $parent = ($category->parent_id) ? Engine_Api::_()->getItem($this->module.'_category', $category->parent_id) : null;
	  $parent_id = $parentId;
	  $_module = $this->module;
	  $left_id = Engine_Api::_()->$_module()->checkOrder($parent_id, $this->module);
      
	  $category->parent_id = $parent_id;
	  $category->left_id = $left_id;
	  $category->right_id = $left_id + 1;			
	  $category->save();
	  Engine_Api::_()->$_module()->migrateSubdir($id, $this->module);	
      
	  Engine_Api::_()->$_module()->sortCategory($sortID, $sortIND);
	  // Commit
      $db->commit();
      $this->view->status   = true;
      $this->view->id   = $id;
      $this->view->parent   = $parent_id;
    }

    catch( Exception $e )
    {
      $db->rollBack();
      throw $e;
      $this->view->status   = false;
    }

  }    
  
  public function deletecategoryAction()
  {
	$class = $this->ucfirst_module.'_Form_Admin_Deletecategory';  
    $this->view->form = $form = new $class();
    $id = (int) $this->_getParam('id', 0);

    $category = Engine_Api::_()->getItem($this->module.'_category', $id);
	$left_id = $category->left_id;
	$right_id = $category->right_id;
	$parent_id = $category->category_id;
    if( $this->getRequest()->isPost() )
    {
      $table = $this->_helper->api()->getDbtable('categories', $this->module);
      $db = $table->getAdapter();
      $db->beginTransaction();

      try
      {
        
        $category->migrateArticles();
        // delete category
        $category->delete();
		$category->delete_category($left_id, $right_id, $parent_id, $this->module);
		
        // commit
        $db->commit();

    	// Forward
    	return $this->_forward('success', 'utility', 'core', array(
      	'smoothboxClose' => true,
      	'parentRefresh' => true,
      	'format'=> 'smoothbox',
      	'messages' => array('Category has been deleted.')
    	));
      }

      catch( Exception $e )
      {
        $db->rollBack();
        throw $e;
      }
    }
  }  

  public function levelAction()
  {
	$this->view->PluginTitle = Zend_Registry::get('Zend_Translate')->_('Advanced Articles');
	$this->view->PluginDiscr = Zend_Registry::get('Zend_Translate')->_('ADVANCED_ARTICLES_DESCRIPTION');
	  
	$this->view->navigation = $navigation = Engine_Api::_()->getApi('menus', 'core')
      ->getNavigation($this->module . '_admin_main', array(), $this->module . '_admin_main_level');
	  
		// Get level
		$id = $this->_getParam('level_id');

		$level = (null != $id) ? Engine_Api::_()->getItem('authorization_level', $id) : Engine_Api::_()->getItemTable('authorization_level')->getDefaultLevel();

		if(!$level instanceof Authorization_Model_Level) throw new Engine_Exception('Missing Level');
    
		$id = $level->level_id;

		$this->view->form = $form = new Advancedarticles_Form_Admin_Level(array(
            'public' => ( in_array($level->type, array('public')) ),
            'moderator' => ( in_array($level->type, array('admin', 'moderator')) ),
        ));

		$form->level_id->setValue($id);
		
		$permissions = Engine_Api::_()->getDbtable('permissions', 'authorization');

		if( !$this->getRequest()->isPost() ) {
 		  $form->populate($permissions->getAllowed('artarticle', $id, array_keys($form->getValues())));
		  return;
		}

		if( !$form->isValid($this->getRequest()->getPost()) ) return;
		
		$values = $form->getValues();

		$db = $permissions->getAdapter();
		$db->beginTransaction();
		try	{
 		  $permissions->setAllowed('artarticle', $id, $values);
		  $db->commit();
		  $form->addNotice('Your changes have been saved.');
		}
		catch( Exception $e ) {
		  $db->rollBack();
		  throw $e;
		}
  }  

  public function settingsAction()
  {
	$this->view->PluginTitle = Zend_Registry::get('Zend_Translate')->_('Advanced Articles');
	$this->view->PluginDiscr = Zend_Registry::get('Zend_Translate')->_('ADVANCED_ARTICLES_DESCRIPTION');
	  
	$this->view->navigation = $navigation = Engine_Api::_()->getApi('menus', 'core')
      ->getNavigation($this->module . '_admin_main', array(), $this->module . '_admin_main_global');
	
	$settings = Engine_Api::_()->getApi('settings', 'core');

	$this->view->form = $form = new Advancedarticles_Form_Admin_Settings();

    $form->getElement('art_route')->setValue(isset($settings->art_route) ? $settings->art_route : 'articles');
	$form->getElement('art_per_page')->setValue(isset($settings->art_per_page) ? $settings->art_per_page : 10);
	$form->getElement('art_photo')->setValue(isset($settings->art_photo) ? $settings->art_photo : 5);
	$form->getElement('art_public')->setValue(isset($settings->art_public) ? $settings->art_public : true);
	$form->getElement('art_sort')->setValue(isset($settings->art_sort) ? $settings->art_sort : 5);
						  
    if( $this->getRequest()->isPost()&& $form->isValid($this->getRequest()->getPost()))
    {
      $values = $form->getValues();
       foreach ($values as $key => $value){
        $settings->$key = $value;
      }
      $form->addNotice('Your changes have been saved.');
    }	
  }  
  
  //More Plugins
  public function moreAction()
  {
    $this->view->navigation = $navigation = Engine_Api::_()->getApi('menus', 'core')
      ->getNavigation('advancedarticles_admin_main', array(), 'advancedarticles_admin_main_more');
  }
  
  public function addarticleAction()
  {
	  $this->view->navigation = $navigation = Engine_Api::_()->getApi('menus', 'core')
      ->getNavigation($this->module . '_admin_main', array(), $this->module . '_admin_main_add');
   
	$viewer = Engine_Api::_()->user()->getViewer();
	
	$class = $this->ucfirst_module.'_Form_Admin_Addarticle'; 
  	$this->view->form = $form = new $class();
  	$_module = $this->module;
  	if( $this->getRequest()->isPost() && $form->isValid($this->getRequest()->getPost()) )
    {
		 $table = $this->_helper->api()->getDbtable('artarticles', $this->module);
            $db = $table->getAdapter();
            $db->beginTransaction();
            
                try {
                $values = $form->getValues();

                $body = htmlspecialchars($values['description']);
                $values['description'] = strip_tags($values['description']);
                $values['url'] = Engine_Api::_()->$_module()->checkURL($values['title']);

                $article = $table->createRow();
                $article->setFromArray($values);
                $article->created_date = $article->updated_date = date('Y-m-d H:i:s');
                $article->owner_id = $article->updated_user_id = $viewer->getIdentity();
                $article->owner_type = $viewer->getType();
                $article->body = $body;
                
                
                $trending_articles = $table->fetchAll($table->select()->where('trending_article = ?', '1')); 
		       /*  if(count($trending_articles) >= 5){
					  $article->trending_article = 0;
				 }*/

               /* $draft = $this->getRequest()->getPost('saveasdraft');

                if (isset($draft)) {
                    $article->status = 'draft';
                }*/
               // else {
                    $article->activate_date = date('Y-m-d H:i:s');
                    $article->activate_user_id = $viewer->getIdentity();
               // }
                $article->save();

                //save article questions
                $questions = $form->getSubForm('questions');
                $questions->setItem($article);
                $questions->saveValues();

                //Photo
                if ($values['art_photo']) {
                    $photo_id = Engine_Api::_()->$_module()->createPhoto($form->art_photo, $viewer->getIdentity(), $article->artarticle_id)->file_id;
                    $article->addPhoto($photo_id, $_module);
                }

                $article->photo_id = isset($photo_id) ? $photo_id : 0;
                $article->save();
                // Commit
                $db->commit();
                

    	
    	 return $this->_forward('success', 'utility', 'core', array(
                        'redirect' => $this->getFrontController()->getRouter()->assemble(array('module'=>'advancedarticles','controller'=>'settings','action' => 'articles'), 'admin_default', true)
                    ));
            } catch (Exception $e) {
                $db->rollBack();
                throw $e;
            }
            
            //Tags
           /* if (!empty($values['tags_info'])) {
                $tags_info = preg_split('/[,]+/', $values['tags_info']);
                $tags_temp = array();
                foreach ($tags_info as $val) {
                    $val = trim($val);
                    if (!empty($val))
                        $tags_temp[] = $val;
                }
                $tags_info = $tags_temp;
                $art_tag = new Engine_ProxyObject($article, Engine_Api::_()->getDbtable('tags', 'core'));
                $art_tag->addTagMaps($viewer, $tags_info);
            }*/
            
            


		
	}
	  
	  
  }
}
