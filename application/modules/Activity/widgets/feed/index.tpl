<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Activity
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: index.tpl 10018 2013-03-27 01:36:15Z john $
 * @author     John
 */
 $status    		=   'false';
 $popup_status 		=	'large_popUp';
?>
<script src="/application/modules/User/externals/scripts/lightbox-plus-jquery.min.js"></script>
 <link href="/application/modules/User/externals/styles/lightbox.min.css" rel="stylesheet" type="text/css">
<script src="/application/modules/User/externals/scripts/message_notififaction.js"></script>
<script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/scripts/jRating.jquery.js"></script>
<!--<script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/scripts/dropdown.js"></script>
<link rel="stylesheet" href="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/styles/dropdown.css"> -->
<script>
var filtermode = '<?php echo $this->filtermode;?>';
</script>
<?php
// member type
    $viewer = Engine_Api::_()->user()->getViewer();
    date_default_timezone_set($viewer->timezone);
    $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
    if( !empty($fieldsByAlias['profile_type']) )
    {
      $optionId = $fieldsByAlias['profile_type']->getValue($viewer);
      $this->view->profiletype = $profile_type_id = $optionId->value;
      $viewerProfileType = $profile_type_id;
    }
    if( Engine_Api::_()->core()->hasSubject() ) {
      // Get subject
        $subject = Engine_Api::_()->core()->getSubject();
        $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($subject);
        if( !empty($fieldsByAlias['profile_type']) )
        {
          $optionId = $fieldsByAlias['profile_type']->getValue($subject);
          $subjectProfileType = $optionId->value;
        }
    }

if(empty(Engine_Api::_()->core()->hasSubject())){ //  home feed
	
    if($viewerProfileType == 4 ){ $checkhomefeedtype = 'landlordfeed';}  //check  landlord
    elseif($viewerProfileType == 1 ){$checkhomefeedtype = 'tenantfeed';}//check  tenant
    else{$checkhomefeedtype = 'servicefeed';}
    
}
else{ $checkhomefeedtype = '';}

if(Engine_Api::_()->core()->hasSubject()){  //  profile feed
	
    if($subjectProfileType ==4){ $checkprofilefeedtype = 'landlordfeed';}//check  landlord
    elseif($subjectProfileType == 1){ $checkprofilefeedtype = 'tenantfeed'; } // tenant
    else{ $checkprofilefeedtype = 'servicefeed';}
}
else{ $checkprofilefeedtype = '';}

	$useragent     = $_SERVER['HTTP_USER_AGENT'];
	$iPod          = stripos($_SERVER['HTTP_USER_AGENT'],"iPod");
	$iPhone        = stripos($_SERVER['HTTP_USER_AGENT'],"iPhone");
	$iPad          = stripos($_SERVER['HTTP_USER_AGENT'],"iPad");
	$Android       = stripos($_SERVER['HTTP_USER_AGENT'],"Android");
	$webOS         = stripos($_SERVER['HTTP_USER_AGENT'],"webOS");

	if( $iPod || $iPhone || $iPad || $Android)  { $dev_type= 1; }// mobile
	else{$dev_type= 2; } // system

    $userHelperObj  = $this->getHelper('User');
    $memberPackage  = $userHelperObj->getmemberpackage($viewer->getIdentity());
    $package_type   = $memberPackage ->package_type;
    $scoutCount     = $userHelperObj->getscoutcount($viewer->getIdentity());
    $settings       = Engine_Api::_()->getApi('settings', 'core');
    $user_premiumLevelProvision       = $settings->user_premiumLevelProvision; 
    $user_basicPropertyLimit          = $settings->user_basicPropertyLimit;  
    $user_landlordProPropertyLimit    = $settings->user_landlordProPropertyLimit;  
    $user_basicScoutLimit             = $settings->user_basicScoutLimit;  
    $user_landlordProScoutLimit       = $settings->user_landlordProScoutLimit; 
    
    $userdetails    = $userHelperObj->getuserDetails($viewer->getIdentity());
    $profileType    = $userdetails['profile_type'];    
?>


<script type="text/javascript">
    <?php $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); ?>
    var viewer_identity='<?php echo $viwer_id; ?>';
    var latitude  = 40.712784;
    var longitude = -74.005941;
jQuery('body').on('click', '.div_attachment_cancel', function(event){
    jQuery('#fade').css('display','none');
    jQuery('#light').css('display','none');
    jQuery('#light1').css('display','none');
    jQuery('#light2').css('display','none');
    jQuery('#light4').css('display','none');
    jQuery('.map_div').html('');
    jQuery('.map_location_div').html('');
});
jQuery('body').on('click', '.set_location', function(event){
	
	 var package_type = "<?php echo $package_type;?>";
     var profile_type_id = "<?php echo $profile_type_id;?>";
     var user_premiumLevelProvision = "<?php echo $user_premiumLevelProvision;?>";
     var user_basicScoutLimit = "<?php echo $user_basicScoutLimit;?>";
     var scoutcount = jQuery.trim(jQuery(".scoutcount").val());
	
	var dev_type ='<?php echo $dev_type;?>';
    var oData           = new Object();
    var prty_country    = oData.prty_country =jQuery.trim(jQuery("#country").val());
    var prty_state      = oData.prty_state =jQuery.trim(jQuery("#administrative_area_level_1").val());
    var prty_city       = oData.prty_city =jQuery.trim(jQuery("#locality").val());
    if(prty_city == ''){
         var prty_city        = oData.prty_city =jQuery.trim(jQuery("#sublocality_level_1").val());
    }
    var prty_county           =  oData.prty_county =jQuery.trim(jQuery("#sublocality_level_1").val());
    var prty_neighborhood     =  oData.prty_neighborhood =jQuery.trim(jQuery("#neighborhood").val());
    var prty_street_address   = oData.prty_street_address =jQuery.trim(jQuery("#street_number").val());
    var prty_zipcode          = oData.prty_zipcode =jQuery.trim(jQuery("#postal_code").val());
    var prty_latitude         = oData.prty_latitude =jQuery.trim(jQuery("#latitude").val());
    var prty_longitude        = oData.prty_longitude =jQuery.trim(jQuery("#longitude").val());
    var prty_location         = oData.prty_location =jQuery.trim(jQuery("#pac-input1").val());
    var is_prefered_location  = oData.is_prefered_location = jQuery('.prefered_loc_chk').prop("checked");
    var set_to_usa            = oData.set_to_usa = jQuery('.select_prefernce_location_popup #set_to_usa').prop("checked");
    if(dev_type == 1){
		var set_to_usa            = oData.set_to_usa = jQuery('#locationPreferenceDeviceModal #set_to_usa').prop("checked");
	}
    var is_validated = true;
    
     if(package_type == '' && profile_type_id == 4 && user_premiumLevelProvision == 2){
	   if(scoutcount >=parseInt(user_basicScoutLimit)){
		   jQuery('.select_prefernce_location_popup .message').html('To continue, please upgrade your package. <a href="/support?page=upgradePackage">Upgrade Package</a>');
           is_validated = false;
     }
    }
    if(is_validated == true) {
    if((set_to_usa == false) &&  (prty_country =='' && prty_state =='' && prty_city =='' && prty_zipcode == '')){
        jQuery('.message').text('Please select a valid location ');
        is_validated = false;
    }
    else {
        if(set_to_usa == false){
        if( prty_country !='' || prty_state !='' || prty_city !='' || prty_zipcode !=''){
        is_validated = true;
        }
        else{
        is_validated = false;
        jQuery('.message').text('Please select a valid location');
        }
        oData.set_to_usa ='';
        }
        else{
        is_validated = true;
        }
    }
   }
    if(is_validated == true) {
    var price          =  oData.price             = jQuery("#price_filtering_icon").val();
   // alert(price);
    var pets_type      =  oData.pets_type         = jQuery("#typeofpets_filtering_icon").val();
    var no_of_bedrooms =  oData.no_of_bedrooms    = jQuery("#noofbedrooms_filtering_icon").val();
        jQuery('.set_location').css('display','none');
        jQuery('.results-pane-loader').css('display','block');
        jQuery('.set_location_loader').css('display','block');
        var formURL    = '<?php echo $this->baseUrl(); ?>' + '/user/index/setlocation';
        jQuery.ajax( {
                        url : formURL,
                        type: "POST",
                        dataType: 'json',
                        data : oData,
                            success: function (returndata) {
                                       location.href = '<?php echo $this->baseUrl(); ?>' + '/members/home';
                            },
                            error: function(e){
                           jQuery(".set_location_loader").css("display", "none");
                           jQuery(".results-pane-loader").css("display", "none");
                           jQuery('.set_location').css('display','block');  }
                        });
    }
    
});

jQuery('body').on('click', '.create_preference_div', function(event){
	jQuery('#matchesModal .message').css('color','#333');
});
jQuery('body').on('click', '.submit_matches', function(event){
	 jQuery('#matchesModal .err_msg').text('');
	 var package_type = "<?php echo $package_type;?>";
     var profile_type_id = "<?php echo $profile_type_id;?>";
     var user_premiumLevelProvision = "<?php echo $user_premiumLevelProvision;?>";
     var user_basicScoutLimit = "<?php echo $user_basicScoutLimit;?>";
     var user_landlordProScoutLimit = '<?php echo $user_landlordProScoutLimit;?>';

	
   jQuery(".submit_matches_loader").css("display", "block");
   jQuery('.submit_matches').css('display','none');

   var housing_types= jQuery('input[name="housing_type"]:checked').val();

   if(housing_types == undefined){
       housing_types = '';
   }
   var scout_name   = jQuery(".scout_name").val();
   var is_petsallowd= jQuery("#is_petsallowd").val();
   var pets_type    = jQuery("#pets_type").val();
   var price        = jQuery("#matchesModal .price_range_from").val();
   var price_to        = jQuery("#matchesModal .price_range_to").val();
   var number_of_rooms        = jQuery("#number_of_rooms").val();
   var location        = jQuery("#location").val();
   var oData           = new Object();
   var PreferenceCountry                        = oData.PreferenceCountry =jQuery.trim(jQuery(".new_preference_country").val());
   var PreferenceState                          = oData.PreferenceState =jQuery.trim(jQuery(".new_preference_state").val());
   var PreferenceCity                           = oData.PreferenceCity =jQuery.trim(jQuery(".new_preference_city").val());
   if(PreferenceCity == ''){
   var PreferenceCity     = oData.PreferenceCity =jQuery.trim(jQuery(".new_preference_sublocality_level_1").val());
   }
 
   var PreferenceCounty          =  oData.PreferenceCounty =jQuery.trim(jQuery(".new_preference_sublocality_level_1").val());
   var PreferencNeighborhood     =  oData.PreferenceNeighborhood =jQuery.trim(jQuery(".new_preference_neighborhood").val());
   var PreferenceZip             = oData.PreferenceZip =jQuery.trim(jQuery(".new_prefernce_zip").val());
   oData.housing_types = housing_types;
   oData.is_petsallowd = is_petsallowd;
   oData.pets_type     = pets_type;
   oData.price         = price;
   oData.price_to         = price_to;
   oData.number_of_rooms  = number_of_rooms;
   oData.location         = location;
   oData.scout_name       = scout_name;
   
   var scoutcount         =  oData.scoutcount = jQuery.trim(jQuery(".scoutcount").val());

   var is_validate = true;
   
   /*if(housing_types == '' && is_petsallowd == '' &&  pets_type == '' && price == '' && number_of_rooms == '' &&
   PreferenceCountry == '' &&PreferenceState == '' && PreferenceCity == '' && PreferenceCounty == '' && PreferencNeighborhood == '' &&   
   PreferenceZip == '' ){
	   is_validate = false;
   }
   else{
	   is_validate = true;
   }*/
  if((package_type == '' && profile_type_id == 4 && user_premiumLevelProvision == 2)){
	   if(scoutcount >=parseInt(user_basicScoutLimit)){
		   jQuery('#matchesModal .message').css('color','red');
       is_validate = false;
     }
   }
   if((package_type == 'landlord_pro_package' && profile_type_id == 4 && user_premiumLevelProvision == 2)){
	   if(scoutcount >= parseInt(user_landlordProScoutLimit)){
		   jQuery('#matchesModal .message').css('color','red');
       is_validate = false;
     }
   }
   
   if(is_validate == true){
   
	   if(PreferenceCountry == '' &&PreferenceState == '' && PreferenceCity == ''){
			jQuery('.preference_place').css('border-color','#dd1616');
			is_validate = false;
	   }
	   else{
			jQuery('.preference_place').css('border-color','#b2c6cd');
			is_validate = true;
	   }
   
   }
   if(is_validate == true){
	  if(scout_name ==''){
		 jQuery('.scout_name').css('border-color','#dd1616');
		 is_validate = false; 
	  }else{
			jQuery('.scout_name').css('border-color','#b2c6cd');
			is_validate = true;
	   }
	   
   }
   if(is_validate == true){
	   
	  if(price == '' && price_to !=''){
		  jQuery('.price_range_from').css('border-color','#dd1616');
		  is_validate = false;		  
	  }
	  else{
		  jQuery('.price_range_from').css('border-color','#b2c6cd');
		  is_validate = true;
	  } 
   }
   if(is_validate == true){
		 if(price != '' && price_to !=''){
			 if(parseFloat(price_to) < parseFloat(price)){
				jQuery('#matchesModal .price_range_from').css('border-color','#dd1616');
			    is_validate = false;  
			 }
			 else{
			   jQuery('#matchesModal .price_range_from').css('border-color','#b2c6cd'); 
			   is_validate = true; 				 
			 }
		   
		 }		 
	  }
   if(is_validate == true) {
	   
	 if(price ==''){
		
		oData.price = 0;
	}	
	if(price_to ==''){
		
		oData.price_to = 0;
	}	
   
   var formURL    = '<?php echo $this->baseUrl(); ?>' + '/user/index/filterfeedbymatches';
        jQuery.ajax( {
                        url : formURL,
                        type: "POST",
                        //dataType: 'json',
                        data : oData,
                            success: function (returndata) {
								
							if(returndata == 'true'){								
							    var url ='<?php echo $this->baseUrl(); ?>' + '/members/home';
                                window.location.assign(url);								
							}	
							else{
								jQuery('#matchesModal .err_msg').text('You have already added this preference');
								jQuery(".submit_matches_loader").css("display", "none");
                                jQuery('.submit_matches').css('display','block');  
							}

                            },
                            error: function(e){
                           jQuery(".submit_matches_loader").css("display", "none");
                           jQuery('.submit_matches').css('display','block');  }
                        });
        } 
        else{
		  jQuery(".submit_matches_loader").css("display", "none");
          jQuery('.submit_matches').css('display','block');
			
		}               
});
jQuery(document).on('change','#price_filtering_icon',function(){
    var oData                   = new Object();
    var price                   =  oData.price             = jQuery("#price_filtering_icon").val();
    var pets_type               =  oData.pets_type         = jQuery("#typeofpets_filtering_icon").val();
    var no_of_bedrooms          =  oData.no_of_bedrooms    = jQuery("#noofbedrooms_filtering_icon").val();
    oData.location_country_name = jQuery('.location_country_name').val();
    oData.location_state_name   = jQuery('.location_state_name').val();
    oData.location_city_name    = jQuery('.location_city_name').val();
    oData.location_countryId    = jQuery('.location_countryId').val();
    oData.location_stateId      = jQuery('.location_stateId').val();
    oData.location_cityId       = jQuery('.location_cityId').val();
    oData.location_zipcode      = jQuery('.location_zipcode').val();
    oData.location_county       = jQuery('.location_county').val();
    oData.location_neighborhood = jQuery('.location_neighborhood').val();
    oData.location_set_to_usa   = jQuery('.location_set_to_usa').val();
    jQuery('#typeofpets_filtering_icon').prop('disabled', 'disabled');
    jQuery('#noofbedrooms_filtering_icon').prop('disabled', 'disabled');
    jQuery('#feedpreferenceunit_filtering_icon').prop('disabled', 'disabled');
    jQuery(".results-pane-loader").css("display", "block");
     var formURL    = '<?php echo $this->baseUrl(); ?>' + '/user/index/filterfeedbyprice';
     jQuery.ajax( {
                        url : formURL,
                        type: "POST",
                        dataType: 'json',
                        data : oData,
                            success: function (returndata) {
                                    location.href = '<?php echo $this->baseUrl(); ?>' + '/members/home';
                            },
                            error: function(e){
                           jQuery(".results-pane-loader").css("display", "none");
                           jQuery('.set_location').css('display','block');  }
                        });
 });

jQuery(document).on('change','#noofbedrooms_filtering_icon',function(){
    var oData           = new Object();
    var price          =  oData.price             = jQuery("#price_filtering_icon").val();
    var pets_type      =  oData.pets_type         = jQuery("#typeofpets_filtering_icon").val();
    var no_of_bedrooms =  oData.no_of_bedrooms    = jQuery("#noofbedrooms_filtering_icon").val();
    oData.location_country_name    = jQuery('.location_country_name').val();
    oData.location_state_name      = jQuery('.location_state_name').val();
    oData.location_city_name       = jQuery('.location_city_name').val();
    oData.location_countryId       = jQuery('.location_countryId').val();
    oData.location_stateId         = jQuery('.location_stateId').val();
    oData.location_cityId          = jQuery('.location_cityId').val();
    oData.location_zipcode         = jQuery('.location_zipcode').val();
    oData.location_county          = jQuery('.location_county').val();
    oData.location_neighborhood    = jQuery('.location_neighborhood').val();
    oData.location_set_to_usa      = jQuery('.location_set_to_usa').val();
    jQuery('#price_filtering_icon').prop('disabled', 'disabled');
    jQuery('#typeofpets_filtering_icon').prop('disabled', 'disabled');
    jQuery('#feedpreferenceunit_filtering_icon').prop('disabled', 'disabled');
    jQuery(".results-pane-loader").css("display", "block");
     var formURL    = '<?php echo $this->baseUrl(); ?>' + '/user/index/filterfeedbynoofbedrooms';
     jQuery.ajax( {
                        url : formURL,
                        type: "POST",
                        dataType: 'json',
                        data : oData,
                            success: function (returndata) {
                                    location.href = '<?php echo $this->baseUrl(); ?>' + '/members/home';
                            },
                            error: function(e){
                           jQuery(".results-pane-loader").css("display", "none");
                           jQuery('.set_location').css('display','block');  }
                        });
 });
jQuery(document).on('change','#typeofpets_filtering_icon',function(){
    var oData           = new Object();
    var price          =  oData.price             = jQuery("#price_filtering_icon").val();
    var pets_type      =  oData.pets_type         = jQuery("#typeofpets_filtering_icon").val();
    var no_of_bedrooms =  oData.no_of_bedrooms    = jQuery("#noofbedrooms_filtering_icon").val();
    oData.location_country_name   = jQuery('.location_country_name').val();
    oData.location_state_name     = jQuery('.location_state_name').val();
    oData.location_city_name      = jQuery('.location_city_name').val();
    oData.location_countryId      = jQuery('.location_countryId').val();
    oData.location_stateId        = jQuery('.location_stateId').val();
    oData.location_cityId         = jQuery('.location_cityId').val();
    oData.location_zipcode        = jQuery('.location_zipcode').val();
    oData.location_county         = jQuery('.location_county').val();
    oData.location_neighborhood   = jQuery('.location_neighborhood').val();
    oData.location_set_to_usa     = jQuery('.location_set_to_usa').val();
    jQuery('#price_filtering_icon').prop('disabled', 'disabled');
    jQuery('#noofbedrooms_filtering_icon').prop('disabled', 'disabled');
    jQuery('#feedpreferenceunit_filtering_icon').prop('disabled', 'disabled');
    jQuery(".results-pane-loader").css("display", "block");
     var formURL    = '<?php echo $this->baseUrl(); ?>' + '/user/index/filterfeedbypetstype';
     jQuery.ajax( {
                        url : formURL,
                        type: "POST",
                        dataType: 'json',
                        data : oData,
                            success: function (returndata) {
                                    location.href = '<?php echo $this->baseUrl(); ?>' + '/members/home';
                                    jQuery("#typeofpets_filtering_icon").val(pets_type);
                            },
                            error: function(e){
                           jQuery(".results-pane-loader").css("display", "none");
                           jQuery('.set_location').css('display','block');  }
                        });
 });

jQuery(document).on('change','#feedpreferenceunit_filtering_icon',function(event){
    jQuery('#price_filtering_icon').prop('disabled', 'disabled');
    jQuery('#typeofpets_filtering_icon').prop('disabled', 'disabled');
    jQuery('#noofbedrooms_filtering_icon').prop('disabled', 'disabled');
    jQuery(".results-pane-loader").css("display", "block");
     var count        = jQuery("#feedpreferenceunit_filtering_icon").val();
     var feedpreferenceUnitid         = jQuery('option:selected', this).attr('feedpreferenceunitid');
     var oData                  = new Object();
     oData.feedpreferenceUnitid =   feedpreferenceUnitid;
     oData.count =  count;
     var feedpreferencecount          = jQuery('option:selected', this).attr('count');
     oData.feedpreferencemore         = jQuery('option:selected', this).attr('feedpreferencemore');
         if(feedpreferencecount==5)
      {
          jQuery(".results-pane-loader").css("display", "none");
      }
     if(feedpreferencecount != undefined){
         event.preventDefault();
         event.stopImmediatePropagation();
         var i=0;
        <?php foreach($this->FeedPreferenceUnitData as $data): ?>
        var i= i+1;
        if(i == feedpreferencecount){
        var feedpreferenceunitid = '<?php echo $data['id'];?>';
        jQuery("#feedpreferenceunit_filtering_icon").append('<option value='+feedpreferencecount+' feedpreferenceunitid='+feedpreferenceunitid+' feedpreferencemore =2>Preference '+feedpreferencecount+'</option>');
        feedpreferencecount++;
        jQuery('option:selected', this).remove();
        }
        <?php endforeach;?>
     }
     else{
     var formURL    = '<?php echo $this->baseUrl(); ?>' + '/user/index/filterfeedbyfeedpreferenceunit';
     jQuery.ajax( {
                        url : formURL,
                        type: "POST",
                        dataType: 'json',
                        data : oData,
                            success: function (returndata) {
                                location.href = '<?php echo $this->baseUrl(); ?>' + '/members/home';
                            },
                            error: function(e){
                           jQuery(".results-pane-loader").css("display", "none");
                           jQuery('.set_location').css('display','block');  }
                        });
    }
 });

jQuery(document).on('click','.preference_unit',function(event){
    jQuery('#price_filtering_icon').prop('disabled', 'disabled');
    jQuery('#typeofpets_filtering_icon').prop('disabled', 'disabled');
    jQuery('#noofbedrooms_filtering_icon').prop('disabled', 'disabled');
     var oData           = new Object();
     var feedpreferenceUnitid =  oData.feedpreferenceUnitid =parseInt(jQuery(this).attr('feedpreferenceunitid'));
     var preference_number = oData.preference_number = parseInt(jQuery(this).attr('preference_number'));
     oData.feedpreferenceUnitid =   feedpreferenceUnitid;
     var formURL    = '<?php echo $this->baseUrl(); ?>' + '/user/index/filterpreferenceunit';
     jQuery.ajax( {
                        url : formURL,
                        type: "POST",
                        dataType: 'json',
                        data : oData,
                            success: function (returndata) {
                                location.href = '<?php echo $this->baseUrl(); ?>' + '/members/home';
                            },
                            error: function(e){
                           jQuery('.set_location').css('display','block');  
                          }
                        });
 });
</script>
<!-- map popup ------>
<div id="light2" class="white_content map_popup select_prefernce_location_popup">
<div class="pop_up_title"><div class="div_attachment_title"><a href="<?php echo $this->baseUrl().'/location' ?>" target="_blank">View Full Map</a></div>
<div class="div_attachment_cancel"><img src="/application/modules/User/externals/images/GREYcancel.png"></div></div>
<div class="popup_content">
<div class="message" style="color:red"></div>
<div class="map_location_div">
</div>
<div class="pro_field_wrapper"><input type="checkbox" name="set_to_usa" value="2" id="set_to_usa"><span class="prty_lablel">&nbsp;Reset to USA </span>
</div>
<div class="map_options">
    <div class="set_location_btn_div"><input class="set_location" type="button" value="Save" name=""></div>
    <div class="set_location_loader loader" style="display:none"></div>
</div>
</div>
</div>

<div class="modal fade" id="surveyModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <span class="modal-title" id="exampleModalLabel">Survey</span>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
       <div class="modal-body">
           <div class="error_msg" style="color:red"></div>
        <?php if($this->survey_notification_status == 'survey_notification'):?>
          <?php foreach($this->surveyQuestions as $surveyQuestionsData):?>
          <?php $surveyqids[] = $surveyQuestionsData['question_id']?>
            <div class="survey_content">
            <div class="question"><?php echo $surveyQuestionsData['question'];?></div>
            <div class="answer">
            <?php foreach($surveyQuestionsData['answer'] as $ans):?>
            <input type="radio" name="survey_ans_<?php echo $surveyQuestionsData['question_id'];?>" value="<?php echo $ans['option_id']?>" >
            <label class="radio_label" for="survey_ans"><?php echo $ans['option']?></label>
            <?php endforeach;?>
            </div>
            </div>
          <?php endforeach;?>
          <?php print_r($surveyqids);?>
        <?php endif;?>
        <input type="hidden" value="<?php echo $this->meetingSchedulerData->id?>" id="scheduler_id">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary survey_respond_submit" style="float: left;width: 128px;">Submit</button>
        <button type="button" class="btn btn-primary survey_respond_later" style="float: left;width: 128px;">Later</button>
        <button type="button" class="btn btn-primary  survey_respond_not_interested">Not interested</button>
        <div class="loader" style="display:none;width: 81px;height: 46px;"></div>
      </div>
    </div>
  </div>
</div>
<div id="fade" class="black_overlay"></div>
<?php    $profile_type =$this->profile_type;
   if($profile_type == 4 || $profile_type == 1){
       $is_rating_option = $this->is_rating_option; 
   }?>


<?php /*****************************/?>

<?php if(empty(Engine_Api::_()->core()->hasSubject())){?>
<?php if($checkhomefeedtype == 'tenantfeed'):?>
<?php if( $this->enableComposer ): ?>
<div class="feed_preference_main_div tenant">
<?php endif;?>
<?php endif;?>
<?php } ?>
<?php /*****************************/?>
<script>

        jQuery("#typeofpets_filtering_icon").css('width','80px');
        jQuery("#noofbedrooms_filtering_icon").css('width','80px');
        jQuery("#price_filtering_icon").css('width','87px');
    <?php  if(isset($_SESSION['feedicon'])){ ?>
    <?php  if(isset($_SESSION['location_mode_array']) && !isset($_SESSION['feedpreferenceunit'])){
           $location_mode_array = $_SESSION['location_mode_array'];
    ?>
    <?php if($location_mode_array['price'] !=''){ ?>
        var price = '<?php echo $location_mode_array['price'];?>';
        jQuery("#price_filtering_icon").val(price);
        jQuery("#price_filtering_icon").css('width','auto');
        jQuery("#typeofpets_filtering_icon").css('width','80px');
        jQuery("#noofbedrooms_filtering_icon").css('width','80px');
        jQuery("#feedpreferenceunit_filtering_icon").css('width','80px');

    <?php }
    if($location_mode_array['no_of_bedrooms'] !=''){?>
        var no_of_bedrooms = '<?php echo $location_mode_array['no_of_bedrooms'];?>';
        jQuery("#noofbedrooms_filtering_icon").val(no_of_bedrooms);
        jQuery("#noofbedrooms_filtering_icon").css('width','auto');
        jQuery("#price_filtering_icon").css('width','87px');
        jQuery("#typeofpets_filtering_icon").css('width','80px');
        jQuery("#feedpreferenceunit_filtering_icon").css('width','80px');
    <?php }
    if($location_mode_array['pets_type'] !=''){?>
        var pets_type = '<?php echo $location_mode_array['pets_type'];?>';
        jQuery("#typeofpets_filtering_icon").val(pets_type);
        jQuery("#typeofpets_filtering_icon").css('width','auto');
        jQuery("#price_filtering_icon").css('width','87px');
        jQuery("#noofbedrooms_filtering_icon").css('width','80px');
        jQuery("#feedpreferenceunit_filtering_icon").css('width','80px');
    <?php }
    }

    if(isset($_SESSION['matching_array']) && isset($_SESSION['feedpreferenceunit'])){
    $matching_array = $_SESSION['matching_array'];
    ?>
    var feedpreferenceunit = '<?php echo $_SESSION['feedpreferenceunit'];?>';
        jQuery("#feedpreferenceunit_filtering_icon").val(feedpreferenceunit);
        jQuery("#feedpreferenceunit_filtering_icon").css('width','auto');
        jQuery("#price_filtering_icon").css('width','87px');
        jQuery("#noofbedrooms_filtering_icon").css('width','80px');
        jQuery("#typeofpets_filtering_icon").css('width','80px');
    <?php } ?>
<?php } ?>
jQuery( ".change_location" ).click(function() {
    var dev_type = "<?php echo $dev_type;?>";
    if(dev_type == 1){
        //location.href = '<?php echo $this->baseUrl(); ?>' + '/location';
        initAutocomplete2();
    }
    else{
    jQuery('.map_location_div').html('');
    jQuery('.map_location_div').html('<input type= "hidden" class="field" id="street_number" ></input>'+
        ' <input  type= "hidden" class="field" id="route"></input>'+
        '<input type= "hidden" class="field" id="neighborhood" ></input>  '+   
        '<input type= "hidden" class="field" id="locality"></input>'+
        '<input type= "hidden" class="field" id="sublocality_level_1"></input>'+
        '<input type= "hidden" class="field" id="administrative_area_level_1" ></input>'+
        '<input type= "hidden" class="field" id="postal_code"></input>'+
        '<input type= "hidden" class="field" id="country"></input>'+
        '<input type= "hidden" class="field" id="latitude"></input>'+
        '<input type= "hidden" class="field" id="longitude"></input>'+
        '<div class="popup_location_label">Select Location</div>'+
        '<div class="pro_field_wrapper">'+
        '<input id="pac-input1" class="controls1 input-box prty_field" type="text" placeholder="Location" style="font-weight:bold;margin-bottom: 12px;">'+
        '</div>'+
                '<div id="map"></div>');
   jQuery("#light2").css("display","block");
   jQuery("#fade").css("display","block");
   initAutocomplete();
   }
});
jQuery( ".reset_to_usa" ).click(function() {
    var oData       = new Object();
    var set_to_usa    = oData.set_to_usa =1;
    var formURL    = '<?php echo $this->baseUrl(); ?>' + '/user/index/settousa';
    jQuery.ajax( {
                        url : formURL,
                        type: "POST",
                        dataType: 'json',
                        data : oData,
                        success: function (returndata) {
                                    location.href = '<?php echo $this->baseUrl(); ?>' + '/members/home';
                            },
                            error: function(e){
                        }
    });
});
jQuery( ".location_dropdown_submenu" ).click(function() {jQuery( '.location_dropdown_menu' ).css( 'display','block' );});
jQuery( ".location_dropdown_menu" ).mouseout(function() {jQuery( ".location_dropdown_menu" ).css( 'display','none' );});
</script>

<!-- Renter home feed-->

<?php if($checkhomefeedtype == 'tenantfeed' || $checkprofilefeedtype == 'landlordfeed'):?>
<?php  
	$licount =0; 
	$propertyimageTable    =  Engine_Api::_()->getDbtable('propertyimages', 'user');
	$likepropertyTable     =  Engine_Api::_()->getDbtable('likeuser', 'user');
	$userTable             =  Engine_Api::_()->getDbtable('users', 'user');
	$postcommentTable      =  Engine_Api::_()->getDbtable('Postcomments', 'user');
	$viewHelperObj         =  $this->getHelper('ItemPhoto');
?>
<?php if(count($this->propertyListData) ==0):?>
   <?php if((isset($_SESSION['location_mode_array'])) || (isset($_SESSION['matching_array']))):?>
  <div class="notfoundbox">There are no post available for this location</div>
  <?php  elseif($viewer->prefered_location != ''):?>
  <div class="notfoundbox">You have no posts under this preferred location</div>
  <?php else:?>
  <div class="notfoundbox">There are no post available for this location</div>
  <?php endif;?>  

<?php else: ?>
 
<div class="feed_preference_main_div tenant">
	<div class="loader results-pane-loader" style="display:none"></div>
	 <?php /*if(count($this->propertyListData) ==0):?>
		   <?php if((isset($_SESSION['location_mode_array'])) || (isset($_SESSION['matching_array']))):?>
		   <div class="results_pane_li" style="text-align: center; padding: 18px !important;">You have no posts </div>
		  <?php  elseif($viewer->prefered_location != ''):?>
			 <div class="results_pane_li" style="text-align: center; padding: 18px !important;">You have no posts under this preferred location </div>
		   <?php else:?>  
			<div class="results_pane_li" style="text-align: center; padding: 18px !important;">You have no posts </div>
		  <?php endif;*/?>  
	 

	
	<ul class='feed' id="activity-feed">
		<?php foreach($this->propertyListData as $data): ?>
		<?php $UserData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $data['property_owner_id'])); ?>
		<?php if(!empty($UserData)):?>
		<?php
                $profileNoPicInfo   =   $viewHelperObj->getNoPhoto($UserData);
                $type               =   'thumb.icon';
                $safeName           =   ( $type ? str_replace('.', '_', $type) : 'main' );
                $src                =   $UserData->getPhotoUrl($type);
                if($src):
                $src                =   $src;
                else:
                $src                =   $viewHelperObj->getNoPhoto($UserData,$safeName);
                endif;
		?>
		
		<?php $licount = $licount+1; ?>
		
			<li  class="activity_item_li activity_item_li_<?php echo $licount?>" licount=<?php echo $licount;?> id="activity-item-<?php echo $data['action_id'] ?>" data-activity-feed-item="<?php echo $data['action_id'] ?>">
			 <div class='feed_item_body feed_item_body_<?php echo $licount?>' licount=<?php echo $licount;?> >
			 
				 <div class="feed_property_locality">
					 <div class="feed_property_name">
						<a class="feed_property_name_link" href="<?php echo $this->baseUrl().'/property/'.$data['id']; ?>" title="View Property"><?php echo $data['property_name'];?> </a>
					 </div>
					 <div class="timestamp feed_timestamp">Posted on: <?php echo $this->timestamp($data['created_at']) ?></div>
					 <div class="feed_property_locality_meta">
						<?php if($data['prty_country'] !=''):?>						
						<?php echo $data['prty_country'];?>
						<?php if($data['prty_state'] !=''):?>
						<?php echo " , ".$data['prty_state']; ?>
						<?php endif;?>
						<?php if($data['prty_city'] !='' && $data['prty_city'] != $data['prty_state']):?>
						<?php echo " , ".$data['prty_city']; ?>
						<?php endif;?>				        
						 <?php if(($data['prty_county'] !='') && ($data['prty_county'] != $data['prty_city'])):?>
						 <?php echo " , ".$data['prty_county']; ?>
						 <?php endif;?>
						 <?php if($data['prty_neighborhood'] !=''):?>
						 <?php echo " , ".$data['prty_neighborhood']; ?>
						 <?php endif;?>
					   
						<?php if($dev_type == 1): // mobile?>
						<a href="<?php echo $this->baseUrl().'/property/map/'.$data['id'] ?>" target="_blank"><img src= "/application/modules/User/externals/images/LOCATION.png" style="margin-top: -4px;"></a>
						<?php else:?>
						<span class="location_icon" data-city= "<?php echo $data['prty_city'];?>" data-id ="<?php echo $data['id'];?>" data-type= "<?php echo 'property';?>" data-lat=<?php echo $data['latitude'];?> data-lng= <?php echo $data['longitude'];?>><img src= "/application/modules/User/externals/images/LOCATION.png" style="margin-top: -4px;"></span>
						<?php endif;?>
						<?php endif;?>				 
					</div>		 
				</div>	
				
				<div class='feed_item_attachments'>
					<span class='feed_attachment_album_photo'>
						
						<div class="feed_property_div">
							<div class="row" style="padding: 12px;">
							<div class="feed_property_image_div">
								<?php
								$propertyImageData         = $propertyimageTable->fetchRow($propertyimageTable->select()->where('property_id = ?', $data['id'])->where('type = "image"'));
								?>
								<a href="<?php echo $this->baseUrl().'/property/'.$data['id'] ?>" title="View Property"><img src="<?php echo $this->baseUrl().'/'.$propertyImageData->image ?>" alt="" class="feed_property_image item_photo_album_photo feed_property_image"></a>
							</div>	
							<div class="property_description">
								<?php 
								$description  = strip_tags($data['description']);
								if(strlen($description)<=300){echo $description;}
								else{$y=substr($description,0,300) . '...'; echo $y;}
								?>
							</div>
							</div>
						<div class="feed_property_details row" style="margin-bottom: 27px;margin-left: 0px;">
							<div class="property_list_spl housing_type"><span class="qwerty"><img src="/application/modules/User/externals/images/apartments.svg"></span>  <span class="qwerty_label"><?php echo $data['housing_type'];?></span></div>
							<div class="property_list_spl price"><span class="qwerty"><img src="/application/modules/User/externals/images/price.png"></span><span class="qwerty_label"> <?php echo $data['price'];?></span></div>
							<div class="property_list_spl bedroom"><span class="qwerty"><img src="/application/modules/User/externals/images/bedroom.png"></span><span class="qwerty_label"> <?php echo $data['no_of_rooms'];?> Bedroom</span></div>
							<div class="property_list_spl pets"><span class="qwerty">
								<?php if($data['has_pets'] == 'No'):?>
								<img src="/application/modules/User/externals/images/nopet.png"></span><span class="qwerty_label"> No </span>
								<?php else:?>
								<?php if($data['pets_type']== 'Dogs'):?>
								<img src="/application/modules/User/externals/images/dog.svg"></span><span class="qwerty_label"> Dog </span>
								<?php elseif($data['pets_type'] == 'Cats'):?>
								<img src="/application/modules/User/externals/images/cat.svg"></span><span class="qwerty_label"> Cat </span>
								<?php elseif($data['pets_type'] == 'Cats & Dogs'):?>
								<img src="/application/modules/User/externals/images/catndog.png"></span><span class="qwerty_label"> Cats & Dogs </span>
								<?php elseif($data['pets_type'] == 'Birds'):?>
								<img src="/application/modules/User/externals/images/bird.svg"></span><span class="qwerty_label"> Birds </span>
								<?php elseif($data['pets_type'] == 'Small pets'):?>
								<img src="/application/modules/User/externals/images/tortoise.svg"></span><span class="qwerty_label"> Small pets </span>
								<?php endif;?>
								<?php endif;?>
							</div>
						</div>	
						</div>	
					</span>		
				</div>	
				
				 <?php          
				 $likepropertyData = $likepropertyTable->fetchRow($likepropertyTable->select()->where('type = ?', 'property')
				->where('object_id = ?', $data['id'])
				->where('subject_id = ?',$viwer_id ));
				?>
					 <?php if(count($likepropertyData) == 0):?>
					  <div class="save_btn_div save_btn_div_<?php echo $data['id'];?>">
					  <button class="like_property like_property_<?php echo $data['id'];?>" property_id="<?php echo $data['id']; ?>" title="Save">Save</button>
					  </div>
					  <span class="loader like_property_loader_<?php echo $data['id'];?>" style="display:none;float:right"></span>
					  <?php else: ?>
					  <div class="save_btn_div save_btn_div_<?php echo $data['id'];?>"><button class="unlike_property like_user_<?php echo $data['id'];?>" property_id ="<?php echo $data['id'];?>" >Save</button></div>
					 <?php endif; ?>
				<div id='comment-likes-activity-item-<?php echo $data['id']?>'>
					<div class='feed_item_date feed_item_icon activity_icon_property item_icon_album_photo '>
						 <ul>
							 <li class="feed_item_option_share">
								 <?php if($dev_type == 1):  $popup_status = 'mobile'; // mobile?> 
									 <a href="<?php echo $this->baseUrl().'/tichat/singlechatmob'; ?>" target="_blank" onClick="popUpChatClick('<?php echo $UserData->user_id ?>','<?php echo $UserData->displayname; ?>','<?php echo $src ?>','<?php echo $popup_status ?>')">&nbsp;&nbsp;Message</a>
								  <?php else: ?>
									<span onClick="popUpChatClick('<?php echo $UserData->user_id ?>','<?php echo $UserData->displayname; ?>','<?php echo $src ?>','<?php echo $popup_status ?>')">
										<a href="javascript:void(0)" >&nbsp;&nbsp;Message</a>
								 <?php endif; ?>
							 </li>	
							<li> <a href="javascript:void(0)" class="feed_comment" action_id="<?php echo $data['id']; ?>" >&nbsp;&nbsp;Comment</a></li>
							
			<?php 
			/*$meetingSchedulerTable   =  Engine_Api::_()->getDbtable('meetingscheduler', 'user'); 
            $scheduledMeetingsSelect = $meetingSchedulerTable->select()
                              ->setIntegrityCheck(false)
                              ->from(array('scheduler'=>'engine4_meeting_scheduler',))
                              ->where('scheduler.property_id = ?', $data['id'])
                              ->where('scheduler.scheduled_by = ?', $viwer_id)
                              ->where('scheduler.scheduled_with = ?', $data['property_owner_id']);
            $meeting_req_Data=$meetingSchedulerTable->fetchRow($scheduledMeetingsSelect);
       
       
			$today=date('Y-m-d');
			$today_date  = strtotime($today);
            $datearray =  explode('-', $meeting_req_Data->scheduled_date);
            
            $scheduled_date=$datearray['2'].'-'.$datearray['0'].'-'.$datearray['1'];
            $scheduled_date_new=     strtotime($scheduled_date).'</br>';
           
       
            if(count($meeting_req_Data)>0):
               if($meeting_req_Data->approved=="rejected" || ($meeting_req_Data->approved!=""  && ($scheduled_date_new < $today_date))): ?>
                  <li> <a href="javascript:void(0)" class="meetingrequest meetingrequest_<?php echo $data['id']; ?>" owner_id="<?php echo $data['property_owner_id']; ?>" property_id="<?php echo $data['id']; ?>" >&nbsp;&nbsp;Schedule a viewing</a></li>
               <?php else: ?>
			       <li> <a href="javascript:void(0)" class="meetingrequested meetingrequested_<?php echo $data['id']; ?>"   style="color:red;">&nbsp;&nbsp;Scheduled</a></li>
			    <?php endif;?>				
		     <?php else:?>
		     
			<li> <a href="javascript:void(0)" class="meetingrequest meetingrequest_<?php echo $data['id']; ?>" owner_id="<?php echo $data['property_owner_id']; ?>" property_id="<?php echo $data['id']; ?>" >&nbsp;&nbsp;Schedule a viewing</a></li>
			
			<?php endif;*/ ?>				

							<div class="feed_comment_post feed_comment_post_<?php echo $data['id']?>" style="display:none">
								<form>
								<textarea class="feed_comment_body feed_comment_body_<?php echo $data['id'];?>" ></textarea>

								<input type="button" value="Post" class="comment_post_btn" status="<?php echo 'post_comment' ?>" propertyid= "<?php echo $data['id'];?>" action_id="<?php echo $data['id'];?>" viewer_id="<?php echo $viwer_id ;?>" actionSubjectId = "<?php echo $data['property_owner_id'];?>">
								</form>
							</div>
							<span class="loader loader_<?php echo $data['id'];?>" style="display:none;float:right !important"></span>
						 </ul>		 
					</div>
				
					<div class='comments comments_<?php echo $data['id'];?>'>
						 <ul>
								 <?php 
									$postcommentData = $postcommentTable->fetchAll($postcommentTable->select()
									 ->where('actionId = ?',$data['id'] )
									  ->order('commentId DESC')
									 ->limit(2)
									 ); 
								?>
							<ul class="comment_ul comment_ul_<?php echo $data['id']; ?>">
									<?php foreach($postcommentData as $commentData):?>
											<li class="comment_li comment_li_<?php echo $commentData['commentId'] ;?>">
											<?php $commentedUserData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $commentData['posterId'])); ?>
											<?php if(!empty($commentedUserData)) : ?>
											<div class="comment_auther_photo">
													<?php echo $this->htmlLink($commentedUserData->getHref(), $this->itemPhoto($commentedUserData, 'thumb.icon', $commentedUserData->getTitle()), array('title'=>$commentedUserData->getTitle())) ?>
											</div>
											<div class="comments_info">
												<span class="comments_author"><a href="<?php echo $this->baseUrl().'/profile/'.$commentData['posterId'] ?>"><?php echo $commentedUserData->getTitle();?></a></span>
												<span class="comment_content"><?php echo $commentData['body'];?></span>
												<div class="comment_timestamp" comment_time="<?php echo $commentData['created_at']; ?>"><?php echo $this->timestamp($commentData['created_at']); ?></div>
												<?php if(($viwer_id == $commentData['posterId'])): ?>
												<span class="delete_feed_comment"  data-toggle="modal" data-target="#DeletecommentModal" comment_id="<?php echo $commentData['commentId'] ?>" action_id="<?php echo $data['action_id']; ?>" poster_id="<?php echo $commentData['posterId'] ?>">
												<a href="javascript:void(0)">Delete</a>
												</span>            
												<?php endif;?>
											</div>
											<?php endif;?>		
											</li>
									<?php endforeach;?>
									
									<?php  
									 $allpostcommentData = $postcommentTable->fetchAll($postcommentTable->select()
									 ->where('actionId = ?',$data['id'] )
									  ->order('commentId DESC'));
									 $comment_count= count($allpostcommentData);  
									?>
									<?php if( $comment_count > 2): ?>
									   <div class="feed_view_comment">
											 <a href="javascript:void(0)" class="comments_Load_more comments_Load_more_<?php echo $data['id']; ?>" action_id="<?php echo $data['id']; ?>" status="<?php echo 'view_more' ?>">View more</a>
									   </div>
									<?php endif;?>		
							</ul> 
						</ul>        
					</div>
				</div>     
			 </div>
		</li>
		<?php endif;?>
		<?php  endforeach; ?>
	</ul>

</div>	
<?php endif;?>
<?php endif;?>


<!-- end Renter home feed-->

<!-- Start Landlord home feed--->

<?php if($checkhomefeedtype == 'landlordfeed' || $checkprofilefeedtype == 'tenantfeed'): ?>
<?php
$userTable = Engine_Api::_()->getDbtable('users', 'user');
$propertyRequirementTable =  Engine_Api::_()->getDbtable('propertyrequirement', 'user');
$propertyReqResultData = $this->propertyReqResultData;
 ?>
  <?php if(empty($propertyReqResultData)):?>
	  <?php if((isset($_SESSION['location_mode_array'])) || (isset($_SESSION['matching_array']))):?>
	    <div class="notfoundbox">There are no post available for this location</div>
	   <?php  elseif($viewer->prefered_location != ''):?> 
	   	<div class="notfoundbox">You have no posts under this preferred location</div>
	   	<?php else:?>  
        <div class="notfoundbox">There are no post available for this location</div>
        <?php endif; ?>
 <?php endif; ?>
 <?php   if(!empty($propertyReqResultData)):
    $licount = 0;
  ?>
 <div class="results-pane">
   <div class="loader results-pane-loader" style="display:none"></div>
   <?php /*if(empty($propertyReqResultData)):?>
     <ul>
	   <?php if((isset($_SESSION['location_mode_array'])) || (isset($_SESSION['matching_array']))):?>
		  <li class="results_pane_li" style="text-align: center; padding: 18px !important;">You have no posts </li>
	   <?php  elseif($viewer->prefered_location != ''):?>
		 <li class="results_pane_li" style="text-align: center; padding: 18px !important;">You have no posts under this preferred location </li>
	   <?php else:?>  
		 <li class="results_pane_li" style="text-align: center; padding: 18px !important;">You have no posts </li>
	   <?php endif;?> 
     
     </ul>
     <?php endif; */?>

    <ul>
    <?php
        $viewHelperObj      =   $this->getHelper('ItemPhoto');
        foreach($propertyReqResultData as $result):
           $licount =  $licount + 1;
                $user = $userTable->fetchRow($userTable->select()->where('user_id = ?', $result['userId']));
           if(!empty($user)) :    
                $profileNoPicInfo   =   $viewHelperObj->getNoPhoto($user);
                $type               =   'thumb.icon';
                $safeName           =   ( $type ? str_replace('.', '_', $type) : 'main' );
                $src                =   $user->getPhotoUrl($type);
                if($src):
                $src                =   $src;
                else:
                $src                =   $viewHelperObj->getNoPhoto($user,$safeName);
                endif;

     $userselect    =   $userTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('user'=>'engine4_users',))
                        ->joinLeft(array('search_field'=>'engine4_user_fields_search'),'search_field.item_id=user.user_id',null)
                        ->joinLeft(array('state'=>'engine4_state_list',),'state.state_id=search_field.field_76',array('state'))
                        ->joinLeft(array('city'=>'engine4_city_list',),'city.city_id=search_field.field_77',array('city'))
                        ->where('user.search=?' , 1)
                        ->where('user.enabled=?' , 1)
                        ->where('search_field.profile_type =?' , '1')
                        ->where('user.user_id = ?', $result['userId'])
                        ->group('user.user_id');          
    $userData = $userTable->fetchRow($userselect);          
    ?>

              <li class="results_pane_li results_pane_li_<?php echo $licount?>" licount = <?php echo  $licount;?>>
            <div class="results_pane_body">
          <!--  <div class="mob_bar_iphone_ipad feed_heading">-->
            <div class="feed_heading feed_heading_<?php echo $licount?>" licount = <?php echo  $licount;?>>
					
			<span><?php echo $this->timestamp($result['created_at']); ?></span> 
					
			<span class="feed_location">     
          	<?php if($result['prty_country'] !=''):?>
	        <?php if($dev_type == 1): // mobile?>
			<a href="<?php echo $this->baseUrl().'/property/requirement/map/'.$data->id ?>" target="_blank"><img src= "/application/modules/User/externals/images/LOCATION.png" style="margin-top: -4px;"></a>
			<?php else:?>
			<span class="location_icon" style="height: 30px;width: 15px;" data-city= "<?php echo $result['prty_city'];?>"  data-id ="<?php echo  $result['reqId'];?>"  data-lat=<?php echo $result['latitude'];?> data-lng= <?php echo $result['longitude'];?>><img src= "/application/modules/User/externals/images/LOCATION.png" style="margin-top: -4px;"></span>
			<?php endif;?>
			<span>	
			<?php  //echo $result['prty_country']." , ".$result['prty_state']." , ".$result['prty_city'] ;?>	
			 <?php if($result['prty_state'] !=''):?>
			 <?php echo $result['prty_state']; ?>   
			 <?php endif;?>
			 <?php if($result['prty_city'] !='' && $result['prty_city'] != $result['prty_state']):?>
			 <?php echo " , ".$result['prty_city']; ?>   
			 <?php endif;?>		 
			 <?php if($result['prty_county'] !='' && $result['prty_county'] != $result['prty_city']):?>
			 <?php echo " , ".$result['prty_county']; ?>
			 <?php endif;?>
			 <?php if($result['prty_neighborhood'] !=''):?>
			 <?php echo " , ".$result['prty_neighborhood']; ?>   
			 <?php endif;?>
			 <?php endif;?>
			</span>  
			</span>
								
			</div>
            <div class="results_pane_li_content">
            <div class="scrolling-row-inner">
			<div class="row">	
		   <?php if($dev_type == 1): // mobile?>
		   <div class="col-md-3 col-sm-2 col-xs-3 profile_image">
		   <?php else:?>		
            <div class="col-md-4 col-sm-4 col-xs-12 profile_image">
			<?php endif;?>	
            <?php echo $this->htmlLink($user->getHref(), $this->itemPhoto($user, '', array('class' => 'photo')),array('title'=>$user->getTitle())) ?>
          </div>

          </div>
         <div class="row">
                     <div class="col-md-4 col-sm-4 col-xs-12">
                        <?php  if($user->bg_verified == 1 && $result['isSmartmoveRenter'] == 0):?>
                          <span class="verified">Verified</span>
                        <?php endif;?>
                        <?php  if($user->bg_verified == 0 && $result['isSmartmoveRenter'] == 1):?>
                          <span  class="verified">Verified</span>
                        <?php endif;?>
                        <?php  if($user->bg_verified == 0 && $result['isSmartmoveRenter'] == 0):?>
                          <span class="feed_notverified_span">Not Verified</span>
                        <?php endif;?>
                        <?php  if($user->bg_verified == 1 && $result['isSmartmoveRenter'] == 1):?>
                          <span class="verified">Verified</span>
                        <?php endif;?>
                    <h2 class="vcard">
                    <span class="hover-card-parent">
                        <span class="url" style="display:block;">
                            <?php  $attribs = Array('title'=>'View Profile'); ?>
                             <?php echo $this->htmlLink($user->getHref(), ucwords($user->getTitle()),$attribs) ?>
                        </span>
                    </span>
                <span class="meta locality">
                    <?php echo "USA" . " , ";  if($userData['state'] !=''):?><?php echo $userData['state']?>, <?php endif;?> <?php echo $userData['city']?>
                </span>
                </h2>

                <?php if($viewer->getIdentity()!=$result['userId']): ?>
                <?php if($dev_type == 1): $popup_status = 'mobile'; // mobile?> 
				  <div style="padding-bottom:3px;">
					<a href="<?php echo $this->baseUrl().'/tichat/singlechatmob'; ?>" target="_blank" onClick="popUpChatClick('<?php echo $result['userId'] ?>','<?php echo $user->displayname; ?>','<?php echo $src ?>','<?php echo $popup_status ?>')"  class="feed_message_btn">Message</a>
				  </div>	
                <?php else:?>
					<div style="padding-bottom:3px;">
						<a href="javascript:void(0)" onClick="popUpChatClick('<?php echo $result['userId'] ?>','<?php echo $user->displayname; ?>','<?php echo $src ?>','<?php echo $popup_status ?>')" class="feed_message_btn">Message</a>
					</div>
                 <?php endif;?>                 
                 <?php endif;?>                 
                
                <div class="feed_rating">
                <?php if($user->rating_value != '' && $user->rating_value !=0): ?>
                <?php if($user->enable_rating_value == 1):?>
                  <div  class="basic" data-average="<?php echo $user->rating_value;?>" data-id="1" title="<?php echo $user->rating_value;?>"></div>
                  <?php else:?>
                  <div style="color: #f58410;">Not Rated</div>  
                <?php endif;?>
                <?php else:?>
                <div class="not_rated">Not Rated</div>
                <?php endif;?>
                 </div>              
                 </div>
                 <div class="col-md-7 col-sm-8 col-xs-12">
                     <?php echo substr($result['description'],0,200) . '...';?>
                </div>

                </div>
                
                </div>
                <div class="row" style="padding-top: 4px;">
                <div class="feed_icons">

                 <div class="wert" style="float:right;">
                    <div class="feed_filter_count_icons">
                    <?php if($dev_type== 1):?>
                    
                   <?php if($result['no_of_rooms']!="Room"): ?>
                    <div class="voucher1" ><img src="/application/modules/User/externals/images/feed_bedroom_orange.png" width="22px" height="22px"><h5 style="line-height: 0.8;float: right;padding-left: 7px;"><?php  echo  $result['no_of_rooms'] ;?></h5></div>
                   <?php endif; ?>
                    <div class="voucher1" ><img src="/application/modules/User/externals/images/dollar-symbol.svg" width="22px" height="22px"> <h5 style="line-height: 0.8;float: right;"><?php  echo  $result['budget'] ; if($result['budget_range_to']!='0'): echo " - ".$result['budget_range_to'];endif;?> </h5></div>
                    <div class="voucher1" title="<?php  echo  $result['housing_type'] ;?>" style="margin-right: 3px;" ><img src="/application/modules/User/externals/images/orangeapartments.svg" width="22px" height="22px"> </div>
                   
                    
                    <?php if($result['pets_allowed']=='Yes'): ?>
                    
						  <?php if($result['pets_type']== 'Dogs'):?>                     
							<div class="voucher1" title="Dogs"><img src="/application/modules/User/externals/images/dog.png" width="22px" height="22px"></div>
						 <?php elseif($result['pets_type'] == 'Cats'):?>
							 <div class="voucher1" title="Cats"><img src="/application/modules/User/externals/images/cat.png" width="22px" height="22px"></div>
						 <?php elseif($result['pets_type'] == 'Cats & Dogs'):?>
							  <div class="voucher1" title="Cats & Dogs"><img src="/application/modules/User/externals/images/Layer-18.png" width="22px" height="22px"></div>
						 <?php elseif($result['pets_type'] == 'Birds'):?>
							   <div class="voucher1" title="Birds"><img src="/application/modules/User/externals/images/bird.png" width="22px" height="22px"></div>
						 <?php elseif($result['pets_type'] == 'Small pets'):?> 
							  <div class="voucher1" title="Small pets"><img src="/application/modules/User/externals/images/tortoise.svg" width="22px" height="22px"></div> 
						 <?php endif; ?>
						
                    <?php endif; ?>
                    
                    
                    <?php if($result['vouchers']=='Yes'): ?>
                    <div class="voucher1 voucher_image" style="float:left;"><img src="/application/modules/User/externals/images/vochericon.jpg" width="22px" height="22px"></div>
                    <?php endif; ?>
                    <?php if($result['wheelchair']=='Yes'): ?>
                    <div class="voucher1" ><img src="/application/modules/User/externals/images/wheelchair.svg" width="27px" height="22px"></div>
                    <?php endif;   ?>
                    <?php  if($result['parking']=='Yes'): ?>
                    <div class="voucher1" ><img src="/application/modules/User/externals/images/parking-sign.svg" width="27px" height="22px"></div>
                    <?php endif; ?>
                    
                    
                 
                    <?php endif; ?>

                     </div> <!-- feed_icons div end-->
            
            
                 <?php if($dev_type== 2):?>
                     <div class="feed_filter_count_icons dev2">           
                    <?php if($result['no_of_rooms']!="Room"): ?>
                    <span class="voucher1 bedroom" ><img src="/application/modules/User/externals/images/feed_bedroom_orange.png" width="22px" height="22px"><span style="line-height: 0.8;padding-left: 7px;"><?php  echo  $result['no_of_rooms'] ;?></span></span>
                    <?php endif; ?>
                    <span class="voucher1 price" ><img src="/application/modules/User/externals/images/dollar-symbol.svg" width="22px" height="22px"> <span style="line-height: 0.8;"><?php  echo  $result['budget'] ; if($result['budget_range_to']!='0'): echo " - ".$result['budget_range_to'];endif;?></span></span>
                    <span class="voucher1 housing_type" title="<?php  echo  $result['housing_type'] ;?>" ><img src="/application/modules/User/externals/images/orangeapartments.svg" width="22px" height="22px"></span>


                   <?php if($result['pets_allowed']=='Yes'): ?>
                        <?php if($result['pets_type']== 'Dogs'):?>                     
							<span class="voucher1 pets" title="Dogs"><img src="/application/modules/User/externals/images/dog.png" width="22px" height="22px"></span>
						 <?php elseif($result['pets_type'] == 'Cats'):?>
							 <span class="voucher1 pets" title="Cats"><img src="/application/modules/User/externals/images/cat.png" width="22px" height="22px"></span>
						 <?php elseif($result['pets_type'] == 'Cats & Dogs'):?>
							  <span class="voucher1 pets" title="Cats & Dogs"><img src="/application/modules/User/externals/images/Layer-18.png" width="22px" height="22px"></span>
						 <?php elseif($result['pets_type'] == 'Birds'):?>
							   <span class="voucher1 pets" title="Birds"><img src="/application/modules/User/externals/images/bird.png" width="22px" height="22px"></span>
						 <?php elseif($result['pets_type'] == 'Small pets'):?> 
							  <span class="voucher1 pets" title="Small pets"><img src="/application/modules/User/externals/images/tortoise.png" width="22px" height="22px"></span> 
						 <?php endif; ?>
                    <?php endif; ?>


                    <?php if($result['vouchers']=='Yes'): ?>
                    <span class="voucher1 vouchers" ><img src="/application/modules/User/externals/images/vochericon.jpg" width="22px" height="22px"></span>
                    <?php endif; ?>
                    <?php if($result['wheelchair']=='Yes'): ?>
                    <span class="voucher1 wheelchair" ><img src="/application/modules/User/externals/images/wheelchair.svg" width="27px" height="22px"></span>
                    <?php endif;   ?>
                      <?php  if($result['parking']=='Yes'): ?>
                    <span class="voucher1 parking" ><img src="/application/modules/User/externals/images/parking-sign.svg" width="27px" height="22px"></span>
                    <?php endif; ?>
                   
                    </div>
                 <?php endif;  ?>
           
            
            <?php if($result['is_like'] == 0):?>
            <div class="save_btn_div save_btn_div_<?php echo $result['userId'];?>"><button class="like_user like_user_<?php echo $result['userId'];?>" user_id ="<?php echo $result['userId'];?>" title="Save">Save</button></div>
            <?php else: ?>
             <div class="save_btn_div save_btn_div_<?php echo $result['userId'];?>"><button class="unlike_user like_user_<?php echo $result['userId'];?>" user_id ="<?php echo $result['userId'];?>" title="Unsave">Save</button></div>
            <?php endif;?>
            
            </div>
            </div>
      </div>
     </div>
     </div>
     </li>
     <?php endif;?>
  <?php   endforeach;   ?>
   </ul>

  </div>
    <?php endif;?>
<?php endif;?>

<!-- End landlord homefeed-->

<!-- popup ------>
<div id="light" class="white_content">
<div class="pop_up_title rating_poup_title"><div class="div_attachment_title">Rating</div><div class="div_attachment_cancel"></div></div>
<div class="popup_content">
<?php if($profile_type == 4):?>
<div class="confirm_text">Would you mind taking a minute to rate your Renters, who rented your properties ?</div>
<?php endif;?>
<?php if($profile_type == 1):?>
<div class="confirm_text">Would you mind taking a minute to rate your Landlords, for his property ?</div>
<?php endif;?>
<div class="confirm_btns" style="text-align: left;">
<span class="confirm_btns"><a href="<?php echo $this->baseUrl().'/rate';?>"><button class="yes_btn yes_rate" style="width: 134px;">Rate</button></a></span>
<span class="confirm_btns"><button class="yes_cancel_rate" style="width: 100px;">Cancel</button></span>
</div>
</div>
</div>
</div>

<!-- map popup ------>
<div id="light1" class="white_content map_popup">
<div class="pop_up_title"><div class="div_attachment_title"></div><div class="div_attachment_cancel"><img src="/application/modules/User/externals/images/GREYcancel.png"></div></div>
<div class="popup_content">
<div class="map_div">
</div>
</div>
</div>

<div id="light3" class="white_content">
<div class="pop_up_title rating_poup_title"><div class="div_attachment_title">Preferred Location</div><div class="div_attachment_cancel"><img src="/application/modules/User/externals/images/GREYcancel.png"></div></div>
<div class="popup_content">
<?php if($profile_type == 4):?>
<div class="confirm_text">Choose your preferred location to see renters requirement feed from that location. You can anytime change from edit profile</div>
<?php endif;?>
<?php if($profile_type == 1):?>
<div class="confirm_text">Choose your preferred location to see property feed from that location. You can anytime change from edit profile </div>
<?php endif;?>
<div class="confirm_btns" style="text-align: left;">
<span class="confirm_btns"><a href="<?php echo $this->baseUrl().'/members/edit/locationpreference';?>"><button class="yes_btn yes_rate" style="width: 134px;">Yes</button></a></span>
</div>
</div>
</div>
<!-- end map popup ------>
<div id="fade" class="black_overlay"></div>

<script>
    var profile_type = '<?php echo  $profile_type; ?>';
    var prefered_location = '<?php echo $this->viewer()->prefered_location ;?>';
    if(profile_type == 4 || profile_type == 1){
    var page_url =  '<?php echo $this->page_url; ?>';
    var is_rating_option = '<?php echo  $is_rating_option; ?>';
    if(page_url == '/members/home'){
    if(is_rating_option == 1){
    jQuery('#fade').css('display','block');
    jQuery('#light').css('display','block');
    jQuery('.generic_layout_container.layout_left').css('display','none');
    jQuery('#global_wrapper').css('z-index','100');
    jQuery('#global_header').css('z-index','0');
    jQuery('#global_page_ynresponsive1-index-dashboard #global_wrapper').css('margin-top','0px');
    jQuery('#global_page_ynresponsive1-index-dashboard #global_wrapper').css('padding','0px');
    }
    if(prefered_location == ''){

    }
    }
  }

jQuery('body').on('click', '.yes_cancel_rate', function(event){

    jQuery('#fade').css('display','none');
    jQuery('#light').css('display','none');
    jQuery('.generic_layout_container.layout_left').css('display','block');
    jQuery('#global_wrapper').css('z-index','2');
    jQuery('#global_header').css('z-index','100');
    var host    =   window.location.host;
    var url =   'http://' + host + '/user/index/cancelrate';
     jQuery.ajax({
                        url:  url,
                        dataType: 'json',
                        type: 'POST',
                     success: function (data) {
                        if(data.status == true){
                        }
                     },
                       error: function(e){   }
                    });
});
jQuery('body').on('click', '.div_attachment_cancel', function(event){
    jQuery('#fade').css('display','none');
    jQuery('#light').css('display','none');
    jQuery('#light1').css('display','none');
    jQuery('#light2').css('display','none');
    jQuery('#light3').css('display','none');
    jQuery('#light4').css('display','none');
    jQuery('.map_div').html('');
    jQuery('.map_location_div').html('');
    jQuery('.generic_layout_container.layout_left').css('display','block');
});

</script>
<script>
jQuery( ".location_icon" ).click(function() {
    var feedtype  = jQuery(this).data("type");
    var id  = jQuery(this).data("id");
    var city  = jQuery(this).data("city");
    if(feedtype == 'property'){
        var url =  '<?php echo $this->baseUrl().'/property/map/' ?>' +id;
    }
    else{
        var url =  '<?php echo $this->baseUrl().'/property/requirement/map/' ?>' +id;
    }
    jQuery('.div_attachment_title').html();
    jQuery('.div_attachment_title').html('<a href="'+url+'" target="_blank">View Full Map</a>');
    jQuery('.map_div').html('');
    jQuery('.map_div').html('<div id="map"></div>');
    jQuery('#light1').css('display','block');
    jQuery('#fade').css('display','block');
    var latitude  = jQuery(this).data("lat");
    var longitude = jQuery(this).data("lng");
    var myLatLng = {lat: latitude, lng: longitude};
        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 4,
          center: myLatLng
        });
        // google.maps.event.trigger(map, "resize");
        var marker = new google.maps.Marker({
          position: myLatLng,
          map: map,
          title: city
        });
});

function petsType(){
    var hasPet  =   jQuery('#is_petsallowd').val();
    jQuery('#pets_type').val('');
    if(hasPet   ==  'Yes')
    {
        jQuery('.pets_type_wrapper').css('display','block');
    }
    else
    {
        jQuery('.pets_type_wrapper').css('display','none');
    }
}

 //orange border for landlord
jQuery( ".results_pane_li" ).mouseover(function() {
  var licount = parseInt(jQuery(this).attr('licount'));
   jQuery('.feed_heading.feed_heading_'+licount).css('border-top','10px solid #f15a24');

});
jQuery( ".results_pane_li" ).mouseout(function() {
 var licount = parseInt(jQuery(this).attr('licount'));
  jQuery('.feed_heading.feed_heading_'+licount).css('border-top','10px solid #f7f7f7');
});
 //orange border for tenant
jQuery( ".feed_item_body" ).mouseover(function() {
  var licount = parseInt(jQuery(this).attr('licount'));
  jQuery('.feed_item_body.feed_item_body_'+licount).css('border-top','10px solid #f15a24');
});
jQuery( ".feed_item_body" ).mouseout(function() {
 var licount = parseInt(jQuery(this).attr('licount'));
  jQuery('.feed_item_body.feed_item_body_'+licount).css('border-top','10px solid transparent');
});



jQuery(document).ready(function(){
  <?php if($this->survey_notification_status == 'survey_notification'):?>
  jQuery("#surveyModal").modal('show');
  <?php endif;?>
});


jQuery('.basic').jRating();
    jQuery('body').on('click', '.survey_respond_later', function(event){
        var scheduler_id  = jQuery('#scheduler_id').val();
        var url = '<?php echo $this->baseUrl().'/user/index/surveyrespondlater' ?>';
        var oData       = new Object();
        oData.scheduler_id = scheduler_id ;
        jQuery.ajax({
                        url:  url,
                        data: oData,
                        dataType: 'json',
                        type: 'POST',
                        success: function (data) { console.log(data);
                        if(data.status == true){
                            jQuery('.close').trigger('click');
                        }
                     },
                       error: function(e){ }
                    });
    });
    jQuery('body').on('click', '.survey_respond_not_interested', function(event){
        var scheduler_id  = jQuery('#scheduler_id').val();
        var url = '<?php echo $this->baseUrl().'/user/index/surveyrespondnotinterested' ?>';
        var oData       = new Object();
        oData.scheduler_id = scheduler_id ;
        jQuery.ajax({
                        url:  url,
                        data: oData,
                        dataType: 'json',
                        type: 'POST',
                        success: function (data) { console.log(data);
                        if(data.status == true){
                            jQuery('.close').trigger('click');
                        }
                     },
                       error: function(e){ }
                    });
    });
    jQuery('body').on('click', '.survey_respond_submit', function(event){
        var surveyQuestionArray = <?php echo json_encode($surveyqids); ?>;console.log(surveyQuestionArray);
        var surveyansArray = [];
        for(var i=0; i< surveyQuestionArray.length ; i++){
            var surveyans= jQuery('input[name="survey_ans_'+surveyQuestionArray[i]+'"]:checked').val();
            surveyansArray.push(surveyans);
        }
        console.log(surveyansArray);
        var scheduler_id  = jQuery('#scheduler_id').val();
        var oData       = new Object();
        oData.scheduler_id = scheduler_id ;
        oData.surveyansArray = surveyansArray ;
        if(jQuery.inArray(undefined, surveyansArray) !== -1){
            jQuery('.error_msg').text('');
            jQuery('.error_msg').text('please answer to all questions');
        }
        else{
        var url = '<?php echo $this->baseUrl().'/user/index/surveyrespondsubmit' ?>';
        jQuery.ajax({
                        url:  url,
                        data: oData,
                        dataType: 'json',
                        type: 'POST',
                        success: function (data) { console.log(data);
                        if(data.status == true){
                            jQuery('.close').trigger('click');
                            jQuery('.error_msg').text('');
                        }
                     },
                       error: function(e){ }
                    });
        }
    });
    jQuery('body').on('click', '.like_user', function(event){
        var user_id =parseInt(jQuery(this).attr('user_id'));
        if(!jQuery('.like_user_'+user_id).hasClass('clicked')){
        jQuery('.like_user_'+user_id).addClass('clicked');
        var oData       = new Object();
        oData.user_id = user_id;
        var url = '<?php echo $this->baseUrl().'/user/index/likeuser' ?>';
        jQuery.ajax({
                        url:  url,
                        data: oData,
                        dataType: 'json',
                        type: 'POST',
                        success: function (data) { console.log(data);
                        if(data.status == true){
                            jQuery('.save_btn_div_'+user_id).html('');
                            jQuery('.save_btn_div_'+user_id).html('<button class="unlike_user like_user_'+user_id+'" user_id ="'+user_id+'" title="Unsave">Save</button>');
                        var url = '<?php echo $this->baseUrl().'/user/index/getlikedusers' ?>';
                        jQuery.ajax({
                            url:  url,
                            data: oData,
                            dataType: 'json',
                            type: 'POST',
                            success: function (result) {
                                jQuery('#likeUserModal .modal-body').html(result.html);
                                },
                           error: function(e){ }
                        });
                       }
                     },
                       error: function(e){ }
                    });
                }
        else{
            jQuery('.like_user_'+user_id).removeClass('clicked');
        }
    });
    
jQuery('body').on('click', '.feed_comment', function(event){

    var action_id =parseInt(jQuery(this).attr('action_id'));
        if(jQuery( ".feed_comment" ).hasClass("show_comment")){
             jQuery('.feed_comment_post_'+action_id+'').css('display','none');
            jQuery( ".feed_comment" ).removeClass("show_comment");
        }
        else
        {
            jQuery( ".feed_comment" ).addClass("show_comment");
            jQuery('.feed_comment_post_'+action_id+'').css('display','block');
        }

}); 
    jQuery('body').on('click', '.comment_post_btn', function(event){
	var isValidate = true;
    var action_id =parseInt(jQuery(this).attr('action_id'));
    var poster_id       =parseInt(jQuery(this).attr('viewer_id'));
    var actionSubjectId =parseInt(jQuery(this).attr('actionSubjectId'));
    var propertyid      =parseInt(jQuery(this).attr('propertyid'));
    var oData              = new Object();
    var action_id          = oData.action_id =action_id;
    var poster_id          = oData.poster_id =poster_id;
    var actionSubjectId    = oData.actionSubjectId =actionSubjectId;
    var propertyid         = oData.propertyid =propertyid;
    jQuery('.loader_'+action_id).css('display','block');
    jQuery('.feed_comment_post_'+action_id+'').css('display','none');
    jQuery( ".feed_comment" ).removeClass("show_comment");
    var feed_comment_body = jQuery('.feed_comment_body_'+action_id+'').val();
    if(feed_comment_body == ''){
		isValidate = false;
		jQuery('.loader_'+action_id).css('display','none');
        jQuery('.feed_comment_post_'+action_id+'').css('display','block');
	}
	if(isValidate  == true){
      var feed_comment_body    = oData.feed_comment_body =feed_comment_body;
      var formURL    = '<?php echo $this->baseUrl(); ?>' + '/user/index/postfeedcomment';
            jQuery.ajax( {
                        url : formURL,
                        type: "POST",
                        dataType: 'json',
                        data : oData,
                        success: function (data) {
                            jQuery('.comment_ul_'+action_id+'').html(data.html);
                            jQuery('.feed_comment_body_'+action_id+'').val('');
                            jQuery('.loader_'+action_id).css('display','none');
                            },
                            error: function(e){
                        }
                    
       });

     }   
    });
    
  jQuery('body').on('click', '.delete_feed_comment', function(event){
   var comment_id =parseInt(jQuery(this).attr('comment_id')); 
   var poster_id =parseInt(jQuery(this).attr('poster_id'));
   var action_id    = parseInt(jQuery(this).attr('action_id'));
   jQuery(".yes_delete_comment").attr("comment_id",comment_id);
   jQuery(".yes_delete_comment").attr("action_id",action_id);   
   });
    
jQuery('body').on('click', '.yes_delete_comment', function(event){
	   var comment_id = parseInt(jQuery(this).attr('comment_id'));
	   var action_id  = parseInt(jQuery(this).attr('action_id'));
	   var oData           = new Object();
	   oData.comment_id    = comment_id;
	   var URL    = '<?php echo $this->baseUrl(); ?>' + '/user/index/deletecomment';

       jQuery.ajax( {
                        url : URL,
                        type: "POST",
                        dataType: 'json',
                        data : oData,
                        success: function (data) {
                         jQuery('#DeletecommentModal .close').trigger('click');
                         jQuery(".comment_li_"+comment_id+"").css('display','none');
                         var formURL        = '<?php echo $this->baseUrl(); ?>' + '/user/index/viewcomments';
                         var status         = "view_less";
                         oData.status       = status;
                         oData.action_id    = action_id;
                         jQuery.ajax( {
                                                url : formURL,
                                                type: "POST",
                                                dataType: 'json',
                                                data : oData,
                                                success: function (data) {
                                                jQuery('.comment_ul_'+action_id+'').html(data.html);
                                                 },
                                                    error: function(e){
                                                }
                            });
                         },
                            error: function(e){
                        }
         });
    });

    jQuery('body').on('click', '.comments_Less', function(event){

    var action_id =parseInt(jQuery(this).attr('action_id'));
    var status =jQuery(this).attr('status');
    var oData           = new Object();
    var status   = oData.status =status;
    var action_id    = oData.action_id =action_id;
    jQuery('.comments_Load_more_'+action_id).remove();
    var formURL    = '<?php echo $this->baseUrl(); ?>' + '/user/index/viewcomments';
    jQuery.ajax( {
                        url : formURL,
                        type: "POST",
                        dataType: 'json',
                        data : oData,
                        success: function (data) {
                            jQuery('.comment_ul_'+action_id+'').html(data.html);
                        },
                            error: function(e){
                        }
    });

    });
    jQuery('body').on('click', '.comments_Load_more', function(event){

    var action_id =parseInt(jQuery(this).attr('action_id'));
    var status =jQuery(this).attr('status');
    var oData           = new Object();
    var status   = oData.status =status;
    var action_id    = oData.action_id =action_id;
    if(jQuery( ".comments_Load_more").hasClass("comments_Load_more_"+action_id)){

    var formURL    = '<?php echo $this->baseUrl(); ?>' + '/user/index/viewcomments';

    jQuery.ajax( {
                        url : formURL,
                        type: "POST",
                        dataType: 'json',
                        data : oData,
                        success: function (data) {

                            jQuery('.comment_ul_'+action_id+'').html(data.html);
                        },
                            error: function(e){

                        }
        });
    }
   });
   jQuery('body').on('click', '.like_property', function(event){


var oData       = new Object();

var property_id =oData.property_id =parseInt(jQuery(this).attr('property_id'));

jQuery('.like_property_loader_'+property_id).css('display','block');
jQuery('.like_property_'+property_id).css('display','none');

jQuery('.save_btn_div_'+property_id).html('');

        var url = '<?php echo $this->baseUrl().'/user/index/likeproperty' ?>';
            jQuery.ajax( {
                        url : url,
                        type: "POST",
                        dataType: 'json',
                        data : oData,
                        success: function (data) {
                        if(data.status==true)
                                   {
                        jQuery('.save_btn_div_'+property_id).html('');

                        jQuery('.save_btn_div_'+property_id).html('<button class="unlike_property like_property_'+property_id+'" user_id ="'+property_id+'" title="Unsave">Save</button>');
                        jQuery('.like_property_loader_'+property_id).css('display','none');

                        var url = '<?php echo $this->baseUrl().'/user/index/getlikedproperties' ?>';
                        jQuery.ajax({

                            url:  url,
                            data: oData,
                            dataType: 'json',
                            type: 'POST',
                            success: function (result) { console.log(result.html);

                                jQuery('#likePropertyModal .modal-body').html(result.html);


                                },
                           error: function(e){ }
                        });

                        }
                        },
                            error: function(e){

                        }
    });

    });
    
    
jQuery('body').on('click', '.meetingrequest', function(event){
    var property_id =parseInt(jQuery(this).attr('property_id'));
    var owner_id =parseInt(jQuery(this).attr('owner_id'));
    var oData           = new Object();
    var property_id    = oData.property_id =property_id;
    var owner_id    = oData.owner_id =owner_id;

    var formURL    = '<?php echo $this->baseUrl(); ?>' + '/user/index/rentermeetingrequest';

    jQuery.ajax( {
                        url : formURL,
                        type: "POST",
                        dataType: 'json',
                        data : oData,
                        success: function (data) {

                          if(data.status==true){
						  jQuery('.meetingrequest_'+property_id).html('&nbsp;&nbsp;Scheduled');
						  jQuery(".meetingrequest_"+property_id).css('color','red'); 
						  }
                        },
                            error: function(e){

                        }
        });

	
});   
    
 var  profileType = '<?php echo  $profileType;?>';
 if(profileType  == 'tenant'){
	jQuery( ".activity_item_li:first .feed_property_details" ).attr("data-step","9");
    jQuery( ".activity_item_li:first .feed_property_details" ).attr("data-intro","The icons provides you quick information on the feed. Such as parking, rent subsidies pets, and desired rent price, bedroom amount and type of rental desired.");
	  
 }
 if(profileType  == 'landlord'){
    jQuery( ".results_pane_li:first .feed_filter_count_icons.dev2" ).attr("data-step","8");
    jQuery( ".results_pane_li:first .feed_filter_count_icons.dev2" ).attr("data-scrollto","tooltip");
    jQuery( ".results_pane_li:first .feed_filter_count_icons.dev2" ).attr("data-intro"," The icons provides you quick information on the feed. Such as parking, rent subsidies pets, and desired rent price, bedroom amount and type of rental desired.");
 }
</script>
