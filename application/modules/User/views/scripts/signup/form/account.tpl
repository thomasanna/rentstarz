<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: account.tpl 10143 2014-03-26 16:18:25Z andres $
 * @author     John
 */
?>

<style>
#signup_account_form #name-wrapper {
  display: none;
}
</style>

<script type="text/javascript"> 
jQuery('#global_content').prepend('<div class="create_account_main_title">Welcome to Rentstarz, the social driven rental platform</div>');

//<![CDATA[
  window.addEvent('load', function() {
     jQuery('#services_type-wrapper').css('display','none');
    if( $('username') && $('profile_address') ) {
      $('profile_address').innerHTML = $('profile_address')
        .innerHTML
        .replace('<?php echo /*$this->translate(*/'yourname'/*)*/?>',
          '<span id="profile_address_text"><?php echo $this->translate('yourname') ?></span>');

      $('username').addEvent('keyup', function() {
        var text = '<?php echo $this->translate('yourname') ?>';
        if( this.value != '' ) {
          text = this.value;
        }

        $('profile_address_text').innerHTML = text.replace(/[^a-z0-9]/gi,'');
      });
      // trigger on page-load
      if( $('username').value.length ) {
          $('username').fireEvent('keyup');
      }
    }
    var selectedText    =   jQuery( "#profile_type option:selected" ).text();
    if(selectedText ==  'Services')
    {
        jQuery('#services_type-wrapper').css('display','block');
    }
  });
//]]>

function emailcheck()
{
    var email   =   jQuery.trim(jQuery("input[type='email']").val());
    //var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
            //if( !emailReg.test( email ) ) {
                //alert('Please enter valid email');
                //} else {
                    if(email)
                    {
                        jQuery( "div.confirm_text_first" ).replaceWith( '<div class="confirm_text_first">Email you input is <span style="color:blue">'+email+'.</span> Click Confirm if it is correct.</div>' );
                        document.getElementById('light').style.display='block';
                        document.getElementById('fade').style.display='block';
                    }

             //}

} 

jQuery('body').on('click', '.no_btn,.div_attachment_cancel', function(event){

    document.getElementById('light').style.display='none';
    document.getElementById('fade').style.display='none';
    jQuery("input[type='email']").focus();
});

</script>
<script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/scripts/lightbox-plus-jquery.min.js"></script>
<script>jQuery.noConflict();</script>

<?php echo $this->form->render($this) ?>

<!-- popup ------>
<div id="light" class="white_content">
<div class="pop_up_title"><div class="div_attachment_title">Confirm</div><div class="div_attachment_cancel"><img src="/application/modules/User/externals/images/GREYcancel.png"></div></div>
<div class="popup_content">

<div class="confirm_text_first">Email you input is <email>. Click Confirm if it is correct.</div>
<div class="confirm_text_second">Please note, you will not be able to change your email once signed up.</div>
<div class="confirm_btns" style="text-align: left;"><span class="confirm_btns"><button class="yes_btn" style="width: 134px;">Confirm</button><button class="no_btn" style="width: 134px;">Cancel</button></span>
<input type="hidden" value="" id="prty_id">

</div>
</div>
</div>
</div>
<div id="fade" class="black_overlay"></div>
<script type="text/javascript">
    jQuery(document).ready(function()  {
    var a =jQuery('#signup_account_form').find('input:first').addClass('1111');
    jQuery("#profile_type").find("option").eq(0).text('Select profile type  *');
    jQuery("#profile_type option[value=6]").hide();
    //jQuery("#profile_type option[value=" + title + "]").hide();
});
jQuery( "#password" ).blur(function() {
  password = jQuery( "#password" ).val();	
  if(/((?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%]).{6,})/.test(password)) {
	  jQuery("#password").css('border-color','dd1616');
	  jQuery( "#password" ).removeClass("error");
  }
  else{
	  jQuery( "#password" ).addClass("error");
	  jQuery("#password").focus();
	  jQuery("#password").val('');
	  jQuery("#password").attr('Placeholder','Invalid password');
  }
  });

/*function showServicesTypes(){
    var profile_type    =   jQuery('#profile_type').val();
    if(profile_type ==  '6')
    {
        jQuery('#services_type-wrapper').css('display','block');
        jQuery("label[for=services_type]").addClass('mand');
    }
    else
    {
        jQuery("#services_type").val('');
        jQuery('.validation_message').remove();
        jQuery('#services_type-wrapper').css('display','none');
    }
}*/

jQuery('#signup_account_form :input:enabled:visible:first').keyup(function(){   // email validation

    var emailOnly = jQuery(this).val();

    var id = jQuery(this).attr('id');
    jQuery( ".validation_message_email" ).remove();

        if(/\*/g.test(emailOnly) || /\#/g.test(emailOnly)) {
            jQuery('#'+id+'-element').append("<div class='validation_message_email' style='color:red';margin-left:2px;>Please enter valid email address</div>");
        }
        else {

        }

});

    jQuery('#submit').click(function(event){
    var profileType =   jQuery("#profile_type").val();
    if(profileType == 6)
    {
        var servicesType    =   jQuery("#services_type").val();
        jQuery('.validation_message').remove();
        if(servicesType == "" || servicesType == "Select services type")
        {
            jQuery("#services_type-element").append("<div class='validation_message' style='color:red';margin-left:2px;>Please enter your services type</div>");
            return false;
        }
        else
        {
            jQuery('.validation_message').remove();
        }
    }


 <?php /*   if (jQuery("#locationcheck").is(":checked")) {
        var oData       = new Object();
    var prty_country  = oData.prty_country =jQuery.trim(jQuery("#country").val());
    var prty_state    = oData.prty_state =jQuery.trim(jQuery("#administrative_area_level_1").val());
    var prty_city     = oData.prty_city =jQuery.trim(jQuery("#locality").val());
    if(prty_city == ''){
         var prty_city     = oData.prty_city =jQuery.trim(jQuery("#sublocality_level_1").val());
    }
    if (prty_country  == "" || prty_state =="" || prty_city=="")
    {   jQuery(".pro_field_wrapper .form-label").css('display','none');
        jQuery('.msg').text('Please select country,state and city');
         event.preventDefault();
    }
    } */?>


});

    jQuery('.yes_btn').click(function(){

    jQuery('form#signup_account_form').submit();
    document.getElementById('light').style.display='none';
    document.getElementById('fade').style.display='none';

});

jQuery( document ).ready(function() {
 jQuery("#country-wrapper").css('display','none');
 jQuery("#postal_code-wrapper").css('display','none');
 jQuery("#administrative_area_level_1-wrapper").css('display','none');
 jQuery("#locality-wrapper").css('display','none');
 jQuery("#latitude-wrapper").css('display','none');
 jQuery("#longitude-wrapper").css('display','none');
 jQuery("#sublocality_level_1-wrapper").css('display','none');
 jQuery("#neighborhood-wrapper").css('display','none');
 jQuery(".pro_field_wrapper .form-label").css('display','none');

});

</script>

        <input type= "hidden" class="field" id="street_number" name="street_number"></input>
        <input  type= "hidden" class="field" id="route" name="route"></input>
        <input type= "hidden"  class="field" id="neighborhood"></input>
        <input type= "hidden" class="field" id="locality" name="locality"></input>

        <input type= "hidden" class="field" id="sublocality_level_1"></input>

        <input type= "hidden" class="field" id="administrative_area_level_1" name="administrative_area_level_1"></input>
        <input type= "hidden" class="field" id="postal_code" name="postal_code"></input>

        <input type= "hidden" class="field" id="country" name="country"></input>
        <input type= "hidden" class="field" id="latitude" name="latitude"></input>
        <input type= "hidden" class="field" id="longitude" name="longitude"></input>

<script>
	// hide prefered location map
//jQuery('#global_page_user-signup-index #timezone-wrapper').after('<div class="pro_field_wrapper form-wrapper"><span class="location_text_span" style="font-weight: bold;"> </span>   <input id="pac-input" class="controls1" type="text" style="font-weight:bold;" placeholder="Location" ><div id="map" class="map_size"></div><div class="form-label" id="location-label">&nbsp;</div><span class="msg" style="color:red;"></span></div>');
jQuery('#locationcheck-wrapper').css('display','none');
</script>

<script>
var latitude  = 40.712784;
var longitude = -74.005941;
</script>


<?php /*<script src="<?php //echo $this->baseUrl(); ?>/application/modules/User/externals/scripts/autocomplete_address_googleapi.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAAWRDCCJZYbD17HwNNUMK-6DzyHziKhN8&libraries=places&callback=initAutocomplete" async defer></script>

*/ ?>
