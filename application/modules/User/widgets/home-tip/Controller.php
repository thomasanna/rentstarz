<?php
class User_Widget_HometipController extends Engine_Content_Widget_Abstract {

public function indexAction()  {


    $viewer = Engine_Api::_()->user()->getViewer();
    if ($viewer -> getIdentity()){  
    
     $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer); 
		 
			if( !empty($fieldsByAlias['profile_type']) )
			{
			  $optionId = $fieldsByAlias['profile_type']->getValue($viewer);
			  $profile_type_id = $optionId->value; 
			  $this->view->profile_type_id = $optionId->value; 
			  
			}
    }


	$tips_table =  Engine_Api::_()->getDbtable('tips', 'user');
	$tips_select = $tips_table->select();		    
	$tipData = $tips_table->fetchAll($tips_select);
	$this->view->tipData = $tipData;
	

		
	
	if($profile_type_id == 4){
		
			
		$propertyRequestTable =  Engine_Api::_()->getDbtable('propertyrequest', 'user');	
	    $propertyReq_select = $propertyRequestTable->select()
		                      ->setIntegrityCheck(false)
		                       ->from(array('prequest'=>'engine4_property_request',)) 
		                       ->where('prequest.landlord_approve = ?', 1)
		                       ->where('prequest.landlord_id = ?', $viewer -> getIdentity());
		$propertyReqData = $propertyRequestTable->fetchAll($propertyReq_select);
		$this->view->landlordapproveData = $propertyReqData;	
		//echo "landlord";
	}
	elseif($profile_type_id == 1)
	{
		
		
		$rentalApplicationsTable =  Engine_Api::_()->getDbtable('rentalapplications', 'user');	

    	$this->view->rentalApplicationsData = $rentalApplicationsData = $rentalApplicationsTable->fetchRow($rentalApplicationsTable->select()->where('tenant_id = ?', $viewer -> getIdentity()));   	  
	     
	     
	     
	    $propertyRequestTable =  Engine_Api::_()->getDbtable('propertyrequest', 'user');	
	 	$propertyReq_select = $propertyRequestTable->select()
		                       ->setIntegrityCheck(false)
		                       ->from(array('prequest'=>'engine4_property_request',)) 
		                       ->where('prequest.tenant_id = ?', $viewer -> getIdentity());					      					         
        
		$propertyRequestData = $propertyRequestTable->fetchAll($propertyReq_select);
		
		$this->view->propertyRequestData = $propertyRequestData;
	     

	     
		//echo "tenant";
	}
	

    if($viewer->tip_dismiss_time=='')
    {
	
	$this->view->tipemty=1;
	$this->view->tipblock=1;
    }
    else
    {
		$this->view->tipemty=0;
		
	    $tipdismisdatetime= $viewer->tip_dismiss_time;

		//date_default_timezone_set('Asia/Calcutta');
		date_default_timezone_set($viewer->timezone);
		$currentdatetime = date('H:i:s d-m-Y'); 

		$currentdatetime = DateTime::createFromFormat('H:i:s d-m-Y', $currentdatetime);
		
		
		$tipdismisdatetime = DateTime::createFromFormat('H:i:s d-m-Y', $tipdismisdatetime);

		$interval = $currentdatetime->diff($tipdismisdatetime);
	    $current_tipdismiss_difference = ($interval->days * 24) + $interval->h+ ($interval->i / 60) + ($interval->s / 3600);
	    
	    $common_settings_table =  Engine_Api::_()->getDbtable('commonsettings', 'user'); 
	    $common_settings = $common_settings_table->fetchRow($common_settings_table->select()->where('type =?', 'tip_duration'));
    

		if($current_tipdismiss_difference>=$common_settings->value)
		{ 
		$this->view->tipblock=1;
		}
		else
		{
			$this->view->tipblock=0;
		}
	}
	

		

}
}


?>
