<?php
$userHelperObj       =  $this->getHelper('User');
$landlodsData = $userHelperObj->getYourLandlords($this->subjectId);
?>
<div>
	
<?php if(count($landlodsData)>0):?>	
<div class="tabs_alt tabs_parent " style="display:block">
          <ul id="main_tabs">
            <li class="tab_541 tab_layout_user_profile_fields active renter_my_task_li "><a href="javascript:void(0);">Maintenance Log</a></li>
            <li class="renter_new_task_li"><a href="javascript:void(0);">New Task</a></li>
            <li class="renter_link_li"><a href="javascript:void(0);">Link</a></li>

          </ul>
</div>

<div class="renter_my_task_div">
<?php if(count($this->mytasks) > 0):?>

<div class="col-md-2 col-sm-3 col-xs-12 task_head">Task</div>
<div class="col-md-2 col-sm-3 col-xs-12 task_head">Landlord</div>
<div class="col-md-2 col-sm-3 col-xs-12 task_head">Scheduled at</div>
<div class="col-md-2 col-sm-3 col-xs-12 task_head">Status</div>
<div class="col-md-2 col-sm-3 col-xs-12 task_head">More Info</div>

<hr style="clear:both">
<?php foreach($this->mytasks as $task):?>
<div class="row renter_task_log_<?php echo $task['id']?>">
<div class="col-md-2 col-sm-3 col-xs-12"><?php echo $task['task_info']?></div>
<div class="col-md-2 col-sm-3 col-xs-12"><?php echo $task['landlord_name']?></div>
<div class="col-md-2 col-sm-3 col-xs-12 scheduled_date"><?php echo $task['scheduled_date']?></div>
<div class="col-md-2 col-sm-3 col-xs-12 task_status"><?php echo $task['status']?></div>
<div class="col-md-2 col-sm-3 col-xs-12 more_info_task" style="cursor:pointer" taskid ="<?php echo $task['id']?>" data-toggle="modal" data-target="#taskmoreinfoModal">More Info</div>
<div class="col-md-2 col-sm-3 col-xs-12 schedule_task" style="cursor:pointer" taskid ="<?php echo $task['id']?>" data-toggle="modal" data-target="#scheduletaskModal">Schedule Task</div>
</div>
<hr style="clear:both">
<?php endforeach;?>
<?php else:?>
<div>You have no created tasks yet</div>
<?php endif;?>
</div>

<div class="renter_new_task_div" style="display:none">

<div class="message"></div>	
<form method = "post" enctype="multipart/form-data" class="taskform" >	
<div id="wrapper">
    <input id="fileUpload" name ="fileUpload" type="file" />
    <br />
    <div id="image-holder"></div>
</div> 
<!--
<input name="video" type="file" accept="video/*"/> 


-->


<div>
<div class="task_head">Briefly describe the problem</div>	
<br>
<textarea class="task_info" rows="4" cols="50" name="task_info"></textarea>
</div>
<div>
<br>
<div class="pro_field_wrapper">
<div class="task_head">Select your landlord</div>
<br>
<select name="yourlandlord" class="yourlandlord prty_field input-box">
	<?php foreach($landlodsData as $data):?>
		<option value ="<?php echo $data['landlord_id']?>"><?php echo $data['landlord_name']?></option>
	<?php endforeach;?>

</select>
</div>
</div>
<div>
	<br>
<div class="task_head">Location</div>
<textarea class="task_location" rows="4" cols="50" name="task_location"></textarea>
</div>
<div class="confirm_btns" style="text-align: left;">
  <input type="submit" value="Send" class="send_task_btn" style="width: 134px;">
</div>
                  <div class="loader" style="display:none;"></div>

</form>   
</div>
<?php else:?>

<div>You have no rented any property yet</div>

<?php endif;?>




</div>


<div class="link_div" style="display:none">
	
	<div>You can invite someone to join and share task info</div>
    <div class="tabs_alt tabs_parent " style="display:block">
     <ul id="main_tabs">
	<li class="newlink_li active"><a href="javascript:void(0);">New Link</a></li>
	<li class="mylink_li"><a href="javascript:void(0);">My Links</a></li>
	</ul>
    </div>

	<div class="newlink_content">
	who do you want to link with<br><br>
	
	<div data-toggle="modal" data-target="#linkModal"><input type="radio" name="link_profile" value="landlord" >Landlord</div><br><br>
    <div data-toggle="modal" data-target="#linkModal"><input type="radio" name="link_profile" value="renter">Renter </div><br><br>
    <div data-toggle="modal" data-target="#linkModal"><input type="radio" name="link_profile" value="service_agent">Service Agent</div><br><br> 

	
	
	</div>
	<div class="mylink_content" style="display:none">
	   <div class="search_links" style="padding: 12px;">
		<select class="search_links_select">
		<option value="view_all">View All</option>
		<option value="renter">My Renters</option>
		<option value="landlord">My Landlord</option>
		<option value="service_agent">My Service Agents</option>
		</select>		
		</div>	
	<?php foreach($this->linksData as $links):?>
	<div class="<?php echo $links['link_profile']?>">
	<div class="col-md-3 col-sm-3 col-xs-12 ">
		<?php   $user   =  Engine_Api::_()->user()->getUser($links['user_id']);?>
		<?php 
         echo $this->htmlLink($user->getHref(), $this->itemPhoto($user, 'thumb.icon', array('class' => 'photo')));         
        ?>
        <div><?php echo $user->displayname;?></div>
    </div> 
    <div class="col-md-3 col-sm-3 col-xs-12 ">
     <?php if($links['link_profile'] == 'landlord') echo "Landlord";?>
     <?php if($links['link_profile'] == 'renter') echo "Renter";?>
     <?php if($links['link_profile'] == 'service_agent') echo "Service Agent";?>
    </div>
    <hr style="clear:both">
    </div>

	
	<?php endforeach;?>
	
	</div>
</div>

<script>
var handleClick= 'ontouchstart' in document.documentElement ? 'touchstart': 'click';


jQuery('.renter_my_task_li').on(handleClick, function() {

 jQuery('.renter_new_task_div').css('display','none');
 jQuery('.renter_new_task_li').removeClass('active'); 
 jQuery('.renter_my_task_div').css('display','block');
 jQuery('.renter_my_task_li').addClass('active');
 jQuery('.link_div').css('display','none');
 jQuery('.renter_link_li').removeClass('active');

 
});
jQuery('.renter_new_task_li').on(handleClick, function() {

 jQuery('.renter_new_task_div').css('display','block');
 jQuery('.renter_new_task_li').addClass('active'); 
 jQuery('.renter_my_task_div').css('display','none');
 jQuery('.renter_my_task_li').removeClass('active');
 jQuery('.link_div').css('display','none');
 jQuery('.renter_link_li').removeClass('active');

 
});
jQuery('.renter_link_li').on(handleClick, function() {

 jQuery('.renter_new_task_div').css('display','none');
 jQuery('.renter_new_task_li').removeClass('active'); 
 jQuery('.renter_my_task_div').css('display','none');
 jQuery('.renter_my_task_li').removeClass('active');
 jQuery('.link_div').css('display','block');
 jQuery('.renter_link_li').addClass('active');
 
});

jQuery('.newlink_li').on('click', function() {

 jQuery('.newlink_content').css('display','block');
 jQuery('.newlink_li').addClass('active'); 
 
 jQuery('.mylink_content').css('display','none');
 jQuery('.mylink_li').removeClass('active'); 
 
});
jQuery('.mylink_li').on('click', function() {

 jQuery('.newlink_content').css('display','none');
 jQuery('.newlink_li').removeClass('active'); 
 
 jQuery('.mylink_content').css('display','block');
 jQuery('.mylink_li').addClass('active'); 
 
});


jQuery("#fileUpload").on('change', function () {

    var imgPath = jQuery(this)[0].value;
    var extn = imgPath.substring(imgPath.lastIndexOf('.') + 1).toLowerCase();

    if (extn == "png" || extn == "jpg" || extn == "jpeg") {
        if (typeof (FileReader) != "undefined") {

            var image_holder = jQuery("#image-holder");
            image_holder.empty();

            var reader = new FileReader();
            reader.onload = function (e) {
                jQuery("<img />", {
                    "src": e.target.result,
                        "class": "thumb-image"
                }).appendTo(image_holder);

            }
            image_holder.show();
            reader.readAsDataURL(jQuery(this)[0].files[0]);
        } else {
            alert("This browser does not support FileReader.");
        }
    } else {
        alert("Pls select only images");
    }
});

jQuery(".taskform").submit(function (event) {
 event.preventDefault();
 jQuery('.send_task_btn').hide();
 jQuery('.taskform .loader').show();

 var photopath = jQuery('#fileUpload').val(); 
 var task_info = jQuery('.task_info').val(); 
 var yourlandlord = jQuery('.yourlandlord').val(); 
 var task_location = jQuery('.task_location').val(); 
 var ext = jQuery('#fileUpload').val().split('.').pop().toLowerCase();
 if(task_info !='' && photopath != '' && yourlandlord !='' && task_location !=''){

 if(ext != "jpg" && ext != "JPG" && ext != "png" && ext != "jpeg" && ext != "JPEG" &&  ext != "PNG") {
		jQuery('.renter_new_task_div .message').css('color','red');
		jQuery('.renter_new_task_div .message').html('Sorry, only JPG, JPEG, & PNG  files are allowed');
		jQuery('.send_task_btn').show();
        jQuery('taskform .loader').hide();

 }
 else{	 
 
 var url =  '<?php echo $this->baseUrl().'/user/index/saverentertask' ?>';
 jQuery.ajax({
	url: url,
	type: "POST",
	data:  new FormData(this),
	contentType: false,
	cache: false,
	processData:false,
	dataType: 'json',
	success: function(data){
		if(data.status == true){
			
			jQuery('.renter_new_task_div .message').css('color','green');
			jQuery('.renter_new_task_div .message').html('Your task has been succesfully submitted');
			jQuery('#fileUpload').val('');
			jQuery('.task_info').val('');
			jQuery('.task_location').val('');
			jQuery('#image-holder').html('');			
		 jQuery('.send_task_btn').show();
         jQuery('.taskform .loader').hide();

	     }
       
	},
		
	error: function(){} 	        
	});
	 
 }
 
}
else{
	     jQuery('.send_task_btn').hide();
         jQuery('.taskform .loader').show();

}
});

jQuery('body').on('click', '.more_info_task', function(event){
	var taskid  = jQuery(this).attr('taskid');
	var oData       = new Object();		
    oData.taskid         = taskid;
    if(taskid != ''){
	    var url          = '<?php echo $this->baseUrl().'/user/index/gettaskbyid' ?>';		
			jQuery.ajax({
				url:  url,
				data: oData,						
				dataType: 'json',
				type: 'POST',
				success: function (result) {
					//jQuery('#taskmoreinfoModal').modal('show')
					jQuery('#taskmoreinfoModal .modal-body').html(result);				
				},
				error: function(e){ }  
			   });
	    }		
	});
jQuery('body').on('click', '.schedule_task', function(event){
	var taskid  = jQuery(this).attr('taskid');
	var oData       = new Object();		
    oData.taskid         = taskid;
    if(taskid != ''){
	    var url          = '<?php echo $this->baseUrl().'/user/index/gettask' ?>';		
			jQuery.ajax({
				url:  url,
				data: oData,						
				dataType: 'json',
				type: 'POST',
				success: function (result) {
					//jQuery('#scheduletaskModal').modal('show')
					jQuery('#scheduletaskModal .schedule_date_text').val(result.scheduled_date);				
					jQuery('#scheduletaskModal .expense_text').val(result.expense);				
					jQuery('#scheduletaskModal .status_option').val(result.status);				
					jQuery('#scheduletaskModal .task_id_text').val(result.taskid);				
				},
				error: function(e){ }  
			   });
	    }		
	});
jQuery('body').on('click', '.submit_task_update', function(event){
	 jQuery('#scheduletaskModal .message').html('');	

	var scheduled_date  = jQuery('#scheduletaskModal .schedule_date_text').val();
	var expense         = jQuery('#scheduletaskModal .expense_text').val();
	var status         = jQuery('#scheduletaskModal .status_option').val();
	var taskid         = jQuery('#scheduletaskModal .task_id_text').val();
	var oData       = new Object();		
    oData.taskid         = taskid;
    oData.scheduled_date         = scheduled_date;
    oData.expense         = expense;
    oData.status         = status;
    if(taskid != ''){
	    var url          = '<?php echo $this->baseUrl().'/user/index/updatetask' ?>';		
			jQuery.ajax({
				url:  url,
				data: oData,						
				dataType: 'json',
				type: 'POST',
				success: function (result) {
				 jQuery('#scheduletaskModal .message').html('You have successfully updated your task');	
                 jQuery('.renter_task_log_'+taskid + ' .scheduled_date').html(scheduled_date);
                 jQuery('.renter_task_log_'+taskid + ' .task_status').html(status);
			},
				error: function(e){ }  
			   });
	    }		
	});

jQuery('body').on('click', '.submit_link', function(event){
	jQuery('#linkModal .message').html('');
	jQuery('#linkModal .submit_link').css('display','none');
	jQuery('#linkModal .loader').css('display','block');
	var link_name  =    jQuery('#linkModal .link_name').val();
	var link_address  = jQuery('#linkModal .link_address').val();
	var link_message  = jQuery('#linkModal .link_message').val();
	var link_profile           = jQuery("input[name='link_profile']:checked").val();
    var oData       = new Object();		
    oData.link_name            = link_name;
    oData.link_address         = link_address;
    oData.link_message         = link_message;
    oData.link_profile         = link_profile;

    
    if(link_name != '' && link_address != '' && link_message !='' && link_profile !=''){
	    var url          = '<?php echo $this->baseUrl().'/user/index/savelink' ?>';		
			jQuery.ajax({
				url:  url,
				data: oData,						
				dataType: 'json',
				type: 'POST',
				success: function (result) {
                        jQuery('#linkModal .link_name').val('');
                        jQuery('#linkModal .link_address').val('');
                        jQuery('#linkModal .link_message').val('');
                        jQuery('#linkModal .message').css('color','green');
                        jQuery('#linkModal .message').html('Your link has been succesfully sent');
                        jQuery('#linkModal .submit_link').css('display','block');
                	    jQuery('#linkModal .loader').css('display','none');

			},
				error: function(e){ 
					jQuery('#linkModal .submit_link').css('display','block');
                	jQuery('#linkModal .loader').css('display','none');
	}  
			   });
	    }
	    else{
			jQuery('#linkModal .submit_link').css('display','block');
          	jQuery('#linkModal .loader').css('display','none');	
		}
    
});
jQuery( ".search_links_select" ).change(function() {
	
  var val = jQuery('.search_links_select').val();
  if(val == 'renter'){
	    jQuery('.mylink_content .landlord').css('display','none');
	    jQuery('.mylink_content .service_agent').css('display','none');
	    jQuery('.mylink_content .renter').css('display','block');

  }
  if(val == 'landlord'){
	    jQuery('.mylink_content .renter').css('display','none');
	    jQuery('.mylink_content .service_agent').css('display','none');
	    jQuery('.mylink_content .landlord').css('display','block');

  }
  if(val == 'service_agent'){
	    jQuery('.mylink_content .renter').css('display','none');
	    jQuery('.mylink_content .landlord').css('display','none');
	    jQuery('.mylink_content .service_agent').css('display','block');

  }
  if(val == 'view_all'){
	    jQuery('.mylink_content .renter').css('display','block');
	    jQuery('.mylink_content .landlord').css('display','block');
	    jQuery('.mylink_content .service_agent').css('display','block');

  }
});


</script>
