<script src="/application/modules/User/externals/scripts/message_notififaction.js"></script>

<div class="property_requests_content generic_layout_container layout_middle">
	
	
	<div class="package_content">
	
	
	<div id="profile_status">

		 <div class="property_status">	
		  <span style="font-size: 26px;">
			 Choose a package
		  </span>

		</div>
    </div>
	
	
	<div class="package_choose_div">
	
	<div>You can Share your to five landlords a day for 30 days</div>
	
	<div class="package_box_div">
	
	
	<div class="package_1">
	
	<div class="package_name">
	
	Credit and Background
	
	</div>
	<div class="package_rate">
	
	$49.99
	
	</div>
	
	<div class="package_title">
	
	Credit and Background
	<span class="normal" style="color: #0f0;display:none">✔</span>
	</div>
	
	</div>
	
	<div class="package_2">
	
	<div class="package2_name">
	
	+ eviction
	
	</div>
	<div class="package_rate">
	
	$59.99
	
	</div>
	
	<div class="package_title">
	
	Credit , background with eviction
	<span class="normal" style="color: #0f0;display:none">✔</span>
	</div>
	</div>
	
	
	</div>
	
	<div class="package_text"> Add your transunion score for an additional $9.99</div>
	<div class="add_score_btn_div">
	
	<button class="add_score_btn" style="float: left;">Add My Score  </button>
	<span class="normal" style="color: #0f0;display:none">✔</span>
	</div>
	</div>
	
	</div>
	
	<div class="payment_content_div">
	
	<span class="payment-errors" style="color:red"></span>
	<form method="POST" id="payment-form">
		
	<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Card Number <span style="color:red">*</span></span>    
					<input name="card_number" type="text" maxlength="65" placeholder="" id="card_number" class="prty_field" autofocus data-stripe="number">
	</div> <br>
	<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Expiration (MM/YY) <span style="color:red">*</span></span>    
					<input name="expiration_month" type="text" maxlength="2" placeholder="" id="expiration_month" class="prty_field" autofocus size="2" data-stripe="exp_month">
					<span> / </span>
                   <input name="expiration_year" type="text" id="expiration_year" maxlength="2" size="2" data-stripe="exp_year" class="prty_field">
	</div> <br>
	<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">CVC <span style="color:red">*</span></span>    
					<input name="expiration" type="text" maxlength="4" placeholder="" id="expiration" class="prty_field" autofocus size="4" data-stripe="cvc">
	</div> <br>
	
	<input type="text" value="" name="selected_packagerate" class="selected_packagerate">
	<input type="text" value="" name="selected_package" class="selected_package">
	<input type="text" value="0" name="score" class="score">
	
	<div class="pro_field_wrapper">
	<span class="prty_lablel pro_label"></span>
   <input type="submit" class="submit" value="Submit Payment">
   <div class="loader" style="display:none;"></div> 
    </form>
</div>
	

</div>	
	
<script type="text/javascript" src="https://js.stripe.com/v2/"></script>

<script type="text/javascript">

	jQuery('body').on('click', '.package_1', function(event){
		
		jQuery('.package_1 .normal').css('display','block');
		jQuery('.package_2 .normal').css('display','none');
		jQuery('.selected_packagerate').val('49.99');
		jQuery('.selected_package').val('credit_and_ackground');
		
	});
	jQuery('body').on('click', '.package_2', function(event){
		
		jQuery('.package_1 .normal').css('display','none');
		jQuery('.package_2 .normal').css('display','block');
		jQuery('.selected_packagerate').val('59.99');
		jQuery('.selected_package').val('credit_background_eviction');
		
	});
	jQuery('body').on('click', '.add_score_btn', function(event){
		
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
	

		
var form = jQuery('#payment-form');
form.submit(function(event) { //alert(1);
			
			// stripe test 4242 4242 4242 4242
			jQuery('.payment-errors').text("");
	 
			event.preventDefault();
			
			var selected_packagerate = jQuery('.selected_packagerate').val();
			var selected_package = jQuery('.selected_package').val();
			var score            = jQuery('.score').val();
			
			var validated = true;
			
			if(selected_package ==''){
				
				jQuery('.payment-errors').text('Please select package');
				validated = false;
				
			}
			else{
				validated = true;
				
			}
			
			if(validated == true){
				
			// Disable the submit button to prevent repeated clicks:
			form.find('.submit').prop('disabled', true); 
			jQuery('.submit').css('display','none');
			jQuery('.loader').css('display','block');
			
		
			// Request a token from Stripe:
			Stripe.card.createToken(form, stripeResponseHandler);
				
			}
			
			
		
		 
			// Prevent the form from being submitted:
			return false;
		
	    });
	  
	

function stripeResponseHandler(status, response) {
	  // Grab the form:
	  var form = jQuery('#payment-form'); console.log(form);
	
	  if (response.error) { // Problem!
	    console.log(response.error.message);
		// Show the errors on the form:
		jQuery('.payment-errors').text(response.error.message);
		form.find('.submit').prop('disabled', false); // Re-enable submission
		jQuery('.submit').css('display','block');
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


</script>
