<?php
 $subject = Engine_Api::_()->core()->getSubject();
 $displayname  = $subject->displayname;
 $displaynameArray =explode(' ',$displayname);
 $viewer = Engine_Api::_()->user()->getViewer();
 $viewHelperObj      =   $this->getHelper('ItemPhoto');
 $profile_menus = Engine_Api::_()
      ->getApi('menus', 'core')
      ->getNavigation('user_profile');
      
      
	$useragent=$_SERVER['HTTP_USER_AGENT'];

	$iPod = stripos($_SERVER['HTTP_USER_AGENT'],"iPod");
	$iPhone = stripos($_SERVER['HTTP_USER_AGENT'],"iPhone");
	$iPad = stripos($_SERVER['HTTP_USER_AGENT'],"iPad");
	$Android = stripos($_SERVER['HTTP_USER_AGENT'],"Android");
	$webOS = stripos($_SERVER['HTTP_USER_AGENT'],"webOS");
	$status = 'false';
	$viewer_id=$this->viewer()->getIdentity();
	//if(preg_match('/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino/i',$useragent)||preg_match('/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i',substr($useragent,0,4))){
	if( $iPod || $iPhone || $iPad || $Android)  {
		$dev_type= 1; // mobile

	}
	else{

		$dev_type= 2; // system
	}
$smartmoveHelperObj  = $this->getHelper('SmartmoveApi');
$StateArray          = $smartmoveHelperObj->getState();   
?>
<script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/scripts/message_notififaction.js"></script>
<script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/scripts/jRating.jquery.js"></script>

<link rel="stylesheet" href="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/styles/new-profile.css">
<script>
<?php $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); ?>
var viewer_identity='<?php echo $viwer_id; ?>';
</script>
<!-- Page Container -->
<div class="newprofile-content newprofile-margin-top" style="max-width:1400px;">
  <!-- The Grid -->
  <div class="newprofile-row-padding">
    <!-- Left Column -->
    <div class="newprofile-third">
      <div class="newprofile-white newprofile-text-grey newprofile-card-4">
        <div class="newprofile-display-container">
           <div style=
           "display: block;
			margin: 0 auto;
			width: 146px;
			height: 161px;"       
           >        
		 <?php echo $this->itemPhoto($this->subject()) ?>
           <?php if($this->is_online == 1):?>
            <div class="led-green" style="top: unset;margin-left: 6px;position: absolute;float: left;z-index: 9;"></div>
            <?php endif;?>
              </div>

          <div class="newprofile-display-bottomleft newprofile-container newprofile-text-black">
            <h2><?php echo $this->subject()->getTitle() ?> 	   
            </h2>
            <?php if($this->subjectData->rating_value != '' && $this->subjectData->rating_value !=0):?>
            <?php if($this->subjectData->enable_rating_value == 1):?>
              <div style="float: left;" class="basic" data-average="<?php echo $this->subjectData->rating_value;?>" data-id="1" title="<?php echo $this->subjectData->rating_value;?>"></div>
                <script>
                jQuery('.basic').jRating();
                </script>
           <?php endif;?>
           <?php endif;?>
          </div>
        </div>
        <div class="newprofile-container">
          <p><i class="fa fa-briefcase fa-fw newprofile-margin-right newprofile-large newprofile-text-teal"></i>
          <?php if($this->profile_type_id == 1):?>
          Renter
          <?php endif;?>
          <?php if($this->profile_type_id == 4):?>
          Landlord
          <?php endif;?>
          <?php if($this->profile_type_id == 6):?>
          Services
          <?php endif;?>
          <?php if($this->profile_type_id == 32):?>
          Repair Agent
          <?php endif;?>
          </p>
          <p><i class="fa fa-home fa-fw newprofile-margin-right newprofile-large newprofile-text-teal"></i><?php echo $this->userselectData->state?>, <?php echo $this->userselectData->city?></p>
        <?php if($this->profile_type_id == 1 && $this->creditscoreData->creditscore_view_status==1): ?>
        <?php
        $userTable = Engine_Api::_()->getDbtable('users', 'user');
        $viewer = Engine_Api::_()->user()->getViewer();
        $viewerId   =   $viewer->getIdentity();
        $creditscoreSelect   =   $userTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('user'=>'engine4_users',))
                        ->joinLeft(array('fields_value'=>'engine4_user_fields_values'),'fields_value.item_id=user.user_id',array('value'))
                        ->where('fields_value.field_id=?' , 16)
                        ->where('user.user_id=?' ,  $viewerId );
        $creditscoreData = $userTable->fetchRow($creditscoreSelect);
        ?>
        <?php if($creditscoreData->value !=''):?>
        <p><i class="fa fa-home fa-fw newprofile-margin-right newprofile-large newprofile-text-teal"></i>Credit Score: <?php echo $creditscoreData->value;?></p>
        <?php endif;?>
          <?php endif; ?>
          <?php if($subject->getIdentity() != $viewer -> getIdentity()): ?>
          <p uid="<?php echo $subject->getIdentity();?>" class="cometchat_chatwith" style="padding: 0px !important;"><i class="fa fa-envelope fa-fw newprofile-margin-right newprofile-large newprofile-text-teal"></i>Message</p>
          <?php endif;?>
          <?php if($this->profile_type_id == 4):?>
          <?php
           $propertyTable =  Engine_Api::_()->getDbtable('propertylist', 'user');
           $propertySelect   =   $propertyTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('plist'=>'engine4_property_list',))
                        ->where('plist.property_owner_id=?' , $subject->getIdentity())
                        ->where('plist.enable=?' , 1);
           $propertyData=$propertyTable->fetchAll($propertySelect);
           $total_properties = count($propertyData);
           $propertySelect   =   $propertyTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('plist'=>'engine4_property_list',))
                        ->where('plist.property_owner_id=?' , $subject->getIdentity())
                        ->where('plist.enable=?' , 1)
                        ->where('plist.granted=?' , 0);
           $propertyData=$propertyTable->fetchAll($propertySelect);
           $available_properties = count($propertyData);
          ?>
           <p><img src="/application/modules/User/externals/images/my_properties.svg" style="width: 22px;margin-right: 16px;">Total Units  : <?php echo $total_properties ; ?></p>
           <p><img src="/application/modules/User/externals/images/my_properties.svg" style="width: 22px;margin-right: 16px;">Availble Units  : <?php echo $available_properties ; ?></p>
          <?php endif;?>
          <?php if($subject->getIdentity() != $viewer -> getIdentity()): ?>
                <p><a href="javascript:void(0);" class="buttonlink reportuser" style="padding-left: 39px;background-image: url(application/modules/Core/externals/images/report.png)"  data-toggle="modal" data-target="#reportModal">Report</a></p>
                <?php if( $this->is_blocked == 0):?>
                <p><a href="javascript:void(0);" class="buttonlink blockmember" style="padding-left: 39px;background-image: url(application/modules/User/externals/images/block.png)"  data-toggle="modal" data-target="#blockmemberModal">Block Member</a></p>
                <?php endif;?> 
                <?php if( $this->is_blocked == 1):?>
                <p><a href="javascript:void(0);" class="buttonlink unblockmember" style="padding-left: 39px;background-image: url(application/modules/User/externals/images/block.png)"  data-toggle="modal" data-target="#unblockmemberModal">Unblock Member</a></p>
                <?php endif;?> 
         
                             <?php
                                $profileNoPicInfo   =   $viewHelperObj->getNoPhoto($this->subject());
                                $type               =   'thumb.icon';
                                $safeName           =   ( $type ? str_replace('.', '_', $type) : 'main' );
                                $src                =   $this->subject()->getPhotoUrl($type);
                                if($src):
                                $src                =   $src;
                                else:
                                $src                =   $viewHelperObj->getNoPhoto($this->subject(),$safeName);
                                endif;
                                $status = 'false';
                                $popup_status 		=	'large_popUp';
                            ?>
                       <?php if($dev_type == 1):  $popup_status='mobile';// mobile?>     
                            <a href="<?php echo $this->baseUrl().'/tichat/singlechatmob'; ?>" target="_blank" onClick="popUpChatClick('<?php echo $subject->getIdentity() ?>','<?php echo $this->subject()->getTitle() ?>','<?php echo $src ?>','<?php echo $popup_status ?>')">
								<i class="fa fa-envelope fa-fw newprofile-margin-right newprofile-large newprofile-text-teal" aria-hidden="true"></i>Message</p>
							</a>
                       <?php else:?>
							
						<p class="hand-symbol" onClick="popUpChatClick('<?php echo $subject->getIdentity() ?>','<?php echo $this->subject()->getTitle() ?>','<?php echo $src ?>','<?php echo $popup_status ?>')">
                            <i class="fa fa-envelope fa-fw newprofile-margin-right newprofile-large newprofile-text-teal" aria-hidden="true"></i>Message</p>
                       <?php endif;?>      
            <?php endif;?>
             <?php if($this->profile_type_id == 4):?>
               <p><a href="/properties/<?php echo $subject->getIdentity() ?>" class="buttonlink properties" style="font-size: 13px; background-size: 21px;padding-left: 39px;background-image: url(application/modules/User/externals/images/my_properties.svg)">Properties</a></p>
               <p class="screen_renter_link" style="cursor:pointer"><i class="fa fa-briefcase fa-fw newprofile-margin-right newprofile-large newprofile-text-teal" ></i>Screen Renters</p>
  
             <?php endif;?>
             <?php if($this->profile_type_id == 1 && ($subject->getIdentity() == $viewer -> getIdentity())):?>
             <p class="renter_task" style="cursor:pointer"><i class="fa fa-briefcase fa-fw newprofile-margin-right newprofile-large newprofile-text-teal" ></i>Task</p>
             <?php endif;?>

             <?php if($this->profile_type_id == 4 && ($subject->getIdentity() == $viewer -> getIdentity())):?>
             <p class="landlord_task" style="cursor:pointer"><i class="fa fa-briefcase fa-fw newprofile-margin-right newprofile-large newprofile-text-teal" ></i>Task</p>
             <?php endif;?>
             <?php if(($this->profile_type_id == 32 || $this->profile_type_id == 34) && ($subject->getIdentity() == $viewer -> getIdentity())):?>
             <p class="repairagent_task" style="cursor:pointer"><i class="fa fa-briefcase fa-fw newprofile-margin-right newprofile-large newprofile-text-teal" ></i>Task</p>
             <?php endif;?>
          <hr>
          <br>
          <?php
          $userHelperObj  = $this->getHelper('User');
          $profileCompletePercentage = $userHelperObj->getProgileComplete($subject->getIdentity());    
          $scale = 1.0;
          ?>
          <div class="percentbar" style="width:<?php echo round(100 * $scale); ?>px;">
	      <div style="width:<?php echo round($profileCompletePercentage * $scale); ?>px;"></div>
          </div>
          Profile complete: <?php echo $profileCompletePercentage; ?>%

        </div>
      </div><br>
    <!-- End Left Column -->
    </div>
    <!-- Right Column -->
    <div class="newprofile-twothird">
      <div class="newprofile-container newprofile-card-2 newprofile-white newprofile-margin-bottom newprofile-container-profilefields">
        <!--<h2 class="newprofile-text-grey newprofile-padding-16"><i class="fa fa-suitcase fa-fw newprofile-margin-right newprofile-xxlarge newprofile-text-teal"></i>Work Experience</h2>-->
        <div class="newprofile-container">
          <h5 class="newprofile-opacity"><b></b></h5>
          
          <div class="profile_fields_div" style="display:block">  <!-- profile_fields_div start-->
          <div class="tabs_alt tabs_parent " style="display:block">
          <ul id="main_tabs">
            <li class="tab_541 tab_layout_user_profile_fields active"><a href="javascript:void(0);">Info</a></li>
            <?php if($subject->getIdentity() == $viewer -> getIdentity()): ?>
             <li><a href="members/edit/profile">Edit Profile</a></li>
             <?php if($this->profile_type_id == 4):?>            
             <li class="tab_layout_manage_subscription"><a href="manage/subscription">Manage Subscription</a></li>
             <?php endif;?>           
            <?php endif;?>
          </ul>
          </div>
          <div class="profile_fields">
          <h2><i class="fa fa-certificate fa-fw newprofile-margin-right newprofile-xxlarge newprofile-text-teal"></i>Info</h2>
          <?php echo $this->content()->renderWidget('user.profile-fields'); ?>
          </div>
          </div> <!-- profile_fields_div end-->
          
          
                   <div class="property_div" style="display:none">  <!-- start property_div-->
          
         <div class="holding+property_create_form">

<article class="padding_top_bottom20">
   <div class="maincontentdiv">
      <div class="generic_layout_container layout_core_container_tabs">
	  
         <div class="propertytabs_alt propertytabs_parent tabs">
            <ul id="main_tabs_navigation">
               <li><a id="property_details" href="javascript:void(0);" class="active">PROPERTY DETAILS</a></li>
               <li><a id="property_verification_details" href="javascript:void(0);">PROPERTY VERIFICATION DETAILS</a></li>
               <li><a id="application_details" href="javascript:void(0);">APPLICATION DETAILS</a></li>
               <li><a id="personal_details" href="javascript:void(0);">PERSONAL DETAILS</a></li>
              
            </ul>
         </div>
      
      
      <article class="content_main_left">
         <div class="padding_bottom20" style="position: relative;">
            <div class="message" style='color:red;padding-bottom: 12px;'>All fields are mandatory</div>
         <div>
      </div>
      
      <div class="property_details_div"> <!--property_details_div start -->

      <form id="property_entry_form" enctype="multipart/form-data">
                  <div class="pro_field_wrapper"><span class="prty_lablel pro_label">Property Name <span style="color:red;font-weight: bolder;">*</span></span>    <input name="property_name" type="text" maxlength="65" placeholder="Property Name" id="property_name" class="prty_field input-box" value="<?php echo  $this->PropertyData->property_name?>"  autofocus></div>
                  <br>
                  <div class="pro_field_wrapper"><span class="prty_lablel pro_label">UnitNumber <span style="color:red;font-weight: bolder;">*</span></span>    <input name="UnitNumber" type="text" maxlength="50" placeholder="UnitNumber" id="UnitNumber" class="prty_field input-box" ></div>
                  <br>
                  <div class="pro_field_wrapper"><span class="prty_lablel pro_label">Street Address <span style="color:red;font-weight: bolder;">*</span></span>    <input name="Street" type="text" maxlength="65" placeholder="Street" id="Street" class="prty_field input-box" ></div>
                  <br>
                  <div class="pro_field_wrapper"><span class="prty_lablel pro_label">Phone<span style="color:red;font-weight: bolder;">*</span> </span>    <input name="Phone" type="text" maxlength="15" placeholder="Phone" id="Phone" class="prty_field input-box" ></div>
                  <br>
                  <div class="pro_field_wrapper"><span class="prty_lablel pro_label">Phone Extension <span style="color:red;font-weight: bolder;">*</span></span>    <input name="PhoneExtension" type="text" maxlength="6" placeholder="Phone Extension" id="PhoneExtension" class="prty_field input-box" ></div>
                  <br>
		          <div class="pro_field_wrapper">
         <div class="prty_lablel pro_label">Location<span style="color:red;font-weight: bolder;">*</span> </div>
        <input id="autocomplete1" class="new_property_autocomplete prty_field input-box" placeholder="Enter Location" type="text">
        <input type="hidden" class="new_property_street" id="street_number" ></input>
        <input type="hidden" class="new_propert_route" id="route"></input>
        <input type="hidden" class="new_property_neighborhood" id="neighborhood" ></input>
        <input type="hidden" class="new_property_city" id="locality"></input>
        <input type="hidden" class="new_property_sublocality_level_1 county" id="sublocality_level_1"></input>
        <input type="hidden" class="new_property_state" id="administrative_area_level_1">
        <input type="hidden" class="new_property_zip" id="postal_code">
        <input type="hidden" class="new_property_country" id="country">
        <input type="hidden" class="new_property_latitude" id="latitude">
        <input type="hidden" class="new_property_longitude" id="longitude">
        </div> <br>    
                  
                  <div class="loader" style="display:none;"></div>
                  <div class="padding_top_bottom submit_btn " >
                     <input class="property_details_btn property_btn" type="button" value="Continue" name="">
                  </div>
            </form>
            </div> <!-- property_details_div end -->
            
            
            <div class="property_verification_div" style="display:none">
               <!--property_verification_div start -->
               <div class="pro_field_wrapper">
                  <div class="prty_lablel pro_label">Classification<span style="color:red;font-weight: bolder;">*</span></div>
                  <select name="Classification" id="Classification"  class="prty_field input-box">
                     <option value="Conventional">Conventional</option>
                     <option value="Subsidized">Subsidized</option>
                  </select>
               </div>
               <br>
               <div class="pro_field_wrapper"><span class="prty_lablel pro_label">Income To Rent<span style="color:red;font-weight: bolder;">*</span> </span>    <input name="IR" type="text" maxlength="65" placeholder="IR" id="IR" class="prty_field input-box"></div>
               <br>
               <div class="pro_field_wrapper">
                  <div class="prty_lablel pro_label">Include Medical Collections<span style="color:red;font-weight: bolder;">*</span></div>
                  <select name="IncludeMedicalCollections" id="IncludeMedicalCollections"  class="prty_field input-box">
                     <option value="true">Yes</option>
                     <option value="false">No</option>
                  </select>
               </div>
               <br>
               <div class="pro_field_wrapper">
                  <div class="prty_lablel pro_label">Include Fore closures<span style="color:red;font-weight: bolder;">*</span></div>
                  <select name="IncludeForeclosures" id="IncludeForeclosures"  class="prty_field input-box">
                     <option value="true">Yes</option>
                     <option value="false">No</option>
                  </select>
               </div>
               <br>
               <div class="pro_field_wrapper">
                  <div class="prty_lablel pro_label">Decline For Open Bankruptcies<span style="color:red;font-weight: bolder;">*</span></div>
                  <select name="DeclineForOpenBankruptcies" id="DeclineForOpenBankruptcies"  class="prty_field input-box">
                     <option value="true">Yes</option>
                     <option value="false">No</option>
                  </select>
               </div>
               <br>
               <div class="pro_field_wrapper"><span class="prty_lablel pro_label">Open Bankruptcy Window <span style="color:red;font-weight: bolder;">*</span></span>    <input name="OpenBankruptcyWindow" type="text" maxlength="65" placeholder="6-120" id="OpenBankruptcyWindow" class="prty_field input-box" ></div>
               <br>
               <div class="pro_field_wrapper fcra">
                  <div class="prty_lablel pro_label"><a href="javascript:void(0)" target="_blank">Fcra Agreement Accepted<span style="color:red;font-weight: bolder;">*</span></a></div>
                  <select name="IsFcraAgreementAccepted" id="IsFcraAgreementAccepted"  class="prty_field input-box">
                     <option value="true">Yes</option>
                     <option value="false">No</option>
                  </select>
               </div>
               <br>
               <div class="loader" style="display:none;"></div>
               <div class="padding_top_bottom submit_btn " >
                  <input class="property_verification_btn property_btn" type="button" value="Continue" name="">
               </div>
               <div class="loader" style="display:none;"></div>
            </div>
            <!--property_verification_div end -->
            
            
            <!--aplication div start -->
            <div class="application_div" style="display:none">
               
               <div class="pro_field_wrapper">
				 <span class="prty_lablel pro_label">Deposit <span style="color:red">*</span></span>    
				 <input name="Deposit" type="text" maxlength="10" placeholder="Deposit" id="Deposit" class="prty_field input-box">
			  </div>
               <br>
				 <div class="pro_field_wrapper">
						 <span class="prty_lablel pro_label">Rent <span style="color:red">*</span></span> </span>    
						 <input name="Rent" type="text" maxlength="10" placeholder="Rent" id="Rent" class="prty_field input-box">
			    </div>              
				 <br>
              <div class="pro_field_wrapper">
				 <span class="prty_lablel pro_label">Lease Term In Months <span style="color:red">*</span></span> </span>    
				 <input name="LeaseTermInMonths" type="text" maxlength="2" placeholder="6-12" id="LeaseTermInMonths" class="prty_field input-box" >
			  </div>
               <br>
                <div class="pro_field_wrapper">
				 <span class="prty_lablel pro_label">Landlord Pays </span>    
				 <select name="LandlordPays" id="LandlordPays"  class="prty_field input-box">
					<option value="true">Yes</option>
					<option value="false">No</option>
				 </select>
			  </div>
               <br>
                <div class="pro_field_wrapper">
				 <span class="prty_lablel pro_label">Product Bundle </span>  
				 <select name="ProductBundle" id="ProductBundle"  class="prty_field input-box">
					<option value="PackageCore">PackageCore</option>
					<option value="PackageCorePlusEviction">PackageCorePlusEviction</option>
				 </select>
			  </div>
               <br>
               <div class="loader" style="display:none;"></div>
               <div class="padding_top_bottom submit_btn " >
                  <input class="application_btn property_btn" type="button" value="Continue" name="">
               </div>
               <div class="loader" style="display:none;"></div>
            </div>
            <!--aplication div end -->
            <div class="personal_details_div" style="display:none">
               <!--personal_details_div start -->
               <div class="pro_field_wrapper"><span class="prty_lablel pro_label">First Name <span style="color:red;font-weight: bolder;">*</span></span>    <input name="LandlordFirstName" type="text" maxlength="65" placeholder="" id="LandlordFirstName" class="prty_field input-box" value="<?php echo $displaynameArray[0]?>" readonly></div>
               <br>
               <div class="pro_field_wrapper"><span class="prty_lablel pro_label">Last Name<span style="color:red;font-weight: bolder;">*</span> </span>    <input name="LandlordLastName" type="text" maxlength="65" placeholder="" id="LandlordLastName" class="prty_field input-box"  value="<?php echo $displaynameArray[1]?>" ></div>
               <br>
               <div class="pro_field_wrapper"><span class="prty_lablel pro_label">Street Address Line One<span style="color:red;font-weight: bolder;">*</span> </span>    <input name="LandlordStreetAddressLineOne" type="text" maxlength="65" placeholder="" id="LandlordStreetAddressLineOne" class="prty_field input-box" ></div>
               <br>
               <div class="pro_field_wrapper"><span class="prty_lablel pro_label">Street Address Line Two</span>    <input name="LandlordStreetAddressLineTwo" type="text" maxlength="65" placeholder="" id="LandlordStreetAddressLineTwo" class="prty_field input-box" ></div>
               <br>
               <div class="pro_field_wrapper">
                  <span class="prty_lablel pro_label">State <span style="color:red;font-weight: bolder;">*</span><span style="color:red"></span></span>
                  <select name="LandlordState" id="LandlordState123"  class="prty_field input-box">
                     <option value="">Select</option>
                     <?php foreach($StateArray as $key =>$value):?>
                     <option value="<?php echo $key;?>"><?php echo $value;?></option>
                     <?php endforeach;?>
                  </select>
               </div>
               <br>
               <div class="pro_field_wrapper">
                  <span class="prty_lablel pro_label">City <span style="color:red;font-weight: bolder;">*</span><span style="color:red"></span></span>
                  <select name="LandlordCity" id="LandlordCity123"  class="prty_field input-box" maxlength="50">
                     <option value="">Select</option>
                     
                  </select>
               </div>
               <br>
               <div class="pro_field_wrapper"><span class="prty_lablel pro_label">Zip<span style="color:red;font-weight: bolder;">*</span></span>    <input name="LandlordZip" type="text" maxlength="5" placeholder="" id="LandlordZip" class="prty_field input-box" ></div>
               <br>
               <div class="pro_field_wrapper"><span class="prty_lablel pro_label">PhoneNumber<span style="color:red;font-weight: bolder;">*</span></span>    <input name="LandlordPhoneNumber" type="text" maxlength="15" placeholder="" id="LandlordPhoneNumber" class="prty_field input-box" ></div>
               <br>
               <div class="pro_field_wrapper"><span class="prty_lablel pro_label">Email<span style="color:red;font-weight: bolder;">*</span></span>    <input name="LandlordEmail" type="text" maxlength="65" placeholder="" id="LandlordEmail" class="prty_field input-box" value="<?php echo $viewer->email;?>" readonly></div>
               <br>
               <div class="loader property_btn_loader" style="display:none;"></div>
               <div class="padding_top_bottom submit_btn " >
                  <input class="btn_submit property_btn" type="button" value="Submit" name="">
               </div>
              
            </div>
            
            <!--personal_details_div end -->      
      </article>
      </div>
      </article>
      </div>
          </div>  <!-- end property_div-->
          
          
           <!-- smartmoveapi questions-->          
            
            <div class="smartmoveapiquestions_ans_div" style="display:none">
			<br><br>
			<div style="text-align:center;font-size:16px;">Please Answer to all questions</div>
			<br><br>
            <ul>
				<?php //$qids = array();?>
            <?php foreach($this->qans as $qdata):?>
            <?php $qIds = $qIds.','.$qdata['QuestionId']; ?>
            <div class="pro_field_wrapper">
            <li qid="<?php echo $qdata['QuestionId']?>">
            <div style="font-weight:600"><?php echo $qdata['QuestionText'];?></div> 
            <br>
             <?php //print_r($qdata['Options']); exit;?>
            <ul>
                <?php foreach($qdata['Options'] as $ans): ?>
                <li>    
				<input type="radio" name="question_<?php echo $qdata['QuestionId'];?>" value="<?php echo $qdata['QuestionId']."_".$ans['AnswerText'];?>">
                <?php echo $ans['AnswerDescription'];?>
                </li>
                <br>
                <?php endforeach;?>
            </ul>
            </li>
            <br>
            </div>
            
            <?php endforeach;?>
            
            </ul>
            <input type="button" value="Submit" class="submit_questions">
            <div class="loader submit_questions_loader"></div>
            </div>
            <!-- smartmoveapi questions-->
      


          <div class="screen_renters_div" style="display:none">
			  <input type="hidden" value="" class="smartmovePid">
			  <input type="hidden" value="" class="pid">
          
            <div class="screen_renters_subdiv">
             <div style="text-align:center; font-size:16px; ">Send verification link to a renter to get started</div>
             
              <br>
              <div class="screen_renters_subdiv_msg"></div> 
              <br><br>
             <div class="pro_field_wrapper">
                   <input name="renter_email" type="text" maxlength="65" placeholder="Renter's email" id="renter_email" class="prty_field input-box" autofocus><span style="color:red;font-weight: bolder;">*</span></span> 
             </div><br>
             <div class="pro_field_wrapper">
              <input class="invite_renter_backgroundcheck property_btn" type="button" value="SEND" name="">
              <div class="loader screen_renters_subdiv_loader" style="display:none;"></div>
            </div>          
            </div>          
          </div>
            <hr>
        </div>
        </div>
        
       <?php if($this->profile_type_id == 1 && ($subject->getIdentity() == $viewer -> getIdentity())):?>

         <div class="newprofile-container newprofile-card-2 newprofile-white newprofile-container-rentertask" style="margin-top: 15px;display:none;">
        <div class="newprofile-container">
          <h5 class="newprofile-opacity"><b></b></h5>
          <h2 class="newprofile-padding-16"><i class="fa fa-certificate fa-fw newprofile-margin-right newprofile-xxlarge newprofile-text-teal"></i>Tasks</h2>
          <p></p>
          <?php echo $this->content()->renderWidget('user.renter-task'); ?>
          <hr style="clear: both;">
        </div>
      </div>
      <?php endif;?>
      
       <?php if($this->profile_type_id == 4 && ($subject->getIdentity() == $viewer -> getIdentity())):?>

         <div class="newprofile-container newprofile-card-2 newprofile-white newprofile-container-landlordtask" style="margin-top: 15px;display:none;">
        <div class="newprofile-container">
          <h5 class="newprofile-opacity"><b></b></h5>
          <h2 class="newprofile-padding-16"><i class="fa fa-certificate fa-fw newprofile-margin-right newprofile-xxlarge newprofile-text-teal"></i>Tasks</h2>
          <p></p>
          <?php echo $this->content()->renderWidget('user.landlord-task'); ?>
          <hr style="clear: both;">
        </div>
      </div>
      <?php endif;?>
      
       <?php if(($this->profile_type_id == 32  || $this->profile_type_id == 34)&& ($subject->getIdentity() == $viewer -> getIdentity())):?>

         <div class="newprofile-container newprofile-card-2 newprofile-white newprofile-container-repairagenttask" style="margin-top: 15px;display:none;">
        <div class="newprofile-container">
          <h5 class="newprofile-opacity"><b></b></h5>
          <h2 class="newprofile-padding-16"><i class="fa fa-certificate fa-fw newprofile-margin-right newprofile-xxlarge newprofile-text-teal"></i>Tasks</h2>
          <p></p>
          <?php echo $this->content()->renderWidget('user.repairagent-task'); ?>
          <hr style="clear: both;">
        </div>
      </div>
      <?php endif;?>
      
      <?php if($this->profile_type_id == 4 || $this->profile_type_id == 1):?>
       <div class="newprofile-container newprofile-card-2 newprofile-white newprofile-container-gallery" style="margin-top: 15px;">
        <div class="newprofile-container">
          <h5 class="newprofile-opacity"><b></b></h5>
          <h2 class="newprofile-padding-16"><i class="fa fa-certificate fa-fw newprofile-margin-right newprofile-xxlarge newprofile-text-teal"></i>Galleries</h2>
          <!--<h6 class="newprofile-text-teal"><i class="fa fa-calendar fa-fw newprofile-margin-right"></i>Forever</h6>-->
          <p></p>
          <?php echo $this->content()->renderWidget('user.gallery-new'); ?>
          <hr style="clear: both;">
        </div>
      </div>
      <div class="newprofile-container newprofile-card-2 newprofile-white newprofile-container-documents" style="margin-top: 15px;">
        <div class="newprofile-container">
          <h5 class="newprofile-opacity"><b></b></h5>
          <h2 ><i class="fa fa-certificate fa-fw newprofile-margin-right newprofile-xxlarge newprofile-text-teal"></i>Documents</h2>
          <!--<h6 class="newprofile-text-teal"><i class="fa fa-calendar fa-fw newprofile-margin-right"></i>Forever</h6>-->
          <p></p>
          <?php echo $this->content()->renderWidget('user.profile-documents'); ?>
          <hr>
        </div>
      </div>
      <?php endif;?>
    <!-- End Right Column -->
    </div>
  <!-- End Grid -->
  </div>
  <!-- End Page Container -->
</div>

<!-- report modal start-->

<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content-new">
      <div class="modal-header">
        <span class="modal-title" id="exampleModalLabel"><a href="javascript:void(0)" target="_blank">Report</a></span>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">×</span>
        </button>
      </div>
       <div class="modal-body">
            <div class="message" style="color:#008000;padding: 0px 0px 8px 0px;display:block;"></div>
            <div class="err_msg" style="color:red"></div>
			<div class="matches_div">
			  Do you want to report this?
			  <div class="pro_field_wrapper">
			 <div class="prty_lablel pro_label">Type <span style="color:red;font-weight: bolder;">*</span></div>  
						<select name="reportCategory" id="reportCategory" class="prty_field reportCategory">
						<option value="">(select)</option>
						<option value="spam">Spam</option>
						<option value="abuse">Abuse</option>
						<option value="inappropriate">Inappropriate Content</option>
						<option value="licensed">Licensed Material</option>
						<option value="other">Other</option>
				       </select>
			  </div>   <br>
			  <div class="pro_field_wrapper" style="margin-bottom:5px;">
				<div class="prty_lablel pro_label" style="padding-bottom:12px;">Description <span style="color:red;font-weight: bolder;">*</span>  </div>
				<textarea class="prty_field reportDescription"></textarea>
		      </div>
			
       <div class="btn_div"><input class="submit_report" type="button" value="Submit Report" name=""></div>
      </div>
            <div class="loader" style="display:none"></div>
    </div>
  </div>
</div>
</div>

<!-- report modal end-->
<!-- block modal start-->

<div class="modal fade" id="blockmemberModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content-new">
      <div class="modal-header">
        <span class="modal-title" id="exampleModalLabel"><a href="javascript:void(0)" target="_blank">Block Member</a></span>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">×</span>
        </button>
      </div>
       <div class="modal-body">
            <div class="message" style="color:#008000;padding: 0px 0px 8px 0px;display:block;"></div>
            <div class="err_msg" style="color:red"></div>
			<div class="matches_div"  style="text-align: center;">
			  Do you want to block this member?			
			
       <div class="btn_div" style="padding-top: 12px;" style="text-align: center;"><input class="submit_blockmember" type="button" value="Block Member" name=""></div>
      </div>
      </div>
            <div class="loader" style="display:none"></div>
    </div>
  </div>
</div>


<!-- block modal end-->
<!-- block modal start-->

<div class="modal fade" id="unblockmemberModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content-new">
      <div class="modal-header">
        <span class="modal-title" id="exampleModalLabel"><a href="javascript:void(0)" target="_blank">Unblock Member</a></span>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">×</span>
        </button>
      </div>
       <div class="modal-body">
            <div class="message" style="color:#008000;padding: 0px 0px 8px 0px;display:block;"></div>
            <div class="err_msg" style="color:red"></div>
			<div class="matches_div">
			  Do you want to unblock this member?
			  <input type="hash" name="token" value="" id="token">
			
       <div class="btn_div" style="padding-top: 12px;"><input class="submit_unblockmember" type="button" value="Unblock Member" name=""></div>
      </div>
      </div>
            <div class="loader" style="display:none"></div>
    </div>
  </div>
</div>


<!-- block modal end-->

<!-- task more info modal-->

<div class="modal fade" id="taskmoreinfoModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content-new">
      <div class="modal-header">
        
      </div>
       <div class="modal-body">
        
      </div>
            <div class="loader" style="display:none"></div>
    </div>
  </div>
</div>
<!-- schedule task  modal-->

<div class="modal fade" id="scheduletaskModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content-new">
      <div class="modal-header">
        
      </div>
       <div class="modal-body">
		   <div class="pro_field_wrapper">
		   <div>Schedule Your Task</div><br><br>
		   <input type="hidden" value="" class="task_id_text prty_field input-box">
		   </div>
		   <div class="pro_field_wrapper">
		   <div>Schedule Date</div>
		   <div><input type="text" class="schedule_date_text prty_field input-box"></div><br>
		   </div>
           <div class="pro_field_wrapper">
		   <div>Expense</div><br>
		   <div><input type="text" class="expense_text prty_field input-box"></div><br>
		   </div>
		   <div class="pro_field_wrapper">
		   <div>Change Status</div><br>
		   <div>
		   <select class="status_option prty_field input-box">
		   <option value="">Select</option>
		   <option value="pending">Pending</option>
		   <option value="scheduled">Scheduled</option>
		   <option value="completed">Completed</option>
		   </select>
           </div> </div> <br>
           <div class="pro_field_wrapper">

          <input class="submit_task_update" type="button" value="Submit" name="">
       
          </div>
            <div class="loader" style="display:none"></div>
    </div>
  </div>
</div>
</div>
<!-- link modal-->

<div class="modal fade" id="linkModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content-new">
      <div class="modal-header">
        Link
      </div>
       <div class="modal-body">
		   <div class="message"></div>
		   <div class="pro_field_wrapper">
		   <div>Name</div><br>
		   <input type="text" value="" class="link_name prty_field input-box">
		   </div><br>
		   <div class="pro_field_wrapper">
		   <div>Email Address</div><br>
		   <div><input type="text" class="link_address prty_field input-box"></div><br>
		   </div><br>
           <div class="pro_field_wrapper">
		   <div>Message</div><br>
		   <div><textarea class="link_message prty_field" rows="4"></textarea></div><br>
		   </div>
		   <br>
		   <div class="pro_field_wrapper">

          <input class="submit_link" type="button" value="Submit" name="">
       
           </div>
            <div class="loader" style="display:none"></div>
    
    </div>
  </div>
</div>
</div>

















     
<script>
jQuery('body').on('click', '.submit_report', function(event){
	
	var subjectId  = "<?php echo $subject->getIdentity();?>";
	var reporterId = "<?php echo $viewer->getIdentity();?>";
	var reportCategory     = jQuery('.reportCategory').val();
	var reportDescription  = jQuery('.reportDescription').val();
	var is_validate  = true;
	if(reportCategory == ""){
		jQuery('#reportModal .reportCategory').css('border-color','#e62828');  
		is_validate   = false;
	}
	else{
		jQuery('#reportModal .reportCategory').css('border-color','#b2c6cd'); 
		is_validate  = true;
	}
	if(is_validate == true){
		if(reportDescription == ""){
		jQuery('#reportModal .reportDescription').css('border-color','#e62828'); 
		is_validate   = false;
	    }
	    else{
		jQuery('#reportModal .reportDescription').css('border-color','#b2c6cd'); 
		is_validate  = true;
		}
	}
	if(is_validate == true ){
	var oData       = new Object();		
			oData.subjectId         = subjectId;	
			oData.reporterId        = reporterId;	
			oData.reportCategory    = reportCategory;	
			oData.reportDescription = reportDescription;	
			var url          = '<?php echo $this->baseUrl().'/user/index/reportuser' ?>';		
			jQuery.ajax({
				url:  url,
				data: oData,						
				dataType: 'json',
				type: 'POST',
				success: function (result) { console.log(result.html);
							if(result.status == true){
								jQuery('#reportModal .reportCategory').val(''); 
							    jQuery('#reportModal .reportDescription').val(''); 
								jQuery('#reportModal .message').html('Your report has been submitted');
								setTimeout(function(){
									  jQuery('#reportModal .message').html(''); 
							   }, 5000);
								
							}
									
				},
				error: function(e){ }  
			   });
		}
		
	});
	jQuery('body').on('click', '.submit_blockmember', function(event){
		var subjectId  = "<?php echo $subject->getIdentity();?>";
		var oData       = new Object();		
	    oData.subjectId         = subjectId;
	    var url          = '<?php echo $this->baseUrl().'/user/index/blockmember' ?>';		
			jQuery.ajax({
				url:  url,
				data: oData,						
				dataType: 'json',
				type: 'POST',
				success: function (result) { console.log(result.html);
							if(result.status == true){
                                jQuery('#blockmemberModal .matches_div').html(''); 
								jQuery('#blockmemberModal .message').html('Member blocked');
								setTimeout(function(){
									 location.reload();
							   }, 2000);
								
							}
									
				},
				error: function(e){ }  
			   });
	    
	});
	jQuery('body').on('click', '.submit_unblockmember', function(event){
		var subjectId  = "<?php echo $subject->getIdentity();?>";
		var oData       = new Object();		
	    oData.subjectId         = subjectId;
	    var url          = '<?php echo $this->baseUrl().'/user/index/unblockmember' ?>';		
			jQuery.ajax({
				url:  url,
				data: oData,						
				dataType: 'json',
				type: 'POST',
				success: function (result) { console.log(result.html);
							if(result.status == true){
                                jQuery('#unblockmemberModal .matches_div').html(''); 
								jQuery('#unblockmemberModal .message').html('Member unblocked');
								setTimeout(function(){
									 location.reload();
							   }, 2000);
								
							}
									
				},
				error: function(e){ }  
			   });
	    
	});
	
	jQuery('body').on('click', '.screen_renter_link', function(event){
		
		jQuery('.profile_fields_div').css('display','none');
		jQuery('.property_div').css('display','block');
	});
	
    jQuery('body').on('click', '.invite_renter_backgroundcheck', function(event){
		
		   jQuery('.screen_renters_subdiv_loader').show();
		   jQuery('.invite_renter_backgroundcheck').hide();

        	var pid       = jQuery('.pid').val();
        	var smartmovePid     = jQuery('.smartmovePid').val();
        	var renter_email     = jQuery('#renter_email').val();
        	if(pid != '' && renter_email != '' && smartmovePid !==''){
			var oData       = new Object();		
	        oData.pid           = pid;
	        oData.renter_email         = renter_email;
	        oData.smartmovePid         = smartmovePid;

	        var url                    = '<?php echo $this->baseUrl().'/user/index/inviterentertobackgroundcheck'?>';		
			jQuery.ajax({
				url:  url,
				data: oData,						
				dataType: 'json',
				type: 'POST',
				success: function (result) { console.log(result);
							if(result.status == true){
                             jQuery('.screen_renters_subdiv_msg').html('Your invitation has been successfully sent');
                             jQuery('.renter_email').val('');
                             jQuery('.screen_renters_subdiv_loader').hide();
		                     jQuery('.invite_renter_backgroundcheck').show();
		                        
							}
							else{
								jQuery('.screen_renters_subdiv_loader').hide();
		                        jQuery('.invite_renter_backgroundcheck').show();
		                        jQuery('.screen_renters_subdiv_msg').html('Someone is already registered with this mail id');
							}
									
				},
				error: function(e){ }  
			   });   
				
			}
			else{
				alert("please eneter all fields");
				jQuery('.screen_renters_subdiv_loader').hide();
		        jQuery('.invite_renter_backgroundcheck').show();
				
			}
        	

    });
    
    jQuery('#property_details').on('click', function() {

    jQuery('#property_details').addClass('active');
    jQuery('#property_verification_details').removeClass('active');
    jQuery('#personal_details').removeClass('active');
    jQuery('#application_details').removeClass('active');
    jQuery('.property_verification_div').css('display', 'none');
    jQuery('.property_details_div').css('display', 'block');
    jQuery('.personal_details_div').css('display', 'none');
    jQuery('.application_div').css('display', 'none');

});
jQuery('#application_details').on('click', function() {

    jQuery('#application_details').addClass('active');
    jQuery('#property_verification_details').removeClass('active');
    jQuery('#property_details').removeClass('active');
    jQuery('#personal_details').removeClass('active');
    jQuery('.application_div').css('display', 'block');
    jQuery('.property_verification_div').css('display', 'none');
    jQuery('.property_details_div').css('display', 'none');
    jQuery('.personal_details_div').css('display', 'none');
    jQuery('.loader').css('display', 'none');

});
jQuery('#property_verification_details').on('click', function() {

    jQuery('#property_verification_details').addClass('active');
    jQuery('#property_details').removeClass('active');
    jQuery('#personal_details').removeClass('active');
    jQuery('#application_details').removeClass('active');
    jQuery('.property_verification_div').css('display', 'block');
    jQuery('.property_details_div').css('display', 'none');
    jQuery('.personal_details_div').css('display', 'none');
    jQuery('.loader').css('display', 'none');
    jQuery('.application_div').css('display', 'none');

});
jQuery('#personal_details').on('click', function() {

    jQuery('#personal_details').addClass('active');
    jQuery('#property_details').removeClass('active');
    jQuery('#property_verification_details').removeClass('active');
    jQuery('#application_details').removeClass('active');
    jQuery('.property_verification_div').css('display', 'none');
    jQuery('.property_details_div').css('display', 'none');
    jQuery('.personal_details_div').css('display', 'block');
    jQuery('.loader').css('display', 'none');
    jQuery('.application_div').css('display', 'none');

});
jQuery('.property_details_btn').on('click', function() {
    jQuery('.loader').css('display', 'block');

    jQuery('#property_verification_details').trigger('click');
});
jQuery('.property_verification_btn').on('click', function() {
    jQuery('.loader').css('display', 'block');

    jQuery('#application_details').trigger('click');
});
jQuery('.application_btn').on('click', function() {
    jQuery('.loader').css('display', 'block');

    jQuery('#personal_details').trigger('click');
});
initAutocomplete1();

jQuery("#LandlordState123").change(function() {

    var url = '<?php echo $this->baseUrl(); ?>' + '/user/index/getcitywithstateabbreviations';
    var state_abbr = jQuery('#LandlordState123').val();
    jQuery('#LandlordCity123').html('<option value="Loading">Loading...</option>');

    jQuery.ajax({
        url: url,
        data: "state_abbr=" + state_abbr,
        dataType: 'json',
        type: 'POST',
        success: function(data) {
           var i=1;
                    jQuery.each(data, function (i, item) {
                    jQuery('#LandlordCity123').append(jQuery('<option>', {
                        value: item.city,
                        text : item.city
                    }));
                    i=i+1;
						if(i==data.length){
							jQuery("#LandlordCity123 option[value='Loading']").remove();
							jQuery('#LandlordCity123').prepend('<option selected>Select City</option>');
						}
                });
        },
        error: function(e) {}
    });
});
var handleClick= 'ontouchstart' in document.documentElement ? 'touchstart': 'click';


jQuery('.btn_submit').on(handleClick, function() {
	jQuery('.btn_submit').css('display','none');
	jQuery('.property_btn_loader').css('display','block');
	
	var error       =  false;
    var oData       = new Object();
    var property_name   = oData.property_name =jQuery.trim(jQuery("#property_name").val());
    var prty_country     = oData.prty_country =jQuery.trim(jQuery("#country").val());
    var prty_state       = oData.prty_state =jQuery.trim(jQuery("#administrative_area_level_1").val());
    var prty_city        = oData.prty_city =jQuery.trim(jQuery("#locality").val());
    if(prty_city == ''){
         var prty_city     = oData.prty_city =jQuery.trim(jQuery("#sublocality_level_1").val());
    }
    var prty_county     =  oData.prty_county =jQuery.trim(jQuery("#sublocality_level_1").val());   
    var prty_neighborhood     =  oData.prty_neighborhood =jQuery.trim(jQuery("#neighborhood").val());
    var prty_street_address    = oData.prty_street_address =jQuery.trim(jQuery("#street_number").val());   
    
    var prty_zipcode    = oData.prty_zipcode =jQuery.trim(jQuery(".new_property_zip").val());  

    var prty_latitude    = oData.prty_latitude =jQuery.trim(jQuery("#latitude").val());
    var prty_longitude    = oData.prty_longitude =jQuery.trim(jQuery("#longitude").val());   
    var UnitNumber              = oData.UnitNumber =jQuery.trim(jQuery("#UnitNumber").val());
    var Street                  = oData.Street =jQuery.trim(jQuery("#Street").val());
    var Phone                   = oData.Phone =jQuery.trim(jQuery("#Phone").val());
    var PhoneExtension          = oData.PhoneExtension =jQuery.trim(jQuery("#PhoneExtension").val());
    var Classification          = oData.Classification =jQuery.trim(jQuery("#Classification").val());
    var IR                      = oData.IR =jQuery.trim(jQuery("#IR").val());
    var IncludeMedicalCollections     = oData.IncludeMedicalCollections =jQuery.trim(jQuery("#IncludeMedicalCollections").val());
    var DeclineForOpenBankruptcies    = oData.DeclineForOpenBankruptcies =jQuery.trim(jQuery("#DeclineForOpenBankruptcies").val());
    var OpenBankruptcyWindow          = oData.OpenBankruptcyWindow =jQuery.trim(jQuery("#OpenBankruptcyWindow").val());
    var IsFcraAgreementAccepted       = oData.IsFcraAgreementAccepted =jQuery.trim(jQuery("#IsFcraAgreementAccepted").val());
    var IncludeForeclosures           = oData.IncludeForeclosures =jQuery.trim(jQuery("#IncludeForeclosures").val());
    var LandlordStreetAddressLineOne           = oData.LandlordStreetAddressLineOne =jQuery.trim(jQuery("#LandlordStreetAddressLineOne").val());
    var LandlordStreetAddressLineTwo           = oData.LandlordStreetAddressLineTwo =jQuery.trim(jQuery("#LandlordStreetAddressLineTwo").val());
    var LandlordState                          = oData.LandlordState =jQuery.trim(jQuery("#LandlordState123").val());
    var LandlordCity                           = oData.LandlordCity =jQuery.trim(jQuery("#LandlordCity123").val());
    var LandlordZip                            = oData.LandlordZip =jQuery.trim(jQuery("#LandlordZip").val());
    var LandlordPhoneNumber                    = oData.LandlordPhoneNumber =jQuery.trim(jQuery("#LandlordPhoneNumber").val());
    var LandlordEmail                          = oData.LandlordEmail =jQuery.trim(jQuery("#LandlordEmail").val());
    var LandlordLastName                       = oData.LandlordLastName=jQuery.trim(jQuery("#LandlordLastName").val());

	var Deposit                = oData.Deposit      =  jQuery.trim(jQuery("#Deposit").val()); 
	var Rent                   = oData.Rent         =  jQuery.trim(jQuery("#Rent").val());  
	var LeaseTermInMonths      = oData.LeaseTermInMonths =   jQuery.trim(jQuery("#LeaseTermInMonths").val());  
	var LandlordPays           = oData.LandlordPays      =   jQuery.trim(jQuery("#LandlordPays").val());  
	var ProductBundle          = oData.ProductBundle     =   jQuery.trim(jQuery("#ProductBundle").val());
    
    
    var is_validated = true;   
    if(property_name =='' || prty_country =='' || prty_state =='' || prty_city =='' ||  UnitNumber =='' || Street =='' || Phone =='' || 
    PhoneExtension =='' || Classification =='' || IR =='' || IncludeMedicalCollections =='' || 
    IncludeForeclosures =='' || DeclineForOpenBankruptcies =='' ||  OpenBankruptcyWindow =='' || IsFcraAgreementAccepted =='' || 
    LandlordStreetAddressLineOne == '' || LandlordState =='' || LandlordCity =='' ||  LandlordZip =='' || LandlordPhoneNumber =='' ||
    Deposit == '' || Rent == ''|| LeaseTermInMonths == ''|| LandlordPays == ''|| ProductBundle == ''  ){
    
    if(property_name =='')     { jQuery('#property_name').css('border-color','#e62828');                            }       
    if(UnitNumber =='')               {     jQuery('#UnitNumber').css('border-color','#e62828');                    }
    if(Street =='')                   {     jQuery('#Street').css('border-color','#e62828');                        }
    if(Phone =='')                    {     jQuery('#Phone').css('border-color','#e62828');                         }
    if(PhoneExtension =='')           {     jQuery('#PhoneExtension').css('border-color','#e62828');                }
    if(prty_country =='')             {     jQuery('.new_property_autocomplete').css('border-color','#e62828');                       }
    if(prty_state =='')               {     jQuery('.new_property_autocomplete').css('border-color','#e62828');   }
    if(prty_city =='')                {     jQuery('.new_property_autocomplete').css('border-color','#e62828');                      }
    if(Classification =='')           {     jQuery('#Classification').css('border-color','#e62828');                }
    if(IR =='')                       {     jQuery('#IR').css('border-color','#e62828');                            }
    if(IncludeMedicalCollections ==''){    jQuery('#IncludeMedicalCollections').css('border-color','#e62828');      }
    if(IncludeForeclosures =='')      {     jQuery('#IncludeForeclosures').css('border-color','#e62828');           }
    if(DeclineForOpenBankruptcies ==''){     jQuery('#DeclineForOpenBankruptcies').css('border-color','#e62828');   }
    if(OpenBankruptcyWindow =='')      {     jQuery('#OpenBankruptcyWindow').css('border-color','#e62828');         }
    if(IsFcraAgreementAccepted =='')   {     jQuery('#IsFcraAgreementAccepted').css('border-color','#e62828');            }
    if(LandlordStreetAddressLineOne =='')   {     jQuery('#LandlordStreetAddressLineOne').css('border-color','#e62828');  }
    if(LandlordState =='')                  {     jQuery('#LandlordState123').css('border-color','#e62828');                  }
    if(LandlordCity =='')                   {     jQuery('#LandlordCity123').css('border-color','#e62828');                  }
    if(LandlordZip =='')                    {     jQuery('#LandlordZip').css('border-color','#e62828');                   }
    if(LandlordPhoneNumber =='')            {     jQuery('#LandlordPhoneNumber').css('border-color','#e62828');           }
    if(Deposit =='')                        {     jQuery('#Deposit').css('border-color','#e62828');                     }
    if(Rent =='')                           {     jQuery('#Rent').css('border-color','#e62828');                        }
    if(LeaseTermInMonths =='')              {     jQuery('#LeaseTermInMonths').css('border-color','#e62828');           }
    if(LandlordPays =='')                   {     jQuery('#LandlordPays').css('border-color','#e62828');                }
    if(ProductBundle =='')                  {     jQuery('#ProductBundle').css('border-color','#e62828');               }
    
    
    if(property_name == '' ||  UnitNumber == ''|| Street == ''
     || Phone == ''|| PhoneExtension == ''|| prty_country == ''|| prty_state == ''|| prty_city == ''){
		jQuery('#property_details').trigger( 'click' );		 
	 }
    else if(Classification == '' || IR == ''|| IncludeMedicalCollections == ''|| IncludeForeclosures == ''|| DeclineForOpenBankruptcies == ''|| 
    OpenBankruptcyWindow == ''|| IsFcraAgreementAccepted == '' ){
		jQuery('#property_verification_details').trigger( 'click' );		 
	 }
    else if(LandlordStreetAddressLineOne == '' || LandlordState == ''|| LandlordCity == ''|| LandlordZip == ''|| LandlordPhoneNumber == '' ){
		jQuery('#personal_details').trigger( 'click' );		 
	 }
    else if(Deposit == '' || Rent == ''|| LeaseTermInMonths == ''|| LandlordPays == ''|| ProductBundle == '' ){
		jQuery('#application_details').trigger( 'click' );		 
	 }

		 jQuery('.message').html('Please fill all fields');
		 is_validated = false; 
		 jQuery('.btn_submit').css('display','block');
	     jQuery('.property_btn_loader').css('display','none');
	
	}
	else{
		 is_validated = true;		
	} 
	
      //Zip validation     
    if(is_validated ==  true){		
		if(prty_zipcode != ''){
			jQuery(".message").text('');
		    if(/([0-9]{5})+$/.test(prty_zipcode)) {
			 jQuery(".property_zipcode").css('border-color','b2c6cd');
             is_validated =true;
			}
			else {
			 jQuery(".message").text('Zipcode should have exact 5 numeric values');
			 jQuery(".property_zipcode").css('border-color','dd1616');
			 jQuery('#property_details').trigger( 'click' );
			 is_validated =false;
			}
		}
    }
     if(is_validated ==  true){		
		if(LandlordZip != ''){
        jQuery(".message").text('');
         if(/([0-9]{5})+$/.test(LandlordZip)) {
         jQuery("#LandlordZip").css('border-color','b2c6cd');
         is_validated =true;
        }
        else {
          jQuery(".message").text('Zipcode should have exact 5 numeric values');
          jQuery("#LandlordZip").css('border-color','dd1616');
          jQuery('#personal_details').trigger( 'click' );
          is_validated =false;
        }
      }
	}
	if(is_validated ==  true){		
		if(OpenBankruptcyWindow !=''){
			OpenBankruptcyWindow = parseInt(OpenBankruptcyWindow);
			if((parseInt(OpenBankruptcyWindow) >=6)&&(parseInt(OpenBankruptcyWindow)<=120)){
				jQuery("#OpenBankruptcyWindow").css('border-color','b2c6cd');
				is_validated =true;
			}
			else{
				 is_validated =false;
				 jQuery(".message").text('Open Bankruptcy Window Value must be between 6 and 120');
				 jQuery("#OpenBankruptcyWindow").css('border-color','dd1616');
				 jQuery('#property_verification_details').trigger( 'click' );
			}
		}
    }
    if(is_validated ==  true){	
		if(Phone != ''){
		jQuery(".message").text('');
		if(/([0-9]{10,15})+$/.test(Phone)) {
			 jQuery("#Phone").css('border-color','b2c6cd');
			 is_validated =true;
			}
			else {
			 jQuery(".message").text('Phone can only contain numbers and must be between 10 and 15 characters in length');
			 jQuery("#Phone").css('border-color','dd1616');
			 jQuery('#property_details').trigger( 'click' );
			 is_validated =false;
			}
		}
    }
    if(is_validated ==  true){	
		if(LandlordPhoneNumber != ''){
			jQuery(".message").text('');
		if(/([0-9]{10,15})+$/.test(LandlordPhoneNumber)) {
			 jQuery("#LandlordPhoneNumber").css('border-color','b2c6cd');
             is_validated =true; 
			}
			else {
			 jQuery(".message").text('Phone can only contain numbers and must be between 10 and 15 characters in length');
			 jQuery("#LandlordPhoneNumber").css('border-color','dd1616');
			 jQuery('#personal_details').trigger( 'click' );
			 is_validated =false;
			}
		}
    }
     if(is_validated ==  true){	
		if(LandlordStreetAddressLineOne != ''){
        jQuery(".message").text('');
        if(/^(?=.*[0-9 ])(?=.*[a-zA-Z])([a-zA-Z0-9\s]+)$/.test(LandlordStreetAddressLineOne)) {
         jQuery("#LandlordStreetAddressLineOne").css('border-color','b2c6cd');
         is_validated =true; 
        }
        else {
         jQuery(".message").text('The Street Address field must contain at least one number and a letter');
         jQuery('#personal_details').trigger( 'click' );
         jQuery("#LandlordStreetAddressLineOne").css('border-color','dd1616');
         is_validated =false;
        }
      }		
	}
	 if(is_validated ==  true){
		if(Street != ''){
        jQuery(".message").text('');
        if(/^(?=.*[0-9 ])(?=.*[a-zA-Z])([a-zA-Z0-9\s]+)$/.test(Street)) {
		 is_validated =true; 
         jQuery("#Street").css('border-color','b2c6cd');
        }
        else {
         jQuery(".message").text('The Street Address field must contain at least one number and a letter');
         jQuery("#Street").css('border-color','dd1616');
         jQuery('#property_details').trigger( 'click' );
         is_validated =false;
        }
      }
	}
	if(is_validated ==  true){
		if(LandlordStreetAddressLineTwo !=''){
        jQuery(".message").text('');
                if(/^(?=.*[0-9 ])(?=.*[a-zA-Z])([a-zA-Z0-9\s]+)$/.test(LandlordStreetAddressLineTwo) == false){
                    jQuery(".message").text('The Street Address field must contain at least one number and a letter');
                    jQuery('#personal_details').trigger( 'click' );
                    jQuery("#LandlordStreetAddressLineTwo").css('border-color','dd1616');
                    var is_validated =false;
                }
                else{
					jQuery("#LandlordStreetAddressLineTwo").css('border-color','b2c6cd');
				}
            }
	}
	if(is_validated ==  true){
		if(LandlordLastName !=''){
        jQuery(".message").text('');
        if(LandlordLastName.length>=2 && LandlordLastName.length<=50) {
        jQuery("#LandlordLastName").css('border-color','b2c6cd');
        is_validated =true;
        }
        else {
         jQuery(".message").text('The field LastName can only contain letters and must be between 2 and 50 characters in length.');
         jQuery('#personal_details').trigger( 'click' );
         jQuery("#LandlordLastName").css('border-color','dd1616');
         is_validated =false;
        }
      }		
	}
	if(is_validated == true){
	    if(prty_country =='' || prty_state =='' || prty_city ==''){
            jQuery('.message').text('Location field should have country , state and city');
            jQuery('#property_details').trigger( 'click' );
            jQuery("#pac-input").css('border-color','dd1616');
            is_validated = false;
            }
            else{
				jQuery("#pac-input").css('border-color','b2c6cd');
			}
	}
	if(is_validated == true){
	  if(prty_zipcode == ''){	 
		 jQuery('.message').text('Please enter zipcode');
		 jQuery('#property_details').trigger( 'click' );
		 jQuery(".new_property_autocomplete").css('border-color','dd1616');
		 is_validated = false; 
	  }
    } 
    if(is_validated == true){ 
		
		jQuery('.property_div').css('display','none');
		jQuery('.smartmoveapiquestions_ans_div').css('display','block');
		
	}	
	else{
		jQuery('.btn_submit').css('display','block');
	    jQuery('.property_btn_loader').css('display','none');
	
	}
});

jQuery('.submit_questions').on(handleClick, function() {
	
	jQuery(".submit_questions_loader").css("display", "block");
    jQuery('.submit_questions').css('display','none');
	
	var oData       = new Object();	
    var property_name   = oData.property_name =jQuery.trim(jQuery("#property_name").val());
    var prty_country     = oData.prty_country =jQuery.trim(jQuery("#country").val());
    var prty_state       = oData.prty_state =jQuery.trim(jQuery("#administrative_area_level_1").val());
    var prty_city        = oData.prty_city =jQuery.trim(jQuery("#locality").val());
    if(prty_city == ''){
         var prty_city     = oData.prty_city =jQuery.trim(jQuery("#sublocality_level_1").val());
    }
    var prty_county     =  oData.prty_county =jQuery.trim(jQuery("#sublocality_level_1").val());   
    var prty_neighborhood     =  oData.prty_neighborhood =jQuery.trim(jQuery("#neighborhood").val());
    var prty_street_address    = oData.prty_street_address =jQuery.trim(jQuery("#street_number").val());      
    var prty_zipcode    = oData.prty_zipcode =jQuery.trim(jQuery(".new_property_zip").val());  
    var prty_latitude    = oData.prty_latitude =jQuery.trim(jQuery("#latitude").val());
    var prty_longitude    = oData.prty_longitude =jQuery.trim(jQuery("#longitude").val());   
    var UnitNumber              = oData.UnitNumber =jQuery.trim(jQuery("#UnitNumber").val());
    var Street                  = oData.Street =jQuery.trim(jQuery("#Street").val());
    var Phone                   = oData.Phone =jQuery.trim(jQuery("#Phone").val());
    var PhoneExtension          = oData.PhoneExtension =jQuery.trim(jQuery("#PhoneExtension").val());
    var Classification          = oData.Classification =jQuery.trim(jQuery("#Classification").val());
    var IR                      = oData.IR =jQuery.trim(jQuery("#IR").val());
    var IncludeMedicalCollections     = oData.IncludeMedicalCollections =jQuery.trim(jQuery("#IncludeMedicalCollections").val());
    var DeclineForOpenBankruptcies    = oData.DeclineForOpenBankruptcies =jQuery.trim(jQuery("#DeclineForOpenBankruptcies").val());
    var OpenBankruptcyWindow          = oData.OpenBankruptcyWindow =jQuery.trim(jQuery("#OpenBankruptcyWindow").val());
    var IsFcraAgreementAccepted       = oData.IsFcraAgreementAccepted =jQuery.trim(jQuery("#IsFcraAgreementAccepted").val());
    var IncludeForeclosures           = oData.IncludeForeclosures =jQuery.trim(jQuery("#IncludeForeclosures").val());
    var LandlordStreetAddressLineOne           = oData.LandlordStreetAddressLineOne =jQuery.trim(jQuery("#LandlordStreetAddressLineOne").val());
    var LandlordStreetAddressLineTwo           = oData.LandlordStreetAddressLineTwo =jQuery.trim(jQuery("#LandlordStreetAddressLineTwo").val());
    var LandlordState                          = oData.LandlordState =jQuery.trim(jQuery("#LandlordState123").val());
    var LandlordCity                           = oData.LandlordCity =jQuery.trim(jQuery("#LandlordCity123").val());
    var LandlordZip                            = oData.LandlordZip =jQuery.trim(jQuery("#LandlordZip").val());
    var LandlordPhoneNumber                    = oData.LandlordPhoneNumber =jQuery.trim(jQuery("#LandlordPhoneNumber").val());
    var LandlordEmail                          = oData.LandlordEmail =jQuery.trim(jQuery("#LandlordEmail").val());
    var LandlordLastName                       = oData.LandlordLastName=jQuery.trim(jQuery("#LandlordLastName").val());

	var Deposit                = oData.Deposit      =  jQuery.trim(jQuery("#Deposit").val()); 
	var Rent                   = oData.Rent         =  jQuery.trim(jQuery("#Rent").val());  
	var LeaseTermInMonths      = oData.LeaseTermInMonths =   jQuery.trim(jQuery("#LeaseTermInMonths").val());  
	var LandlordPays           = oData.LandlordPays      =   jQuery.trim(jQuery("#LandlordPays").val());  
	var ProductBundle          = oData.ProductBundle     =   jQuery.trim(jQuery("#ProductBundle").val());
    		
	    var q1Ans =   oData.q1Ans  =  jQuery("input:radio[name='question_1']:checked").val();
		var q2Ans =   oData.q2Ans = jQuery("input:radio[name='question_2']:checked").val();
		var q3Ans =   oData.q3Ans  = jQuery("input:radio[name='question_3']:checked").val();
		var q4Ans =   oData.q4Ans  = jQuery("input:radio[name='question_4']:checked").val();
		var q5Ans =   oData.q5Ans  = jQuery("input:radio[name='question_5']:checked").val();
		
		
		if(q1Ans == '' || q2Ans == '' || q3Ans == '' || q4Ans == '' || q5Ans ){          
		var formURL    = '<?php echo $this->baseUrl(); ?>' + '/user/index/savepropertyforbackgroundreport';	    
	    jQuery.ajax({
                        url : formURL,
                        type: "POST",
                        dataType: 'json',
                        data : oData,
                            success: function (returndata) {
                            if(returndata.status==true) {
                                 jQuery(".submit_questions_loader").css("display", "none"); 
                                 jQuery('.submit_questions').css('display','none');
		                         jQuery('.smartmoveapiquestions_ans_div').css('display','none');		
                                 jQuery(".screen_renters_div").css("display", "block"); 
                                 jQuery('.smartmovePid').val(returndata.smartmovePid);
                                 jQuery('.pid').val(returndata.pid);                                
                                 alert('Your property has been succesfully added');                             
                                      
                                // location.href = '<?php echo $this->baseUrl(); ?>' + '/admin/user/manage/transunion';    a               
                            }
                            else{
                                console.log(returndata.errors);
                                jQuery(".submit_questions_loader").css("display", "none");
                                jQuery('.submit_questions').css('display','block');
                            }
                            },
                            error: function(e){
                                jQuery(".submit_questions_loader").css("display", "none");
                                jQuery('.submit_questions').css('display','block');  }
                        });			
		}
		else{
	    jQuery(".submit_questions_loader").css("display", "none");
        jQuery('.submit_questions').css('display','block');		
		alert("Answer to all questions");
	} 

	
});
jQuery('.renter_task').on(handleClick, function() {

 jQuery('.newprofile-container-profilefields').css('display','none');
 jQuery('.newprofile-container-gallery').css('display','none');
 jQuery('.newprofile-container-documents').css('display','none');
 jQuery('.newprofile-container-rentertask').css('display','block');
});
jQuery('.landlord_task').on(handleClick, function() {

 jQuery('.newprofile-container-profilefields').css('display','none');
 jQuery('.newprofile-container-gallery').css('display','none');
 jQuery('.newprofile-container-documents').css('display','none');
 jQuery('.newprofile-container-rentertask').css('display','none');
 jQuery('.newprofile-container-landlordtask').css('display','block');
});
jQuery('.repairagent_task').on(handleClick, function() {

 jQuery('.newprofile-container-profilefields').css('display','none');
 jQuery('.newprofile-container-gallery').css('display','none');
 jQuery('.newprofile-container-documents').css('display','none');
 jQuery('.newprofile-container-rentertask').css('display','none');
 jQuery('.newprofile-container-landlordtask').css('display','none');
 jQuery('.newprofile-container-repairagenttask').css('display','block');
});
jQuery(document).ready(function(){
		// jQuery(function() {
		jQuery( ".schedule_date_text" ).datepicker({
		  dateFormat: 'yy-mm-dd',
		  minDate: 0
		});   
		//}); 
	});
</script>
