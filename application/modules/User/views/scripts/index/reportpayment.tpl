<script src="/application/modules/User/externals/scripts/message_notififaction.js"></script>
<script>
<?php $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); 
$viewHelperObj  = $this->getHelper('SmartmoveApi');
$StateArray     = $viewHelperObj->getState();
?>

var viewer_identity='<?php echo $viwer_id; ?>';
</script>

<div class="property_requests_content generic_layout_container layout_middle">


    <div class="package_content">
   
    <div id="profile_status1">

         <div class="property_status">
          <span style="font-size: 26px;">
             Choose a package
          </span>

        </div>
    </div>

  

    <div class="package_choose_div">
		 <div class="err_message" style="color:red"><?php echo $_SESSION['err_message'];?></div>

    <div class="paymentpkg">You can Share your report to five landlords a day for <?php echo $this->payment_duration;?> days</div>

    <div class="package_box_div1">
    <div class="package_box_div">


    <div class="package_1">

    <div class="package_name">

    Credit and Background

    </div>
    <div class="package_rate">

    $<?php echo  $this->credit_and_background_payment_amount;?>

    </div>

    <div class="package_title">

    Credit and Background
    <span class="normal" style="color: #0f0;display:none;font-size: 28px;">✔</span>
    </div>

    </div>

    <div class="package_2">

    <div class="package2_name">

    + eviction

    </div>
    <div class="package_rate">

    $<?php echo  $this->creditbackground_eviction_payment_amount;?>

    </div>

    <div class="package_title">

    Credit , background with eviction
    <span class="normal" style="color: #0f0;display:none;font-size: 28px;">✔</span>
    </div>
    </div>


    </div>

    <div class="package_text"> Add your transunion score for an additional $<?php echo  $this->creditscore_payment_amount;?></div>
    <div class="add_score_btn_div">

    <button class="add_score_btn" style="float: left;">Add My Score  </button>
    <span class="normal" style="color: #0f0;display:none;font-size: 28px;">✔</span>
    </div>
    </div>
    </div>

    </div>

    <div class="payment_content_div">

    <span class="payment-errors" style="color:red"></span>
    <div >
    <form method="POST" id="reportpayment-form">
	<div style="text-align: center;
    font-size: 15px;
    font-weight: 600;
    padding: 0px 0px 12px 0px;
    color: #808080;">Card holders info</div>
	<div class="div_section">

    <div class="pro_field_wrapper">
                   <!-- <div class="profield_label">First Name <span style="color:red;font-weight: bolder;">*</span> </div>-->
                    <input name="cardholder_name" type="text" maxlength="65" placeholder="First Name" id="cardholder_name" class="prty_field input-box" autofocus data-stripe="name">
    </div> 
    <div class="pro_field_wrapper">
                    <!--<div class="profield_label">Last Name<span style="color:red;font-weight: bolder;">*</span> </div>-->
                    <input name="last_name" type="text" maxlength="65" placeholder="Last Name" id="last_name" class="prty_field input-box" autofocus data-stripe="number">
    </div> <br>
    </div>
    <div class="div_section">
    <div class="pro_field_wrapper">
    <!--<div class="profield_label">State<span style="color:red;font-weight: bolder;">*</span> </div>-->
                <select name="LandlordState" id="LandlordState"   class="prty_field input-box" data-stripe="address_state">
                    <option value="">State</option>
                    <?php foreach($StateArray as $key =>$value):?>
                                                         <option value="<?php echo $key;?>"><?php echo $value;?></option>
                    <?php endforeach;?>
                </select>
    </div>
        <div class="pro_field_wrapper">

   <!--<div class="profield_label">City<span style="color:red;font-weight: bolder;">*</span> </div>-->

                <select name="LandlordCity" id="LandlordCity"  class="prty_field input-box" maxlength="50" data-stripe="address_city">
                <option value="">City</option>
                    </select>
    </div> <br>
    </div>
    <div class="div_section">
    <div class="pro_field_wrapper">
                    <!--<div class="profield_label">Street<span style="color:red;font-weight: bolder;">*</span> </div>-->
                    <input name="street" type="text" maxlength="65" placeholder="Street" id="street" class="prty_field input-box" autofocus data-stripe="address_line1">
    </div>

    
    <div class="pro_field_wrapper">
                   <!-- <div class="profield_label">Zipcode<span style="color:red;font-weight: bolder;">*</span> </div>-->
                    <input name="zipcode" type="text" maxlength="65" placeholder="Zipcode" id="zipcode" class="prty_field input-box" autofocus data-stripe="address_zip">
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
                     <!--<div class="profield_label">Card Number<span style="color:red;font-weight: bolder;">*</span> </div>--> 
                    <input name="card_number" type="text" maxlength="65" placeholder="Card Number" id="card_number" class="prty_field input-box" autofocus data-stripe="number">
    </div> 
    <div class="pro_field_wrapper">
                    <!--<div class="profield_label">Expiration(MM/YY)<span style="color:red;font-weight: bolder;">*</span> </div>--> 
                    <input name="expiration_month" type="text" maxlength="2" placeholder="Expiration (MM)" id="expiration_month" class="prty_field input-box" autofocus size="2" data-stripe="exp_month" style="margin-right: 57px;">
                   <input name="expiration_year" type="text" id="expiration_year" placeholder="Expiration (YY)" maxlength="2" size="2" data-stripe="exp_year" class="prty_field input-box">
    </div> <br>
     </div> 
     <div class="div_section">
    <div class="pro_field_wrapper">
                  <!-- <div class="profield_label">CVC<span style="color:red;font-weight: bolder;">*</span> </div> -->
                    <input name="expiration" type="text" maxlength="4" placeholder="CVC" id="expiration" class="prty_field input-box" autofocus size="4" data-stripe="cvc">
    </div> <br>
   </div>
    <input type="hidden" value="" name="selected_packagerate" class="selected_packagerate">
    <input type="hidden" value="" name="selected_package" class="selected_package">
    <input type="hidden" value="0" name="score" class="score">


   <input type="submit" class="submit" value="Submit Payment">
   <div class="loader" style="display:none;"></div>
   
  
    </form>
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

<script type="text/javascript">

    jQuery('.package_1').on('click',function(){

        jQuery('.package_1 .normal').css('display','block');
        jQuery('.package_2 .normal').css('display','none');
        jQuery('.selected_packagerate').val('<?php echo  $this->credit_and_background_payment_amount;?>');
        jQuery('.selected_package').val('credit_and_background');

    });
    jQuery('.package_2').on('click',function(){

        jQuery('.package_1 .normal').css('display','none');
        jQuery('.package_2 .normal').css('display','block');
        jQuery('.selected_packagerate').val('<?php echo  $this->creditbackground_eviction_payment_amount;?>');
        jQuery('.selected_package').val('credit_background_eviction');

    });

	jQuery('.add_score_btn').on('click',function(){

    if(!jQuery('.add_score_btn').hasClass('checked')){

        jQuery('.add_score_btn').addClass('checked');
        jQuery('.score').val('1');
        jQuery('.add_score_btn_div .normal').css('display','block');


    }
    else{
        jQuery('.add_score_btn').removeClass('checked');
        jQuery('.score').val('0');
        jQuery('.add_score_btn_div .normal').css('display','none');
    }
    });

Stripe.setPublishableKey('<?php echo $this->params['public_live_key']; ?>');
//Stripe.setPublishableKey('<?php echo $this->params['public_test_key']; ?>');

var form = jQuery('#reportpayment-form');
form.submit(function(event) {

            // stripe test 4242 4242 4242 4242
            jQuery('.payment-errors').text("");
            event.preventDefault();
            var selected_packagerate = jQuery('.selected_packagerate').val();
            var selected_package = jQuery('.selected_package').val();
            var score            = jQuery('.score').val();
            var card_number                = jQuery('#reportpayment-form #card_number').val();
            var expiration_month           = jQuery('#reportpayment-form #expiration_month').val();
            var expiration_year            = jQuery('#reportpayment-form #expiration_year').val();
            var expiration                 = jQuery('#reportpayment-form #expiration').val();
            var cardholder_name            = jQuery('#reportpayment-form #cardholder_name').val();
            var last_name                  = jQuery('#reportpayment-form #last_name').val();
            var street                     = jQuery('#reportpayment-form #street').val();
            var city                       = jQuery('#reportpayment-form #LandlordCity').val();
            var state                      = jQuery('#reportpayment-form #LandlordState').val();
            var zipcode                    = jQuery('#reportpayment-form #zipcode').val();
         //   var billing_address            = jQuery('#billing_address').val();
            var validated = true;
            
            jQuery('#global_page_user-index-reportpayment #cardholder_name').css('border-color','#b2c6cd');
			jQuery('#global_page_user-index-reportpayment #last_name').css('border-color','#b2c6cd'); 
			jQuery('#global_page_user-index-reportpayment #street').css('border-color','#b2c6cd'); 
			jQuery('#global_page_user-index-reportpayment #LandlordCity').css('border-color','#b2c6cd'); 
			jQuery('#global_page_user-index-reportpayment #LandlordState').css('border-color','#b2c6cd'); 
			jQuery('#global_page_user-index-reportpayment #zipcode').css('border-color','#b2c6cd'); 
			jQuery('#global_page_user-index-reportpayment #card_number').css('border-color','#b2c6cd'); 
			jQuery('#global_page_user-index-reportpayment #expiration_month').css('border-color','#b2c6cd'); 
			jQuery('#global_page_user-index-reportpayment #expiration_year').css('border-color','#b2c6cd');  
			jQuery('#global_page_user-index-reportpayment #expiration').css('border-color','#b2c6cd'); 
            
            
            if(selected_package ==''){
                jQuery('.payment-errors').text('Please select package');
                validated = false;
            }
            else if(cardholder_name == ''){
                jQuery('.payment-errors').text('Please enter cardholder name');
                jQuery('#global_page_user-index-reportpayment #cardholder_name').css('border-color','#e62828');
                validated = false;
            }
            else if(last_name == ''){
                jQuery('.payment-errors').text('Please enter last name');
                jQuery('#global_page_user-index-reportpayment #last_name').css('border-color','#e62828');
                validated = false;
            }
            else if(state == ''){
                jQuery('.payment-errors').text('Please enter state');
                jQuery('#global_page_user-index-reportpayment #LandlordState').css('border-color','#e62828');
                validated = false;
            }
            else if(city == ''){
                jQuery('.payment-errors').text('Please enter city');
                jQuery('#global_page_user-index-reportpayment #LandlordCity').css('border-color','#e62828');
                validated = false;
            }
            else if(street == ''){
                jQuery('.payment-errors').text('Please enter street');
                jQuery('#global_page_user-index-reportpayment #street').css('border-color','#e62828');
                validated = false;
            }
            else if(zipcode == ''){
                jQuery('.payment-errors').text('Please enter zipcode');
                jQuery('#global_page_user-index-reportpayment #zipcode').css('border-color','#e62828');
                validated = false;
            }

            else if(card_number == ''){
                jQuery('.payment-errors').text('Please enter card number');
                jQuery('#global_page_user-index-reportpayment #card_number').css('border-color','#e62828');
                validated = false;
            }
            else if(expiration_month == ''){
                jQuery('.payment-errors').text('Please enter expiration month');
                jQuery('#global_page_user-index-reportpayment #expiration_month').css('border-color','#e62828');
                validated = false;
            }
            else if(expiration_year == ''){
                jQuery('.payment-errors').text('Please enter expiration year');
                jQuery('#global_page_user-index-reportpayment #expiration_year').css('border-color','#e62828');
                validated = false;
            }
            else if(expiration == ''){
                jQuery('.payment-errors').text('Please enter cvc');
                jQuery('#global_page_user-index-reportpayment #expiration').css('border-color','#e62828');
                validated = false;
            }
            else{
                validated = true;
            }

            if(validated == true){
            // Disable the submit button to prevent repeated clicks:
            form.find('.submit').prop('disabled', true);
            //jQuery('.submit').css('display','none');
            jQuery('.submit').hide();
            jQuery('.loader').css('display','block');
            // Request a token from Stripe:
            Stripe.card.createToken(form, stripeResponseHandler);    
            }
            // Prevent the form from being submitted:
            return false;
        });

function stripeResponseHandler(status, response) {
      // Grab the form:
      var form = jQuery('#reportpayment-form'); console.log(form);

      if (response.error) { // Problem!
		  
		if(response.error.message=="Your card number is incorrect.")
		{
			 jQuery('#global_page_user-index-reportpayment #card_number').css('border-color','#e62828');
			  
		}else{
				jQuery('#global_page_user-index-reportpayment #card_number').css('border-color','#b2c6cd');
		}

		if(response.error.message=="Your card's expiration month is invalid.")
		{
			 jQuery('#global_page_user-index-reportpayment #expiration_month').css('border-color','#e62828'); 
		}else{
				jQuery('#global_page_user-index-reportpayment #expiration_month').css('border-color','#b2c6cd');
		}
		if(response.error.message=="Your card's security code is invalid.")
		{
			 jQuery('#global_page_user-index-reportpayment #expiration').css('border-color','#e62828'); 
		}else{
				jQuery('#global_page_user-index-reportpayment #expiration').css('border-color','#b2c6cd');
		}
		  
		  
        console.log(response.error.message);
        // Show the errors on the form:
        jQuery('.payment-errors').text(response.error.message);
        form.find('.submit').prop('disabled', false); // Re-enable submission
        //jQuery('.submit').css('display','block');
        jQuery('.submit').show();
        jQuery('.loader').css('display','none');

      } else { // Token was created!

        // Get the token ID:
        var token = response.id;

        // Insert the token ID into the form so it gets submitted to the server:
        form.append(jQuery('<input type="hidden" name="stripeToken">').val(token));

        // Submit the form:
        form.get(0).submit();
      }
    };
jQuery('#successModal .close').on('click',function(){
 location.href='<?php echo $this->baseUrl()?>' +'/credit/background' ;
});
 jQuery( "#reportpayment-form #LandlordState" ).change(function() {
    var url           = '<?php echo $this->baseUrl(); ?>' + '/user/index/getcitywithstateabbreviations';
    var state_abbr    =   jQuery('#reportpayment-form #LandlordState').val();
    jQuery('#reportpayment-form #LandlordCity').html('<option value="Loading">Loading...</option>');
          jQuery.ajax({
                     url:  url,
                    data: "state_abbr="+state_abbr,
                    dataType: 'json',
                    type: 'POST',
                 success: function (data) {
					var i=1;
                    jQuery.each(data, function (i, item) {
                    jQuery('#reportpayment-form #LandlordCity').append(jQuery('<option>', {
                        value: item.city,
                        text : item.city
                    }));
                     i=i+1;
						if(i==data.length){
							jQuery("#reportpayment-form #LandlordCity option[value='Loading']").remove();
							jQuery('#reportpayment-form #LandlordCity').prepend('<option selected>Select City</option>');
						}
                });},
                   error: function(e){   }
                });
});
</script>
