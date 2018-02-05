<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class User_EditController extends Core_Controller_Action_User
{
  public function init()
  {
    if( !Engine_Api::_()->core()->hasSubject() ) {
      // Can specifiy custom id
      $id = $this->_getParam('id', null);
      $subject = null;
      if( null === $id ) {
        $subject = Engine_Api::_()->user()->getViewer();
        Engine_Api::_()->core()->setSubject($subject);
      } else {
        $subject = Engine_Api::_()->getItem('user', $id);
        Engine_Api::_()->core()->setSubject($subject);
      }
    }

    if( !empty($id) ) {
      $params = array('id' => $id);
    } else {
      $params = array();
    }
    // Set up navigation
    $this->view->navigation = $navigation = Engine_Api::_()
      ->getApi('menus', 'core')
      ->getNavigation('user_edit', array('params' => $params));

    // Set up require's
    $this->_helper->requireUser();
    $this->_helper->requireSubject('user');
    $this->_helper->requireAuth()->setAuthParams(
      null,
      null,
      'edit'
    );
  }
  
  public function profileAction()
  {
    $this->view->user = $user = Engine_Api::_()->core()->getSubject();
    $this->view->viewer = $viewer = Engine_Api::_()->user()->getViewer();

    
    // General form w/o profile type
    $aliasedFields = $user->fields()->getFieldsObjectsByAlias();
    $this->view->topLevelId = $topLevelId = 0;
    $this->view->topLevelValue = $topLevelValue = null;
    if( isset($aliasedFields['profile_type']) ) {
      $aliasedFieldValue = $aliasedFields['profile_type']->getValue($user);
      $topLevelId = $aliasedFields['profile_type']->field_id;
      $topLevelValue = ( is_object($aliasedFieldValue) ? $aliasedFieldValue->value : null );
      if( !$topLevelId || !$topLevelValue ) {
        $topLevelId = null;
        $topLevelValue = null;
      }
      $this->view->topLevelId = $topLevelId;
      $this->view->topLevelValue = $topLevelValue;
    }
    
    // Get form
    $form = $this->view->form = new Fields_Form_Standard(array(
      'item' => Engine_Api::_()->core()->getSubject(),
      'topLevelId' => $topLevelId,
      'topLevelValue' => $topLevelValue,
      'hasPrivacy' => true,
      'privacyValues' => $this->getRequest()->getParam('privacy'),
    ));
    //$form->generate();

    if( $this->getRequest()->isPost() && $form->isValid($this->getRequest()->getPost()) ) {

      $form->saveValues();

      // Update display name
      $aliasValues = Engine_Api::_()->fields()->getFieldsValuesByAlias($user);
      $user->setDisplayName($aliasValues);
      //$user->modified_date = date('Y-m-d H:i:s');
      $user->save();

      // update networks
      Engine_Api::_()->network()->recalculate($user);
      
      $form->addNotice(Zend_Registry::get('Zend_Translate')->_('Your changes have been saved.'));
    }
  }


  public function photoAction()
  {
    $this->view->user = $user = Engine_Api::_()->core()->getSubject();
    $this->view->viewer = $viewer = Engine_Api::_()->user()->getViewer();

    // Get form
    $this->view->form = $form = new User_Form_Edit_Photo();

    if( empty($user->photo_id) ) {
      $form->removeElement('remove');
    }

    if( !$this->getRequest()->isPost() ) {
      return;
    }

    if( !$form->isValid($this->getRequest()->getPost()) ) {
      return;
    }

    // Uploading a new photo
    if( $form->Filedata->getValue() !== null ) {
      $db = $user->getTable()->getAdapter();
      $db->beginTransaction();
      
      try {
        $fileElement = $form->Filedata;

        $user->setPhoto($fileElement);
        
        $iMain = Engine_Api::_()->getItem('storage_file', $user->photo_id);
        
        // Insert activity
        $action = Engine_Api::_()->getDbtable('actions', 'activity')->addActivity($user, $user, 'profile_photo_update',
          '{item:$subject} added a new profile photo.');

        // Hooks to enable albums to work
        if( $action ) {
          $event = Engine_Hooks_Dispatcher::_()
            ->callEvent('onUserProfilePhotoUpload', array(
                'user' => $user,
                'file' => $iMain,
              ));

          $attachment = $event->getResponse();
          if( !$attachment ) $attachment = $iMain;

          // We have to attach the user himself w/o album plugin
          Engine_Api::_()->getDbtable('actions', 'activity')->attachActivity($action, $attachment);
        }
        
        $db->commit();
        $form->addNotice(Zend_Registry::get('Zend_Translate')->_('Profile photo has been saved.'));
      }

      // If an exception occurred within the image adapter, it's probably an invalid image
      catch( Engine_Image_Adapter_Exception $e )
      {
        $db->rollBack();
        $form->addError(Zend_Registry::get('Zend_Translate')->_('The uploaded file is not supported or is corrupt.'));
      }

      // Otherwise it's probably a problem with the database or the storage system (just throw it)
      catch( Exception $e )
      {
        $db->rollBack();
        throw $e;
      }
    }

    // Resizing a photo
    else if( $form->getValue('coordinates') !== '' ) {
      $storage = Engine_Api::_()->storage();

      $iProfile = $storage->get($user->photo_id, 'thumb.profile');
      $iSquare = $storage->get($user->photo_id, 'thumb.icon');

      // Read into tmp file
      $pName = $iProfile->getStorageService()->temporary($iProfile);
      $iName = dirname($pName) . '/nis_' . basename($pName);

      list($x, $y, $w, $h) = explode(':', $form->getValue('coordinates'));

      $image = Engine_Image::factory();
      $image->open($pName)
        ->resample($x+.1, $y+.1, $w-.1, $h-.1, 48, 48)
        ->write($iName)
        ->destroy();

      $iSquare->store($iName);

      // Remove temp files
      @unlink($iName);
    }
  }

  public function removePhotoAction()
  {
    // Get form
    $this->view->form = $form = new User_Form_Edit_RemovePhoto();

    if( !$this->getRequest()->isPost() || !$form->isValid($this->getRequest()->getPost()) )
    {
      return;

    }
          
    $user = Engine_Api::_()->core()->getSubject();
    
    $userTable = Engine_Api::_()->getDbtable('users', 'user');
	$UserData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $user->user_id)); 
	   
    $UserData->photo_id = 0;
    $UserData->save();
    $this->view->status = true;
    $this->view->message = Zend_Registry::get('Zend_Translate')->_('Your photo has been removed.');
    
    $this->_forward('success', 'utility', 'core', array(
      'smoothboxClose' => true,
     // 'parentRefresh' => true,
      'messages' => array(Zend_Registry::get('Zend_Translate')->_('Your photo has been removed.'))
    ));

    $this->_redirect('/members/edit/photo');
  }

  public function styleAction()
  {
    $this->view->user = $user = Engine_Api::_()->core()->getSubject();
    $this->view->viewer = $viewer = Engine_Api::_()->user()->getViewer();
    if( !$this->_helper->requireAuth()->setAuthParams('user', null, 'style')->isValid()) return;


    // Get form
    $this->view->form = $form = new User_Form_Edit_Style();

    // Get current row
    $table = Engine_Api::_()->getDbtable('styles', 'core');
    $select = $table->select()
      ->where('type = ?', $user->getType())
      ->where('id = ?', $user->getIdentity())
      ->limit();

    $row = $table->fetchRow($select);

    // Not posting, populate
    if( !$this->getRequest()->isPost() )
    {
      $form->populate(array(
        'style' => ( null === $row ? '' : $row->style )
      ));
      return;
    }

    // Whoops, form was not valid
    if( !$form->isValid($this->getRequest()->getPost()) )
    {
      return;
    }


    // Cool! Process
    $style = $form->getValue('style');

    // Process
    $style = strip_tags($style);

    $forbiddenStuff = array(
      '-moz-binding',
      'expression',
      'javascript:',
      'behaviour:',
      'vbscript:',
      'mocha:',
      'livescript:',
    );

    $style = str_replace($forbiddenStuff, '', $style);

    // Save
    if( null == $row )
    {
      $row = $table->createRow();
      $row->type = $user->getType();
      $row->id = $user->getIdentity();
    }

    $row->style = $style;
    $row->save();

    $form->addNotice(Zend_Registry::get('Zend_Translate')->_('Your changes have been saved.'));
  }

  public function externalPhotoAction()
  {
    if( !$this->_helper->requireSubject()->isValid() ) return;
    $user = Engine_Api::_()->core()->getSubject();
    
    // Get photo
    $photo = Engine_Api::_()->getItemByGuid($this->_getParam('photo'));
    if( !$photo || !($photo instanceof Core_Model_Item_Abstract) || empty($photo->photo_id) ) {
      $this->_forward('requiresubject', 'error', 'core');
      return;
    }

    if( !$photo->authorization()->isAllowed(null, 'view') ) {
      $this->_forward('requireauth', 'error', 'core');
      return;
    }

    
    // Make form
    $this->view->form = $form = new User_Form_Edit_ExternalPhoto();
    $this->view->photo = $photo;

    if( !$this->getRequest()->isPost() ) {
      return;
    }

    if( !$form->isValid($this->getRequest()->getPost()) ) {
      return;
    }

    // Process
    $db = $user->getTable()->getAdapter();
    $db->beginTransaction();
    
    try {
      // Get the owner of the photo
      $photoOwnerId = null;
      if( isset($photo->user_id) ) {
        $photoOwnerId = $photo->user_id;
      } else if( isset($photo->owner_id) && (!isset($photo->owner_type) || $photo->owner_type == 'user') ) {
        $photoOwnerId = $photo->owner_id;
      }

      // if it is from your own profile album do not make copies of the image
      if( $photo instanceof Album_Model_Photo &&
          ($photoParent = $photo->getParent()) instanceof Album_Model_Album &&
          $photoParent->owner_id == $photoOwnerId &&
          $photoParent->type == 'profile' ) {

        // ensure thumb.icon and thumb.profile exist
        $newStorageFile = Engine_Api::_()->getItem('storage_file', $photo->file_id);
        $filesTable = Engine_Api::_()->getDbtable('files', 'storage');
        if( $photo->file_id == $filesTable->lookupFile($photo->file_id, 'thumb.profile') ) {
          try {
            $tmpFile = $newStorageFile->temporary();
            $image = Engine_Image::factory();
            $image->open($tmpFile)
              ->resize(200, 400)
              ->write($tmpFile)
              ->destroy();
            $iProfile = $filesTable->createFile($tmpFile, array(
              'parent_type' => $user->getType(),
              'parent_id' => $user->getIdentity(),
              'user_id' => $user->getIdentity(),
              'name' => basename($tmpFile),
            ));
            $newStorageFile->bridge($iProfile, 'thumb.profile');
            @unlink($tmpFile);
          } catch( Exception $e ) { echo $e; die(); }
        }
        if( $photo->file_id == $filesTable->lookupFile($photo->file_id, 'thumb.icon') ) {
          try {
            $tmpFile = $newStorageFile->temporary();
            $image = Engine_Image::factory();
            $image->open($tmpFile);
            $size = min($image->height, $image->width);
            $x = ($image->width - $size) / 2;
            $y = ($image->height - $size) / 2;
            $image->resample($x, $y, $size, $size, 48, 48)
              ->write($tmpFile)
              ->destroy();
            $iSquare = $filesTable->createFile($tmpFile, array(
              'parent_type' => $user->getType(),
              'parent_id' => $user->getIdentity(),
              'user_id' => $user->getIdentity(),
              'name' => basename($tmpFile),
            ));
            $newStorageFile->bridge($iSquare, 'thumb.icon');
            @unlink($tmpFile);
          } catch( Exception $e ) { echo $e; die(); }
        }

        // Set it
        $user->photo_id = $photo->file_id;
        $user->save();
        
        // Insert activity
        // @todo maybe it should read "changed their profile photo" ?
        $action = Engine_Api::_()->getDbtable('actions', 'activity')
            ->addActivity($user, $user, 'profile_photo_update',
                '{item:$subject} changed their profile photo.');
        if( $action ) {
          // We have to attach the user himself w/o album plugin
          Engine_Api::_()->getDbtable('actions', 'activity')
              ->attachActivity($action, $photo);
        }
      }

      // Otherwise copy to the profile album
      else {
        $user->setPhoto($photo);

        // Insert activity
        $action = Engine_Api::_()->getDbtable('actions', 'activity')
            ->addActivity($user, $user, 'profile_photo_update',
                '{item:$subject} added a new profile photo.');
        
        // Hooks to enable albums to work
        $newStorageFile = Engine_Api::_()->getItem('storage_file', $user->photo_id);
        $event = Engine_Hooks_Dispatcher::_()
          ->callEvent('onUserProfilePhotoUpload', array(
              'user' => $user,
              'file' => $newStorageFile,
            ));

        $attachment = $event->getResponse();
        if( !$attachment ) {
          $attachment = $newStorageFile;
        }
        
        if( $action  ) {
          // We have to attach the user himself w/o album plugin
          Engine_Api::_()->getDbtable('actions', 'activity')
              ->attachActivity($action, $attachment);
        }
      }

      $db->commit();
    }

    // Otherwise it's probably a problem with the database or the storage system (just throw it)
    catch( Exception $e )
    {
      $db->rollBack();
      throw $e;
    }
    
    return $this->_forward('success', 'utility', 'core', array(
      'messages' => array(Zend_Registry::get('Zend_Translate')->_('Set as profile photo')),
      'smoothboxClose' => true,
    ));
  }

  public function clearStatusAction()
  {
    $this->view->status = false;
    
    if( $this->getRequest()->isPost() ) {
      $viewer = Engine_Api::_()->user()->getViewer();
      $viewer->status = '';
      $viewer->status_date = '00-00-0000';
      // twitter-style handling
      // $lastStatus = $viewer->status()->getLastStatus();
      // if( $lastStatus ) {
      //   $viewer->status = $lastStatus->body;
      //   $viewer->status_date = $lastStatus->creation_date;
      // }
      $viewer->save();
      
      $this->view->status = true;
    } 
  }
  
  public function documentAction(){ 
	  if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
	$this->view->user = $user = Engine_Api::_()->core()->getSubject();
    $this->view->viewer = $viewer = Engine_Api::_()->user()->getViewer();

    // Get form
    $this->view->form = $form = new User_Form_Edit_Document();
    
   /* if( !$form->isValid($this->getRequest()->getPost()) ) {
      return;
    }*/
 


 

	$dirname =   $viewer->getIdentity().'_'.$viewer->displayname;  
			
	$dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dirname;
	if (!is_dir($dir)) {
			mkdir($dir, 0777, true);
	}
	
   $files =	$this->loaddirectory($dir);

   $this->view->files = $files;
   
   $propertyRequestTable =  Engine_Api::_()->getDbtable('propertyrequest', 'user');	
   $propertyReq_select = $propertyRequestTable->select()
		                      ->setIntegrityCheck(false)
		                       ->from(array('prequest'=>'engine4_property_request',))  
		                       ->joinLeft(array('user'=>'engine4_users',),'prequest.landlord_id=user.user_id',array('displayname'))   
					           ->where('prequest.tenant_id = ?', $viewer->getIdentity())
					           ->where('prequest.landlord_approve	 = ?', 1)
					           ->order('prequest.id DESC');
   
    $propertyRequest = $propertyRequestTable->fetchAll($propertyReq_select);
		
	$this->view->requestApprovedLandlords = $propertyRequest;

   
   
   

  /*$aData = $this->_request->getPost();  
   
    if( $this->getRequest()->isPost() && $form->isValid($this->getRequest()->getPost()) ) {
    // Uploading a new photo
    if( $form->document->getValue() !== null  && $aData['title'] !='') {
    
    
    try{
		
	$documentTable = Engine_Api::_()->getDbtable('documents', 'user');
		
		
    $fileElement = $form->document;

    $fileElement->getFileName();
    

    $file_name = $_FILES['document']['name'];
    $file_tmp =  $_FILES['document']['tmp_name']; 
    
   
    $document =$_SERVER['HTTP_HOST'].'/public/temporary/'.$file_name;  
    

    $path = dirname($_SERVER['SCRIPT_FILENAME']).'/public/documents/'.$viewer->getIdentity().'/';
							
							if(!is_dir($path)){
								mkdir($path,0777,true);
							}			
				
    
    $newfile_name = uniqid().$file_name;	
									$document_link = $document;//Direct link to image
									$split_image = pathinfo($document_link);

									$ch = curl_init();
									curl_setopt($ch, CURLOPT_URL , $document_link);
									curl_setopt($ch, CURLOPT_USERAGENT, "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.13 (KHTML, like Gecko) Chrome/0.A.B.C Safari/525.13");
									curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1); 
									$response= curl_exec ($ch);
									curl_close($ch);
									$image_name = uniqid().".".$split_image['extension'];
									$file_name = $path.$image_name;
									$file = fopen($file_name , 'w') or die("X_x");
									fwrite($file, $response);
									fclose($file);
									

    $document_path = 'public/documents/'.$viewer->getIdentity().'/'.$image_name;
    
    $documentTableId=   $documentTable->insert(array(
			
                    'document_name' => $aData['title'],
                    'document' => $document_path,
                    'user_id' => $viewer->getIdentity(),
                    'created_at' => date("Y-m-d"),

                    
                ));
   
   
    $form->addNotice(Zend_Registry::get('Zend_Translate')->_('Your document is successfully saved.'));
    
    }catch( Exception $e ) { echo $e; die(); }
    
    }
   }*/
	  
  }
  
   public function documentrequestsAction(){ //document req list page
	  if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
	$this->view->user = $user = Engine_Api::_()->core()->getSubject();
    $this->view->viewer = $viewer = Engine_Api::_()->user()->getViewer();
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


   }
   
   
   public function createdirectoryAction() {
	   if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
		
		$this->_helper->viewRenderer->setNoRender(true);
		$this->_helper->layout->disableLayout();
		
		$user_id=Engine_Api::_()->user()->getViewer()->getIdentity(); 
		$viewer     = Engine_Api::_()->user()->getViewer();
		$subject = Engine_Api::_()->core()->getSubject();
		
		$aData = $this->_request->getPost(); 
		$folder_name	=	$aData['folder_name'];
		$cur_dir	=	$aData['cur_dir'];
		$li_count	=	$aData['li_count']+1;
		$dirname =   $subject->getIdentity().'_'.$subject->displayname; 
		if($cur_dir ==''){

		$dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dirname.'/'.$folder_name;
	    }
	   else{
		   
		   $dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dirname.'/'.$cur_dir.'/'.$folder_name;
	   }
		if (!is_dir($dir)) {
				mkdir($dir, 0777, true);
				$aResult['msg'] ='Folder created successfully';
				//$aResult['content'] = '<li class="dir_li list'.$li_count.'" dir-name="'.$folder_name.'"><a href="javascript:void(0)" class="dir_open" dir-name="'.$folder_name.'">'.$folder_name.'</a><span class="option_links"><a href="javascript:void(0)" dir-name="'.$folder_name.'" li-count="'.$li_count.'" class="dir_share">Share</a> | <a href="javascript:void(0)" class="dir_rename" dir-name="'.$folder_name.'" li-count="'.$li_count.'">Rename</a> | <a href="javascript:void(0)" class="dir_delete" dir-name="'.$folder_name.'" li-count="'.$li_count.'">Delete</a></span><hr></li>';
				$aResult['content'] = '<li class="dir_li list'.$li_count.'" dir-name="'.$folder_name.'"><a href="javascript:void(0)" class="dir_open" dir-name="'.$folder_name.'"><img src="/application/modules/User/externals/images/document_folder.svg">&nbsp;&nbsp;'.$folder_name.'</a><span class="option_links"><a href="javascript:void(0)" class="dir_rename" dir-name="'.$folder_name.'" li-count="'.$li_count.'">Rename</a> | <a href="javascript:void(0)" class="dir_delete" dir-name="'.$folder_name.'" li-count="'.$li_count.'">Delete</a></span><hr></li>';
		}
		else{
			$aResult['msg'] ='This folder is already existed.';
			$aResult['content'] ='';
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
	public function savefileAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
		$viewer     = Engine_Api::_()->user()->getViewer();
		$subject = Engine_Api::_()->core()->getSubject();
		$this->_helper->viewRenderer->setNoRender(true);
		$this->_helper->layout->disableLayout();
		 if( $this->getRequest()->isPost()){
			 
			  $aData = $this->_request->getPost();
			  
			$cur_dir = $aData['cur_dir']; 
			$dirname =   $subject->getIdentity().'_'.$subject->displayname; 
			if($cur_dir ==''){

			$dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dirname;
			}
			else{
				   
			   $dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dirname.$cur_dir; 
			}
			  
		    $target_file = $dir .'/'. basename($_FILES["upload_files"]["name"]); 
		    $imageFileType = pathinfo($target_file,PATHINFO_EXTENSION);
		    
		    if($imageFileType != "pdf") {
				
				$aResult['msg'] = "Sorry, only PDF files are allowed.";
				$aResult['status'] = false;
			}
		    else{
		    
			if (move_uploaded_file($_FILES["upload_files"]["tmp_name"], $target_file)) {
				
				$aResult['status'] = $_FILES["upload_files"]["name"];
				$aResult['msg'] = "File is successfully uploaded.";
				$aResult['status'] = true;
			} else {
				
				$aResult['status'] = false;

			}
		    }
			echo json_encode($aResult['status']);
		//return $this->_helper->redirector->gotoRoute(array('module'=>'user','controller'=>'edit','action' => 'document'), '', true);	  
		 }  
	}
	public function getdirectorycontentsAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
		$this->_helper->viewRenderer->setNoRender(true);
		$this->_helper->layout->disableLayout();
		
		$user_id=Engine_Api::_()->user()->getViewer()->getIdentity(); 
		$viewer     = Engine_Api::_()->user()->getViewer();
		$subject = Engine_Api::_()->core()->getSubject();
		
		$aData = $this->_request->getPost(); 
		$dirname	            =	$aData['dirname'];
	    $current_directory	    =	$aData['current_directory'];
	    $menu_open	    =	$aData['menu_open'];
		$user_dir =   $subject->getIdentity().'_'.$subject->displayname; 
		$aResult['par_dir'] =  dirname($current_directory);
		if($current_directory == ''){
			if($menu_open == 0){
			$dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$user_dir.'/'.$dirname;
		   }
		   else{
			   $dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$user_dir;
		   }
			$file_path = '/filemanager/'.$user_dir.'/'.$dirname.'/'; 
			$doc_path = $user_dir.'/'.$dirname.'/'; 
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
	    
		$files =	$this->loaddirectory($dir); //echo '<pre>' print_r($files) ;exit;
		
		 $dropboxfileTable = Engine_Api::_()->getDbtable('dropboxfiles', 'user');
    
        foreach($files['files'] as $file){
		   
		   $doc_path1 = $doc_path.$file['filename']; 
		   $dropboxfileData = $dropboxfileTable->fetchRow($dropboxfileTable->select()->where('file_path LIKE ?', $doc_path1.'%')); 	 
				
		   $tmpArrayFile[]	=	array('file_id'=>$dropboxfileData->id,'filename'=>$file['filename'],'file_title'=>$dropboxfileData->file_title,'file_owner_id'=> $dropboxfileData->file_owner_id,'file_path'=> $dropboxfileData->file_path,'created_at'=> $dropboxfileData->created_at);  

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
		//$a = $a .'<li class="dir_li list'.$i.'" dir-name="'.$dir['dirname'].'"><a href="javascript:void(0)" class="dir_open" dir-name="'.$dir['dirname'].'">'.$dir['dirname'].'</a><span class="option_links"><a href="javascript:void(0)" dir-name="'.$dir['dirname'].'" li-count="'.$i.'" class="dir_share">Share</a> | <a href="javascript:void(0)" class="dir_rename" dir-name="'.$dir['dirname'].'" li-count="'.$i.'">Rename</a> | <a href="javascript:void(0)" class="dir_delete" dir-name="'.$dir['dirname'].'" li-count="'.$i.'">Delete</a></span><hr></li>';
		$a = $a .'<li class="dir_li list'.$i.'" dir-name="'.$dir['dirname'].'"><a href="javascript:void(0)" class="dir_open" dir-name="'.$dir['dirname'].'"><img src="/application/modules/User/externals/images/document_folder.svg">&nbsp;&nbsp;'.$dir['dirname'].'</a><span class="option_links"><a href="javascript:void(0)" class="dir_rename" dir-name="'.$dir['dirname'].'" li-count="'.$i.'">Rename</a> | <a href="javascript:void(0)" class="dir_delete" dir-name="'.$dir['dirname'].'" li-count="'.$i.'">Delete</a></span><hr></li>';
		 $i++;
		 }
		}
		
		//print_r($files['files']); exit;
			if(count($files['files'])>0){
		    //$file_path = $_SERVER['HTTP_HOST'].'/filemanager/'.$user_dir.$current_directory.'/'.$dirname.'/'.$dir['filename']; 		
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
			$b = $b.'<span class="option_links"><a href="javascript:void(0)" file-name="'.$dir['filename'].'" li-count="'.$i.'" class="file_details" file-id="'.$dir['file_id'].'">Details</a> | <a href="javascript:void(0)" file-name="'.$dir['filename'].'" li-count="'.$i.'" class="file_share" file-id="'.$dir['file_id'].'">Share</a> | <a href="javascript:void(0)" class="file_rename" file-name="'.$dir['filename'].'" li-count="'.$i.'" file-id="'.$dir['file_id'].'">Rename</a> | <a href="javascript:void(0)" class="file_copy" file-name="'.$dir['filename'].'" li-count="'.$i.'" file-id="'.$dir['file_id'].'">Copy</a> | <a href="javascript:void(0)" class="file_delete" file-name="'.$dir['filename'].'" li-count="'.$i.'" file-id="'.$dir['file_id'].'">Delete</a></span><hr></li>';
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
	
	public function deletefileAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
		$this->_helper->viewRenderer->setNoRender(true);
		$this->_helper->layout->disableLayout();
		
		$user_id=Engine_Api::_()->user()->getViewer()->getIdentity(); 
		$viewer     = Engine_Api::_()->user()->getViewer();
		$subject = Engine_Api::_()->core()->getSubject();
		
		$aData = $this->_request->getPost(); 
		$filename	=	$aData['file_name'];
		$current_directory	=	$aData['current_directory'];
		$dirname =   $subject->getIdentity().'_'.$subject->displayname; 
		if($current_directory ==''){
		 $dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dirname.'/'.$current_directory.$filename; 
		}
		else{
		 $dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dirname.'/'.$current_directory.'/'.$filename; 
	    }
	    if (file_exists($dir)){
			unlink($dir);
			$aResult['msg'] ='This file is succesfully deleted.';	
		} 
        echo json_encode($aResult); 
		
	}
	
	public function deletedirAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
		$this->_helper->viewRenderer->setNoRender(true);
		$this->_helper->layout->disableLayout();
		
		$user_id=Engine_Api::_()->user()->getViewer()->getIdentity(); 
		$viewer     = Engine_Api::_()->user()->getViewer();
		$subject = Engine_Api::_()->core()->getSubject();
		
		$aData = $this->_request->getPost(); 
		
		$aData = $this->_request->getPost(); 
		$deleteddir_name	=	$aData['dir_name'];
		$current_directory	=	$aData['current_directory'];
		$dirname =   $subject->getIdentity().'_'.$subject->displayname; 
		if($current_directory ==''){
		 $dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dirname.'/'.$current_directory.$deleteddir_name; 
		}
		else{
		 $dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dirname.'/'.$current_directory.'/'.$deleteddir_name; 
	    }
		if (is_dir($dir)){
		array_map('unlink', glob("$dir/*.*"));
		rmdir($dir);
		$aResult['msg'] ='This folder is succesfully deleted.';	
	    }
		
		echo json_encode($aResult); 
	}
    
    public function renamefileAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
		$this->_helper->viewRenderer->setNoRender(true);
		$this->_helper->layout->disableLayout();
		
		$user_id=Engine_Api::_()->user()->getViewer()->getIdentity(); 
		$viewer     = Engine_Api::_()->user()->getViewer();
		$subject = Engine_Api::_()->core()->getSubject();
		
		$aData = $this->_request->getPost(); 

		
		$new_name	=	$aData['new_name'];
		$old_name	=	$aData['old_name'];
		$current_directory	=	$aData['current_directory'];
		$root_dirname =   $subject->getIdentity().'_'.$subject->displayname; 
		if($current_directory ==''){
		  $old_dir_name = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$root_dirname.'/'.$current_directory.$old_name; 
		  $new_dir_name = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$root_dirname.'/'.$current_directory.$new_name; 
		}
		else{
		  $old_dir_name = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$root_dirname.'/'.$current_directory.'/'.$old_name; 
		  $new_dir_name = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$root_dirname.'/'.$current_directory.'/'.$new_name; 
	    }
	    if(is_dir($old_dir_name)){
		rename($old_dir_name, $new_dir_name);
		$aResult['msg'] ='Succesfully renamed.';	
		$aResult['type'] ='dir';	
	    }
	    if(file_exists($old_dir_name)){
		rename($old_dir_name, $new_dir_name);
		$aResult['msg'] ='Succesfully renamed.';	
		$aResult['type'] ='file';	
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
		$subject = Engine_Api::_()->core()->getSubject();
		
		$aData = $this->_request->getPost();
		$share_dir_name	    =	$aData['share_dir_name'];
		$current_directory	=	$aData['current_directory'];
	    $landlord_ids	    =	$aData['landlord_ids'];
		$tenant_id          =   $subject->getIdentity();
		$landlords = explode(",",$landlord_ids); 
		
		$root_dirname =   $subject->getIdentity().'_'.$subject->displayname; 
		if($current_directory ==''){
		    $shared_document_path = $root_dirname.'/'.$current_directory.$share_dir_name;
	    }
	    else{
			 $shared_document_path = $root_dirname.'/'.$current_directory.'/'.$share_dir_name; 
		}
		try{
			$documentshareTable = Engine_Api::_()->getDbtable('documentshare', 'user');
			
			for($i=0;$i<count($landlords);$i++){
			
			$documentshareTableId=   $documentshareTable->insert(array(
			
                  'sender_id' => $tenant_id,
                  'reciever_id' => $landlords[$i],
                  'shared_document' => $shared_document_path,
                  'shared_document_name' => $share_dir_name,
                  'shared_date' => date('Y-m-d H:i:s'),

                    
                ));
			}
			$aResult['msg'] ='Succesfully shared.';
			
		}catch( Exception $e ) { echo $e; die(); }
		
		echo json_encode($aResult); 
		
	}
	public function locationpreferenceAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
		$this->view->user = $user = Engine_Api::_()->core()->getSubject();
        $this->view->viewer = $viewer = Engine_Api::_()->user()->getViewer();
        
        if($user->prefered_location !=''){
			
		if($user->prefered_location !='United States'){
			
		$location   = explode(",",$user->prefered_location);	
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
		$this->view->county = $user->prefered_county;
		$this->view->neighborhood = $user->prefered_neighborhood;
	    }
			
		$this->view->prefered_location = $user->prefered_location;	
		}
		
        

	}
    public function savelocationpreferenceAction(){
		
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
		$viewer     = Engine_Api::_()->user()->getViewer();
		$subject = Engine_Api::_()->core()->getSubject();
		$this->_helper->viewRenderer->setNoRender(true);
		$this->_helper->layout->disableLayout();
		
		$propertycountrtyTable  =  Engine_Api::_()->getDbtable('propertycountry', 'user');	  
		$propertystateTable     =  Engine_Api::_()->getDbtable('propertystate', 'user');	  
		$propertycityable       =  Engine_Api::_()->getDbtable('propertycity', 'user');	
		$userTable              =  Engine_Api::_()->getDbtable('users', 'user');  
		
		unset($_SESSION['countryId']);
		unset($_SESSION['stateId']);
		unset($_SESSION['cityId']);
		unset($_SESSION['set_to_usa']);
		
		if( $this->getRequest()->isPost()){
			 
			  $aData = $this->_request->getPost();
			 
			  
			  
			  if($aData['set_to_usa'] == ''){
			  
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
				
				
		$userData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $subject->getIdentity())); 	
		
		$userData->	prefered_location     = $propertycountryid.','.$propertystateid.','.$propertycityid;
		$userData->	prefered_county       =$aData['prty_county'];
		$userData->	prefered_neighborhood =$aData['prty_neighborhood'];
		$userData->save();
	}
	else{
		
		$userData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $subject->getIdentity())); 	
		
		$userData->	prefered_location = 'United States';
		
		$userData->save();
		
		
	}
		
		$aResult['status'] = true;
		
		}
		else{
			
			$aResult['status'] = false;
		}
		
		echo json_encode($aResult['status']);
		
	}
	
	public function hidecreditscoreAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
		$viewer     = Engine_Api::_()->user()->getViewer();
		$subject = Engine_Api::_()->core()->getSubject();
		$viewer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); 
		$this->_helper->viewRenderer->setNoRender(true);
		$this->_helper->layout->disableLayout();
		 
		$userTable = Engine_Api::_()->getDbtable('users', 'user');
		$userData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $viewer_id)); 
		if(!empty($userData)){
			
			$userData->creditscore_view_status= 0;
			$userData->save();
			$aResult['status'] = true;
		}
		else{
			$aResult['status'] = false;
			
		}
		echo json_encode($aResult['status']);
	 }
	public function showcreditscoreAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
		$viewer     = Engine_Api::_()->user()->getViewer();
		$subject = Engine_Api::_()->core()->getSubject();
		$viewer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); 
		$this->_helper->viewRenderer->setNoRender(true);
		$this->_helper->layout->disableLayout();
		 
		$userTable = Engine_Api::_()->getDbtable('users', 'user');
		$userData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $viewer_id)); 
		if(!empty($userData)){
			
			$userData->creditscore_view_status= 1;
			$userData->save();
			$aResult['status'] = true;
		}
		else{
			$aResult['status'] = false;
			
		}
		echo json_encode($aResult['status']);
	 }
	 
	 	public function getparentdirectorycontentsAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
		$this->_helper->viewRenderer->setNoRender(true);
		$this->_helper->layout->disableLayout();
		
		$user_id=Engine_Api::_()->user()->getViewer()->getIdentity(); 
		$viewer     = Engine_Api::_()->user()->getViewer();
		//$subject = Engine_Api::_()->core()->getSubject();
		
		$aData = $this->_request->getPost(); 
		$dirname	            =	$aData['dirname'];
	    $current_directory	    =	$aData['current_directory'];
	    $rootdir	            =	$aData['rootdir'];
	    if($current_directory == '/')
	    $current_directory = '';
	    $menu_open	    =	$aData['menu_open'];
		//$user_dir =   $subject->getIdentity().'_'.$subject->displayname; 
		if($current_directory == ''){
			if($menu_open == 0){
			
			$dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$rootdir;
		   }
		   else{
			   $dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$rootdir;
		   }
			
			$file_path = '/filemanager/'.$user_dir.'/'; 
			$doc_path = $user_dir.'/'; 
		}
		else{
		if($menu_open == 0){
		
		$dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$rootdir.'/'.$current_directory;
	    }
		else{
			$dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$rootdir.$current_directory;
		}
		
		$file_path = '/filemanager/'.$rootdir.'/'.$current_directory.'/';
		if($menu_open == 0){
		
		$doc_path =  $rootdir.$current_directory.'/';
	    }
	    else{
			$doc_path =  $rootdir.$current_directory.'/';
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
		$a = $a .'<li class="dir_li list'.$i.'" dir-name="'.$dir['dirname'].'"><a href="javascript:void(0)" class="dir_open" dir-name="'.$dir['dirname'].'"><img src="/application/modules/User/externals/images/document_folder.svg">&nbsp;&nbsp;'.$dir['dirname'].'</a><span class="option_links"><a href="javascript:void(0)" class="dir_rename" dir-name="'.$dir['dirname'].'" li-count="'.$i.'">Rename</a> | <a href="javascript:void(0)" class="dir_delete" dir-name="'.$dir['dirname'].'" li-count="'.$i.'">Delete</a></span><hr></li>';
		 $i++;
		 }
		}
		
		
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
			$b = $b.'<span class="option_links"><a href="javascript:void(0)" file-name="'.$dir['filename'].'" li-count="'.$i.'" class="file_details" file-id="'.$dir['file_id'].'">Details</a> | <a href="javascript:void(0)" file-name="'.$dir['filename'].'" li-count="'.$i.'" class="file_share" file-id="'.$dir['file_id'].'">Share</a> | <a href="javascript:void(0)" class="file_rename" file-name="'.$dir['filename'].'" li-count="'.$i.'" file-id="'.$dir['file_id'].'">Rename</a> | <a href="javascript:void(0)" class="file_copy" file-name="'.$dir['filename'].'" li-count="'.$i.'" file-id="'.$dir['file_id'].'">Copy</a> | <a href="javascript:void(0)" class="file_delete" file-name="'.$dir['filename'].'" li-count="'.$i.'" file-id="'.$dir['file_id'].'">Delete</a></span><hr></li>';
		  $i++;
		 }
		}

	$content= $a.$b;	
		$aResult['html'] = $content;
		if($menu_open == 0){
		$aResult['cur_dir'] = $current_directory ;
		$aResult['par_dir'] =  dirname($current_directory);
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
		public function getdirectoryAction(){
		if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
		$this->_helper->viewRenderer->setNoRender(true);
		$this->_helper->layout->disableLayout();
		
		$user_id=Engine_Api::_()->user()->getViewer()->getIdentity(); 
		$viewer     = Engine_Api::_()->user()->getViewer();
		$subject = Engine_Api::_()->core()->getSubject();
		
		$aData = $this->_request->getPost(); 
		$dirname	            =	$aData['dirname'];
	    $current_directory	    =	$aData['current_directory'];
	    $menu_open	    =	$aData['menu_open'];
		$user_dir =   $subject->getIdentity().'_'.$subject->displayname; 
		$aResult['par_dir'] =  dirname($current_directory);
		if($current_directory == ''){
			if($menu_open == 0){
			$dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$user_dir.'/'.$dirname;
		   }
		   else{
			   $dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$user_dir;
		   }
			$file_path = '/filemanager/'.$user_dir.'/'.$dirname.'/'; 
			$doc_path = $user_dir.'/'.$dirname.'/'; 
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
	    
		$files =	$this->loaddirectory($dir); //echo '<pre>' print_r($files) ;exit;
		
		 $dropboxfileTable = Engine_Api::_()->getDbtable('dropboxfiles', 'user');
    
        foreach($files['files'] as $file){
		   
		   $doc_path1 = $doc_path.$file['filename']; 
		   $dropboxfileData = $dropboxfileTable->fetchRow($dropboxfileTable->select()->where('file_path LIKE ?', $doc_path1.'%')); 	 
				
		   $tmpArrayFile[]	=	array('file_id'=>$dropboxfileData->id,'filename'=>$file['filename'],'file_title'=>$dropboxfileData->file_title,'file_owner_id'=> $dropboxfileData->file_owner_id,'file_path'=> $dropboxfileData->file_path,'created_at'=> $dropboxfileData->created_at);  

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
		//$a = $a .'<li class="dir_li list'.$i.'" dir-name="'.$dir['dirname'].'"><a href="javascript:void(0)" class="dir_open" dir-name="'.$dir['dirname'].'">'.$dir['dirname'].'</a><span class="option_links"><a href="javascript:void(0)" dir-name="'.$dir['dirname'].'" li-count="'.$i.'" class="dir_share">Share</a> | <a href="javascript:void(0)" class="dir_rename" dir-name="'.$dir['dirname'].'" li-count="'.$i.'">Rename</a> | <a href="javascript:void(0)" class="dir_delete" dir-name="'.$dir['dirname'].'" li-count="'.$i.'">Delete</a></span><hr></li>';
		$a = $a .'<li class="dir_li list'.$i.'" dir-name="'.$dir['dirname'].'"><a href="javascript:void(0)" class="dir_open" dir-name="'.$dir['dirname'].'"><img src="/application/modules/User/externals/images/document_folder.svg">&nbsp;&nbsp;'.$dir['dirname'].'</a><hr></li>';
		 $i++;
		 }
		}
		
		//print_r($files['files']); exit;
			if(count($files['files'])>0){
		    //$file_path = $_SERVER['HTTP_HOST'].'/filemanager/'.$user_dir.$current_directory.'/'.$dirname.'/'.$dir['filename']; 		
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
	 public function managesubscriptionAction(){

        $this->_helper->viewRenderer->setNoRender(false);
        $this->_helper->layout->setLayout('common_layout');
        $subject = Engine_Api::_()->core()->getSubject();
        $viewer        = Engine_Api::_()->user()->getViewer();
        $viewer_id     = Engine_Api::_()->user()->getViewer()->getIdentity();
        $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($subject);
        if( !empty($fieldsByAlias['profile_type']) ){
              $optionId        = $fieldsByAlias['profile_type']->getValue($subject);
              $profile_type_id = $optionId->value;
        }
        if($profile_type_id != 4){ //if not landlord
            return $this->_forward('notfound');
        }
	    $CardholderdetailsTable =  Engine_Api::_()->getDbtable('Cardholderdetails', 'user');
	    $CardholderdetailsData  =  $CardholderdetailsTable->fetchRow($CardholderdetailsTable->select()->where('userId = ?',  $subject->getIdentity()));
        $this->view->CardholderdetailsData  = $CardholderdetailsData;
	   
	   
	   
   }
}
