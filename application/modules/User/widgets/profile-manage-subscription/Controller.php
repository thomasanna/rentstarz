<?php

class User_Widget_ProfileManageSubscriptionController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {   
	  $subject                =  Engine_Api::_()->core()->getSubject();
	  $CardholderdetailsTable =  Engine_Api::_()->getDbtable('Cardholderdetails', 'user');
	  $CardholderdetailsData  =  $CardholderdetailsTable->fetchRow($CardholderdetailsTable->select()->where('userId = ?',  $subject->getIdentity()));
      $this->view->CardholderdetailsData  = $CardholderdetailsData;
  }
  
  
}
