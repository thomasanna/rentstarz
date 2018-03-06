<?php
$userHelperObj       =  $this->getHelper('User');
$landlodsData = $userHelperObj->getYourLandlords($this->subjectId);
?>
<div>
	
<?php if(count($landlodsData)>0):?>	
<div class="tabs_alt tabs_parent " style="display:block">
          <ul id="main_tabs">
            <li class="tab_541 tab_layout_user_profile_fields active renter_my_task_li "><a href="javascript:void(0);">My Task</a></li>
            <li class="renter_new_task_li"><a href="javascript:void(0);">New Task</a></li>
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

<div class="col-md-2 col-sm-3 col-xs-12"><?php echo $task['task_info']?></div>
<div class="col-md-2 col-sm-3 col-xs-12"><?php echo $task['landlord_name']?></div>
<div class="col-md-2 col-sm-3 col-xs-12"><?php echo $task['scheduled_date']?></div>
<div class="col-md-2 col-sm-3 col-xs-12"><?php echo $task['status']?></div>
<div class="col-md-2 col-sm-3 col-xs-12 more_info_task" style="cursor:pointer" taskid ="<?php echo $task['id']?>" data-toggle="modal" data-target="#taskmoreinfoModal">More Info</div>
<div class="col-md-2 col-sm-3 col-xs-12 schedule_task" style="cursor:pointer" taskid ="<?php echo $task['id']?>" data-toggle="modal" data-target="#scheduletaskModal">Schedule Task</div>

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
</form>   
</div>
<?php else:?>

<div>You have no rented any property yet</div>

<?php endif;?>




</div>


<script>
var handleClick= 'ontouchstart' in document.documentElement ? 'touchstart': 'click';


jQuery('.renter_my_task_li').on(handleClick, function() {

 jQuery('.renter_new_task_div').css('display','none');
 jQuery('.renter_new_task_li').removeClass('active'); 
 jQuery('.renter_my_task_div').css('display','block');
 jQuery('.renter_my_task_li').addClass('active');
 
});
jQuery('.renter_new_task_li').on(handleClick, function() {

 jQuery('.renter_new_task_div').css('display','block');
 jQuery('.renter_new_task_li').addClass('active'); 
 jQuery('.renter_my_task_div').css('display','none');
 jQuery('.renter_my_task_li').removeClass('active');
 
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
 jQuery('.send_task_btn').prop('disabled', true);

 var photopath = jQuery('#fileUpload').val(); 
 var task_info = jQuery('.task_info').val(); 
 var yourlandlord = jQuery('.yourlandlord').val(); 
 var task_location = jQuery('.task_location').val(); 
 var ext = jQuery('#fileUpload').val().split('.').pop().toLowerCase();
 if(task_info !='' && photopath != '' && yourlandlord !='' && task_location !=''){

 if(ext != "jpg" && ext != "JPG" && ext != "png" && ext != "jpeg" && ext != "JPEG" &&  ext != "PNG") {
		jQuery('.renter_new_task_div .message').css('color','red');
		jQuery('.renter_new_task_div .message').html('Sorry, only JPG, JPEG, & PNG  files are allowed');
	    jQuery('.send_task_btn').prop('disabled', false);
		jQuery('.send_task_btn').css('display', 'block');
        jQuery('.loader').css('display', 'none');
		
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
		 jQuery('.send_task_btn').prop('disabled', false);
		 jQuery('.send_task_btn').css('display', 'block');
	     }
       
	},
		
	error: function(){} 	        
	});
	 
 }
 
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
					    location.reload();
			},
				error: function(e){ }  
			   });
	    }		
	});


</script>
