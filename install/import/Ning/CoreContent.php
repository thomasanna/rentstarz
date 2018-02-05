<?php

class Install_Import_Ning_CoreContent extends Install_Import_Ning_Abstract
{
  protected $_fromFile = 'ning-pages-local.json';
  protected $_fromFileAlternate = 'ning-pages.json';
  protected $_toTable = 'engine4_core_content';
  protected $_priority = 6500;

  protected function _translateRow(array $data, $key = null)
  {

    $pageId = $this->getPageMap($data['id']);

    // Insert main content for page
    $this->getToDb()->insert($this->getToTable(), array(
      'page_id' => $pageId,
      'type' => 'container',
      'name' => 'main'
    ));
    $mainIdentity = $this->getToDb()->lastInsertId();

    // Insert main-middle content for page
    $this->getToDb()->insert($this->getToTable(), array(
      'page_id' => $pageId,
      'type' => 'container',
      'parent_content_id' => $mainIdentity,
      'name' => 'middle'
    ));
    $middleIdentity = $this->getToDb()->lastInsertId();

    // Insert html-block widget
    $this->getToDb()->insert($this->getToTable(), array(
      'page_id' => $pageId,
      'type' => 'widget',
      'parent_content_id' => $middleIdentity,
      'name' => 'core.html-block',
      'params' => Zend_Json::encode(array('title' => $data['title'], 'data' => $data['description']))
    ));
    return false;
  }
}
