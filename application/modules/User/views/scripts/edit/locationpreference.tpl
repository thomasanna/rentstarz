<div class="headline">
  <h2>
    <?php if ($this->viewer->isSelf($this->user) ):?>
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

     <div class="message" style='color:red'></div>
     <form>

        <?php if($this->prefered_location !=''):?>

            <?php if($this->prefered_location =='United States'):?>

            <input type= "hidden" class="field" id="street_number" ></input>
            <input  type= "hidden" class="field" id="route"></input>
            <input type= "hidden" class="field" id="locality"></input>
            <input type= "hidden" class="field" id="sublocality_level_1"></input>
            <input type= "hidden" placeholder="neighborhood" id="neighborhood"></input>
            <input type= "hidden" class="field" id="administrative_area_level_1" ></input>
            <input type= "hidden" class="field" id="postal_code"></input>

            <input type= "hidden" class="field" id="country"></input>
            <input type= "hidden" class="field" id="latitude"></input>
            <input type= "hidden" class="field" id="longitude"></input>

            <div class="pro_field_wrapper"> <span class="prty_lablel  popup_location_label">&nbsp;Select a Location </span> <input id="pac-input" class="controls1" type="text" placeholder="Location" style="font-weight:bold;" ></div>

            <div id="map" style="margin-top: 12px;"></div>

            <div class="pro_field_wrapper"><input type="checkbox" name="location" value="2" id="location" checked><span class="prty_lablel pro_label">&nbsp;Reset to USA </span>
            </div>

            <?php else: ?>

            <input type= "hidden" class="field" id="street_number"></input>
            <input  type= "hidden" class="field" id="route"></input>
            <input type= "hidden" class="field" id="locality" value="<?php echo $this->locationData->prty_city ?>"></input>
            <input type= "hidden" class="field" id="sublocality_level_1" value="<?php echo $this->county ?>"></input>
            <input type= "hidden" placeholder="neighborhood" id="neighborhood" value="<?php echo $this->neighborhood ?>"></input>
                            
            <input type= "hidden" class="field" id="administrative_area_level_1" value="<?php echo $this->locationData->prty_state ?>"></input>
            <input type= "hidden" class="field" id="postal_code" ></input>

            <input type= "hidden" class="field" id="country" value="<?php echo $this->locationData->prty_country ?>"></input>
            <input type= "hidden" class="field" id="latitude" value="<?php echo $this->locationData->latitude ?>"></input>
            <input type= "hidden" class="field" id="longitude" value="<?php echo $this->locationData->longitude ?>"></input>

            <div class="pro_field_wrapper"><span class="prty_lablel popup_location_label">&nbsp;Select a Location </span>   <input id="pac-input" class="controls1" type="text" placeholder="Location" style="font-weight:bold;" value="<?php 
            if($this->neighborhood!=''):
            echo $this->neighborhood .",";
            endif;
            if($this->county!=''):
            echo $this->county .",";
            endif;
            echo $this->locationData->prty_city ."," .$this->locationData->prty_state .",".$this->locationData->prty_country; ?>"></div>

            <div id="map" style="margin-top: 12px;"></div>

             <div class="pro_field_wrapper"><input type="checkbox" name="location" value="2" id="location"><span class="prty_lablel pro_label">&nbsp;Reset to USA </span>
            </div>

            <?php endif;?>

        <?php else: ?>


        <input type= "hidden" class="field" id="street_number" ></input>
        <input  type= "hidden" class="field" id="route"></input>
        <input type= "hidden" class="field" id="locality"></input>
        <input type= "hidden" class="field" id="sublocality_level_1"></input>
        <input type= "hidden" placeholder="neighborhood" id="neighborhood"></input>
        <input type= "hidden" class="field" id="administrative_area_level_1" ></input>
        <input type= "hidden" class="field" id="postal_code"></input>
        <input type= "hidden" class="field" id="country"></input>
        <input type= "hidden" class="field" id="latitude"></input>
        <input type= "hidden" class="field" id="longitude"></input>

        <div class="pro_field_wrapper"><span class="prty_lablel popup_location_label">&nbsp;Select a Location </span>   <input id="pac-input" class="controls1" type="text" placeholder="Location" style="font-weight:bold;"></div>

        <div id="map" style="margin-top: 12px;"></div>

        <div class="pro_field_wrapper"><input type="checkbox" name="location" value="2" id="location"><span class="prty_lablel pro_label">&nbsp;Reset to USA </span>
        </div>


        <?php endif;?>



        <input class="but_submit" type="button" value="Submit" name="">
        <div class="loader" style="display:none;"></div>
        </form>

</div>




<script>



<?php if($this->prefered_location != ''):?>

    <?php if($this->prefered_location !='United States'):?>

        var latitude  = <?php echo $this->locationData->latitude ?>;
        var longitude = <?php echo $this->locationData->longitude ?>;

    <?php else: ?>

        var latitude  = 40.712784;
        var longitude = -74.005941;

    <?php endif;?>

<?php else: ?>


var latitude  = 40.712784;
var longitude = -74.005941;

<?php endif;?>
initAutocomplete();
</script>

<!--<script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/scripts/autocomplete_address_googleapi.js"></script>


<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAOdWM32gJ4t6-csxQQxCVDigYfq261xi0&libraries=places&callback=initAutocomplete" async defer></script>
-->
<script>

var handleClick= 'ontouchstart' in document.documentElement ? 'touchstart': 'click';

jQuery('.but_submit').on(handleClick,function(){

    jQuery('.but_submit').css('display','none');
    jQuery('.loader').css('display','block');

    var oData       = new Object();
    var prty_country  = oData.prty_country =jQuery.trim(jQuery("#country").val());
    var prty_state    = oData.prty_state =jQuery.trim(jQuery("#administrative_area_level_1").val());
    var prty_city     = oData.prty_city =jQuery.trim(jQuery("#locality").val());
    if(prty_city == ''){
         var prty_city     = oData.prty_city =jQuery.trim(jQuery("#sublocality_level_1").val());
    }
    var prty_county     = oData.prty_county =jQuery.trim(jQuery("#sublocality_level_1").val());
    var prty_neighborhood     = oData.prty_neighborhood =jQuery.trim(jQuery("#neighborhood").val());
    var prty_street_address    = oData.prty_street_address =jQuery.trim(jQuery("#street_number").val());
    var prty_zipcode    = oData.prty_zipcode =jQuery.trim(jQuery("#postal_code").val());
    var prty_latitude    = oData.prty_latitude =jQuery.trim(jQuery("#latitude").val());
    var prty_longitude    = oData.prty_longitude =jQuery.trim(jQuery("#longitude").val());

    var set_to_usa    = oData.set_to_usa =jQuery("input[name=location]:checked").val();

    if((set_to_usa == undefined) &&  (prty_country =='' || prty_state =='' || prty_city =='')){


        jQuery('.message').text('Please select a location , Location field should have country , state and city');
        is_validated = false;

    }
    else {
        if(set_to_usa == undefined){

        if( prty_country !='' && prty_state !='' && prty_city !=''){

        is_validated = true;

        }
        else{

        is_validated = false;
        jQuery('.message').text('Location field should have country , state and city');
        }
        }
        else{

        is_validated = true;

        }
    }

    if( is_validated == true){

    if(set_to_usa == undefined){
        oData.set_to_usa ='';
    }

        var formURL    = '<?php echo $this->baseUrl(); ?>' + '/user/edit/savelocationpreference';

        jQuery.ajax( {
                        url : formURL,
                        type: "POST",
                        dataType: 'json',
                        data : oData,
                            success: function (returndata) {
							 jQuery("#successModal .success_message").text('');
                             jQuery("#successModal .success_message").text('You have successfully saved your prefered location');
                             jQuery("#successModal").modal('show'); 
                            },
                            error: function(e){
                           jQuery(".loader").css("display", "none");
                           jQuery('.but_submit').css('display','block');  }

                        });

    }
    else{

        jQuery('.but_submit').css('display','block');
        jQuery('.loader').css('display','none');

    }


});



jQuery('#location').on('click',function(){


    if (jQuery(this).is(':checked')) {
            jQuery("#country").val('');
            jQuery("#administrative_area_level_1").val('');
            jQuery("#locality").val('');
            jQuery("#sublocality_level_1").val('');
            jQuery("#neighborhood").val('');
            jQuery("#street_number").val('');
            jQuery("#postal_code").val('');
            jQuery("#latitude").val('');
            jQuery("#longitude").val('');
            jQuery("#pac-input").val('');
        }
    else{

    }

});




jQuery('#global_page_user-edit-locationpreference .headline').append('<span class="profile_click mob_bar" style="float:right;width: 5%;font-size: medium;"><i class="fa fa-bars" aria-hidden="true"></i></span>');

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

 jQuery('#successModal .close').on('click',function(){ 
	 
	 
		event.preventDefault();
	    var url = '<?php echo $this->baseUrl().'/user/index/unsetsessions' ?>';
	    var oData       = new Object();
        jQuery.ajax({
                        data: oData,
                        url : url,
                        dataType: 'json',
                        type: 'POST',
                        success: function (data) {
                        location.href = '<?php echo $this->baseUrl(); ?>' + '/members/home';                       
                     },
                       error: function(e){ }
            });
 
	 
	 
        location.href = '<?php echo $this->baseUrl(); ?>' + '/members/home';
});

</script>
