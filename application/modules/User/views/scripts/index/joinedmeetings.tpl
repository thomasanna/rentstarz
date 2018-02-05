<script src="/application/modules/User/externals/scripts/message_notififaction.js"></script>
<script>
	
    
    jQuery('#global_header').append('<div class="affix-top extra_header mob_bar_disable_particular_pages" data-spy="affix" data-offset-top="100">'+
	'<div id="global_content">'+
	'<div class="extra_header_content">'+
	
	'<ul class="navigation">'+
    '<li><a href="<?php echo $this->baseUrl().'/scheduler'?>">Schedule Viewings</a></li>'+
    '<li><a href="<?php echo $this->baseUrl().'scheduler/meetings'?>">My Viewings</a></li>'+
    '<li ><a href="<?php echo $this->baseUrl().'/scheduler/meetings/requests'?>">Viewing Requests</a></li>'+
    '<li  class="active"><a href="<?php echo $this->baseUrl().'/scheduler/meetings/joined'?>">Joined Viewing</a></li>'+
    '</ul>'+
    
	'</div>'+
	'</div>'+
	'</div>');
	
	jQuery('.sub_header_dropdown').html(
                   '<select id = "sub_header_heding_select" class="input-box">'+
                   ' <option  value="scheduler">Schedule Viewings</option>'+
                   ' <option   value="scheduler/meetings">My Viewings</option>'+
                   ' <option  value="scheduler/meetings/requests">Viewing Requests</option>'+
                   ' <option selected value="scheduler/meetings/joined">Joined Viewing</option>'+
                   ' </select>'
    );

jQuery(document).on('change','#sub_header_heding_select',function(){
	 location.href=jQuery('#sub_header_heding_select').val();
});
	
<?php $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
$viewer     = Engine_Api::_()->user()->getViewer();
date_default_timezone_set($viewer->timezone);
?>

var viewer_identity='<?php echo $viwer_id; ?>';	
</script>
<div class="scheduler_container generic_layout_container layout_middle">	

<div class="payment_content_div">
   <div class="message" style=color:red></div>	
    <div style="text-align: center;padding: 30px;" >
	<?php  	 if(count($this->scheduledMeetingsData) == 0):  
	 echo "No joined Viewing yet" ; ?>
    </div>
    <?php else: ?>	
	<ul>
	<?php foreach($this->scheduledMeetingsData as $data):?>	
	<?php  $userTable = Engine_Api::_()->getDbtable('users', 'user');
	
	if($data['scheduled_with'] == $viwer_id):
	    $userData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $data['scheduled_by']));  
	endif; 
	if($data['scheduled_by'] == $viwer_id):
	    $userData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $data['scheduled_with']));  
	endif; 
	?>
    <?php if(!empty($userData)){?>	
	<li>		
		<div>		
			<div class="user_image">	
			<?php echo $this->htmlLink($userData->getHref(), $this->itemPhoto($userData, 'thumb.icon', array('class' => 'photo'))) ?> 
			</div>
			<div class="position">	
			 <div class="user_profile">	    
				<div>
					<a class="username" href="<?php echo $this->baseUrl().'/profile/'.$userData->user_id ?>"><?php echo $userData->displayname;?></a>
				</div>
				<?php 
				$scheduled_date=$data['scheduled_date'];				
				?>
          <div class="scheduled_date"> <?php echo $scheduled_date.'  ,'.$data['scheduled_time']; ?></div>
	    </div>
	    </div>
	    </div>	
	<hr style="clear: both;">
	</li>
	<?php } ?>
	<?php endforeach;?>
	</ul>
	<?php endif;?>
</div>
</div>
