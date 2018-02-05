<?php

class Advancedarticles_Model_Category extends Core_Model_Item_Abstract
{
  public function delete_category($left_id = 0, $right_id = 0, $parent_id = 0, $module) 
	{
	  $table = Engine_Api::_()->getDbtable('categories', $module);
	  $categoriesTableName = $table->info('name');
   	  $sql = "UPDATE " . $categoriesTableName . "
						SET left_id = left_id - 1, right_id = right_id - 1
						WHERE left_id BETWEEN {$left_id} AND {$right_id}";

      $table->getAdapter()->query($sql);

   	  $sql = "UPDATE " . $categoriesTableName . "
						SET right_id = right_id - 2
						WHERE right_id > {$right_id}";
      $table->getAdapter()->query($sql);

   	  $sql = "UPDATE " . $categoriesTableName . "
						SET left_id = left_id - 2
						WHERE left_id > {$right_id}";
      $table->getAdapter()->query($sql);
	  
   	  $sql = "UPDATE " . $categoriesTableName . "
						SET parent_id = 0
						WHERE parent_id = {$parent_id}";
      $table->getAdapter()->query($sql);	  
  }
  
  public function migrateArticles($module = 'advancedarticles') {
  	
    $table = Engine_Api::_()->getDbtable('categories', $module);
    $select = $table->select();
    $select
      ->where('category_id != ?', $this->category_id)
      ->order('sort')
      ->limit(1);
    $data = $table->fetchRow($select);  
    $new_id = $data ? $data->category_id : 0;
    
    Engine_Api::_()->getItemTable('artarticle')->update(array(
	       'category_id' => $new_id,
	    ), array(
           'category_id = ?' => $this->category_id,
    ));

	return true;		
  }  
  
  public function getHref($adv_params = array())
  {
    $params = array(
      'id' => $this->category_id
    );
	$seo = !empty($this->url) ? '/'.$this->url : '';
    return Zend_Controller_Front::getInstance()->getRouter()->assemble($params, 'advancedarticles_category_specific', true).$seo;
  }  
  
  public function getTitle()
  {
    if( isset($this->name) && '' !== trim($this->name) ) return $this->name;
  } 	
}
