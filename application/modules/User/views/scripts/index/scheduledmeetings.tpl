<script src="/application/modules/User/externals/scripts/message_notififaction.js"></script>
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
        
 	$useragent     = $_SERVER['HTTP_USER_AGENT'];
	$iPod          = stripos($_SERVER['HTTP_USER_AGENT'],"iPod");
	$iPhone        = stripos($_SERVER['HTTP_USER_AGENT'],"iPhone");
	$iPad          = stripos($_SERVER['HTTP_USER_AGENT'],"iPad");
	$Android       = stripos($_SERVER['HTTP_USER_AGENT'],"Android");
	$webOS         = stripos($_SERVER['HTTP_USER_AGENT'],"webOS");

	if( $iPod || $iPhone || $iPad || $Android)  { $dev_type= 1; }// mobile
	else{$dev_type= 2; } // system      
        
 $status    		=   'false';
 $popup_status 		=	'large_popUp';
 if($dev_type == 1):  $popup_status = 'mobile'; endif;
?>

<script>
	
	var profile_type_id = "<?php echo $profile_type_id;?>";
	
	if(profile_type_id  == 4){ // landlord
	
	jQuery('#global_header').append('<div class="affix-top extra_header mob_bar_disable_particular_pages" data-spy="affix" data-offset-top="100">'+
	'<div id="global_content">'+
	'<div class="extra_header_content">'+
	
	'<ul class="navigation">'+
    '<li><a href="<?php echo $this->baseUrl().'/scheduler'?>">Schedule Viewings</a></li>'+
    '<li class="active"><a href="javascript:void(0)">My Viewings</a></li>'+
    '<li><a href="<?php echo $this->baseUrl().'/scheduler/meetings/requests'?>">Viewing Requests</a></li>'+
    '<li><a href="<?php echo $this->baseUrl().'/scheduler/meetings/joined'?>">Joined Viewing</a></li>'+
    '</ul>'+
    
	'</div>'+
	'</div>'+
	'</div>');
	
	jQuery('.sub_header_dropdown').html(
                   '<select id = "sub_header_heding_select" class="input-box">'+
                   ' <option  value="scheduler">Schedule Viewings</option>'+
                   ' <option  selected value="scheduler/meetings">My Viewings</option>'+
                   ' <option  value="scheduler/meetings/requests">Viewing Requests</option>'+
                   ' <option  value="scheduler/meetings/joined">Joined Viewing</option>'+
                   ' </select>'
    );
 }
 
  if(profile_type_id  == 1){ // tenant
	  
	 jQuery('#global_header').append('<div class="affix-top extra_header mob_bar_disable_particular_pages" data-spy="affix" data-offset-top="100">'+
	'<div id="global_content">'+
	'<div class="extra_header_content">'+	
	'<ul class="navigation">'+
    '<li class="active"><a href="javascript:void(0)">My Viewings</a></li>'+
    '<li><a href="<?php echo $this->baseUrl().'/scheduler/meetings/requests'?>">Viewing Requests</a></li>'+
    '</ul>'+    
	'</div>'+
	'</div>'+
	'</div>');
	
	jQuery('.sub_header_dropdown').html(
                   '<select id = "sub_header_heding_select" class="input-box">'+
                   ' <option  selected value="scheduler/meetings">My Viewings</option>'+
                   ' <option  value="scheduler/meetings/requests">Viewing Requests</option>'+
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
	 echo "No scheduled meetings yet" ; ?>
    </div>
    <?php else: ?>	
	<!--<ul>-->
	<?php foreach($this->scheduledMeetingsData as $data): ?>
	<?php $today                            = date('Y-m-d'); 
	      $today_date                       = strtotime($today);
	?>
	
	<?php if($data['sheduledby_usertype'] == 'landlord'):?>
		<?php  $userTable = Engine_Api::_()->getDbtable('users', 'user');
        $userData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $data['scheduled_with']));?>
        
        <?php  if(!empty($userData)):?>

	   <div class="row row_<?php echo $data['id'];?>" style="border-bottom:1px solid #eee; padding: 12px;">

        <div class="user_image">	
	    <?php echo $this->htmlLink($userData->getHref(), $this->itemPhoto($userData, 'thumb.icon', array('class' => 'photo'))) ?> 
	    <div style="margin-top: 2px;">
	   <a class="username" href="<?php echo $this->baseUrl().'/profile/'.$data['scheduled_with'] ?>"><?php echo $userData->displayname;?></a>
	    </div>
	    </div>
				 <?php 
		$date=$data['scheduled_date'];
		$datearray =  explode('-', $date);
		$scheduled_date= $datearray['0'].'-'.$datearray['1'].'-'.$datearray['2'];
		?>
		 <div class="left_options">	
        <div class="scheduled_date col-md-3 col-sm-3 col-xs-12 scheduled_date_<?php echo $data['id']; ?>" style="padding-top: 12px;"> <?php echo $scheduled_date.'  ,'. $data['scheduled_time']; ?></div>
	    <div class="col-md-3 col-sm-3 reshedule_meeting col-xs-12" data-id="<?php echo $data['id'];?>" scheduled_with=<?php echo $data['scheduled_with']; ?> scheduled_date=<?php echo $scheduled_date; ?> scheduled_time=<?php echo $data['scheduled_time']; ?> style="padding-top: 12px;"><a href="javascript:void(0)">Reschedule</a></div>
	   <?php if(($data['approved'] == 1 )&& ($today_date > strtotime($data['scheduled_date']))):?>
	    <div class="col-md-3 col-sm-3 complete_meeting col-xs-12" data-id="<?php echo $data['id'];?>" scheduled_date=<?php echo $data['scheduled_date']; ?> style="padding-top: 12px;">
	    <input type="checkbox" name="Complete" value="Complete" style="cursor: pointer;">&nbsp;&nbsp;Complete
	    </div>
	    <?php endif;?> 

       </div>
      
      </div>
        
     <?php endif;?> 
     <?php endif;?> 
	<?php if($data['sheduledby_usertype'] == 'renter'):?>
	    <?php  $userTable = Engine_Api::_()->getDbtable('users', 'user');
        $userData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $data['scheduled_with']));        
        ?>
        <?php
        if(!empty($userData)):
        $viewHelperObj      =   $this->getHelper('ItemPhoto');
         $profileNoPicInfo   =   $viewHelperObj->getNoPhoto($userData);
                $type               =   'thumb.icon';
                $safeName           =   ( $type ? str_replace('.', '_', $type) : 'main' );
                $src                =   $userData->getPhotoUrl($type);
                if($src):
                $src                =   $src;
                else:
                $src                =   $viewHelperObj->getNoPhoto($userData,$safeName);
                endif;
        
        
        ?>

	   <div class="row row_<?php echo $data['id'];?>"  style="border-bottom:1px solid #eee; padding: 12px;">
		
        <div class="user_image">	
	    <?php echo $this->htmlLink($userData->getHref(), $this->itemPhoto($userData, 'thumb.icon', array('class' => 'photo'))) ?> 
	    <div style="margin-top: 2px;">
	    <a class="username" href="<?php echo $this->baseUrl().'/profile/'.$data['scheduled_with'] ?>"><?php echo $userData->displayname;?></a>
	    </div>
	    </div>
	    <div class="left_options">
	     <div class="property col-md-3 col-sm-2 col-xs-12" style="padding-top: 12px;"><?php echo $data['property_name']; ?></div>
	     <div class="property col-md-2 col-sm-2 col-xs-12" style="padding-top: 12px;"><?php if($data['approved'] == '1'):echo "Accepted"; elseif($data['approved'] == 'rejected'): echo "Rejected"; else: echo "Waiting for approval";endif; ?></div>
		<?php 
		$date=$data['scheduled_date'];
		$datearray =  explode('-', $date);
		$scheduled_date= $datearray['0'].'-'.$datearray['1'].'-'.$datearray['2'];
		?>
        <div class="scheduled_date col-md-3 col-sm-2 col-xs-12 scheduled_date_<?php echo $data['id']; ?>" style="padding-top: 12px;"> <?php echo $scheduled_date.'  ,'. $data['scheduled_time']; ?></div>
	     <?php if($dev_type == 1):?>
	     <div class="property col-md-2 col-sm-2 col-xs-12" style="padding-top: 12px;cursor:pointer" ><a style="color: #364347;" href="<?php echo $this->baseUrl().'/tichat/singlechatmob'; ?>" target="_blank" onClick="popUpChatClick('<?php echo $UserData->user_id ?>','<?php echo $UserData->displayname; ?>','<?php echo $src ?>','<?php echo $popup_status ?>')">Message</a></div>									 
        <?php else:?> 
        <div class="message col-md-2 col-sm-2 col-xs-12" style="padding-top: 12px;cursor:pointer" onClick="popUpChatClick('<?php echo $userData->user_id ?>','<?php echo $userData->displayname; ?>','<?php echo $src ?>','<?php echo $popup_status ?>')">Message</div>
        <?php endif;?> 
	   
      </div>
     
      </div>
     
     <?php endif;?> 
     <?php endif;?> 

	

	<?php endforeach;?>
<!--	</ul>-->

	<?php endif;?>


</div>
</div>

</div>

<script>

	
jQuery( ".reshedule_meeting" ).click(function() {
jQuery("#schedulerModal").modal('show');
var id = jQuery(this).attr('scheduled_with'); 
var scheduled_date = jQuery(this).attr('scheduled_date'); 
var scheduled_time = jQuery(this).attr('scheduled_time'); 
var data_id = jQuery(this).attr('data-id'); 


jQuery('#data_id').val(data_id);

	jQuery("#datepicker").datepicker('setDate',scheduled_date );
	jQuery("#timepicker").timepicker('setTime',scheduled_time );

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
	
	
	
	

jQuery('.scheduler_submit_btn').on('click',function(){
			

	var data_id = jQuery('#data_id').val();	
	var datescheduledbylandlord = jQuery('#datescheduledbylandlord').val();	
	jQuery('#schedulerModal').modal('hide');
    var oData       = new Object();
    var scheduled_date = oData.scheduled_date = jQuery('#datepicker').val(); 
	var scheduled_time = oData.scheduled_time = jQuery('#timepicker').val();

    var data_id = oData.data_id = data_id;
    if(scheduled_date !='' && scheduled_time !='' ){

		
		var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/rescheduleoflandlord';		
	    jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					    success: function (data) { 						 
						if(data.status == true){
							jQuery("#successModal .success_message").text('You have successfully rescheduled your meeting');
							jQuery("#successModal").modal('show');
							jQuery('.scheduled_date_'+data_id).text(scheduled_date+' ,'+scheduled_time);

						}
						else{
							jQuery("#successModal .success_message").text(data.message);
							jQuery("#successModal").modal('show');
						}
                   
					 },
					   error: function(e){  

						  }  
					}); 
	}

	 
    }); 
    
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
