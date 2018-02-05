<?php

class Install_Import_Ning_ForumPosts extends Install_Import_Ning_Abstract
{
  protected $_fromFile = 'ning-discussions-local.json';

  protected $_fromFileAlternate = 'ning-discussions.json';

  protected $_toTable = 'engine4_forum_posts';

  protected $_priority = 200;

  protected function  _translateRow(array $data, $key = null)
  {
    if( !empty($data['groupId']) /*|| empty($data['category'])*/ ) {
      return false;
    }
    
    if( empty($data['category']) ) {
      $data['category'] = 'general discussion';
    }

    $userIdentity = $this->getUserMap($data['contributorName']);
    $topicIdentity = $key + 1;

    $forumIdentity = $this->getToDb()->select()
      ->from('engine4_forum_topics', 'forum_id')
      ->where('topic_id = ?', $topicIdentity)
      ->limit(1)
      ->query()
      ->fetchColumn(0);

    if( !$forumIdentity ) {
      return false;
    }
    // push primary post
    $posts = (array) @$data['comments'];
    array_push($posts, array(
      'id' => $data['id'],
      'contributorName' => $data['contributorName'],
      'description' => $data['description'],
      'createdDate' => $data['createdDate'],
    ));

    foreach(array_reverse($posts) as $postData ) {
      $postUserIdentity = $this->getUserMap($postData['contributorName']);
      $this->getToDb()->insert($this->getToTable(), array(
        'topic_id' => $topicIdentity,
        'user_id' => $postUserIdentity,
        'forum_id' => $forumIdentity,
        'body' => $postData['description'],
        'creation_date' => $this->_translateTime($postData['createdDate']),
        'modified_date' => $this->_translateTime($postData['createdDate']),
      ));
      $lastPostId = $this->getToDb()->lastInsertId();
      $lastPosterId = $postUserIdentity;
      // search
      $this->_insertSearch('forum_post', $lastPosterId, array(
        'description' => $postData['description'],
      ));
    }

    // Update last post?
    if( count($posts) > 0 && $lastPostId && $lastPosterId ) {
      $this->getToDb()->update('engine4_forum_topics', array(
        'lastpost_id' => $lastPostId,
        'lastposter_id' => $lastPosterId,
      ), array(
        'topic_id = ?' => $topicIdentity,
      ));

      $this->getToDb()->update('engine4_forum_forums', array(
        'lastpost_id' => $lastPostId,
        'lastposter_id' => $lastPosterId,
      ), array(
        'forum_id = ?' => $forumIdentity,
      ));
    }

    // Update signature?

    return false;
  }
}