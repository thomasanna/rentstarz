<div class="tabs_alt tabs_parent " style="display:block">
          <ul id="main_tabs">
            <li class="tab_541 tab_layout_user_profile_fields active landlord_maintenancelog_li "><a href="javascript:void(0);">Maintenance Log</a></li>
            <li class="landlord_new_task_li"><a href="javascript:void(0);">New Task</a></li>
            <li class="landlord_repairagent_li"><a href="javascript:void(0);">Repair Agent</a></li>
            <li class="landlord_link_li"><a href="javascript:void(0);">Link</a></li>
          </ul>
</div>

<div class="maintenancelog_div">
<?php if(count($this->maintenaceLog) > 0): ?>	
	
<div class="col-md-2 col-sm-3 col-xs-12 task_head">Task</div>
<div class="col-md-2 col-sm-3 col-xs-12 task_head">Tenant</div>
<div class="col-md-2 col-sm-3 col-xs-12 task_head">Date Rescieve</div>
<div class="col-md-2 col-sm-3 col-xs-12  task_head">Date Scheduled</div>
<div class="col-md-2 col-sm-3 col-xs-12 task_head">Status</div>
<div class="col-md-2 col-sm-3 col-xs-12 task_head">More Info</div>
<hr style="clear:both">
<?php foreach($this->maintenaceLog as $data):?>
<div class="row landlord_task_log_<?php echo $data['id']?>">
<div class="col-md-2 col-sm-3 col-xs-12"><?php echo $data['task_info'];?></div>
<div class="col-md-2 col-sm-3 col-xs-12"><?php echo $data['renter_name'];?></div>
<div class="col-md-2 col-sm-3 col-xs-12"><?php echo $data['created_at'];?></div>
<div class="col-md-2 col-sm-3 col-xs-12 scheduled_date"><?php echo $data['scheduled_date'];?></div>
<div class="col-md-2 col-sm-3 col-xs-12 status"><?php echo $data['status'];?></div>
<div class="col-md-2 col-sm-3 col-xs-12 more_info_task" style="cursor:pointer" taskid ="<?php echo $data['id']?>" data-toggle="modal" data-target="#taskmoreinfoModal">More Info</div>
</div>
<hr style="clear:both">
<?php endforeach;?>
<?php else :?>
<div style="text-align:center; padding:12px;">You have no tasks</div>

<?php endif;?>
</div>
<div class="landlord_new_task_div" style="display:none">
<input type="hidden" value="" class="selected_task_id">
<?php if(count($this->newtaskData) > 0):?>
<?php foreach($this->newtaskData as $data):?>
<div>
<div style="text-align:center; margin-bottom:12px"><?php echo "The tenant ".$data['renter_name']." in ".$data['location'].", requesting a task"?></div>
<div class="landlord_image_holder"><img src="<?php echo $this->baseUrl()."/".$data['image']?>"></div>
</div>
<div class="newtask_options" style="text-align:center">
<div class="col-md-3 col-sm-3 col-xs-12">Message</div>
<div class="col-md-3 col-sm-3 col-xs-12 schedule_task" style="cursor:pointer" taskid ="<?php echo $data['id']?>" data-toggle="modal" data-target="#scheduletaskModal">Schedule Task</div>
<div class="col-md-3 col-sm-3 col-xs-12 selectagent" style="cursor:pointer" task-id ="<?php echo $data['id']?>">Assign to an agent</div>
</div>
<hr style="clear:both">
<?php endforeach;?>
<?php else: ?>
<div style="text-align:center; padding:12px;">You have no new tasks</div>
<?php endif;?>
</div>
<div class="repairagent_div" style="display:none">
<?php if(count($this->repairAgentData) > 0):?>	
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
<?php else:?>
<div style="text-align:center; padding:12px;">You have no repair agents</div>

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


jQuery('.landlord_maintenancelog_li').on(handleClick, function() {

 jQuery('.landlord_new_task_div').css('display','none');
 jQuery('.landlord_new_task_li').removeClass('active'); 
 jQuery('.repairagent_div').css('display','none');
 jQuery('.landlord_repairagent_li').removeClass('active'); 
 jQuery('.maintenancelog_div').css('display','block');
 jQuery('.landlord_maintenancelog_li').addClass('active');
 jQuery('.link_div').css('display','none');
 jQuery('.landlord_link_li').removeClass('active');

 
});

jQuery('.landlord_new_task_li').on(handleClick, function() {

 jQuery('.landlord_new_task_div').css('display','block');
 jQuery('.landlord_new_task_li').addClass('active'); 
 jQuery('.repairagent_div').css('display','none');
 jQuery('.landlord_repairagent_li').removeClass('active'); 
 jQuery('.maintenancelog_div').css('display','none');
 jQuery('.landlord_maintenancelog_li').removeClass('active');
 jQuery('.link_div').css('display','none');
 jQuery('.landlord_link_li').removeClass('active');

});

jQuery('.landlord_repairagent_li').on('click', function() {

 jQuery('.landlord_new_task_div').css('display','none');
 jQuery('.landlord_new_task_li').removeClass('active'); 
 jQuery('.repairagent_div').css('display','block');
 jQuery('.landlord_repairagent_li').addClass('active'); 
 jQuery('.maintenancelog_div').css('display','none');
 jQuery('.landlord_maintenancelog_li').removeClass('active');
 jQuery('.link_div').css('display','none');
 jQuery('.landlord_link_li').removeClass('active');

 
});
jQuery('.landlord_link_li').on('click', function() {

 jQuery('.landlord_new_task_div').css('display','none');
 jQuery('.landlord_new_task_li').removeClass('active'); 
 jQuery('.repairagent_div').css('display','none');
 jQuery('.landlord_repairagent_li').removeClass('active'); 
 jQuery('.maintenancelog_div').css('display','none');
 jQuery('.landlord_maintenancelog_li').removeClass('active'); 
 jQuery('.link_div').css('display','block');
 jQuery('.landlord_link_li').addClass('active');
 
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
                 jQuery('.landlord_task_log_'+taskid + ' .scheduled_date').html(scheduled_date);
                 jQuery('.landlord_task_log_'+taskid + ' .status').html(status);

					  
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

</script>
