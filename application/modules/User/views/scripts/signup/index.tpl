<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: index.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */
?>

<h2>
  <?php echo ( $this->title ? $this->translate($this->title) : '' ) ?>
</h2>

<script type="text/javascript">
  function skipForm() {
    document.getElementById("skip").value = "skipForm";
    jQuery('#SignupForm').submit();
  }
  function finishForm() {
    document.getElementById("nextStep").value = "finish";
  }
</script>

<?php echo $this->partial($this->script[0], $this->script[1], array(
  'form' => $this->form
)) ?>

<script type="text/javascript">
	
	jQuery('#1_1_16-wrapper').css("display","none"); // hide credit score
	
jQuery( "#Filedata-element" ).click(function() {

jQuery('#nextStep').val('');
});

jQuery(document).ready(function()  {

	
	//jQuery("#1_6_54").prop('disabled', true);
	jQuery("#1_6_55").prop('disabled', true);
	
	//jQuery("#1_4_30").prop('disabled', true);
	//jQuery("#1_4_31").prop('disabled', true);
	jQuery("label[for=1_4_30]").addClass('mand');
	jQuery("label[for=1_4_31]").addClass('mand');
	
	jQuery("label[for=1_6_54]").addClass('mand');
	jQuery("label[for=1_6_55]").addClass('mand');
	
	
	jQuery("#1_6_64").attr('maxlength', '4');   //Years in Business 
    
    jQuery("#1_1_3").keyup(function(){		
		var charactersOnly = jQuery(this).val();
		jQuery(".validation_message_1_1_3").text("");
		if (charactersOnly.search(/[^a-zA-Z\s]+$/) === -1 && charactersOnly.length>=2 && charactersOnly.length<=50) {
        
        }
        else{
			 jQuery("#1_1_3-element").append("<div class='validation_message_1_1_3' style='color:red';margin-left:2px;>Only alphabets allowed and First Name can only contain letters and must be between 2 and 50 characters in length</div>");
			 
		} 

	});
	
	jQuery("#1_1_4").keyup(function(){		
		var charactersOnly = jQuery(this).val();
		jQuery(".validation_message_1_1_4").text("");
		if (charactersOnly.search(/[^a-zA-Z\s]+$/) === -1 && charactersOnly.length>=2 && charactersOnly.length<=50) {
        
        }
        else{
			 jQuery("#1_1_4-element").append("<div class='validation_message_1_1_4' style='color:red';margin-left:2px;>Only alphabets allowed and Last Name can only contain letters and must be between 2 and 50 characters in length</div>");
			 
		}

	});
	
    jQuery("#1_4_17").keyup(function(){		
		var charactersOnly = jQuery(this).val();
		jQuery(".validation_message_1_4_17").text("");
		if (charactersOnly.search(/[^a-zA-Z\s]+$/) === -1) {
        
        }
        else{
			 jQuery("#1_4_17-element").append("<div class='validation_message_1_4_17' style='color:red';margin-left:2px;>Only alphabets allowed</div>");
			 
		}

	});
	
	jQuery("#1_4_18").keyup(function(){		
		var charactersOnly = jQuery(this).val();
		jQuery(".validation_message_1_4_18").text("");
		if (charactersOnly.search(/[^a-zA-Z\s]+$/) === -1) {
        
        }
        else{
			 jQuery("#1_4_18-element").append("<div class='validation_message_1_4_18' style='color:red';margin-left:2px;>Only alphabets allowed</div>");
			 
		}

	});
    

    jQuery("#1_6_49").keyup(function(){		
		var charactersOnly = jQuery(this).val();
		jQuery(".validation_message_1_6_49").text("");
		if (charactersOnly.search(/[^a-zA-Z\s]+$/) === -1) {
        
        }
        else{
			 jQuery("#1_6_49-element").append("<div class='validation_message_1_6_49' style='color:red';margin-left:2px;>Only alphabets allowed</div>");
			 
		}

	});
	
	jQuery("#1_6_50").keyup(function(){		
		var charactersOnly = jQuery(this).val();
		jQuery(".validation_message_1_6_50").text("");
		if (charactersOnly.search(/[^a-zA-Z\s]+$/) === -1) {
        
        }
        else{
			 jQuery("#1_6_50-element").append("<div class='validation_message_1_6_50' style='color:red';margin-left:2px;>Only alphabets allowed</div>");
			 
		}

	});
    
});
jQuery("#1_6_64").keyup(function(){		//Years in Business
	
		var numberOnly = jQuery(this).val();
		jQuery( ".validation_message_1_6_64" ).remove();
		
		if(/^\d+$/.test(numberOnly)) {

        }
		else {
		 jQuery("#1_6_64-element").append("<div class='validation_message_1_6_64' style='color:red';margin-left:2px;>Only numbers allowed</div>");
		}
		
	});
					
		var countryurl	=	'<?php echo $this->baseUrl()?>' + '/user/signup/getcountries';
		var stateurl	=	'<?php echo $this->baseUrl()?>' + '/user/signup/getstates';
		var country_id	=	1;

					
				<!--Landlords starts---->			
			  jQuery.ajax({
						 url:  countryurl,
						
						dataType: 'json',
						type: 'POST',
					 success: function (data) { console.log(data);
						
						jQuery("#1_4_33")
						.replaceWith('<select id="1_4_33" name="1_4_33" class="" > </select>') ;
						jQuery('#1_4_33').append('<option>Select Country</option>');
						jQuery.each(data, function (i, item) {
						jQuery('#1_4_33').append(jQuery('<option>', { 
							value: item.id,
							text : item.country 
						}));
						jQuery("#1_4_33").find("option").eq(0).remove();
						
					});},
					   error: function(e){  //alert('Error: '+e);  
						   console.log(e);}  
					});
					

			 jQuery.ajax({
						url:  stateurl,
						data: "countryId="+country_id,
						dataType: 'json',
						type: 'POST',
					    success: function (data) { console.log(data);
						 jQuery("#1_4_30")
						.replaceWith('<select id="1_4_30" name="1_4_30" class="landlordstatefield""> </select>') ;
						 jQuery('#1_4_30').append('<option>Select State</option>');
						 jQuery.each(data, function (i, item) {						
						 jQuery('#1_4_30').append(jQuery('<option>', { 
							value: item.id,
							text : item.state 
						}));

					}); },
					   error: function(e){  //alert('Error: '+e); 
						   console.log(e); }  
					});
					
					
    jQuery("#1_4_31")
    .replaceWith('<select id="1_4_31" name="1_4_31" class="cityfield" > </select>') ;
	jQuery('#1_4_31').html('<option>Select City</option>');		
	
	
   jQuery('body').on('change', '.landlordstatefield', function () {
		         jQuery("#1_4_31")
					.replaceWith('<select id="1_4_31" name="1_4_31" class="cityfield" > </select>') ;
					jQuery('#1_4_31').html('<option value="Loading">Loading.....</option>');	
		 var url	=	'<?php echo $this->baseUrl()?>' + '/user/signup/getcity';
		 var state_id	=	jQuery('#1_4_30').val(); 
		//jQuery("#1_4_31").prop('disabled', false);
		
			  jQuery.ajax({
						 url:  url,
						data: "stateId="+state_id,
						dataType: 'json',
						type: 'POST',
					 success: function (data) { console.log(data);

			  //  alert(data.length); 
				var i=1;
						jQuery.each(data, function (i, item) {
							
						jQuery('#1_4_31').append(jQuery('<option>', { 
							value: item.id,
							text : item.city 
						}));
						i=i+1;
						if(i==data.length){
							jQuery("#1_4_31 option[value='Loading']").remove();
							jQuery('#1_4_31').prepend('<option selected>Select City</option>');
						}
					});},
					   error: function(e){  //alert('Error: '+e); 
						   console.log(e);
						    }  
					});
		
	});
	
	
	
	
			
					<!--Landlords ends---->	
					
	<!--tenant starts---->	
			
			  jQuery.ajax({
						 url:  countryurl,
						
						dataType: 'json',
						type: 'POST',
					 success: function (data) { console.log(data);
						
						jQuery("#1_1_75")
						.replaceWith('<select id="1_1_75" name="1_1_75" class="" > </select>') ;
						jQuery('#1_1_75').append('<option>Select Country</option>');
						jQuery.each(data, function (i, item) {
						jQuery('#1_1_75').append(jQuery('<option>', { 
							value: item.id,
							text : item.country 
						}));
						jQuery("#1_1_75").find("option").eq(0).remove();
						
					});},
					   error: function(e){  
						   console.log(e);}  
					});		
					
					
			  jQuery.ajax({
						 url:  stateurl,
						data: "countryId="+country_id,
						dataType: 'json',
						type: 'POST',
					 success: function (data) { console.log(data);
						jQuery("#1_1_76")
						.replaceWith('<select id="1_1_76" name="1_1_76" class="tenantstatefield"> </select>') ;
						 jQuery('#1_1_76').html('<option>Select State</option>');
						jQuery.each(data, function (i, item) {						
						jQuery('#1_1_76').append(jQuery('<option>', { 
							value: item.id,
							text : item.state 
						}));

					}); },
					   error: function(e){  //alert('Error: '+e); 
						   console.log(e); }  
					});
					
					
		         jQuery("#1_1_77")
				.replaceWith('<select id="1_1_77" name="1_1_77" class="cityfield" > </select>') ;
				jQuery('#1_1_77').html('<option>Select City</option>');	
				
	
	  jQuery('body').on('change', '.tenantstatefield', function () {
		  
		  		jQuery("#1_1_77")
			    .replaceWith('<select id="1_1_77" name="1_1_77" class="cityfield" > </select>') ;
			     jQuery('#1_1_77').html('<option value="Loading">Loading....</option>');
		  
		      var url	=	'<?php echo $this->baseUrl()?>' + '/user/signup/getcity';
		      var state_id	=	jQuery('#1_1_76').val(); 
			  jQuery.ajax({
						 url:  url,
						data: "stateId="+state_id,
						dataType: 'json',
						type: 'POST',
					 success: function (data) { console.log(data);

				        var i=1;
						jQuery.each(data, function (i, item) {
						jQuery('#1_1_77').append(jQuery('<option>', { 
							value: item.id,
							text : item.city 
						}));
						i=i+1;
						if(i==data.length){
							jQuery("#1_1_77 option[value='Loading']").remove();
							jQuery('#1_1_77').prepend('<option selected>Select City</option>');
						}
					});},
					   error: function(e){  
						   console.log(e); }  
					});
	  });	
	
	<!--tenant end---->	
	
	
	<!-- Repair agent-->
	
			
			  jQuery.ajax({
						 url:  countryurl,
						
						dataType: 'json',
						type: 'POST',
					 success: function (data) { console.log(data);
						
						jQuery("#1_32_101")
						.replaceWith('<select id="1_32_101" name="1_32_101" class="" > </select>') ;
						jQuery('#1_32_101').append('<option>Select Country</option>');
						jQuery.each(data, function (i, item) {
						jQuery('#1_32_101').append(jQuery('<option>', { 
							value: item.id,
							text : item.country 
						}));
						jQuery("#1_32_101").find("option").eq(0).remove();
						
					});},
					   error: function(e){  
						   console.log(e);}  
					});		
					
					
			  jQuery.ajax({
						 url:  stateurl,
						data: "countryId="+country_id,
						dataType: 'json',
						type: 'POST',
					 success: function (data) { console.log(data);
						jQuery("#1_32_102")
						.replaceWith('<select id="1_32_102" name="1_32_102" class="repairagentstatefield"> </select>') ;
						 jQuery('#1_32_102').html('<option>Select State</option>');
						jQuery.each(data, function (i, item) {						
						jQuery('#1_32_102').append(jQuery('<option>', { 
							value: item.id,
							text : item.state 
						}));

					}); },
					   error: function(e){  //alert('Error: '+e); 
						   console.log(e); }  
					});
					
					
		         jQuery("#1_32_103")
				.replaceWith('<select id="1_32_103" name="1_32_103" class="cityfield" > </select>') ;
				jQuery('#1_32_103').html('<option>Select City</option>');	
	
	 jQuery('body').on('change', '.repairagentstatefield', function () {
		  
		  		jQuery("#1_32_103")
			    .replaceWith('<select id="1_32_103" name="1_32_103" class="cityfield" > </select>') ;
			     jQuery('#1_32_103').html('<option value="Loading">Loading....</option>');
		  
		      var url	=	'<?php echo $this->baseUrl()?>' + '/user/signup/getcity';
		      var state_id	=	jQuery('#1_32_102').val(); 
			  jQuery.ajax({
						 url:  url,
						data: "stateId="+state_id,
						dataType: 'json',
						type: 'POST',
					 success: function (data) { console.log(data);

				        var i=1;
						jQuery.each(data, function (i, item) {
						jQuery('#1_32_103').append(jQuery('<option>', { 
							value: item.id,
							text : item.city 
						}));
						i=i+1;
						if(i==data.length){
							jQuery("#1_32_103 option[value='Loading']").remove();
							jQuery('#1_32_103').prepend('<option selected>Select City</option>');
						}
					});},
					   error: function(e){  
						   console.log(e); }  
					});
	  });	
	
	

</script>	
	
