<?php

class User_Widget_GalleryNewController extends Engine_Content_Widget_Abstract {

public function indexAction()  {
	
	$subject = Engine_Api::_()->core()->getSubject('user');
	$viewer = Engine_Api::_()->user()->getViewer();
	
	
	
	$PhotogalleryTable = Engine_Api::_()->getDbtable('photogallery', 'user'); 
	
	$PhotogallerySelect = $PhotogalleryTable->select()
									->where('user_id = ?', $subject->getIdentity());
			  
			  
	$this->view->PhotogalleryData  = $PhotogalleryData = $PhotogalleryTable->fetchAll($PhotogallerySelect);
	
	$this->view->totalPhotogalleryData  = $totalPhotogalleryData = count($PhotogalleryData);
	
	$this->view->subjectId = $subject->getIdentity();
	$this->view->viewerId = $viewer->getIdentity();
	
	
 }
}

?>
