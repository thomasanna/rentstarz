<?php

class Install_Import_Ning_GroupComments extends Install_Import_Ning_Abstract
{
  protected $_fromFile = 'ning-groups-local.json';

  protected $_fromFileAlternate = 'ning-groups.json';

  protected $_toTable = 'engine4_core_comments';

  protected function  _translateRow(array $data, $key = null)
  {
    if( !isset($data['comments']) || !is_array($data['comments']) || count($data['comments']) < 1 ) {
      return false;
    }

    $groupOwnerIdentity = $this->getUserMap($data['contributorName']);
    $groupIdentity = $key + 1;

    foreach( array_reverse($data['comments']) as $commentKey => $commentData ) {
      $commentUserIdentity = $this->getUserMap($commentData['contributorName']);

      // Insert into comments?
      $this->getToDb()->insert($this->getToTable(), array(
        'resource_type' => 'group',
        'resource_id' => $groupIdentity,
        'poster_type' => 'user',
        'poster_id' => $commentUserIdentity,
        'body' => $this->_translateCommentBody($commentData['description']),
        'creation_date' => $this->_translateTime($commentData['createdDate']),
      ));

      //Set Activty
      $action = array(
        'type' => 'post',
        'subject_type' => 'user',
        'subject_id' => $commentUserIdentity,
        'object_type' => 'group',
        'object_id' => $groupIdentity,
        'body' => $this->_translateCommentBody($commentData['description']),
        'date' => $this->_translateTime($commentData['createdDate']),
      );

      $action['targetTypes'] = array(
          'owner' => $groupOwnerIdentity,
          'parent' => $groupOwnerIdentity,
          'members' => $groupOwnerIdentity,
          'registered' => 0,
          'everyone' => 0,
      );
      $key = strtotime($this->_translateTime($commentData['createdDate']));
      $this->setActivity($key, $action);
    }

    return false;
  }
}