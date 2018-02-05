<?php 
      $viewer = Engine_Api::_()->user()->getViewer();
	  date_default_timezone_set($viewer->timezone);
?>
<script src="/application/modules/User/externals/scripts/message_notififaction.js">
<script type="text/javascript">

  /*var notificationPageCount = <?php echo sprintf('%d', $this->notifications->count()); ?>;
  var notificationPage = <?php echo sprintf('%d', $this->notifications->getCurrentPageNumber()); ?>;
  var loadMoreNotifications = function() {
    notificationPage++;
    new Request.HTML({
      'url' : en4.core.baseUrl + 'ynresponsive1/index/pulldown',
      'data' : {
        'format' : 'html',
        'page' : notificationPage
      },
      'onComplete' : function(responseTree, responseElements, responseHTML, responseJavaScript) {
        $('notifications_loading_main').setStyle('display', 'none');
        if( '' != responseHTML.trim() && notificationPageCount > notificationPage ) {
          $('notifications_viewmore').setStyle('display', '');
        }
        $('notifications_main').innerHTML += responseHTML;
      }
    }).send();
  };
  en4.core.runonce.add(function(){
    if($('notifications_viewmore_link')){
      $('notifications_viewmore_link').addEvent('click', function() {
        $('notifications_viewmore').setStyle('display', 'none');
        $('notifications_loading_main').setStyle('display', '');
        loadMoreNotifications();
      });
    }

    if($('notifications_markread_link_main')){
      $('notifications_markread_link_main').addEvent('click', function() {
        $('notifications_markread_main').setStyle('display', 'none');
        en4.activity.hideNotifications('<?php echo $this->translate("0 Updates");?>');
      });
    }
    
    $('notifications_main').addEvent('click', function(event){
        event.stop(); //Prevents the browser from following the link.
        var current_link = event.target;
        var notification_li = $(current_link).getParent('li');
        if(current_link.get('href')){
          en4.core.request.send(new Request.JSON({
            url : en4.core.baseUrl + 'ynresponsive1/index/markread',
            data : {
              format     : 'json',
              'actionid' : notification_li.get('value')
            },
            onSuccess : window.location = current_link.get('href')
          }));
        }
    });

  });*/
     
</script>

<div class='notifications_layout'>

  <div class=''>
	<div class="notification_head">
		<div class="notification_heading">
		<h3 class="sep">
		  <span><?php echo $this->translate("Your Notifications") ?></span>
		</h3>
		</div>
		<div class="notificaion_main_options"> 
			  
			<div class="notification_select_all">
				<input type="checkbox" class="ckbCheckAll" name="ckbCheckAll" value="1" style="margin-right: 3px;" id="checkbox_id"><label for="checkbox_id">Select All</label>
			</div>
			 <div class="notification_clear_all" >Clear</div>    
		</div>
		
		
    </div>
    <div class="msg" style="padding: 12px;color: #008000;"></div>
    <ul class='notifications' id="notifications_main">
      <?php if( $this->notifications->getTotalItemCount() > 0 ): ?>
        <?php  $userTable = Engine_Api::_()->getDbtable('users', 'user');
          foreach( $this->notifications as $notification ): 
          ob_start();
          try { 
          	$subject = $notification->getSubject(); ?>
          						
			<?php  $subjectData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $notification->subject_id)); 	?>	
					
            <li <?php if( !$notification->read ): ?> class = "ynadvmenu_Contentlist_<?php echo $notification->getIdentity();?> ynadvmenu_Contentlist_unread"<?php $this->hasunread = true; ?> <?php endif; ?> value="<?php echo $notification->getIdentity();?>" >
			<div class="check_field"><input type="checkbox" class="checkBoxClass" name="checkBoxClass" value="<?php echo $notification->getIdentity();?>"></div>

				<div class="content_info_div">
				
				<a title="<?php echo $subjectData->displayname; ?>" ><?php echo $this->itemPhoto($subject, 'thumb.icon');?></a>   
				<div class="ynadvmenu_ContentlistInfo">
					<div class="ynadvmenu_NameUser" id="content_<?php echo $notification->getIdentity();?>">

					
						<?php if($notification->type == 'document_request'):?>

						<span class="feed_item_username"><?php echo $subjectData->displayname;?></span>  has requested to access your document <a class="feed_item_username" title="View Document" href="/documents/requests"><?php echo $notification->params['label'];?></a>
						 
						<?php elseif($notification->type == 'document_request_approve'):?>
						
						<span class="feed_item_username"><?php echo $subjectData->displayname;?></span>  has approved your request for document  <a class="feed_item_username" title="View Document" href="/documents/sharedwithme"><?php echo $notification->params['label'];?></a>
						
						<?php elseif($notification->type == 'document_request_reject'):?>
						
						<a class="feed_item_username" title="View Profile" href="/profile/<?php echo $notification->subject_id; ?>"><?php echo $subjectData->displayname;?> </a>  has rejected your request for document <span class="feed_item_username"><?php echo $notification->params['label'];?></span>
						
						<?php elseif($notification->type == 'profile_rate'):?>
						
						<span class="feed_item_username"><?php echo $subjectData->displayname;?></span>  rated you on property <?php echo $notification->params['pname'];?> <a class="feed_item_username" title="View Rate" href="/rate/<?php echo $notification->subject_id;?>/<?php echo $notification->params['pid'];?>"><?php echo $notification->params['label'];?></a>
						
						<?php elseif($notification->type == 'document_share'):?>
						
						<span class="feed_item_username"><?php echo $subjectData->displayname;?></span>  has shared a new document <a class="feed_item_username" title="View Document" href="/documents/sharedwithme"><?php echo $notification->params['label'];?></a>

						<?php elseif($notification->type == 'matching_property'):?>
						
						<span class="feed_item_username"><?php echo $subjectData->displayname;?></span>  has added a new property that match with your requirement <a class="feed_item_username" title="View Property" href="/property/<?php echo $notification->params['pid'];?>"><?php echo $notification->params['label'];?></a>

						
						<?php elseif($notification->type == 'application_request'):?>
						
						<span class="feed_item_username"><?php echo $subjectData->displayname;?></span>  has sent application for your property <a class="feed_item_username" title="View Property" href="/propertyrequestslist"><?php echo $notification->params['label'];?></a>

					
						<?php elseif($notification->type == 'application_accept'):?>
						
						<!--<a class="feed_item_username" title="View Profile" href="/profile/<?php echo $notification->subject_id; ?>"><?php echo $subjectData->displayname;?> </a> has accepted your application for the property <a class="feed_item_username" title="View Property" href="/property/requests/approved"><?php echo $notification->params['label'];?></a>-->
                         Good news your application against property <a class="feed_item_username" title="View Property" href="/property/<?php echo $notification->params['pid'];?>"><?php echo $notification->params['label'];?></a> is being considered
					
						<?php elseif($notification->type == 'application_reject'):?>
						
                        Sorry, your application against property <a class="feed_item_username" title="View Property" href="/property/<?php echo $notification->params['pid'];?>"><?php echo $notification->params['label'];?></a> has been rejected

						<?php elseif($notification->type == 'report_request'): ?>
						
						<span class="feed_item_username"><?php echo $subjectData->displayname;?></span>  has requested  a report for the property <a class="feed_item_username" title="View Property" href="/property/requests"><?php echo $notification->params['label'];?></a>


                        <?php elseif($notification->type == 'application_review'): ?>
                         
                            <?php $propertyRequestTable =  Engine_Api::_()->getDbtable('propertyrequest', 'user');	 
                         
                            $propertyRequestData = $propertyRequestTable->fetchRow($propertyRequestTable->select()->where('id = ?', $notification->params['property_request_id']));
                         
								 if($propertyRequestData->landlord_approve == 0 && $propertyRequestData->application_view_status ==1 ):

								 ?>                         

							   	Your application for property <a class="feed_item_username" title="View Property" href="/property/"<?php echo $notification->params['pid']?>><?php echo $notification->params['label'];?></a> is under review 
							   <!--	<a class="feed_item_username" title="View Profile" href="/profile/<?php echo $notification->subject_id; ?>"><?php echo $subjectData->displayname;?> </a> your application for property <a class="feed_item_username" title="View Property" href="/property/"<?php echo $notification->params['pid']?>><?php echo $notification->params['label'];?></a> is under review -->

								<?php endif;?>
                        <?php elseif($notification->type == 'meeting_scheduler'): ?>
						
						<span class="feed_item_username"><?php echo $subjectData->displayname;?></span>  has scheduled a meeting with you on <a href="scheduler/meetings/requests"><?php echo $notification->params['scheduled_date'] ."  ".$notification->params['scheduled_time'];?></a>

                        <?php elseif($notification->type == 'scheduled_appoinment_remainder'): ?>
						
						<span class="feed_item_username"><?php echo $subjectData->displayname;?></span>  has scheduled a meeting with you on <a href="<?php echo $schedulerUrl;?>"><?php echo $notification->params['scheduled_date'] ;?></a>

                        <?php elseif($notification->type == 'survey_notification'): ?>
						
						<a class="feed_item_username" title="View Profile" href="/profile/<?php echo $notification->subject_id; ?>"><?php echo $subjectData->displayname;?> </a> has initiate survey with you 


                        <?php elseif($notification->type == 'share_report'): ?>
						
						<span class="feed_item_username"><?php echo $subjectData->displayname;?></span>  has shared a <a href="report/<?php echo $notification->params['user_id']?>">report</a>

                        <?php elseif($notification->type == 'approve_scheduler'): ?>
						
						<span class="feed_item_username"><?php echo $subjectData->displayname;?></span>  has approved your meeting request and your meeting scheduled on <a href="scheduler/meetings/joined"><?php echo $notification->params['scheduled_date'] ."  ".$notification->params['scheduled_time'];?> </a>

                        <?php elseif($notification->type == 'decline_meeting'): ?>
						
						<span class="feed_item_username"><?php echo $subjectData->displayname;?></span>  has declined your meeting request against the property <a href="scheduler/meetings"><?php echo $notification->params['pname'];?> </a>

                        <?php elseif($notification->type == 'property_granted'): ?>
						
						<span class="feed_item_username"><?php echo $subjectData->displayname;?></span>  has granted you, to  <?php echo $notification->params['rentaltype'] . " " .$notification->params['gender_of_propertyowner']." ";?>  property  <a href="property/<?php echo $notification->params['pid'];?>"><?php echo $notification->params['pname'];?> </a>

                        <?php elseif($notification->type == 'meeting_request'):  ?>
						
						<span class="feed_item_username"><?php echo $subjectData->displayname;?></span>  has requested a meeting against the property <a href="scheduler/meetings/requests"><?php echo $notification->params['property'] ; ?> </a>
						
                        <?php elseif($notification->type == 'package_renewal_remainder'):  ?>
						
						<span class="feed_item_username"></span> You have only <?php echo $notification->params['day_diif'] ; ?> days remains to expire your package. 
						
                        <?php elseif($notification->type == 'package_renewal'):  ?>
						
						<span class="feed_item_username"></span> Your package has been successfully renewed.
						
                        <?php elseif($notification->type == 'backgroundreport_remainder_during_lastweek'):  ?>
						
						<span class="feed_item_username"></span> You have only few days remaining to expire your background report.
						
                        <?php elseif($notification->type == 'comment_notification_to_renter'):  ?>
						
						<span class="feed_item_username"><?php echo $subjectData->displayname;?></span> has replied to your comment on property <a href="property/<?php echo $notification->params['pid']?>"><?php echo $notification->params['pname'] ; ?> </a>
						
                        <?php elseif($notification->type == 'comment_notification_to_pOwner'):  ?>
						
						<span class="feed_item_username"><?php echo $subjectData->displayname;?></span> has commented on your property <a href="property/<?php echo $notification->params['pid']?>"><?php echo $notification->params['pname'] ; ?> </a>
						
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
          <?php
          } catch( Exception $e ) {
            ob_end_clean();
            if( APPLICATION_ENV === 'development' ) {
              //echo $e->__toString();
            }
            continue;
          }
          ob_end_flush();
          endforeach;
        ?>
        
       
		
        
        
      <?php else: ?>
        <li>
          <?php echo $this->translate("You have no notifications.") ?>
        </li>
      <?php endif; ?>
    </ul>

    <div class="notifications_options">
      <?php /*if( $this->hasunread ): ?>
        <div class="notifications_markread" id="notifications_markread_main">
          <?php echo $this->htmlLink('javascript:void(0);', $this->translate('Mark All Read'), array(
            'id' => 'notifications_markread_link_main',
            'class' => 'buttonlink notifications_markread_link'
          )) ?>
        </div>
      <?php endif; */?>
      <?php if( $this->notifications->getTotalItemCount() > 10 ): ?>
        <div class="notifications_viewmore" id="notifications_viewmore">
          <?php echo $this->htmlLink('javascript:void(0);', $this->translate('View More'), array(
            'id' => 'notifications_viewmore_link',
            'class' => 'buttonlink icon_viewmore'
          )) ?>
        </div>
      <?php endif; ?>
      <div class="notifications_viewmore" id="notifications_loading_main" style="display: none;">
        <img src='application/modules/Core/externals/images/loading.gif' style='float:left; margin-right: 5px;' />
        <?php echo $this->translate("Loading ...") ?>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">

var notificationPage = <?php echo sprintf('%d', $this->notifications->getCurrentPageNumber()); ?>;
var notificationPageCount = <?php echo sprintf('%d', $this->notifications->count()); ?>;

      jQuery('#notifications_viewmore_link').on('click',function(){	
       jQuery('.notifications_viewmore').css('display', 'none');
       jQuery('#notifications_loading_main').css('display', '');
        loadMoreNotifications();

      });
  
   var loadMoreNotifications = function()
  {
	     notificationPage++;
         var url =    '/ynresponsive1/index/pulldown';
         var oData       = new Object();
         jQuery.ajax({
                        url:  url,
                        data: oData,
                        page : notificationPage,
                        dataType : 'html',
                        type: 'POST',
                        success: function (data) {console.log(data);
                        if(data) {
                          
							 jQuery('#notifications_loading_main').css('display', 'none');
							 if('' != data.trim() && notificationPageCount > notificationPage ){
								  jQuery('.notifications_viewmore').css('display', 'none');
							 }
                             jQuery('#notifications_main').append(data);
                           }
                          
                     },
                       error: function(e){   }
                 });
  }
    jQuery('body').on('click', '.content_info_div', function(event){

        //event.stop(); //Prevents the browser from following the link.
      var current_link = event.target;
      var notification_li = jQuery(current_link).closest('li');
      var id = jQuery(notification_li).attr('value');
      var url =    '/ynresponsive1/index/markread';
      var last_redirect_url = jQuery(notification_li).find('a:last').attr('href');
      var first_redirect_url = jQuery(current_link).find('a:last').attr('href');
      var oData       = new Object();

      oData.actionid = id;
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
    });

   jQuery(".ckbCheckAll").click(function () {
	  jQuery(".checkBoxClass").prop('checked', jQuery(this).prop('checked'));	 
   });
   
   jQuery('.notification_clear_all').on('click', function(event){
		 
		 var allVals = [];
		 var i;
		 jQuery("input[name=checkBoxClass]:checked").each(function() {
		   allVals.push(jQuery(this).val());
		 });
		 if(allVals.length == 0){
			 jQuery('.msg').html('Please select notifications to delete');
		 }
		 else{
		 		 
         var oData       = new Object();
         oData.notificatioIds   = allVals;
         var url =    '/ynresponsive1/index/clearnotifications';
		 console.log(allVals);
		 jQuery.ajax({
                        url:  url,
                        data: oData,
                        dataType: 'json',
                        type: 'POST',
                        success: function (data) {
						if(data.status == true){
							jQuery('.msg').html('You have successfully deleted the notifications.');
							for( i = 0; i<= allVals.length; i++){
								jQuery('.ynadvmenu_Contentlist_'+allVals[i]).css('display','none');
							}	
							location.reload();
                       }
                          
                     },
                       error: function(e){   }
                 });
                 
	}
		 
	 });
   </script>
