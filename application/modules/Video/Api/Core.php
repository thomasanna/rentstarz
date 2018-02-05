<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Video
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Core.php 10212 2014-05-13 17:34:39Z andres $
 * @author     Jung
 */

/**
 * @category   Application_Extensions
 * @package    Video
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Video_Api_Core extends Core_Api_Abstract
{
  public function getVideosPaginator($params = array())
  {
    $paginator = Zend_Paginator::factory($this->getVideosSelect($params));
    if( !empty($params['page']) )
    {
      $paginator->setCurrentPageNumber($params['page']);
    }
    if( !empty($params['limit']) )
    {
      $paginator->setItemCountPerPage($params['limit']);
    }
    return $paginator;
  }

  public function getVideosSelect($params = array())
  {
    $table = Engine_Api::_()->getDbtable('videos', 'video');
    $rName = $table->info('name');

    $tmTable = Engine_Api::_()->getDbtable('TagMaps', 'core');
    $tmName = $tmTable->info('name');
    
    $select = $table->select()
      ->from($table->info('name'))
      ->order( !empty($params['orderby']) ? $params['orderby'].' DESC' : "$rName.creation_date DESC" );
    
    if( !empty($params['text']) ) {
      $searchTable = Engine_Api::_()->getDbtable('search', 'core');
      $db = $searchTable->getAdapter();
      $sName = $searchTable->info('name');
      $select
        ->joinRight($sName, $sName . '.id=' . $rName . '.video_id', null)
        ->where($sName . '.type = ?', 'video')
        ->where(new Zend_Db_Expr($db->quoteInto('MATCH(' . $sName . '.`title`, ' . $sName . '.`description`, ' . $sName . '.`keywords`, ' . $sName . '.`hidden`) AGAINST (? IN BOOLEAN MODE)', $params['text'])))
        //->order(new Zend_Db_Expr($db->quoteInto('MATCH(' . $sName . '.`title`, ' . $sName . '.`description`, ' . $sName . '.`keywords`, ' . $sName . '.`hidden`) AGAINST (?) DESC', $params['text'])))
        ;
    }
      
    if( !empty($params['status']) && is_numeric($params['status']) )
    {
      $select->where($rName.'.status = ?', $params['status']);
    }
    if( !empty($params['search']) && is_numeric($params['search']) )
    {
      $select->where($rName.'.search = ?', $params['search']);
    }
    if( !empty($params['user_id']) && is_numeric($params['user_id']) )
    {
      $select->where($rName.'.owner_id = ?', $params['user_id']);
    }

    if( !empty($params['user']) && $params['user'] instanceof User_Model_User )
    {
      $select->where($rName.'.owner_id = ?', $params['user_id']->getIdentity());
    }
    
    if( !empty($params['category']) )
    {
      $select->where($rName.'.category_id = ?', $params['category']);
    }

    if( !empty($params['tag']) )
    {
      $select
        // ->setIntegrityCheck(false)
        // ->from($rName)
        ->joinLeft($tmName, "$tmName.resource_id = $rName.video_id", NULL)
        ->where($tmName.'.resource_type = ?', 'video')
        ->where($tmName.'.tag_id = ?', $params['tag']);
    }

    return $select;
  }

  public function getCategories()
  {
    $table = Engine_Api::_()->getDbTable('categories', 'video');
    return $table->fetchAll($table->select()->order('category_name ASC'));
  }

  public function getCategory($category_id)
  {
    return Engine_Api::_()->getDbtable('categories', 'video')->find($category_id)->current();
  }

  public function getRating($video_id)
  {
    $table  = Engine_Api::_()->getDbTable('ratings', 'video');
    $rating_sum = $table->select()
      ->from($table->info('name'), new Zend_Db_Expr('SUM(rating)'))
      ->group('video_id')
      ->where('video_id = ?', $video_id)
      ->query()
      ->fetchColumn(0)
      ;

    $total = $this->ratingCount($video_id);
    if ($total) $rating = $rating_sum/$this->ratingCount($video_id);
    else $rating = 0;
    
    return $rating;
  }

  public function getRatings($video_id)
  {
    $table  = Engine_Api::_()->getDbTable('ratings', 'video');
    $rName = $table->info('name');
    $select = $table->select()
                    ->from($rName)
                    ->where($rName.'.video_id = ?', $video_id);
    $row = $table->fetchAll($select);
    return $row;
  }
  
  public function checkRated($video_id, $user_id)
  {
    $table  = Engine_Api::_()->getDbTable('ratings', 'video');

    $rName = $table->info('name');
    $select = $table->select()
                 ->setIntegrityCheck(false)
                    ->where('video_id = ?', $video_id)
                    ->where('user_id = ?', $user_id)
                    ->limit(1);
    $row = $table->fetchAll($select);
    
    if (count($row)>0) return true;
    return false;
  }

  public function setRating($video_id, $user_id, $rating){
    $table  = Engine_Api::_()->getDbTable('ratings', 'video');
    $rName = $table->info('name');
    $select = $table->select()
                    ->from($rName)
                    ->where($rName.'.video_id = ?', $video_id)
                    ->where($rName.'.user_id = ?', $user_id);
    $row = $table->fetchRow($select);
    if (empty($row)) {
      // create rating
      Engine_Api::_()->getDbTable('ratings', 'video')->insert(array(
        'video_id' => $video_id,
        'user_id' => $user_id,
        'rating' => $rating
      ));
    }
/*
    $select = $table->select()
      //->setIntegrityCheck(false)
      ->from($rName)
      ->where($rName.'.video_id = ?', $video_id);

    $row = $table->fetchAll($select);
    $total = count($row);
    foreach( $row as $item )
    {
      $rating += $item->rating;
    }
    $video = Engine_Api::_()->getItem('video', $video_id);
    $video->rating = $rating/$total;
    $video->save();*/
    
  }

  public function ratingCount($video_id){
    $table  = Engine_Api::_()->getDbTable('ratings', 'video');
    $rName = $table->info('name');
    $select = $table->select()
                    ->from($rName)
                    ->where($rName.'.video_id = ?', $video_id);
    $row = $table->fetchAll($select);
    $total = count($row);
    return $total;
  }

  // handle video upload
  public function createVideo($params, $file, $values)
  {
    if( $file instanceof Storage_Model_File ) {
      $params['file_id'] = $file->getIdentity();
    } else {
      // create video item
      $video = Engine_Api::_()->getDbtable('videos', 'video')->createRow();
      $file_ext = pathinfo($file['name']);
      $file_ext = $file_ext['extension'];
      $video->code = $file_ext;
      $video->save();

      // Store video in temporary storage object for ffmpeg to handle
      $storage = Engine_Api::_()->getItemTable('storage_file');
      $storageObject = $storage->createFile($file, array(
        'parent_id' => $video->getIdentity(),
        'parent_type' => $video->getType(),
        'user_id' => $video->owner_id,
      ));

      // Remove temporary file
      @unlink($file['tmp_name']);

      $video->file_id = $storageObject->file_id;
      $video->save();

      // Add to jobs
      if (Engine_Api::_()->getApi('settings', 'core')->getSetting('video.html5', false)) {
        Engine_Api::_()->getDbtable('jobs', 'core')->addJob('video_encode', array(
          'video_id' => $video->getIdentity(),
          'type' => 'mp4',
        ));
      } else {
        Engine_Api::_()->getDbtable('jobs', 'core')->addJob('video_encode', array(
          'video_id' => $video->getIdentity(),
          'type' => 'flv',
        ));
      }
    }

    return $video;
  }
  
  
  // handle video upload
  public function jquerycreateVideo($params, $file, $values)
  {
    if( $file instanceof Storage_Model_File ) {
      $params['file_id'] = $file->getIdentity();
    } else {
   
	  $fileids	=	array();
	  $videoids	=	array();
	  /*if(empty($_SESSION['storage_file_ids']))
	  {
		  unset($fileids);
	  }
	  else
	  {
		  $fileids	=	$_SESSION['storage_file_ids'];
		  //array_push($videoids,$_SESSION['storage_video_ids']);
	  }*/
	  
	  if(empty($_SESSION['video_ids']))
	  {
		  //unset($videoids);
		  reset($videoids);
	  }
	  else
	  {
		 
		if(isset($_SESSION['edit'])){
					   
					unset($_SESSION['video_ids']);
					unset($_SESSION['edit']);  
						
				}
		else{		
		  $videoids	=	$_SESSION['video_ids'];
		  
	    }
	  }
	  

    	  // create video item
      $video = Engine_Api::_()->getDbtable('videos', 'video')->createRow();
      $file_ext = $file['extension'];
      $video->code = $file_ext;
      $video->type = 3;
      $video->status = 1;
      $video->save();

      // Store video in temporary storage object for ffmpeg to handle
      $storage = Engine_Api::_()->getItemTable('storage_file');
      $storageObject = $storage->createFile($file, array(
        'parent_id' => $video->getIdentity(),
        'parent_type' => $video->getType(),
        'user_id' => $video->owner_id,
      ));
      $file_tmp_name = $storageObject->storage_path;
      $image_path = explode("/", $file_tmp_name);
      array_pop($image_path);
      $image_path = implode("/", $image_path);
      $image_name = strtotime("now");
      $image = $image_path.'/'.$image_name.'.jpg';
      $second = 1;
      $ffmpeg = '/usr/bin/ffmpeg';
      $command = "ffmpeg  -itsoffset -$second  -i $file_tmp_name -vcodec mjpeg -vframes 1 -an -f rawvideo  $image"; 
      exec($command);
   
      $data = array(
      'parent_file_id'=> $storageObject->file_id,
      'type'          => 'thumb',
      'parent_type'   => 'video',
      'parent_id'     => $storageObject->parent_id,
      'user_id'       => $storageObject->user_id,
      'creation_date' => $storageObject->creation_date,
      'modified_date' => $storageObject->modified_date,
      'service_id'    => $storageObject->service_id,
      'storage_path'  => $image,
      'extension'     => 'jpg',
      'name'          => $image_name.'jpg',
      'mime_major'    => 'image',
      'mime_minor'    => 'jpeg',
      'size'          => 1
      );
      
      $photo = Engine_Db_Table::getDefaultAdapter()->insert('engine4_storage_files',$data);
      /*array_push($fileids,$storageObject->file_id);
	  $_SESSION['storage_file_ids'] = $fileids;*/
      
      // Remove temporary file
      @unlink($file['tmp_name']);

      $video->file_id = $storageObject->file_id;
      $video->photo_id = Engine_Db_Table::getDefaultAdapter()->lastInsertId();
      $video->save();
      
      $video_ids	=	$video->getIdentity();
      array_push($videoids, $video_ids);
       //print_r($videoids);exit;
	  $_SESSION['video_ids'] = $videoids;
    

      // Store video in temp directory for ffmpeg to handle
//      $tmp_file = APPLICATION_PATH . '/temporary/video/'.$video->video_id.".".$file_ext;
//      $tmp_path = dirname($tmp_file);
//      if( !file_exists($tmp_path) ) {
//        mkdir($tmp_path, 0777, true);
//      }
//      $src_fh = fopen($file['tmp_name'], 'r');
//      $tmp_fh = fopen($tmp_file, 'w');
//      stream_copy_to_stream($src_fh, $tmp_fh);
      
      // Add to jobs
      Engine_Api::_()->getDbtable('jobs', 'core')->addJob('video_encode', array(
        'video_id' => $video->getIdentity(),
      ));
    }
    //$video->save();
    return $video;
  }


  public function deleteVideo($video)
  {

    // delete video ratings
    Engine_Api::_()->getDbtable('ratings', 'video')->delete(array(
      'video_id = ?' => $video->video_id,
    ));

    // check to make sure the video did not fail, if it did we wont have files to remove
    if ($video->status == 1){
      // delete storage files (video file and thumb)
      if ($video->type == 3) Engine_Api::_()->getItem('storage_file', $video->file_id)->remove();
      if ($video->photo_id) Engine_Api::_()->getItem('storage_file', $video->photo_id)->remove();
    }
    
    // delete activity feed and its comments/likes
    $item = Engine_Api::_()->getItem('video', $video->video_id);
    if ($item) {
      $item->delete();
    }


  }
}
