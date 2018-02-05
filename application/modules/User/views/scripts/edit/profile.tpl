<script src="/application/modules/User/externals/scripts/message_notififaction.js"></script>
<script>
<?php $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); ?>

var viewer_identity='<?php echo $viwer_id; ?>';	
</script>
<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: profile.tpl 9984 2013-03-20 00:00:04Z john $
 * @author     John
 */
?>
<?php
        $viewer     = Engine_Api::_()->user()->getViewer();
		
     	$fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer); 
		if( !empty($fieldsByAlias['profile_type']) )
		{
		  $optionId = $fieldsByAlias['profile_type']->getValue($viewer);
		   $profile_type_id = $optionId->value; 
		}
?>
<?php $viewer     = Engine_Api::_()->user()->getViewer(); ?>


<div class="headline">
  <h2>
    <?php if ($this->viewer->isSelf($this->user)):?>
      <?php echo $this->translate('Edit My Profile');?>
    <?php else:?>
      <?php echo $this->translate('%1$s\'s Profile', $this->htmlLink($this->user->getHref(), $this->user->getTitle()));?>
    <?php endif;?>
  </h2>
  <div class="tabs">
    <?php
      // Render the menu
      echo $this->navigation()
        ->menu()
        ->setContainer($this->navigation)
        ->render();
    ?>
  </div>
</div>
 <?php /*<div class="generic_layout_container layout_left">
<?php
echo $this->content()->renderWidget('user.home-photo');
echo $this->content()->renderWidget('user.home-links');
?>
</div> */?>
 <div class="generic_layout_container layout_middle">
<?php
  /* Include the common user-end field switching javascript */
  echo $this->partial('_jsSwitch.tpl', 'fields', array(
      'topLevelId' => (int) @$this->topLevelId,
      'topLevelValue' => (int) @$this->topLevelValue
    ))
?>

<?php
  $this->headTranslate(array(
    'Everyone', 'All Members', 'Friends', 'Only Me',
  ));
?>
<script type="text/javascript">
  window.addEvent('domready', function() {
    en4.user.buildFieldPrivacySelector($$('.global_form *[data-field-id]'));
  });
</script>

<?php echo $this->form->render($this) ?>

</div>

<script>


//------------------landlord-------------------
jQuery("select :selected").each(function(){
    jQuery(this).parent().data("default", this);
});

/*jQuery("#1_1_5").change(function(e) {   //tenant gender
    jQuery(jQuery(this).data("default")).prop("selected", true);    
});
jQuery("#1_4_19").change(function(e) { //landlord gender
    jQuery(jQuery(this).data("default")).prop("selected", true);    
});
jQuery("#1_6_51").change(function(e) { //service gender
    jQuery(jQuery(this).data("default")).prop("selected", true);    
});*/


jQuery("#1_1_6-month").change(function(e) {   //tenant month
    jQuery(jQuery(this).data("default")).prop("selected", true);    
});
jQuery("#1_1_6-day").change(function(e) {   //tenant day
    jQuery(jQuery(this).data("default")).prop("selected", true);    
});
jQuery("#1_1_6-year").change(function(e) {   //tenant year
    jQuery(jQuery(this).data("default")).prop("selected", true);    
});

jQuery("#1_4_74-month").change(function(e) {   //landlord month
    jQuery(jQuery(this).data("default")).prop("selected", true);    
});
jQuery("#1_4_74-day").change(function(e) {   //landlord day
    jQuery(jQuery(this).data("default")).prop("selected", true);    
});
jQuery("#1_4_74-year").change(function(e) {   //landlord year
    jQuery(jQuery(this).data("default")).prop("selected", true);    
});

jQuery("#1_6_52-month").change(function(e) {   //services month
    jQuery(jQuery(this).data("default")).prop("selected", true);    
});
jQuery("#1_6_52-day").change(function(e) {   //services day
    jQuery(jQuery(this).data("default")).prop("selected", true);    
});
jQuery("#1_6_52-year").change(function(e) {   //services year
    jQuery(jQuery(this).data("default")).prop("selected", true);    
});

function showPets()
{
	var hasPet	=	jQuery("#1_1_70").val();
	if(hasPet	==	11)
	{
		jQuery("#1_1_71-wrapper").css('display','block');
		jQuery("label[for=1_1_71]").addClass('mand');
	}
	else
	{
		jQuery("#1_1_71-wrapper").css('display','none');
		jQuery("#1_1_71").val('');
	}
	
}

function showSpecialize()
{
	var edu	=	jQuery("#1_1_14").val();
	if(edu	==	18)
	{
		jQuery("#1_1_72-wrapper").css('display','block');
		jQuery("label[for=1_1_72]").addClass('mand');
		jQuery("#1_1_73-wrapper").css('display','none');
		jQuery("#1_1_73").val('');
	}
	else if(edu == 19)
	{
		jQuery("#1_1_72-wrapper").css('display','none');
		jQuery("#1_1_73-wrapper").css('display','block');
		jQuery("label[for=1_1_73]").addClass('mand');
		jQuery("#1_1_72").val('');
	}
	else
	{
		jQuery("#1_1_72-wrapper").css('display','none');
		jQuery("#1_1_73-wrapper").css('display','none');
		jQuery("#1_1_72").val('');
		jQuery("#1_1_73").val('');
	}
	
}


jQuery( document ).ready(function() {
jQuery('#1_1_66-wrapper').append('<div class="textar2"><div>');	
	
	jQuery("label[for=1_4_30]").addClass('mand');
	jQuery("label[for=1_4_31]").addClass('mand');
	
	jQuery("label[for=1_6_54]").addClass('mand');
	jQuery("label[for=1_6_55]").addClass('mand');
	/*jQuery("#1_1_5").attr("disabled", "disabled"); // tenant
	jQuery("#1_4_19").attr("disabled", "disabled"); // landlord
	jQuery("#1_6_51").attr("disabled", "disabled"); // service*/
	jQuery("#1_1_3").prop("readonly",true); //tenant
	jQuery("#1_1_4").prop("readonly",true);
	jQuery("#1_4_17").prop("readonly",true); //landlord
	jQuery("#1_4_18").prop("readonly",true);
	jQuery("#1_6_49").prop("readonly",true); //service
	jQuery("#1_6_50").prop("readonly",true);
	
	jQuery('#1_1_67-wrapper').css("display","none");
	//jQuery('#1_1_16-wrapper').css("display","none");
	
	jQuery('#1_1_6-element select').attr('style','width:81px !important'); //dob width set for tenant
	jQuery('#1_4_74-element select').attr('style','width:81px !important'); //dob width set for landlord
	jQuery('#1_6_52-element select').attr('style','width:81px !important'); //dob width set for services
		
	jQuery("#1_1_14").find("option").eq(0).text('Select');
	jQuery("#1_1_72").find("option").eq(0).text('Select');
	jQuery("#1_1_73").find("option").eq(0).text('Select');
	jQuery("#1_1_15").find("option").eq(0).text('Select Income');
	jQuery("#1_1_14").attr('onchange','showSpecialize()');
	jQuery("#1_1_70").attr('onchange','showPets()');
	jQuery("#1_1_70").find("option").eq(0).text('Select');
	jQuery("#1_1_71").find("option").eq(0).text('Type of pets');
	
	jQuery("#1_1_6-day").find("option").eq(0).text('Day');
	jQuery("#1_1_6-month").find("option").eq(0).text('Month');
	jQuery("#1_1_6-year").find("option").eq(0).text('Year');
	
	jQuery("#1_4_74-day").find("option").eq(0).text('Day');
	jQuery("#1_4_74-month").find("option").eq(0).text('Month');
	jQuery("#1_4_74-year").find("option").eq(0).text('Year');
	
	jQuery("#1_6_52-day").find("option").eq(0).text('Day');
	jQuery("#1_6_52-month").find("option").eq(0).text('Month');
	jQuery("#1_6_52-year").find("option").eq(0).text('Year');
	jQuery("label[for=1_1_71]").addClass('mand');
		
	var level_id = '<?php echo $viewer->level_id;?>';
	
	if(level_id == '8' || level_id == '6' || level_id == '7' ) {
	//landlord
	if(level_id == '6'){
	var country_id	=	jQuery('#1_4_33').val();
	var state_id	=	jQuery('#1_4_30').val();	
	var city_id	    =	jQuery('#1_4_31').val();
    }
	
	// services
	if(level_id == '8'){
	var country_id	=	jQuery('#1_6_53').val();	
	var state_id	=	jQuery('#1_6_54').val();	
	var city_id	    =	jQuery('#1_6_55').val();
    }
    
	// renter
	if(level_id == '7'){
	var country_id	=	jQuery('#1_1_75').val();	
	var state_id	=	jQuery('#1_1_76').val();	
	var city_id	    =	jQuery('#1_1_77').val();
    }
}


  var oData       = new Object();
   oData.countryId =country_id;  
   oData.state_id =state_id; 
   oData.city_id =city_id; 
   
   
   getcountries();
   getstates();
   getcity();
		
					
			
	
		    if(level_id	==	'7')
			{
				
					var edu	=	jQuery("#1_1_14").val();
					if(edu	==	18)
					{
						jQuery("#1_1_72-wrapper").css('display','block');
						jQuery("label[for=1_1_72]").addClass('mand');
						jQuery("#1_1_73-wrapper").css('display','none');
					}
					else if(edu == 19)
					{
						jQuery("#1_1_72-wrapper").css('display','none');
						jQuery("#1_1_73-wrapper").css('display','block');
						jQuery("label[for=1_1_73]").addClass('mand');
					}
					else
					{
						jQuery("#1_1_72-wrapper").css('display','none');
						jQuery("#1_1_73-wrapper").css('display','none');
					}
				
			}
			
		var coverletter	=	jQuery('#1_1_66').val();	
		var host	=	window.location.host;

		var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/getdefaultcoverletters';
			  jQuery.ajax({
						 url:  url,
						
						dataType: 'json',
						type: 'POST',
					 success: function (data) { console.log(data);
						
						jQuery("#1_1_66")
    .replaceWith('<select id="1_1_66" name="1_1_66" class="" onchange="getnewfield();"> </select>') ;
     jQuery('#1_1_66').append('<option value=" ">Select cover letter</option>');
						jQuery.each(data, function (i, item) {
						jQuery('#1_1_66').append(jQuery('<option>', { 
							value: item.id,
							text : item.title 
						}));
						
					});
					jQuery('#1_1_66').append('<option value="new">Other</option>');
						if(coverletter)
						{
							jQuery("#1_1_66 > [value=" + coverletter + "]").attr("selected", "true");
							getnewfield();
						}
					},
					   error: function(e){  console.log(e);//alert('Error: '+e); 
						    }  
					});
					
					
var creditscore_view_status = '<?php echo $viewer->creditscore_view_status?>';	

if(creditscore_view_status == '1'){
	
	jQuery('#1_1_16-element').append('<div class="creditscore_options_div"><a class="hide_creditscore" href="javascript:void(0)">Hide</a></div>');

}
else{
	jQuery('#1_1_16-element').append('<div class="creditscore_options_div"><a class="show_creditscore" href="javascript:void(0)">Show</a></div>');

}				




jQuery(document).on("click",".hide_creditscore",function() {
	
	var formURL    = '<?php echo $this->baseUrl(); ?>' + '/user/edit/hidecreditscore';
		
		jQuery.ajax( {
						url : formURL,
						type: "POST",
						dataType: 'json',
						data : oData,
							success: function (returndata) { 
								
                               
									jQuery(".creditscore_options_div").html('');
	                                jQuery(".creditscore_options_div").html('<a class="show_creditscore" href="javascript:void(0)">Show</a>');

								
							},
							error: function(e){  
						   jQuery(".loader").css("display", "none");
						   jQuery('.but_submit').css('display','block');  }  

						});

});

jQuery(document).on("click",".show_creditscore",function() {
	
	
		var formURL    = '<?php echo $this->baseUrl(); ?>' + '/user/edit/showcreditscore';
		
		jQuery.ajax( {
						url : formURL,
						type: "POST",
						dataType: 'json',
						data : oData,
							success: function (returndata) { 
								
                               
								    jQuery(".creditscore_options_div").html('');
	                               jQuery(".creditscore_options_div").html('<a class="hide_creditscore" href="javascript:void(0)">Hide</a>');
								
							},
							error: function(e){  
						   jQuery(".loader").css("display", "none");
						   jQuery('.but_submit').css('display','block');  }  

						});


});

});





var level_id = '<?php echo $viewer->level_id;?>';
jQuery('#submit').click(function(){
	if(level_id == 7)
	{
		var edu	=	jQuery('#1_1_14').val();
		var school	=	jQuery('#1_1_72').val();
		var college	=	jQuery('#1_1_73').val();
		var hasPets	=	jQuery('#1_1_70').val();
		var pettype	=	jQuery('#1_1_71').val();
		
		jQuery('.validation_message_1_1_72').remove();
		jQuery('.validation_message_1_1_73').remove();
		jQuery('.validation_message_1_1_71').remove();
		jQuery('.validation_message_1_1_14').remove();
		
		/*if(edu	==	18)
		{
			if(school	==	'' || school == 'Select')
			{
				jQuery("#1_1_72-element").append("<div class='validation_message_1_1_72' style='color:red';margin-left:2px;>Please enter your specialization</div>");
				return false;
			}
			else
			{
				jQuery('.validation_message_1_1_72').remove();
			}
		}
		else if(edu	==	19)
		{
			if(college	==	'' || college == 'Select')
			{
				jQuery("#1_1_73-element").append("<div class='validation_message_1_1_73' style='color:red';margin-left:2px;>Please enter your specialization</div>");
				return false;
			}
			else
			{
				jQuery('.validation_message_1_1_73').remove();
			}
		}
		else if(edu	==	31)
		{
				jQuery('.validation_message_1_1_14').remove();
		}
		else
		{
			jQuery("#1_1_14-element").append("<div class='validation_message_1_1_14' style='color:red';margin-left:2px;>Please enter your education</div>");
			return false;
		}*/
		
		
		if(hasPets	==	11)
		{
			if(pettype	==	'' || school == 'Type of pets')
			{
				jQuery("#1_1_71-element").append("<div class='validation_message_1_1_71' style='color:red';margin-left:2px;>Please enter your pet type</div>");
				return false;
			}
			else
			{
				jQuery('.validation_message_1_1_71').remove();
			}
		}
		else
		{
			jQuery('.validation_message_1_1_71').remove();
		}
		
	}
});

		function getcountries(){
	
		var profile_type_id='<?php echo $profile_type_id ; ?>';
		
		if(profile_type_id == '4'){ //landlord
		var country_id	=	jQuery('#1_4_33').val();	
		}
		
		if(profile_type_id == '1'){ //tenant
		var country_id	=	jQuery('#1_1_75').val();

		}
    
	
	
	    var country_id	=	country_id; 
	    var host	=	window.location.host;
		
		var url	=	'<?php echo $this->baseUrl()?>' + '/user/signup/getcountries';
			  jQuery.ajax({
						 url:  url,
						
						dataType: 'json',
						type: 'POST',
					    success: function (data) { console.log(data);
						
						if(profile_type_id == '1'){
						jQuery("#1_1_75")
						.replaceWith('<select id="1_1_75" name="1_1_75" class="" onchange="getstates();"> </select>') ;
						jQuery('#1_1_75').append('<option>Select country</option>');
						jQuery.each(data, function (i, item) {
							
						if(country_id==item.id)
							{
							
						    jQuery('#1_1_75').append(jQuery('<option>', { 
							value: item.id,						
							text : item.country 
						   }));
						   jQuery("#1_1_75 option[value="+country_id+"]").attr("selected", "selected");
							}
							else{
							jQuery('#1_1_75').append(jQuery('<option>', { 
								value: item.id,
							
								text : item.country 
							}));
					        }
						
					    });
					}
						if(profile_type_id == '4'){
						jQuery("#1_4_33")
						.replaceWith('<select id="1_4_33" name="1_4_33" class="" onchange="getstates();"> </select>') ;
						jQuery('#1_4_33').append('<option>Select country</option>');
						jQuery.each(data, function (i, item) {
							
						if(country_id==item.id)
							{
							
						    jQuery('#1_4_33').append(jQuery('<option>', { 
							value: item.id,						
							text : item.country 
						   }));
						   jQuery("#1_4_33 option[value="+country_id+"]").attr("selected", "selected");
							}
							else{
							jQuery('#1_4_33').append(jQuery('<option>', { 
								value: item.id,
							
								text : item.country 
							}));
					        }
						
					    });
					}
					    
					    
					    
					    
					    },
					    error: function(e){  console.log(e);//alert('Error: '+e);
						     }  
					    });
					
		}	

	function getstates(){
		
		
        var profile_type_id='<?php echo $profile_type_id ; ?>';
		if(profile_type_id == '4'){ //landlord
		var country_id	=	jQuery('#1_4_33').val();	
		var state_id	=	jQuery('#1_4_30').val();
		}
		
		if(profile_type_id == '1'){ //tenant
		var country_id	=	jQuery('#1_1_75').val();	
		var state_id	=	jQuery('#1_1_76').val();	
		} 

		var host	=	window.location.host;
		var url	=	'<?php echo $this->baseUrl()?>' + '/user/signup/getstates';
			  jQuery.ajax({
						 url:  url,
						data: "countryId="+country_id,
						dataType: 'json',
						type: 'POST',
					 success: function (data) { console.log(data);
					
					if(profile_type_id == '1'){ //tenant
					
						jQuery("#1_1_76")
						.replaceWith('<select id="1_1_76" name="1_1_76" class="" onclick="getcity();"> </select>') ;
						jQuery('#1_1_76').append('<option value=" ">Select state</option>');
						jQuery.each(data, function (i, item) {			
							
						if(state_id==item.id)
							{			
								
						jQuery('#1_1_76').append(jQuery('<option>', { 
							
							value: item.id,
							text : item.state 
						}));
                        jQuery("#1_1_76 option[value="+state_id+"]").attr("selected", "selected");
							}
							else{
							jQuery('#1_1_76').append(jQuery('<option>', { 
							
							value: item.id,
							text : item.state 
						}));	
								
							}
					});
				}
					if(profile_type_id == '4'){ //landlord
					
						jQuery("#1_4_30")
						.replaceWith('<select id="1_4_30" name="1_4_30" class="" onclick="getcity();"> </select>') ;
						jQuery('#1_4_30').append('<option value=" ">Select state</option>');
						jQuery.each(data, function (i, item) {			
							
						if(state_id==item.id)
							{			
								
						jQuery('#1_4_30').append(jQuery('<option>', { 
							
							value: item.id,
							text : item.state 
						}));
                        jQuery("#1_4_30 option[value="+state_id+"]").attr("selected", "selected");
							}
							else{
							jQuery('#1_4_30').append(jQuery('<option>', { 
							
							value: item.id,
							text : item.state 
						}));	
								
							}
					});
				}
					
					
					
					
					
					
					 },
					   error: function(e){  //alert('Error: '+e);  
						   }  
					}); }



function getcity(){
	
	var profile_type_id='<?php echo $profile_type_id ; ?>';
		if(profile_type_id == '4'){ //landlord
		var state_id	=	jQuery('#1_4_30').val();
		var city_id	    =	jQuery('#1_4_31').val();	
		}
		
		if(profile_type_id == '1'){
		var state_id	=	jQuery('#1_1_76').val();	
		var city_id	    =	jQuery('#1_1_77').val();
		}
		
		var host	=	window.location.host;
	    var url	=	'<?php echo $this->baseUrl()?>' + '/user/signup/getcity';
		

		
			  jQuery.ajax({
						url:  url,
						data: "stateId="+state_id,
					 	dataType: 'json',
						type: 'POST',
					    success: function (data) { console.log(data);
							
						if(profile_type_id == '1'){	
						jQuery("#1_1_77")
						.replaceWith('<select id="1_1_77" name="1_1_77" class="" > </select>') ;
						jQuery('#1_1_77').append('<option value="">Select city</option>');
						jQuery.each(data, function (i, item) {
								if(city_id==item.id)
							{	
	                        jQuery('#1_1_77').append(jQuery('<option>', { 
							value: item.id,
							text : item.city 
						    }));
						   jQuery("#1_1_77 option[value="+city_id+"]").attr("selected", "selected");
					       }
					      else
					       {
						    jQuery('#1_1_77').append(jQuery('<option>', { 
							value: item.id,
							text : item.city 
						   }));
					      }
					
					     });
				    	 }
				    	 
						if(profile_type_id == '4'){	
						jQuery("#1_4_31")
						.replaceWith('<select id="1_4_31" name="1_4_31" class="" > </select>') ;
						jQuery('#1_4_31').append('<option value="">Select city</option>');
						jQuery.each(data, function (i, item) {
								if(city_id==item.id)
							{	
	                        jQuery('#1_4_31').append(jQuery('<option>', { 
							value: item.id,
							text : item.city 
						    }));
						   jQuery("#1_4_31 option[value="+city_id+"]").attr("selected", "selected");
					       }
					      else
					       {
						    jQuery('#1_4_31').append(jQuery('<option>', { 
							value: item.id,
							text : item.city 
						   }));
					      }
					
					     });
				    	 }
					     
					     
					     
					     },
					    error: function(e){ // alert('Error: '+e);  
						   }  
					   });
	}
	
	
		//-----------------------------SERVICES------------------
	

		
	jQuery( "#1_6_53" ).click(function() {
			
			//jQuery("#1_6_53").attr("onchange" , "");
		var host	=	window.location.host;
		//var url = '<?php echo $this->url(array('action' => 'getcountries'));?>'; 
		var url	=	'<?php echo $this->baseUrl()?>' + '/user/signup/getcountries';
			  jQuery.ajax({
						 url:  url,
						
						dataType: 'json',
						type: 'POST',
					 success: function (data) { console.log(data);
						//jQuery('#1_6_63_field_63').append('<option></option>');
						jQuery("#1_6_53")
    .replaceWith('<select id="1_6_53" name="1_6_53" class="" onchange="getlanlordstates();"> </select>') ;
    jQuery('#1_6_53').append('<option>Select country</option>');
						jQuery.each(data, function (i, item) {
						jQuery('#1_6_53').append(jQuery('<option>', { 
							value: item.id,
							text : item.country 
						}));
						
						
					});},
					   error: function(e){  console.log(e);//alert('Error: '+e);
						     }  
					});
		});
	
	
	

	function getlanlordstates(){
		var host	=	window.location.host; 
		var url	=	'<?php echo $this->baseUrl()?>' + '/user/signup/getstates';
		var country_id	=	jQuery('#1_6_53').val(); 
		//jQuery("#1_6_54").attr("onchange" , "");

			  jQuery.ajax({
						 url:  url,
						data: "countryId="+country_id,
						dataType: 'json',
						type: 'POST',
					 success: function (data) { console.log(data);
						//jQuery('#1_4_30_field_30').append('<option></option>');
						jQuery("#1_6_54")
    .replaceWith('<select id="1_6_54" name="1_6_54" class="" onclick="getlandlordcity();"> </select>') ;
     jQuery('#1_6_54').append('<option>Select state</option>');
						jQuery.each(data, function (i, item) {						
						jQuery('#1_6_54').append(jQuery('<option>', { 
							value: item.id,
							text : item.state 
						}));

					}); },
					   error: function(e){ // alert('Error: '+e); 
						    }  
					}); }
	
	
	function getlandlordcity(){
		var host	=	window.location.host;
	    var url	=	'<?php echo $this->baseUrl()?>' + '/user/signup/getcity';
		var state_id	=	jQuery('#1_6_54').val(); 

		
			  jQuery.ajax({
						 url:  url,
						data: "stateId="+state_id,
						dataType: 'json',
						type: 'POST',
					 success: function (data) { console.log(data);
						//jQuery('#1_4_31').append('<option></option>');
						jQuery("#1_6_55")
    .replaceWith('<select id="1_6_55" name="1_6_55" class="" > </select>') ;
    jQuery('#1_6_55').append('<option>Select city</option>');
						jQuery.each(data, function (i, item) {
						jQuery('#1_6_55').append(jQuery('<option>', { 
							value: item.id,
							text : item.city 
						}));
					});},
					   error: function(e){  //alert('Error: '+e); 
						    }  
					});
	}
	
		//-----------------------------TENANTS------------------
	

		
	jQuery( "#1_1_75" ).click(function() {
			
			//jQuery("#1_1_75").attr("onchange" , "");
		var host	=	window.location.host;
		//var url = '<?php echo $this->url(array('action' => 'getcountries'));?>'; 
		var url	=	'<?php echo $this->baseUrl()?>' + '/user/signup/getcountries';
			  jQuery.ajax({
						 url:  url,
						
						dataType: 'json',
						type: 'POST',
					 success: function (data) { console.log(data);
						//jQuery('#1_6_63_field_63').append('<option></option>');
						jQuery("#1_1_75")
    .replaceWith('<select id="1_1_75" name="1_1_75" class="" onchange="gettenantstates();"> </select>') ;
    jQuery('#1_1_75').append('<option>Select country</option>');
						jQuery.each(data, function (i, item) {
						jQuery('#1_1_75').append(jQuery('<option>', { 
							value: item.id,
							text : item.country 
						}));
						
						
					});},
					   error: function(e){  console.log(e);//alert('Error: '+e);
						     }  
					});
		});
	
	
	

	function gettenantstates(){

		var host	=	window.location.host; 
		var url	=	'<?php echo $this->baseUrl()?>' + '/user/signup/getstates';
		var country_id	=	jQuery('#1_1_75').val(); 
		//jQuery("#1_1_76").attr("onchange" , "");
		
		
			  jQuery.ajax({
						 url:  url,
						data: "countryId="+country_id,
						dataType: 'json',
						type: 'POST',
					 success: function (data) { console.log(data);
						//jQuery('#1_4_30_field_30').append('<option></option>');
						jQuery("#1_1_76")
    .replaceWith('<select id="1_1_76" name="1_1_76" class="" onclick="gettenantcity();"> </select>') ;
     jQuery('#1_1_76').append('<option>Select state</option>');
						jQuery.each(data, function (i, item) {						
						jQuery('#1_1_76').append(jQuery('<option>', { 
							value: item.id,
							text : item.state 
						}));

					}); },
					   error: function(e){ // alert('Error: '+e); 
						    }  
					}); }
	
	
	function gettenantcity(){
		var host	=	window.location.host;
	    var url	=	'<?php echo $this->baseUrl()?>' + '/user/signup/getcity';
		var state_id	=	jQuery('#1_1_76').val(); 

		
			  jQuery.ajax({
						 url:  url,
						data: "stateId="+state_id,
						dataType: 'json',
						type: 'POST',
					 success: function (data) { console.log(data);
						//jQuery('#1_4_31').append('<option></option>');
						jQuery("#1_1_77")
    .replaceWith('<select id="1_1_77" name="1_1_77" class="" > </select>') ;
    jQuery('#1_1_77').append('<option>Select city</option>');
						jQuery.each(data, function (i, item) {
						jQuery('#1_1_77').append(jQuery('<option>', { 
							value: item.id,
							text : item.city 
						}));
					});},
					   error: function(e){  //alert('Error: '+e); 
						    }  
					});
	}
	
	
	
	//---------------------------------------
	
function getnewfield() {	
	var theValue = jQuery('#1_1_66').find('option:selected').val(); 
	jQuery('.template_div').remove();
	if(theValue == 'new'){
		jQuery('#textar2').css("display","block");
	}
	else{
		jQuery('#textar2').css("display","none");
		
		
		var host	=	window.location.host;
		
		var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/getdefaultcoverletterbyid/id/'+theValue; ;
			  jQuery.ajax({
						url:  url,
						
						dataType: 'json',
						type: 'POST',
					 success: function (data) { console.log(data);
						 
					//	jQuery('#1_1_66-wrapper').after('<div class="template_div"><div class="title"></div><p align="justify" class="template">'+data.content+'</p></div>');
						
											jQuery('.textar2').html('<div class="form-d"><div class="form-label"><label class="optional"></label></div><div class="form-element"><div class="title"></div><textarea>'+data.content+'</textarea></div></div>');
						
					},
					   error: function(e){  console.log(e);//alert('Error: '+e);  
						   }  
					});
		
	}
}

jQuery('.headline h2').append('<span class="profile_click mob_bar" style="float:right;margin: 17px;font-size: medium;"><i class="fa fa-bars" aria-hidden="true"></i></span>');

jQuery( ".profile_click" ).click(function() {
	if(jQuery( ".profile_click" ).hasClass("show_dropdown")){
        jQuery('.tabs .navigation').css('display','none');
	    jQuery('.profile_click').removeClass('show_dropdown');
		
	}
	else{
		jQuery('.profile_click').addClass('show_dropdown');
        jQuery('.tabs .navigation').css('display','block');
	
	}
});
</script>
