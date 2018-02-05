<?php

class Advancedarticles_Widget_ViewBlockController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
    $perpage = $this->_getParam('perpage', 5);
	
	$articles = Engine_Api::_()->advancedarticles()->getArticles(0, 'advancedarticles', array('num_views'));
	if (!is_object($articles)) return $this->setNoRender();
	
    $paginator = Zend_Paginator::factory($articles);
    $paginator->setItemCountPerPage($perpage);
    $paginator->setCurrentPageNumber(1);
	$this->view->paginator = $paginator;
	
	if (!$paginator->getTotalItemCount()) return $this->setNoRender();
  }    
}  