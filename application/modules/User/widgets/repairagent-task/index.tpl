<div class="tabs_alt tabs_parent " style="display:block">
          <ul id="main_tabs">
            <li class="repairagent_new_task_li active"><a href="javascript:void(0);">Maintenance Log</a></li>
          </ul>
</div>

<div class="repairagent_new_task_div">
<?php if(count($this->mytasks) > 0):?>

<div class="col-md-2 col-sm-3 col-xs-12 task_head">Task</div>
<div class="col-md-2 col-sm-3 col-xs-12 task_head">Location</div>
<div class="col-md-2 col-sm-3 col-xs-12 task_head">Schedule</div>
<div class="col-md-2 col-sm-3 col-xs-12 task_head">Status</div>
<hr style="clear:both">
<?php foreach($this->mytasks as $data):?>
<div class="col-md-2 col-sm-3 col-xs-12"><?php echo $data['task_info'];?></div>
<div class="col-md-2 col-sm-3 col-xs-12"><?php echo $data['location'];?></div>
<div class="col-md-2 col-sm-3 col-xs-12"><?php echo $data['scheduled_date'];?></div>
<div class="col-md-2 col-sm-3 col-xs-12"><?php echo $data['status'];?></div>
<div class="col-md-2 col-sm-3 col-xs-12 more_info_task" style="cursor:pointer" taskid ="<?php echo $data['id']?>">More Info</div>
<div class="col-md-2 col-sm-3 col-xs-12 schedule_task" style="cursor:pointer" taskid ="<?php echo $data['id']?>">Schedule Task</div>

<hr style="clear:both">
<?php endforeach;?>
<?php else:?>
<div>No one is assigned tasks till yet</div>
<?php endif;?>
</div>

<script>
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
					jQuery('#taskmoreinfoModal').modal('show')
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
					jQuery('#scheduletaskModal').modal('show')
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
