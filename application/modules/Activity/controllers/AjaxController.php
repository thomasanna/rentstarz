<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Activity
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: AjaxController.php 9806 2012-10-30 23:54:12Z matthew $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Activity
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Activity_AjaxController extends Core_Controller_Action_Standard
{
  public function feedAction()
  {    
    // Get config options for activity
    $config = array(
      'action_id' => (int) $this->_getParam('action_id'),
      'max_id' => (int) $this->_getParam('maxid'),
      'min_id' => (int) $this->_getParam('minid'),
      'limit' => (int) $this->_getParam('limit'),
    );
    
    $viewer = Engine_Api::_()->user()->getViewer();

    if( !isset($subject) && Engine_Api::_()->core()->hasSubject() ) {
      $subject = Engine_Api::_()->core()->getSubject();
    }

    if( !empty($subject) ) {
      $activity = Engine_Api::_()->getDbtable('actions', 'activity')->getActivityAbout($subject, $viewer, $config);
      $this->view->subjectGuid = $subject->getGuid(false);
    } else {
      $activity = Engine_Api::_()->getDbtable('actions', 'activity')->getActivity($viewer, $config);
      $this->view->subjectGuid = null;
    }

    $feed = array();
    foreach( $activity as $action ) {
      $attachments = array();
      if( $action->attachment_count > 0 ) {
        foreach( $action->getAttachments() as $attachment ) {
          $attachments[] = array(
            'meta' => $attachment->meta->toArray(),
            'item' => $attachment->item->toRemoteArray(),
          );
        }
      }
      $feed[] = array(
        'typeinfo' => $action->getTypeInfo()->toArray(),
        'action' => $action->toArray(),
        'subject' => $action->getSubject()->toRemoteArray(),
        'object' => $action->getObject()->toRemoteArray(),
        'attachments' => $attachments
      );
    }
    $this->view->feed = $feed;
  }
  
  /**
     * function for uploading images
     * @param integer $wordid
     * @param string $word
     * @return json array
     *
     */

    public function shareuploadAction()
    {if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $shareupload    =   $this->_getParam('shareuploads');
        $feeduploads    =   $this->_getParam('feeduploads');

        $this->shareuploads =   (array)json_decode($this->user_readsession($shareupload,$this->shareuploads));
        $this->feeduploads =    (array)json_decode($this->user_readsession($feeduploads,$this->feeduploads));
       // print_r($this->shareuploads);
       // extit();
        $aData = $this->_request->getPost();
        $existing_image_count = $aData['existing_image_count']; 
        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        $user=Engine_Api::_()->user()->getViewer();
        $upload = new Zend_File_Transfer_Adapter_Http();
        $path=dirname($_SERVER['SCRIPT_FILENAME']).'/public/share/'.$user->getIdentity().'/';
        if(!is_dir($path)){
            mkdir($path,0777,true);
        }
        $upload->setDestination($path);
        if($existing_image_count != 0){
			
			if(isset($this->shareuploads) && (count($this->shareuploads) + $existing_image_count) >=12){
            exit;
        }
		}
        if(isset($this->shareuploads) && count($this->shareuploads)>=12){
            exit;
        }
        try {
              $filename = $upload->getFileName(null,false);
              $filemtype = $upload->getMimeType();
              $filesize = $upload->getFileSize();
              $originalFilename = pathinfo($filename);
              $newFilename = 'share-' . uniqid() . '.' . $originalFilename['extension'];
              $target='public/share/'.$user->getIdentity().'/'.$newFilename;
              $upload->addValidator('Extension', false, array('jpg', 'png','gif','jpeg'));
              $upload->addFilter('Rename',array('target' => $target,'overwrite' => true));
                if (!$upload->isValid()){
                    $dataError = $upload->getMessages();
                    if($dataError['fileUploadErrorIniSize']) {
                        $dataError['fileUploadErrorIniSize'] = ' your file is too large. Please make sure your file is under 10MB.';
                    }
                    $error = array('Sorry');
                    foreach($dataError as $key=>$row)
                    {
                        $error[] = $row;
                    }
                   $res= array('status'=>'error','message'=>$error);
                } else {
                    if($upload->receive()){
                      $image = Engine_Image::factory();
                      $image->open($target);
                      $smallPath = $path . '58_' . $newFilename;
                      $size = min($image->height, $image->width);
                      $x = ($image->width - $size) / 2;
                      $y = ($image->height - $size) / 2;
                      $image->resample($x, $y, $size, $size, 58, 58)
                        ->write($smallPath)
                        ->destroy();
                      $bigPath = $path . '166_' . $newFilename;
                      $image->open($target);
                      $image->resample($x, $y, $size, $size, 166, 166)
                        ->write($bigPath)
                        ->destroy();

                      $sptarget='public/share/'.$user->getIdentity().'/'.'58_'.$newFilename;
                      $bptarget='public/share/'.$user->getIdentity().'/'.'166_'.$newFilename;
                      $mptarget='public/share/'.$user->getIdentity().'/'.$newFilename;

                      if(count($this->shareuploads)<=0){
                        $pindex=1;
                      } else {
                        $pindex=0;
                      }
                      $this->shareuploads[] = array('main_image'=>$mptarget,'small_image'=>$sptarget,'big_image'=>$bptarget,'primary'=>$pindex);


                        $pid=1;
                        if(isset($this->feeduploads)){$pid=count($this->feeduploads)+1;}
                        $files[]= array(
                                  'url'=> $this->get_full_url().'/'.$mptarget,
                                  'previewthumb_url'=> $this->get_full_url().'/'.$sptarget,
                                  'name'=> $newFilename,
                                  'type'=> $filemtype,
                                  'size'=> $filesize,
                                  'delete_type'=> "DELETE",
                                  'photo_id' => $pid
                               );
                        $res= array('files'=>$files);
                        $this->feeduploads[$pid]=$files[0];
                        $this->user_writesession($feeduploads,$this->feeduploads);


                        //print_r((array)json_decode($this->user_readsession($shareupload,$this->shareuploads)));exit;
                        $this->user_writesession($shareupload,$this->shareuploads);

                      $res= array('status'=>'success','images'=>$this->shareuploads);
                    } else {
                      $res= array('status'=>'error','message'=>array('Upload Failed'));
                    }
                }
                echo json_encode($res);
        } catch (Zend_File_Transfer_Exception $e) {
              echo json_encode(array('status'=>'error: '.$e));
        }

    }
    
    public function uploadpreviewAction()
    {if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $shareupload=$this->_getParam('shareuploads');
        $this->view->shareupload=json_decode($this->user_readsession($shareupload), true);
        $this->view->feeduploads=$this->_getParam('feeduploads');
        $this->_helper->layout->disableLayout();
    }
    
    /**
     * function for showing preview of uploaded images
     * @return integer
     *
     */
    public function uploadstatAction()
    {if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $this->view->shareupload=$shareupload=$this->_getParam('shareuploads');
        $this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);

        $this->shareuploads =   (array)json_decode($this->user_readsession($shareupload,$this->shareuploads));

        if(isset($this->shareuploads)){
            echo count($this->shareuploads);
        } else {
            echo '0';
        }
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
    /**
     * function for getting full url
     * @return string
     *
     */
    protected function get_full_url() {
        $https = !empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off';
        return
            ($https ? 'https://' : 'http://').
            (!empty($_SERVER['REMOTE_USER']) ? $_SERVER['REMOTE_USER'].'@' : '').
            (isset($_SERVER['HTTP_HOST']) ? $_SERVER['HTTP_HOST'] : ($_SERVER['SERVER_NAME'].
            ($https && $_SERVER['SERVER_PORT'] === 443 ||
            $_SERVER['SERVER_PORT'] === 80 ? '' : ':'.$_SERVER['SERVER_PORT']))).
            substr($_SERVER['SCRIPT_NAME'],0, strrpos($_SERVER['SCRIPT_NAME'], '/'));
    }
    	/**
     * function for removing uploaded images
     * @return integer
     *
     */
    
    public function removeshareuploadAction()
    {if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }

        $viewer     = Engine_Api::_()->user()->getViewer();
        $primary=false;
        $this->_helper->layout->disableLayout();
        $aData  = $this->_request->getPost();
             $shareupload= $this->view->shareupload=$this->_getParam('shareuploads');
             $feeduploads=$this->view->feeduploads=$this->_getParam('feeduploads');
             $shareupload_session=(array)json_decode($this->user_readsession($shareupload), true);
       if(isset($shareupload_session[$aData['imageid']])){
            $iImage=$shareupload_session[$aData['imageid']];
            $path=dirname($_SERVER['SCRIPT_FILENAME']).'/';
            if(file_exists($path.$iImage['main_image'])){unlink($path.$iImage['main_image']); }
            if(file_exists($path.$iImage['small_image'])){unlink($path.$iImage['small_image']); }
            if(file_exists($path.$iImage['big_image'])){unlink($path.$iImage['big_image']); }
            if($iImage['primary']=='1'){
                $primary=true;
            }

            unset($shareupload_session[$aData['imageid']]);
            unset($_SESSION[$shareupload][$aData['imageid']]);

        }

        if(count($shareupload_session)!=0){
            if($primary){
                foreach($shareupload_session as $key => $val):
                    $val['primary']=1;
                    $shareupload_session[$key]= $val;
                    break;
                endforeach;

            }
        }

        $shareupload_session_new = array();
        foreach($shareupload_session as $key=>$value)
        {
            $shareupload_session_new[] = $value;
        }

        $this->user_writesession($shareupload,$shareupload_session_new);

        $this->view->shareupload_session=$shareupload_session_new;

    }
    
   /**
     * function for removing uploaded images
     * @return integer
     *
     */
    
    public function removeshareuploadvideoAction()
    {
if( !$this->_helper->requireUser()->isValid() ) {
          return;
        }
        $viewer     = Engine_Api::_()->user()->getViewer();
        $primary=false;
        $this->_helper->layout->disableLayout();
        $aData  = $this->_request->getPost();
		$videoid	=	$aData['videoid'];
		$fileid	=	$aData['fileid'];
		$video_image_path	=	$aData['imagepath'];
		$video = Engine_Api::_()->getItem('video', $videoid);
		
		$db = $video->getTable()->getAdapter();
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
           
            $path=dirname($_SERVER['SCRIPT_FILENAME']).'/';
            /*if(file_exists($path.$iImage['main_image'])){unlink($path.$iImage['main_image']); }
            if(file_exists($path.$iImage['small_image'])){unlink($path.$iImage['small_image']); }
            if(file_exists($path.$iImage['big_image'])){unlink($path.$iImage['big_image']); }*/
            
            /*if(file_exists($path.$video_path)){unlink($path.$video_path); }
            if(file_exists($path.$video_image_path)){unlink($path.$video_image_path); }*/
            
            unset($_SESSION['video_ids'][$key]);
            /*if($iImage['primary']=='1'){
                $primary=true;
            }*/

        }

        $videoids	=	$_SESSION['video_ids'];

		$resultArray	=	array();
		foreach($videoids as $videoid)
		{
		$video = Engine_Api::_()->getItem('video', $videoid);
		$storageTable =  Engine_Api::_()->getDbtable('files', 'storage');
		$photo = Engine_Db_Table::getDefaultAdapter()->select()
						  ->from('engine4_storage_files')
						  ->where('parent_id = ?',$videoid)
						  ->where('type = ?','thumb')
						  ->query()->fetch();

		array_push($resultArray, $photo);		
		}  
	
		$this->view->videoResult	=	$resultArray;

    }
    
}
