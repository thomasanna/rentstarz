<?php

class Advancedarticles_Widget_UserInfoController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
    $front = Zend_Controller_Front::getInstance();
	$art_id = (int) $front->getRequest()->getParam('art_id', 0);
	if (!$art_id) return $this->setNoRender();
	
	$article = Engine_Api::_()->getItem('artarticle', $art_id);
	if (!is_object($article)) return $this->setNoRender();
	$this->view->article = $article;
	$this->view->count_art = count($article->getOwnerArticle());
	
	$viewer = Engine_Api::_()->user()->getViewer();

	$this->view->photo_upload = $article->authorization()->isAllowed($viewer, 'art_photo');
	$this->view->art_edit = $article->authorization()->isAllowed($viewer, 'edit');
	$this->view->art_delete = $article->authorization()->isAllowed($viewer, 'art_delete');
  }    
}  