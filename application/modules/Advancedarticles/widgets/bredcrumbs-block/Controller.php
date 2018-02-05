<?php

class Advancedarticles_Widget_BredcrumbsBlockController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
    $front = Zend_Controller_Front::getInstance();
    $_module = $front->getRequest()->getModuleName();
	
	$id = (int) $front->getRequest()->getParam('id', 0);
	$art_id = (int) $front->getRequest()->getParam('art_id', 0);
	if ($art_id) $id = Engine_Api::_()->$_module()->getCategoryID($art_id);
	$this->view->category = $categoty = Engine_Api::_()->$_module()->getCategoryObject($id, $_module); 
  }    
}  