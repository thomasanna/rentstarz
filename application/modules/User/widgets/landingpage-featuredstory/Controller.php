<?php

class User_Widget_LandingpageFeaturedstoryController extends Engine_Content_Widget_Abstract {

public function indexAction()  {
	
     $settings = Engine_Api::_()->getApi('settings', 'core'); 
     
     if($settings->user_showLandingpageFeaturedstory  == 0){
		  return $this->setNoRender();		 
	 }
  } 
}


?>
