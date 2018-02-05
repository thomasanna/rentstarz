<?php

class Install_Import_Ning_CorePages extends Install_Import_Ning_Abstract
{
  protected $_fromFile = 'ning-pages-local.json';
  protected $_fromFileAlternate = 'ning-pages.json';
  protected $_toTable = 'engine4_core_pages';
  protected $_priority = 7000;

  protected function _translateRow(array $data, $key = null)
  {

    $url = Engine_String::slug($data['title']);
    $hasUrl = true;
    $i = 0;
    do {
      $existingNameId = $this->getToDb()->select()
        ->from($this->getToTable(), 'page_id')
        ->where('url = ?', $url . ( $i ? '-' . $i : ''))
        ->limit(1)
        ->query()
        ->fetchColumn(0)
      ;
      if (!$existingNameId) {
        $hasUrl = false;
        $url = $url . ( $i ? '-' . $i : '');
      } else {
        $i++;
      }
    } while ($hasUrl);

    // Insert into comments?
    $this->getToDb()->insert($this->getToTable(), array(
      'custom' => 1,
      'displayname' => $data['title'],
      'title' => $data['title'],
      'description' => '',
      'keywords' => '',
      'url' => $url
    ));
    $pageIdentity = $this->getToDb()->lastInsertId();
    $this->setPageMap($data['id'], $pageIdentity);

    return false;
  }
}
