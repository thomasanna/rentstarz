<?php

class Install_Import_Ning_BlogComments extends Install_Import_Ning_Abstract
{
  protected $_fromFile = 'ning-blogs-local.json';

  protected $_fromFileAlternate = 'ning-blogs.json';

  protected $_toTable = 'engine4_core_comments';

  protected function  _translateRow(array $data, $key = null)
  {
    if( !isset($data['comments']) || !is_array($data['comments']) || count($data['comments']) < 1 ) {
      return false;
    }

    $blogIdentity = $key + 1;

    foreach( array_reverse($data['comments']) as $commentKey => $commentData ) {
      $commentUserIdentity = $this->getUserMap($commentData['contributorName']);

      // Insert into comments?
      $this->getToDb()->insert($this->getToTable(), array(
        'resource_type' => 'blog',
        'resource_id' => $blogIdentity,
        'poster_type' => 'user',
        'poster_id' => $commentUserIdentity,
        'body' => $this->_translateCommentBody($commentData['description']),
        'creation_date' => $this->_translateTime($commentData['createdDate']),
      ));
    }

    return false;
  }
}