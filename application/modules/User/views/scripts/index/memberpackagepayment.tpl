<?php
$settings = Engine_Api::_()->getApi('settings', 'core');
$viewHelperObj  = $this->getHelper('SmartmoveApi');
$StateArray     = $viewHelperObj->getState();
?>

<div class="member_package_payment generic_layout_container layout_middle">
<h1 style="text-align: center;">Payment process</h1>
	
	<div>
	<div class="payment_content_div">

    <span class="payment-errors" style="color:red"></span>	
    
    <form method="POST" id="payment-form123">
	<div style="text-align: center;
    font-size: 15px;
    font-weight: 600;
    padding: 0px 0px 12px 0px;
    color: #808080;">Card holders info</div>
    <div class="div_section">
    <div class="pro_field_wrapper">
                   <!--<div class="profield_label">First Name <span style="color:red;font-weight: bolder;">*</span> </div>-->
                   
    <input name="cardholder_name" type="text" maxlength="65" placeholder="First Name" id="cardholder_name" class="prty_field input-box" autofocus data-stripe="name" value="<?php echo $this->CardholderdetailsData->first_name;?>">
                    
    </div>
    <div class="pro_field_wrapper">
                    <!--<div class="profield_label">Last Name<span style="color:red;font-weight: bolder;">*</span> </div>-->
                    <input name="last_name" type="text" maxlength="65" placeholder="Last Name" id="last_name" class="prty_field input-box" autofocus data-stripe="number" value="<?php echo $this->CardholderdetailsData->last_name;?>">
                    
     </div> <br>
    </div>
    <div class="div_section">
    <div class="pro_field_wrapper">
		         <!--<div class="profield_label">State<span style="color:red;font-weight: bolder;">*</span> </div>-->
                <select name="cardholderState" id="cardholderState"   class="prty_field input-box">
                    <option value="">State</option>
                    <?php foreach($StateArray as $key =>$value):?>
                         <option value="<?php echo $key;?>"><?php echo $value;?></option>
                    <?php endforeach;?>
                </select>              
    </div> 
        <div class="pro_field_wrapper">
               <!-- <div class="profield_label">City<span style="color:red;font-weight: bolder;">*</span> </div>-->
                <select name="cardholderCity" id="cardholderCity"  class="prty_field input-box" maxlength="50">
                <option value="">City</option>
                    </select>
    </div> <br>
     </div>
     <div class="div_section">
    <div class="pro_field_wrapper">
		            <!--<div class="profield_label">Street<span style="color:red;font-weight: bolder;">*</span> </div>-->
                    <input name="street" type="text" maxlength="65" placeholder="Street" id="street" class="prty_field input-box" autofocus data-stripe="number" value="<?php echo $this->CardholderdetailsData->street;?>">
                    
    </div> 

    
    <div class="pro_field_wrapper">
		           <!-- <div class="profield_label">Zipcode<span style="color:red;font-weight: bolder;">*</span> </div>-->
                    <input name="zipcode" type="text" maxlength="5" placeholder="Zipcode" id="zipcode" class="prty_field input-box" autofocus data-stripe="number" value="<?php echo $this->CardholderdetailsData->zipcode;?>">
    </div> <br>
   </div>
    <hr>
    <div style="padding: 0px 0px 0px 12px;float: left;">
	<img src="/application/modules/User/externals/images/mc_vrt_opt_pos_73_1x.png" width="38px" height="" >
	<img src="/application/modules/User/externals/images/visa-us-vector-logo.png" width="38px" height="" >
	</div>
    <div style="    text-align: center;
    font-size: 15px;
    font-weight: 600;
    padding: 5px 0px 12px 0px;
    color: #808080;margin-right: 81px;">Card info</div>

   <div class="div_section" style="clear: both;">
    <div class="pro_field_wrapper">
		            <!--<div class="profield_label">Card Number<span style="color:red;font-weight: bolder;">*</span> </div> -->
                    <input name="card_number" type="text" maxlength="65" placeholder="Card Number" id="card_number" class="prty_field input-box" autofocus data-stripe="number" value="<?php echo $this->CardholderdetailsData->card_number;?>">
    </div>
    <div class="pro_field_wrapper">
                  <!--  <div class="profield_label">Expiration(MM/YY)<span style="color:red;font-weight: bolder;">*</span> </div> -->
                    <input name="expiration_month" type="text" maxlength="2" placeholder="Expiration (MM)" id="expiration_month" class="prty_field input-box" autofocus size="2" data-stripe="exp_month" style="margin-right: 57px;" value="<?php echo $this->CardholderdetailsData->expiration_month;?>">
          
                   <input name="expiration_year" type="text" placeholder="Expiration (YY)" id="expiration_year" maxlength="2" size="2" data-stripe="exp_year" class="prty_field input-box" value="<?php echo $this->CardholderdetailsData->expiration_year;?>">
 
    </div> <br>
    </div>
     <div class="div_section">
    <div class="pro_field_wrapper">
		          <!-- <div class="profield_label">CVC<span style="color:red;font-weight: bolder;">*</span> </div> -->
                    <input name="expiration" type="text" maxlength="4" placeholder="CVC" id="expiration" class="prty_field input-box" autofocus size="4" data-stripe="cvc" value="<?php echo $this->CardholderdetailsData->cvc;?>">
    </div> <br>
  </div>
    <input type="hidden" value="" name="selected_packagerate" class="selected_packagerate">
    <input type="hidden" value="" name="selected_package" class="selected_package">
    <input type="hidden" value="0" name="score" class="score">


   <input type="submit" class="submit submit_payment" value="Submit Payment">
   <div class="loader" style="display:none;"></div>
   
  
    </form>
</div>

<div class="package_content" >
		<?php if(isset($_SESSION['userpackage'])):?>	
			<?php if($_SESSION['userpackage'] == 'landlord_pro_package'):?>
			<div class="package1 landlord_pro_package"> 
			      <div class="part1"> Landlord Pro</div>
                  <div class="part2">Premium upgrade to scout master</div>
                  <div class="part2">Free video interviews</div>
                  <div class="part2">10 listing at a time</div>
                  <div class="part2">Upgrade to document pro</div>
                  <div class="part2">Email support</div>
                  <div class="part2">
					  <span style="font-size: 20px;"><?php echo '$' . $settings->user_landlordProPrice ; ?></span><br>
					   <span style="color: #999;">per month </span>			  
				 </div>
					 
			</div>
		<?php endif;?>
			<?php if($_SESSION['userpackage'] == 'management_gold_package'):?>
			<div class="package1 management_gold_package"> 
			     <div class="part1"> Management Gold</div>
                  <div class="part2">Landlord Pro features</div>
                  <div class="part2">Upto 100 listing at a time</div>
                  <div class="part2">Assign account manager</div>
                  <div class="part2">
					  <span style="font-size: 20px;"><?php echo '$' . $settings->user_managementGoldPrice ; ?></span><br>
					    <span style="color: #999;">per month </span>
				 </div>
			
			</div>
		<?php endif;?>
		<?php endif;?>
	</div>

</div>
<!-- Begin DigiCert site seal HTML and JavaScript -->
<div id="DigiCertClickID_g3wGrxJ9" data-language="en">
     <a href="https://www.digicert.com/ev-ssl-certification.htm"></a>
</div>
</div>	
<script type="text/javascript">
     var __dcid = __dcid || [];__dcid.push(["DigiCertClickID_g3wGrxJ9", "10", "m", "black", "g3wGrxJ9"]);
     (function(){var cid=document.createElement("script");
     cid.async=true;
     cid.src="https://seal.digicert.com/seals/cascade/seal.min.js";
     var s = document.getElementsByTagName("script");
     var ls = s[(s.length - 1)];
     ls.parentNode.insertBefore(cid, ls.nextSibling);
     }());
</script>
<!--<script type="text/javascript" src="https://js.stripe.com/v2/"></script>-->
<script type="text/javascript">
jQuery('#payment-form123 #cardholderState').val('<?php echo $this->CardholderdetailsData->state;?>');	
jQuery( "#cardholderState" ).change(function() {
  var url = '<?php echo $this->baseUrl(); ?>' + '/user/index/getcitywithstateabbreviations';
  var state_abbr    =   jQuery('#cardholderState').val();
    jQuery('#cardholderCity').html('<option value="Loading">Loading...</option>');
          jQuery.ajax({
                     url:  url,
                    data: "state_abbr="+state_abbr,
                    dataType: 'json',
                    type: 'POST',
                 success: function (data) { 
					var i=1; 
                    jQuery.each(data, function (i, item) {
                    jQuery('#cardholderCity').append(jQuery('<option>', {
                        value: item.city,
                        text : item.city
                    }));
                    i=i+1;
						if(i==data.length){
							jQuery("#cardholderCity option[value='Loading']").remove();
							jQuery('#cardholderCity').prepend('<option selected value="">Select City</option>');
						}
                });},
                   error: function(e){   }
                });
});

var state_abbr    =   jQuery('#cardholderState').val();
if(state_abbr  != ''){
  var url = '<?php echo $this->baseUrl(); ?>' + '/user/index/getcitywithstateabbreviations';
  var state_abbr    =   jQuery('#cardholderState').val();
    jQuery('#cardholderCity').html('<option value="Loading">Loading...</option>');
          jQuery.ajax({
                     url:  url,
                    data: "state_abbr="+state_abbr,
                    dataType: 'json',
                    type: 'POST',
                 success: function (data) { 
					var i=1; 
                    jQuery.each(data, function (i, item) {
                    jQuery('#cardholderCity').append(jQuery('<option>', {
                        value: item.city,
                        text : item.city
                    }));
                    i=i+1;
						if(i==data.length){
							jQuery("#cardholderCity option[value='Loading']").remove();
							jQuery('#cardholderCity').prepend('<option selected value="">Select City</option>');
							jQuery('#payment-form123 #cardholderCity').val('<?php echo $this->CardholderdetailsData->city;?>');
						}
                });},
                   error: function(e){   }
                });

}

//Stripe.setPublishableKey('<?php echo $this->params['public_live_key']; ?>');
var form = jQuery('#payment-form123');
form.submit(function(event) {
 event.preventDefault();
 
            var card_number                = jQuery('#payment-form123 #card_number').val();
            var expiration_month           = jQuery('#payment-form123 #expiration_month').val();
            var expiration_year            = jQuery('#payment-form123 #expiration_year').val();
            var expiration                 = jQuery('#payment-form123 #expiration').val();
            var cardholder_name            = jQuery('#payment-form123 #cardholder_name').val();
            var last_name                  = jQuery('#payment-form123 #last_name').val();
            var street                     = jQuery('#payment-form123 #street').val();
            var city                       = jQuery('#payment-form123 #cardholderCity').val();
            var state                      = jQuery('#payment-form123 #cardholderState').val();
            var zipcode                    = jQuery('#payment-form123 #zipcode').val();
            var validated = true;
            
            jQuery('#global_page_user-index-memberpackagepayment #cardholder_name').css('border-color','#b2c6cd');
			jQuery('#global_page_user-index-memberpackagepayment #last_name').css('border-color','#b2c6cd'); 
			jQuery('#global_page_user-index-memberpackagepayment #street').css('border-color','#b2c6cd'); 
			jQuery('#global_page_user-index-memberpackagepayment #cardholderCity').css('border-color','#b2c6cd'); 
			jQuery('#global_page_user-index-memberpackagepayment #cardholderState').css('border-color','#b2c6cd'); 
			jQuery('#global_page_user-index-memberpackagepayment #zipcode').css('border-color','#b2c6cd'); 
			jQuery('#global_page_user-index-memberpackagepayment #card_number').css('border-color','#b2c6cd'); 
			jQuery('#global_page_user-index-memberpackagepayment #expiration_month').css('border-color','#b2c6cd'); 
			jQuery('#global_page_user-index-memberpackagepayment #expiration_year').css('border-color','#b2c6cd');  
			jQuery('#global_page_user-index-memberpackagepayment #expiration').css('border-color','#b2c6cd'); 

			  
			 if(cardholder_name == ''){
                jQuery('.payment-errors').text('Please enter cardholder name');
                jQuery('#global_page_user-index-memberpackagepayment #cardholder_name').css('border-color','#e62828'); 
                validated = false;
            }
            else if(last_name == ''){
                jQuery('.payment-errors').text('Please enter last name');
                jQuery('#global_page_user-index-memberpackagepayment #last_name').css('border-color','#e62828'); 
                validated = false;
            }
            else if(state == ''){
                jQuery('.payment-errors').text('Please enter state');
                jQuery('#global_page_user-index-memberpackagepayment #cardholderState').css('border-color','#e62828'); 
                validated = false;
            }
            else if(city == ''){
                jQuery('.payment-errors').text('Please enter city');
                jQuery('#global_page_user-index-memberpackagepayment #cardholderCity').css('border-color','#e62828');  
                validated = false;
            }
            else if(street == ''){
                jQuery('.payment-errors').text('Please enter street');
                jQuery('#global_page_user-index-memberpackagepayment #street').css('border-color','#e62828'); 
                validated = false;
            }
            else if(zipcode == ''){
                jQuery('.payment-errors').text('Please enter zipcode');
                jQuery('#global_page_user-index-memberpackagepayment #zipcode').css('border-color','#e62828');    
                validated = false;
            }

            else if(card_number == ''){
                jQuery('.payment-errors').text('Please enter card number');
                jQuery('#global_page_user-index-memberpackagepayment #card_number').css('border-color','#e62828');  
                validated = false;
            }
            else if(expiration_month == ''){
                jQuery('.payment-errors').text('Please enter expiration month');
                jQuery('#global_page_user-index-memberpackagepayment #expiration_month').css('border-color','#e62828');  
                validated = false;
            }
            else if(expiration_year == ''){
                jQuery('.payment-errors').text('Please enter expiration year');
                jQuery('#global_page_user-index-memberpackagepayment #expiration_year').css('border-color','#e62828');  
                validated = false;
            }
            else if(expiration == ''){
                jQuery('.payment-errors').text('Please enter cvc');
                jQuery('#global_page_user-index-memberpackagepayment #expiration').css('border-color','#e62828');  
                validated = false;
            }
            else{
                validated = true;
            }

			 
            
              //Zip validation     
     if(validated ==  true){		
		if(zipcode != ''){
			 jQuery('.payment-errors').text('');
		    if(/([0-9]{5})+$/.test(zipcode)) {			 
             validated =true;
			}
			else {
			 jQuery(".payment-errors").text('Please enter valid zipcode');
			 validated =false;
			}
		}
    } 
            
            if(validated == true){
            // Disable the submit button to prevent repeated clicks:
            form.find('.submit').prop('disabled', true);
            jQuery('.submit').hide();
            jQuery('.loader').css('display','block');
            // Request a token from Stripe:
            Stripe.card.createToken(form, stripeResponseHandler);
             // Prevent the form from being submitted:
            return false;    
            }
 
});
function stripeResponseHandler(status, response) {
      // Grab the form:
      var form = jQuery('#payment-form123'); console.log(form);

      if (response.error) { // Problem!
		  
		  
		if(response.error.message=="The card number is not a valid credit card number.")
		{
			 jQuery('#global_page_user-index-memberpackagepayment #card_number').css('border-color','#e62828');
			 jQuery('#global_page_user-index-memberpackagepayment .submit_payment').css('display','table-column !important'); 
 
			  
		}else{
				jQuery('#global_page_user-index-memberpackagepayment #card_number').css('border-color','#b2c6cd');
		}

		if(response.error.message=="Your card's expiration month is invalid.")
		{
			 jQuery('#global_page_user-index-memberpackagepayment #expiration_month').css('border-color','#e62828'); 
		}else{
				jQuery('#global_page_user-index-memberpackagepayment #expiration_month').css('border-color','#b2c6cd');
		}
		if(response.error.message=="Your card's security code is invalid.")
		{
			 jQuery('#global_page_user-index-memberpackagepayment #expiration').css('border-color','#e62828'); 
		}else{
				jQuery('#global_page_user-index-memberpackagepayment #expiration').css('border-color','#b2c6cd');
		}
		

        console.log(response.error.message);
        // Show the errors on the form:
        jQuery('.payment-errors').text(response.error.message);
        form.find('.submit').prop('disabled', false); // Re-enable submission
        jQuery('.submit').show();
        jQuery('.loader').css('display','none');

      } else { // Token was created!

        // Get the token ID:
        var token = response.id;

        // Insert the token ID into the form so it gets submitted to the server:
        form.append(jQuery('<input type="hidden" name="stripeToken" id="stripeToken">').val(token));

        // Submit the form:
       // form.get(0).submit();
       
             var oData       = new Object();
	         oData.card_number                = jQuery('#payment-form123 #card_number').val();
             oData.expiration_month           = jQuery('#payment-form123 #expiration_month').val();
             oData.expiration_year            = jQuery('#payment-form123 #expiration_year').val();
             oData.cvc                        = jQuery('#payment-form123 #expiration').val();
             oData.cardholder_name            = jQuery('#payment-form123 #cardholder_name').val();
             oData.last_name                  = jQuery('#payment-form123 #last_name').val();
             oData.street                     = jQuery('#payment-form123 #street').val();
             oData.city                       = jQuery('#payment-form123 #cardholderCity').val();
             oData.state                      = jQuery('#payment-form123 #cardholderState').val();
             oData.zipcode                    = jQuery('#payment-form123 #zipcode').val();
             oData.stripeToken                = jQuery('#payment-form123 #stripeToken').val();
	  var url    =   '<?php echo $this->baseUrl()?>' + '/user/index/saveuserpacakgepayment';
      jQuery.ajax({
                        url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
                        success: function (data) {
                        if(data.status == true){
                                jQuery("#successModal .success_message").text('');
                                jQuery("#successModal .success_message").text('Your package has been upgraded');
                                jQuery("#successModal").modal('show');
                        }
                        else{
                           
                        }
                     },
                       error: function(e){}
                });
      }
    };
 jQuery('#successModal .close').on('click',function(){
 location.href = '<?php echo $this->baseUrl(); ?>' + '/manage/subscription';
});
</script>
