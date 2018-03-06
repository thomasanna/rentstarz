<div class="tabs_alt tabs_parent " style="display:block">
          <ul id="main_tabs">
            <li class="tab_541 tab_layout_user_profile_fields active landlord_maintenancelog_li "><a href="javascript:void(0);">Maintenance Log</a></li>
            <li class="landlord_new_task_li"><a href="javascript:void(0);">New Task</a></li>
            <li class="landlord_repairagent_li"><a href="javascript:void(0);">Repair Agent</a></li>
          </ul>
</div>

<div class="maintenancelog_div">
	
<div class="col-md-2 col-sm-3 col-xs-12">Task</div>
<div class="col-md-2 col-sm-3 col-xs-12">Tenant</div>
<div class="col-md-2 col-sm-3 col-xs-12">Date Rescieve</div>
<div class="col-md-2 col-sm-3 col-xs-12">Date Scheduled</div>
<div class="col-md-2 col-sm-3 col-xs-12">Status</div>
<div class="col-md-2 col-sm-3 col-xs-12">More Info</div>
<hr style="clear:both">
<?php foreach($this->maintenaceLog as $data):?>
<div class="col-md-2 col-sm-3 col-xs-12"><?php echo $data['task_info'];?></div>
<div class="col-md-2 col-sm-3 col-xs-12"><?php echo $data['renter_name'];?></div>
<div class="col-md-2 col-sm-3 col-xs-12"><?php echo $data['created_at'];?></div>
<div class="col-md-2 col-sm-3 col-xs-12"><?php echo $data['scheduled_date'];?></div>
<div class="col-md-2 col-sm-3 col-xs-12"><?php echo $data['status'];?></div>
<div class="col-md-2 col-sm-3 col-xs-12 more_info_task" style="cursor:pointer" taskid ="<?php echo $data['id']?>" data-toggle="modal" data-target="#taskmoreinfoModal">More Info</div>

<hr style="clear:both">
<?php endforeach;?>
</div>
<div class="landlord_new_task_div" style="display:none">
<input type="hidden" value="" class="selected_task_id">

<?php foreach($this->newtaskData as $data):?>
<div>
<div style="text-align:center; margin-bottom:12px"><?php echo "The tenant ".$data['renter_name']." in ".$data['location'].", requesting a task"?></div>
<div class="landlord_image_holder"><img src="<?php echo $this->baseUrl()."/".$data['image']?>"></div>
</div>
<div class="newtask_options" style="text-align:center">
<div class="col-md-3 col-sm-3 col-xs-12">Message</div>
<div class="col-md-3 col-sm-3 col-xs-12 selectagent" style="cursor:pointer" task-id ="<?php echo $data['id']?>">Assign to an agent</div>
</div>
<hr style="clear:both">
<?php endforeach;?>
</div>
<div class="repairagent_div" style="display:none">
<?php foreach($this->repairAgentData as $data):?>

<div class="col-md-3 col-sm-3 col-xs-12">
        <?php 
         echo $this->htmlLink($data->getHref(), $this->itemPhoto($data, 'thumb.icon', array('class' => 'photo')));         
        ?>
        <div><?php echo $data['displayname'];?></div>
</div>
<div class="col-md-3 col-sm-3 col-xs-12">
	<?php echo $data['state']." , ". $data['city'];?>
</div>
<div class="col-md-3 col-sm-3 col-xs-12">
	<?php echo $data['value'];?>
</div>
<div class="col-md-3 col-sm-3 col-xs-12">
<a class="assign_to_agent <?php echo $data['user_id']?>" href="javascript:void(0)" agentid ="<?php echo $data['user_id']?>">Assign</a>
</div>
<hr style="clear:both">

<?php endforeach;?>
</div>


<script>
var handleClick= 'ontouchstart' in document.documentElement ? 'touchstart': 'click';


jQuery('.landlord_maintenancelog_li').on(handleClick, function() {

 jQuery('.landlord_new_task_div').css('display','none');
 jQuery('.landlord_new_task_li').removeClass('active'); 
 jQuery('.repairagent_div').css('display','none');
 jQuery('.landlord_repairagent_li').removeClass('active'); 
 jQuery('.maintenancelog_div').css('display','block');
 jQuery('.landlord_maintenancelog_li').addClass('active');
 
});

jQuery('.landlord_new_task_li').on(handleClick, function() {

 jQuery('.landlord_new_task_div').css('display','block');
 jQuery('.landlord_new_task_li').addClass('active'); 
 jQuery('.repairagent_div').css('display','none');
 jQuery('.landlord_repairagent_li').removeClass('active'); 
 jQuery('.maintenancelog_div').css('display','none');
 jQuery('.landlord_maintenancelog_li').removeClass('active');
 
});

jQuery('.landlord_repairagent_li').on('click', function() {

 jQuery('.landlord_new_task_div').css('display','none');
 jQuery('.landlord_new_task_li').removeClass('active'); 
 jQuery('.repairagent_div').css('display','block');
 jQuery('.landlord_repairagent_li').addClass('active'); 
 jQuery('.maintenancelog_div').css('display','none');
 jQuery('.landlord_maintenancelog_li').removeClass('active');
 
});

jQuery('body').on('click', '.selectagent', function(event){
jQuery('.selected_task_id').val(jQuery(this).attr('task-id'));
jQuery( '.landlord_repairagent_li' ).trigger( 'click' );

});
	jQuery('body').on('click', '.assign_to_agent', function(event){
		var agentid  = jQuery(this).attr('agentid');
		var taskid   = jQuery('.selected_task_id').val();
		var oData       = new Object();		
	    oData.agentid         = agentid;
	    oData.taskid         = taskid;
	    if(taskid != ''){
	    var url          = '<?php echo $this->baseUrl().'/user/index/assigntoagent' ?>';		
			jQuery.ajax({
				url:  url,
				data: oData,						
				dataType: 'json',
				type: 'POST',
				success: function (result) { 
							if(result.status == true){
                                jQuery('.assign_to_agent.'+agentid).html('Please wait for the approval'); 						
                                jQuery('.assign_to_agent.'+agentid).removeClass('assign_to_agent');
                                jQuery('.selected_task_id').val(''); 						
							}
									
				},
				error: function(e){ }  
			   });
	    }
	    else{
			alert('select task');
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
