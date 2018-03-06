<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: fields.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */
?>

<?php
  /* Include the common user-end field switching javascript */
  echo $this->partial('_jsSwitch.tpl', 'fields', array(
    'topLevelId' => $this->form->getTopLevelId(),
    'topLevelValue' => $this->form->getTopLevelValue(),
  ));
?>

<!--<script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/scripts/lightbox-plus-jquery.min.js"></script>-->
<script>jQuery.noConflict();</script>

<?php echo $this->form->render($this) ?>

<!-- popup ------>
<div id="light" class="white_content">
<div class="pop_up_title"><div class="div_attachment_title">Confirm</div><div class="div_attachment_cancel"><img src="/application/modules/User/externals/images/GREYcancel.png"></div></div>
<div class="popup_content">	
	
<div class="confirm_text_first">Email you input is <email>. Click Confirm if it is correct.</div>
<div class="confirm_text_second">Please note, you will not be able to change your email once signed up.</div>
<div class="confirm_btns" style="text-align: left;"><span class="confirm_btns"><button class="yes_btn" style="width: 134px;">Confirm</button><button class="no_btn" style="width: 134px;">Cancel</button></span> 

</div>
</div>
</div>
</div>
<div id="fade" class="black_overlay"></div>

<script type="text/javascript">
	
	
	jQuery("#1_4_17-element").append('<p class="description"  style="color: #f58410;">You cannot change the First Name after sign up</p>');
	jQuery("#1_4_18-element").append('<p class="description"  style="color: #f58410;">You cannot change the Last Name after sign up</p>');
	//jQuery("#1_4_19-element").append('<p class="description">You cannot change the Gender after sign up</p>');
	jQuery("#1_4_74-element").append('<p class="description" style="color: #f58410;">You cannot change the Birthdate after sign up</p>');
	
	jQuery("#1_1_3-element").append('<p class="description"  style="color: #f58410;">You cannot change the First Name after sign up</p>');
	jQuery("#1_1_4-element").append('<p class="description"  style="color: #f58410;">You cannot change the Last Name after sign up</p>');
	//jQuery("#1_1_5-element").append('<p class="description">You cannot change the Gender after sign up</p>');
	jQuery("#1_1_6-element").append('<p class="description"  style="color: #f58410;">You cannot change the Birthdate after sign up</p>');
	
	jQuery("#1_6_49-element").append('<p class="description"  style="color: #f58410;">You cannot change the First Name after sign up</p>');
	jQuery("#1_6_50-element").append('<p class="description"  style="color: #f58410;">You cannot change the Last Name after sign up</p>');
	//jQuery("#1_6_51-element").append('<p class="description">You cannot change the Gender after sign up</p>');
	jQuery("#1_6_52-element").append('<p class="description"  style="color: #f58410;">You cannot change the Birthdate after sign up</p>');
	
jQuery("#1_1_3,#1_6_49,#1_4_17").blur(function()	
{
	var tenantfname	=	jQuery.trim(jQuery("#1_1_3").val());
	var servicesfname	=	jQuery.trim(jQuery("#1_6_49").val());
	var landfname	=	jQuery.trim(jQuery("#1_4_17").val());
	
	if(tenantfname)
	{
		fname	=	tenantfname;
	}
	
	if(servicesfname)
	{
		fname	=	servicesfname;
	}
	
	if(landfname)
	{
		fname	=	landfname;
	}
	
	if(fname)
	{
		/*jQuery( "div.confirm_text_first" ).replaceWith( '<div class="confirm_text_first">First name you input is <span style="color:blue">'+fname+'.</span> Click Confirm if it is correct.</div>' );
		jQuery( "div.confirm_text_second" ).replaceWith( '<div class="confirm_text_second">Please note, you will not be able to change your First Name once signed up.</div>' );
		document.getElementById('light').style.display='block';
		document.getElementById('fade').style.display='block';
		
		jQuery('#1_4_19,#1_4_74-month,#1_4_74-day,#1_4_74-year,#1_4_33,#1_4_30,#1_4_31').prop('disabled',true);
		jQuery('#1_1_5,#1_1_6-month,#1_1_6-day,#1_1_6-year,#1_1_75,#1_1_76,#1_1_77').prop('disabled',true);
		jQuery('#1_6_51,#1_6_52-month,#1_6_52-day,#1_6_52-year,#1_6_53,#1_6_54,#1_6_55').prop('disabled',true);*/
    }
});

jQuery("#1_1_4,#1_6_50,#1_4_18").blur(function()	
{
	
	var tenantlname	=	jQuery.trim(jQuery("#1_1_4").val());
	var serviceslname	=	jQuery.trim(jQuery("#1_6_50").val());
	var landlname	=	jQuery.trim(jQuery("#1_4_18").val());
	
	if(tenantlname)
	{
		lname	=	tenantlname;
	}
	
	if(serviceslname)
	{
		lname	=	serviceslname;
	}
	
	if(landlname)
	{
		lname	=	landlname;
	}
	
	if(lname)
	{
		/*jQuery( "div.confirm_text_first" ).html('');
		jQuery( "div.confirm_text_second" ).html('');
		jQuery( "div.confirm_text_first" ).replaceWith( '<div class="confirm_text_first">Last name you input is <span style="color:blue">'+lname+'.</span> Click Confirm if it is correct.</div>' );
		jQuery( "div.confirm_text_second" ).replaceWith( '<div class="confirm_text_second">Please note, you will not be able to change your Second Name once signed up.</div>' );
		document.getElementById('light').style.display='block';
		document.getElementById('fade').style.display='block';
 
		jQuery('#1_4_19,#1_4_74-month,#1_4_74-day,#1_4_74-year,#1_4_33,#1_4_30,#1_4_31').prop('disabled',true);
		jQuery('#1_1_5,#1_1_6-month,#1_1_6-day,#1_1_6-year,#1_1_75,#1_1_76,#1_1_77').prop('disabled',true);
		jQuery('#1_6_51,#1_6_52-month,#1_6_52-day,#1_6_52-year,#1_6_53,#1_6_54,#1_6_55').prop('disabled',true);
	*/
    }
});

jQuery("#1_1_5,#1_4_19,#1_6_51").blur(function()	
{
	//$("#yourdropdownid option:selected").text();
	var tenantgender	=	jQuery.trim(jQuery("#1_1_5").val());
	var servicesgender	=	jQuery.trim(jQuery("#1_6_51").val());
	var landgender	=	jQuery.trim(jQuery("#1_4_19").val());
	var gender	=	'';
	var gendertext	=	'';
	
	if(tenantgender)
	{
		gender	=	tenantgender;
		gendertext	=	jQuery.trim(jQuery("#1_1_5 option:selected").text());
	}
	
	if(servicesgender)
	{
		gender	=	servicesgender;
		gendertext	=	jQuery.trim(jQuery("#1_6_51 option:selected").text());
	}
	
	if(landgender)
	{
		gender	=	landgender;
		gendertext	=	jQuery.trim(jQuery("#1_4_19 option:selected").text());
	}

	if(gender)
	{
		/*jQuery( "div.confirm_text_first" ).html('');
		jQuery( "div.confirm_text_second" ).html('');
		jQuery( "div.confirm_text_first" ).replaceWith( '<div class="confirm_text_first">Gender you input is <span style="color:blue">'+gendertext+'.</span> Click Confirm if it is correct.</div>' );
		jQuery( "div.confirm_text_second" ).replaceWith( '<div class="confirm_text_second">Please note, you will not be able to change your Gender once signed up.</div>' );
		document.getElementById('light').style.display='block';
		document.getElementById('fade').style.display='block';
		
		jQuery('#1_4_19,#1_4_74-month,#1_4_74-day,#1_4_74-year,#1_4_33,#1_4_30,#1_4_31').prop('disabled',true);
		jQuery('#1_1_5,#1_1_6-month,#1_1_6-day,#1_1_6-year,#1_1_75,#1_1_76,#1_1_77').prop('disabled',true);
		jQuery('#1_6_51,#1_6_52-month,#1_6_52-day,#1_6_52-year,#1_6_53,#1_6_54,#1_6_55').prop('disabled',true);*/
    }
});

jQuery("#1_4_74-month,#1_4_74-day,#1_4_74-year").blur(function()	//landlord
{
	var month	=	jQuery.trim(jQuery("#1_4_74-month").val());
	var day	=	jQuery.trim(jQuery("#1_4_74-day").val());
	var year	=	jQuery.trim(jQuery("#1_4_74-year").val());

	if((month > 0) && (day > 0) && (year > 0))
	{
		/*jQuery( "div.confirm_text_first" ).html('');
		jQuery( "div.confirm_text_second" ).html('');
		jQuery( "div.confirm_text_first" ).replaceWith( '<div class="confirm_text_first">Birthday you input is <span style="color:blue">'+month+'-'+day+'-'+year+'.</span> Click Confirm if it is correct.</div>' );
		jQuery( "div.confirm_text_second" ).replaceWith( '<div class="confirm_text_second">Please note, you will not be able to change your Birthday once signed up.</div>' );
		document.getElementById('light').style.display='block';
		document.getElementById('fade').style.display='block';
		
		jQuery('#1_4_19,#1_4_74-month,#1_4_74-day,#1_4_74-year,#1_4_33,#1_4_30,#1_4_31').prop('disabled',true);
		jQuery('#1_1_5,#1_1_6-month,#1_1_6-day,#1_1_6-year,#1_1_75,#1_1_76,#1_1_77').prop('disabled',true);
		jQuery('#1_6_51,#1_6_52-month,#1_6_52-day,#1_6_52-year,#1_6_53,#1_6_54,#1_6_55').prop('disabled',true);*/
    }
});

jQuery("#1_1_6-month,#1_1_6-day,#1_1_6-year").blur(function()	//tenant
{
	var month	=	jQuery.trim(jQuery("#1_1_6-month").val());
	var day	=	jQuery.trim(jQuery("#1_1_6-day").val());
	var year	=	jQuery.trim(jQuery("#1_1_6-year").val());

	if((month > 0) && (day > 0) && (year > 0))
	{
		/*jQuery( "div.confirm_text_first" ).html('');
		jQuery( "div.confirm_text_second" ).html('');
		jQuery( "div.confirm_text_first" ).replaceWith( '<div class="confirm_text_first">Birthdate you input is <span style="color:blue">'+month+'-'+day+'-'+year+'.</span> Click Confirm if it is correct.</div>' );
		jQuery( "div.confirm_text_second" ).replaceWith( '<div class="confirm_text_second">Please note, you will not be able to change your Birthdate once signed up.</div>' );
		document.getElementById('light').style.display='block';
		document.getElementById('fade').style.display='block';
		
		jQuery('#1_4_19,#1_4_74-month,#1_4_74-day,#1_4_74-year,#1_4_33,#1_4_30,#1_4_31').prop('disabled',true);
		jQuery('#1_1_5,#1_1_6-month,#1_1_6-day,#1_1_6-year,#1_1_75,#1_1_76,#1_1_77').prop('disabled',true);
		jQuery('#1_6_51,#1_6_52-month,#1_6_52-day,#1_6_52-year,#1_6_53,#1_6_54,#1_6_55').prop('disabled',true);*/
    }
});

jQuery("#1_6_52-month,#1_6_52-day,#1_6_52-year").blur(function()	
{
	var month	=	jQuery.trim(jQuery("#1_6_52-month").val());
	var day	=	jQuery.trim(jQuery("#1_6_52-day").val());
	var year	=	jQuery.trim(jQuery("#1_6_52-year").val());

	if((month > 0) && (day > 0) && (year > 0))
	{
		/*jQuery( "div.confirm_text_first" ).html('');
		jQuery( "div.confirm_text_second" ).html('');
		jQuery( "div.confirm_text_first" ).replaceWith( '<div class="confirm_text_first">Birthdate you input is <span style="color:blue">'+month+'-'+day+'-'+year+'.</span> Click Confirm if it is correct.</div>' );
		jQuery( "div.confirm_text_second" ).replaceWith( '<div class="confirm_text_second">Please note, you will not be able to change your Birthdate once signed up.</div>' );
		document.getElementById('light').style.display='block';
		document.getElementById('fade').style.display='block';
		
		jQuery('#1_4_19,#1_4_74-month,#1_4_74-day,#1_4_74-year,#1_4_33,#1_4_30,#1_4_31').prop('disabled',true);
		jQuery('#1_1_5,#1_1_6-month,#1_1_6-day,#1_1_6-year,#1_1_75,#1_1_76,#1_1_77').prop('disabled',true);
		jQuery('#1_6_51,#1_6_52-month,#1_6_52-day,#1_6_52-year,#1_6_53,#1_6_54,#1_6_55').prop('disabled',true);*/
    }
});

jQuery('body').on('click', '.no_btn,.div_attachment_cancel', function(event){

	document.getElementById('light').style.display='none';
	document.getElementById('fade').style.display='none';
	jQuery('#1_4_19,#1_4_74-month,#1_4_74-day,#1_4_74-year,#1_4_33,#1_4_30,#1_4_31').prop('disabled',false);
	jQuery('#1_1_5,#1_1_6-month,#1_1_6-day,#1_1_6-year,#1_1_75,#1_1_76,#1_1_77').prop('disabled',false);
	jQuery('#1_6_51,#1_6_52-month,#1_6_52-day,#1_6_52-year,#1_6_53,#1_6_54,#1_6_55').prop('disabled',false);
});

jQuery('.yes_btn').click(function(){
    
    document.getElementById('light').style.display='none';
	document.getElementById('fade').style.display='none'; 
	jQuery('#1_4_19,#1_4_74-month,#1_4_74-day,#1_4_74-year,#1_4_33,#1_4_30,#1_4_31').prop('disabled',false);
	jQuery('#1_1_5,#1_1_6-month,#1_1_6-day,#1_1_6-year,#1_1_75,#1_1_76,#1_1_77').prop('disabled',false);
	jQuery('#1_6_51,#1_6_52-month,#1_6_52-day,#1_6_52-year,#1_6_53,#1_6_54,#1_6_55').prop('disabled',false);
});
</script>
<script type="text/javascript">
jQuery("#1_1_5").find("option").eq(0).text('Select Gender  *');
jQuery("#1_4_19").find("option").eq(0).text('Select Gender  *');
jQuery("#1_6_51").find("option").eq(0).text('Select Gender  *');

jQuery("#1_1_6-month").find("option").eq(0).text('Month  *');
jQuery("#1_1_6-day").find("option").eq(0).text('Day  *');
jQuery("#1_1_6-year").find("option").eq(0).text('Year  *');

jQuery("#1_6_52-month").find("option").eq(0).text('Month  *');
jQuery("#1_6_52-day").find("option").eq(0).text('Day  *');
jQuery("#1_6_52-year").find("option").eq(0).text('Year  *');

jQuery("#1_4_74-month").find("option").eq(0).text('Month  *');
jQuery("#1_4_74-day").find("option").eq(0).text('Day  *');
jQuery("#1_4_74-year").find("option").eq(0).text('Year  *');

jQuery("#1_1_15").find("option").eq(0).text('Select Income');
jQuery("#1_1_70").find("option").eq(0).text('Select Pets  *');
jQuery("#1_1_71").find("option").eq(0).text('Type of pets');
jQuery("#1_1_14").find("option").eq(0).text('Select Education');
jQuery("#1_1_72").find("option").eq(0).text('Select');
jQuery("#1_1_73").find("option").eq(0).text('Select');
/*jQuery('#1_1_15').blur(function(el){
	//var regex = /^[0-9]*(?:\.\d{1,2})?$/;    // allow only numbers [0-9] 
	var regex	=	/^[0-9]*$/;
	var income = jQuery('#1_1_15').val();
	if( !regex.test(income) ) {
      alert('Please enter numbers only');
      jQuery('#1_1_15').val('');
    }
    
});*/

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
jQuery(document).ready(function()  {
jQuery("#1_4_34").attr('maxlength', '10'); 
jQuery("#1_1_70").attr('onchange','showPets()');
jQuery("#1_1_14").attr('onchange','showSpecialize()');
jQuery("#1_1_71-wrapper").css('display','none');
jQuery("#1_1_72-wrapper").css('display','none');
jQuery("#1_1_73-wrapper").css('display','none');

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
	
jQuery("#global_page_user-signup-index .user-profile").css('display', 'none');

	var type	= jQuery("#1_6_55").prop('type');
	var textvalue	=	jQuery("#1_6_55").val();
	if(type	==	'text' && textvalue	!= '')
	{
		jQuery("#1_6_55").val('');
	}
	
	var type	= jQuery("#1_4_31").prop('type');
	var textvalue	=	jQuery("#1_4_31").val();
	if(type	==	'text' && textvalue	!= '')
	{
		jQuery("#1_4_31").val('');
	}

});
jQuery("#1_4_34").keyup(function(){		//zipcode validation in landlord
	
		var chrOnly = jQuery(this).val();
		jQuery( ".validation_message_1_4_34" ).remove();
		
		if(/^[A-Za-z0-9 _.-]+$/.test(chrOnly)) {

        }
		else {
		 jQuery("#1_4_34-element").append("<div class='validation_message_1_4_34' style='color:red';margin-left:2px;>Only alphaneumeric values allowed</div>");
		}
		
	});
	
jQuery("#1_1_69").keyup(function(){		//zipcode validation in tenant
	
		var chrOnly = jQuery(this).val();
		jQuery( ".validation_message_1_1_69" ).remove();
		
		if(/^[A-Za-z0-9 _.-]+$/.test(chrOnly)) {

        }
		else {
		 jQuery("#1_1_69-element").append("<div class='validation_message_1_1_69' style='color:red';margin-left:2px;>Only alphaneumeric values allowed</div>");
		}
		
	});
	
jQuery("#1_6_68").keyup(function(){		//zipcode validation in services
	
		var chrOnly = jQuery(this).val();
		jQuery( ".validation_message_1_6_68" ).remove();
		
		if(/^[A-Za-z0-9 _.-]+$/.test(chrOnly)) {

        }
		else {
		 jQuery("#1_6_68-element").append("<div class='validation_message_1_6_68' style='color:red';margin-left:2px;>Only alphaneumeric values allowed</div>");
		}
		
	});
jQuery("#1_1_15").keyup(function(){		//Annual Income validation in teanant
	
		var numbrOnly = jQuery(this).val();
		jQuery( ".validation_message_1_1_15" ).remove();
		
		if(/^[0-9]*(?:\.\d{1,2})?$/.test(numbrOnly)) {

        }
		else {
		 jQuery("#1_1_15-element").append("<div class='validation_message_1_1_15' style='color:red';margin-left:2px;>Only numbers allowed</div>");
		}
		
	});
	jQuery('#submit').click(function(){
	<?php
	    $accountSession = new Zend_Session_Namespace('User_Plugin_Signup_Account');
        $profileTypeValue = @$accountSession->data['profile_type'];
	?>
	var profileType	=	'<?php echo $profileTypeValue;?>';
	if(profileType == 6)
	{
		var Sstate = jQuery('#1_6_54 option:selected').val();
		var Scity = jQuery('#1_6_55 option:selected').val();
		jQuery('.validation_message_1_6_55').remove();
		jQuery('.validation_message_1_6_54').remove();

		if(Sstate == "" || Sstate == "Select State")
		{
			jQuery("#1_6_54-element").append("<div class='validation_message_1_6_54' style='color:red';margin-left:2px;>Please enter your state</div>");
			return false;
		}
		else
		{
			jQuery('.validation_message_1_6_54').remove();
		}
		
		if(Scity == "" || Scity == "Select City")
		{
			jQuery("#1_6_55-element").append("<div class='validation_message_1_6_55' style='color:red';margin-left:2px;>Please enter your city</div>");
			return false;
		}
		else
		{
			jQuery('.validation_message_1_6_55').remove();
		}
	}
	else if(profileType == 4)
	{
		var Lstate = jQuery('#1_4_30 option:selected').val();
		var Lcity = jQuery('#1_4_31 option:selected').val();
        jQuery('.validation_message_1_4_30').remove(); 
        jQuery('.validation_message_1_4_31').remove();
		if(Lstate == "" || Lstate == "Select State")
		{
			jQuery("#1_4_30-element").append("<div class='validation_message_1_4_30' style='color:red';margin-left:2px;>Please enter your state</div>");
			return false;
		}
		else
		{
			jQuery('.validation_message_1_4_30').remove();
		}
		
		if(Lcity == "" || Lcity == "Select City")
		{
			jQuery("#1_4_31-element").append("<div class='validation_message_1_4_31' style='color:red';margin-left:2px;>Please enter your city</div>");
			return false;
		}
		else
		{
			jQuery('.validation_message_1_4_31').remove();
		}
		
	}
	else if(profileType == 1)
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
	
	jQuery(document).ready(function()  {
		
		//signup gender field
		jQuery( "#1_1_6-month" ).addClass( "b_mnth" );
		jQuery( "#1_1_6-day" ).addClass( "b_day" );
		jQuery( "#1_1_6-year" ).addClass( "b_year" );
		jQuery( "#1_4_74-month" ).addClass( "lanlord_b_mnth" );
		jQuery( "#1_4_74-day" ).addClass( "lanlord_b_day" );
		jQuery( "#1_4_74-year" ).addClass( "lanlord_b_year" );
		jQuery( "#1_6_52-month" ).addClass( "service_b_mnth" );
		jQuery( "#1_6_52-day" ).addClass( "service_b_day" );
		jQuery( "#1_6_52-year" ).addClass( "service_b_year" );
		
		
		//placeholder
		
		jQuery("#1_1_3").attr("placeholder", "First Name  *");
		jQuery("#1_1_4").attr("placeholder", "Last Name  *");
		jQuery("#1_1_69").attr("placeholder", "Zip Code  *");
		jQuery("#1_1_13").attr("placeholder", "Say Something About Yourself  *");
		jQuery("#1_1_8").attr("placeholder", "Website");
		jQuery("#1_1_9").attr("placeholder", "Twitter");
		jQuery("#1_1_10").attr("placeholder", "Facebook");
		jQuery("#1_1_11").attr("placeholder", "AIM");
		jQuery("#1_4_17").attr("placeholder", "First Name  *");
		jQuery("#1_4_18").attr("placeholder", "Last Name  *");
		jQuery("#1_4_34").attr("placeholder", "Zip code  *");
		// repair agent
		jQuery("#1_34_83").attr("placeholder", "First Name  *");
		jQuery("#1_34_84").attr("placeholder", "Last Name  *");
		jQuery("#1_34_89").attr("placeholder", "Zipcode  *");
		jQuery("#1_34_90").attr("placeholder", "Phonenumber  *");
		jQuery("#1_34_93").attr("placeholder", "Employment  *");
		
		
	});
	
	
</script>
