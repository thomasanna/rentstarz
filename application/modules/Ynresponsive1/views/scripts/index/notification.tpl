<?php  $viewer = Engine_Api::_()->user()->getViewer();
	  date_default_timezone_set($viewer->timezone);
?>
<script type="text/javascript">
function makeRead(actionid)
{
      var oData       = new Object();
      oData.actionid =actionid;
      var content = jQuery('#content_'+actionid).html();
      var last_redirect_url = jQuery('#content_'+actionid).find('a:last').attr('href');
      var first_redirect_url = jQuery('#content_'+actionid).find('a:last').attr('href');
      var url =    '/ynresponsive1/index/markread';
      jQuery.ajax({
                        url:  url,
                        data: oData,
                        dataType: 'json',
                        type: 'POST',
                        success: function (data) {
						if(data == true){	
							if(last_redirect_url != 'undefined'){
							location.href='<?php echo $this->baseUrl(); ?>' + last_redirect_url;
						   }
						   else{
							  location.href='<?php echo $this->baseUrl(); ?>' + first_redirect_url; 
						   }
                       }
                          
                     },
                       error: function(e){   }
                 }); 
}
</script>	
<?php if (count($this->updates)): ?>
<div class="ynadvmenu_dropdownHaveContent">
	<ul class="ynadvmenu_Contentlist">
	<?php  $userTable = Engine_Api::_()->getDbtable('users', 'user');
	foreach ($this->updates as $item):?>
		<?php
		ob_start();
          try { 
		$subject = $item->getSubject()?>
							
		<?php  $subjectData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $item->subject_id)); 	?>	 
					
		<li <?php if( !$item->read ): ?> class = "ynadvmenu_Contentlist_unread" <?php endif; ?> onclick="makeRead(<?php echo $item->getIdentity();?>)" value="<?php echo $item->getIdentity();?>" >
			<a title="<?php echo $subjectData->displayname; ?>"><?php echo $this->itemPhoto($subject, 'thumb.icon');?></a>   
			<div class="ynadvmenu_ContentlistInfo">
				<div class="ynadvmenu_NameUser" id="content_<?php echo $item->getIdentity();?>" onclick="makeRead(<?php echo $item->getIdentity();?>)">
					 
					 <?php if($item->type == 'document_request'):?>

						<a class="feed_item_username" title="View Profile" href="/profile/<?php echo $item->subject_id; ?>"><?php echo $subjectData->displayname;?> </a> has requested to access your document <a class="feed_item_username" title="View Document" href="/documents/requests"><?php echo $item->params['label'];?></a>
						 
						<?php elseif($item->type == 'document_request_approve'):?>
						
						<a class="feed_item_username" title="View Profile" href="/profile/<?php echo $item->subject_id; ?>"><?php echo $subjectData->displayname;?> </a> has approved your request for document  <a class="feed_item_username" title="View Document" href="/documents/sharedwithme"><?php echo $item->params['label'];?></a>
						
						<?php elseif($item->type == 'profile_rate'):?>
						
						<a class="feed_item_username" title="View Profile" href="/profile/<?php echo $item->subject_id; ?>"><?php echo $subjectData->displayname;?> </a> rated you on property '<?php echo $item->params['pname'];?>' <a class="feed_item_username" title="View Rate" href="/rate/<?php echo $item->subject_id;?>/<?php echo $item->params['pid'];?>"><?php echo $item->params['label'];?></a>
						
						<?php elseif($item->type == 'document_share'):?>
						
						<a class="feed_item_username" title="View Profile" href="/profile/<?php echo $item->subject_id; ?>"><?php echo $subjectData->displayname;?> </a> has shared a new document <a class="feed_item_username" title="View Document" href="/documents/sharedwithme"><?php echo $item->params['label'];?></a>

						<?php elseif($item->type == 'matching_property'):?>
						
						<a class="feed_item_username" title="View Profile" href="/profile/<?php echo $item->subject_id; ?>"><?php echo $subjectData->displayname;?> </a> has added a new property that match with your requirement <a class="feed_item_username" title="View Property" href="/property/<?php echo $item->params['pid'];?>"><?php echo $item->params['label'];?></a>

						<?php elseif($item->type == 'application_request'):?>
						
						<a class="feed_item_username" title="View Profile" href="/profile/<?php echo $item->subject_id; ?>"><?php echo $subjectData->displayname;?> </a> has sent application for your property <a class="feed_item_username" title="View Property" href="/propertyrequestslist"><?php echo $item->params['label'];?></a>

						<?php elseif($item->type == 'application_accept'):?>
						
						<!--<a class="feed_item_username" title="View Profile" href="/profile/<?php echo $item->subject_id; ?>"><?php echo $subjectData->displayname;?> </a> has accepted your application for the property <a class="feed_item_username" title="View Property" href="/property/requests/approved"><?php echo $item->params['label'];?></a> -->
                        Good news your application against property <a class="feed_item_username" title="View Property" href="/property/<?php echo $item->params['pid'];?>"><?php echo $item->params['label'];?></a> is being considered


                         <?php elseif($item->type == 'application_reject'):?>
						
					     Sorry, your application against property <a class="feed_item_username" title="View Property" href="/property/<?php echo $item->params['pid'];?>"><?php echo $item->params['label'];?></a> has been rejected


                        <?php elseif($item->type == 'report_request'):?>
						
						<a class="feed_item_username" title="View Profile" href="/profile/<?php echo $item->subject_id; ?>"><?php echo $subjectData->displayname;?> </a> has requested  a report for the property <a class="feed_item_username" title="View Property" href="/property/requests"><?php echo $item->params['label'];?></a>

                        <?php elseif($item->type == 'application_review'): ?>
                         
                            <?php $propertyRequestTable =  Engine_Api::_()->getDbtable('propertyrequest', 'user');	 
                         
                            $propertyRequestData = $propertyRequestTable->fetchRow($propertyRequestTable->select()->where('id = ?', $item->params['property_request_id']));
                         
								 if($propertyRequestData->landlord_approve == 0 && $propertyRequestData->application_view_status ==1 ):

								 ?>                         

							   	Your application for property <a class="feed_item_username" title="View Property" href="/property/"<?php echo $item->params['pid']?>><?php echo $item->params['label'];?></a> is under review 
							   <?php /*	<a class="feed_item_username" title="View Profile" href="/profile/<?php echo $notification->subject_id; ?>"><?php echo $subjectData->displayname;?> </a> your application for property <a class="feed_item_username" title="View Property" href="/property/"<?php echo $notification->params['pid']?>><?php echo $notification->params['label'];?></a> is under review */?>

								<?php endif;?>
						<?php elseif($item->type == 'meeting_scheduler'): ?>
						
						<a class="feed_item_username" title="View Profile" href="/profile/<?php echo $item->subject_id; ?>"><?php echo $subjectData->displayname;?> </a> has scheduled a meeting with you on <a href="scheduler/meetings/requests"><?php echo $item->params['scheduled_date'] ."  ".$item->params['scheduled_time'];?></a>
		
						<?php elseif($item->type == 'scheduled_appoinment_remainder'): ?>
						
						<a class="feed_item_username" title="View Profile" href="/profile/<?php echo $item->subject_id; ?>"><?php echo $subjectData->displayname;?> </a> has scheduled a meeting with you on <a href="<?php echo $schedulerUrl;?>"><?php echo $item->params['scheduledDate'] ;?></a>
		
						<?php elseif($item->type == 'survey_notification'): ?>
						
						<a class="feed_item_username" title="View Profile" href="/profile/<?php echo $item->subject_id; ?>"><?php echo $subjectData->displayname;?> </a> has initiate survey with <a href="members/home"> you </a>
		
						<?php elseif($item->type == 'share_report'): ?>
						
						<a class="feed_item_username" title="View Profile" href="/profile/<?php echo $item->subject_id; ?>"><?php echo $subjectData->displayname;?> </a> has shared a <a href="report/<?php echo $item->params['user_id'] ;?>"> report </a>
		
						<?php elseif($item->type == 'approve_scheduler'): ?>
						
						<a class="feed_item_username" title="View Profile" href="/profile/<?php echo $item->subject_id; ?>"><?php echo $subjectData->displayname;?> </a> has approved your meeting request and your meeting scheduled on <a href="scheduler/meetings/joined"> <?php echo $item->params['scheduled_date'] ."  ".$item->params['scheduled_time'];?> </a>
		
						<?php elseif($item->type == 'decline_meeting'): ?>
						
						<a class="feed_item_username" title="View Profile" href="/profile/<?php echo $item->subject_id; ?>"><?php echo $subjectData->displayname;?> </a> has declined your meeting request against the property <a href="scheduler/meetings"> <?php echo $item->params['pname'];?> </a>
		               
		                <?php elseif($item->type == 'property_granted'): ?>
						
						<a class="feed_item_username" title="View Profile" href="/profile/<?php echo $item->subject_id; ?>"><?php echo $subjectData->displayname;?> </a> has granted you, to  <?php echo $item->params['rentaltype'] . " " .$item->params['gender_of_propertyowner']." ";?>  property  <a href="property/<?php echo $item->params['pid'];?>"><?php echo $item->params['pname'];?> </a>

                        <?php elseif($item->type == 'meeting_request'): ?>
						
						<span class="feed_item_username"><?php echo $subjectData->displayname;?></span>  has requested a meeting against the property <a href="scheduler/meetings/requests"><?php echo $item->params['property'] ; ?> </a>
						
                        <?php elseif($item->type == 'package_renewal_remainder'): ?>
						
						<span class="feed_item_username"></span> You have only <?php echo $item->params['day_diif'] ; ?> days remains to expire your package. 
						
                        <?php elseif($item->type == 'package_renewal'): ?>
						
						<span class="feed_item_username"></span> Your package has been successfully renewed.
						
                        <?php elseif($item->type == 'backgroundreport_remainder_during_lastweek'): ?>
						
						<span class="feed_item_username"></span> You have only few days remaining to expire your background report.
						 
						<?php elseif($item->type == 'comment_notification_to_renter'):  ?>
						
						<span class="feed_item_username"><?php echo $subjectData->displayname;?></span> has replied to your comment on property <a href="property/<?php echo $item->params['pid']?>"><?php echo $item->params['pname'] ; ?> </a>
                       
                       <?php elseif($item->type == 'comment_notification_to_pOwner'):  ?>
						
						<span class="feed_item_username"><?php echo $subjectData->displayname;?></span> has commented on your property <a href="property/<?php echo $item->params['pid']?>"><?php echo $item->params['pname'] ; ?> </a>
			
                       <?php elseif($item->type == 'task_for_maintenance'):  ?>
						
						<a class="feed_item_username" title="View Profile" href="/profile/<?php echo $item->subject_id; ?>"><?php echo $subjectData->displayname;?></a> has sent a new task for maintenance. 
			
                       <?php elseif($item->type == 'assign_task_to_agent'):  ?>
						
						<a class="feed_item_username" title="View Profile" href="/profile/<?php echo $item->subject_id; ?>"><?php echo $subjectData->displayname;?></a> has assigned a new task for you.Please check. 
			
                       <?php elseif($item->type == 'scheduled_task'):  ?>
						
						<a class="feed_item_username" title="View Profile" href="/profile/<?php echo $item->subject_id; ?>"><?php echo $subjectData->displayname;?></a> has been scheduled a task for you.Please check. 
			
                       <?php elseif($item->type == 'Like_to_link'):  ?>
						
						<a class="feed_item_username" title="View Profile" href="/profile/<?php echo $item->subject_id; ?>"><?php echo $subjectData->displayname;?></a>  would like to link with you do you except.    
			
						<?php else:?>
			
						 
						<?php echo $item->__toString() ?>
						 
						<?php endif;?>
					 
				</div>
				<div class="ynadvmenu_postIcon activity_icon_status notification_type_<?php echo $item->type ?>"> 
					<span class="timestamp"> <?php echo $this->timestamp($item->date)?> </span> 
				</div>
			</div>
		</li>
	<?php 
	 } catch( Exception $e ) 
	 {
        ob_end_clean();
        if( APPLICATION_ENV === 'development' ) {
          //echo $e->__toString();
        }
        continue;
      }
          ob_end_flush();
      endforeach;?>
	</ul>
</div>
<?php else:?>
<div class="ynadvmenu_dropdownNoContent">
	<?php echo $this->translate("You have no new updates.") ?>
</div>
<?php endif;?>
