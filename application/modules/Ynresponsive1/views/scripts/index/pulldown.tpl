<?php foreach( $this->notifications as $notification ): 
 ob_start();
   try { 
  		$subject = $notification->getSubject(); ?>
            <li <?php if( !$notification->read ): ?> class = "ynadvmenu_Contentlist_unread"<?php $this->hasunread = true; ?> <?php endif; ?> value="<?php echo $notification->getIdentity();?>" >
			 <div class="check_field"><input type="checkbox" class="checkBoxClass" name="checkBoxClass" value="<?php echo $notification->getIdentity();?>"></div>
              <div class="content_info_div">
				<a><?php echo $this->itemPhoto($subject, 'thumb.icon');?></a>   
				<div class="ynadvmenu_ContentlistInfo">
					<div class="ynadvmenu_NameUser" id="content_<?php echo $notification->getIdentity();?>">
					
						 <?php if($notification->type == 'document_request'):?>

						<span class="feed_item_username"><?php echo $subject->displayname;?></span>  has requested to access your document <a class="feed_item_username" title="View Document" href="/documents/requests"><?php echo $notification->params['label'];?></a>
						 
						<?php elseif($notification->type == 'document_request_approve'):?>
						
						<span class="feed_item_username"><?php echo $subject->displayname;?></span>  has approved your request for document  <a class="feed_item_username" title="View Document" href="/documents/sharedwithme"><?php echo $notification->params['label'];?></a>
						<?php elseif($notification->type == 'document_request_reject'):?>
						
						<a class="feed_item_username" title="View Profile" href="/profile/<?php echo $notification->subject_id; ?>"><?php echo $subject->displayname;?> </a>  has rejected your request for document <span class="feed_item_username"><?php echo $notification->params['label'];?></span>

						<?php elseif($notification->type == 'profile_rate'):?>
						
						<span class="feed_item_username"><?php echo $subject->displayname;?></span>  rated you on property <?php echo $notification->params['pname'];?> <a class="feed_item_username" title="View Rate" href="/rate/<?php echo $notification->subject_id;?>/<?php echo $notification->params['pid'];?>"><?php echo $notification->params['label'];?></a>
						
						<?php elseif($notification->type == 'document_share'):?>
						
						<span class="feed_item_username"><?php echo $subject->displayname;?></span>  has shared a new document <a class="feed_item_username" title="View Document" href="/documents/sharedwithme"><?php echo $notification->params['label'];?></a>

						<?php elseif($notification->type == 'matching_property'):?>
						
						<span class="feed_item_username"><?php echo $subject->displayname;?></span>  has added a new property that match with your requirement <a class="feed_item_username" title="View Property" href="/property/<?php echo $notification->params['pid'];?>"><?php echo $notification->params['label'];?></a>

						
						<?php elseif($notification->type == 'application_request'):?>
						
						<span class="feed_item_username"><?php echo $subject->displayname;?></span>  has sent application for your property <a class="feed_item_username" title="View Property" href="/propertyrequestslist"><?php echo $notification->params['label'];?></a>

					
						<?php elseif($notification->type == 'application_accept'):?>
						
						<!--<a class="feed_item_username" title="View Profile" href="/profile/<?php echo $notification->subject_id; ?>"><?php echo $subjectData->displayname;?> </a> has accepted your application for the property <a class="feed_item_username" title="View Property" href="/property/requests/approved"><?php echo $notification->params['label'];?></a>-->
                         Good news your application against property <a class="feed_item_username" title="View Property" href="/property/<?php echo $notification->params['pid'];?>"><?php echo $notification->params['label'];?></a> is being considered
					
						<?php elseif($notification->type == 'application_reject'):?>
						
                        Sorry, your application against property <a class="feed_item_username" title="View Property" href="/property/<?php echo $notification->params['pid'];?>"><?php echo $notification->params['label'];?></a> has been rejected

						<?php elseif($notification->type == 'report_request'): ?>
						
						<span class="feed_item_username"><?php echo $subject->displayname;?></span>  has requested  a report for the property <a class="feed_item_username" title="View Property" href="/property/requests"><?php echo $notification->params['label'];?></a>


                        <?php elseif($notification->type == 'application_review'): ?>
                         
                            <?php $propertyRequestTable =  Engine_Api::_()->getDbtable('propertyrequest', 'user');	 
                         
                            $propertyRequestData = $propertyRequestTable->fetchRow($propertyRequestTable->select()->where('id = ?', $notification->params['property_request_id']));
                         
								 if($propertyRequestData->landlord_approve == 0 && $propertyRequestData->application_view_status ==1 ):

								 ?>                         

							   	Your application for property <a class="feed_item_username" title="View Property" href="/property/"<?php echo $notification->params['pid']?>><?php echo $notification->params['label'];?></a> is under review 
							   <!--	<a class="feed_item_username" title="View Profile" href="/profile/<?php echo $notification->subject_id; ?>"><?php echo $subjectData->displayname;?> </a> your application for property <a class="feed_item_username" title="View Property" href="/property/"<?php echo $notification->params['pid']?>><?php echo $notification->params['label'];?></a> is under review -->

								<?php endif;?>
                        <?php elseif($notification->type == 'meeting_scheduler'): ?>
						
						<span class="feed_item_username"><?php echo $subject->displayname;?></span>  has scheduled a meeting with you on <a href="scheduler/meetings/requests"><?php echo $notification->params['scheduled_date'] ."  ".$notification->params['scheduled_time'];?></a>

                        <?php elseif($notification->type == 'scheduled_appoinment_remainder'): ?>
						
						<span class="feed_item_username"><?php echo $subject->displayname;?></span>  has scheduled a meeting with you on <a href="<?php echo $schedulerUrl;?>"><?php echo $notification->params['scheduled_date'] ;?></a>

                        <?php elseif($notification->type == 'survey_notification'): ?>
						
						<a class="feed_item_username" title="View Profile" href="/profile/<?php echo $notification->subject_id; ?>"><?php echo $subjectData->displayname;?> </a> has initiate survey with you 


                        <?php elseif($notification->type == 'share_report'): ?>
						
						<span class="feed_item_username"><?php echo $subject->displayname;?></span>  has shared a <a href="report/<?php echo $notification->params['user_id']?>">report</a>

                        <?php elseif($notification->type == 'approve_scheduler'): ?>
						
						<span class="feed_item_username"><?php echo $subject->displayname;?></span>  has approved your meeting request on <a href="scheduler/meetings/joined"><?php echo $notification->params['scheduled_date'] ."  ".$notification->params['scheduled_time'];?> </a>

                        <?php elseif($notification->type == 'decline_meeting'): ?>
						
						<span class="feed_item_username"><?php echo $subject->displayname;?></span>  has declined your meeting request against the property <a href="scheduler/meetings"><?php echo $notification->params['pname'];?> </a>

                        <?php elseif($notification->type == 'property_granted'): ?>
						
						<span class="feed_item_username"><?php echo $subject->displayname;?></span>  has granted you, to  <?php echo $notification->params['rentaltype'] . " " .$notification->params['gender_of_propertyowner']." ";?>  property  <a href="property/<?php echo $notification->params['pid'];?>"><?php echo $notification->params['pname'];?> </a>

                        <?php elseif($notification->type == 'meeting_request'):   ?>
						
						<span class="feed_item_username"><?php echo $subject->displayname;?></span>  has requested a meeting against the property <a href="scheduler/meetings/requests"><?php echo $notification->params['property'] ; ?> </a>
												
                        <?php elseif($notification->type == 'package_renewal_remainder'):   ?>
						
						<span class="feed_item_username"></span>You have only <?php echo $notification->params['day_diif'] ; ?> days remains to expire your package. 

                        <?php elseif($notification->type == 'package_renewal'):   ?>
						
						<span class="feed_item_username"></span>Your package has been successfully renewed.
						
                        <?php elseif($notification->type == 'backgroundreport_remainder_during_lastweek'):   ?>
						
						<span class="feed_item_username"></span>You have only few days remaining to expire your background report.
						
						<?php elseif($notification->type == 'comment_notification_to_renter'):  ?>
						
						<span class="feed_item_username"><?php echo $subject->displayname;?></span> has replied to your comment on property <a href="property/<?php echo $notification->params['pid']?>"><?php echo $notification->params['pname'] ; ?> </a>
						 
						<?php elseif($notification->type == 'comment_notification_to_pOwner'):  ?>
						
						<span class="feed_item_username"><?php echo $subject->displayname;?></span> has commented on your property <a href="property/<?php echo $notification->params['pid']?>"><?php echo $notification->params['pname'] ; ?> </a>
			

						<?php else:?>
						 
						<?php echo $notification->__toString(); ?>
						 
						<?php endif;?>
						 
						 
					</div>

					<div class="ynadvmenu_postIcon activity_icon_status notification_type_<?php echo $notification->type ?>"> 
						<span class="timestamp"> <?php echo $this->timestamp($notification->date)?> </span> 
					</div>
				</div>
			</div>
			</li>
<?php } catch( Exception $e ) {
            ob_end_clean();
            if( APPLICATION_ENV === 'development' ) 
            {
              //echo $e->__toString();
            }
            continue;
          }
          ob_end_flush();
endforeach; ?>
