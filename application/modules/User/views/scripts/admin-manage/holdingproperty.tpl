<?php
$viewer= Engine_Api::_()->user()->getViewer();
$viewHelperObj  = $this->getHelper('SmartmoveApi');
$StateArray     = $viewHelperObj->getState();
$displayname  = $viewer->displayname;
$displaynameArray =explode(' ',$displayname);
        $landlordData                         = $this->PropertyData->landlordData;
        $landlordData                         = json_decode($landlordData); 
        $landlordData                         = json_decode(json_encode($landlordData),true);
?>
  <div class='tabs'>
    <div class="tabs">
    <ul class="navigation">
    <li>
        <a class="" href="/admin/user/manage/transunion">Manage Transunion</a>
    </li>
    <li  class="active">
        <a class="" href="/admin/user/manage/holdingproperty">Manage Holding Property</a>
    </li>
    <li >
        <a class="" href="/admin/user/manage/smartmoveapiquestions">Manage Smartmove Api Questions</a>
    </li>
     
</ul>  </div>
  </div>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAAWRDCCJZYbD17HwNNUMK-6DzyHziKhN8&libraries=places" async defer></script>
<script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/scripts/autocomplete_address_googleapi.js"></script>
<div class="holding+property_create_form">

<article class="padding_top_bottom20">
   <div class="maincontentdiv">
      <div class="generic_layout_container layout_core_container_tabs">
	  
         <div class="tabs_alt tabs_parent tabs">
            <ul id="main_tabs_navigation">
               <li><a id="property_details" href="javascript:void(0);" class="active">PROPERTY DETAILS</a></li>
               <li><a id="property_verification_details" href="javascript:void(0);">PROPERTY VERIFICATION DETAILS</a></li>
               <li><a id="application_details" href="javascript:void(0);">APPLICATION DETAILS</a></li>
               <li><a id="personal_details" href="javascript:void(0);">PERSONAL DETAILS</a></li>
              
            </ul>
         </div>
      </div>
      <article class="content_main_left">
         <div class="padding_bottom20" style="position: relative;">
            <div class="message" style='color:red;padding-bottom: 12px;'>All fields are mandatory</div>
            <div></div>
            <form id="property_entry_form" enctype="multipart/form-data">
               <div class="property_details_div">
                  <div class="pro_field_wrapper"><span class="prty_lablel pro_label">Property Name <span style="color:red;font-weight: bolder;">*</span></span>    <input name="property_name" type="text" maxlength="65" placeholder="Property Name" id="property_name" class="prty_field" value="<?php echo  $this->PropertyData->property_name?>"  autofocus></div>
                  <br>
                  <div class="pro_field_wrapper">
                     <div class="prty_lablel pro_label">Type of rental<span style="color:red;font-weight: bolder;">*</span></div>
                     <select name="rental_type" id="rental_type"  class="prty_field">
                        <option value="">Select rental type</option>
                        <option value="Rent">Rental</option>
                        <option value="Lease">Lease</option>
                     </select>
                  </div>
                  <br>
                  <div class="pro_field_wrapper">
                     <div class="prty_lablel pro_label">Type of housing<span style="color:red;font-weight: bolder;">*</span></div>
                     <select name="housing_type" id="housing_type"  class="prty_field">
                        <option value="">Select housing type</option>
                        <option value="Apartment">Apartment</option>
                        <option value="Room">Room</option>
                        <option value="House">House</option>
                        <!--<option value="Bedroom">Bedroom</option>-->
                     </select>
                  </div>
                  <br>
                  <div class="num_rooms" style="display:none;">
                     <div class="pro_field_wrapper">
                        <div class="prty_lablel pro_label">Number of bedrooms<span style="color:red;font-weight: bolder;">*</span></div>
                        <select name="add_property_number_of_rooms" id="add_property_number_of_rooms"  class="prty_field">
                           <option value="">Number of bedrooms</option>
                           <option value="1">1</option>
                           <option value="2">2</option>
                           <option value="3">3</option>
                           <option value="4">4</option>
                           <option value="4+">4+</option>
                        </select>
                     </div>
                     <br/> 
                  </div>
                  <div class="pro_field_wrapper">
                     <div class="prty_lablel pro_label">Rental prices (monthly)<span style="color:red;font-weight: bolder;">*</span></div>
                     <div class="price_valid"><span><input name="add_property_price" type="text" maxlength="65" placeholder="Price" id="add_property_price"  class="prty_field"></span></div>
                  </div>
                  <br>
                  <div class="pro_field_wrapper">
                     <div class="prty_lablel pro_label">Do you accept vouchers?<span style="color:red;font-weight: bolder;">*</span></div>
                     <select name="accept_vouchers" id="accept_vouchers"  class="prty_field">
                        <option value="">Select</option>
                        <option value="Yes">Yes</option>
                        <option value="No">No</option>
                     </select>
                  </div>
                  <br>
                  <div class="pro_field_wrapper">
                     <div class="prty_lablel pro_label">Is this property wheel chair accessible?<span style="color:red;font-weight: bolder;">*</span></div>
                     <select name="wheel_chair_accessible" id="wheel_chair_accessible"  class="prty_field">
                        <option value="">Select</option>
                        <option value="Yes">Yes</option>
                        <option value="No">No</option>
                     </select>
                  </div>
                  <br>
                  <div class="pro_field_wrapper">
                     <div class="prty_lablel pro_label">How many months deposits required?<span style="color:red;font-weight: bolder;">*</span></div>
                     <select name="months_of_deposits" id="months_of_deposits"  class="prty_field">
                        <option value="">Select</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                     </select>
                  </div>
                  <br>
                  <div class="pro_field_wrapper">
                     <div class="prty_lablel pro_label">Does this property have a property manager?<span style="color:red;font-weight: bolder;">*</span></div>
                     <select name="have_property_manager" id="have_property_manager"  class="prty_field">
                        <option value="">Select</option>
                        <option value="Yes">Yes</option>
                        <option value="No">No</option>
                     </select>
                  </div>
                  <br>
                  <div class="pro_field_wrapper">
                     <div class="prty_lablel pro_label">Does this property provide onsite or off site parking?<span style="color:red;font-weight: bolder;">*</span></div>
                     <select name="parking" id="parking"  class="prty_field">
                        <option value="">Select</option>
                        <option value="Yes">Yes</option>
                        <option value="No">No</option>
                     </select>
                  </div>
                  <br>
                  <div class="pro_field_wrapper">
                     <div class="prty_lablel pro_label">Pets Allowed<span style="color:red;font-weight: bolder;">*</span></div>
                     <select name="allowed_pets" id="allowed_pets"  class="prty_field" onchange="petsType()">
                        <option value="">Select</option>
                        <option value="Yes">Yes</option>
                        <option value="No">No</option>
                     </select>
                  </div>
                  <br>
                  <div class="pets_type_wrapper" style="display:none">
                     <div class="pro_field_wrapper">
                        <div class="prty_lablel pro_label">What kind of pets ?<span style="color:red;font-weight: bolder;">*</span></div>
                        <select name="pets_type" id="property_add_pets_type"  class="prty_field">
                           <option value="">Select pets type</option>
                           <option value="Cats">Cats</option>
                           <option value="Dogs">Dogs</option>
                           <option value="Cats & Dogs">Cats & Dogs</option>
                           <option value="Birds">Birds</option>
                           <option value="Small pets">Small pets</option>
                        </select>
                     </div>
                     <br>
                  </div>
                  <div class="pro_field_wrapper"><span class="prty_lablel pro_label">UnitNumber <span style="color:red;font-weight: bolder;">*</span></span>    <input name="UnitNumber" type="text" maxlength="50" placeholder="UnitNumber" id="UnitNumber" class="prty_field" ></div>
                  <br>
                  <div class="pro_field_wrapper"><span class="prty_lablel pro_label">Street Address <span style="color:red;font-weight: bolder;">*</span></span>    <input name="Street" type="text" maxlength="65" placeholder="Street" id="Street" class="prty_field" ></div>
                  <br>
                  <div class="pro_field_wrapper"><span class="prty_lablel pro_label">Phone<span style="color:red;font-weight: bolder;">*</span> </span>    <input name="Phone" type="text" maxlength="15" placeholder="Phone" id="Phone" class="prty_field" ></div>
                  <br>
                  <div class="pro_field_wrapper"><span class="prty_lablel pro_label">Phone Extension <span style="color:red;font-weight: bolder;">*</span></span>    <input name="PhoneExtension" type="text" maxlength="6" placeholder="Phone Extension" id="PhoneExtension" class="prty_field" ></div>
                  <br>
                  <div class="pro_field_wrapper"><span class="location_text_span" style="font-weight: bold;">Location <span style="color:red;font-weight: bolder;">*</span></span> <input id="pac-input1" class="controls1" type="text" style="font-weight:bold;" placeholder="Location" value="<?php echo $this->PropertyData->prty_city ."," .$this->PropertyData->prty_state .",".$this->PropertyData->prty_country; ?>"></div>
					<div id="map" style="height: 200px;margin-bottom: 17px;margin-top: 13px;"></div>
					<div class="map_fields">
					   <input type= "hidden" placeholder="Street_number" class="field" id="street_number"></input>
					   <input  type= "hidden" class="field" id="route"></input>
					   <input type= "text" placeholder="Neighborhood" class="field input-box" id="neighborhood" value="<?php echo $this->PropertyData->prty_neighborhood ;?>" readonly></input>
					   <input type= "text" placeholder="City" class="field input-box input-box" id="locality" value="<?php echo $this->PropertyData->prty_city ; ?>"></input>
					   <input type= "hidden" placeholder="Sublocality county" class="field" id="sublocality_level_1"></input>
					   <input type= "text" placeholder="State" class="field input-box" id="administrative_area_level_1" value="<?php echo $this->PropertyData->prty_state ;?>" ></input>                          
					   <input type= "text" placeholder="Country" class="field input-box" id="country" value="<?php echo $this->PropertyData->prty_country ;?>"></input>
					   <input type= "text" placeholder="Zipcode" class="field property_zipcode input-box" id="postal_code" value="<?php echo $this->PropertyData->zip ;?>"></input>
					   <input type= "hidden" class="field" id="latitude"></input>
					   <input type= "hidden" class="field" id="longitude"></input>
					</div>
                  <div class="prty_lablel pro_label des">Description <span style="color:red;font-weight: bolder;">*</span></div>
                  <div class="dis" style="margin-top: 41px;">
                     <div class="dis_textarea_span"><textarea name="description" cols="5" rows="8" id="description"  class="prty_field tinyMCE" ><?php echo $this->PropertyData->description; ?></textarea></div>
                  </div>
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
                  <select name="Classification" id="Classification"  class="prty_field">
                     <option value="Conventional">Conventional</option>
                     <option value="Subsidized">Subsidized</option>
                  </select>
               </div>
               <br>
               <div class="pro_field_wrapper"><span class="prty_lablel pro_label">Income To Rent<span style="color:red;font-weight: bolder;">*</span> </span>    <input name="IR" type="text" maxlength="65" placeholder="IR" id="IR" class="prty_field"></div>
               <br>
               <div class="pro_field_wrapper">
                  <div class="prty_lablel pro_label">Include Medical Collections<span style="color:red;font-weight: bolder;">*</span></div>
                  <select name="IncludeMedicalCollections" id="IncludeMedicalCollections"  class="prty_field">
                     <option value="true">Yes</option>
                     <option value="false">No</option>
                  </select>
               </div>
               <br>
               <div class="pro_field_wrapper">
                  <div class="prty_lablel pro_label">Include Fore closures<span style="color:red;font-weight: bolder;">*</span></div>
                  <select name="IncludeForeclosures" id="IncludeForeclosures"  class="prty_field">
                     <option value="true">Yes</option>
                     <option value="false">No</option>
                  </select>
               </div>
               <br>
               <div class="pro_field_wrapper">
                  <div class="prty_lablel pro_label">Decline For Open Bankruptcies<span style="color:red;font-weight: bolder;">*</span></div>
                  <select name="DeclineForOpenBankruptcies" id="DeclineForOpenBankruptcies"  class="prty_field">
                     <option value="true">Yes</option>
                     <option value="false">No</option>
                  </select>
               </div>
               <br>
               <div class="pro_field_wrapper"><span class="prty_lablel pro_label">Open Bankruptcy Window <span style="color:red;font-weight: bolder;">*</span></span>    <input name="OpenBankruptcyWindow" type="text" maxlength="65" placeholder="6-120" id="OpenBankruptcyWindow" class="prty_field" ></div>
               <br>
               <div class="pro_field_wrapper fcra">
                  <div class="prty_lablel pro_label"><a href="javascript:void(0)" target="_blank">Fcra Agreement Accepted<span style="color:red;font-weight: bolder;">*</span></a></div>
                  <select name="IsFcraAgreementAccepted" id="IsFcraAgreementAccepted"  class="prty_field">
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
				 <input name="Deposit" type="text" maxlength="10" placeholder="Deposit" id="Deposit" class="prty_field">
			  </div>
               <br>
				 <div class="pro_field_wrapper">
						 <span class="prty_lablel pro_label">Rent <span style="color:red">*</span></span> </span>    
						 <input name="Rent" type="text" maxlength="10" placeholder="Rent" id="Rent" class="prty_field">
			    </div>              
				 <br>
              <div class="pro_field_wrapper">
				 <span class="prty_lablel pro_label">Lease Term In Months <span style="color:red">*</span></span> </span>    
				 <input name="LeaseTermInMonths" type="text" maxlength="2" placeholder="6-12" id="LeaseTermInMonths" class="prty_field" >
			  </div>
               <br>
                <div class="pro_field_wrapper">
				 <span class="prty_lablel pro_label">Landlord Pays </span>    
				 <select name="LandlordPays" id="LandlordPays"  class="prty_field">
					<option value="true">Yes</option>
					<option value="false">No</option>
				 </select>
			  </div>
               <br>
                <div class="pro_field_wrapper">
				 <span class="prty_lablel pro_label">Product Bundle </span>  
				 <select name="ProductBundle" id="ProductBundle"  class="prty_field">
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
               <div class="pro_field_wrapper"><span class="prty_lablel pro_label">First Name <span style="color:red;font-weight: bolder;">*</span></span>    <input name="LandlordFirstName" type="text" maxlength="65" placeholder="" id="LandlordFirstName" class="prty_field" value="<?php echo $displaynameArray[0]?>" readonly></div>
               <br>
               <div class="pro_field_wrapper"><span class="prty_lablel pro_label">Last Name<span style="color:red;font-weight: bolder;">*</span> </span>    <input name="LandlordLastName" type="text" maxlength="65" placeholder="" id="LandlordLastName" class="prty_field"  value="<?php echo $displaynameArray[1]?>" ></div>
               <br>
               <div class="pro_field_wrapper"><span class="prty_lablel pro_label">Street Address Line One<span style="color:red;font-weight: bolder;">*</span> </span>    <input name="LandlordStreetAddressLineOne" type="text" maxlength="65" placeholder="" id="LandlordStreetAddressLineOne" class="prty_field" ></div>
               <br>
               <div class="pro_field_wrapper"><span class="prty_lablel pro_label">Street Address Line Two</span>    <input name="LandlordStreetAddressLineTwo" type="text" maxlength="65" placeholder="" id="LandlordStreetAddressLineTwo" class="prty_field" ></div>
               <br>
               <div class="pro_field_wrapper">
                  <span class="prty_lablel pro_label">State <span style="color:red;font-weight: bolder;">*</span><span style="color:red"></span></span>
                  <select name="LandlordState" id="LandlordState"  class="prty_field">
                     <option value="">Select</option>
                     <?php foreach($StateArray as $key =>$value):?>
                     <option value="<?php echo $key;?>"><?php echo $value;?></option>
                     <?php endforeach;?>
                  </select>
               </div>
               <br>
               <div class="pro_field_wrapper">
                  <span class="prty_lablel pro_label">City <span style="color:red;font-weight: bolder;">*</span><span style="color:red"></span></span>
                  <select name="LandlordCity" id="LandlordCity"  class="prty_field" maxlength="50">
					  <?php if($landlordData['City'] == ''): ?>
                     <option value="">Select</option>
                     <?php else: ?>
                     <option value="<?php echo $landlordData['City']; ?>"><?php echo $landlordData['City']; ?></option>
                     <?php endif;?>
                  </select>
               </div>
               <br>
               <div class="pro_field_wrapper"><span class="prty_lablel pro_label">Zip<span style="color:red;font-weight: bolder;">*</span></span>    <input name="LandlordZip" type="text" maxlength="5" placeholder="" id="LandlordZip" class="prty_field" ></div>
               <br>
               <div class="pro_field_wrapper"><span class="prty_lablel pro_label">PhoneNumber<span style="color:red;font-weight: bolder;">*</span></span>    <input name="LandlordPhoneNumber" type="text" maxlength="15" placeholder="" id="LandlordPhoneNumber" class="prty_field" ></div>
               <br>
               <div class="pro_field_wrapper"><span class="prty_lablel pro_label">Email<span style="color:red;font-weight: bolder;">*</span></span>    <input name="LandlordEmail" type="text" maxlength="65" placeholder="" id="LandlordEmail" class="prty_field" value="<?php echo $viewer->email;?>" readonly></div>
               <br>
               <div class="loader" style="display:none;"></div>
               <div class="padding_top_bottom submit_btn " >
                  <input class="but_submit property_btn" type="button" value="Submit" name="">
               </div>
              
            </div>
            <!--personal_details_div end -->
            </form>
         </div>
      </article>
   </div>
   <div class="clear"></div>
</article>

  </div>
<script>

var latitude  = 40.712784;
var longitude = -74.005941;
jQuery(document).ready(function(){

initAutocomplete();

});
var handleClick= 'ontouchstart' in document.documentElement ? 'touchstart': 'click';
</script>
<script src='//cdn.tinymce.com/4/tinymce.min.js'></script>

<script type="text/javascript">
	var propertyCount = '<?php echo count($this->PropertyData)?>'; 
    var UnitNumber =  '<?php echo $this->PropertyData->UnitNumber?>';
    var Street =  '<?php echo $this->PropertyData->Street?>';
    var Zip =  '<?php echo $this->PropertyData->Zip?>';
    var Phone =  '<?php echo $this->PropertyData->Phone?>';
    var PhoneExtension =  '<?php echo $this->PropertyData->PhoneExtension?>';
    var Classification =  '<?php echo $this->PropertyData->Classification?>';
    var IR =  '<?php echo $this->PropertyData->IR?>';
    var IncludeMedicalCollections =  '<?php echo $this->PropertyData->IncludeMedicalCollections?>';
    var IncludeForeclosures =  '<?php echo $this->PropertyData->IncludeForeclosures?>';
    var DeclineForOpenBankruptcies =  '<?php echo $this->PropertyData->DeclineForOpenBankruptcies?>';
    var OpenBankruptcyWindow =  '<?php echo $this->PropertyData->OpenBankruptcyWindow?>';
    var IsFcraAgreementAccepted =  '<?php echo $this->PropertyData->IsFcraAgreementAccepted?>';
    var LandlordStreetAddressLineOne =  '<?php echo $landlordData['StreetAddressLineOne']?>';
    var LandlordStreetAddressLineTwo =  '<?php echo $landlordData['StreetAddressLineTwo']?>';
    var LandlordState =  '<?php echo $landlordData['State']?>';
    var LandlordCity  =  '<?php echo $landlordData['City']?>';
    var LandlordZip  =  '<?php echo $landlordData['Zip']?>';
    var LandlordPhoneNumber  =  '<?php echo $landlordData['PhoneNumber']?>'; 	
	
	var accept_vouchers =  '<?php echo $this->PropertyData->vouchers?>';
    var wheel_chair_accessible =  '<?php echo $this->PropertyData->wheelchair_accessible?>';
    var months_of_deposits =  '<?php echo $this->PropertyData->months_of_deposits?>';
    var have_property_manager =  '<?php echo $this->PropertyData->property_manager?>';
    var parking =  '<?php echo $this->PropertyData->provide_parking?>';
	
	jQuery('#UnitNumber').val(UnitNumber);
    jQuery('#Street').val(Street);
    jQuery('#Zip').val(Zip);
    jQuery('#Phone').val(Phone);
    jQuery('#PhoneExtension').val(PhoneExtension);
    jQuery('#Classification').val(Classification);
    jQuery('#IR').val(IR);

    jQuery('#LandlordStreetAddressLineOne').val(LandlordStreetAddressLineOne);
    jQuery('#LandlordStreetAddressLineTwo').val(LandlordStreetAddressLineTwo);
    jQuery('#LandlordState').val(LandlordState);
    jQuery('#LandlordCity').val(LandlordCity);
    jQuery('#LandlordZip').val(LandlordZip);
    jQuery('#LandlordPhoneNumber').val(LandlordPhoneNumber);
    
    jQuery('#accept_vouchers').val(accept_vouchers);
    jQuery('#wheel_chair_accessible').val(wheel_chair_accessible);
    jQuery('#months_of_deposits').val(months_of_deposits);
    jQuery('#have_property_manager').val(have_property_manager);
    jQuery('#parking').val(parking);
	
	if(IncludeMedicalCollections == 1){
        jQuery('#IncludeMedicalCollections').val('true');
    }else{

        jQuery('#IncludeMedicalCollections').val('false');
    }
    if(IncludeForeclosures == 1){
        jQuery('#IncludeForeclosures').val('true');
    }else{

        jQuery('#IncludeForeclosures').val('false');
    }
    if(DeclineForOpenBankruptcies == 1){
        jQuery('#DeclineForOpenBankruptcies').val('true');
    }else{

        jQuery('#DeclineForOpenBankruptcies').val('false');
    }
    if(IsFcraAgreementAccepted == 1){
        jQuery('#IsFcraAgreementAccepted').val('true');
    }else{

        jQuery('#IsFcraAgreementAccepted').val('false');
    }


    jQuery('#OpenBankruptcyWindow').val(OpenBankruptcyWindow);
    
     jQuery("#allowed_pets").val('<?php echo $this->PropertyData->has_pets?>');
     jQuery("#property_add_pets_type").val('<?php echo $this->PropertyData->pets_type?>');
     jQuery("#rental_type").val('<?php echo $this->PropertyData->rental_type?>');
     jQuery("#housing_type").val('<?php echo $this->PropertyData->housing_type?>');
     jQuery("#add_property_number_of_rooms").val('<?php echo $this->PropertyData->no_of_rooms?>');
     jQuery("#add_property_price").val('<?php echo $this->PropertyData->price?>');
	
	 jQuery("#Deposit").val('<?php echo $this->PropertyData->Deposit?>');
	 jQuery("#Rent").val('<?php echo $this->PropertyData->Rent?>');
	 jQuery("#LeaseTermInMonths").val('<?php echo $this->PropertyData->LeaseTermInMonths?>');
	 jQuery("#LandlordPays").val('<?php echo $this->PropertyData->LandlordPays?>');
	 jQuery("#ProductBundle").val('<?php echo $this->PropertyData->ProductBundle?>');

tinymce.init({
    selector: '#description',
    setup: function(editor) {
        editor.on('keyup', function(e) {

            jQuery('.des_length').text('');
            jQuery(".des_length").remove();
            var description = tinymce.get('description').getContent();

            descripltion_plain_text = jQuery(description).text();

            var des_length = descripltion_plain_text.length;
            jQuery('.dis_textarea_span').append('<div class="des_length">' + des_length + ' / 10000 characters</div>');

        });

        editor.on('init', function() {});
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
jQuery("#LandlordState").change(function() {

    var url = '<?php echo $this->baseUrl(); ?>' + '/user/index/getcitywithstateabbreviations';
    var state_abbr = jQuery('#LandlordState').val();
    jQuery('#LandlordCity').html('');
    jQuery.ajax({
        url: url,
        data: "state_abbr=" + state_abbr,
        dataType: 'json',
        type: 'POST',
        success: function(data) {
            console.log(data);
            jQuery('#LandlordCity').append('<option value="">Select</option>');
            jQuery.each(data, function(i, item) {
                jQuery('#LandlordCity').append(jQuery('<option>', {
                    value: item.city,
                    text: item.city
                }));
            });
        },
        error: function(e) {}
    });
});
function petsType() {

    var hasPet = jQuery('#allowed_pets').val();
    jQuery('#property_add_pets_type').val('');
    if (hasPet == 'Yes') {
        jQuery('.pets_type_wrapper').css('display', 'block');
    } else {
        jQuery('.pets_type_wrapper').css('display', 'none');
    }
}

jQuery("#housing_type").change(function() {

    var housing_type = jQuery("#housing_type").val();
    if (housing_type != '') {
        jQuery(".num_rooms").css('display', 'block')
    } else {
        jQuery(".num_rooms").css('display', 'none')
    }

});

jQuery('.but_submit').on(handleClick, function() {
	
	var error       =  false;
    var oData       = new Object();
    var property_id     = oData.property_id =  '<?php echo $this->PropertyData->id?>';
    var property_name   = oData.property_name =jQuery.trim(jQuery("#property_name").val());
    var rental_type     = oData.rental_type =jQuery.trim(jQuery("#rental_type").val());
    var price           = oData.price =jQuery.trim(jQuery("#add_property_price").val());
    var description     = oData.description = tinymce.get('description').getContent();
    var des             =  tinymce.get('description').getContent({format: 'text'}).replace(/^\s+/g, '');
    var number_of_rooms     = oData.number_of_rooms =jQuery.trim(jQuery("#add_property_number_of_rooms").val());
    var housing_type     = oData.housing_type =jQuery.trim(jQuery("#housing_type").val());
    var allowed_pets     = oData.allowed_pets = jQuery.trim(jQuery("#allowed_pets").val());
    var pets_type        = oData.pets_type =jQuery.trim(jQuery("#property_add_pets_type").val());
    var prty_country     = oData.prty_country =jQuery.trim(jQuery("#country").val());
    var prty_state       = oData.prty_state =jQuery.trim(jQuery("#administrative_area_level_1").val());
    var prty_city        = oData.prty_city =jQuery.trim(jQuery("#locality").val());
    if(prty_city == ''){
         var prty_city     = oData.prty_city =jQuery.trim(jQuery("#sublocality_level_1").val());
    }
    var prty_county     =  oData.prty_county =jQuery.trim(jQuery("#sublocality_level_1").val());   
    var prty_neighborhood     =  oData.prty_neighborhood =jQuery.trim(jQuery("#neighborhood").val());
    var prty_street_address    = oData.prty_street_address =jQuery.trim(jQuery("#street_number").val());   
    
    var prty_zipcode    = oData.prty_zipcode =jQuery.trim(jQuery(".property_zipcode").val());  

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
    var LandlordState                          = oData.LandlordState =jQuery.trim(jQuery("#LandlordState").val());
    var LandlordCity                           = oData.LandlordCity =jQuery.trim(jQuery("#LandlordCity").val());
    var LandlordZip                            = oData.LandlordZip =jQuery.trim(jQuery("#LandlordZip").val());
    var LandlordPhoneNumber                    = oData.LandlordPhoneNumber =jQuery.trim(jQuery("#LandlordPhoneNumber").val());
    var LandlordEmail                          = oData.LandlordEmail =jQuery.trim(jQuery("#LandlordEmail").val());
    var accept_vouchers                        = oData.accept_vouchers=jQuery.trim(jQuery("#accept_vouchers").val());
    var wheel_chair_accessible                 = oData.wheel_chair_accessible=jQuery.trim(jQuery("#wheel_chair_accessible").val());
    var months_of_deposits                     = oData.months_of_deposits=jQuery.trim(jQuery("#months_of_deposits").val());
    var have_property_manager                  = oData.have_property_manager=jQuery.trim(jQuery("#have_property_manager").val());
    var parking                                = oData.parking=jQuery.trim(jQuery("#parking").val());
    var LandlordLastName                       = oData.LandlordLastName=jQuery.trim(jQuery("#LandlordLastName").val());

	var Deposit                = oData.Deposit      =  jQuery.trim(jQuery("#Deposit").val()); 
	var Rent                   = oData.Rent         =  jQuery.trim(jQuery("#Rent").val());  
	var LeaseTermInMonths      = oData.LeaseTermInMonths =   jQuery.trim(jQuery("#LeaseTermInMonths").val());  
	var LandlordPays           = oData.LandlordPays      =   jQuery.trim(jQuery("#LandlordPays").val());  
	var ProductBundle          = oData.ProductBundle     =   jQuery.trim(jQuery("#ProductBundle").val());
    
    
    var is_validated = true;   
    
    if(property_name =='' || prty_country =='' || prty_state =='' || prty_city =='' || rental_type =='' || price =='' || description =='' || 
    housing_type =='' || allowed_pets == '' ||  number_of_rooms =='' || 
    UnitNumber =='' || Street =='' || Phone =='' || PhoneExtension =='' || Classification =='' || IR =='' || IncludeMedicalCollections =='' || 
    IncludeForeclosures =='' || DeclineForOpenBankruptcies =='' ||  OpenBankruptcyWindow =='' || IsFcraAgreementAccepted =='' || 
    LandlordStreetAddressLineOne == '' || LandlordState =='' || LandlordCity =='' ||  LandlordZip =='' || LandlordPhoneNumber =='' || accept_vouchers =='' ||
    wheel_chair_accessible =='' || months_of_deposits =='' || have_property_manager ==''|| parking =='' ||
    Deposit == '' || Rent == ''|| LeaseTermInMonths == ''|| LandlordPays == ''|| ProductBundle == ''  ){
    
    if(property_name =='')     { jQuery('#property_name').css('border-color','#e62828');                            }       
    if(rental_type =='')       { jQuery('#rental_type').css('border-color','#e62828');                              }
    if(housing_type =='')      { jQuery('#housing_type').css('border-color','#e62828');                             }
    if(price =='')             { jQuery('#add_property_price').css('border-color','#e62828');                       }
    if(accept_vouchers =='')   { jQuery('#accept_vouchers').css('border-color','#e62828');                          }
    if(wheel_chair_accessible =='')   {     jQuery('#wheel_chair_accessible').css('border-color','#e62828');        }
    if(months_of_deposits =='')       {     jQuery('#months_of_deposits').css('border-color','#e62828');            }
    if(have_property_manager =='')    {     jQuery('#have_property_manager').css('border-color','#e62828');         }
    if(parking =='')                  {     jQuery('#parking').css('border-color','#e62828');                       }
    if(allowed_pets =='')             {     jQuery('#allowed_pets').css('border-color','#e62828');                  }
    if(UnitNumber =='')               {     jQuery('#UnitNumber').css('border-color','#e62828');                    }
    if(Street =='')                   {     jQuery('#Street').css('border-color','#e62828');                        }
    if(Phone =='')                    {     jQuery('#Phone').css('border-color','#e62828');                         }
    if(PhoneExtension =='')           {     jQuery('#PhoneExtension').css('border-color','#e62828');                }
    if(prty_country =='')             {     jQuery('#country').css('border-color','#e62828');                       }
    if(prty_state =='')               {     jQuery('#administrative_area_level_1').css('border-color','#e62828');   }
    if(prty_city =='')                {     jQuery('#locality').css('border-color','#e62828');                      }
    if(description =='')              {    jQuery('.mce-tinymce').css('border-color','#e62828');                    }
    if(Classification =='')           {     jQuery('#Classification').css('border-color','#e62828');                }
    if(IR =='')                       {     jQuery('#IR').css('border-color','#e62828');                            }
    if(IncludeMedicalCollections ==''){    jQuery('#IncludeMedicalCollections').css('border-color','#e62828');      }
    if(IncludeForeclosures =='')      {     jQuery('#IncludeForeclosures').css('border-color','#e62828');           }
    if(DeclineForOpenBankruptcies ==''){     jQuery('#DeclineForOpenBankruptcies').css('border-color','#e62828');   }
    if(OpenBankruptcyWindow =='')      {     jQuery('#OpenBankruptcyWindow').css('border-color','#e62828');         }
    if(IsFcraAgreementAccepted =='')   {     jQuery('#IsFcraAgreementAccepted').css('border-color','#e62828');            }
    if(LandlordStreetAddressLineOne =='')   {     jQuery('#LandlordStreetAddressLineOne').css('border-color','#e62828');  }
    if(LandlordState =='')                  {     jQuery('#LandlordState').css('border-color','#e62828');                  }
    if(LandlordCity =='')                   {     jQuery('#LandlordCity').css('border-color','#e62828');                  }
    if(LandlordZip =='')                    {     jQuery('#LandlordZip').css('border-color','#e62828');                   }
    if(LandlordPhoneNumber =='')            {     jQuery('#LandlordPhoneNumber').css('border-color','#e62828');           }
    if(Deposit =='')                        {     jQuery('#Deposit').css('border-color','#e62828');                     }
    if(Rent =='')                           {     jQuery('#Rent').css('border-color','#e62828');                        }
    if(LeaseTermInMonths =='')              {     jQuery('#LeaseTermInMonths').css('border-color','#e62828');           }
    if(LandlordPays =='')                   {     jQuery('#LandlordPays').css('border-color','#e62828');                }
    if(ProductBundle =='')                  {     jQuery('#ProductBundle').css('border-color','#e62828');               }
    
    
    if(property_name == '' || rental_type == ''|| housing_type == ''|| price == ''|| accept_vouchers == ''|| wheel_chair_accessible == ''||
     months_of_deposits == '' || have_property_manager == ''|| parking == ''|| allowed_pets == ''|| UnitNumber == ''|| Street == ''
     || Phone == ''|| PhoneExtension == ''|| prty_country == ''|| prty_state == ''|| prty_city == ''|| description == ''){
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
	}
	else{
		 is_validated = true;		
	} 
    if(is_validated ==  true){
    var regex   =   /^[0-9]*$/;
    var price = jQuery('#add_property_price').val();    
    if( !regex.test(price) ) {
         jQuery(".price_validation").html("");
         jQuery(".price_valid").append("<div class='price_validation' style='color:red;margin-left:240px;font-weight: normal;'>Numbers Only</div>");
         jQuery('#add_property_price').css('border-color','#dd1616');
         is_validated = false;
         jQuery('#property_details').trigger( 'click' );
    }
    else{
		jQuery('#add_property_price').css('border-color','#b2c6cd');
        is_validated = true;
    }
	}
	if(is_validated ==  true){
	descripltion_plain_text = jQuery(description).text();

    if(descripltion_plain_text !=''){
            jQuery( ".discription_validation" ).remove();
            if(descripltion_plain_text.length < 100 || des.length < 100){
            jQuery(".dis").append("<div class='discription_validation' style='color:red;margin-left:240px;font-weight: normal;'>Description should have atleast 100 characters</div>");
            is_validated = false;
            jQuery('#property_details').trigger( 'click' );
            }
            else if (descripltion_plain_text.length >10000 || des.length > 10000){
            is_validated = false;
            jQuery('#property_details').trigger( 'click' );
            }
            else{
                is_validated = true;
            }
    }
		
	}
	if(is_validated ==  true){		
		if(housing_type == 'Bedroom' && number_of_rooms =='' ){
        is_validated = false;
        jQuery('#property_details').trigger( 'click' );
        jQuery('#add_property_number_of_rooms').css('border-color','#dd1616');
        }
        else{
		jQuery('#add_property_number_of_rooms').css('border-color','#b2c6cd');	
		}		
	}
	if(is_validated ==  true){	
		if(allowed_pets == 'Yes' && pets_type =='' ){
			is_validated = false;
			jQuery('#property_details').trigger( 'click' );
			jQuery('#property_add_pets_type').css('border-color','#dd1616');
		}
		else{
			jQuery('#property_add_pets_type').css('border-color','#b2c6cd');
		}
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
		 jQuery("#postal_code").css('border-color','dd1616');
		 is_validated = false; 
	  }
    } 
    if(is_validated == true){ 
		jQuery('.but_submit').css('display','none');
        jQuery(".loader").css("display", "block");
        if(propertyCount == 0){     
		var formURL    = '<?php echo $this->baseUrl(); ?>' + '/admin/user/manage/saveholdingproperty';
	    }
	    else{		
		var formURL    = '<?php echo $this->baseUrl(); ?>' + '/admin/user/manage/saveedittedholdingproperty';
	    }
		jQuery.ajax( {
                        url : formURL,
                        type: "POST",
                        dataType: 'json',
                        data : oData,
                            success: function (returndata) {
                            if(returndata.status==true) {
                                 jQuery(".loader").css("display", "none");                                                                               
                                 //alert('Your property has been succesfully added');                             
                                      
                                 location.href = '<?php echo $this->baseUrl(); ?>' + '/admin/user/manage/transunion';    a               
                            }
                            else{
                                console.log(returndata.errors);
                                jQuery(".loader").css("display", "none");
                                jQuery('.but_submit').css('display','block');
                            }
                            },
                            error: function(e){
                           jQuery(".loader").css("display", "none");
                           jQuery('.but_submit').css('display','block');  }

                        });
	}	
});
</script>
