<?php

class Install_Import_Ning_VideoVideos extends Install_Import_Ning_Abstract
{
  protected $_fromFile = 'ning-videos-local.json';

  protected $_fromFileAlternate = 'ning-videos.json';

  protected $_toTable = 'engine4_video_videos';

  protected $_priority = 700;

  protected function _translateRow(array $data, $key = null)
  {
    $userIdentity = $this->getUserMap($data['contributorName']);
    $videoIdentity = $key + 1;
    $this->setVideoMap($data['id'], $videoIdentity);

    $newData = array();

    $newData['video_id'] = $videoIdentity;
    $newData['title'] = $data['title'] ? : 'Untitled';
    $newData['owner_type'] = 'user';
    $newData['owner_id'] = $userIdentity;
    $newData['search'] = 1;
    $newData['creation_date'] = $this->_translateTime($data['createdDate']);
    $newData['modified_date'] = $this->_translateTime($data['updatedDate']);
    $newData['view_count'] = 0;
    $newData['comment_count'] = count((array) @$data['comments']);
    $newData['status'] = 1;

    // @todo duration, category_id, photo_id
    
    // privacy
    $this->_insertPrivacy('video', $newData['video_id'], 'view');
    $this->_insertPrivacy('video', $newData['video_id'], 'comment');

    // search
    $this->_insertSearch('video', $newData['video_id'], array(
      'title' => $newData['title'],
    ));

    // Youtube
    if( !empty($data['embedCode']) && stripos($data['embedCode'], 'youtube.com') !== false ) {
      if( preg_match('/v\/(.+?)(\/|&|$)/', $data['embedCode'], $m) ) {
        $newData['type'] = 1;
        $newData['code'] = $m[1];
        // check for http://www.youtube.com/embed/XXXXXXX?fs
      } else if (preg_match('/embed\/(.+?)(\/|\?|\"|$)/', $data['embedCode'], $m1)) {
        $newData['type'] = 1;
        $newData['code'] = $m1[1];
      } else {
        throw new Engine_Exception('Unable to parse video embed code - ' . Zend_Json::encode($data['embedCode']));
      }
    }

    // Vimeo
    else if( !empty($data['embedCode']) && stripos($data['embedCode'], 'vimeo.com') !== false ) {
      if( preg_match('/clip_id=(\d+)/', $data['embedCode'], $m) ) {
        $newData['type'] = 2;
        $newData['code'] = $m[1];
      } else {
        throw new Engine_Exception('Unable to parse video embed code - ' . Zend_Json::encode($data['embedCode']));
      }
    }

    // File
    else if( !empty($data['videoAttachmentUrl']) ) {

      $file = $this->getFromPath() . DIRECTORY_SEPARATOR . $data['videoAttachmentUrl'];

      // Flash
      $fileExtension = ltrim(strrchr($file, '.'), '.');
      if( in_array($fileExtension, array('flv', 'mp4')) ) {
        $newData['type'] = 3;
        $file_id = $this->_translateFile($file, array(
          'parent_type' => 'video',
          'parent_id' => $videoIdentity,
          'user_id' => $userIdentity,
        ));
        $newData['file_id'] = $file_id;
      } else {
        throw new Engine_Exception('Unsupported file type - ' . $data['videoAttachmentUrl']);
      }
      
    }

    // Wtf
    else
    {
      throw new Engine_Exception('Unknown video type - ' . Zend_Json::encode($data));
    }

    try
    {
      $newData['photo_id'] = $this->_translateThumbnail($newData);
    }
    catch (Exception $e)
    {
      // Silence
    }
    return $newData;
  }

  // Now try to create thumbnail
  protected function _translateThumbnail($newData)
  {
    $file_id = 0;
    if( empty($newData['code']) ) {
      return $file_id;
    }

    $thumbnail = $this->handleThumbnail($newData['type'], $newData['code']);
    if( !$thumbnail ) {
      return $file_id;
    }

    $ext = ltrim(strrchr($thumbnail, '.'), '.');
    if( !$ext || !in_array($ext, array('jpg', 'jpeg', 'gif', 'png')) ) {
      return $file_id;
    }

    $thumbnail_parsed = @parse_url($thumbnail);
    if( !$thumbnail_parsed || !@GetImageSize($thumbnail) ) {
      return $file_id;
    }

    $temporary_directory = $this->_sys_get_temp_dir();
    $tmp_file = $temporary_directory . '/video_' . md5($thumbnail) . '.' . $ext;
    $thumb_file = $temporary_directory . '/video_thumb_' . md5($thumbnail) . '.' . $ext;
    $src_fh = fopen($thumbnail, 'r');
    $tmp_fh = fopen($tmp_file, 'w');
    stream_copy_to_stream($src_fh, $tmp_fh, 1024 * 1024 * 2);
    $image = Engine_Image::factory();
    $image->open($tmp_file)
      ->resize(120, 240)
      ->write($thumb_file)
      ->destroy();

    $file_id = $this->_translateFile($thumb_file, array(
      'parent_type' => 'video',
      'parent_id' => $newData['video_id'],
      'user_id' => $newData['owner_id']
      ), false);
    @unlink($thumb_file);
    @unlink($tmp_file);

    return $file_id;
  }

  // handles thumbnails
  private function handleThumbnail($type, $code = null)
  {
    switch ($type) {
      //youtube
      case "1":
        //https://i.ytimg.com/vi/Y75eFjjgAEc/default.jpg
        return "https://i.ytimg.com/vi/$code/default.jpg";
      //vimeo
      case "2":
        //thumbnail_medium
        $data = simplexml_load_file("http://vimeo.com/api/v2/video/" . $code . ".xml");
        $id = count($data->video->id);
        if ($id == 0)
          return false;
        return $data->video->thumbnail_medium;
    }
  }
}
