<script src="/application/modules/User/externals/scripts/message_notififaction.js"></script>
<script>
<?php $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); 

$viewHelperObj  = $this->getHelper('SmartmoveApi');
$StateArray     = $viewHelperObj->getState();

$viewer     = Engine_Api::_()->user()->getViewer();
$displayname  = $viewer->displayname;
$displaynameArray =explode(' ',$displayname);?>

var viewer_identity='<?php echo $viwer_id; ?>';	
</script>
<div class="generic_layout_container layout_main">



<div class="generic_layout_container layout_middle">
	
	<div class="property_list_content">
		
		<div class="generic_layout_container layout_core_container_tabs">
	<div class="tabs_alt tabs_parent">
	   <ul id="main_tabs">

			<li><a id="about_me" href="javascript:void(0);" class="active">ABOUT ME</a></li>
			<li><a id="residences" href="javascript:void(0);">RESIDENCE</a></li>
			<li><a id="office" href="javascript:void(0);">OCCUPATION</a></li>
		</ul>
	</div>
   </div>	
		
	<div class="message" style="color:red"></div>
	
	<div class="about_me_content"> <!-- start about me-->
	
			<div class="pro_field_wrapper">
			<input name="FirstName" type="text" maxlength="65" placeholder="First Name" id="FirstName" class="prty_field input-box" autofocus value ="<?php echo $this->smartmoveapiRentersData->FirstName; ?>" readonly>
			<span style="color:red; font-size: 28px;">*</span>
			</div> <br>

			<div class="pro_field_wrapper">
				<input name="MiddleName" type="text" maxlength="65" placeholder="Middle Name" id="MiddleName" class="prty_field input-box" value ="<?php echo $this->smartmoveapiRentersData->MiddleName; ?>">
				<span style="color:#fff; font-size: 28px;">*</span>
			</div><br>
			
			<div class="pro_field_wrapper">
				<input name="LastName" type="text" maxlength="65" placeholder="Last Name" id="LastName" class="prty_field input-box" value ="<?php echo $this->smartmoveapiRentersData->LastName; ?>" readonly>
			  <span style="color:red; font-size: 28px;">*</span>
			</div><br>

			<div class="pro_field_wrapper">
				<input name="Email" type="text" maxlength="65" placeholder="Email" id="Email" class="prty_field input-box" value ="<?php echo $this->smartmoveapiRentersData->Email; ?>" readonly>
				<span style="color:red; font-size: 28px;">*</span>
			</div><br>
			
			<div class="pro_field_wrapper">
				<input name="DateOfBirth" type="text" maxlength="65" placeholder="YYYY-MM-DD" id="DateOfBirth" class="prty_field input-box" value ="<?php echo str_replace("T00:00:00", "",$this->smartmoveapiRentersData->DateOfBirth); ?>" readonly>
				<span style="color:red; font-size: 28px;">*</span>
			</div><br>
			<div class="pro_field_wrapper">
				<input name="SocialSecurityNumber" type="text" maxlength="9" placeholder="Social Security Number" id="SocialSecurityNumber" class="prty_field input-box"  value ="<?php echo $this->smartmoveapiRentersData->SocialSecurityNumber; ?>">
				<span style="color:red; font-size: 28px;">*</span>
			</div><br>
			<div class="pro_field_wrapper">
			<button class="aboutme_next_btn" type="button" value="Save" name="">Next</button>
			 </div>
	
	</div> <!-- end about me-->
	
	<div class="residence_content" style="display:none"> <!-- start residence content-->
		

			<div class="pro_field_wrapper">
				<input name="StreetAddressLineOne" type="text" maxlength="65" placeholder="Street Address Line One" id="StreetAddressLineOne" class="prty_field input-box" value ="<?php echo $this->smartmoveapiRentersData->StreetAddressLineOne; ?>">
			   <span style="color:red; font-size: 28px;">*</span>
			</div> <br>
			
			<div class="pro_field_wrapper">
				<input name="StreetAddressLineTwo" type="text" maxlength="65" placeholder="Street Address Line Two" id="StreetAddressLineTwo" class="prty_field input-box" value ="<?php echo $this->smartmoveapiRentersData->StreetAddressLineTwo; ?>">
				<span style="color:#fff; font-size: 28px;">*</span>
			</div> <br>
			<div class="pro_field_wrapper">
			<select name="State" id="State"  class="prty_field input-box">
				<option value="">State</option>
				
				<?php foreach($StateArray as $key =>$value):?>
													 <option value="<?php echo $key;?>"><?php echo $value;?></option>
				<?php endforeach;?>									 
													 
												
									 
			</select>
			<span style="color:red; font-size: 28px;">*</span>
			</div> <br>
			 <div class="pro_field_wrapper">


			<select name="City" id="City"  class="prty_field input-box" maxlength="18">
		  
				<option value="<?php echo $this->smartmoveapiRentersData->City; ?>"><?php echo $this->smartmoveapiRentersData->City; ?></option>
			</select>
			<span style="color:red; font-size: 28px;">*</span>
			</div> <br>
			 <div class="pro_field_wrapper">
				<input name="Zip" type="text" maxlength="5" placeholder="Zip" id="Zip" class="prty_field input-box" value ="<?php echo $this->smartmoveapiRentersData->Zip; ?>">
				<span style="color:red; font-size: 28px;">*</span>
			</div> <br>
			 <div class="pro_field_wrapper">
				<input name="HomePhoneNumber" type="text" maxlength="15" placeholder="Home Phone Number" id="HomePhoneNumber" class="prty_field input-box" value ="<?php echo $this->smartmoveapiRentersData->HomePhoneNumber; ?>">
				<span style="color:red; font-size: 28px;">*</span>
			</div> <br>
			
				 <div class="pro_field_wrapper">

				<input name="MobilePhoneNumber" type="text" maxlength="15" placeholder="Mobile Phone Number" id="MobilePhoneNumber" class="prty_field input-box" value ="<?php echo $this->smartmoveapiRentersData->MobilePhoneNumber; ?>">
				<span style="color:#fff; font-size: 28px;">*</span>
			</div> <br>
			<div class="pro_field_wrapper">
			   <button class="residence_next_btn" type="button" value="Save" name="">Next</button>
			</div>
    </div>  <!-- end residence content-->
    
    <div class="office_content" style="display:none">  <!-- start office content-->
		   			<div class="pro_field_wrapper">
			<select name="EmploymentStatus" id="EmploymentStatus"  class="prty_field input-box">
													 <option value="">Employment Status</option>
													 <option value="Employed">Employed</option>
													 <option value="NotEmployed">NotEmployed</option>
													 <option value="SelfEmployed">SelfEmployed</option>
													 <option value="Student">Student</option>
									 
			</select>
			<span style="color:red; font-size: 28px;">*</span>
			</div> <br>
            <div class="pro_field_wrapper">

				<input name="Income" type="text" maxlength="65" placeholder="Income" id="Income" class="prty_field input-box" value ="<?php echo $this->smartmoveapiRentersData->Income; ?>">
				<span style="color:red; font-size: 28px;">*</span>
			</div> <br>
			<div class="pro_field_wrapper">
			<select name="IncomeFrequency" id="IncomeFrequency"  class="prty_field input-box">
													 <option value="">Income Frequency</option>
													 <option value="Monthly">Monthly</option>
													 <option value="Annual">Annual</option>
									 
			</select>
			<span style="color:red; font-size: 28px;">*</span>
			</div> <br>
			<div class="pro_field_wrapper">
				<input name="OtherIncome" type="text" maxlength="18" placeholder="Other Income" id="OtherIncome" class="prty_field input-box" value ="<?php echo $this->smartmoveapiRentersData->OtherIncome; ?>">
				<span style="color:#fff; font-size: 28px;">*</span>
			</div> <br>
			<div class="pro_field_wrapper">
			<select name="Other Income Frequency" id="OtherIncomeFrequency"  class="prty_field input-box">
													 <option value="">Other Income Frequency</option>
													 <option value="Monthly">Monthly</option>
													 <option value="Annual">Annual</option>
									 
			</select>
			<span style="color:#fff; font-size: 28px;">*</span>
			</div> <br>
			 <div class="pro_field_wrapper">

				<input name="OfficePhoneNumber" type="text" maxlength="15" placeholder="Office Phone Number" id="OfficePhoneNumber" class="prty_field input-box" value ="<?php echo $this->smartmoveapiRentersData->OfficePhoneNumber; ?>">
				<span style="color:#fff; font-size: 28px;">*</span>
			</div> <br>
			 <div class="pro_field_wrapper">

				<input name="OfficePhoneExtension" type="text" maxlength="6" placeholder="Office Phone Extension" id="OfficePhoneExtension" class="prty_field input-box" value ="<?php echo $this->smartmoveapiRentersData->OfficePhoneExtension; ?>">
				<span style="color:#fff; font-size: 28px;">*</span>
			</div> <br>

			 
			 
			 <div class="pro_field_wrapper">
				<input name="AssetValue" type="text" maxlength="65" placeholder="Asset Value" id="AssetValue" class="prty_field input-box" value ="<?php echo $this->smartmoveapiRentersData->AssetValue; ?>">
				<span style="color:#fff; font-size: 28px;">*</span>
			</div> <br>
			<div class="pro_field_wrapper">
			<div class="fcra"><a href="javascript:void(0)" target="_blank">Fcra Agreement Accepted </a><span style="color:red">*</div> 
			<select name="FcraAgreementAccepted" id="FcraAgreementAccepted"  class="prty_field input-box">
													 <option value="true">Yes</option>
													 <option value="false">No</option>
									 
			</select>
			<span style="color:red; font-size: 28px;">*</span>
			</div> <br>
			   
			
			
			<div class="pro_field_wrapper">
			<button class="createrental_submit_btn" type="button" value="Save" name="">Submit</button>
			</div>
    
    </div>  <!-- End office content-->
    </div>
    <div class="loader" style="display:none"></div>


</div>



</div>

<script type="text/javascript">
	
	var EmploymentStatus ='<?php echo $this->smartmoveapiRentersData->EmploymentStatus?>';
	var State ='<?php echo $this->smartmoveapiRentersData->State?>';
	var IncomeFrequency ='<?php echo $this->smartmoveapiRentersData->IncomeFrequency?>';
	var OtherIncomeFrequency ='<?php echo $this->smartmoveapiRentersData->OtherIncomeFrequency?>';
	var OfficePhoneNumber ='<?php echo $this->smartmoveapiRentersData->OfficePhoneNumber?>';
	var OfficePhoneExtension ='<?php echo $this->smartmoveapiRentersData->OfficePhoneExtension?>';
	var MobilePhoneNumber ='<?php echo $this->smartmoveapiRentersData->MobilePhoneNumber?>';
	var OtherIncome ='<?php echo $this->smartmoveapiRentersData->OtherIncome?>';
	var AssetValue ='<?php echo $this->smartmoveapiRentersData->AssetValue?>';
	
	jQuery("#EmploymentStatus").val(EmploymentStatus);
	jQuery("#State").val(State);
	jQuery("#IncomeFrequency").val(IncomeFrequency);
	
	if(OtherIncomeFrequency == 'Unknown'){
		jQuery("#OtherIncomeFrequency").val('');
	}
	else{
	jQuery("#OtherIncomeFrequency").val(OtherIncomeFrequency);
    }
    if(OfficePhoneNumber == '0'){
		jQuery("#OfficePhoneNumber").val('');
	}
    if(OfficePhoneExtension == 0){
		jQuery("#OfficePhoneExtension").val('');
	}
    if(MobilePhoneNumber == 0){
		jQuery("#MobilePhoneNumber").val('');
	}
    if(OtherIncome == 0){
		jQuery("#OtherIncome").val('');
	}
    if(AssetValue == 0){
		jQuery("#AssetValue").val('');
	}



jQuery('.createrental_submit_btn').on('click',function(){
	
 var viewer_id = '<?php echo $viewer->getIdentity();?>';
 var oData       = new Object();


 var FirstName    = oData.FirstName  =jQuery.trim(jQuery("#FirstName").val()); 
 var MiddleName   = oData.MiddleName =jQuery.trim(jQuery("#MiddleName").val()); 
 var LastName     = oData.LastName   =jQuery.trim(jQuery("#LastName").val()); 
 var Email        = oData.Email      =jQuery.trim(jQuery("#Email").val()); 
 var DateOfBirth                 = oData.DateOfBirth =jQuery.trim(jQuery("#DateOfBirth").val()); 
 var SocialSecurityNumber        = oData.SocialSecurityNumber =jQuery.trim(jQuery("#SocialSecurityNumber").val()); 
 var EmploymentStatus            = oData.EmploymentStatus =jQuery.trim(jQuery("#EmploymentStatus").val()); 
 var StreetAddressLineOne        = oData.StreetAddressLineOne =jQuery.trim(jQuery("#StreetAddressLineOne").val()); 
 var StreetAddressLineTwo        = oData.StreetAddressLineTwo =jQuery.trim(jQuery("#StreetAddressLineTwo").val()); 
 var State                       = oData.State =jQuery.trim(jQuery("#State").val()); 
 var City                        = oData.City =jQuery.trim(jQuery("#City").val()); 
 var Zip                         = oData.Zip =jQuery.trim(jQuery("#Zip").val()); 
 var HomePhoneNumber             = oData.HomePhoneNumber =jQuery.trim(jQuery("#HomePhoneNumber").val()); 
 var OfficePhoneNumber           = oData.OfficePhoneNumber =jQuery.trim(jQuery("#OfficePhoneNumber").val()); 
 var OfficePhoneExtension        = oData.OfficePhoneExtension =jQuery.trim(jQuery("#OfficePhoneExtension").val()); 
 var MobilePhoneNumber           = oData.MobilePhoneNumber =jQuery.trim(jQuery("#MobilePhoneNumber").val()); 
 var Income                      = oData.Income =jQuery.trim(jQuery("#Income").val()); 
 var IncomeFrequency             = oData.IncomeFrequency =jQuery.trim(jQuery("#IncomeFrequency").val()); 
 var OtherIncome                 = oData.OtherIncome =jQuery.trim(jQuery("#OtherIncome").val()); 
 var OtherIncomeFrequency        = oData.OtherIncomeFrequency =jQuery.trim(jQuery("#OtherIncomeFrequency").val()); 
 var AssetValue                  = oData.AssetValue =jQuery.trim(jQuery("#AssetValue").val()); 
 var FcraAgreementAccepted       = oData.FcraAgreementAccepted =jQuery.trim(jQuery("#FcraAgreementAccepted").val()); 

 var is_validate = true;
 
  if(FirstName == '' ||  LastName =='' ||Email =='' ||DateOfBirth =='' ||SocialSecurityNumber =='' ||
 EmploymentStatus == '' || StreetAddressLineOne == '' ||State =='' ||City =='' ||Zip =='' ||
 Income =='' ||IncomeFrequency ==''  || FcraAgreementAccepted == '' || HomePhoneNumber == ''){
    var scrollPos =  jQuery(".message").offset().top;
    jQuery(".message").text('Please fill all mandatory fields');
    jQuery(window).scrollTop(scrollPos);
    if(FirstName =='')         { jQuery('#FirstName').css('border-color','#e62828');                            }
    else                       { jQuery('#FirstName').css('border-color','#b2c6cd');                            }  
    if(LastName =='')          { jQuery('#LastName').css('border-color','#e62828');                             }
    else                       { jQuery('#LastName').css('border-color','#b2c6cd');                             }  
    if(Email =='')             { jQuery('#Email').css('border-color','#e62828');                                }
    else                       { jQuery('#Email').css('border-color','#b2c6cd');                                }  
    if(DateOfBirth =='')       { jQuery('#DateOfBirth').css('border-color','#e62828');                          }
    else                       { jQuery('#DateOfBirth').css('border-color','#b2c6cd');                          }  
    if(SocialSecurityNumber =='')     { jQuery('#SocialSecurityNumber').css('border-color','#e62828');          }
    else                       { jQuery('#SocialSecurityNumber').css('border-color','#b2c6cd');                 }  
    if(EmploymentStatus =='')         { jQuery('#EmploymentStatus').css('border-color','#e62828');              }
    else                       { jQuery('#EmploymentStatus').css('border-color','#b2c6cd');                     }  
    if(StreetAddressLineOne =='')     { jQuery('#StreetAddressLineOne').css('border-color','#e62828');          }
    else                       { jQuery('#StreetAddressLineOne').css('border-color','#b2c6cd');                 }  
    if(State =='')     { jQuery('#State').css('border-color','#e62828');                                        }
    else                       { jQuery('#State').css('border-color','#b2c6cd');                                }  
    if(City =='')     { jQuery('#City').css('border-color','#e62828');                                          }
    else                       { jQuery('#City').css('border-color','#b2c6cd');                                 }  
    if(Zip =='')     { jQuery('#Zip').css('border-color','#e62828');                                            }
    else                       { jQuery('#Zip').css('border-color','#b2c6cd');                                  }  
    if(Income =='')     { jQuery('#Income').css('border-color','#e62828');                                      }
    else                       { jQuery('#Income').css('border-color','#b2c6cd');                               }  
    if(IncomeFrequency =='')     { jQuery('#IncomeFrequency').css('border-color','#e62828');                    }
    else                       { jQuery('#IncomeFrequency').css('border-color','#b2c6cd');                      }  
    if(FcraAgreementAccepted =='')     { jQuery('#FcraAgreementAccepted').css('border-color','#e62828');        }
    else                       { jQuery('#FcraAgreementAccepted').css('border-color','#b2c6cd');                }  
    if(HomePhoneNumber =='')     { jQuery('#HomePhoneNumber').css('border-color','#e62828');                    }
    else                         { jQuery('#HomePhoneNumber').css('border-color','#b2c6cd');                    }  
    var is_validate =false;
    
    if(FirstName =='' ||LastName =='' ||Email =='' ||DateOfBirth =='' ||SocialSecurityNumber ==''  ){		
		jQuery('#about_me').trigger( 'click' );		
	}
	else if(StreetAddressLineOne == '' ||State == '' ||City == '' ||Zip == '' ||HomePhoneNumber == ''){
		jQuery('#residences').trigger( 'click' );		
	}	
    else{
		jQuery('#office').trigger( 'click' );		
	}
 }
 
 else{
	 
	 jQuery(".message").text('');
	 is_validate = true;
	 
 }
 
 if(is_validate == true){
	 jQuery(".message").text('');

	if(SocialSecurityNumber != ''){
		
    if(/([0-9]{9})+$/.test(SocialSecurityNumber)) {

		 jQuery("#SocialSecurityNumber").css('border-color','b2c6cd');
         var is_validate =true;
        }
		else {
		 jQuery("#SocialSecurityNumber").css('border-color','red');
		 jQuery(".message").text('SocialSecurityNumber should have exact 9 numeric values');
		 jQuery('#about_me').trigger( 'click' );	
		 var is_validate =false;
		}
	}
 }
 
 if(is_validate == true){
	 jQuery(".message").text('');

	if(StreetAddressLineOne != ''){
		
    if(/^(?=.*[0-9])(?=.*[a-zA-Z])([a-zA-Z0-9\s]+)$/.test(StreetAddressLineOne)) {

		 jQuery("#StreetAddressLineOne").css('border-color','b2c6cd');
         var is_validate =true;
        }
		else {
		 jQuery("#StreetAddressLineOne").css('border-color','red');
		 jQuery(".message").text('The Street Address field must contain at least one number and a letter');
		 jQuery('#residences').trigger( 'click' );
		 var is_validate =false;
		}
	}
 }
 if(is_validate == true){
	 jQuery(".message").text('');

	if(StreetAddressLineTwo != ''){
		
	if(/^(?=.*[0-9])(?=.*[a-zA-Z])([a-zA-Z0-9\s]+)$/.test(StreetAddressLineTwo)) {

		 jQuery("#StreetAddressLineTwo").css('border-color','b2c6cd');
         var is_validate =true;
        }
		else {
		 jQuery("#StreetAddressLineTwo").css('border-color','red');
		 jQuery(".message").text('The Street Address field must contain at least one number and a letter');
		 jQuery('#residences').trigger( 'click' );
		 var is_validate =false;
		}
	}
 }
 
 if(is_validate == true){
	 jQuery(".message").text('');
 //Zip validation 
	if(Zip != ''){
		
    if(/([0-9]{5})+$/.test(Zip)) {
		 jQuery("#Zip").css('border-color','b2c6cd');
         var is_validate =true;
        }
		else {
		 jQuery("#Zip").css('border-color','red');
		 jQuery(".message").text('Zipcode should have exact 5 numeric values');
		 jQuery('#residences').trigger( 'click' );
		 var is_validate =false;
		}
	}
 }
 if(is_validate == true){
	 jQuery(".message").text('');

	if(HomePhoneNumber != ''){
		
    if(/([0-9]{10,15})+$/.test(HomePhoneNumber)) {
		 jQuery("#HomePhoneNumber").css('border-color','b2c6cd');
         var is_validate =true;
        }
		else {
		 jQuery("#HomePhoneNumber").css('border-color','red');
		 jQuery(".message").text('The field Home Phone Number can only contain numbers and must be between 10 and 15 characters in length');
		 jQuery('#residences').trigger( 'click' );
		 var is_validate =false;
		}
	}
 }
 if(is_validate == true){
	 jQuery(".message").text('');

	if(OfficePhoneNumber != ''){
		
    if(/([0-9]{10,15})+$/.test(OfficePhoneNumber)) {
		 jQuery("#OfficePhoneNumber").css('border-color','b2c6cd');
         var is_validate =true;
        }
		else {
		 jQuery("#OfficePhoneNumber").css('border-color','red');
		 jQuery(".message").text('The field Office Phone Number can only contain numbers and must be between 10 and 15 characters in length');
		 jQuery('#office').trigger( 'click' );	
		 var is_validate =false;
		}
	}
 }
 if(is_validate == true){
	 jQuery(".message").text('');

	if(OfficePhoneExtension != ''){
		
    if(/([0-9]{5})+$/.test(OfficePhoneExtension)) {
		 jQuery("#OfficePhoneExtension").css('border-color','b2c6cd');
         var is_validate =true;
        }
		else {
		 jQuery("#OfficePhoneExtension").css('border-color','red');
		 jQuery(".message").text('Office Phone Extension should have 5 numeric values');
		 jQuery('#office').trigger( 'click' );	
		 var is_validate =false;
		}
	}
 }
 if(is_validate == true){
	 jQuery(".message").text('');

	if(MobilePhoneNumber != ''){
		
    if(/([0-9]{5})+$/.test(MobilePhoneNumber)) {
		 jQuery("#MobilePhoneNumber").css('border-color','b2c6cd');
         var is_validate =true;
        }
		else {
		 jQuery("#MobilePhoneNumber").css('border-color','red');
		 jQuery(".message").text('Invalid MobilePhoneNumber');
		 jQuery('#residences').trigger( 'click' );	
		 var is_validate =false;
		}
	}
 }
 if(is_validate == true){
	 jQuery(".message").text('');

	if(Income != ''){
		
    if(/[1-9]\d*(\.\d+)?$/.test(Income)) {
		 jQuery("#Income").css('border-color','b2c6cd');
         var is_validate =true;
        }
		else {
		 jQuery("#Income").css('border-color','red');
		 jQuery(".message").text('Please enter only numeric values for Income');
		 jQuery('#office').trigger( 'click' );	
		 var is_validate =false;
		}
	}
 }
 if(is_validate == true){
	 jQuery(".message").text('');

	if(OtherIncome != ''){
		
		if(OtherIncomeFrequency ==''){
			
			 jQuery("#OtherIncomeFrequency").css('border-color','red');
			 jQuery(".message").text('Please enter OtherIncomeFrequency');
			 jQuery('#office').trigger( 'click' );	
			 var is_validate =false;
			
		}
		else{
			jQuery("#OtherIncomeFrequency").css('border-color','b2c6cd');
            var is_validate =true;
			
		}
	}
		
   
 }
  if(is_validate == true){
	 jQuery(".message").text('');

	if(FcraAgreementAccepted != ''){
		
    if(FcraAgreementAccepted =='true') {

		 jQuery("#FcraAgreementAccepted").css('border-color','b2c6cd');
         var is_validate =true;
        }
		else {
		 jQuery("#FcraAgreementAccepted").css('border-color','red');
		 jQuery(".message").text('Accept Fcra Agreement');
		 jQuery('#office').trigger( 'click' );	
		 var is_validate =false;
		}
	}
 }
 if(is_validate == true){
	 jQuery(".message").text('');

	if(LastName != ''){
	
    if( /^[a-zA-Z ]{2,50}$/.test(LastName)) {

		 jQuery("#LastName").css('border-color','b2c6cd');
         var is_validate =true;
        }
		else {
		 jQuery("#LastName").css('border-color','red');
		 jQuery(".message").text('The  LastName can only contain letters and must be between 2 and 50 characters in length');
		 jQuery('#about_me').trigger( 'click' );	
		 var is_validate =false;
		}
	}
 } 
 if(is_validate == true){
	 
	 jQuery(".loader").css("display", "block");
	 jQuery(".createrental_submit_btn").hide();
	 
	    var host	=	window.location.host;
        var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/smartmoveapicreaterenterupdate';
	              jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) { console.log(data);
						 
						if(data.status == true){ 						 
                                jQuery("#successModal .success_message").text('');
                                jQuery("#successModal .success_message").text('Your changes have been succesfully saved');
                                jQuery("#successModal").modal('show');  
                        }
                        else{
							jQuery(".loader").css("display", "none");
	                        jQuery(".createrental_submit_btn").show();
							console.log(data.errors);							
						}      
					 },
					   error: function(e){  
						   jQuery(".loader").css("display", "none");
						   jQuery('.createrental_submit_btn').show(); }  
					}); 
	 
 }
	
 });
  jQuery( "#State" ).change(function() {
	
  var url = '<?php echo $this->baseUrl(); ?>' + '/user/index/getcitywithstateabbreviations'; 
  var state_abbr	=	jQuery('#State').val();  
  jQuery('#City').html('<option value="Loading">Loading...</option>');
		  jQuery.ajax({
					 url:  url,
					data: "state_abbr="+state_abbr,
					dataType: 'json',
					type: 'POST',
				 success: function (data) { 
					var i=1; 
					jQuery.each(data, function (i, item) {
					jQuery('#City').append(jQuery('<option>', { 
						value: item.city,
						text : item.city 
					}));
					 i=i+1;
						if(i==data.length){
							jQuery("#City option[value='Loading']").remove();
							jQuery('#City').prepend('<option selected>Select City</option>');
						}
				});},
				   error: function(e){   }  
				});
});
jQuery('#successModal .close').on('click',function(){
location.href = '<?php echo $this->baseUrl()?>' + '/members/home';
});

jQuery('#about_me').on('click',function(){

    jQuery('#about_me').addClass('active');
    jQuery('#residences').removeClass('active');
    jQuery('#office').removeClass('active');
    jQuery('.about_me_content').css('display','block');
    jQuery('.residence_content').css('display','none');
    jQuery('.office_content').css('display','none');

});

jQuery('#residences').on('click',function(){

    jQuery('#about_me').removeClass('active');
    jQuery('#residences').addClass('active');
    jQuery('#office').removeClass('active');
    jQuery('.about_me_content').css('display','none');
    jQuery('.residence_content').css('display','block');
    jQuery('.office_content').css('display','none');

});
jQuery('#office').on('click',function(){

    jQuery('#about_me').removeClass('active');
    jQuery('#residences').removeClass('active');
    jQuery('#office').addClass('active');
    jQuery('.about_me_content').css('display','none');
    jQuery('.residence_content').css('display','none');
    jQuery('.office_content').css('display','block');

});
jQuery('.aboutme_next_btn').on('click',function(){
    jQuery('#residences').trigger( 'click' );
});
jQuery('.residence_next_btn').on('click',function(){
    jQuery('#office').trigger( 'click' );
});
</script>
