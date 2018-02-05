<?php

class Advancedarticles_Widget_ActionsBlockController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
    $front = Zend_Controller_Front::getInstance();
    $_action = $front->getRequest()->getActionName();
	
  	$this->view->navigation = $navigation = Engine_Api::_()->getApi('menus', 'core')
      ->getNavigation('advancedarticles_home', array(), 'advancedarticles_page_'.$_action);	
  }    
}  