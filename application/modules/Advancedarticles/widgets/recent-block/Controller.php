<?php

class Advancedarticles_Widget_RecentBlockController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
    $perpage = $this->_getParam('perpage', 10);
	
	$articles = Engine_Api::_()->advancedarticles()->getArticles(0, 'advancedarticles', array('created_date'));
	if (!is_object($articles)) return $this->setNoRender();
	
    $paginator = Zend_Paginator::factory($articles);
    $paginator->setItemCountPerPage($perpage);
    $paginator->setCurrentPageNumber(1);
	$this->view->paginator = $paginator;
	
	$auth = new Authorization_Controller_Action_Helper_RequireAuth();
	$this->view->art_create = $auth->setAuthParams('artarticle', null, 'create')->checkRequire();	
	
  }    
}  