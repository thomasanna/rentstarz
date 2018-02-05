<script src="/application/modules/User/externals/scripts/message_notififaction.js">
</script><link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
	
<?php $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); 
$viewer     = Engine_Api::_()->user()->getViewer();	
date_default_timezone_set($viewer->timezone);
$fieldsByAlias              =   Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
        if( !empty($fieldsByAlias['profile_type']) ){
              $optionId = $fieldsByAlias['profile_type']->getValue($viewer);
              $profile_type_id = $optionId->value;
        }
$today                            = date('Y-m-d'); 
$today_date                       = strtotime($today);

?>
<script>
	
		var profile_type_id = "<?php echo $profile_type_id;?>";
	
	if(profile_type_id  == 4){ // landlord
	
	jQuery('#global_header').append('<div class="affix-top extra_header mob_bar_disable_particular_pages" data-spy="affix" data-offset-top="100">'+
	'<div id="global_content">'+
	'<div class="extra_header_content">'+
	
	'<ul class="navigation">'+
    '<li><a href="<?php echo $this->baseUrl().'/scheduler'?>">Schedule Viewings</a></li>'+
    '<li><a href="<?php echo $this->baseUrl().'scheduler/meetings'?>">My Viewings</a></li>'+
    '<li  class="active"><a href="<?php echo $this->baseUrl().'/scheduler/meetings/requests'?>">Viewing Requests</a></li>'+
    '<li><a href="<?php echo $this->baseUrl().'/scheduler/meetings/joined'?>">Joined Viewing</a></li>'+
    '</ul>'+
    
	'</div>'+
	'</div>'+
	'</div>');
	
	jQuery('.sub_header_dropdown').html(
                   '<select id = "sub_header_heding_select" class="input-box">'+
                   ' <option  value="scheduler">Schedule Viewings</option>'+
                   ' <option   value="scheduler/meetings">My Viewings</option>'+
                   ' <option selected value="scheduler/meetings/requests">Viewing Requests</option>'+
                   ' <option  value="scheduler/meetings/joined">Joined Viewing</option>'+
                   ' </select>'
    );
 }
 
  if(profile_type_id  == 1){ // tenant
	  
	 jQuery('#global_header').append('<div class="affix-top extra_header mob_bar_disable_particular_pages" data-spy="affix" data-offset-top="100">'+
	'<div id="global_content">'+
	'<div class="extra_header_content">'+	
	'<ul class="navigation">'+
    '<li ><a href="<?php echo $this->baseUrl().'scheduler/meetings'?>">My Viewings</a></li>'+
    '<li class="active"><a href="<?php echo $this->baseUrl().'/scheduler/meetings/requests'?>">Viewing Requests</a></li>'+
    '</ul>'+    
	'</div>'+
	'</div>'+
	'</div>');
	
	jQuery('.sub_header_dropdown').html(
                   '<select id = "sub_header_heding_select" class="input-box">'+
                   ' <option   value="scheduler/meetings">My Viewings</option>'+
                   ' <option  selected value="scheduler/meetings/requests">Viewing Requests</option>'+
                   ' </select>'
    ); 
	   
   }

jQuery(document).on('change','#sub_header_heding_select',function(){
	 location.href=jQuery('#sub_header_heding_select').val();
});

var viewer_identity='<?php echo $viwer_id; ?>';	
</script>
<div class="scheduler_container generic_layout_container layout_middle">	

<div class="payment_content_div">
   <div class="message" style=color:red></div>	
	<div style="text-align: center;padding: 30px;" >
	<?php  	 if(count($this->scheduledMeetingsData) == 0): 
	 echo "No meeting request yet" ; ?>
    </div>
    <?php else: ?>	
	<?php foreach($this->scheduledMeetingsData as $data):?>		
	
	<?php if($data['sheduledby_usertype'] == 'renter'):?>
		<?php  $userTable = Engine_Api::_()->getDbtable('users', 'user');
        $userData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $data['scheduled_by']));?>
        <?php if(!empty($userData)):?>
				<div class="row row_<?php echo $data['id'];?>" style="border-bottom:1px solid #eee; padding: 12px;" >

				<div class="user_image">	
				<?php echo $this->htmlLink($userData->getHref(), $this->itemPhoto($userData, 'thumb.icon', array('class' => 'photo'))) ?> 
				<div style="margin-top: 2px;">
				<a class="username" href="<?php echo $this->baseUrl().'/profile/'.$data['scheduled_by'] ?>"><?php echo $data['displayname'];?></a>
				
				</div>
				</div>
				<?php 
				$scheduled_date=$data['scheduled_date'];
				?>
				<div class="left_options">
				<div class="property col-md-2 col-sm-2" property_id="<?php echo $data['property_id'];?>" style="padding-top: 12px;"> <?php echo $data['property_name']; ?></div>
				<div class="property data_<?php echo $data['id'];?> col-md-2 col-sm-2 col-xs-12" style="padding-top: 12px;"><?php if($data['approved'] == '1'):echo "Accepted"; elseif($data['approved'] == 'rejected'): echo "Rejected"; else: echo "Waiting for approval";endif; ?></div>

				<div class="scheduled_date col-md-3 col-sm-2" style="padding-top: 12px;"> <?php echo $scheduled_date ." , ".$data['scheduled_time']; ?></div>


				<div class="scheduler_options col-md-2 col-sm-2" style="padding-top: 12px;">        
				
			   <?php  if($data['approved'] != '1' && $data['approved'] != 'rejected'&& $data['approved'] != 'completed' ):?>
				
				 <a title="approve" class="scheduler_approve_btn approve_btn_<?php echo $data['id'];?>" scheduled_by="<?php echo $data['scheduled_by'];?>" property_id="<?php echo $data['property_id'];?>" data-id="<?php echo $data['id'];?>" href="javascript:void(0)"   > &nbsp;<img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/images/accept.svg" width="20px"> </a>
				 <a title="decline" class="scheduler_decline_btn decline_btn_<?php echo $data['id'];?>" data-id="<?php echo $data['id'];?>" href="javascript:void(0)"   > &nbsp;<img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/images/reject.svg" width="20px"> </a>
				
				<?php endif;?>
				 <?php if(($data['approved'] == 1 )&& ($today_date > strtotime($data['scheduled_date']))):?>
				<div class="complete_meeting " data-id="<?php echo $data['id'];?>" scheduled_date=<?php echo $data['scheduled_date']; ?> >
				<input type="checkbox" name="Complete" value="Complete" style="cursor: pointer;">&nbsp;&nbsp;Complete
				</div>
				<?php endif;?> 
				
				 <div class="loader loader_<?php echo $data['id'];?>" style="display:none"></div>        
				</div>
				</div>
				</div>	
	
	<?php endif;?>
	<?php endif;?>
	
	<?php if($data['sheduledby_usertype'] == 'landlord'):?>
	<?php  $userTable = Engine_Api::_()->getDbtable('users', 'user');
        $userData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $data['scheduled_by']));?>
	 <?php if(!empty($userData)):?>
			<div class="row row_<?php echo $data['id'];?>" style="border-bottom:1px solid #eee; padding: 12px;">
			
			<div class="user_image">	
			<?php echo $this->htmlLink($userData->getHref(), $this->itemPhoto($userData, 'thumb.icon', array('class' => 'photo'))) ?> 
			<div style="margin-top: 2px;">
			<a class="username" href="<?php echo $this->baseUrl().'/profile/'.$data['scheduled_by'] ?>"><?php echo $data['displayname'];?></a>
			</div>
			</div>
			<?php 
			$scheduled_date=$data['scheduled_date'];
			//$datearray =  explode('-', $date);
			//$scheduled_date= $datearray['2'].'-'.$datearray['0'].'-'.$datearray['1'];
			?>
			<div class="left_options">
			<div class="scheduled_date col-md-2 col-sm-2" style="padding-top: 12px;"> <?php echo $scheduled_date; ?></div>
					<div class="scheduled_date col-md-2 col-sm-2" style="padding-top: 12px;"> <?php echo $data['scheduled_time']?></div>


			<div class="scheduler_options col-md-2 col-sm-2" style="padding-top: 12px;">        
			
		  
			 <div class="loader loader_<?php echo $data['id'];?>" style="display:none"></div>        
			</div>
			</div>
			</div>	
	
	
	<?php endif;?>
	<?php endif;?>

	<?php endforeach;?>

	<?php endif;?>
</div>
</div>
</div>




<script>
 
jQuery( ".scheduler_approve_btn" ).click(function() {
jQuery("#schedulerModal").modal('show');
var data_id = jQuery(this).attr('data-id');
var id = jQuery(this).attr('scheduled_by'); 
var property_id = jQuery(this).attr('property_id'); 

jQuery('#meetingscheduled_with').val(id);
jQuery('#property_id').val(property_id);
jQuery('#data_id').val(data_id);





/*
 var id = jQuery(this).attr('data-id'); 
 jQuery(".approve_btn_"+id).fadeOut();                            
 jQuery(".decline_btn_"+id).fadeOut();  
 jQuery(".loader_"+id).css("display", "block");
 
 var oData       = new Object();
 oData.id       = id;
 var url	=	'<?php echo $this->baseUrl() .'/user/index/approvemeeting' ?>';
 
 
 jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					success: function (data) {
						 
					if(data.status == true){
                       
                        jQuery("#successModal .success_message").text('');
                        jQuery("#successModal .success_message").text('You have successfully accepted the meeting request');
                        jQuery("#successModal").modal('show');
                        jQuery(".loader").css("display", "none");
					}      
					else{
						 jQuery(".approve_btn_"+id).show();
						 jQuery(".decline_btn_"+id).show();
                         jQuery(".loader").css("display", "none");
						
					}                    
					},
					   error: function(e){  
				    }  
		    }); */
});





    jQuery('.scheduler_submit_btn').on('click',function(){
	var data_id = jQuery('#data_id').val();	
	jQuery('.scheduler_submit_btn').hide();
	jQuery('.loader_'+data_id).css('display','block');	
	var oData       = new Object();
	//var scheduled_with = oData.scheduled_with = jQuery('.scheduled_with').val();

	var scheduled_date = oData.scheduled_date = jQuery('#datepicker').val(); 
	var scheduled_time = oData.scheduled_time = jQuery('#timepicker').val();
	var meetingscheduled_with = oData.meetingscheduled_with = jQuery('#meetingscheduled_with').val();
	var property_id = oData.property_id = jQuery('#property_id').val();

	if(meetingscheduled_with !='' && scheduled_date !='' && scheduled_time !=''){
		
			 var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/schedulemeeting';
	 
	    jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) { 						 
						if(data.status == true){
							
							
							
							jQuery("#schedulerModal").modal('hide');
							jQuery("#successModal .success_message").text('You have successfully scheduled your meeting');
							jQuery("#successModal").modal('show'); 
							jQuery('.loader').css('display','none');							
							jQuery(".data_"+data_id).text("Accepted");  
							jQuery(".row_"+data_id+ ' .scheduled_date').text(scheduled_date+' , '+scheduled_time); 
							
							jQuery(".approve_btn_"+data_id).fadeOut();                            							                          
							jQuery(".decline_btn_"+data_id).fadeOut();  

						}
						else{
							jQuery("#schedulerModal").modal('hide');
							jQuery("#successModal .success_message").text(data.message);
							jQuery("#successModal").modal('show'); 
							jQuery('.loader').css('display','none');	
					    }
                   
					 },
					   error: function(e){  
						  }  
					}); 
				
	}
	else{		
		jQuery('.scheduler_submit_btn').show();
	    jQuery('.loader').css('display','none');
	    jQuery('.message').text('please fill all fields');	
	}	
    });  




jQuery( ".scheduler_decline_btn" ).click(function() {

 var id = jQuery(this).attr('data-id'); 
 jQuery(".approve_btn_"+id).fadeOut();                            
 jQuery(".decline_btn_"+id).fadeOut();  
 jQuery(".loader_"+id).css("display", "block");
 
 var oData       = new Object();
 oData.id       = id;
 var url	=	'<?php echo $this->baseUrl() .'/user/index/declinemeeting' ?>';
 
 
 jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					success: function (data) {
						 
					if(data.status == true){
                      /*  jQuery(".approve_btn_"+id).fadeOut();                            
                        jQuery(".decline_btn_"+id).fadeOut();  
                        jQuery(".loader").css("display", "none");
                        */
                        jQuery("#successModal .success_message").text('');
                        jQuery("#successModal .success_message").text('You have rejected the meeting request');
                        jQuery("#successModal").modal('show');
                        jQuery(".loader").css("display", "none");
                        jQuery(".data_"+id).text("Rejected");
					}      
					else{
						 jQuery(".decline_btn_"+id).show();
                         jQuery(".loader").css("display", "none");
						
					}                    
					},
					   error: function(e){  
				    }  
		    }); 
});
	jQuery(document).ready(function(){
		 jQuery(function() {
		jQuery( "#datepicker" ).datepicker({
		  dateFormat: 'yy-mm-dd',
		  minDate: 0
		});   
		}); 
		jQuery('input#timepicker').timepicker({});
	});   
	
	 
  
    jQuery('#global_page_user-index-scheduler .datetimepicker-hours th.switch').text('hour');
    jQuery('#global_page_user-index-scheduler .datetimepicker-minutes th.switch').text('hour');
        
        jQuery('.complete_meeting').on('click',function(){
		var oData       = new Object();		
		var data_id         = oData.data_id        = jQuery(this).attr('data-id'); 
		var scheduled_date  = oData.scheduled_date = jQuery(this).attr('scheduled_date'); 
		var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/completemeeting';		
	    jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					    success: function (data) { 						 
						if(data.status == true){
							jQuery("#successModal .success_message").text('You have successfully completed your meeting');
							jQuery("#successModal").modal('show');
							jQuery(".row_"+data_id).fadeOut( "slow" );

						}
                   
					 },
					   error: function(e){  

						  }  
					}); 
	});
</script>      

