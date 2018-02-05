<?php 
$subject        = Engine_Api::_()->core()->getSubject();
$CardholderdetailsData  =  $this->CardholderdetailsData ;
$smartmoveHelperObj  = $this->getHelper('SmartmoveApi');
$StateArray          = $smartmoveHelperObj->getState();  
?>
<h1 style="text-align: center;">Manage Subscription</h1>
<div class="manage_subscription">
           <?php echo $this->content()->renderWidget('user.profile-manage-subscription'); ?>
</div>


<!-- cancel_renewal modal start-->

<div class="modal fade" id="cancelrenewalModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content-new">
      <div class="modal-header">
        <span class="modal-title" id="exampleModalLabel"><a href="javascript:void(0)" target="_blank">Confirm</a></span>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">×</span>
        </button>
      </div>
       <div class="modal-body">
            <div class="message" style="color:#008000;padding: 0px 0px 8px 0px;display:block;"></div>
            <div class="err_msg" style="color:red"></div>
			<div class="matches_div">
			  Do you want to cancel subscription?
			  <input type="hash" name="token" value="" id="token">
			
       <div class="btn_div" style="padding-top: 12px;"><input class="submit_cancelrenewal" type="button" value="Cancel Renewal" name=""></div>
      </div>
      </div>
            <div class="loader" style="display:none"></div>
    </div>
  </div>
</div>


<!-- cancel_renewal modal end-->

<!-- Edit cardholder modal-->

<div class="modal fade" id="editcardholderModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content-new">
      <div class="modal-header">
        <span class="modal-title" id="exampleModalLabel"><a href="javascript:void(0)" target="_blank">Edit Cardholder details</a></span>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">×</span>
        </button>
      </div>
       <div class="modal-body">
            <div class="message" style="color:#008000;padding: 0px 0px 8px 0px;display:block;"></div>
            <div class="payment-errors" style="color:red"></div> 
			<div class="pro_field_wrapper" style="margin-bottom:5px;">
			<div class="prty_lablel pro_label" style="padding-bottom:12px;">First Name <span style="color:red;font-weight: bolder;">*</span>  </div>
			<input type="text" name="cardholder_fname" value="<?php echo $this->CardholderdetailsData->first_name?>" class="cardholder_fname prty_field">
           </div>
			<div class="pro_field_wrapper" style="margin-bottom:5px;">
			<div class="prty_lablel pro_label" style="padding-bottom:12px;">Last Name <span style="color:red;font-weight: bolder;">*</span>  </div>
			<input type="text" name="cardholder_lname" value="<?php echo $this->CardholderdetailsData->last_name?>" class="cardholder_lname prty_field">
           </div>
			<div class="pro_field_wrapper" style="margin-bottom:5px;">
			<div class="prty_lablel pro_label" style="padding-bottom:12px;">Street <span style="color:red;font-weight: bolder;">*</span>  </div>
			<input type="text" name="cardholder_street" value="<?php echo $this->CardholderdetailsData->street?>" class="cardholder_street prty_field">
           </div>
			<div class="pro_field_wrapper" style="margin-bottom:5px;">
			<div class="prty_lablel pro_label" style="padding-bottom:12px;">State <span style="color:red;font-weight: bolder;">*</span>  </div>
			<select name="cardholder_state" id="cardholder_state"   class="prty_field">

			  <option value="">State</option>

                    <?php foreach($StateArray as $key =>$value):?>
                                                         <option value="<?php echo $key;?>"><?php echo $value;?></option>
                    <?php endforeach;?>
           </select>
           </div>
			<div class="pro_field_wrapper" style="margin-bottom:5px;">
			<div class="prty_lablel pro_label" style="padding-bottom:12px;">City <span style="color:red;font-weight: bolder;">*</span>  </div>
			<select name="cardholder_city" id="cardholder_city"  class="prty_field  maxlength="50">
                <option value="">City</option>
            </select>
           </div>
			<div class="pro_field_wrapper" style="margin-bottom:5px;">
			<div class="prty_lablel pro_label" style="padding-bottom:12px;">Zipcode <span style="color:red;font-weight: bolder;">*</span>  </div>
			<input type="text" name="cardholder_zipcode" value="<?php echo $this->CardholderdetailsData->zipcode?>" class="cardholder_zipcode prty_field">
           </div>
			<div class="pro_field_wrapper" style="margin-bottom:5px;">
			<div class="prty_lablel pro_label" style="padding-bottom:12px;">Card Number <span style="color:red;font-weight: bolder;">*</span>  </div>
			<input type="text" name="cardholder_cardnumber" value="<?php echo $this->CardholderdetailsData->card_number?>" class="cardholder_cardnumber prty_field">
           </div>
			<div class="pro_field_wrapper" style="margin-bottom:5px;">
			<div class="prty_lablel pro_label" style="padding-bottom:12px;">Expiration Month <span style="color:red;font-weight: bolder;">*</span>  </div>
			<input type="text" name="cardholder_expirationmonth" value="<?php echo $this->CardholderdetailsData->expiration_month?>" class="cardholder_expirationmonth prty_field">
           </div>
			<div class="pro_field_wrapper" style="margin-bottom:5px;">
			<div class="prty_lablel pro_label" style="padding-bottom:12px;">Expiration Year <span style="color:red;font-weight: bolder;">*</span>  </div>
			<input type="text" name="cardholder_expirationyear" value="<?php echo $this->CardholderdetailsData->expiration_year?>" class="cardholder_expirationyear prty_field">
           </div>
			<div class="pro_field_wrapper" style="margin-bottom:5px;">
			<div class="prty_lablel pro_label" style="padding-bottom:12px;">CVC <span style="color:red;font-weight: bolder;">*</span>  </div>
			<input type="text" name="cardholder_cvc" value="<?php echo $this->CardholderdetailsData->cvc?>" class="cardholder_cvc prty_field">
           </div>
			
       <div class="btn_div" style="padding-top: 12px;"><input class="submit_cardholder" type="button" value="Save" name=""></div>
       <div class="loader" style="display:none"></div>
      </div>
     
      </div>
           
    </div>
  </div>
</div>


<!-- Edit cardholder modal-->


<script type="text/javascript">
	
jQuery( "#cardholder_state" ).change(function() {
  var url = '<?php echo $this->baseUrl(); ?>' + '/user/index/getcitywithstateabbreviations';
  var state_abbr    =   jQuery('#cardholder_state').val();
    jQuery('#cardholder_city').html('<option value="Loading">Loading...</option>');
          jQuery.ajax({
                     url:  url,
                    data: "state_abbr="+state_abbr,
                    dataType: 'json',
                    type: 'POST',
                 success: function (data) { 
					var i=1; 
                    jQuery.each(data, function (i, item) {
                    jQuery('#cardholder_city').append(jQuery('<option>', {
                        value: item.city,
                        text : item.city
                    }));
                    i=i+1;
						if(i==data.length){
							jQuery("#cardholder_city option[value='Loading']").remove();
							jQuery('#cardholder_city').prepend('<option selected value="">Select City</option>');
						}
                });},
                   error: function(e){   }
                });
});


jQuery('#cardholder_state').val('<?php echo $this->CardholderdetailsData->state;?>');


var state_abbr    =   jQuery('#cardholder_state').val(); 
if(state_abbr != ''){
	
  var url = '<?php echo $this->baseUrl(); ?>' + '/user/index/getcitywithstateabbreviations';
  var state_abbr    =   jQuery('#cardholder_state').val();
    jQuery('#cardholder_city').html('<option value="Loading">Loading...</option>');
          jQuery.ajax({
                     url:  url,
                    data: "state_abbr="+state_abbr,
                    dataType: 'json',
                    type: 'POST',
                 success: function (data) { 
					var i=1; 
                    jQuery.each(data, function (i, item) {
                    jQuery('#cardholder_city').append(jQuery('<option>', {
                        value: item.city,
                        text : item.city
                    }));
                    i=i+1;
						if(i==data.length){
							jQuery("#cardholder_city option[value='Loading']").remove();
							jQuery('#cardholder_city').prepend('<option selected value="">Select City</option>');
							jQuery('#cardholder_city').val('<?php echo $this->CardholderdetailsData->city;?>');
						}
                });},
                   error: function(e){   }
                });
}

jQuery('body').on('click', '.submit_cardholder', function(event){
  jQuery('#editcardholderModal .loader').show();	
  jQuery('#editcardholderModal .submit_cardholder').hide();	
  var subjectId  = "<?php echo $subject->getIdentity();?>";
  var first_name  = jQuery('.cardholder_fname').val();
  var last_name  = jQuery('.cardholder_lname').val();
  var street  = jQuery('.cardholder_street').val();
  var state  = jQuery('#cardholder_state').val();
  var city  = jQuery('#cardholder_city').val();
  var zipcode  = jQuery('.cardholder_zipcode').val();
  var card_number  = jQuery('.cardholder_cardnumber').val();
  var expiration_month  = jQuery('.cardholder_expirationmonth').val();
  var expiration_year  = jQuery('.cardholder_expirationyear').val();
  var cvc  = jQuery('.cardholder_cvc').val();
  var validated = true; 
  if(first_name == ''){
                jQuery('#editcardholderModal .payment-errors').text('Please enter cardholder name');
                jQuery('#editcardholderModal .cardholder_fname').css('border-color','#e62828'); 
                validated = false;
            }
            else if(last_name == ''){
                jQuery('#editcardholderModal .payment-errors').text('Please enter last name');
                jQuery('#editcardholderModal .cardholder_lname').css('border-color','#e62828'); 
                validated = false;
            }
            else if(state == ''){
                jQuery('#editcardholderModal .payment-errors').text('Please enter state');
                jQuery('#editcardholderModal .cardholder_state').css('border-color','#e62828'); 
                validated = false;
            }
            else if(city == ''){
                jQuery('#editcardholderModal .payment-errors').text('Please enter city');
                jQuery('#editcardholderModal .cardholder_city').css('border-color','#e62828');  
                validated = false;
            }
            else if(street == ''){
                jQuery('#editcardholderModal .payment-errors').text('Please enter street');
                jQuery('#editcardholderModal .cardholder_street').css('border-color','#e62828'); 
                validated = false;
            }
            else if(zipcode == ''){
                jQuery('#editcardholderModal .payment-errors').text('Please enter zipcode');
                jQuery('#editcardholderModal .cardholder_zipcode').css('border-color','#e62828');    
                validated = false;
            }

            else if(card_number == ''){
                jQuery('#editcardholderModal .payment-errors').text('Please enter card number');
                jQuery('#editcardholderModal .cardholder_cardnumber').css('border-color','#e62828');  
                validated = false;
            }
            else if(expiration_month == ''){
                jQuery('#editcardholderModal .payment-errors').text('Please enter expiration month');
                jQuery('#editcardholderModal .expiration_month').css('border-color','#e62828');  
                validated = false;
            }
            else if(expiration_year == ''){
                jQuery('#editcardholderModal .payment-errors').text('Please enter expiration year');
                jQuery('#editcardholderModal .expiration_year').css('border-color','#e62828');  
                validated = false;
            }
            else if(cvc == ''){
                jQuery('#editcardholderModal .payment-errors').text('Please enter cvc');
                jQuery('#editcardholderModal .cardholder_cvc').css('border-color','#e62828');  
                validated = false;
            }
            else{
                validated = true;
            }
  
  if(validated == true){
	  var oData               = new Object();		
	  oData.userId         = subjectId;
	  oData.first_name         = first_name;
	  oData.last_name         = last_name;
	  oData.street         = street;
	  oData.state         = state;
	  oData.city         = city;
	  oData.zipcode         = zipcode;
	  oData.card_number         = card_number;
	  oData.expiration_month         = expiration_month;
	  oData.expiration_year         = expiration_year;
	  oData.cvc                    = cvc;
      var url          = '<?php echo $this->baseUrl().'/user/index/savecardholderdata' ?>';		
			jQuery.ajax({
				url:  url,
				data: oData,						
				dataType: 'json',
				type: 'POST',
				success: function (result) { console.log(result.html);
							if(result.status == true){
                                jQuery('#editcardholderModal .loader').hide();	
                                jQuery('#editcardholderModal .submit_cardholder').show();	  
								setTimeout(function(){
									 location.reload();
							   }, 2000);
								
							}
									
				},
				error: function(e){ }  
			   });
  
  }
  else{
  jQuery('#editcardholderModal .loader').hide();	
  jQuery('#editcardholderModal .submit_cardholder').show();	  	  
  }
});

jQuery('body').on('click', '.submit_cancelrenewal', function(event){
	jQuery('#cancelrenewalModal .loader').show();	
    jQuery('#cancelrenewalModal .submit_cancelrenewal').hide();	 
	var subjectId  = "<?php echo $subject->getIdentity();?>";
	var oData               = new Object();		
	oData.userId          = subjectId;
	 var url          = '<?php echo $this->baseUrl().'/user/index/cancelpackagerenewal' ?>';		
			jQuery.ajax({
				url:  url,
				data: oData,						
				dataType: 'json',
				type: 'POST',
				success: function (result) { console.log(result.html);
							if(result.status == true){ 
								 location.reload();								
							}
									
				},
				error: function(e){ }  
			   });
	
});


</script>
