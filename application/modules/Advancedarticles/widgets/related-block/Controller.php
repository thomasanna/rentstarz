<?php

class Advancedarticles_Widget_RelatedBlockController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
    $perpage = $this->_getParam('perpage', 10);
    $front = Zend_Controller_Front::getInstance();
	$art_id = (int) $front->getRequest()->getParam('art_id', 0);
	if (!$art_id) return $this->setNoRender();
	
	$article = Engine_Api::_()->getItem('artarticle', $art_id);

	if (!is_object($article)) return $this->setNoRender();
	
	$related_articles = $article->getRelatedArticles();
	if (!is_object($related_articles)) return $this->setNoRender();
	
    $paginator = Zend_Paginator::factory($related_articles);
    $paginator->setItemCountPerPage($perpage);
    $paginator->setCurrentPageNumber(1);
	$this->view->paginator = $paginator;
	
	if (!$paginator->getTotalItemCount()) return $this->setNoRender();
  }    
}  