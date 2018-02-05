<?php
class Ynresponsivepurity_Widget_MiniMenuController extends Engine_Content_Widget_Abstract
{
    public function indexAction()
    {
        if(substr(YNRESPONSIVE_ACTIVE, 0, 18) != 'ynresponsivepurity')
        {
            return $this -> setNoRender(true);
        }
        $this -> view -> viewer = $viewer = Engine_Api::_() -> user() -> getViewer();
        $this -> view -> navigation = $navigation = Engine_Api::_() -> getApi('menus', 'core') -> getNavigation('core_mini');

        //Logo
        $this->view->logo = $this->_getParam('logo', false);
        $this->view->logo_link = $this->_getParam('logo_link', false);
        $this->view->site_name = $this->_getParam('site_name', false);
        $this->view->site_link = $this->_getParam('site_link', false);

        //Search
        $require_check = Engine_Api::_() -> getApi('settings', 'core') -> core_general_search;
        if (!$require_check)
        {
            if ($viewer -> getIdentity())
            {
                $this -> view -> search_check = true;
            }
            else
            {
                $this -> view -> search_check = false;
            }
        }
        else
            $this -> view -> search_check = true;
            //main menu
            if (substr(YNRESPONSIVE_ACTIVE, 0, 18) != 'ynresponsivepurity') {
            return $this->setNoRender(true);
            }

        $this->view->navigationMain = $navigation = Engine_Api::_()
            ->getApi('menus', 'core')
            ->getNavigation('core_main');

        $this -> view -> limit = $this -> _getParam('limit', 12);
        $this->view->viewer = $viewer = Engine_Api::_()->user()->getViewer();
        $require_check = Engine_Api::_()->getApi('settings', 'core')->getSetting('core.general.browse', 1);
        if (!$require_check && !$viewer->getIdentity()) {
            $navigation->removePage($navigation->findOneBy('route', 'user_general'));
        }
        //Search
        $require_check = Engine_Api::_() -> getApi('settings', 'core') -> core_general_search;
        if (!$require_check)
        {
            if ($viewer -> getIdentity())
            {
                $this -> view -> search_check = true;
            }
            else
            {
                $this -> view -> search_check = false;
            }
        }
        else
            $this -> view -> search_check = true;
            //main menu
                // Get online users
    if ($viewer -> getIdentity()){

        $table           = Engine_Api::_()->getItemTable('user');
        $onlineTable     = Engine_Api::_()->getDbtable('online', 'user');
        $tableName       = $table->info('name');
        $onlineTableName = $onlineTable->info('name');
        $fieldsTable     = Engine_Api::_()->fields()->getTable('user', 'values');
        $fieldsTableName = $fieldsTable->info('name');
        $viewer          = Engine_Api::_()->user()->getViewer();
        $viewerId        =   $viewer->getIdentity();
        $select = $table->select()
          ->from($tableName)
          ->joinRight($onlineTableName, $onlineTableName.'.user_id = '.$tableName.'.user_id', null)
          ->where($onlineTableName.'.user_id > ?', 0)
          ->where($onlineTableName.'.active > ?', new Zend_Db_Expr('DATE_SUB(NOW(),INTERVAL 20 MINUTE)'))
          ->where($tableName.'.search = ?', 1)
          ->where($tableName.'.enabled = ?', 1)
          ->where($onlineTableName.'.user_id != ?', $viewerId) // to hide logged in user from showing in member online widget
          ->order($onlineTableName.'.active DESC')
          ->group($onlineTableName.'.user_id')
          ;

        $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
        if( !empty($fieldsByAlias['profile_type']) )
                {
                  $optionId = $fieldsByAlias['profile_type']->getValue($viewer);
                  $profile_type_id = $optionId->value;
                }
        if($profile_type_id  == 4){ // landlord
        $select
        ->joinLeft($fieldsTableName, $fieldsTableName.'.item_id = '.$tableName.'.user_id', null)
          ->where("{$fieldsTableName}.field_id = ?", 1)
          ->where("{$fieldsTableName}.value = ?", 1);
        }
        elseif($profile_type_id  == 1){ // tenant
       $select
        ->joinLeft($fieldsTableName, $fieldsTableName.'.item_id = '.$tableName.'.user_id', null)
          ->where("{$fieldsTableName}.field_id = ?", 1)
          ->where("{$fieldsTableName}.value = ?", 4);
        }
        else{

        $select
        ->joinLeft($fieldsTableName, $fieldsTableName.'.item_id = '.$tableName.'.user_id', null)
        ->where("{$fieldsTableName}.field_id = ?", 1)
        ->where("({$fieldsTableName}.value = ?", 1)
        ->orWhere("{$fieldsTableName}.value = ?)", 4);
        }
        $paginator = Zend_Paginator::factory($select);
        // Set item count per page and current page number
        $paginator->setItemCountPerPage($this->_getParam('itemCountPerPage', 16));
        $paginator->setCurrentPageNumber($this->_getParam('page', 1));
        // Skip if empty
        $count = $paginator->getTotalItemCount();
        $this->view->paginator = $paginator;
        // Make title
        $this->_onlineUserCount = $count;
        /* statistics*/
        $propertyRequirementTable     =  Engine_Api::_()->getDbtable('propertyrequirement', 'user');
        $propertyRequirementTableName = $propertyRequirementTable->info('name');
        $propertyTable                =  Engine_Api::_()->getDbtable('propertylist', 'user');
        $propertyTableName            = $propertyTable->info('name');
        $dropboxfileTable             = Engine_Api::_()->getDbtable('dropboxfiles', 'user');
        $dropboxfileTableName         = $dropboxfileTable->info('name');
        if($profile_type_id == 4){ //landlord
            $select = $table->select()
            ->from($tableName)
            ->joinLeft($fieldsTableName, "$tableName.user_id = $fieldsTableName.item_id",null)
            ->where("{$tableName}.enabled = ?", 1)
            ->where("{$fieldsTableName}.field_id = ?", 1)
            ->where("{$fieldsTableName}.value = ?", 1);
            $tenantsData                  = Zend_Paginator::factory($select);
            $this->view->tenantsCount     = $tenantsCount = $tenantsData->getTotalItemCount();
            $select_matching_requirements = $propertyRequirementTable->select()
                ->from($propertyRequirementTableName)
                ->joinLeft($propertyTableName, "$propertyRequirementTableName.country_id = $propertyTableName.country_id
                                               AND $propertyRequirementTableName.state_id=$propertyTableName.state_id
                                               AND $propertyRequirementTableName.city_id=$propertyTableName.city_id
                                               AND ($propertyRequirementTableName.budget=$propertyTableName.price
                                               OR  ($propertyTableName.price BETWEEN $propertyRequirementTableName.budget
                                               AND $propertyRequirementTableName.budget_range_to))",null)
                ->where("{$propertyTableName}.landlord_enable = ?", 1)
                ->where("{$propertyTableName}.property_owner_id = ?", $viewerId)
                ->group("{$propertyRequirementTableName}.id");
           $matching_requirementsData              =  Zend_Paginator::factory($select_matching_requirements);
           $this->view->matching_requirementsCount = $matching_requirementsCount = $matching_requirementsData->getTotalItemCount();
           $mypropertySelect        =   $propertyTable->select()
                                    ->from($propertyTableName)
                                    ->where("{$propertyTableName}.property_owner_id = ?", $viewerId);
           $mypropertysData               = Zend_Paginator::factory($mypropertySelect);
           $this->view->mypropertiesCount = $mypropertiesCount = $mypropertysData->getTotalItemCount();
           $mydocumentsSelect             =   $dropboxfileTable->select()
                                            ->from($dropboxfileTableName)
                                            ->where("{$dropboxfileTableName}.file_owner_id = ?", $viewerId);
           $mydocumentsData               = Zend_Paginator::factory($mydocumentsSelect);
           $this->view->mydocumentsCount  = $mydocumentsCount = $mydocumentsData->getTotalItemCount();
       
       
       
       
        $viewHelperObj                          =  $this->view->getHelper('SmartmoveApi');
        $stripefiles     = $viewHelperObj->getStripeFiles(); 
        $params = array(
            "testmode"   => "off",
            "private_live_key" => "sk_live_bcnF3vdwkx2Q405aOq7POiep",
            "public_live_key"  => "pk_live_evBvNtpwiJlCwieyHNPKsQLO",
            "private_test_key" => "sk_test_K2gnuPgv5SH1P3lkvw86TJIQ",
            "public_test_key"  => "pk_test_kCahdc8oaSK65WPNb3iClcF1"
        );

        if ($params['testmode'] == "off") {
        Stripe::setApiKey($params['private_test_key']);
        $pubkey = $params['public_test_key'];
        } else {
        Stripe::setApiKey($params['private_live_key']);
        $pubkey = $params['public_live_key'];
        }
        $this->view->params = $params;
       
       
        }
        elseif($profile_type_id == 1){ // tenants
            $select = $table->select()
            ->from($tableName)
            ->joinLeft($fieldsTableName, "$tableName.user_id = $fieldsTableName.item_id",null)
            ->where("{$tableName}.enabled = ?", 1)
            ->where("{$fieldsTableName}.field_id = ?", 1)
            ->where("{$fieldsTableName}.value = ?", 4);
            $landlordsData              = Zend_Paginator::factory($select);
            $this->view->landlordCount  = $landlordCount = $landlordsData->getTotalItemCount();
            $select_matching_properties = $table->select()
                        ->from($tableName)
                        ->joinLeft($propertyTableName, $propertyTableName.'.property_owner_id = '.$tableName.'.user_id', null)
                        ->joinRight($propertyRequirementTableName, "$propertyRequirementTableName.country_id = $propertyTableName.country_id
                                                               AND $propertyRequirementTableName.state_id=$propertyTableName.state_id
                                                               AND $propertyRequirementTableName.city_id=$propertyTableName.city_id
                                                               AND ($propertyRequirementTableName.budget=$propertyTableName.price
                                                               OR ($propertyTableName.price BETWEEN $propertyRequirementTableName.budget
                                                               AND $propertyRequirementTableName.budget_range_to))",null)

                        ->where("({$propertyTableName}.enable = ?", 1)
                        ->orWhere("{$tableName}.bg_verified = ?)", 1)
                        ->where("{$propertyTableName}.landlord_enable = ?", 1)
                        ->where("{$propertyRequirementTableName}.tenant_id = ?", $viewerId)
                        ->group("{$propertyTableName}.property_owner_id");
            $matchingPropertiesData              = Zend_Paginator::factory($select_matching_properties);
            $this->view->matchingPropertiesCount = $matchingPropertiesCount = $matchingPropertiesData->getTotalItemCount();
            $propertySelect                      =   $propertyTable->select()
                                                      ->from($propertyTableName)
                                                      ->where("{$propertyTableName}.enable = ?", 1)
                                                      ->where("{$propertyTableName}.landlord_enable = ?", 1);
            $propertysData                       = Zend_Paginator::factory($propertySelect);
            $this->view->propertyCount           = $propertyCount = $propertysData->getTotalItemCount();
            $mydocumentsSelect                   = $dropboxfileTable->select()
                                                    ->from($dropboxfileTableName)
                                                    ->where("{$dropboxfileTableName}.file_owner_id = ?", $viewerId);
            $mydocumentsData                     = Zend_Paginator::factory($mydocumentsSelect);
            $this->view->mydocumentsCount        = $mydocumentsCount = $mydocumentsData->getTotalItemCount();
        }
        else{ //services
             $tenantSelect            = $fieldsTable->select()
                                        ->where("{$fieldsTableName}.field_id = ?", 1)
                                        ->where("{$fieldsTableName}.value = ?", 1);
            $tenantsData              = Zend_Paginator::factory($tenantSelect);
            $this->view->tenantsCount = $tenantsCount = $tenantsData->getTotalItemCount();
            $landlordSelect           = $fieldsTable->select()
                                        ->where("{$fieldsTableName}.field_id = ?", 1)
                                        ->where("{$fieldsTableName}.value = ?", 4);
            $landlordsData             = Zend_Paginator::factory($landlordSelect);
            $this->view->landlordCount = $landlordCount = $landlordsData->getTotalItemCount();
        }
    }
     // feed preference unit
    if ($viewer -> getIdentity()){
        $FeedPreferenceUnitTable            = Engine_Api::_()->getDbtable('Feedpreferenceunit', 'user');
        $FeedPreferenceUnitDataSelect       = $FeedPreferenceUnitTable->select()
                                              ->where('userid = ?', $viewer -> getIdentity());
        $this->view->FeedPreferenceUnitData =    $FeedPreferenceUnitData = $FeedPreferenceUnitTable->fetchAll($FeedPreferenceUnitDataSelect);

         if(isset($_SESSION['location_mode_array'])){//print_r($_SESSION['location_mode_array']); exit;
             $location_mode_array = $_SESSION['location_mode_array'];
             if($location_mode_array['set_to_usa'] != '' ){
                $location_text = $this->view->location_text = 'United States';
             }
             elseif($location_mode_array['zipcode'] != ''){
                 if($location_mode_array['neighborhood_name'] !=''){
                      $location_text = $this->view->location_text = $location_mode_array['neighborhood_name'];
                 }
                 elseif($location_mode_array['county_name'] !=''){
                      $location_text = $this->view->location_text = $location_mode_array['county_name'];
                 }
                 elseif($location_mode_array['city_name'] !=''){
                      $location_text = $this->view->location_text = $location_mode_array['city_name'];
                 }
                 elseif($location_mode_array['state_name'] !=''){

                     $location_text = $this->view->location_text = $location_mode_array['state_name'];
                 }
                 else{
                      $location_text = $this->view->location_text = $location_mode_array['country_name'];
                 }
               }
               elseif($location_mode_array['neighborhood_name'] != ''){
                $location_text = $this->view->location_text = $location_mode_array['neighborhood_name'];
               }
               elseif($location_mode_array['county_name'] != ''){
                $location_text = $this->view->location_text = $location_mode_array['county_name'];
             }
               elseif($location_mode_array['city_name'] != ''){
                $location_text = $this->view->location_text = $location_mode_array['city_name'];
             }
            elseif($location_mode_array['state_name'] != ''){
                 $location_text = $this->view->location_text = $location_mode_array['state_name'];
             }
             elseif($location_mode_array['country_name'] != ''){
                 $location_text = $this->view->location_text = $location_mode_array['country_name'];
             }
         }
        else{
                if($viewer->prefered_location != '' ){
                        if($viewer->prefered_location == 'United States'){
                            $propertycountryTable       =  Engine_Api::_()->getDbtable('propertycountry', 'user');
                            $locationSelect             =  $propertycountryTable->select()
                                                            ->setIntegrityCheck(false)
                                                            ->from(array('country'=>'engine4_property_countries'))
                                                            ->where('country.prty_country = ?', 'United States');
                            $locationData             = $propertycountryTable->fetchRow($locationSelect);
                            $this->view->locationData = $locationData;
                        $country_id    = $this->view->country_id    = $locationData->country_id;
                        $location_text = $this->view->location_text = 'United States';
                        }
                        else{
                            $location   = explode(",",$viewer->prefered_location);
                            $country_id = $location[0];
                            $state_id   = $location[1];
                            $city_id    = $location[2];
                            $propertycityable =  Engine_Api::_()->getDbtable('propertycity', 'user');
                            $locationSelect   =   $propertycityable->select()
                                            ->setIntegrityCheck(false)
                                            ->from(array('city'=>'engine4_property_city'))
                                            ->joinLeft(array('country'=>'engine4_property_countries'),'city.country_id=country.country_id',array('prty_country'))
                                            ->joinLeft(array('state'=>'engine4_property_states'),'city.state_id=state.state_id',array('prty_state'))
                                            ->where('city.city_id = ?', $location[2]);
                            $locationData             = $propertycityable->fetchRow($locationSelect);
                            $this->view->locationData = $locationData;
                            $country_id    = $this->view->country_id = $locationData->country_id;
                            $state_id      = $this->view->state_id = $locationData->state_id;
                            $city_id       = $this->view->city_id = $locationData->city_id;
                            $county = $viewer->prefered_county;
		                    $neighborhood = $viewer->prefered_neighborhood;
		                     if($neighborhood!=''){ 
                              $location_text = $this->view->location_text =$neighborhood;
							}
							 elseif($county!=''){
						
							  $location_text = $this->view->location_text =$county;
							}
							else{
                            $location_text = $this->view->location_text = $locationData->prty_city;
						    }
                        }
                }
       }
        $smartmoveapiRenters_table           =  Engine_Api::_()->getDbtable('Smartmoveapirenters', 'user');
        $this->view->smartmoveapiRentersData = $smartmoveapiRenters = $smartmoveapiRenters_table->fetchRow($smartmoveapiRenters_table->select()->where('tenant_id = ?', $viewerId));
        if(!empty($smartmoveapiRenters)){
                $this->view->isSmartmoveRenter = 1;
        }
        else{
                $this->view->isSmartmoveRenter = 0;
        }
   }
        if ($viewer -> getIdentity()){
           $likeuserTable             =  Engine_Api::_()->getDbtable('likeuser', 'user');
           $likeuserData              = $likeuserTable->fetchAll($likeuserTable->select()->where('type = ?', 'user')
                                        ->where('subject_id = ?', $viewerId));
           $this->view->likeuserData  = $likeuserData;
       
           //like property
        

            $likepropertydetails= $likeuserTable->select()
           ->setIntegrityCheck(false)
           ->from(array('likeuser'=>'engine4_like_user',)) 
           ->joinLeft(array('plist'=>'engine4_property_list',),'plist.id=likeuser.object_id',array('landlord_enable')  ) 
           ->where('likeuser.type = ?', 'property')
           ->where('plist.landlord_enable = ?', '1')
           ->where('subject_id = ?', $viewerId);
        
        
        
           $likepropertyData          = $likeuserTable->fetchAll($likepropertydetails);
           $this->view->likepropertyData  = $likepropertyData;
        }

  if($profile_type_id == 1){
        $smartmoveapiRenters_table =  Engine_Api::_()->getDbtable('Smartmoveapirenters', 'user');
        $smartmoveapiRentersData   = $smartmoveapiRenters_table->fetchRow($smartmoveapiRenters_table->select()->where('tenant_id   = ?', $viewerId));
        if(count($smartmoveapiRentersData)>0){
             $this->view->smartmoveRenterApiStatus = 1;
        }
        else{
             $this->view->smartmoveRenterApiStatus = 0;
        }
  }
  if($profile_type_id == 1){
        $PaymentpackageTable          =  Engine_Api::_()->getDbtable('Paymentpackage', 'user');
        $PaymentpackageData           = $PaymentpackageTable->fetchRow($PaymentpackageTable->select()->where('user_id = ?', $viewerId)->where('active= ?', 1));
        $this->view->have_paid_report = count($PaymentpackageData);
        if(count($PaymentpackageData)>0){
            $today          = date('d-m-Y');
            $today_date     = strtotime($today);
            $expiry_date    = strtotime($PaymentpackageData->expiry_date);
            if($today_date>$expiry_date){
            $PaymentpackageData->   active = 0;
            $PaymentpackageData->   save();
            }
        }
        $SmartmoveapireportTable = Engine_Api::_()->getDbtable('Smartmoveapireport', 'user');
        $ReportshareTable        =  Engine_Api::_()->getDbtable('Reportshare', 'user');
        $SmartmoveapireportData  = $SmartmoveapireportTable->fetchRow($SmartmoveapireportTable->select()->where('RenterId     = ?', $viewerId)->where('status    = ?', 'Active'));
        if(count($SmartmoveapireportData)>0){
            $today          = date('d-m-Y');
            $today_date     = strtotime($today);
            $expiry_date    = strtotime($SmartmoveapireportData->expiry_date);
            if($today_date>$expiry_date){
                $SmartmoveapireportData->   status = 'Closed';
                $SmartmoveapireportData->   save();
                $ReportshareData                    = $ReportshareTable->fetchAll($ReportshareTable->select()->where('report_shared_by = ?', $viewerId)
                                                                                          ->where('status   = ?', 'Active'));
                if(count($ReportshareData) >0){
                    foreach($ReportshareData as $reportshare)   {
                                $ReportshareData1 = $ReportshareTable->fetchRow($ReportshareTable->select()->where('report_shared_by    = ?', $reportshare['report_shared_by']));
                                $ReportshareData1-> status = 'Closed';
                                $ReportshareData1-> save();
                                }
                }
            }

        }
    }
    if($profile_type_id == 4){
        $Reportrequest_table =  Engine_Api::_()->getDbtable('Reportrequest', 'user');
        $ReportrequestData   = $Reportrequest_table->fetchAll($Reportrequest_table->select()->where('landlord_id = ?', $viewerId));
        foreach($ReportrequestData  as $data){
            $today_date     = strtotime($today);
            $expiry_date    = strtotime($data['expiry_date']);
            if($today_date>$expiry_date){
            $ReportrequestData1            = $Reportrequest_table->fetchAll($Reportrequest_table->select()->where('id = ?', $data['id']));
            $ReportrequestData1->   status = 'Closed';
            $ReportrequestData1->   save();
            }
        }
        
    $propertyTable =  Engine_Api::_()->getDbtable('propertylist', 'user');
    $this->view->propertyListsData        = $propertyTable->fetchAll($propertyTable->select()->where('property_owner_id = ?',  $viewerId));
 
    }
    $price_table =  Engine_Api::_()->getDbtable('price', 'user');
	$price_select = $price_table->select();	
	$priceData = $price_table->fetchAll($price_select);
	$this->view->priceData = $priceData; 
   if($viewerId){	
   $loginTable = Engine_Api::_()->getDbtable('logins', 'user');
   $loginData        = $loginTable->fetchAll($loginTable->select()->where('user_id = ?',  $viewerId)
                                                                  ->where('state = ?',  'success') );
   $this->view->logincount =  count($loginData); }

 }
}
