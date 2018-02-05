<?php

class Advancedarticles_Widget_PostersBlockController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
    $perpage = $this->_getParam('perpage', 5);
	
	$data = Engine_Api::_()->advancedarticles()->getTopPosters($perpage);
	if (!is_object($data)) return $this->setNoRender();
		
    $paginator = Zend_Paginator::factory($data);
    $paginator->setItemCountPerPage($perpage);
    $paginator->setCurrentPageNumber(1);
	$this->view->paginator = $paginator;
	
	if (!$paginator->getTotalItemCount()) return $this->setNoRender();
  }    
}  