<?php

class Advancedarticles_Widget_TagsBlockController extends Engine_Content_Widget_Abstract
{
  public function indexAction() 
  {
    $count_perpage = $this->_getParam('perpage', 20);
    $sort = $this->_getParam('sort', 'text');
    $this->view->link = $link = $this->_getParam('link', 1);
    
    $tagMapsTable = Engine_Api::_()->getDbtable('TagMaps', 'core');
	$table = Engine_Api::_()->getDbtable('tags', 'core');
    $tName = $table->info('name');
    $mName = $tagMapsTable->info('name');
	
    $select = $table->select();
	$select
	  ->setIntegrityCheck(false)
      ->from($tName, new Zend_Db_Expr('COUNT(engine4_core_tagmaps.tag_id) AS count'))
      ->join("{$mName}", "`{$tName}`.`tag_id` = `{$mName}`.`tag_id`", array('engine4_core_tags.tag_id', 'engine4_core_tags.text', 'engine4_core_tagmaps.resource_type'))
	  ->group("{$tName}.text")
	  ->group("{$mName}.resource_type")
	  ->having("{$mName}.resource_type = ? ", "artarticle");
	
	$by = ($sort == 'count') ? ' desc' : ' asc';
	$select->order($sort . $by);
	  
	$select->limit($count_perpage);

 
	$this->view->same_tags = $tags = $select->query()->fetchAll();

	if (!count($tags)) return $this->setNoRender();
	$count = array();
	foreach ($tags as $tag) {
	  $count[] = $tag['count'];
	}
	$this->view->max_tags = max($count);
	$this->view->min_tags = min($count);
  }
}  