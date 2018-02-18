<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Activity
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Controller.php 9806 2012-10-30 23:54:12Z matthew $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Activity
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Activity_Widget_FeedController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
    // Don't render this if not authorized
    $viewer = Engine_Api::_()->user()->getViewer();
    date_default_timezone_set('EST');
    if ($viewer -> getIdentity()){
       $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
            if( !empty($fieldsByAlias['profile_type']) )
            {
              $optionId        = $fieldsByAlias['profile_type']->getValue($viewer);
              $profile_type_id = $optionId->value;
            }
            if( Engine_Api::_()->core()->hasSubject() ) {
                $subject       = Engine_Api::_()->core()->getSubject();
                $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($subject);

                if( !empty($fieldsByAlias['profile_type']) )
                {
                  $optionId        = $fieldsByAlias['profile_type']->getValue($subject);
                  $profile_type_id = $optionId->value;
                }
            }
    }
    $subject = null;
    if( Engine_Api::_()->core()->hasSubject() ) {
      // Get subject
      $subject = Engine_Api::_()->core()->getSubject();
      if( !$subject->authorization()->isAllowed($viewer, 'view') ) {
        return $this->setNoRender();
      }
    }
    if(isset($_SESSION['location_mode_array'])){
     $location_mode_array = $_SESSION['location_mode_array'];
         if($location_mode_array['set_to_usa'] != '' ){
            $propertycountryTable       =  Engine_Api::_()->getDbtable('propertycountry', 'user');
            $locationSelect             =  $propertycountryTable->select()
                                            ->setIntegrityCheck(false)
                                            ->from(array('country'=>'engine4_property_countries'))
                                            ->where('country.prty_country = ?', 'United States');
            $locationData               =  $propertycountryTable->fetchRow($locationSelect);
            $this->view->locationData   = $locationData;
            $country_id                 = $this->view->country_id = $locationData->country_id;
            $location_text              = 'United States';
         }
     }
    else{
            if($viewer->prefered_location != '' ){
                    if($viewer->prefered_location == 'United States'){
                        $propertycountryTable       =  Engine_Api::_()->getDbtable('propertycountry', 'user');
                        $locationSelect             =   $propertycountryTable->select()
                                                        ->setIntegrityCheck(false)
                                                        ->from(array('country'=>'engine4_property_countries'))
                                                        ->where('country.prty_country = ?', 'United States');
                        $locationData               =  $propertycountryTable->fetchRow($locationSelect);
                        $this->view->locationData   = $locationData;
                    $country_id                     = $this->view->country_id =$locationData->country_id;
                    $location_text                  = 'United States';
                    }
                    else{
                        $location   = explode(",",$viewer->prefered_location);
                        $country_id = $location[0];
                        $state_id   = $location[1];
                        $city_id    = $location[2];

                        $propertycityable       =  Engine_Api::_()->getDbtable('propertycity', 'user');
                        $locationSelect   =   $propertycityable->select()
                                        ->setIntegrityCheck(false)
                                        ->from(array('city'=>'engine4_property_city'))
                                        ->joinLeft(array('country'=>'engine4_property_countries'),'city.country_id=country.country_id',array('prty_country'))
                                        ->joinLeft(array('state'=>'engine4_property_states'),'city.state_id=state.state_id',array('prty_state'))
                                        ->where('city.city_id = ?', $location[2]);

                        $locationData=$propertycityable->fetchRow($locationSelect);

                        $this->view->locationData = $locationData;

                        $country_id = $this->view->country_id = $locationData->country_id;
                        $state_id   = $this->view->state_id = $locationData->state_id;
                        $city_id    = $this->view->city_id = $locationData->city_id;
                        $county=$viewer->prefered_county;
                        $neighborhood=$viewer->prefered_neighborhood;
                        $location_text = $locationData->prty_city;
                    }
            }
   }
    if ($viewer -> getIdentity()){
          $viewer               = Engine_Api::_()->user()->getViewer();
          $propertyGrantedTable =  Engine_Api::_()->getDbtable('propertygranted', 'user');
          $fieldsByAlias        = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
            if( !empty($fieldsByAlias['profile_type']) )
            {
              $optionId        = $fieldsByAlias['profile_type']->getValue($viewer);
              $profile_type_id = $optionId->value;
            }
        if($profile_type_id  == 4 || $profile_type_id  == 1){
        if($profile_type_id == 4){ // landlord
                $propertyGranted_select = $propertyGrantedTable->select()
                                      ->setIntegrityCheck(false)
                                       ->from(array('pgranted'=>'engine4_property_granted',))
                                       ->joinLeft(array('plist'=>'engine4_property_list',),'plist.id=pgranted.property_id',array('property_name','rental_type','housing_type'))
                                       ->joinLeft(array('user'=>'engine4_users',),'pgranted.tenant_id=user.user_id',array('displayname'))
                                       ->joinLeft(array('rate'=>'engine4_rating_value',),'pgranted.tenant_id=rate.subject_id',array('rated_date','next_rating_date'))
                                        ->joinLeft(array('ratelog'=>'engine4_rating_log',),'plist.id=ratelog.property_id AND pgranted.landlord_id=ratelog.subject_id',array())
                                       ->where('pgranted.landlord_id = ?', $viewer -> getIdentity())
                                       ->where('pgranted.status = ?', 1)
                                       ->where('ratelog.next_rating_date = ?', date('Y-m-d'))
                                        ->group('pgranted.property_id');

                $propertyRequestTable =  Engine_Api::_()->getDbtable('propertyrequest', 'user');
                $propertyReq_select   = $propertyRequestTable->select()
                                      ->setIntegrityCheck(false)
                                       ->from(array('prequest'=>'engine4_property_request',))
                                       ->where('prequest.landlord_approve = ?', 1)
                                       ->where('prequest.landlord_id = ?', $viewer -> getIdentity());
                $propertyReqData                 = $propertyRequestTable->fetchAll($propertyReq_select);
                $this->view->landlordapproveData = $propertyReqData;
         }
        if($profile_type_id == 1)   { // tenant

        $propertyGranted_select = $propertyGrantedTable->select()
                               ->setIntegrityCheck(false)
                               ->from(array('pgranted'=>'engine4_property_granted',))
                               ->joinLeft(array('plist'=>'engine4_property_list',),'plist.id=pgranted.property_id',array('property_name','rental_type','housing_type'))
                               ->joinLeft(array('user'=>'engine4_users',),'pgranted.landlord_id=user.user_id',array('displayname'))
                               ->joinLeft(array('rate'=>'engine4_rating_value',),'pgranted.landlord_id=rate.subject_id',array('rated_date','next_rating_date'))
                               ->joinLeft(array('ratelog'=>'engine4_rating_log',),'plist.id=ratelog.property_id AND pgranted.tenant_id=ratelog.subject_id',array())
                               ->where('pgranted.tenant_id = ?', $viewer -> getIdentity())
                               ->where('pgranted.status = ?', 1)
                               ->where('ratelog.next_rating_date = ?', date('Y-m-d'))
                               ->group('pgranted.property_id');

        $rentalApplicationsTable            =  Engine_Api::_()->getDbtable('rentalapplications', 'user');
        $this->view->rentalApplicationsData = $rentalApplicationsData = $rentalApplicationsTable->fetchRow($rentalApplicationsTable->select()->where('tenant_id = ?', $viewer -> getIdentity()));

        $propertyRequestTable =  Engine_Api::_()->getDbtable('propertyrequest', 'user');
        $propertyReq_select   = $propertyRequestTable->select()
                              ->setIntegrityCheck(false)
                               ->from(array('prequest'=>'engine4_property_request',))
                               ->where('prequest.landlord_approve = ?', 1)
                               ->where('prequest.tenant_id = ?', $viewer -> getIdentity());
        $propertyReqData                 = $propertyRequestTable->fetchAll($propertyReq_select);
        $this->view->propertyRequestData = $propertyReqData;
        }
        $propertyGrantedDAta             = $propertyGrantedTable->fetchAll($propertyGranted_select);
        if(count($propertyGrantedDAta)>0){
            $this->view->is_rating_option = 1;
        }
        else{
            $this->view->is_rating_option = 0;
        }
        $tips_table =  Engine_Api::_()->getDbtable('tips', 'user');
        $tips_select = $tips_table->select();
        $tipData = $tips_table->fetchAll($tips_select);
        $this->view->tipData = $tipData;

        }
            $this->view->profile_type =$profile_type_id;
        }
    $current_url                         = explode("?", $_SERVER['REQUEST_URI']);
    $this->view->page_url                = $page_url = $current_url[0] ;
    //tip_duration
    $common_settings_table               = Engine_Api::_()->getDbtable('commonsettings', 'user');
    $common_settings                     = $common_settings_table->fetchRow($common_settings_table->select()->where('type =?', 'tip_duration'));
    $this->view->tip_duration_time       = $common_settings->value;
    $datetimearray                       = explode(' ', $viewer->tip_dismiss_time);
    $this->view->tip_dismiss_time        = $datetimearray['0'];
    $this->view->tip_dismiss_date        = $datetimearray['1'];
    // feed preference unit
    $FeedPreferenceUnitTable             = Engine_Api::_()->getDbtable('Feedpreferenceunit', 'user');
    $FeedPreferenceUnitDataSelect        = $FeedPreferenceUnitTable->select()
                                    ->where('userid = ?', $viewer -> getIdentity());
    $this->view->FeedPreferenceUnitData  =    $FeedPreferenceUnitData = $FeedPreferenceUnitTable->fetchAll($FeedPreferenceUnitDataSelect);


  // member type
    $viewer               = Engine_Api::_()->user()->getViewer();
    $fieldsByAlias        = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
    if( !empty($fieldsByAlias['profile_type']) )
    {
      $optionId                = $fieldsByAlias['profile_type']->getValue($viewer);
      $this->view->profiletype = $profile_type_id = $optionId->value;
      $viewerProfileType       = $profile_type_id;
    }
    if( Engine_Api::_()->core()->hasSubject() ) {
      // Get subject
        $subject           = Engine_Api::_()->core()->getSubject();
        $fieldsByAlias     = Engine_Api::_()->fields()->getFieldsObjectsByAlias($subject);
        if( !empty($fieldsByAlias['profile_type']) )
        {
          $optionId           = $fieldsByAlias['profile_type']->getValue($subject);
          $subjectProfileType = $optionId->value;
        }
    }
            if(empty(Engine_Api::_()->core()->hasSubject())){ //  home feed
                if($viewerProfileType == 4 ){  $checkhomefeedtype = 'landlordfeed';} //check  landlord
                elseif($viewerProfileType == 1 ){  $checkhomefeedtype = 'tenantfeed';}//check  tenant
                else{$checkhomefeedtype = 'servicefeed';}
            }
            else{  $checkhomefeedtype = '';}

            if(Engine_Api::_()->core()->hasSubject()){  //  profile feed
                if($subjectProfileType ==4){  $checkprofilefeedtype   =  'landlordfeed'; }//check  landlord
                elseif($subjectProfileType == 1){  $checkprofilefeedtype   = 'tenantfeed';}// tenant
                else{ $checkprofilefeedtype   =  'servicefeed';}
            }
            else{   $checkprofilefeedtype = '';}

if($checkhomefeedtype == 'tenantfeed' || $checkprofilefeedtype == 'landlordfeed'){
	
	$userTable = Engine_Api::_()->getDbtable('users', 'user');
	$propertyTable =  Engine_Api::_()->getDbtable('propertylist', 'user');
	if(!empty($this->view->subject())){  // profile
		
		 $propertySelect   =   $propertyTable->select()
                                ->setIntegrityCheck(false)
                                ->from(array('plist'=>'engine4_property_list',))
                                ->joinLeft(array('pcountry'=>'engine4_property_countries',),'plist.prty_country_id=pcountry.country_id',array('prty_country'))
                                ->joinLeft(array('pstate'=>'engine4_property_states',),'plist.prty_state_id=pstate.state_id',array('prty_state'))
                                ->joinLeft(array('pcity'=>'engine4_property_city',),'plist.prty_city_id=pcity.city_id',array('prty_city','latitude','longitude'))
                                ->where('plist.enable = ?', 1)
                                ->where('plist.landlord_enable=?' ,  1)
                                ->where('plist.property_type !=?' ,  'holding_property')
                                ->order('plist.created_at DESC');
		
		
	}else{ // home
                $propertySelect   =   $propertyTable->select()
                                ->setIntegrityCheck(false)
                                ->from(array('plist'=>'engine4_property_list',))
                                ->joinLeft(array('pcountry'=>'engine4_property_countries',),'plist.prty_country_id=pcountry.country_id',array('prty_country'))
                                ->joinLeft(array('pstate'=>'engine4_property_states',),'plist.prty_state_id=pstate.state_id',array('prty_state'))
                                ->joinLeft(array('pcity'=>'engine4_property_city',),'plist.prty_city_id=pcity.city_id',array('prty_city','latitude','longitude'))
                                ->where('plist.enable = ?', 1)
                                ->where('plist.landlord_enable=?' ,  1)
                                ->where('plist.property_type !=?' ,  'holding_property')
                                ->order('plist.created_at DESC');

                                   
                if(isset($_SESSION['matching_array'])){
                   //print_r($_SESSION['matching_array']);exit;
                    $this->view->filtermode = 'preference_mode';

                    $matching_array = $_SESSION['matching_array'];

                    if(!empty($matching_array)){

                        if(!empty($matching_array['housing_types'])){

                            $propertySelect->where('plist.housing_type  IN(?)' , $matching_array['housing_types']);

                        }
                        if( isset($matching_array['is_petsallowd']) && !empty($matching_array['is_petsallowd']) ) {

                            $propertySelect->where('plist.has_pets   =?' , $matching_array['is_petsallowd']);

                        }
                        if( isset($matching_array['pets_type']) && !empty($matching_array['pets_type']) ) {

                            $propertySelect->where('plist.pets_type  =?' , $matching_array['pets_type']);

                        }
                        if( isset($matching_array['no_of_bedrooms']) && !empty($matching_array['no_of_bedrooms']) ) {

                            $propertySelect->where('plist.no_of_rooms    =?' , $matching_array['no_of_bedrooms']);

                        }
                       // if( isset($matching_array['price_from']) && isset($matching_array['price_to']) && !empty($matching_array['price_to']) ) 
                        if( isset($matching_array['price_from'])) 
                        {
							$price_from = (int)$matching_array['price_from'];
						    $price_to   = (int)$matching_array['price_to'];
						    if($matching_array['price_from'] !='0' && $matching_array['price_to'] == '0'){
								$propertySelect->where('plist.price =?' , $price_from);
							}
							if($matching_array['price_from'] !='0' && $matching_array['price_to'] != '0'){
								$propertySelect->where('plist.price >=?' , $price_from);
                                $propertySelect->where('plist.price <=?' , $price_to);	
							}
													
     					}
                  
                        if( isset($matching_array['countryName']) && !empty($matching_array['countryName'])) {
                           $propertySelect->where('pcountry.prty_country      =?' ,  $matching_array['countryName']);
                        }
                        if( isset($matching_array['stateName']) && !empty($matching_array['stateName']) ) {
                            $propertySelect->where('pstate.prty_state      =?' ,  $matching_array['stateName']);
                        }
                        if(isset($matching_array['cityName']) && !empty($matching_array['cityName'])  ) {
                            $propertySelect->where('pcity.prty_city      =?' ,  $matching_array['cityName']);
                        }
                        if(isset($matching_array['countyName']) && !empty($matching_array['countyName'])  ) {
                            $propertySelect->where('plist.prty_county      =?' ,  $matching_array['countyName']);
                                            
                        }
                        if( isset($matching_array['neighborhoodName']) && !empty($matching_array['neighborhoodName']) ) {
                                         $propertySelect->where('plist.prty_neighborhood      =?' ,  $matching_array['neighborhoodName']);
                                            
                                        }
                        
                        if( isset($matching_array['zip']) && !empty($matching_array['zip']) ) {
							
							$propertySelect->where('plist.zip      =?' ,  $matching_array['zip']);
                        }
                    }
                }
                else{

                if(isset($_SESSION['location_mode_array'])){//print_r($_SESSION['location_mode_array']); exit("ii");

                $location_mode_array = $_SESSION['location_mode_array']; //print_r($location_mode_array); exit;
                $this->view->filtermode = 'location_mode';
                  
                        if( isset($location_mode_array['set_to_usa']) && !empty($location_mode_array['set_to_usa']) ) {
                                        $propertySelect->where('plist.prty_country_id      =?' ,  $country_id);
                        }
                        else{

                            if( isset($location_mode_array['zipcode']) && !empty($location_mode_array['zipcode']) ) {
                                            $propertySelect->where('plist.zip      =?' ,  $location_mode_array['zipcode']);
                                        }

                           if( isset($location_mode_array['neighborhood_name']) && !empty($location_mode_array['neighborhood_name']) ) {
                                       $propertySelect->where('plist.prty_neighborhood      =?' ,  $location_mode_array['neighborhood_name']);
                                            
                                        }
                            if( isset($location_mode_array['county_name']) && !empty($location_mode_array['county_name']) ) {
                                       $propertySelect->where('plist.prty_county      =?' ,  $location_mode_array['county_name']);
                                          
                                        } 
							

                            if( isset($location_mode_array['city_name']) && !empty($location_mode_array['city_name']) ) {
                                                $propertySelect->where('pcity.prty_city      =?' ,  $location_mode_array['city_name']);
                                        }

                            if( isset($location_mode_array['state_name']) && !empty($location_mode_array['state_name']) ) {
                                             $propertySelect->where('pstate.prty_state      =?' ,  $location_mode_array['state_name']);
                                        }

                             }
                             
                            if( isset($location_mode_array['country_name']) && !empty($location_mode_array['country_name'])) {
								   $propertySelect->where('pcountry.prty_country      =?' ,  $location_mode_array['country_name']);                      
                            }

                        if( isset($location_mode_array['pets_type']) && !empty($location_mode_array['pets_type']) ) {
                        $propertySelect->where('plist.pets_type  =?' , $location_mode_array['pets_type']);
                        }
                         if( isset($location_mode_array['price_from']) &&  isset($location_mode_array['price_to'])  && !empty($location_mode_array['price_to'])) 
                        {
						$price_from = (int)$location_mode_array['price_from'];
						$price_to   = (int)$location_mode_array['price_to'];
					    $propertySelect->where('plist.price >=?' , $price_from);
                        $propertySelect->where('plist.price <=?' , $price_to);						
     					}

                            if( isset($location_mode_array['no_of_bedrooms']) && !empty($location_mode_array['no_of_bedrooms']) ) {
                            $propertySelect->where('plist.no_of_rooms =?' , $location_mode_array['no_of_bedrooms']);
                            }
 //echo $propertySelect; exit;
                    }
                    else{
                        if($viewer->prefered_location != ''){
                                    if($viewer->prefered_location != 'United States' ) {
									
                                    $propertySelect->where('plist.prty_city_id      =?' ,  $city_id);
                                    
                                    if($viewer->prefered_county != '' ) {
									
                                         $propertySelect->where('plist.prty_county      =?' ,  $county);
                                    }
                                    if($viewer->prefered_neighborhood != '' ) {
									
                                         $propertySelect->where('plist.prty_neighborhood      =?' ,   $neighborhood);
                                    }
                                    if($viewer->prefered_zipcode != '' ) {
									
                                         $propertySelect->where('plist.zip      =?' ,   $viewer->prefered_zipcode);
                                    }
                                    }

                                    else{
                                        $propertySelect->where('plist.prty_country_id      =?' ,  $country_id);
                                    }
                         }

                        else{
                            $propertySelect   =   $propertyTable->select()
                                ->setIntegrityCheck(false)
                                ->from(array('plist'=>'engine4_property_list',))
                                ->joinLeft(array('pcountry'=>'engine4_property_countries',),'plist.prty_country_id=pcountry.country_id',array('prty_country'))
                                ->joinLeft(array('pstate'=>'engine4_property_states',),'plist.prty_state_id=pstate.state_id',array('prty_state'))
                                ->joinLeft(array('pcity'=>'engine4_property_city',),'plist.prty_city_id=pcity.city_id',array('prty_city','latitude','longitude'))
                                ->where('plist.enable = ?', 1)
                                ->where('plist.landlord_enable=?' ,  1)
                                ->where('plist.property_type !=?' ,  'holding_property')
                                ->order('plist.created_at DESC');

                                    
                      }
                   }
                }
            }
       //  echo $propertySelect; exit;
	$propertyListData = $propertyTable->fetchAll($propertySelect);
	$this->view->propertyListData = $propertyListData;
    
 // print_r($propertyListData); exit;
	
}

       // if($profile_type_id == 4){ // landlord

        if($checkhomefeedtype == 'landlordfeed' || $checkprofilefeedtype == 'tenantfeed'){

        $userTable = Engine_Api::_()->getDbtable('users', 'user');
        $propertyRequirementTable =  Engine_Api::_()->getDbtable('propertyrequirement', 'user');

        if(!empty($this->view->subject())){  // profile
        $subject = Engine_Api::_()->core()->getSubject();
        $subjectId = $subject->getIdentity();
        

        
        
       $propertyRequirementSelect   =   $propertyRequirementTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('property_req'=>'engine4_property_requirement',))
                        ->joinLeft(array('pcountry'=>'engine4_property_countries',),'property_req.country_id=pcountry.country_id',array('prty_country'))
                        ->joinLeft(array('pstate'=>'engine4_property_states',),'property_req.state_id=pstate.state_id',array('prty_state'))
                        ->joinLeft(array('pcity'=>'engine4_property_city',),'property_req.city_id=pcity.city_id',array('prty_city','latitude','longitude'))
                        ->where('property_req.tenant_id =?' , $subjectId)
                        ->order('property_req.created_at DESC');
        }
        else{
                $propertyRequirementSelect   =   $propertyRequirementTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('property_req'=>'engine4_property_requirement',))
                        ->joinLeft(array('pcountry'=>'engine4_property_countries',),'property_req.country_id=pcountry.country_id',array('prty_country'))
                        ->joinLeft(array('pstate'=>'engine4_property_states',),'property_req.state_id=pstate.state_id',array('prty_state'))
                        ->joinLeft(array('pcity'=>'engine4_property_city',),'property_req.city_id=pcity.city_id',array('prty_city','latitude','longitude'))
                        ->where('property_req.housing_type !=?' , '')
                        ->order('property_req.created_at DESC');
        if(isset($_SESSION['matching_array'])){
               // print_r($_SESSION['matching_array']); exit;
                    $matching_array = $_SESSION['matching_array'];
                        if(!empty($matching_array)){
                            $this->view->filtermode = 'preference_mode';

                            if(!empty($matching_array['housing_types'])){
                            $propertyRequirementSelect->where('property_req.housing_type  IN(?)' , $matching_array['housing_types']);
                            }
                            if( isset($matching_array['is_petsallowd']) && !empty($matching_array['is_petsallowd']) ) {
                            $propertyRequirementSelect->where('property_req.pets_allowed    =?' , $matching_array['is_petsallowd']);
                            }
                            if( isset($matching_array['pets_type']) && !empty($matching_array['pets_type']) ) {
                            $propertyRequirementSelect->where('property_req.pets_type   =?' , $matching_array['pets_type']);
                            }
                            if( isset($matching_array['no_of_bedrooms']) && !empty($matching_array['no_of_bedrooms']) ) {
                            $propertyRequirementSelect->where('property_req.no_of_rooms =?' , $matching_array['no_of_bedrooms']);
                            }
                       // if( isset($matching_array['price_from']) && isset($matching_array['price_to'])  && !empty($matching_array['price_to'])) 
                        if( isset($matching_array['price_from'])) 
                        {
                            $price_from = (int)$matching_array['price_from'];
							$price_to   = (int)$matching_array['price_to'];
							if($matching_array['price_from'] != '0' && $matching_array['price_to'] =='0'){
								/*$propertyRequirementSelect->where('property_req.budget <=?' , $price_from);
								$propertyRequirementSelect->where('(property_req.budget_range_to >=?' , $price_from);
								$propertyRequirementSelect->orWhere('property_req.budget =?)' , $price_from);*/
								
								$propertyRequirementSelect->Where('(property_req.budget =?' , $price_from);
								
								$propertyRequirementSelect->orWhere('(property_req.budget <=?' , $price_from);
								$propertyRequirementSelect->Where('property_req.budget_range_to >=?))' , $price_from);
								
							}
							if($matching_array['price_from'] != '0' && $matching_array['price_to'] !='0'){
								/*$propertyRequirementSelect->where('property_req.budget >=?' , $price_from);
								$propertyRequirementSelect->where('property_req.budget <=?' , $price_to);
								$propertyRequirementSelect->where('property_req.budget_range_to <=?' , $price_to);	
								$propertyRequirementSelect->orWhere('(property_req.budget >=?' , $price_from);
								$propertyRequirementSelect->where('property_req.budget <=?)' , $price_to);	*/
								$propertyRequirementSelect->where('((property_req.budget >=?' , $price_from);
								$propertyRequirementSelect->where('property_req.budget <=?)' , $price_to);
								
								$propertyRequirementSelect->orWhere('(property_req.budget <=?' , $price_from);
								$propertyRequirementSelect->Where('(property_req.budget_range_to >=?' , $price_from);
								$propertyRequirementSelect->Where('property_req.budget_range_to <=?))' , $price_to);
								
								$propertyRequirementSelect->orWhere('(property_req.budget_range_to >=?' , $price_to);
								$propertyRequirementSelect->Where('(property_req.budget >=?' , $price_from);
								$propertyRequirementSelect->Where('property_req.budget <=?))' , $price_to);
									
								$propertyRequirementSelect->orWhere('(property_req.budget <=?' , $price_from);
								$propertyRequirementSelect->where('property_req.budget_range_to >=?))' , $price_to);
								
						   }
							
     					}

                            if(isset($matching_array['countryName']) && !empty($matching_array['countryName'])) {
                                 $propertyRequirementSelect->where('pcountry.prty_country      =?' ,  $matching_array['countryName']);
                            }
                            if( isset($matching_array['stateName']) && !empty($matching_array['stateName'])) {
                                $propertyRequirementSelect->where('pstate.prty_state      =?' ,  $matching_array['stateName']);
                           }
                            if( isset($matching_array['cityName']) && !empty($matching_array['cityName']) ) {
                               $propertyRequirementSelect->where('pcity.prty_city      =?' ,  $matching_array['cityName']);
                              }
                            if( isset($matching_array['neighborhoodName']) && !empty($matching_array['neighborhoodName']) ) {
                                         $propertyRequirementSelect->where('property_req.neighborhood      =?' ,  $matching_array['neighborhoodName']);
                                            
                            }
    
					        if( isset($matching_array['countyName']) && !empty($matching_array['countyName']) ) {
                                         $propertyRequirementSelect->where('property_req.county      =?' ,  $matching_array['countyName']);
                                            
                            }
                            if( isset($matching_array['zip']) && !empty($matching_array['zip']) ) {
								
								$propertyRequirementSelect->where('property_req.zip      =?' ,  $matching_array['zip']);
                            }
                        }
        }
        else{
            if(isset($_SESSION['location_mode_array'])){
				//  print_r($_SESSION['location_mode_array']); exit;
                $location_mode_array = $_SESSION['location_mode_array'];
                $this->view->filtermode = 'location_mode';

                if( isset($location_mode_array['set_to_usa']) && !empty($location_mode_array['set_to_usa']) ) {
                        $propertyRequirementSelect->where('property_req.country_id      =?' ,  $country_id);
                   }
                else{

                    if( isset($location_mode_array['zipcode']) && !empty($location_mode_array['zipcode']) ) {
                           $propertyRequirementSelect->where('property_req.zip      =?' ,  $location_mode_array['zipcode']);
                                }

                   if( isset($location_mode_array['neighborhood_name']) && !empty($location_mode_array['neighborhood_name']) ) {
                           $propertyRequirementSelect->where('property_req.neighborhood      =?' ,  $location_mode_array['neighborhood_name']);
                                            
                                        }
    
					if( isset($location_mode_array['county_name']) && !empty($location_mode_array['county_name']) ) {
                           $propertyRequirementSelect->where('property_req.county      =?' ,  $location_mode_array['county_name']);
                                            
                                        }

                    if( isset($location_mode_array['city_name']) && !empty($location_mode_array['city_name']) ) {
                          $propertyRequirementSelect->where('pcity.prty_city      =?' ,  $location_mode_array['city_name']);
                            }

                    if( isset($location_mode_array['state_name']) && !empty($location_mode_array['state_name']) ) {
                          $propertyRequirementSelect->where('pstate.prty_state      =?' ,  $location_mode_array['state_name']);
                                }

                    if( isset($location_mode_array['country_name']) && !empty($location_mode_array['country_name']) ) {
                          $propertyRequirementSelect->where('pcountry.prty_country      =?' ,  $location_mode_array['country_name']);
                              }
                }


                if( isset($location_mode_array['pets_type']) && !empty($location_mode_array['pets_type']) ) {
                    $propertyRequirementSelect->where('property_req.pets_type   =?' , $location_mode_array['pets_type']);
                }
                 if( isset($location_mode_array['price_from']) && isset($location_mode_array['price_to']) && !empty($location_mode_array['price_to']) ) 
                        { //exit;
							$price_from = (int)$location_mode_array['price_from'];
							$price_to   = (int)$location_mode_array['price_to'];
					//  $propertyRequirementSelect->where('property_req.budget >=?' , $price_from);
                    //  $propertyRequirementSelect->where('property_req.budget <=?' , $price_to);	
                      
                      
                      
                                $propertyRequirementSelect->where('((property_req.budget >=?' , $price_from);
								$propertyRequirementSelect->where('property_req.budget <=?)' , $price_to);
								
								$propertyRequirementSelect->orWhere('(property_req.budget <=?' , $price_from);
								$propertyRequirementSelect->Where('(property_req.budget_range_to >=?' , $price_from);
								$propertyRequirementSelect->Where('property_req.budget_range_to <=?))' , $price_to);
								
								$propertyRequirementSelect->orWhere('(property_req.budget_range_to >=?' , $price_to);
								$propertyRequirementSelect->Where('(property_req.budget >=?' , $price_from);
								$propertyRequirementSelect->Where('property_req.budget <=?))' , $price_to);
									
								$propertyRequirementSelect->orWhere('(property_req.budget <=?' , $price_from);
								$propertyRequirementSelect->where('property_req.budget_range_to >=?))' , $price_to);
                      					
     				}

                            if( isset($location_mode_array['no_of_bedrooms']) && !empty($location_mode_array['no_of_bedrooms']) ) {

                            $propertyRequirementSelect->where('property_req.no_of_rooms =?' , $location_mode_array['no_of_bedrooms']);

                            }
            }
           else{
                if($viewer->prefered_location != ''){
                    if($viewer->prefered_location != 'United States' ) { 
                          $propertyRequirementSelect->where('property_req.city_id      =?' ,  $city_id);
                          if($viewer->prefered_county != '' ) {
									
                                         $propertyRequirementSelect->where('property_req.county      =?' ,  $county);
                                    }
                          if($viewer->prefered_neighborhood != '' ) {
									
                                         $propertyRequirementSelect->where('property_req.neighborhood      =?' ,   $neighborhood);
                                    }
                          if($viewer->prefered_zipcode != '' ) {
									
                                         $propertyRequirementSelect->where('property_req.zip      =?' ,   $viewer->prefered_zipcode);
                                    }
                    }
                    else{
                        $propertyRequirementSelect->where('property_req.country_id      =?' ,  $country_id);
                    }
                }

                else{
                     $propertyRequirementSelect   =   $propertyRequirementTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('property_req'=>'engine4_property_requirement',))
                        ->joinLeft(array('pcountry'=>'engine4_property_countries',),'property_req.country_id=pcountry.country_id',array('prty_country'))
                        ->joinLeft(array('pstate'=>'engine4_property_states',),'property_req.state_id=pstate.state_id',array('prty_state'))
                        ->joinLeft(array('pcity'=>'engine4_property_city',),'property_req.city_id=pcity.city_id',array('prty_city','latitude','longitude'))
                        ->where('property_req.housing_type !=?' , '')
                        ->order('property_req.created_at DESC');

                    }

                }

            }

        }

//echo $propertyRequirementSelect ; exit;

$propertyReqData = $propertyRequirementTable->fetchAll($propertyRequirementSelect);
$smartmoveapiRenters_table =  Engine_Api::_()->getDbtable('Smartmoveapirenters', 'user');
$likeuserTable      =  Engine_Api::_()->getDbtable('likeuser', 'user');
    $resultData                = array();
 foreach($propertyReqData as $data):
 
     $this->view->smartmoveapiRentersData = $smartmoveapiRenters = $smartmoveapiRenters_table->fetchRow($smartmoveapiRenters_table->select()->where('tenant_id = ?', $data['tenant_id']));
    if(!empty($smartmoveapiRenters)){
            $isSmartmoveRenter = 1;
    }
    else{
            $isSmartmoveRenter = 0;
    }
    $likeuserDataSelect = $likeuserTable->select()
                    ->where('subject_id = ?', $viewer -> getIdentity())
                    ->where('object_id = ?',   $data['tenant_id']);
    $likeuserData      = $likeuserTable->fetchRow($likeuserDataSelect);
    if(count($likeuserData) == 0){
        $is_like = 0;
    }
    else{
        $is_like = 1;
    }
    $tmpArray['reqId']                 =  $data['id'];
    $tmpArray['userId']                =  $data['tenant_id'];
    $tmpArray['created_at']            =  $data['created_at'];
    $tmpArray['prty_country']          =  'USA';
    $tmpArray['prty_state']            =  $data['prty_state'];
    $tmpArray['prty_city']             =  $data['prty_city'];
    $tmpArray['prty_county']           =  $data['county'];
    $tmpArray['prty_neighborhood']     =  $data['neighborhood'];
    $tmpArray['latitude']              =  $data['latitude'];
    $tmpArray['longitude']             =  $data['longitude'];
    $tmpArray['description']           =  $data['description'];
    $tmpArray['isSmartmoveRenter']     =  $isSmartmoveRenter;
    $tmpArray['vouchers']              =  $data['vouchers'];
    $tmpArray['budget']                =  $data['budget'];
    $tmpArray['budget_range_to']       =  $data['budget_range_to'];
    $tmpArray['no_of_rooms']           =  $data['no_of_rooms'];
    $tmpArray['housing_type']          =  $data['housing_type'];
    $tmpArray['parking']               =  $data['provide_parking'];
    $tmpArray['wheelchair']            =  $data['wheelchair_accessible'];
    $tmpArray['pets_allowed']          =  $data['pets_allowed'];
    $tmpArray['pets_type']             =  $data['pets_type'];
    $tmpArray['is_like']               =  $is_like;
    $finaltmpArray[] = $tmpArray;
 
 endforeach;
    $this->view->propertyReqResultData             = $propertyReqResultData = array_merge($resultData,$finaltmpArray);
    $this->view->total_propertyReqResultData_count = count($propertyReqResultData);      
    
    }

    $meetingSchedulerTable =  Engine_Api::_()->getDbtable('meetingscheduler', 'user');
    $meetingSchedulerData = $meetingSchedulerTable->fetchRow($meetingSchedulerTable->select()->where('scheduled_with = ?', $viewer -> getIdentity())->where('survey_notification_status = ?','survey_notification'));

    if(count($meetingSchedulerData) > 0){
        $this->view->survey_notification_status = 'survey_notification';
        $survey_question_table                  =  Engine_Api::_()->getDbtable('surveyquestions', 'user');
        $survey_question_answerTable            =  Engine_Api::_()->getDbtable('Surveyquestionsansweroptions', 'user');
        $this->view->surveyQuestionsData        = $surveyQuestionsData = $survey_question_table->fetchAll($survey_question_table->select()->where('profile_type =?',$profile_type_id ));
        $ResultData                             = array();
        $QuestionresultData                     = array();
        foreach($surveyQuestionsData as $data){
            $tmpAnswerInfo =array();
            $ResultData[0]['question']      = $data['questions'];
            $ResultData[0]['question_id']   = $data['id'];
            $ResultData[0]['profile_type']  = $data['profile_type'];
            $surveyQuestionAnswerData       = $survey_question_answerTable->fetchAll($survey_question_answerTable->select()->where('survey_question_id = ?', $data['id']));

            foreach($surveyQuestionAnswerData as $answer){
                $answerInfo['option_id'] = $answer['id'];
                $answerInfo['option']    = $answer['option'];
                $tmpAnswerInfo[]         =   $answerInfo;
            }
            $ResultData[0]['answer']     = $tmpAnswerInfo;
            $QuestionresultData          = array_merge($QuestionresultData,$ResultData);
        }
        $this->view->surveyQuestions      = $QuestionresultData;
        $this->view->meetingSchedulerData = $meetingSchedulerData;
    }
    else{
        $this->view->survey_notification_status = '0';
    }
  }
}
