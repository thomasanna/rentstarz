<?php

class Advancedarticles_Widget_ProfileBlockController extends Engine_Content_Widget_Abstract
{
  private $_Count;  
  public function indexAction()
  {
    // Don't render this if not authorized
    $viewer = Engine_Api::_()->user()->getViewer();
    if( !Engine_Api::_()->core()->hasSubject() ) {
      return $this->setNoRender();
    }
          
    $this->view->subject = $subject = Engine_Api::_()->core()->getSubject('user');
    if( !$subject->authorization()->isAllowed($viewer, 'view') ) {
      return $this->setNoRender();
    }
    $perpage = $this->_getParam('perpage', 10);
	
	$articles = Engine_Api::_()->advancedarticles()->getArticles(0, 'advancedarticles', array('created_date'), array('owner' => $subject->getIdentity()));
	if (!is_object($articles)) return $this->setNoRender();
	
    $paginator = Zend_Paginator::factory($articles);
    $paginator->setItemCountPerPage($perpage);
    $paginator->setCurrentPageNumber(1);
	$this->view->paginator = $paginator;
	$this->_Count = $paginator->getTotalItemCount();
	
	$auth = new Authorization_Controller_Action_Helper_RequireAuth();
	$this->view->art_create = $auth->setAuthParams('artarticle', null, 'create')->checkRequire();		
  }    
  
  public function getChildCount() {
    return $this->_Count;
  }	
}  