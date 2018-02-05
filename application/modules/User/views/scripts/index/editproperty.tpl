<script src="/application/modules/User/externals/scripts/message_notififaction.js"></script>
<?php $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
$viewer     = Engine_Api::_()->user()->getViewer();
$viewHelperObj  = $this->getHelper('SmartmoveApi');
$StateArray     = $viewHelperObj->getState();
$displayname  = $viewer->displayname;
$displaynameArray =explode(' ',$displayname);
?>
<script src="http://p.jwpcdn.com/6/10/jwplayer.js"></script>


            <input type="hidden" id="shareuploads" value="<?php echo $this->shareupload; ?>" />
            <input type="hidden" id="feeduploads" value="<?php echo $this->feeduploads; ?>" />
            <input type="hidden" placeholder="" name="main-image" id="main-image" value="0">

<div class="generic_layout_container layout_user_browse_menu">
<div class="headline">
  <h2> Edit Property  </h2>
  <div class="tabs">
      </div>
</div>
</div>


<div class="generic_layout_container layout_middle">
    <article class="padding_top_bottom20">
        <div class="maincontentdiv">
            <article class="content_main_left">
                <div class="padding_bottom20" style="position: relative;">

                  <div class="message" style='color:red'></div>
                  <div></div>
                    <form id="property_entry_form" enctype="multipart/form-data">


                        <div class="form-wrapper-heading" style="font-weight: 900;color: black;">Property Details</div></br>
                  <div class="input_fields_area">
                        <div class="pro_field_wrapper">
                              <input name="property_name" type="text" maxlength="65" placeholder="Property Name" id="property_name" class="prty_field input-box" value="<?php echo $this->propertyData-> property_name;  ?>" autofocus>
                        </div>
                        <br>

                            <div class="pro_field_wrapper">
                            <select name="rental_type" id="rental_type"  class="prty_field input-box">
                                             <option value="">Type of rental</option>
                                             <option value="Rent">Rental</option>
                                             <option value="Lease">Lease</option>

                                             </select>

                            </div>   <br>
                            <div class="pro_field_wrapper">
                            <select name="housing_type" id="housing_type"  class="prty_field input-box">
                                             <option value="">Select housing type</option>
                                             <option value="Apartment">Apartment</option>
                                             <option value="Room">Room</option>
                                             <option value="House">House</option>
                                             <option value="Villa">Villa</option>
                                             </select>
                            </div>   <br>                            
                                                       
                            <div class="num_rooms_pro_field_wrapper">
                            <div class="pro_field_wrapper">
                             <span class="num_rooms" >
                             <select name="add_property_number_of_rooms" id="add_property_number_of_rooms"  class="prty_field input-box">
                                             <option value="">Number of bedrooms</option>
                                             <option value="1">1</option>
                                             <option value="2">2</option>
                                             <option value="3">3</option>
                                             <option value="4">4</option>
                                             <option value="4+">4+</option>

                                             </select> </span> 
                            </div>  <br>
                            </div>                                                        
                            
                            <div class="pro_field_wrapper">
                            <input name="add_property_price" type="text" maxlength="65" placeholder="Rental prices (monthly)" id="add_property_price"  class="prty_field input-box" value="<?php echo $this->propertyData->price;   ?>">

                            </div>   <br>

                             <div class="pro_field_wrapper">
                                  <select name="wheel_chair_accessible" id="wheel_chair_accessible"  class="prty_field input-box">
                                             <option value="">Is this property wheel chair accessible?</option>
                                             <option value="Yes">Yes</option>
                                             <option value="No">No</option>
                             </select></div>   <br>

                             <div class="pro_field_wrapper">
                                 <select name="months_of_deposits" id="months_of_deposits"  class="prty_field input-box">
                                             <option value="">How many months deposits required?</option>
                                             <option value="1">1</option>
                                             <option value="2">2</option>
                             </select></div>   <br>


                            <div class="pro_field_wrapper">
                                  <select name="have_property_manager" id="have_property_manager"  class="prty_field input-box">
                                             <option value="">Does this property have a property manager?</option>
                                             <option value="Yes">Yes</option>
                                             <option value="No">No</option>
                             </select></div>   <br>

                             <div class="pro_field_wrapper">
                             <select name="parking" id="parking"  class="prty_field input-box">
                                             <option value="">Does this unit provide parking?</option>
                                             <option value="Yes">Yes</option>
                                             <option value="No">No</option>
                             </select></div>   <br>


                            <div class="pro_field_wrapper">
                              <select name="allowed_pets" id="allowed_pets"  class="prty_field input-box" onchange="petsType()">
                                             <option value="">Pets Allowed</option>
                                             <option value="Yes">Yes</option>
                                             <option value="No">No</option>

                             </select></div>   <br>


                             <div class="pets_type_wrapper" style="display:none">
                            <div class="pro_field_wrapper" >
                              <select name="pets_type" id="property_add_pets_type"  class="prty_field input-box">
                                             <option value="">What kind of pets ?</option>
                                             <option value="Cats">Cats</option>
                                             <option value="Dogs">Dogs</option>
                                             <option value="Cats & Dogs">Cats & Dogs</option>
                                             <option value="Birds">Birds</option>
                                             <option value="Small pets">Small pets</option>

                             </select> 
                            </div>
                            </div>
                            <br>                          
  </div>
                     <div class="map_area">
                            <div id="map"></div>
                            <div class="map_fields pro_field_wrapper">
                            <input type= "hidden" placeholder="Street_number" class="field" id="street_number"></input>
                            <input  type= "hidden" class="field" id="route"></input>
                            <input type= "hidden" placeholder="Neighborhood" class="field input-box" id="neighborhood" value="<?php echo $this->propertyData->prty_neighborhood ;?>" readonly></input>
                            <input type= "hidden" placeholder="City" class="field input-box input-box" id="locality" value="<?php echo $this->propertyData->prty_city ; ?>" ></input>
                            <input type= "hidden" placeholder="sublocality county" class="field" id="sublocality_level_1"></input>
                            <input type= "hidden" placeholder="State" class="field input-box" id="administrative_area_level_1" value="<?php echo $this->propertyData->prty_state ;?>"></input>                          
                            <input type= "hidden" placeholder="Country" class="field input-box" id="country" value="<?php echo $this->propertyData->prty_country ;?>" ></input>
                            <input type= "hidden" class="field" id="latitude"></input>
                            <input type= "hidden" class="field" id="longitude"></input>

                            </div>
                             <div class="pro_field_wrapper">
                            <input id="pac-input1" class="controls1 input-box prty_field" type="text" placeholder="Location" value="<?php echo $this->propertyData->prty_city ."," .$this->propertyData->prty_state .",".$this->propertyData->prty_country; ?>">
                            </div>
                            <br>
                             <div class="pro_field_wrapper">
                            <input type= "text" placeholder="Zipcode" class="field property_zipcode input-box prty_field" id="postal_code" value="<?php echo $this->propertyData->zip ;?>"  ></input>
                            </div>
                            <br>
                        </div>

                   <div class="prty_lablel des">Description </div>  <div class="dis"><div class="edit_des_span"> <textarea name="description" cols="5" rows="4" id="description"  class="prty_field" ><?php echo $this->propertyData->description; ?></textarea></div> </div>

                            <div class="prty_images_list" style="margin-top: 12px;">

                            <?php foreach ($this->propertyImageData as $propertyImage):?>
                            <div class="prty_image prty_image_<?php echo $propertyImage['id'];?>" style="background: url(<?php echo $this->baseUrl().'/'.$propertyImage['image'];?>) center no-repeat;width:58px; height:58px; background-size: cover;">
                                <a href="javascript:void(0);" class="delete-prty_image"  data-image="<?php echo $propertyImage['id'];?>"><i class="fa fa-times-circle" aria-hidden="true"></i></a>


                            </div>
                            <?php endforeach;?>
                            </div>
                            <div class="prty_images_list" style="margin-top: 12px;">

                            <?php if($this->propertyVideoData) :
                            foreach($this->propertyVideoData as $videos):?>
                            <div id="videoElement_<?php echo $videos['file_id'];?>"></div>
                            <div><a href="javascript:void(0);" class="delete-share-videos video_<?php echo $videos['file_id'];?>" data-file="<?php echo $videos['file_id'];?>" data-video="<?php echo $videos['parent_id'];?>" data-imagepath="<?php echo $videos['storage_path']; ?>"><i class="fa fa-times-circle" aria-hidden="true"></i></a></div>

                            <script type="text/javascript">
                            var playerInstance = jwplayer("videoElement_<?php echo $videos['file_id'];?>");
                            playerInstance.setup({
                                image: "<?php echo $this->baseUrl().$imglocation;?>",
                                file: "<?php echo $this->baseUrl().'/'.$videos['storage_path'];?>",
                                width: 140,
                                height: 140
                            });

                            jQuery('#videoElement_<?php echo $videos['file_id'];?>').on('click',function(){
                            jwplayer("videoElement_<?php echo $videos['file_id'];?>").play();
                            });
                            </script>
                            <?php endforeach;?>
                            <?php endif; ?>
                            </div>
                          <input type="hidden" value="" class="input_image_ids">
                          <input type="hidden" value="" class="input_file_ids">
                          <input type="hidden" value="" class="input_video_ids">
                    <div class="padding_top_bottom submit_btn " style="position: absolute; bottom: -40px;">

                        <input class="but_submit" type="button" value="Submit" name=""style="width:213px !important">
                    </div>

                    </form>


                   <div class="upload_pic_video" style="border:none; clear: both;">
                   <div class="pro_field_wrapper" style="clear: both">
                   <div class="post-upload-box" id="upload-preview"> </div>
                   <div class="name_ifo_hours_holder_right" style="float:left;width:240px;">

                    <form id="shareupload" action="<?php echo $this->baseurl('activity/ajax/shareupload/shareuploads/'); ?>" method="POST" enctype="multipart/form-data">
                    <input type="hidden" placeholder="" name="existing_image_count" id="existing_image_count" value="0">
                                    <div class="input_type_file">
                                        <div class="margin_top20">
                                            <label class="upload_file prty_lablel"><span>Upload Photo</span>
                                                <input name="" type="file" accept="image/*" multiple>
                                            </label>
                                        </div>
                                    </div>
                                    <span>Maximum image upload count is 12</span>
                                    <div id="image_error_div" style="color:red"></div>
                    </form>
                    </div>
                    </div>
                    <div class="pro_field_wrapper" style="clear: both">
                   <div class="post-upload-box" id="video-upload-preview"> </div>
                   <div class="name_ifo_hours_holder_right" style="width:240px;">
                    <form id="shareuploadvideo" action="<?php echo $this->baseurl('videos/index/uploadideo/'); ?>" method="POST" enctype="multipart/form-data">
                        <div class="input_type_file">
                            <div class="margin_top20">
                                <label class="upload_file"><span>Upload Video</span>
                                    <input name="" type="file" >
                                </label>
                            </div>
                        </div>
                    </form>
                    </div>
                    </div>
                   </div>

            <div class="loader" style="display:none;"></div>

            </article>

        </div>
        <div class="clear"></div>
    </article>


</div>
<?php $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); ?>
<div id="stantard-dialogBox" style="font-size:30px"></div>

<script  type="text/javascript">

    var viewer_identity='<?php echo $viwer_id; ?>';

    var UnitNumber =  '<?php echo $this->smartmoveapiPropertyData->UnitNumber?>';
    var Street =  '<?php echo $this->smartmoveapiPropertyData->Street?>';
    var Zip =  '<?php echo $this->smartmoveapiPropertyData->Zip?>';
    var Phone =  '<?php echo $this->smartmoveapiPropertyData->Phone?>';
    var PhoneExtension =  '<?php echo $this->smartmoveapiPropertyData->PhoneExtension?>';


 //   var accept_vouchers =  '<?php echo $this->propertyData['vouchers']?>';
    var wheel_chair_accessible =  '<?php echo $this->propertyData['wheelchair_accessible']?>';
    var months_of_deposits =  '<?php echo $this->propertyData['months_of_deposits']?>';
    var have_property_manager =  '<?php echo $this->propertyData['property_manager']?>';
    var parking =  '<?php echo $this->propertyData['provide_parking']?>';


  //  jQuery('#accept_vouchers').val(accept_vouchers);
    jQuery('#wheel_chair_accessible').val(wheel_chair_accessible);
    jQuery('#months_of_deposits').val(months_of_deposits);
    jQuery('#have_property_manager').val(have_property_manager);
    jQuery('#parking').val(parking);




var latitude  = <?php echo $this->propertyData->latitude;   ?>;
var longitude = <?php echo $this->propertyData->longitude;  ?>;
jQuery(document).ready(function(){
   initAutocomplete();
});
</script>

<script src='//cdn.tinymce.com/4/tinymce.min.js'></script>

<script type="text/javascript">

tinymce.init({
    selector: '#description',
    setup: function (editor) {
        editor.on('keyup', function (e) {

        jQuery('.des_length').text('');
        jQuery( ".des_length" ).remove();
        var description = tinymce.get('description').getContent();

        descripltion_plain_text = jQuery(description).text();

        var des_length = descripltion_plain_text.length;
        jQuery('.edit_des_span').append('<div class="des_length">'+des_length+' / 10000 characters</div>');

        });
        editor.on('init', function()
        {
        });
    }
  });

var allowedfiles=12;
var handleClick= 'ontouchstart' in document.documentElement ? 'touchstart': 'click';

jQuery( document ).ready(function() {
	
     jQuery("#allowed_pets").val('<?php echo $this->propertyData->has_pets?>');
     jQuery("#rental_type").val('<?php echo $this->propertyData->rental_type?>');
     jQuery("#housing_type").val('<?php echo $this->propertyData->housing_type?>');
     
     var housing_type= '<?php echo $this->propertyData->housing_type?>';
  
     if(housing_type=="Room"){
		 jQuery(".num_rooms_pro_field_wrapper").css('display','none')

     }
     
     jQuery("#add_property_number_of_rooms").val('<?php echo $this->propertyData->no_of_rooms?>');
     jQuery("#add_property_price").val('<?php echo $this->propertyData->price?>');


     var hasPet =   jQuery('#allowed_pets').val();
    jQuery('#property_add_pets_type').val('');
        if(hasPet   ==  'Yes')
        {
            jQuery('.pets_type_wrapper').css('display','block');
            jQuery("#property_add_pets_type").val('<?php echo $this->propertyData->pets_type    ?>');
        }
        else
        {
            jQuery('.pets_type_wrapper').css('display','none');
        }

jQuery( "#allowed_pets" ).change(function() {

    var hasPet  =   jQuery('#allowed_pets').val();
    jQuery('#property_add_pets_type').val('');
    if(hasPet   ==  'Yes')
    {
        jQuery('.pets_type_wrapper').css('display','block');
    }
    else
    {
        jQuery('.pets_type_wrapper').css('display','none');
    }
});


jQuery( "#housing_type" ).change(function() {

    var housing_type= jQuery("#housing_type").val();
    if(housing_type =='Room' || housing_type ==''){
		 jQuery(".num_rooms_pro_field_wrapper").css('display','none')
        
    }
    else{
       jQuery(".num_rooms_pro_field_wrapper").css('display','block');
	
    }

});


var property_image_count='<?php echo count($this->propertyImageData); ?>';
if(property_image_count==12)
{
    jQuery('#shareupload').css('display','none');
}
});


jQuery('.but_submit').on(handleClick,function(){



    var userid = '<?php echo Engine_Api::_()->user()->getViewer()->getIdentity(); ?>';
    var error     =  false;
    var oData       = new Object();
    var property_id = oData.property_id = '<?php echo $this->propertyData->id?>';
    var propertyowner_id = oData.property_owner_id   = '<?php echo $this->propertyData->property_owner_id   ?>';
    var property_name  = oData.property_name =jQuery.trim(jQuery("#property_name").val());
    var country  = oData.country =jQuery.trim(jQuery("#country").val());
    var state    = oData.state =jQuery.trim(jQuery("#state").val());
    var city     = oData.city =jQuery.trim(jQuery("#city").val());
    var rental_type     = oData.rental_type =jQuery.trim(jQuery("#rental_type").val());
    var price     = oData.price =jQuery.trim(jQuery("#add_property_price").val());
    //var description     = oData.description =jQuery.trim(jQuery("#description").val());
    var description     = oData.description = tinymce.get('description').getContent();
    var number_of_rooms     = oData.number_of_rooms =jQuery.trim(jQuery("#add_property_number_of_rooms").val());
    var housing_type     = oData.housing_type =jQuery.trim(jQuery("#housing_type").val());
    
    if(housing_type=="Room"){
		 var number_of_rooms     = oData.number_of_rooms =0;
	}
    
    
    var allowed_pets     = oData.allowed_pets = jQuery.trim(jQuery("#allowed_pets").val());
    var pets_type     = oData.pets_type =jQuery.trim(jQuery("#property_add_pets_type").val());
//  var zipcode     = oData.zipcode =jQuery.trim(jQuery("#zipcode").val());
    var removed_images = oData.removed_images = jQuery('.input_image_ids').val();
    var removed_fileids = oData.removed_fileids = jQuery('.input_file_ids').val();
    var removed_videos = oData.removed_videos = jQuery('.input_video_ids').val();

    var prty_country  = oData.prty_country =jQuery.trim(jQuery("#country").val());
    var prty_state    = oData.prty_state =jQuery.trim(jQuery("#administrative_area_level_1").val());
    var prty_city     = oData.prty_city =jQuery.trim(jQuery("#locality").val());
    if(prty_city == ''){
         var prty_city     = oData.prty_city =jQuery.trim(jQuery("#sublocality_level_1").val());
    }
 
    var prty_county     =  oData.prty_county =jQuery.trim(jQuery("#sublocality_level_1").val());
 
    var prty_neighborhood     =  oData.prty_neighborhood =jQuery.trim(jQuery("#neighborhood").val());
    
    
    var prty_street_address    = oData.prty_street_address =jQuery.trim(jQuery("#street_number").val());
    var prty_zipcode    = oData.prty_zipcode =jQuery.trim(jQuery("#postal_code").val());
    var prty_latitude    = oData.prty_latitude =jQuery.trim(jQuery("#latitude").val());
    var prty_longitude    = oData.prty_longitude =jQuery.trim(jQuery("#longitude").val());
    var prty_location    = oData.prty_location =jQuery.trim(jQuery("#pac-input1").val());

    var smartmoveApiEnable              = oData.smartmoveApiEnable = '<?php echo $this->smartmoveApiEnable;  ?>';
   // var accept_vouchers= oData.accept_vouchers =jQuery.trim(jQuery("#accept_vouchers").val());
    var wheel_chair_accessible= oData.wheel_chair_accessible =jQuery.trim(jQuery("#wheel_chair_accessible").val());
    var months_of_deposits= oData.months_of_deposits =jQuery.trim(jQuery("#months_of_deposits").val());
    var have_property_manager= oData.have_property_manager =jQuery.trim(jQuery("#have_property_manager").val());
    var parking= oData.parking =jQuery.trim(jQuery("#parking").val());
    

    var count_of_existing_images = '<?php echo count($this->propertyImageData)?>';

    var valueOfFileId   =   new Array();
    var valueOfType     =   new Array();
    jQuery.each(jQuery('input'),function(i,val){
        if((jQuery(this).attr("type")=="hidden")){
            if(jQuery(this).attr("id") == "file_id"){
            valueOfFileId.push(jQuery(this).val());
            }
        }
    });

    jQuery.each(jQuery('input'),function(i,val){
        if((jQuery(this).attr("type")=="hidden")){
            if(jQuery(this).attr("id")=="upload_type"){
            valueOfType.push(jQuery(this).val());
        }
        }
    });

    var removed_imagesArray = removed_images.split(',');

    var count_removed_images = removed_imagesArray.length-1;

    //var file_ids  = oData.file_id = JSON.stringify(valueOfFileId);alert(file_ids);
    var file_ids    = oData.file_id = jQuery('#file_id').val();
    var upload_types    = oData.upload_type = JSON.stringify(valueOfType);
    var hasimage = jQuery.trim(jQuery('.prty_images_list').html()).length;


    if(hasimage == 0){
        var hasupoadimage = jQuery.trim(jQuery('#upload-preview').html()).length;
    }
    else{

        if(count_removed_images == count_of_existing_images){
        var hasupoadimage = jQuery.trim(jQuery('#upload-preview').html()).length; }
        else{
        var hasupoadimage = 1; }
    }

    var is_validated = true;

    
    if(property_name =='' || prty_country =='' || prty_state =='' || prty_city =='' || rental_type =='' || price =='' || description =='' || 
    housing_type =='' || allowed_pets == '' || hasupoadimage == 0  ||
    wheel_chair_accessible =='' || months_of_deposits =='' || have_property_manager ==''|| parking =='' || prty_zipcode==''){
		    
    if(prty_zipcode ==''){ jQuery('#postal_code').css('border-color','#e62828');          }
    else { jQuery('#postal_code').css('border-color','#b2c6cd');                          }
		    
		     jQuery('.message').text('Please fill all the fields');
             is_validated = false;
	}
    else{
		 is_validated = true;		
	}
    if(is_validated ==  true){
		var regex   =   /^[0-9]*$/;
		var price = jQuery('#add_property_price').val();
		if( !regex.test(price) ) {
         jQuery(".price_validation").html("");
         jQuery(".price_valid").append("<div class='price_validation' style='color:red;margin-left:2px;font-weight: normal;'>Numbers Only</div>");
         var is_validated =false;
         }
         else{
          var is_validated =true;
         }
	}
if(is_validated == true){	   
	if(housing_type =='Apartment' || housing_type =='House')	
	{
		 if(number_of_rooms ==''){ 
		jQuery('#add_property_number_of_rooms').css('border-color','#e62828');
		jQuery('.message').html('Please fill number of rooms');
		 is_validated = false;
		} 
		else{
		  jQuery('#add_property_number_of_rooms').css('border-color','#b2c6cd'); 
		   is_validated = true;
		}
	}
}
    if(is_validated ==  true){
		descripltion_plain_text = jQuery(description).text();
        if(descripltion_plain_text !=''){
            jQuery( ".discription_validation" ).remove();
            if(descripltion_plain_text.length < 100){
            jQuery(".dis").append("<div class='discription_validation' style='color:red;margin-left:2px;font-weight: normal;'>Description should have atleast 300 characters</div>");
            is_validated = false;
            }
            else{
            is_validated = true;
            }
         }
	}
   if(is_validated ==  true){
	   if(housing_type == 'Bedroom' && number_of_rooms =='' ){
		   jQuery('#add_property_number_of_rooms').css('border-color','#dd1616');
           is_validated = false;
       }
       else{
		jQuery('#add_property_number_of_rooms').css('border-color','#b2c6cd');	
		is_validated = true;
		}
   }
   if(is_validated ==  true){
	  if(allowed_pets == 'Yes' && pets_type =='' ){
		jQuery('#property_add_pets_type').css('border-color','#dd1616'); 
        is_validated = false;
      }
      else{
			jQuery('#property_add_pets_type').css('border-color','#b2c6cd');
			is_validated = true;
		} 
   }
   if(is_validated ==  true){
	   if(prty_zipcode != ''){
        jQuery(".message").text('');
        if(/([0-9]{5})+$/.test(prty_zipcode)) {
         jQuery(".property_zipcode").css('border-color','b2c6cd');
         is_validated = true;
        }
        else {
         jQuery(".message").text('Zipcode should have exact 5 numeric values');
         is_validated =false;
        }
    } 	   
   }
   if(is_validated ==  true){
	   if(prty_zipcode ==''){
                    jQuery(".message").text('');       
                    jQuery(".message").text('please enter zipcode');
                    is_validated =false;         
        }
        else{is_validated = true;}    
   }
   if(is_validated ==  true){
    if(prty_country =='' || prty_state =='' || prty_city =='' || prty_location ==''){
            jQuery('.message').text('Location field should have country , state and city');
            is_validated = false;
            }
            else{is_validated = true;}    
	}

    if(is_validated == true){

        // jQuery('.zipcode_validation').css('display','none');
         jQuery('.but_submit').css('display','none');
         jQuery(".loader").css("display", "block");
         if(jQuery('#shareuploads').val()&&jQuery('#feeduploads').val())
         var formURL    = '<?php echo $this->baseUrl(); ?>' + '/user/index/saveedittedproperty/shareuploads/'+jQuery('#shareuploads').val()+'/feeduploads/'+jQuery('#feeduploads').val()+"/t/"+new Date().getTime();
         else
         var formURL    = '<?php echo $this->baseUrl(); ?>' + '/user/index/saveedittedproperty'+"/t/"+new Date().getTime();

         jQuery.ajax( {
                        url : formURL,
                        type: "POST",
                        dataType: 'json',
                        data : oData,
                            success: function (returndata) {
                                //return false;

                            if(returndata.status==true) {
								jQuery("#successModal .success_message").text('');
                                jQuery("#successModal .success_message").text('Succesfully updated');
                                jQuery("#successModal").modal('show');
                               
                            }else{

                                console.log(returndata.errors);
                                jQuery(".loader").css("display", "none");
                                jQuery('.but_submit').css('display','block');

                            }
                            },
                            error: function(e){
                           jQuery(".loader").css("display", "none");
                           jQuery('.but_submit').css('display','block');  }

                        });
         }       

    });

    jQuery('#existing_image_count').val('<?php echo count($this->propertyImageData)?>');

    var image_error=0; var total_image_uploaded = 0;
         jQuery('#shareupload').fileupload({
            autoUpload : true,
            uploadTemplateId: null,
            downloadTemplateId: null,
            sequentialUploads:true,
            dropZone: jQuery('.share-text-field'),
            acceptFileTypes:'/(\.|\/)(gif|jpe?g|png)$/i',
            url:'<?php echo $this->baseUrl(); ?>'+'/activity/ajax/shareupload/shareuploads/<?php echo $this->shareupload; ?>/feeduploads/<?php echo $this->feeduploads; ?>'+"/t/"+new Date().getTime()
        }).bind('fileuploaddone', function (e, data) {
            jQuery(".loader").css('display','none');
            loaduploadpreview('upload-preview');
            jQuery('#shareupload').addClass('one_uploaded');
            updateuploadoption();
        }).bind('fileuploadadd', function (e, data) {
            jQuery(".loader").css('display','block');
            jQuery('#progressbar').show();jQuery('.add-tag-box').show();
            jQuery('#progress_fancy .bar').css(
                'width',
                '0%'
            );
        })
         .bind('fileuploadchange', function (e , data) {
        image_error = 0;
        total_image_uploaded = data.files.length;
        })
        .bind('fileuploadadded', function (e, data) {
                    var fileType = data.files[0].name.split('.').pop(), allowdtypes = 'gif,jpeg,jpg,png';
                    if (allowdtypes.indexOf(fileType.toLowerCase()) < 0) {
                        jQuery(".loader").css('display','none');
                        var str = jQuery('#image_error_div').html();
                        //jQuery('#progress_fancy').html('<p>Invalid format '+data.files[0].name+'</p>');
                        jQuery('#image_error_div').html('<p>Not an accepted file type</p>');
                        image_error++;
                        setTimeout(function(){
                        //jQuery('#progress_fancy').html(str);
                        if(image_error==total_image_uploaded)
                        {
                        jQuery(".loader").css('display','none');
                        image_error=0;total_image_uploaded=0;
                        jQuery('#image_error_div').hide();
                        //jQuery.fancybox.close();
                        }
                       },2000);
                    }
        })
        .bind('fileuploadprogressall', function (e, data) {
            var progress = parseInt(data.loaded / data.total * 100, 10);
            jQuery('#progress_fancy .bar').css(
                'width',
                progress + '%'
            );
            //if(progress=='100')
            fileupload_counter = progress;
        });

     function loaduploadpreview(id)
    {
        var sSaveUrl = '<?php echo $this->baseUrl();?>' + 'activity/ajax/uploadpreview/shareuploads/<?php echo $this->shareupload; ?>/feeduploads/<?php echo $this->feeduploads; ?>'+"/t/"+new Date().getTime();;
        var oRpost = new Object();
        jQuery.ajax({
                url:sSaveUrl,
                type: "POST",
                data:oRpost,
                success:function(data) {
                  jQuery("#"+id).html(data);
                  if(fileupload_counter==100){
                  //jQuery.fancybox.close();
              }
                }
             });
    }

    function updateuploadoption()
    {

        var sSaveUrl = '<?php echo $this->baseUrl();?>' + 'activity/ajax/uploadstat/shareuploads/<?php echo $this->shareupload; ?>/feeduploads/<?php echo $this->feeduploads; ?>'+"/t/"+new Date().getTime();
        var oRpost = new Object();
        jQuery.ajax({
                url:sSaveUrl,
                async:false,
                type: "GET",
                data:oRpost,
                success:function(data) {


                    var prty_image_div_count=jQuery('.prty_image').length;
                    var image_div_count=+data + +prty_image_div_count;

                    if(image_div_count==12)
                    {
                        jQuery('#shareupload').css('display','none');
                    }
                currentuploaded = parseInt(data);
                  if(data == allowedfiles){
                    jQuery('#shareupload .input_type_file').css('display','none');

                  } else if(data==0){
                    jQuery('#progressbar').hide();
                    jQuery('#progressbar .bar').css(
                        'width',
                        '0%'
                    );
                  } else {
                    if(jQuery('#shareupload').hasClass('disabled')){
                        jQuery('#progressbar').show();
                        jQuery('#shareupload').removeClass('disabled');
                        jQuery('#shareupload').show();
                    }
                  }
                }
             });
    }

    jQuery(".upload_pic_video").on('click','#upload-preview .delete-share-image',
         function(){
            var sSaveUrl = '<?php echo $this->baseUrl();?>' + 'activity/ajax/removeshareupload/shareuploads/<?php echo $this->shareupload; ?>/feeduploads/<?php echo $this->feeduploads; ?>'+"/t/"+new Date().getTime();
            var oRpost = new Object();
            oRpost.imageid = jQuery(this).data('imageid');
            jQuery.ajax({
                    async:false,
                    url:sSaveUrl,
                    type: "POST",
                    data:oRpost,
                    success:function(data) {
                        jQuery('#shareupload .input_type_file').css('display','block');
                        jQuery('#shareupload').css('display','block');

                        jQuery("#upload-preview").html(data);
                        //jQuery('.tag').hide();
                        if((jQuery('.post-upload-box').html())==''){jQuery('.tag').hide();}
                        if(!jQuery('#share-main-image').html())
                        jQuery('.add-tag-box').hide();
                        updateuploadoption();
                    }
                 });
        }).bind('fileuploadchange', function (e , data) {
        image_error = 0;
        total_image_uploaded = data.files.length;
        })
jQuery('body').on('click', '.delete-prty_image', function(event){
    var image_id = jQuery(this).attr('data-image');
    var imageids =image_id +','+ jQuery('.input_image_ids').val();
    jQuery('.input_image_ids').val(imageids);
    jQuery('.prty_image_'+image_id).remove();
    jQuery('#shareupload').css('display','block');

    jQuery('#existing_image_count').val(jQuery('.prty_image').length);
             })

var video_error=0; var total_video_uploaded = 0;
    jQuery('#shareuploadvideo').fileupload({
            dataType: 'json',
            autoUpload : true,
            sequentialUploads:true,
         
            acceptFileTypes:'/(.|\/)(flv|mp4|webm)$/i',
            url: '<?php echo $this->baseUrl();?>'+'/video/index/jqueryupload-video/shareuploads/<?php echo $this->shareupload; ?>/feeduploads/<?php echo $this->feeduploads; ?>'+"/t/"+new Date().getTime(),
            uploadTemplateId: '',
            dropZone: jQuery('.upload_pic_video'),
            downloadTemplateId: '',
            crossDomain: true,
            add: function(e, data) {
                    jQuery("#video-upload-preview").css('visibility','visible');
                    jQuery("#video-upload-preview").css('display','block');
                    jQuery(".linkbox-close").css('display','none');
                    jQuery(".loader").css('display','block');
                    jQuery('#upload-preview').addClass('next-button-posting');
                    var uploadErrors = [];
                    var acceptFileTypes =/(.|\/)(flv|mp4|webm)$/i;
                    if(data.originalFiles[0]['type'].length && !acceptFileTypes.test(data.originalFiles[0]['type'])) {

                        uploadErrors.push('Choose mp4,flv and webm type of videos');
                        jQuery(".loader").css('display','none');
                        jQuery('#video-upload-preview').removeClass('next-button-posting');
                        jQuery('#shareupload .upload_file').css('display','block');
                        jQuery('#shareuploadvideo .upload_file').css('display','block');
                    }
                    if(data.originalFiles[0]['size'] > 100000000) {
                        uploadErrors.push('Filesize is too big max 100MB');
                    }
                    if(uploadErrors.length > 0) {
                        //alert(uploadErrors.join("\n"));
                        jQuery('#video-upload-preview').html('<p style="color:red;">'+uploadErrors+'</p>');
                    } else {
                        data.submit();
                    }
           },
           }).bind('fileuploaddone', function (e, data) {
                jQuery("#video-upload-preview").css('visibility','visible');
                jQuery("#video-upload-preview").css('display','block');
                 jQuery(".loader").css('display','none');
                jQuery('#upload-preview').addClass('next-button-posting');
                jQuery('#upload-preview-event').css('float','left');
                loaduploadpreviewvideo('video-upload-preview');
                updateuploadoption();

           }).bind('fileuploadadd', function (e, data) {
                jQuery("#video-upload-preview").css('visibility','visible');
                jQuery("#video-upload-preview").css('display','block');
                jQuery('#upload-preview').addClass('next-button-posting');
                fileupload_counter_video = 0;
           }).bind('fileuploadadded', function (e, data) {
                        var fileType = data.files[0].name.split('.').pop(), allowdtypes = 'mov,avi,flv,mp4,wmv,mpeg';
                        if (allowdtypes.indexOf(fileType.toLowerCase()) < 0) {
                            var str = jQuery('#video-upload-preview').html();
                            jQuery('#video-upload-preview').html('<p>Invalid format '+data.files[0].name+'</p>');
                            video_error++;
                            setTimeout(function(){
                            jQuery('#video-upload-preview').html(str);
                            if(video_error==total_video_uploaded)
                            {
                            video_error=0;total_video_uploaded=0;
                            }
                            },2000);
                            jQuery('#shareupload .upload_file').css('display','block');
                            jQuery('#shareuploadvideo .upload_file').css('display','block');
                        }else{
                            jQuery("#video-upload-preview").css('visibility','visible');
                            jQuery("#video-upload-preview").css('display','block');
                            jQuery('#video-upload-preview').addClass('next-button-posting');
                        }
           }).bind('fileuploadchange', function (e , data) {

                        jQuery("#video-upload-preview").css('visibility','visible');
                        jQuery("#video-upload-preview").css('display','block');
                        jQuery('#video-upload-preview').addClass('next-button-posting');

            video_error = 0;
            total_video_uploaded = data.files.length;
           }).bind('fileuploadprogressall', function (e, data) {

                        jQuery("#video-upload-preview").css('visibility','visible');
                        jQuery("#video-upload-preview").css('display','block');
                        jQuery('#video-upload-preview').addClass('next-button-posting');
                var progress = parseInt(data.loaded / data.total * 100, 10);
                //if(progress=='100')
                fileupload_counter_video=progress;
            });

    function loaduploadpreviewvideo(id)
    {
     var sSaveUrl = '<?php echo $this->baseUrl();?>'+'/video/index/uploadpreview/shareuploads/<?php echo $this->shareupload; ?>/feeduploads/<?php echo $this->feeduploads; ?>'+"/t/"+new Date().getTime();
         var oRpost = new Object();
        jQuery.ajax({
                url:sSaveUrl,
                type: "POST",
                data:oRpost,
                success:function(data) {
                  jQuery("#"+id).html(data);
                  jQuery('#upload-preview').removeClass('next-button-posting');
                  if(fileupload_counter_video==100)
                  {
                  video_error=0;total_video_uploaded=0;
                  }
                }
             });
    }

        jQuery(".upload_pic_video").on('click','#video-upload-preview .delete-share-video',
         function(){
            var sSaveUrl = '<?php echo $this->baseUrl();?>' + 'activity/ajax/removeshareuploadvideo/shareuploads/<?php echo $this->shareupload; ?>/feeduploads/<?php echo $this->feeduploads; ?>'+"/t/"+new Date().getTime();
            var oRpost = new Object();
            oRpost.videoid = jQuery(this).data('videoid');
            oRpost.imagepath = jQuery(this).data('imagepath');
            jQuery.ajax({
                    async:false,
                    url:sSaveUrl,
                    type: "POST",
                    data:oRpost,
                    success:function(data) {
                        jQuery("#video-upload-preview").html(data);
                    }
                 });
        }).bind('fileuploadchange', function (e , data) {
        image_error = 0;
        total_image_uploaded = data.files.length;
        })

        jQuery('body').on('click', '.delete-share-videos', function(event){

            var file_id = jQuery(this).attr('data-file');
            if(jQuery('.input_file_ids').val() != '')
            {
                var fileids =jQuery('.input_file_ids').val()+','+file_id;
            }
            else
            {
                var fileids = file_id;
            }
            jQuery('.input_file_ids').val(fileids);
            jQuery('.video_'+file_id).hide();
            jQuery('#videoElement_'+file_id).hide();

            var video_id = jQuery(this).attr('data-video');
            if(jQuery('.input_video_ids').val() != '')
            {
                var videoids =jQuery('.input_video_ids').val()+','+video_id;
            }
            else
            {
                var videoids = video_id;
            }

            jQuery('.input_video_ids').val(videoids);

        });



    jQuery( "#pac-input1" ).keypress(function() {

     jQuery('#street_number').val('');
     jQuery('#route').val('');
     jQuery('#locality').val('');
     jQuery('#administrative_area_level_1').val('');
     jQuery('#administrative_area_level_1').val('');
     jQuery('#postal_code').val('');
     jQuery('#country').val('');
     jQuery('#latitude').val('');
     jQuery('#longitude').val('');
});

 jQuery( "#LandlordState" ).change(function() {

  var url = '<?php echo $this->baseUrl(); ?>' + '/user/index/getcitywithstateabbreviations';
  var state_abbr    =   jQuery('#LandlordState').val();
    jQuery('#LandlordCity').html('');
          jQuery.ajax({
                     url:  url,
                    data: "state_abbr="+state_abbr,
                    dataType: 'json',
                    type: 'POST',
                 success: function (data) { console.log(data);
                    jQuery('#LandlordCity').append('<option value="">Select</option>');
                    jQuery.each(data, function (i, item) {
                    jQuery('#LandlordCity').append(jQuery('<option>', {
                        value: item.city,
                        text : item.city
                    }));
                });},
                   error: function(e){   }
                });
});
jQuery('#successModal .close').on('click',function(){
 var property_id =  '<?php echo $this->propertyData->id?>';
 var host    =   window.location.host;
 var url =   '<?php echo $this->baseUrl()?>' + '/property/'+property_id;
 location.href= url;
});
</script>
