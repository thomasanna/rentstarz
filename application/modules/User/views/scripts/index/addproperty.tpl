
<script src="/application/modules/User/externals/scripts/message_notififaction.js"></script>
<script src='//cdn.tinymce.com/4/tinymce.min.js'></script>
<?php $viewer= Engine_Api::_()->user()->getViewer();
$is_bg_verified=$viewer->bg_verified;
$viewHelperObj  = $this->getHelper('SmartmoveApi');
$StateArray     = $viewHelperObj->getState();
$displayname  = $viewer->displayname;
$displaynameArray =explode(' ',$displayname);

$userHelperObj  = $this->getHelper('User');
$memberPackage  = $userHelperObj->getmemberpackage($viewer->getIdentity());
$package_type   = $memberPackage ->package_type;
$propertyCount  = $userHelperObj->getpropertycount($viewer->getIdentity());

$settings = Engine_Api::_()->getApi('settings', 'core');
$user_premiumLevelProvision       = $settings->user_premiumLevelProvision;  
$user_basicPropertyLimit          = $settings->user_basicPropertyLimit;  
$user_landlordProPropertyLimit    = $settings->user_landlordProPropertyLimit;  
?>

            <input type="hidden" id="shareuploads" value="<?php echo $this->shareupload; ?>" />
            <input type="hidden" id="feeduploads" value="<?php echo $this->feeduploads; ?>" />
            <input type="hidden" placeholder="" name="main-image" id="main-image" value="0">
            <input type="hidden" placeholder="" name="upload_image_stat" id="upload_image_stat" value="">



<div class="generic_layout_container layout_middle">

    <article class="padding_top_bottom20">
        <div class="maincontentdiv">

        <div class="generic_layout_container layout_core_container_tabs">
        <div class="tabs_alt tabs_parent">
           <ul id="main_tabs">
                <li><a id="property_details" href="javascript:void(0);" class="active">PROPERTY DETAILS</a></li>
            </ul>
        </div>
        </div>

            <article class="content_main_left">
                <div class="padding_bottom20" style="position: relative;">

                  <div class="message" style='color:red;padding-bottom: 12px;'>All fields are mandatory</div>
                  <div></div>
                    <form id="property_entry_form" enctype="multipart/form-data">


                        <div class="property_details_div">
							
							<div class="input_fields_area">
                            <div class="pro_field_wrapper">
							<!--	<span class="prty_lablel pro_label">Property Name <span style="color:red;font-weight: bolder;">*</span></span> -->   
                            <input name="property_name" type="text" maxlength="65" placeholder="Property Name" id="property_name" class="prty_field input-box" autofocus><span style="color:red;font-weight: bolder;">*</span></span> 
                            </div><br>


                            <div class="pro_field_wrapper">
								<!--<div class="prty_lablel pro_label">Type of rental<span style="color:red;font-weight: bolder;">*</span></div> -->
								 <select name="rental_type" id="rental_type"  class="prty_field input-box">
                                             <option value="">Select rental type</option>
                                             <option value="Rent">Rental</option>
                                             <option value="Lease">Lease</option>

                                             </select>
                                             <span style="color:red;font-weight: bolder;">*</span> </div>  <br>


                            <div class="pro_field_wrapper">
								<!--<div class="prty_lablel pro_label">Type of housing<span style="color:red;font-weight: bolder;">*</span></div> -->
								 <select name="housing_type" id="housing_type"  class="prty_field input-box">
                                             <option value="">Select housing type</option>
                                             <option value="Apartment">Apartment</option>
                                             <option value="Room">Room</option>
                                             <option value="House">House</option>
                                             <option value="Villa">Villa</option>
                                        <!--<option value="Bedroom">Bedroom</option>-->

                                             </select>
                                             <span style="color:red;font-weight: bolder;">*</span></div>   <br>

                             <div class="num_rooms" style="display:none;">
								 <div class="pro_field_wrapper">
							     <!--<div class="prty_lablel pro_label">Number of bedrooms<span style="color:red;font-weight: bolder;">*</span></div> -->
								  <select name="add_property_number_of_rooms" id="add_property_number_of_rooms"  class="prty_field input-box">
                                             <option value="">Number of bedrooms</option>
                                             <option value="1">1</option>
                                             <option value="2">2</option>
                                             <option value="3">3</option>
                                             <option value="4">4</option>
                                             <option value="4+">4+</option>

                                             </select>
                                             <span style="color:red;font-weight: bolder;">*</span>
                                  </div> <br/> </div>


                            <div class="pro_field_wrapper">
                            <!--<div class="prty_lablel pro_label">Rental prices (monthly)<span style="color:red;font-weight: bolder;">*</span></div>-->
                            <div class="price_valid">
								<span><input name="add_property_price" type="text" maxlength="65" placeholder="Rental prices (monthly)" id="add_property_price"  class="prty_field input-box"></span>
								<span style="color:red;font-weight: bolder;">*</span>
								</div>
                            </div>
                            <br>
                           <?php /*  <div class="pro_field_wrapper">
                                 <!--<div class="prty_lablel pro_label">Do you accept vouchers?<span style="color:red;font-weight: bolder;">*</span></div> -->
                                  <select name="accept_vouchers" id="accept_vouchers"  class="prty_field input-box">
                                             <option value="">Do you accept vouchers?</option>
                                             <option value="Yes">Yes</option>
                                             <option value="No">No</option>
                                  </select>
                             <span style="color:red;font-weight: bolder;">*</span>
                           </div>   <br> */ ?>
                             <div class="pro_field_wrapper">
                                <!-- <div class="prty_lablel pro_label">Is this property wheel chair accessible?<span style="color:red;font-weight: bolder;">*</span></div> --> 
                                 <select name="wheel_chair_accessible" id="wheel_chair_accessible"  class="prty_field input-box">
                                             <option value="">Is this property wheel chair accessible?</option>
                                             <option value="Yes">Yes</option>
                                             <option value="No">No</option>
                             </select>
                             <span style="color:red;font-weight: bolder;">*</span>
                             </div>   <br>

                             <div class="pro_field_wrapper">
                                 <!--<div class="prty_lablel pro_label">How many months deposits required?<span style="color:red;font-weight: bolder;">*</span></div>-->  
                                 <select name="months_of_deposits" id="months_of_deposits"  class="prty_field input-box">
                                             <option value="">How many months deposits required?</option>
                                             <option value="1">1</option>
                                             <option value="2">2</option>
                             </select>
                             <span style="color:red;font-weight: bolder;">*</span>
                             </div>   <br>
                            <div class="pro_field_wrapper">
                                 <!--<div class="prty_lablel pro_label">Does this property have a property manager?<span style="color:red;font-weight: bolder;">*</span></div> -->
                                  <select name="have_property_manager" id="have_property_manager"  class="prty_field input-box">
                                             <option value="">Does this property have a property manager?</option>
                                             <option value="Yes">Yes</option>
                                             <option value="No">No</option>
                             </select>
                             <span style="color:red;font-weight: bolder;">*</span>
                             </div>   <br>

                             <div class="pro_field_wrapper">
                             <!--<div class="prty_lablel pro_label">Does this property provide onsite or off site parking?<span style="color:red;font-weight: bolder;">*</span></div>  -->
                             <select name="parking" id="parking"  class="prty_field input-box">
                                             <option value="">Does this unit provide parking?</option>
                                             <option value="Yes">Yes</option>
                                             <option value="No">No</option>
                             </select>
                             <span style="color:red;font-weight: bolder;">*</span>
                             </div>   <br>


                            <div class="pro_field_wrapper">
							<!--<div class="prty_lablel pro_label">Pets Allowed<span style="color:red;font-weight: bolder;">*</span></div>-->
                            <select name="allowed_pets" id="allowed_pets"  class="prty_field input-box" onchange="petsType()">
                                             <option value="">Pets Allowed</option>
                                             <option value="Yes">Yes</option>
                                             <option value="No">No</option>

                             </select>
                             <span style="color:red;font-weight: bolder;">*</span>
                             </div>   <br>


                            <div class="pets_type_wrapper" style="display:none">
                             <div class="pro_field_wrapper">
							<!--<div class="prty_lablel pro_label">What kind of pets ?<span style="color:red;font-weight: bolder;">*</span></div> -->
                             <select name="pets_type" id="property_add_pets_type"  class="prty_field input-box">
                                             <option value="">What kind of pets ?</option>
                                             <option value="Cats">Cats</option>
                                             <option value="Dogs">Dogs</option>
                                             <option value="Cats & Dogs">Cats & Dogs</option>
                                             <option value="Birds">Birds</option>
                                             <option value="Small pets">Small pets</option>

                             </select>
                             <span style="color:red;font-weight: bolder;">*</span>
                             </div>   <br></div>
                             
                             </div>

                             <div class="map_area">
                               <div id="map"></div>
                              
                           <div class="map_fields pro_field_wrapper">
								<input type= "hidden" placeholder="Street_number" class="field" id="street_number"></input>
								<input  type= "hidden" class="field" id="route"></input>
								<input type= "hidden" placeholder="Neighborhood" class="field input-box" id="neighborhood" readonly></input>
								<input type= "hidden" placeholder="City" class="field input-box input-box" id="locality" ></input>
								<input type= "hidden" placeholder="Sublocality county" class="field" id="sublocality_level_1"></input>
								<input type= "hidden" placeholder="State" class="field input-box" id="administrative_area_level_1" ></input>                          
								<input type= "hidden" placeholder="Country" class="field input-box" id="country" ></input>
								
								<input type= "hidden" class="field" id="latitude"></input>
								<input type= "hidden" class="field" id="longitude"></input>
                          </div>
                          <div class="pro_field_wrapper">
                                <input id="pac-input1" class="controls1 prty_field input-box property_pacInput" type="text" style="font-weight:bold;" placeholder="Location" style="width: 252px !important;" >
                                 <span style="color:red;font-weight: bolder;">*</span> 
                            </div>
                          <br>
                          <div class="pro_field_wrapper">
							  <input type= "text" placeholder="Zipcode" class="field property_zipcode  prty_field input-box" id="postal_code" ></input>
							  <span style="color:red;font-weight: bolder;">*</span>
                          </div> 
                          <br>
                           </div>  
                             <div class="prty_lablel pro_label des">Describe your rental <span style="color:red;font-weight: bolder;">*</span></div>
                            <div class="dis"><div class="dis_textarea_span"><textarea name="description" cols="5" rows="8" id="description"  class="prty_field tinyMCE input-box" ></textarea></div></div>
                    </form>

                   <div class="upload_pic_video">
                   <div class="pro_field_wrapper">
                   <div class="name_ifo_hours_holder_right" style="float:left;width:240px;">
                   <form id="shareupload" action="<?php echo $this->baseurl('activity/ajax/shareupload/'); ?>" method="POST" enctype="multipart/form-data">
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

                    <div style="float:left;margin-top:10px;"><div class="post-upload-box" id="upload-preview" style="float:left;width:300px;"> </div></div>

                   </div>

                   <div class="pro_field_wrapper" style="clear: both">
                   <div class="name_ifo_hours_holder_right" style="width: 240px; float: left;">
                    <form id="shareuploadvideo" action="<?php echo $this->baseurl('videos/index/uploadideo/'); ?>" method="POST" enctype="multipart/form-data">
                        <div class="input_type_file">
                            <div class="margin_top20">
                                <label class="upload_file"><span>Upload Video</span>
                                    <input name="" type="file">
                                </label>
                            </div>
                        </div>
                    </form>
                    </div>
                    <div style="width: 200px; float: left;">
                    <div class="post-upload-box" id="video-upload-preview" style="float:left;width:300px;margin-bottom: 28px;"> </div>
                    </div><div class="clear"></div>

                </div>
                </div>

                </div>
                    
                    <div class="padding_top_bottom submit_btn " >

                    <input class="but_submit property_btn" type="button" value="Submit" name="">

                    </div>

                     <div class="loader" style="display:none;"></div>
                    </form>
                   </div>
                  </article>

        </div>
        <div class="clear"></div>

    </article>



</div>
 <div id="stantard-dialogBox" style="font-size:30px"></div>
<script type="text/javascript">

var latitude  = 40.712784;
var longitude = -74.005941;
var viewer_identity ='<?php echo $viewer->getIdentity(); ?>';


</script>



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
        jQuery('.dis_textarea_span').append('<div class="des_length">'+des_length+' / 10000 characters</div>');

        });

        editor.on('init', function()
        {
        });
    }

  });

var allowedfiles=12;
var handleClick= 'ontouchstart' in document.documentElement ? 'touchstart': 'click';

jQuery( document ).ready(function() {
    jQuery("#property_name").focus();
    initAutocomplete();
});

function clearentry(){

    jQuery("#property_name").val('');
    jQuery("#country").val('');
    jQuery("#state").val('');
    jQuery("#city").val('');
    jQuery("#rental_type").val('');
    jQuery("#add_property_price").val('');

  //  jQuery("#accept_vouchers").val('');
    jQuery("#wheel_chair_accessible").val('');
    jQuery("#months_of_deposits").val('');
    jQuery("#have_property_manager").val('');
    jQuery("#parking").val('');

    jQuery("#description").val('');
    jQuery("#add_property_number_of_rooms").val('');
    jQuery("#housing_type").val('');
    jQuery("#allowed_pets").val('');
    jQuery("#property_add_pets_type").val('');
    jQuery("#pac-input1").val('');
    //jQuery("#zipcode").val('');
    jQuery("#upload-preview").empty();
    jQuery("#video-upload-preview").empty();
    jQuery(".message").text("");


}

var image_error=0; var total_image_uploaded = 0;
         jQuery('#shareupload').fileupload({

            autoUpload : true,
            uploadTemplateId: null,
            downloadTemplateId: null,
            sequentialUploads:true,
            dropZone: jQuery('.share-text-field'),
            acceptFileTypes:'/(\.|\/)(gif|jpe?g|png)$/i',
            url: '<?php echo $this->baseUrl();?>' +'/activity/ajax/shareupload/shareuploads/<?php echo $this->shareupload; ?>/feeduploads/<?php echo $this->feeduploads; ?>'+"/t/"+new Date().getTime()
        }).bind('fileuploaddone', function (e, data) {
            jQuery(".loader").css('display','none');
            jQuery(".but_submit").prop("disabled", false);
            loaduploadpreview('upload-preview');
            jQuery('#shareupload').addClass('one_uploaded');
            updateuploadoption();
        }).bind('fileuploadadd', function (e, data) {
             jQuery(".loader").css('display','block');
             jQuery(".but_submit").prop("disabled", true);
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
                        jQuery("#image_error_div").css('display','block');
                       // jQuery('#image_error_div').html('<p>Invalid format '+data.files[0].name+'</p>');
                        jQuery('#image_error_div').html('<p>Not an accepted file type</p>');
                        image_error++;
                        setTimeout(function(){
                        //jQuery('#progress_fancy').html(str);
                        if(image_error==total_image_uploaded)
                        {
                        image_error=0;total_image_uploaded=0;
                        jQuery(".loader").css('display','none');
                        jQuery("#image_error_div").css('display','none');
                        jQuery(".but_submit").prop("disabled", false);
                       
                        }
                
                       },5000);
                    }
        })
        .bind('fileuploadprogressall', function (e, data) {
            var progress = parseInt(data.loaded / data.total * 100, 10);
            jQuery('#progress_fancy .bar').css(
                'width',
                progress + '%'
            );
            fileupload_counter = progress;
        });

     function loaduploadpreview(id)
    {
        var sSaveUrl ='<?php echo $this->baseUrl();?>' + '/activity/ajax/uploadpreview/shareuploads/<?php echo $this->shareupload; ?>/feeduploads/<?php echo $this->feeduploads; ?>'+"/t/"+new Date().getTime();;
        var oRpost = new Object();
        jQuery.ajax({
                url:sSaveUrl,
                type: "POST",
                data:oRpost,
                success:function(data) {
                  jQuery("#"+id).html(data);
                  if(fileupload_counter==100){
              }
                }
             });
    }

    function updateuploadoption()
    {
        var sSaveUrl = '<?php echo $this->baseUrl();?>' + '/activity/ajax/uploadstat/shareuploads/<?php echo $this->shareupload; ?>/feeduploads/<?php echo $this->feeduploads; ?>'+"/t/"+new Date().getTime();
        var oRpost = new Object();
        jQuery.ajax({
                url:sSaveUrl,
                async:false,
                type: "GET",
                data:oRpost,
                success:function(data) {

                currentuploaded = parseInt(data); console.log(data);
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
            var sSaveUrl = '<?php echo $this->baseUrl();?>' + '/activity/ajax/removeshareupload/shareuploads/<?php echo $this->shareupload; ?>/feeduploads/<?php echo $this->feeduploads; ?>'+"/t/"+new Date().getTime();
            var oRpost = new Object();
            oRpost.imageid = jQuery(this).data('imageid');
            jQuery.ajax({
                    async:false,
                    url:sSaveUrl,
                    type: "POST",
                    data:oRpost,
                    success:function(data) {
                        jQuery('#shareupload .input_type_file').css('display','block');

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
                    jQuery(".but_submit").prop("disabled", true);
                    jQuery(".linkbox-close").css('display','none');
                    jQuery('#upload-preview').addClass('next-button-posting');
                    jQuery(".loader").css('display','block');
                    var uploadErrors = [];
                  
                    var acceptFileTypes =/(.|\/)(flv|mp4|webm)$/i;

                    if(data.originalFiles[0]['type'].length && !acceptFileTypes.test(data.originalFiles[0]['type'])) {
                        console.log(acceptFileTypes);
                        jQuery(".loader").css('display','none');                 
                        uploadErrors.push('Choose mp4,flv and webm type of videos');
                        jQuery('#video-upload-preview').removeClass('next-button-posting');
                        jQuery(".but_submit").prop("disabled", false);
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
               jQuery(".but_submit").prop("disabled", false);
                jQuery(".loader").css('display','none');
                jQuery("#video-upload-preview").css('visibility','visible');
                jQuery("#video-upload-preview").css('display','block');
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
                            jQuery(".but_submit").prop("disabled", false);
                            jQuery(".loader").css('display','none');
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
                  jQuery.fancybox.close();
                  }
                }
             });
    }

        jQuery(".upload_pic_video").on('click','#video-upload-preview .delete-share-video',
         function(){
            var sSaveUrl = '<?php echo $this->baseUrl();?>' + '/activity/ajax/removeshareuploadvideo/shareuploads/<?php echo $this->shareupload; ?>/feeduploads/<?php echo $this->feeduploads; ?>'+"/t/"+new Date().getTime();
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
function clearentry(){
	
	jQuery("#property_name").val('');
	jQuery("#rental_type").val('');
	jQuery("#add_property_price").val('');
	jQuery("#description").val('');
	jQuery("#add_property_number_of_rooms").val('');
	jQuery("#housing_type").val('');
	jQuery("#allowed_pets").val('');
	jQuery("#property_add_pets_type").val('');
	jQuery("#country").val('');
	jQuery("#administrative_area_level_1").val('');
	jQuery("#locality").val('');
	jQuery("#sublocality_level_1").val('');
	jQuery("#neighborhood").val('');
	jQuery("#street_number").val('');
	jQuery(".property_zipcode").val('');
	jQuery("#latitude").val('');
	jQuery("#longitude").val('');
	jQuery("#wheel_chair_accessible").val('');
	jQuery("#months_of_deposits").val('');
	jQuery("#have_property_manager").val('');
	jQuery("#parking").val('');
}

jQuery('.but_submit').on(handleClick,function(){
	
	var package_type  = '<?php echo $package_type; ?>'
	var propertylistsCount  = '<?php echo $propertyCount;?>';
	var user_premiumLevelProvision        = '<?php echo $user_premiumLevelProvision;?>';
	var user_basicPropertyLimit           = '<?php echo $user_basicPropertyLimit;?>';
	var user_landlordProPropertyLimit     = '<?php echo $user_landlordProPropertyLimit;?>';
	var have_permission = true;
    
    if(user_premiumLevelProvision == 2){
		if(propertylistsCount >= parseInt(user_basicPropertyLimit) && package_type == ''){
			have_permission  = false;
		}
		if(propertylistsCount >= parseInt(user_landlordProPropertyLimit) && package_type == 'landlord_pro_package'){
			have_permission  = false;
		}		
	}
	if(have_permission ==  false){
		 jQuery("#successModal .success_message").html('');
         jQuery("#successModal .success_message").html('Please upgrade your package to add more property <a href="/support?page=upgradePackage">Upgrade Package</a>');
         jQuery("#successModal").modal('show');
	}
	
	else {
	
     var count_image=jQuery('#share-main-image').length;

          if(count_image==1)
          {
    jQuery("#image_error_div").css('display','none');
          }
    var userid = '<?php echo Engine_Api::_()->user()->getViewer()->getIdentity(); ?>';
    var bg_verfied='<?php echo $is_bg_verified ; ?>';
    var error     =  false;
    var oData       = new Object();
    var property_name   = oData.property_name =jQuery.trim(jQuery("#property_name").val());
    var rental_type     = oData.rental_type =jQuery.trim(jQuery("#rental_type").val());
    var price     = oData.price =jQuery.trim(jQuery("#add_property_price").val());
    var description     = oData.description = tinymce.get('description').getContent();
    var des    =  tinymce.get('description').getContent({format: 'text'}).replace(/^\s+/g, '');
    var number_of_rooms     = oData.number_of_rooms =jQuery.trim(jQuery("#add_property_number_of_rooms").val());
    var housing_type     = oData.housing_type =jQuery.trim(jQuery("#housing_type").val());
    var allowed_pets     = oData.allowed_pets = jQuery.trim(jQuery("#allowed_pets").val());
    var pets_type     = oData.pets_type =jQuery.trim(jQuery("#property_add_pets_type").val());
    var prty_country  = oData.prty_country =jQuery.trim(jQuery("#country").val());
    var prty_state    = oData.prty_state =jQuery.trim(jQuery("#administrative_area_level_1").val());
    var prty_city     = oData.prty_city =jQuery.trim(jQuery("#locality").val());
    if(prty_city == ''){
         var prty_city     = oData.prty_city =jQuery.trim(jQuery("#sublocality_level_1").val());
    }
    var prty_county     =  oData.prty_county =jQuery.trim(jQuery("#sublocality_level_1").val());   
    var prty_neighborhood     =  oData.prty_neighborhood =jQuery.trim(jQuery("#neighborhood").val());
    var prty_street_address    = oData.prty_street_address =jQuery.trim(jQuery("#street_number").val());   
    
    var prty_zipcode    = oData.prty_zipcode =jQuery.trim(jQuery(".property_zipcode").val());  

    var prty_latitude    = oData.prty_latitude =jQuery.trim(jQuery("#latitude").val());
    var prty_longitude    = oData.prty_longitude =jQuery.trim(jQuery("#longitude").val());
    var smartmoveApiEnable              = oData.smartmoveApiEnable = '<?php echo $this->smartmoveApiEnable;  ?>';
   // var accept_vouchers                        = oData.accept_vouchers=jQuery.trim(jQuery("#accept_vouchers").val());
    var wheel_chair_accessible                 = oData.wheel_chair_accessible=jQuery.trim(jQuery("#wheel_chair_accessible").val());
    var months_of_deposits                     = oData.months_of_deposits=jQuery.trim(jQuery("#months_of_deposits").val());
    var have_property_manager                  = oData.have_property_manager=jQuery.trim(jQuery("#have_property_manager").val());
    var parking                                = oData.parking=jQuery.trim(jQuery("#parking").val());
  
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


    var file_ids    = oData.file_id = jQuery('#file_id').val();
    var upload_types    = oData.upload_type = JSON.stringify(valueOfType);
    var hasPreview = jQuery.trim(jQuery('#upload-preview').html()).length;
    var is_validated = true;   
    
    if(property_name =='' || prty_country =='' || prty_state =='' || prty_city =='' || rental_type =='' || price =='' || description =='' || 
    housing_type =='' || allowed_pets == '' || wheel_chair_accessible =='' || months_of_deposits =='' || have_property_manager ==''|| parking =='' || prty_zipcode==''){

    if(property_name =='')     { jQuery('#property_name').css('border-color','#e62828');                            }
    else                       { jQuery('#property_name').css('border-color','#b2c6cd');                            }       
    if(rental_type =='')       { jQuery('#rental_type').css('border-color','#e62828');                              }
    else                       { jQuery('#rental_type').css('border-color','#b2c6cd');                              }   
    if(housing_type =='')      { jQuery('#housing_type').css('border-color','#e62828');                             }
    else                       { jQuery('#housing_type').css('border-color','#b2c6cd');                             }  
    if(price =='')             { jQuery('#add_property_price').css('border-color','#e62828');                       }
    else                       { jQuery('#add_property_price').css('border-color','#b2c6cd');                       }  
   // if(accept_vouchers =='')   { jQuery('#accept_vouchers').css('border-color','#e62828');                          }
   // else                       { jQuery('#accept_vouchers').css('border-color','#b2c6cd');                          }  
    if(wheel_chair_accessible =='')   { jQuery('#wheel_chair_accessible').css('border-color','#e62828');            }
    else                              { jQuery('#wheel_chair_accessible').css('border-color','#b2c6cd');            }  
    if(months_of_deposits =='')       { jQuery('#months_of_deposits').css('border-color','#e62828');                }
    else                              { jQuery('#months_of_deposits').css('border-color','#b2c6cd');                }  
    if(have_property_manager =='')    { jQuery('#have_property_manager').css('border-color','#e62828');             }
    else                              { jQuery('#have_property_manager').css('border-color','#b2c6cd');             } 
    if(parking =='')                  { jQuery('#parking').css('border-color','#e62828');                           }
    else                              { jQuery('#parking').css('border-color','#b2c6cd');                           } 
    if(allowed_pets =='')             { jQuery('#allowed_pets').css('border-color','#e62828');                      }
    else                              { jQuery('#allowed_pets').css('border-color','#b2c6cd');                      } 
    if(prty_country =='')             { jQuery('.property_pacInput').css('border-color','#e62828');                           } 
    else                              { jQuery('.property_pacInput').css('border-color','#b2c6cd');                           } 
    if(prty_state =='')               { jQuery('.property_pacInput').css('border-color','#e62828');       }
    else                              { jQuery('.property_pacInput').css('border-color','#b2c6cd');       } 
    if(prty_city =='')                { jQuery('.property_pacInput').css('border-color','#e62828');                          }
    else                              { jQuery('.property_pacInput').css('border-color','#b2c6cd');                          }
    if(prty_zipcode =='')             { jQuery('.property_zipcode').css('border-color','#e62828');                  }
    else                              { jQuery('.property_zipcode').css('border-color','#b2c6cd');                  }
    if(description =='')              { jQuery('.mce-tinymce').css('border-color','#e62828');                       }  
    else                              { jQuery('.mce-tinymce').css('border-color','#b2c6cd');                       } 
 	 
 	
 	      if(housing_type =='Apartment' || housing_type =='House') {
		  if(number_of_rooms==''){
			  jQuery('#add_property_number_of_rooms').css('border-color','#e62828');
		  }else{
		  jQuery("#add_property_number_of_rooms").css('border-color','#b2c6cd');
		  }
		  }


		  if(allowed_pets=='Yes' && pets_type==''){
		  jQuery('#property_add_pets_type').css('border-color','#e62828');
		  }else{
		  jQuery("#property_add_pets_type").css('border-color','#b2c6cd');
		  }



		 jQuery('.message').html('Please fill all fields');
		 is_validated = false;
	}
	else{
	     jQuery('#wheel_chair_accessible').css('border-color','#b2c6cd');
		 jQuery('#months_of_deposits').css('border-color','#b2c6cd'); 
		 jQuery('#have_property_manager').css('border-color','#b2c6cd'); 
		 jQuery('#parking').css('border-color','#b2c6cd'); 
		 jQuery('#allowed_pets').css('border-color','#b2c6cd');  
	     jQuery("#pac-input1").css('border-color','#b2c6cd');
	     jQuery("#add_property_number_of_rooms").css('border-color','#b2c6cd');
         jQuery('.mce-tinymce').css('border-color','#b2c6cd');
         jQuery('.property_zipcode').css('border-color','#b2c6cd');   
		 is_validated = true;		
	}    
    if(is_validated ==  true){
		
		 var count_image=jQuery('#share-main-image').length;

            if(count_image==0)
            {
            jQuery('#image_error_div').html('<p>Please upload the image</p>');
            jQuery('.message').html('Please upload the image');
             is_validated = false;
             jQuery('#property_details').trigger( 'click' );
            }
            else{				
			 is_validated = true;		
			}
	}
	if(is_validated ==  true){
    var regex   =   /^[0-9]*$/;
    var price = jQuery('#add_property_price').val();    
    if( !regex.test(price) ) {
         jQuery(".price_validation").html("");
         jQuery(".price_valid").append("<div class='price_validation' style='color:red;margin-left:240px;font-weight: normal;'>Numbers Only</div>");
         jQuery('#add_property_price').css('border-color','#dd1616');
         is_validated = false;
         jQuery('#property_details').trigger( 'click' );
    }
    else{
		jQuery('#add_property_price').css('border-color','#b2c6cd');
        is_validated = true;
    }
	}
    
    if(is_validated ==  true){
	descripltion_plain_text = jQuery(description).text();
    if(descripltion_plain_text !=''){
            jQuery( ".discription_validation" ).remove();
            if(descripltion_plain_text.length < 100 || des.length < 100){
            jQuery(".dis").append("<div class='discription_validation' style='color:red;margin-left:240px;font-weight: normal;'>Description should have atleast 100 characters</div>");
            is_validated = false;
            jQuery('#property_details').trigger( 'click' );
            }
            else{
                is_validated = true;
            }
    }
		
	}
    if(is_validated ==  true){		
		if(housing_type == 'Bedroom' && number_of_rooms =='' ){	
        is_validated = false;
        jQuery('#property_details').trigger( 'click' );
        jQuery('#add_property_number_of_rooms').css('border-color','#dd1616');
        }
        else{
		jQuery('#add_property_number_of_rooms').css('border-color','#b2c6cd');	

		}		
	}
    if(is_validated ==  true){	
		if(allowed_pets == 'Yes' && pets_type =='' ){
			is_validated = false;
			jQuery('#property_details').trigger( 'click' );
			jQuery('#property_add_pets_type').css('border-color','#e62828');
		}
		else{
			jQuery('#property_add_pets_type').css('border-color','#b2c6cd');
		}
    }
     //Zip validation     
    if(is_validated ==  true){		
		if(prty_zipcode != ''){
			jQuery(".message").text('');
		    if(/([0-9]{5})+$/.test(prty_zipcode)) {
			 jQuery(".property_zipcode").css('border-color','b2c6cd');
             is_validated =true;
			}
			else {
			 jQuery(".message").text('Zipcode should have exact 5 numeric values');
			 jQuery(".property_zipcode").css('border-color','dd1616');
			 jQuery('#property_details').trigger( 'click' );
			 is_validated =false;
			}
		}
    } 
	if(is_validated == true){
	    if(prty_country =='' || prty_state =='' || prty_city ==''){
            jQuery('.message').text('Location field should have country , state and city');
            jQuery('#property_details').trigger( 'click' );
            jQuery("#pac-input1").css('border-color','dd1616');
            is_validated = false;
            }
            else{
				jQuery("#pac-input1").css('border-color','b2c6cd');
			}
	}
	if(is_validated == true){
	  if(prty_zipcode == ''){	  
		 jQuery('.message').text('Please enter zipcode');
		 jQuery('#property_details').trigger( 'click' );
		 jQuery("#postal_code").css('border-color','dd1616');
		 is_validated = false; 
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
	    if(is_validated == true){

         jQuery('.but_submit').css('display','none');
         jQuery(".loader").css("display", "block");
         if(jQuery('#shareuploads').val()&&jQuery('#feeduploads').val())
         var formURL    = '<?php echo $this->baseUrl(); ?>' + '/user/index/saveproperty/shareuploads/'+jQuery('#shareuploads').val()+'/feeduploads/'+jQuery('#feeduploads').val()+"/t/"+new Date().getTime();
         else
         var formURL    = '<?php echo $this->baseUrl(); ?>' + '/user/index/saveproperty'+"/t/"+new Date().getTime();

         jQuery.ajax( {
                        url : formURL,
                        type: "POST",
                        dataType: 'json',
                        data : oData,
                            success: function (returndata) {
                            if(returndata.status==true) {
                                jQuery(".loader").css("display", "none");
                                if(bg_verfied== 1){
							    jQuery("#successModal .success_message").text('');
                                jQuery("#successModal .success_message").text('Your property has been succesfully added');
                                jQuery("#successModal").modal('show');
                                 }
                                else{
                                jQuery("#successModal .success_message").text('');
                                jQuery("#successModal .success_message").text('Please wait for the admin approval');
                                jQuery("#successModal").modal('show');                              
                                }                                
                                clearentry();                        
                            }
                            else{
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
	 }

    });

function petsType(){

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
}

jQuery( "#housing_type" ).change(function() {

    var housing_type= jQuery("#housing_type").val();
    if(housing_type =='Room' || housing_type ==''){
		 jQuery(".num_rooms").css('display','none')
        
    }
    else{
       jQuery(".num_rooms").css('display','block');
	
    }

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
</script>


<script type="text/javascript">

jQuery('#property_details').on('click',function(){

    jQuery('#property_details').addClass('active');
    jQuery('#property_verification_details').removeClass('active');
    jQuery('#personal_details').removeClass('active');
    jQuery('.property_verification_div').css('display','none');
    jQuery('.property_details_div').css('display','block');
    jQuery('.personal_details_div').css('display','none');

});
jQuery('#property_verification_details').on('click',function(){

    jQuery('#property_verification_details').addClass('active');
    jQuery('#property_details').removeClass('active');
    jQuery('#personal_details').removeClass('active');
    jQuery('.property_verification_div').css('display','block');
    jQuery('.property_details_div').css('display','none');
    jQuery('.personal_details_div').css('display','none');
    jQuery('.loader').css('display','none');

});
jQuery('#personal_details').on('click',function(){

    jQuery('#personal_details').addClass('active');
    jQuery('#property_details').removeClass('active');
    jQuery('#property_verification_details').removeClass('active');
    jQuery('.property_verification_div').css('display','none');
    jQuery('.property_details_div').css('display','none');
    jQuery('.personal_details_div').css('display','block');
    jQuery('.loader').css('display','none');

});
jQuery('.property_details_btn').on('click',function(){
    jQuery('.loader').css('display','block');

    jQuery('#property_verification_details').trigger( 'click' );
});
jQuery('.property_verification_btn').on('click',function(){
     jQuery('.loader').css('display','block');

    jQuery('#personal_details').trigger( 'click' );
});
jQuery('#successModal .close').on('click',function(){
 clearentry();
 location.reload();
});



</script>
