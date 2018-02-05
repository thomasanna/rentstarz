<?php

class User_Widget_AdvertisementController extends Engine_Content_Widget_Abstract {

public function indexAction()  {
	
$useragent   = $_SERVER['HTTP_USER_AGENT'];
$iPod        = stripos($_SERVER['HTTP_USER_AGENT'],"iPod");
$iPhone      = stripos($_SERVER['HTTP_USER_AGENT'],"iPhone");
$iPad        = stripos($_SERVER['HTTP_USER_AGENT'],"iPad");
$Android     = stripos($_SERVER['HTTP_USER_AGENT'],"Android");
$webOS       = stripos($_SERVER['HTTP_USER_AGENT'],"webOS");
if( $iPod || $iPhone || $iPad || $Android)	{ $dev_type= 1; } // mobile	
else{	$dev_type= 2;}   // system

if($dev_type == 1){
	 return $this->setNoRender();
}
	
	$viewer     = Engine_Api::_()->user()->getViewer();
	if( !empty($viewer) ) {

		$fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer); 
		if( !empty($fieldsByAlias['profile_type']) )
		{
				  $optionId = $fieldsByAlias['profile_type']->getValue($viewer);
				   $profile_type_id = $optionId->value; 
		}

		$userHelperObj = $this->view->getHelper('User');
		$memberPackage = $userHelperObj->getmemberpackage($viewer->getIdentity());
		$package_type  = $memberPackage ->package_type; 

		$settings = Engine_Api::_()->getApi('settings', 'core');
		$user_premiumLevelProvision = $settings->user_premiumLevelProvision;

		/*if($user_premiumLevelProvision == 1 &&  $profile_type_id==4){
			 return $this->setNoRender();
		}*/
		if($package_type!='' && $user_premiumLevelProvision == 2):  
		 return $this->setNoRender();
		endif; 
   }

	$Advertisement_table =  Engine_Api::_()->getDbtable('advertisement', 'user'); 
	$AdvertisementSelect = $Advertisement_table->select()
													   ->order('id DESC');                                                                 
	$AdvertisementData   = $Advertisement_table->fetchAll($AdvertisementSelect);
	if(count($AdvertisementData) == 0){
		return $this->setNoRender();
	}

	$resultData                = array();
	$i = 0;
	foreach($AdvertisementData as $data):
	 
	 $today       = date('Y-m-d');	
	 $today_date  = strtotime($today) ;
	 $date_from   = strtotime($data['date_from']);
	 $date_to     = strtotime($data['date_to']);   
	 
	   if($today_date >= $date_from && $today_date <= $date_to):
			$i++;
			$tmpArray['id']                 =  $data['id'];
			$tmpArray['date_from']          =  $data['date_from'];
			$tmpArray['date_to']            =  $data['date_to'];
			$tmpArray['title']              =  $data['title'];
			$tmpArray['image']              =  $data['image'];
			$tmpArray['ad_url']             =  $data['ad_url'];
			$finaltmpArray[] = $tmpArray;
			
	   endif;
	   if($i >= 5):  break;	 endif;	
	endforeach;
			
	$this->view->AdvertisementData =  $AdvertisementData = array_merge($resultData,$finaltmpArray); 
		if(count($AdvertisementData) == 0){
			return $this->setNoRender();
		}
     
 }
}

?>
