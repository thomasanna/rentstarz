<?php

abstract class Install_Import_Ning_Abstract extends Install_Import_JsonAbstract
{
  static protected $_userMap;

  static protected $_groupMap;

  static protected $_eventMap;

  static protected $_discussionMap;

  static protected $_videoMap;

  static protected $_pageMap;

  static protected $_levels;

  static protected $_updateUsers;

  protected $_doReverseData = true;


  // User map

  public function getUserMap($key)
  {
    if( isset(self::$_userMap[$key]) ) {
      return self::$_userMap[$key];
    } else {
      throw new Engine_Exception('No user mapping detected');
    }
  }

  public function setUserMap($key, $userIdentity)
  {
    self::$_userMap[$key] = $userIdentity;
    return $this;
  }



  // Group map

  public function getGroupMap($key)
  {
    if( isset(self::$_groupMap[$key]) ) {
      return self::$_groupMap[$key];
    } else {
      throw new Engine_Exception('No group mapping detected');
    }
  }

  public function setGroupMap($key, $groupIdentity)
  {
    self::$_groupMap[$key] = $groupIdentity;
    return $this;
  }



  // Event map

  public function getEventMap($key)
  {
    if( isset(self::$_eventMap[$key]) ) {
      return self::$_eventMap[$key];
    } else {
      throw new Engine_Exception('No event mapping detected');
    }
  }

  public function setEventMap($key, $eventIdentity)
  {
    self::$_eventMap[$key] = $eventIdentity;
    return $this;
  }



  // Discussion map

  public function getDiscussionMap($key)
  {
    if( isset(self::$_discussionMap[$key]) ) {
      return self::$_discussionMap[$key];
    } else {
      throw new Engine_Exception('No discussion mapping detected');
    }
  }

  public function setDiscussionMap($key, $topicIdentity)
  {
    self::$_discussionMap[$key] = $topicIdentity;
    return $this;
  }



  // Discussion map

  public function getVideoMap($key)
  {
    if( isset(self::$_videoMap[$key]) ) {
      return self::$_videoMap[$key];
    } else {
      throw new Engine_Exception('No video mapping detected');
    }
  }

  public function setVideoMap($key, $topicIdentity)
  {
    self::$_videoMap[$key] = $topicIdentity;
    return $this;
  }

  // Page map
  public function getPageMap($key)
  {
    if (isset(self::$_pageMap[$key])) {
      return self::$_pageMap[$key];
    } else {
      throw new Engine_Exception('No page mapping detected');
    }
  }

  public function setPageMap($key, $pageIdentity)
  {
    self::$_pageMap[$key] = $pageIdentity;
    return $this;
  }

  // Activities map
  public function getActivitiesDirectoryPath()
  {
    return $this->getToPath() . DIRECTORY_SEPARATOR . 'temporary' . DIRECTORY_SEPARATOR . 'ning-activties' . DIRECTORY_SEPARATOR;
  }

  public function setActivity($key, $activity)
  {
    $date = gmdate('Y-m-d', $key);
    $path = $this->getActivitiesDirectoryPath();
    $path .= str_replace('-', DIRECTORY_SEPARATOR, $date) . '.json';
    $dirName = dirname($path);
    @mkdir($dirName, 0777, true);
    $fromData = array();
    if (file_exists($path)) {
      $fromData = Zend_Json::decode(file_get_contents($path));
    }
    $fromData[$key] = $activity;
    $file_contents = Zend_Json::encode($fromData);
    file_put_contents($path, $file_contents);
    return $this;
  }

  // Update users

  public function setUpdateUser($user_id)
  {
    self::$_updateUsers[] = $user_id;
    return $this;
  }

  public function isUpdateUser($user_id)
  {
    return in_array($user_id, (array) self::$_updateUsers);
  }



  // MIsc


  public function getLevel($type)
  {
    $types = explode(' ', $type);
    if( in_array('owner', $types) ) {
      return 1;
    } else {
      return 4;
    }
  }

  protected function _insertPrivacy($resourceType, $resourceId, $action, $value = 'everyone')
  {
    $this->getToDb()->insert('engine4_authorization_allow', array(
      'resource_type' => $resourceType,
      'resource_id' => $resourceId,
      'action' => $action,
      'role' => $value,
      'value' => 1,
    ));
  }

  protected function _insertSearch($resourceType, $resourceId, $searchData = array())
  {
    $defaultData = array(
      'type' => $resourceType,
      'id' => $resourceId,
      'title' => '',
      'description' => '',
      'keywords' => '',
      'hidden' => ''
    );

    $searchData = array_merge($defaultData, array_filter($searchData));
    if($searchData['description']) {
      $description = strip_tags($searchData['description']);
      $searchData['description'] = ( Engine_String::strlen($description) > 255 ? Engine_String::substr($description, 0, 252) . '...' : $description );
    }

    try {
      $this->getToDb()->insert('engine4_core_search', $searchData);
    } catch( Exception $e ) {
      // ignore exception
    }
  }

  protected function _translateCommentBody($string)
  {
    $string = preg_replace('#<br\s*/?>#i', "[TEMP_BR]", $string);
    $string = str_replace('[TEMP_BR]', '<br />', strip_tags($string));
    return str_replace('\u00a0', '', $string);
  }
}
