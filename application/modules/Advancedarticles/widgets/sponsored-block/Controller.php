<?php

class Advancedarticles_Widget_SponsoredBlockController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
    $perpage = (int) $this->_getParam('perpage', 3);
    $sort = $this->_getParam('sort', 'created_date');
    $this->view->interval = (int) $this->_getParam('interval', 7) * 1000;
    $category = (int) $this->_getParam('category_id', 0);
	
	$articles = Engine_Api::_()->advancedarticles()->getArticlesFor('sponsored', array('sponsored', $sort), $perpage, $category);
	if (!is_object($articles)) return $this->setNoRender();
	
    $paginator = Zend_Paginator::factory($articles);
    $paginator->setItemCountPerPage($perpage);
    $paginator->setCurrentPageNumber(1);
	$this->view->paginator = $paginator;
	$this->view->totalArticles = $total = $paginator->getTotalItemCount();
	if (!$total) return $this->setNoRender();
  }    
}  