//jQuery(function() {
		
		var form = jQuery('#payment-form');
		 form.submit(function(event) {alert(1);
	
	//	jQuery("#payment_submit_btn").click(function( event ) {alert(1);
		

			 
	    event.preventDefault();
			  // Disable the submit button to prevent repeated clicks:
		//$form.find('.submit').prop('disabled', true); 
		
	
		// Request a token from Stripe:
		Stripe.card.createToken(form, stripeResponseHandler);
	    alert(3);
		// Prevent the form from being submitted:
		return false;
		
	   });
	  
	//});

function stripeResponseHandler(status, response) {alert(7);
	  // Grab the form:
	  var form = jQuery('#payment-form');
	
	  if (response.error) { // Problem!
	
		// Show the errors on the form:
		form.find('.payment-errors').text(response.error.message);
		form.find('.submit').prop('disabled', false); // Re-enable submission
	
	  } else { // Token was created!
	
		// Get the token ID:
		var token = response.id;

		// Insert the token ID into the form so it gets submitted to the server:
		form.append($('<input type="hidden" name="stripeToken">').val(token));
	
		// Submit the form:
		form.get(0).submit();
	  }
	};
