<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Controller.php 10189 2014-04-30 18:51:06Z andres $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class User_Widget_ProfileDocumentsController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
	   // Don't render this if not authorized
    $viewer = Engine_Api::_()->user()->getViewer();
    $subject = Engine_Api::_()->core()->getSubject();
    if( !Engine_Api::_()->core()->hasSubject() ) {
      return $this->setNoRender();
    }

    // Get subject and check auth
    $subject = Engine_Api::_()->core()->getSubject('user');
    if( !$subject->authorization()->isAllowed($viewer, 'view') ) {
      return $this->setNoRender();
    }
    
    /*if($subject->level_id !=7){
		return $this->setNoRender();
	}*/
    
     $viewer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); 
     
	
	$dirname =   $subject->getIdentity().'_'.$subject->displayname;  
	
	
			
	$dir = dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$dirname;
	if (!is_dir($dir)) {
			mkdir($dir, 0777, true);
	}
		
	   $files =	$this->loaddirectory($dir);
	  // echo '<pre>';
	  // print_r($files['directories']); exit;
	   $tmpArrayFile= array();
			$tmpArrayDir= array();
			$resultData= array();
	   
	   $documentreqTable = Engine_Api::_()->getDbtable('documentrequests', 'user');
	   $documentshareTable = Engine_Api::_()->getDbtable('documentshare', 'user');
	   
	foreach($files['directories'] as $file){
		   
		$doc_path = $dirname.'/'.$file['dirname']; 

						
		$docReq_select = $documentreqTable->select()
						->where('doc_requested_user_id = ?', $viewer_id)
						->where('doc_path = ?', $doc_path); 
		$oData = $documentreqTable->fetchRow($docReq_select);
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
						
		 $tmpArrayDir[]	=	array('dirname'=>$file['dirname'],'is_docRequested'=>$is_docRequested,'is_docReqApproved'=> $is_docReqApproved);  
  
	   }
	   $dropboxfileTable = Engine_Api::_()->getDbtable('dropboxfiles', 'user');
	   
	   foreach($files['files'] as $file){
		   
		   $doc_path = $dirname.'/'.$file['filename']; 
		   $dropboxfileData = $dropboxfileTable->fetchRow($dropboxfileTable->select()->where('file_path = ?', $doc_path));
		    	 
          
            
        $docReq_select = $documentreqTable->select()
					->where('doc_requested_user_id = ?', $viewer_id)
					->where('file_id = ?', $dropboxfileData->id); 
		$oData = $documentreqTable->fetchRow($docReq_select);
		
		
        $docShare_select = $documentshareTable->select()   // shared or not
					->where('reciever_id = ?', $viewer_id)
					->where('share_file_id = ?', $dropboxfileData->id); 
		$shareoData = $documentshareTable->fetchRow($docShare_select);
		
	
		
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
		
		 $tmpArrayFile[]	=	array('filename'=>$file['filename'],'filetitle'=>$dropboxfileData->file_title,'file_id'=>$dropboxfileData->id,'is_docRequested'=>$is_docRequested,'is_docReqApproved'=> $is_docReqApproved);  
   
	   }
	   
    $tmpResultData['directories'] = $tmpArrayDir;
	$tmpResultData['files'] = $tmpArrayFile;
	$resultData = array_merge($resultData,$tmpResultData); //echo '<pre>'; print_r($resultData); exit;
	
	$this->view->files = $resultData; 
	
    $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer); 
    
    if( !empty($fieldsByAlias['profile_type']) )
    {
      $optionId = $fieldsByAlias['profile_type']->getValue($viewer);
       $profile_type_id = $optionId->value; 
    }
	
	if($profile_type_id  == 4){
		$is_landlord = 1;

	}
	else{
		$is_landlord = 0;
	}
	
	$this->view->is_landlord = $is_landlord;

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
  
  
}
