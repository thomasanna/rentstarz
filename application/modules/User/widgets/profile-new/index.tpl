<?php
 $subject = Engine_Api::_()->core()->getSubject();
 $viewer = Engine_Api::_()->user()->getViewer();
 $viewHelperObj      =   $this->getHelper('ItemPhoto');
 $profile_menus = Engine_Api::_()
      ->getApi('menus', 'core')
      ->getNavigation('user_profile');
      
      
	$useragent=$_SERVER['HTTP_USER_AGENT'];

	$iPod = stripos($_SERVER['HTTP_USER_AGENT'],"iPod");
	$iPhone = stripos($_SERVER['HTTP_USER_AGENT'],"iPhone");
	$iPad = stripos($_SERVER['HTTP_USER_AGENT'],"iPad");
	$Android = stripos($_SERVER['HTTP_USER_AGENT'],"Android");
	$webOS = stripos($_SERVER['HTTP_USER_AGENT'],"webOS");
	$status = 'false';
	$viewer_id=$this->viewer()->getIdentity();
	//if(preg_match('/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino/i',$useragent)||preg_match('/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i',substr($useragent,0,4))){
	if( $iPod || $iPhone || $iPad || $Android)  {
		$dev_type= 1; // mobile

	}
	else{

		$dev_type= 2; // system
	}
$smartmoveHelperObj  = $this->getHelper('SmartmoveApi');
$StateArray          = $smartmoveHelperObj->getState();   
?>
<script src="/application/modules/User/externals/scripts/message_notififaction.js"></script>
<script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/scripts/jRating.jquery.js"></script>

<link rel="stylesheet" href="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/styles/new-profile.css">
<script>
<?php $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); ?>
var viewer_identity='<?php echo $viwer_id; ?>';
</script>
<!-- Page Container -->
<div class="newprofile-content newprofile-margin-top" style="max-width:1400px;">
  <!-- The Grid -->
  <div class="newprofile-row-padding">
    <!-- Left Column -->
    <div class="newprofile-third">
      <div class="newprofile-white newprofile-text-grey newprofile-card-4">
        <div class="newprofile-display-container">
           <div style=
           "display: block;
			margin: 0 auto;
			width: 146px;
			height: 161px;"       
           >        
		 <?php echo $this->itemPhoto($this->subject()) ?>
           <?php if($this->is_online == 1):?>
            <div class="led-green" style="top: unset;margin-left: 6px;position: absolute;float: left;z-index: 9;"></div>
            <?php endif;?>
              </div>

          <div class="newprofile-display-bottomleft newprofile-container newprofile-text-black">
            <h2><?php echo $this->subject()->getTitle() ?> 	   
            </h2>
            <?php if($this->subjectData->rating_value != '' && $this->subjectData->rating_value !=0):?>
            <?php if($this->subjectData->enable_rating_value == 1):?>
              <div style="float: left;" class="basic" data-average="<?php echo $this->subjectData->rating_value;?>" data-id="1" title="<?php echo $this->subjectData->rating_value;?>"></div>
                <script>
                jQuery('.basic').jRating();
                </script>
           <?php endif;?>
           <?php endif;?>
          </div>
        </div>
        <div class="newprofile-container">
          <p><i class="fa fa-briefcase fa-fw newprofile-margin-right newprofile-large newprofile-text-teal"></i>
          <?php if($this->profile_type_id == 1):?>
          Renter
          <?php endif;?>
          <?php if($this->profile_type_id == 4):?>
          Landlord
          <?php endif;?>
          <?php if($this->profile_type_id == 6):?>
          Services
          <?php endif;?>
          </p>
          <p><i class="fa fa-home fa-fw newprofile-margin-right newprofile-large newprofile-text-teal"></i><?php echo $this->userselectData->state?>, <?php echo $this->userselectData->city?></p>
        <?php if($this->profile_type_id == 1 && $this->creditscoreData->creditscore_view_status==1): ?>
        <?php
        $userTable = Engine_Api::_()->getDbtable('users', 'user');
        $viewer = Engine_Api::_()->user()->getViewer();
        $viewerId   =   $viewer->getIdentity();
        $creditscoreSelect   =   $userTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('user'=>'engine4_users',))
                        ->joinLeft(array('fields_value'=>'engine4_user_fields_values'),'fields_value.item_id=user.user_id',array('value'))
                        ->where('fields_value.field_id=?' , 16)
                        ->where('user.user_id=?' ,  $viewerId );
        $creditscoreData = $userTable->fetchRow($creditscoreSelect);
        ?>
        <?php if($creditscoreData->value !=''):?>
        <p><i class="fa fa-home fa-fw newprofile-margin-right newprofile-large newprofile-text-teal"></i>Credit Score: <?php echo $creditscoreData->value;?></p>
        <?php endif;?>
          <?php endif; ?>
          <?php if($subject->getIdentity() != $viewer -> getIdentity()): ?>
          <p uid="<?php echo $subject->getIdentity();?>" class="cometchat_chatwith" style="padding: 0px !important;"><i class="fa fa-envelope fa-fw newprofile-margin-right newprofile-large newprofile-text-teal"></i>Message</p>
          <?php endif;?>
          <?php if($this->profile_type_id == 4):?>
          <?php
           $propertyTable =  Engine_Api::_()->getDbtable('propertylist', 'user');
           $propertySelect   =   $propertyTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('plist'=>'engine4_property_list',))
                        ->where('plist.property_owner_id=?' , $subject->getIdentity())
                        ->where('plist.enable=?' , 1);
           $propertyData=$propertyTable->fetchAll($propertySelect);
           $total_properties = count($propertyData);
           $propertySelect   =   $propertyTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('plist'=>'engine4_property_list',))
                        ->where('plist.property_owner_id=?' , $subject->getIdentity())
                        ->where('plist.enable=?' , 1)
                        ->where('plist.granted=?' , 0);
           $propertyData=$propertyTable->fetchAll($propertySelect);
           $available_properties = count($propertyData);
          ?>
           <p><img src="/application/modules/User/externals/images/my_properties.svg" style="width: 22px;margin-right: 16px;">Total Units  : <?php echo $total_properties ; ?></p>
           <p><img src="/application/modules/User/externals/images/my_properties.svg" style="width: 22px;margin-right: 16px;">Availble Units  : <?php echo $available_properties ; ?></p>
          <?php endif;?>
          <?php if($subject->getIdentity() != $viewer -> getIdentity()): ?>
                <p><a href="javascript:void(0);" class="buttonlink reportuser" style="padding-left: 39px;background-image: url(application/modules/Core/externals/images/report.png)"  data-toggle="modal" data-target="#reportModal">Report</a></p>
                <?php if( $this->is_blocked == 0):?>
                <p><a href="javascript:void(0);" class="buttonlink blockmember" style="padding-left: 39px;background-image: url(application/modules/User/externals/images/block.png)"  data-toggle="modal" data-target="#blockmemberModal">Block Member</a></p>
                <?php endif;?> 
                <?php if( $this->is_blocked == 1):?>
                <p><a href="javascript:void(0);" class="buttonlink unblockmember" style="padding-left: 39px;background-image: url(application/modules/User/externals/images/block.png)"  data-toggle="modal" data-target="#unblockmemberModal">Unblock Member</a></p>
                <?php endif;?> 
          <?php /* foreach( $profile_menus as $link ): ?>

                        <?php if($link->getLabel() =='Block Member'):?>
                        <p class="profile_menus">
                          <?php echo $this->htmlLink($link->getHref(), $this->translate($link->getLabel()), array(
                            'class' => 'buttonlink' . ( $link->getClass() ? ' ' . $link->getClass() : '' ),
                            'style' => 'background-image: url('.$link->get('icon').');',
                            'target' => $link->get('target'),
                          )) ?>
                        </p>
                        <?php endif;?>
                        <?php endforeach; */?>
                             <?php
                                $profileNoPicInfo   =   $viewHelperObj->getNoPhoto($this->subject());
                                $type               =   'thumb.icon';
                                $safeName           =   ( $type ? str_replace('.', '_', $type) : 'main' );
                                $src                =   $this->subject()->getPhotoUrl($type);
                                if($src):
                                $src                =   $src;
                                else:
                                $src                =   $viewHelperObj->getNoPhoto($this->subject(),$safeName);
                                endif;
                                $status = 'false';
                                $popup_status 		=	'large_popUp';
                            ?>
                       <?php if($dev_type == 1):  $popup_status='mobile';// mobile?>     
                            <a href="<?php echo $this->baseUrl().'/tichat/singlechatmob'; ?>" target="_blank" onClick="popUpChatClick('<?php echo $subject->getIdentity() ?>','<?php echo $this->subject()->getTitle() ?>','<?php echo $src ?>','<?php echo $popup_status ?>')">
								<i class="fa fa-envelope fa-fw newprofile-margin-right newprofile-large newprofile-text-teal" aria-hidden="true"></i>Message</p>
							</a>
                       <?php else:?>
							
						<p class="hand-symbol" onClick="popUpChatClick('<?php echo $subject->getIdentity() ?>','<?php echo $this->subject()->getTitle() ?>','<?php echo $src ?>','<?php echo $popup_status ?>')">
                            <i class="fa fa-envelope fa-fw newprofile-margin-right newprofile-large newprofile-text-teal" aria-hidden="true"></i>Message</p>
                       <?php endif;?>      
            <?php endif;?>
             <?php if($this->profile_type_id == 4):?>
               <p><a href="/properties/<?php echo $subject->getIdentity() ?>" class="buttonlink properties" style="font-size: 13px; background-size: 21px;padding-left: 39px;background-image: url(application/modules/User/externals/images/my_properties.svg)">Properties</a></p>

             <?php endif;?>
          <hr>
          <br>
        </div>
      </div><br>
    <!-- End Left Column -->
    </div>
    <!-- Right Column -->
    <div class="newprofile-twothird">
      <div class="newprofile-container newprofile-card-2 newprofile-white newprofile-margin-bottom">
        <!--<h2 class="newprofile-text-grey newprofile-padding-16"><i class="fa fa-suitcase fa-fw newprofile-margin-right newprofile-xxlarge newprofile-text-teal"></i>Work Experience</h2>-->
        <div class="newprofile-container">
          <h5 class="newprofile-opacity"><b></b></h5>
          <div class="tabs_alt tabs_parent " style="display:block">
          <ul id="main_tabs">
            <li class="tab_541 tab_layout_user_profile_fields active"><a href="javascript:void(0);">Info</a></li>
            <?php if($subject->getIdentity() == $viewer -> getIdentity()): ?>
             <li><a href="members/edit/profile">Edit Profile</a></li>
             <?php if($this->profile_type_id == 4):?>            
             <li class="tab_layout_manage_subscription"><a href="manage/subscription">Manage Subscription</a></li>
             <?php endif;?>           
            <?php endif;?>
           <!-- <li class="tab_540 tab_layout_activity_feed "><a href="javascript:void(0);">Updates</a></li>   -->
          </ul>
          </div>
          <div class="profile_fields">
          <h2><i class="fa fa-certificate fa-fw newprofile-margin-right newprofile-xxlarge newprofile-text-teal"></i>Info</h2>
          <?php echo $this->content()->renderWidget('user.profile-fields'); ?>
          </div>

         <!-- <div class="profile_activity_feed" style="display:none">
          <h2 class="newprofile-text-grey newprofile-padding-16"><i class="fa fa-certificate fa-fw newprofile-margin-right newprofile-xxlarge newprofile-text-teal"></i>Updates</h2>
          <?php //echo $this->content()->renderWidget('activity.feed'); ?>
          </div>-->
            <hr>
        </div>
        </div>
         <div class="newprofile-container newprofile-card-2 newprofile-white" style="margin-top: 15px;">
        <div class="newprofile-container">
          <h5 class="newprofile-opacity"><b></b></h5>
          <h2 class="newprofile-padding-16"><i class="fa fa-certificate fa-fw newprofile-margin-right newprofile-xxlarge newprofile-text-teal"></i>Galleries</h2>
          <!--<h6 class="newprofile-text-teal"><i class="fa fa-calendar fa-fw newprofile-margin-right"></i>Forever</h6>-->
          <p></p>
          <?php echo $this->content()->renderWidget('user.gallery-new'); ?>
          <hr style="clear: both;">
        </div>
      </div>
      <!--<div class="newprofile-container newprofile-card-2 newprofile-white">
        <div class="newprofile-container">
          <h5 class="newprofile-opacity"><b></b></h5>
          <h2 class="newprofile-text-grey newprofile-padding-16"><i class="fa fa-certificate fa-fw newprofile-margin-right newprofile-xxlarge newprofile-text-teal"></i>Galleries</h2>
          <p></p>
          <?php // echo $this->content()->renderWidget('album.profile-albums'); ?>
          <hr>
        </div>
      </div>-->
      <div class="newprofile-container newprofile-card-2 newprofile-white" style="margin-top: 15px;">
        <div class="newprofile-container">
          <h5 class="newprofile-opacity"><b></b></h5>
          <h2 ><i class="fa fa-certificate fa-fw newprofile-margin-right newprofile-xxlarge newprofile-text-teal"></i>Documents</h2>
          <!--<h6 class="newprofile-text-teal"><i class="fa fa-calendar fa-fw newprofile-margin-right"></i>Forever</h6>-->
          <p></p>
          <?php echo $this->content()->renderWidget('user.profile-documents'); ?>
          <hr>
        </div>
      </div>
    <!-- End Right Column -->
    </div>
  <!-- End Grid -->
  </div>
  <!-- End Page Container -->
</div>

<!-- report modal start-->

<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content-new">
      <div class="modal-header">
        <span class="modal-title" id="exampleModalLabel"><a href="javascript:void(0)" target="_blank">Report</a></span>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">×</span>
        </button>
      </div>
       <div class="modal-body">
            <div class="message" style="color:#008000;padding: 0px 0px 8px 0px;display:block;"></div>
            <div class="err_msg" style="color:red"></div>
			<div class="matches_div">
			  Do you want to report this?
			  <div class="pro_field_wrapper">
			 <div class="prty_lablel pro_label">Type <span style="color:red;font-weight: bolder;">*</span></div>  
						<select name="reportCategory" id="reportCategory" class="prty_field reportCategory">
						<option value="">(select)</option>
						<option value="spam">Spam</option>
						<option value="abuse">Abuse</option>
						<option value="inappropriate">Inappropriate Content</option>
						<option value="licensed">Licensed Material</option>
						<option value="other">Other</option>
				       </select>
			  </div>   <br>
			  <div class="pro_field_wrapper" style="margin-bottom:5px;">
				<div class="prty_lablel pro_label" style="padding-bottom:12px;">Description <span style="color:red;font-weight: bolder;">*</span>  </div>
				<textarea class="prty_field reportDescription"></textarea>
		      </div>
			
       <div class="btn_div"><input class="submit_report" type="button" value="Submit Report" name=""></div>
      </div>
            <div class="loader" style="display:none"></div>
    </div>
  </div>
</div>
</div>

<!-- report modal end-->
<!-- block modal start-->

<div class="modal fade" id="blockmemberModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content-new">
      <div class="modal-header">
        <span class="modal-title" id="exampleModalLabel"><a href="javascript:void(0)" target="_blank">Block Member</a></span>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">×</span>
        </button>
      </div>
       <div class="modal-body">
            <div class="message" style="color:#008000;padding: 0px 0px 8px 0px;display:block;"></div>
            <div class="err_msg" style="color:red"></div>
			<div class="matches_div"  style="text-align: center;">
			  Do you want to block this member?			
			
       <div class="btn_div" style="padding-top: 12px;" style="text-align: center;"><input class="submit_blockmember" type="button" value="Block Member" name=""></div>
      </div>
      </div>
            <div class="loader" style="display:none"></div>
    </div>
  </div>
</div>


<!-- block modal end-->
<!-- block modal start-->

<div class="modal fade" id="unblockmemberModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content-new">
      <div class="modal-header">
        <span class="modal-title" id="exampleModalLabel"><a href="javascript:void(0)" target="_blank">Unblock Member</a></span>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">×</span>
        </button>
      </div>
       <div class="modal-body">
            <div class="message" style="color:#008000;padding: 0px 0px 8px 0px;display:block;"></div>
            <div class="err_msg" style="color:red"></div>
			<div class="matches_div">
			  Do you want to unblock this member?
			  <input type="hash" name="token" value="" id="token">
			
       <div class="btn_div" style="padding-top: 12px;"><input class="submit_unblockmember" type="button" value="Unblock Member" name=""></div>
      </div>
      </div>
            <div class="loader" style="display:none"></div>
    </div>
  </div>
</div>


<!-- block modal end-->







<script>
/*jQuery('body').on('click', '.tab_layout_activity_feed', function(event){
    jQuery('.tab_layout_activity_feed').addClass('active');
    jQuery('.tab_layout_user_profile_fields').removeClass('active');
    jQuery('.profile_activity_feed').css('display','block');
    jQuery('.profile_fields').css('display','none');
});
jQuery('body').on('click', '.tab_layout_user_profile_fields', function(event){
    jQuery('.tab_layout_user_profile_fields').addClass('active');
    jQuery('.tab_layout_manage_subscription').removeClass('active');
    jQuery('.profile_fields').css('display','block');
    jQuery('.manage_subscription').css('display','none');
});
jQuery('body').on('click', '.tab_layout_manage_subscription', function(event){
    jQuery('.tab_layout_manage_subscription').addClass('active');
    jQuery('.tab_layout_user_profile_fields').removeClass('active');
    jQuery('.profile_fields').css('display','none');
    jQuery('.manage_subscription').css('display','block');
});*/

jQuery('body').on('click', '.submit_report', function(event){
	
	var subjectId  = "<?php echo $subject->getIdentity();?>";
	var reporterId = "<?php echo $viewer->getIdentity();?>";
	var reportCategory     = jQuery('.reportCategory').val();
	var reportDescription  = jQuery('.reportDescription').val();
	var is_validate  = true;
	if(reportCategory == ""){
		jQuery('#reportModal .reportCategory').css('border-color','#e62828');  
		is_validate   = false;
	}
	else{
		jQuery('#reportModal .reportCategory').css('border-color','#b2c6cd'); 
		is_validate  = true;
	}
	if(is_validate == true){
		if(reportDescription == ""){
		jQuery('#reportModal .reportDescription').css('border-color','#e62828'); 
		is_validate   = false;
	    }
	    else{
		jQuery('#reportModal .reportDescription').css('border-color','#b2c6cd'); 
		is_validate  = true;
		}
	}
	if(is_validate == true ){
	var oData       = new Object();		
			oData.subjectId         = subjectId;	
			oData.reporterId        = reporterId;	
			oData.reportCategory    = reportCategory;	
			oData.reportDescription = reportDescription;	
			var url          = '<?php echo $this->baseUrl().'/user/index/reportuser' ?>';		
			jQuery.ajax({
				url:  url,
				data: oData,						
				dataType: 'json',
				type: 'POST',
				success: function (result) { console.log(result.html);
							if(result.status == true){
								jQuery('#reportModal .reportCategory').val(''); 
							    jQuery('#reportModal .reportDescription').val(''); 
								jQuery('#reportModal .message').html('Your report has been submitted');
								setTimeout(function(){
									  jQuery('#reportModal .message').html(''); 
							   }, 5000);
								
							}
									
				},
				error: function(e){ }  
			   });
		}
		
	});
	jQuery('body').on('click', '.submit_blockmember', function(event){
		var subjectId  = "<?php echo $subject->getIdentity();?>";
		var oData       = new Object();		
	    oData.subjectId         = subjectId;
	    var url          = '<?php echo $this->baseUrl().'/user/index/blockmember' ?>';		
			jQuery.ajax({
				url:  url,
				data: oData,						
				dataType: 'json',
				type: 'POST',
				success: function (result) { console.log(result.html);
							if(result.status == true){
                                jQuery('#blockmemberModal .matches_div').html(''); 
								jQuery('#blockmemberModal .message').html('Member blocked');
								setTimeout(function(){
									 location.reload();
							   }, 2000);
								
							}
									
				},
				error: function(e){ }  
			   });
	    
	});
	jQuery('body').on('click', '.submit_unblockmember', function(event){
		var subjectId  = "<?php echo $subject->getIdentity();?>";
		var oData       = new Object();		
	    oData.subjectId         = subjectId;
	    var url          = '<?php echo $this->baseUrl().'/user/index/unblockmember' ?>';		
			jQuery.ajax({
				url:  url,
				data: oData,						
				dataType: 'json',
				type: 'POST',
				success: function (result) { console.log(result.html);
							if(result.status == true){
                                jQuery('#unblockmemberModal .matches_div').html(''); 
								jQuery('#unblockmemberModal .message').html('Member unblocked');
								setTimeout(function(){
									 location.reload();
							   }, 2000);
								
							}
									
				},
				error: function(e){ }  
			   });
	    
	});
	

</script>
