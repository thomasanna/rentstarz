<script src="/application/modules/User/externals/scripts/message_notififaction.js"></script>
<script>
<?php $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); ?>

var viewer_identity='<?php echo $viwer_id; ?>';
</script>
<div class="generic_layout_container layout_user_browse_menu">
<div class="headline">
  <h2>
   Edit Property Requirement   </h2>

</div>
</div>
<div class="generic_layout_container layout_middle">
    <article class="padding_top_bottom20">
        <div class="maincontentdiv">
            <article class="content_main_left">
                <div class="padding_bottom20" style="position: relative;">

                    <div class="success_msg"  style="color: green;margin-bottom: 12px;"></div>

                  <div class="message" style='color:red'></div>
                  <div></div>
                    <form id="property_entry_form" enctype="multipart/form-data">

                            <div class="input_fields_area">
                            <div class="pro_field_wrapper pets">
							<!--	<div class="prty_lablel pro_label"><span class="prty_lablel" style="font-weight: bold;">Say Something </span><span style="color:red;font-weight: bolder;">*</span></div> -->
							<textarea name="req_description" id="req_description" class="template_div input-box" placeholder="Say Something"><?php echo $this->propertyRequirementData->description;    ?></textarea>
							<span style="color:red;font-weight: bolder;">*</span>
							</div>   <br>
                            <div class="pro_field_wrapper">
								<!--<div class="prty_lablel pro_label"><span class="prty_lablel" style="font-weight: bold;">Pets </span><span style="color:red;font-weight: bolder;">*</span></div>-->
                            <select name="allowed_pets" id="allowed_pets"  class="prty_field input-box" onchange="petsType()">
                                             <option value="">Pets</option>
                                             <option value="Yes">Yes</option>
                                             <option value="No">No</option>

                             </select>
                             <span style="color:red;font-weight: bolder;">*</span>
                             </div>   <br>

                            <div class="pets_type_wrapper" style="display:none">
                            <div class="pro_field_wrapper">
								<!--<div class="prty_lablel pro_label"><span class="prty_lablel" style="font-weight: bold;">Type of pets </span><span style="color:red;font-weight: bolder;">*</span></div>-->
								  <select name="requirement_pets_type" id="requirement_pets_type"  class="prty_field input-box">
                                             <option value="">Type of pets</option>
                                             <option value="Cats">Cats</option>
                                             <option value="Dogs">Dogs</option>
                                             <option value="Cats & Dogs">Cats & Dogs</option>
                                             <option value="Birds">Birds</option>
                                             <option value="Small pets">Small pets</option>

                             </select>
                             <span style="color:red;font-weight: bolder;">*</span>
                             </div>   <br></div>
                            <div class="pro_field_wrapper">
							<!--<div class="prty_lablel pro_label"><span class="prty_lablel" style="font-weight: bold;">Type of rental </span><span style="color:red;font-weight: bolder;">*</span></div>-->
							  <select name="rental_type" id="rental_type"  class="prty_field input-box">
                                             <option value="">Type of rental</option>
                                             <option value="Rent">Rental</option>
                                             <option value="Lease">Lease</option>

                                             </select> 
                                             <span style="color:red;font-weight: bolder;">*</span>
                                             </div>  <br>
                            <div class="pro_field_wrapper">
                                <!-- <div class="prty_lablel pro_label"><span class="prty_lablel" style="font-weight: bold;">Vouchers </span><span style="color:red;font-weight: bolder;">*</span></div> -->
                                  <select name="accept_vouchers" id="accept_vouchers"  class="prty_field input-box">
                                             <option value="">Vouchers</option>
                                             <option value="Yes">Yes</option>
                                             <option value="No">No</option>
                             </select>
                             <span style="color:red;font-weight: bolder;">*</span>
                             </div>   <br> 


                             <div class="pro_field_wrapper">
                               <!--  <div class="prty_lablel pro_label"><span class="prty_lablel" style="font-weight: bold;">Wheel chair accessible properties </span><span style="color:red;font-weight: bolder;">*</span></div>-->
                                  <select name="wheel_chair_accessible" id="wheel_chair_accessible"  class="prty_field input-box">
                                             <option value="">Wheel chair accessible properties</option>
                                             <option value="Yes">Yes</option>
                                             <option value="No">No</option>
                             </select>
                              <span style="color:red;font-weight: bolder;">*</span>
                              </div>   <br>

                              <div class="pro_field_wrapper">
                             <!--<div class="prty_lablel pro_label"><span class="prty_lablel" style="font-weight: bold;">Onsite or off site parking</span><span style="color:red;font-weight: bolder;">*</span></div>-->
                               <select name="parking" id="parking"  class="prty_field input-box">
                                             <option value="">Onsite or off site parking</option>
                                             <option value="Yes">Yes</option>
                                             <option value="No">No</option>
                             </select>
                             <span style="color:red;font-weight: bolder;">*</span>
                             </div>   <br>

                            <div class="pro_field_wrapper">
								<!--<div class="prty_lablel pro_label"><span class="prty_lablel" style="font-weight: bold;">Type of housing</span><span style="color:red;font-weight: bolder;">*</span></div>-->
								  <select name="housing_type" id="housing_type"  class="prty_field input-box">
                                             <option value="">Type of housing</option>
                                             <option value="Apartment">Apartment</option>
                                             <option value="Room">Room</option>
                                             <option value="House">House</option>
                                             <option value="Villa">Villa</option>
                                             <!--<option value="Bedroom">Bedroom</option>-->

                                             </select>
                                              <span style="color:red;font-weight: bolder;">*</span>
                                  </div>   <br>

                          <div class="num_rooms pro_field_wrapper" >
							  <!--<div class="pro_field_wrapper"><div class="prty_lablel pro_label"><span class="prty_lablel" style="font-weight: bold;">Number of bedrooms</span><span style="color:red;font-weight: bolder;">*</span></div>-->
							    <select name="req_number_of_rooms" id="req_number_of_rooms"  class="prty_field input-box">
                                             <option value="">Number of bedrooms</option>
                                             <option value="1">1</option>
                                             <option value="2">2</option>
                                             <option value="3">3</option>
                                             <option value="4">4</option>
                                             <option value="4+">4+</option>

                                             </select>
                                              <span style="color:red;font-weight: bolder;">*</span>
                               </div> <br>
                            <div class="pro_field_wrapper">
								<!--<div class="prty_lablel pro_label"><span class="prty_lablel" style="font-weight: bold;">Budget (monthly)</span><span style="color:red;font-weight: bolder;">*</span></div>-->

                            <?php if($this->propertyRequirementData->budget != '0' && $this->propertyRequirementData->budget_range_to != '0'): ?>


								<span class="price_input_span">
								<input name="requirement_price" type="text" maxlength="65" placeholder="Price" id="requirement_price"  class="prty_field price_field price_range_from prty_field_budget input-box" value="<?php echo $this->propertyRequirementData->budget;?>" style="width: 170px;"></span>
								<span class="price_range_input_span">
								to <input name="requirement_price_renge_to" type="text"  placeholder="Price"   class="requirement_price_renge_to range_field input-box" value="<?php echo $this->propertyRequirementData->budget_range_to; ?>"></span>
								</span>
								<span class="range_span_link"> <a href="javascript:void(0)" class="cancel_range_link 44"><img src="/application/modules/User/externals/images/cancel_add_range.png" alt="" title="Cancel"></a></span>
                            <?php else:?>
                            <span class="price_input_span" style="">
                            <input name="requirement_price" type="text" maxlength="65" placeholder="Price" id="requirement_price"  class="prty_field price_field prty_field_budget mob_bar_disable input-box" value="<?php echo $this->propertyRequirementData->budget;?>">
                            </span>
                            <input name="requirement_price" type="text" maxlength="65" placeholder="Price" id="requirement_price"  class="prty_field price_field mob_bar input-box" value="<?php echo $this->propertyRequirementData->budget;?>">
                           
                            <span class="price_range_input_span" style="display:none;">
                            to <input name="requirement_price_renge_to" type="text"  placeholder="Price"   class="requirement_price_renge_to range_field input-box" value=""></span>
                            </span>
                            <span class="range_span_link"><a href="javascript:void(0)" class="range_link"><img src="/application/modules/User/externals/images/add_range.png" alt="" title="Add Range"></a></span>
                            <?php endif;?>
                            <span style="color:red;font-weight: bolder;">*</span>
                            <div class="price_validation_msg"></div>
                       </div>  <br>    </div>
                   
                  
                    <div class="map_area">
                             <div id="map"></div>
                            <div class="map_fields pro_field_wrapper">
                            <input type= "hidden" placeholder="Street_number" class="field" id="street_number"></input>
                            <input type= "hidden" class="field" id="route"></input>
                            <input type= "hidden" placeholder="Neighborhood" class="field input-box" id="neighborhood" value="<?php echo $this->propertyRequirementData->neighborhood;  ?>" readonly></input>
                            <input type= "hidden" placeholder="City" class="field " id="locality" value="<?php echo $this->propertyRequirementData->prty_city;  ?>" ></input>
                            <input type= "hidden" placeholder="Sublocality county" class="field" id="sublocality_level_1"></input>
                            <input type= "hidden" placeholder="State" class="field " id="administrative_area_level_1" value="<?php echo $this->propertyRequirementData->prty_state;  ?>" ></input>                          
                            <input type= "hidden" placeholder="Country" class="field " id="country" value="<?php echo $this->propertyRequirementData->prty_country;    ?>" ></input>

                            <input type= "hidden" class="field" id="latitude"></input>
                            <input type= "hidden" class="field" id="longitude"></input>

                            </div>
                             <div class="pro_field_wrapper" >
                              <input id="pac-input1" class="controls1 input-box prty_field" type="text" placeholder="Location" value="<?php echo $this->propertyRequirementData->prty_city ."," .$this->propertyRequirementData->prty_state .",".$this->propertyRequirementData->prty_country; ?>">
                              <span style="color:red;font-weight: bolder;">*</span>
                            </div>
                            <br> 
                             <div class="pro_field_wrapper" >
                              <input type= "text" placeholder="Zipcode" class=" property_zipcode prty_field input-box" id="postal_code" value="<?php echo $this->propertyRequirementData->zip;    ?>" ></input>
                              <span style="color:red;font-weight: bolder;">*</span>
                            </div>
                            <br> 

                    </div>
                    
                    
                   
                    <div class="padding_top_bottom submit_btn " >
						 <div class="loader" style="display:none;"></div>
                    <input class="but_submit property_btn" type="button" value="Submit" name="">
                    </div>
                    </form>
                    </div><div class="clear"></div>
                   </div>
            </article>
        </div>
        <div class="clear"></div>
    </article>
</div>

<script type="text/javascript">

var latitude  = <?php echo $this->propertyRequirementData->latitude;    ?>;
var longitude = <?php echo $this->propertyRequirementData->longitude;   ?>;
jQuery(document).ready(function(){
   initAutocomplete();
});
</script>

<script> 

var handleClick= 'ontouchstart' in document.documentElement ? 'touchstart': 'click';

jQuery( document ).ready(function() {

     jQuery("#allowed_pets").val('<?php echo $this->propertyRequirementData->pets_allowed?>');
     jQuery("#rental_type").val('<?php echo $this->propertyRequirementData->rental_type?>');
     jQuery("#housing_type").val('<?php echo $this->propertyRequirementData->housing_type?>');
     jQuery("#req_number_of_rooms").val('<?php echo $this->propertyRequirementData->no_of_rooms?>');
     jQuery("#accept_vouchers").val('<?php echo $this->propertyRequirementData->vouchers?>');
     jQuery("#wheel_chair_accessible").val('<?php echo $this->propertyRequirementData->wheelchair_accessible?>');
     jQuery("#parking").val('<?php echo $this->propertyRequirementData->provide_parking?>');
    var hasPet  =   jQuery('#allowed_pets').val();
    jQuery('#requirement_pets_type').val('');
        if(hasPet   ==  'Yes')
        {
            jQuery('.pets_type_wrapper').css('display','block');
            jQuery("#requirement_pets_type").val('<?php echo $this->propertyRequirementData->pets_type  ?>');
        }
        else
        {
            jQuery('.pets_type_wrapper').css('display','none');
        }

});
function petsType(){

    var hasPet  =   jQuery('#allowed_pets').val();
    jQuery('#requirement_pets_type').val('');
    if(hasPet   ==  'Yes')
    {
        jQuery('.pets_type_wrapper').css('display','block');
    }
    else
    {
        jQuery('.pets_type_wrapper').css('display','none');
    }
}

jQuery( "#housing_type" ).change(function() {

    var housing_type= jQuery("#housing_type").val();
    if(housing_type !=''){
        jQuery(".num_rooms").css('display','block')
    }
    else{
        jQuery(".num_rooms").css('display','none')
    }

});

jQuery('.but_submit').on(handleClick,function(){

    var error     =  false;
    var oData       = new Object();

    var country  = oData.country =jQuery.trim(jQuery("#country").val());
    var state    = oData.state =jQuery.trim(jQuery("#state").val());
    var city     = oData.city =jQuery.trim(jQuery("#city").val());

    var accept_vouchers                        = oData.accept_vouchers=jQuery.trim(jQuery("#accept_vouchers").val());
    var wheel_chair_accessible                 = oData.wheel_chair_accessible=jQuery.trim(jQuery("#wheel_chair_accessible").val());
    var parking                                = oData.parking=jQuery.trim(jQuery("#parking").val());

    var rental_type     = oData.rental_type =jQuery.trim(jQuery("#rental_type").val());

    var price     = oData.price =jQuery.trim(jQuery("#requirement_price").val());
    //var price     = oData.price =jQuery.trim(jQuery("#price_budget").val());

    var price_range_from     = oData.price_range_from =jQuery.trim(jQuery(".range_field_from").val());
    var price_range_to     = oData.price_range_to =jQuery.trim(jQuery(".requirement_price_renge_to").val());
    var number_of_rooms     = oData.number_of_rooms =jQuery.trim(jQuery("#req_number_of_rooms").val());
    var housing_type     = oData.housing_type =jQuery.trim(jQuery("#housing_type").val());
    var allowed_pets     = oData.allowed_pets = jQuery.trim(jQuery("#allowed_pets").val());
    var pets_type     = oData.pets_type =jQuery.trim(jQuery("#requirement_pets_type").val());
    var zipcode     = oData.zipcode =jQuery.trim(jQuery("#zipcode").val());
    var id     = oData.id = '<?php echo $this->propertyRequirementData->id?>';

    var prty_country  = oData.prty_country =jQuery.trim(jQuery("#country").val());
    var prty_state    = oData.prty_state =jQuery.trim(jQuery("#administrative_area_level_1").val());
    var prty_city     = oData.prty_city =jQuery.trim(jQuery("#locality").val());
    if(prty_city == ''){
         var prty_city     = oData.prty_city =jQuery.trim(jQuery("#sublocality_level_1").val());
    }  
    var county     =  oData.county =jQuery.trim(jQuery("#sublocality_level_1").val());    
    var neighborhood     =  oData.neighborhood =jQuery.trim(jQuery("#neighborhood").val());
    var prty_zipcode    = oData.prty_zipcode =jQuery.trim(jQuery("#postal_code").val());
    var prty_latitude    = oData.prty_latitude =jQuery.trim(jQuery("#latitude").val());
    var prty_longitude    = oData.prty_longitude =jQuery.trim(jQuery("#longitude").val());
    var prty_location    = oData.prty_location =jQuery.trim(jQuery("#pac-input").val());
    var req_description     = oData.req_description = jQuery.trim(jQuery("#req_description").val());


   var is_validated = true;   
    
    if(prty_country =='' || prty_state =='' || prty_city =='' || rental_type =='' || price =='' || housing_type ==''|| allowed_pets == '' || accept_vouchers =='' || wheel_chair_accessible == '' || parking == '' || req_description == '' ){
	
     if(prty_country =='')     { jQuery('#pac-input').css('border-color','#e62828');                            }
     else                      { jQuery('#pac-input').css('border-color','#b2c6cd');                            } 
	 if(prty_state =='')       { jQuery('#pac-input').css('border-color','#e62828');        }
     else                      { jQuery('#pac-input').css('border-color','#b2c6cd');        }   
	 if(prty_city =='')        { jQuery('#pac-input').css('border-color','#e62828');                           }
     else                      { jQuery('#pac-input').css('border-color','#b2c6cd');                           }  
	 if(rental_type =='')      { jQuery('#rental_type').css('border-color','#e62828');                        }
     else                      { jQuery('#rental_type').css('border-color','#b2c6cd');                        }   
	 if(price =='')            { jQuery('#requirement_price').css('border-color','#e62828');                  }
     else                      { jQuery('#requirement_price').css('border-color','#b2c6cd');                  }   
	 if(housing_type =='')     { jQuery('#housing_type').css('border-color','#e62828');                       }
     else                      { jQuery('#housing_type').css('border-color','#b2c6cd');                       }   
	 if(allowed_pets =='')     { jQuery('#allowed_pets').css('border-color','#e62828');                       }
     else                      { jQuery('#allowed_pets').css('border-color','#b2c6cd');                       }   
	 if(accept_vouchers =='')  { jQuery('#accept_vouchers').css('border-color','#e62828');                    }
     else                      { jQuery('#accept_vouchers').css('border-color','#b2c6cd');                    }   
	 if(wheel_chair_accessible =='')     { jQuery('#wheel_chair_accessible').css('border-color','#e62828');   }
     else                       { jQuery('#wheel_chair_accessible').css('border-color','#b2c6cd');            }   
	 if(parking =='')           { jQuery('#parking').css('border-color','#e62828');                           }
     else                       { jQuery('#parking').css('border-color','#b2c6cd');                           }   
	 if(req_description =='')   { jQuery('#req_description').css('border-color','#e62828');                   }
     else                       { jQuery('#req_description').css('border-color','#b2c6cd');                   } 
	
	 jQuery('.message').text('Please fill all the fields');
     is_validated = false;
    }
    else{
		is_validated = true;
	}
    //zipcode validation
    
    if(is_validated == true){
    if(prty_zipcode !=''){    
      if(/^[A-Za-z0-9 _.-]+$/.test(prty_zipcode)) {
          is_validated = true;
          jQuery('.property_zipcode').css('border-color','#b2c6cd'); 
       }
       else {
         jQuery('.message').text('Invalid Zipcode');
         jQuery('.property_zipcode').css('border-color','#dd1616');
         is_validated = false;
        }
    }
   }    
   if(is_validated == true){
    var regex   =   /^[0-9]*$/;
    var price = jQuery('#requirement_price').val();

    if( price !='' && price !=undefined){
		if( !regex.test(price) ) {

			 jQuery(".price_validation").html("");
			 jQuery(".price_validation_msg").append("<div class='price_validation' style='color:red;margin-left:2px;font-weight: normal;'>Number Only</div>");
             jQuery('#requirement_price').css('border-color','#dd1616'); 
			 is_validated = false;
		}
		else{
			jQuery('#requirement_price').css('border-color','#b2c6cd'); 
			is_validated = true;
		}
    }		
   }   
   if(is_validated == true){
	    if(price_range_to !=''){
		if( !regex.test(price_range_to) ) {
			 jQuery(".price_validation").html("");
			 jQuery(".price_validation_msg").append("<div class='price_validation' style='color:red;margin-left:2px;font-weight: normal;'>Number Only</div>");
			 jQuery('.reqiirement_price_renge_to').css('border-color','#dd1616');
			 is_validated = false;
		}
		else{
			jQuery('.reqiirement_price_renge_to').css('border-color','#b2c6cd');
			is_validated = true;
		}

		}
   }
 if(is_validated == true){
    if(price != '' && price_range_to !=''){
        jQuery(".price_validation").html("");
        if(parseFloat(price) > parseFloat(price_range_to)){
        jQuery(".price_validation_msg").append("<div class='price_validation' style='color:red;margin-left:2px;font-weight: normal;'>Invalid Range</div>");
        jQuery('#requirement_price').css('border-color','#dd1616');
         is_validated = false;
        }
        else{
			jQuery('#requirement_price').css('border-color','#b2c6cd');
		}
    }
   }
 if(is_validated == true){
    if((price == '') && (price_range_to == '')){
		jQuery('#requirement_price').css('border-color','#dd1616');
        var is_validated =false;
    }
    else{
		jQuery('#requirement_price').css('border-color','#b2c6cd');
	}
 }
 if(is_validated == true){
    if(housing_type == 'Bedroom' && number_of_rooms =='' ){
		jQuery('#req_number_of_rooms').css('border-color','#dd1616');
        is_validated = false;
    }
    else{
		jQuery('#req_number_of_rooms').css('border-color','#b2c6cd');
	}
  }
 if(is_validated == true){
    if(allowed_pets == 'Yes' && pets_type =='' ){
        is_validated = false;
        jQuery('#requirement_pets_type').css('border-color','#dd1616');
    }
     else{
		jQuery('#requirement_pets_type').css('border-color','#b2c6cd');
	}
  }
  if(is_validated == true){
    if(housing_type=='Apartment' || housing_type=='House')    {
        if(number_of_rooms=='')
        {
        jQuery('.message').text('Please fill number of rooms');
        jQuery('#req_number_of_rooms').css('border-color','#dd1616');
        is_validated = false;
        }
         else{
			 jQuery('#req_number_of_rooms').css('border-color','#b2c6cd');
		}
    }
  }
  if(is_validated == true){
	  if(prty_country =='' || prty_state =='' || prty_city ==''){
			jQuery('.message').text('Location field should have country , state and city');
			jQuery('#pac-input').css('border-color','#dd1616');
			is_validated = false;
			}
			else{
				jQuery('#pac-input').css('border-color','#b2c6cd');
			}		
			
  }
  if(is_validated == true){
	  if(prty_zipcode == ''){		  
		 jQuery('.message').text('Please enter zipcode');
		 jQuery('.property_zipcode').css('border-color','#dd1616');
		 is_validated = false; 
	  }
  }



    if(is_validated == true){
		
	   if((price == '') ){
		   oData.price = 0;
	   }
	   if((price_range_to == '') ){
		   oData.price_range_to = 0;
	   }

        jQuery('.zipcode_validation').css('display','none');
        jQuery('.but_submit').css('display','none');
        jQuery(".loader").css("display", "block");

        var formURL    = '<?php echo $this->baseUrl(); ?>' + '/user/index/saveedittedrequirement';

         jQuery.ajax( {
                        url : formURL,
                        type: "POST",
                        dataType: 'json',
                        data : oData,
                            success: function (returndata) {
                            if(returndata.status == true){
                                jQuery(".loader").css("display", "none");
                                jQuery('.but_submit').css('display','block');
                                jQuery("#successModal .success_message").text('');
                                jQuery("#successModal .success_message").text('Your requirement has been succesfully updated');
                                jQuery("#successModal").modal('show');                              
                            }
                            else{

                            }
                            },
                            error: function(e){
                           jQuery(".loader").css("display", "none");
                           jQuery('.but_submit').css('display','block');  }

                        });
    }
    else{
        jQuery('.message').text('Please fill all the fields');       
    }

});

jQuery('body').on('click', '.range_link', function(event){

    jQuery('#price').addClass('price_range_from');
    jQuery('.price_range_input_span').show();
    jQuery('.range_span_link').html('<a href="javascript:void(0)" class="cancel_range_link"><img src="/application/modules/User/externals/images/cancel_add_range.png" alt="" title="Cancel"</a>');
    jQuery('.prty_field_budget').css('width','170px');

});

jQuery('body').on('click', '.cancel_range_link', function(event){

    jQuery('.price_range_input_span').hide();
    jQuery('#price').removeClass('price_range_from');
    jQuery('.range_span_link').html('<a href="javascript:void(0)" class="range_link"><img src="/application/modules/User/externals/images/add_range.png" alt="" title="Add Range"></a>');
    jQuery('.prty_field_budget').css('width','348px');
});


    jQuery( "#pac-input" ).keypress(function() {

     jQuery('#street_number').val('');
     jQuery('#route').val('');
     jQuery('#locality').val('');
     jQuery('#sublocality_level_1').val('');
     jQuery('#administrative_area_level_1').val('');
     jQuery('#postal_code').val('');
     jQuery('#country').val('');
     jQuery('#latitude').val('');
     jQuery('#longitude').val('');
});

jQuery('#successModal .close').on('click',function(){
 location.href = '<?php echo $this->baseUrl(); ?>' + '/requirement/'+ viewer_identity;
});
</script>
