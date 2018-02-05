<script src="/application/modules/User/externals/scripts/message_notififaction.js"></script>


 <div class="generic_layout_container layout_middle">

     <div class="map_container">

     <div class="message" style='color:red'></div>
     <form>




        <input type= "hidden" class="field" id="street_number" ></input>
        <input  type= "hidden" class="field" id="route"></input>
        <input type= "hidden" class="field" id="locality"></input>
        <input type= "hidden" class="field" id="sublocality_level_1"></input>
        <input type= "hidden"  id="neighborhood" readonly></input>
        <input type= "hidden" class="field" id="administrative_area_level_1" ></input>
        <input type= "hidden" class="field" id="postal_code"></input>

        <input type= "hidden" class="field" id="country"></input>
        <input type= "hidden" class="field" id="latitude"></input>
        <input type= "hidden" class="field" id="longitude"></input>

        <div class="popup_location_label">Select Location</div>
            <input id="pac-input" class="controls1" type="text" placeholder="Location" style="font-weight:bold">


        <div id="map"></div>
        <div class="pro_field_wrapper"><input type="checkbox" name="set_to_usa_1" value="2" id="set_to_usa_1" style="margin-right: 8px;"><span class="prty_lablel">&nbsp;Reset to USA </span></div>
        <div class="map_options">
      <!--  <div class="prefered_loc_chk_div">
         <input type="checkbox" class= "prefered_loc_chk" name="prefered_loc_chk" style="margin-right: 8px;"> Add this location as your preferred location
        </div>-->
        <div class="set_location_btn_div" style="margin-top: 12px;">
        <input class="change_location_submit_btn" type="button" value="Save">
        <a href="<?php echo $this->baseUrl().'/members/home'; ?>" >  <button type="button"  id="back" class="backtohome"><?php echo $this->translate("Back") ?></button></a>
        <div class="loader" style="display:none;"></div>
        </div>
        </div>
        </form>
    </div>

</div>


<script>

<?php $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); ?>

var viewer_identity='<?php echo $viwer_id; ?>';
var latitude  = 40.712784;
var longitude = -74.005941;


</script>

<script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/scripts/autocomplete_address_googleapi.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAOdWM32gJ4t6-csxQQxCVDigYfq261xi0&libraries=places&callback=initAutocomplete" async defer></script>

<script>
jQuery( ".change_location_submit_btn" ).click(function() {

    //jQuery('.change_location_submit_btn').css('display','none');
    jQuery('.change_location_submit_btn').hide();
    jQuery('.backtohome').hide();
    jQuery(".loader").css("display", "block");
    var oData       = new Object();
    var prty_country  = oData.prty_country =jQuery.trim(jQuery("#country").val());
    var prty_state    = oData.prty_state =jQuery.trim(jQuery("#administrative_area_level_1").val());
    var prty_city     = oData.prty_city =jQuery.trim(jQuery("#locality").val());
    if(prty_city == ''){
         var prty_city     = oData.prty_city =jQuery.trim(jQuery("#sublocality_level_1").val());
    }
    var prty_street_address    = oData.prty_street_address =jQuery.trim(jQuery("#street_number").val());
    var prty_zipcode    = oData.prty_zipcode =jQuery.trim(jQuery("#postal_code").val());
    var prty_latitude    = oData.prty_latitude =jQuery.trim(jQuery("#latitude").val());
    var prty_longitude    = oData.prty_longitude =jQuery.trim(jQuery("#longitude").val());
    var prty_location    = oData.prty_location =jQuery.trim(jQuery("#pac-input").val());
    var prty_neighborhood    = oData.prty_neighborhood =jQuery.trim(jQuery("#neighborhood").val());
    var prty_county    = oData.prty_county =jQuery.trim(jQuery("#neighborhood").val());
    var prty_county     =  oData.prty_county =jQuery.trim(jQuery("#sublocality_level_1").val());   
    var is_prefered_location = oData.is_prefered_location = jQuery('.prefered_loc_chk').prop("checked");
    var set_to_usa = oData.set_to_usa = jQuery('#set_to_usa_1').prop("checked");
    var is_validated = false;
     if((set_to_usa == false) &&  (prty_country =='' && prty_state =='' && prty_city =='')){
        jQuery('.message').text('Please select a valid location ');
        is_validated = false;
    }
    else {
        if(set_to_usa == false){
            if( prty_country !='' || prty_state !='' || prty_city !=''){
            is_validated = true;
            }
            else{
            is_validated = false;
            jQuery('.message').text('Please select a valid location');
            }
        oData.set_to_usa ='';
        }
        else{
        is_validated = true;
        }
    }
    if(is_validated == true) {
        var formURL    = '<?php echo $this->baseUrl(); ?>' + '/user/index/setlocation';
        jQuery.ajax( {
                        url : formURL,
                        type: "POST",
                        dataType: 'json',
                        data : oData,
                            success: function (returndata) {
                                    location.href = '<?php echo $this->baseUrl(); ?>' + '/members/home';
                            },
                            error: function(e){
                           jQuery(".loader").css("display", "none");
                           jQuery('.change_location_submit_btn').css('display','block');  }
                        });

     }

    else{

        jQuery('.change_location_submit_btn').show();
        jQuery('.backtohome').show();
        jQuery(".loader").css("display", "none");


        jQuery('.message').text('Please select a valid location');
    }
});

</script>
