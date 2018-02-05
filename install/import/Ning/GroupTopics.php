<?php

class Install_Import_Ning_GroupTopics extends Install_Import_Ning_Abstract
{
  protected $_fromFile = 'ning-discussions-local.json';

  protected $_fromFileAlternate = 'ning-discussions.json';

  protected $_toTable = 'engine4_group_topics';

  protected $_priority = 600;

  protected function  _translateRow(array $data, $key = null)
  {
    if( empty($data['groupId']) ) {
      return false;
    }

    $groupIdentity = $this->getGroupMap($data['groupId']);
    $userIdentity = $this->getUserMap($data['contributorName']);
    $topicIdentity = $key + 1;
    
    $newData = array();

    $newData['group_id'] = $groupIdentity;
    $newData['topic_id'] = $topicIdentity;
    $newData['user_id'] = $userIdentity;
    $newData['title'] = $data['title'] ? : 'Untitled';
    //$newData['description'] = $data['description'];
    $newData['creation_date'] = $this->_translateTime(strtotime($data['createdDate']));
    $newData['modified_date'] = $this->_translateTime(strtotime($data['updatedDate']));
    $newData['sticky'] = false;
    $newData['closed'] = false;
    $newData['post_count'] = ( empty($data['comments']) ? 0 : count($data['comments']) ) + 1;

    // search
    $this->_insertSearch('group_topic', $topicIdentity, array(
      'title' => $newData['title'],
    ));
    return $newData;
  }
}