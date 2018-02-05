<?php

class Advancedarticles_Widget_CategoriesBlockController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
    $front = Zend_Controller_Front::getInstance();
    $_module = $front->getRequest()->getModuleName();
	$this->view->categories = $categoties = Engine_Api::_()->$_module()->loadCategory($_module);
	$this->view->cid = $id = (int) $front->getRequest()->getParam('id', -1);
	$art_id = (int) $front->getRequest()->getParam('art_id', 0);
	if ($art_id) $this->view->cid = $id = Engine_Api::_()->$_module()->getCategoryID($art_id);	
  }    
}  