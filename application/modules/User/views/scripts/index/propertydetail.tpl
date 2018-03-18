<script src="<?php echo $this->baseUrl()?>/application/modules/User/externals/scripts/message_notififaction.js"></script>
<?php $viewer     = Engine_Api::_()->user()->getViewer();
 $viewerId=Engine_Api::_()->user()->getViewer()->getIdentity(); 
 $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
 
 $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
        if( !empty($fieldsByAlias['profile_type']) ){
              $optionId        = $fieldsByAlias['profile_type']->getValue($viewer);
              $profile_type_id = $optionId->value;
        }
 
 $userTable = Engine_Api::_()->getDbtable('users', 'user');
 $postcommentTable      =  Engine_Api::_()->getDbtable('Postcomments', 'user');

//echo '<pre>'; print_r($this->postcommentData); exit;
 
 ?>

<div class="generic_layout_container layout_main">
<div class="property_owner_maindiv">
<div class="property_owner_div">	
<div class="property_owner_img">
<?php echo $this->htmlLink($this->landlordUser->getHref(), $this->itemPhoto($this->landlordUser, 'thumb.icon', $this->landlordUser->getTitle()), array('title'=>$this->landlordUser->getTitle())) ?>
</div>
<div class="scrolling-row-intro player-info">
			<span class="vcard">				
				<span class="url">
					<?php echo $this->htmlLink($this->landlordUser->getHref(), ucwords($this->landlordUser->getTitle())) . " : Landlord"?>			
				</span>
				<span class="meta locality">
					USA , <?php echo $this->landlordUser->state; ?>,  <?php echo $this->landlordUser->city; ?>					
				</span>
				<span class="property-prompt">
				Property : <?php echo $this->propertycount; ?>
				</span>
				<?php /*<span class="property-prompt">
				Units : <?php echo $this->propertyData->UnitNumber; ?>
				</span> */?>
        </span>			
		</div>		
<div style="float: left;margin-left: 12px;">
<span class="efg efgh"><img src="/application/modules/User/externals/images/bedroom.png"></span> <span class="abc"> <?php echo $this->propertyData->no_of_rooms;?> Bedroom</span>
<span class="efg"><img src="/application/modules/User/externals/images/apartments.svg"></span> <span class="abc"> <?php echo $this->propertyData->housing_type;?></span>

                        <?php if($this->propertyData->has_pets == 'No'):?>
						<span class="efg efgh"><img src="/application/modules/User/externals/images/nopet.png"></span> <span class="abc">No Pets</span>
						<?php else:?>
						<?php if($this->propertyData->pets_type == 'Dogs'):?>
						<span class="efg"><img src="/application/modules/User/externals/images/dog.svg"></span> <span class="abc">Dog</span>
						<?php elseif($this->propertyData->pets_type == 'Cats'):?>
						<span class="efg"><img src="/application/modules/User/externals/images/cat.svg"></span> <span class="abc">Cat</span>
						<?php elseif($this->propertyData->pets_type == 'Cats & Dogs'):?>
						<span class="efg"><img src="/application/modules/User/externals/images/catndog.png"></span> <span class="abc">Cats & Dogs</span>
						<?php elseif($this->propertyData->pets_type == 'Birds'):?>
						<span class="efg"><img src="/application/modules/User/externals/images/bird.svg"></span> <span class="abc">Birds</span>
						<?php elseif($this->propertyData->pets_type == 'Small pets'):?>
						<span class="efg"><img src="/application/modules/User/externals/images/tortoise.svg"></span><span class="abc">Small pets</span> 
						<?php endif;?>
						<?php endif;?>
<span class="abc efg"> <img src="/application/modules/User/externals/images/price.png"><?php echo $this->propertyData->price;?></span><span class="efg"></span> 
<?php  if($this->propertyData->vouchers	=='Yes'):?>
<span></span><span class="efg">Voucher</span> 
<?php endif;?>
</div>		
</div>
</div>	
<div class="generic_layout_container layout_middle">
<div class="generic_layout_container layout_user_profile_status">
<div id="profile_status">
 <div class="property_status">	
  <span style="font-size: 26px;">
     <?php echo $this->propertyData->property_name;?>	
  </span>  
  <div>
 <?php if($this->propertyData->view_count !=0):?>
 <img src="/application/modules/User/externals/images/view.svg" title="views" style="margin-right: 7px;width: 17px;"><a><?php echo  $this->propertyData->view_count;?> views</a>
 <?php endif;?>   
 <!-- <img src="/application/modules/User/externals/images/like.svg" title="views" style="margin-right: 7px;width: 14px;"><a href="javascript:void(0);"><?php //echo  $this->action->likes()->getLikeCount();?> likes</a>-->
  <img src="/application/modules/User/externals/images/comments.svg" title="views" style="margin-right: 7px;width: 14px;"><a href="javascript:void(0);" class="commentcount"><?php echo $this->commentcount; ?><?php  if($this->commentcount > 1): echo " comments" ;else: echo " comment"; endif;  ?></a> 
 </div>
 </div>
 <div style="float: right;margin-top: 12px;"> 
<?php if($viewerId):?>
<?php if($this->propertyData->property_owner_id== $viewerId || $this->is_from_admin  == 1):?>
<span  class="edit_property" data-action ='edit' data-property="<?php echo $this->propertyData->id;?>" title="Edit"><img src="/application/modules/User/externals/images/edit_new.png"></span>
<span  class="delete_property" title="Delete" data-toggle="modal" data-target="#propertyDeleteModal"><img src="/application/modules/User/externals/images/property_delete.png" width="26px" height="26px"></span>

<?php endif;?>
<?php if($this->propertyData->property_owner_id== $viewerId): ?>
<?php if($this->propertyData->landlord_enable == 0):?>
<span class="enable_property_span_<?php echo $this->propertyData->id;?>"><span  class="btn_property_enable" data-toggle="modal" data-target="#enablePropertyModal" data-property="<?php echo $this->propertyData->id;?>" title="Disabled"><img src="/application/modules/User/externals/images/DISABLE_red.png"></span></span>
<?php else:?>
<span class="enable_property_span_<?php echo $this->propertyData->id;?>"><span  class="btn_property_disable" data-property="<?php echo $this->propertyData->id;?>" title="Enabled" data-toggle="modal" data-target="#disablePropertyModal"><img src="/application/modules/User/externals/images/ABLE.png"></span></span>
<?php endif;?>
<?php endif;?>
<?php endif;?>
</div>
</div>
</div>
<div class="property_list_content">
<div>
	<p align="justify" style="text-indent: 30px"><?php echo $this->propertyData->description;?></p>	
</div>
<div class="generic_layout_container layout_core_container_tabs">
<div class="tabs_alt tabs_parent">
  <ul id="main_tabs">
   <!-- <li class="active"><a id="acomments" href="javascript:void(0);"></a></li>-->
        <li><a id="photos" href="javascript:void(0);" class="active">Photos</a></li>
        <li><a id="videos" href="javascript:void(0);">Videos</a></li>
        <li><a id="comments" href="javascript:void(0);">Comments</a></li>
          </ul>
</div>
</div>
<div class="image_list">
<?php foreach ($this->propertyImageData as $propertyImage ):?>
<span><a class="example-image-link" href="<?php echo $this->baseUrl().'/'.$propertyImage['image'];?>" data-lightbox="image1"><img src= <?php echo $this->baseUrl().'/'.$propertyImage['image'];?> title="View Image" width ="190px" height="150px"></a></span>

<?php endforeach;?>
</div>
<div class="video_list" style="display:none">
<?php if(count($this->propertyVideoData)>0) : 
foreach($this->propertyVideoData as $videos):?>
<?php if($videos['storage_path']):
$image_file_id	=	$videos['file_id'] + 1;
$imglocation = Engine_Api::_()->storage()->get($image_file_id, 'storage')->getHref(); 
endif;
?>

<div id="videoElement_<?php echo $videos['file_id'];?>"></div>
<script type="text/javascript">	
	
var playerInstance = jwplayer("videoElement_<?php echo $videos['file_id'];?>");
playerInstance.setup({
	image: "<?php echo $this->baseUrl().$imglocation;?>",
	file: "<?php echo $this->baseUrl().'/'.$videos['storage_path'];?>",
	width: 205,
	height: 199
});
</script>
<?php endforeach;?>
<?php else: ?>
<div style="text-align: center;margin-top: 48px;">No videos</div>
<?php endif; ?>
</div>

<div class="comment_list" style="display:none">
	<div class="commentpost_area feed_comment_post feed_comment_post_<?php echo $this->propertyData->id?>" style="margin-bottom: 12px;">
	<form>
	<textarea class="feed_comment_body feed_comment_body_<?php echo $this->propertyData->id;?>" style="width: 100%;"></textarea>
	<input type="button" value="Post" class="comment_post_btn" status="<?php echo 'post_comment' ?>" propertyid= "<?php echo $this->propertyData->id;?>" action_id="<?php echo $this->propertyData->id;?>" viewer_id="<?php echo $viwer_id ;?>" actionSubjectId = "<?php echo $this->propertyData->property_owner_id;?>">
		<span class="loader loader_<?php echo $this->propertyData->id;?>" style="display:none;width:56px; height:55px;    margin: 0;"></span>

	</form>

	</div>
	<div class="comments">
	<ul class="comment_ul comment_ul_<?php echo $this->propertyData->id; ?>">
	<?php if(count($this->postcommentData) > 0):?>
   <?php foreach($this->postcommentData  as $commentData):?>
   
    <?php $commentedUserData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $commentData['posterId'])); ?>

   <?php if(!empty($commentedUserData)) : ?>

   	<li class="comment_li comment_li_<?php echo $commentData['commentId'] ;?>">
	<div class="comment_auther_photo">
		<?php echo $this->htmlLink($commentedUserData->getHref(), $this->itemPhoto($commentedUserData, 'thumb.icon', $commentedUserData->getTitle()), array('title'=>$commentedUserData->getTitle())) ?>
	</div>
	<div class="comments_info">
	<span class="comments_author"><a href="<?php echo $this->baseUrl().'/profile/'.$commentData['posterId'] ?>"><?php echo $commentedUserData->getTitle();?></a></span>
	<span class="comment_content"><?php echo $commentData['body'];?></span>
	<div class="comment_timestamp" comment_time="<?php echo $commentData['created_at']; ?>"><?php echo $this->timestamp($commentData['created_at']); ?></div>
	<?php if(($viwer_id == $commentData['posterId'])): ?>
	<span class="delete_feed_comment"  data-toggle="modal" data-target="#DeletecommentModal" comment_id="<?php echo $commentData['commentId'] ?>" action_id="<?php echo $data['action_id']; ?>" poster_id="<?php echo $commentData['posterId'] ?>">
	<a href="javascript:void(0)">Delete</a>
	</span>            
	<?php endif;?>
</div>
   </li>
   <?php endif;?>
   <?php endforeach;?>
   <?php else:?>
   <div style="text-align:center;">No Comments</div>
   <?php endif;?>
   <?php  
	 $allpostcommentData = $postcommentTable->fetchAll($postcommentTable->select()
	 ->where('actionId = ?',$this->propertyData->id )
	  ->order('commentId DESC'));
	 $comment_count= count($allpostcommentData);  
   ?>
<?php if( $comment_count > 2): ?>
   <div class="feed_view_comment">
		 <a href="javascript:void(0)" class="comments_Load_more comments_Load_more_<?php echo $this->propertyData->id; ?>" action_id="<?php echo $this->propertyData->id; ?>" status="<?php echo 'view_more' ?>">View more</a>
   </div>
<?php endif;?>	
   </ul>
  </div> 
</div>

<?php if($viewerId): ?>
<?php if($this->is_granted == 0):?>
<?php if( $profile_type_id == 1):?>
<?php if($this->is_property_approved == 1):?>
<?php if($this->is_Requested == 0 ):?>
	<?php if($this->isSmartmoveRenter == 1):?>
		<?php if( $this->isOneTimeApplicationCreatedUser  == 1):?>
		<div class="property_rqst_div"><button class="btn_property_detail property_rqst_btn">Submit Application</button></div>
		<?php else:?>
		<div class="property_rqst_div"><button class="btn_property_detail property_rqst_btn" data-toggle="modal" data-target="#onetimeApplicationModal">Submit Application</button></div>
		<?php endif;?>
	<?php else:?>
	<div class="property_rqst_div"><button class="btn_property_detail" data-toggle="modal" data-target="#SmartmoverenterModal">Submit Application</button></div>
	<?php endif;?>
<?php else:
if($this->is_request_approved == 0):?>
<div class="property_rqst_div"><button class="btn_property_detail">Waiting for approval</button></div>
<?php elseif($this->is_request_approved == 2):?>
<div class="property_rqst_div"><button class="btn_property_detail">Rejected application request</button></div>
<?php else:?>
<div class="property_rqst_div"><button class="btn_property_detail">Application under review</button></div>
<?php endif;?>
<?php endif;?>
<?php endif;?>
<div class="message" style='color:red'></div>
<?php endif;?>

<?php else:?>
<?php if($viewerId == $this->propertyData->property_owner_id):?>
<div class="complete_btn_div"><button class="complete_btn" data-toggle="modal" data-target="#completePropertyModal">Complete <?php echo $this->propertyData->rental_type;?></button></div>
<?php else:?>
<?php if($viewerId == $this->property_granted_tenent->user_id):?>
<div class="grant_btn_div"><button class="granted_btn">Rented to You </button></div>
<?php else:?>
<div class="grant_btn_div"><button class="granted_btn">Already Rented</button></div>
<?php endif;?>
<?php endif;?>
<?php endif;?>
<?php endif;?>
<div class="loader" style="display:none;"></div>
<hr style="clear: both;">
</div>
</div>
</div>
</div>
</div>
<!-- Modal -->

<div class="modal fade" id="propertyDeleteModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <span class="modal-title" id="exampleModalLabel">Delete Property</span>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
       <div class="modal-body">

          Do you want to delete this property?      

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary yes_btn yes_delete_property">Yes</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="enablePropertyModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <span class="modal-title" id="exampleModalLabel">Confirm</span>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
       <div class="modal-body">

          Are you sure you want to Enable this property?
       <input type="hidden" value="" id="prty_id">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary yes_btn btn_enable" data-dismiss="modal">Yes</button>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="disablePropertyModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <span class="modal-title" id="exampleModalLabel">Confirm</span>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
       <div class="modal-body">

         Are you sure you want to Disable this property?
         
         <input type="hidden" value="" id="prty_id">
   
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary  yes_btn btn_disable " data-dismiss="modal">Yes</button>
      </div>
    </div>
  </div>
</div>


<div class="modal fade" id="completePropertyModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <span class="modal-title" id="exampleModalLabel">Confirm</span>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
       <div class="modal-body">
        <?php if($this->is_granted == 1):?>	 
        
         Are you sure you want to complete  property <?php echo $this->propertyData->rental_type;?> of  <?php echo $this->property_granted_tenent->displayname;?> ?
         
        <?php endif;?>
   
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary  yes_btn yes_complete " data-dismiss="modal">Yes</button>
      </div>
    </div>
  </div>
</div>
<!-- popup ------>
<div id="light2" class="white_content">
	
<div class="pop_up_title"><div class="div_attachment_title">Confirm</div><div class="div_attachment_cancel"><img src="/application/modules/User/externals/images/GREYcancel.png"></div></div>
<div class="popup_content">
<?php if($this->is_granted == 1):?>		
<div class="confirm_text">Are you sure you want to complete  property <?php echo $this->propertyData->rental_type;?> of  <?php echo $this->property_granted_tenent->displayname;?> ?</div>
<?php endif;?>
<div class="confirm_btns" style="text-align: left;">
<span class="confirm_btns"><button class="yes_btn yes_complete" style="width: 134px;">Yes</button></span> 
</div>
</div>
</div>
</div>

<!-- delete popup ------>
<div id="light3" class="white_content">

<div class="pop_up_title"><div class="div_attachment_title">Delete property</div><div class="div_attachment_cancel"><img src="/application/modules/User/externals/images/GREYcancel.png"></div></div>
<div class="popup_content">
<div>
<div style="margin-bottom: 12px;">Do you want to delete this property?</div>	

<div class="confirm_btns" style="text-align: left;">
<span class="confirm_btns"><button class="yes_delete_property" style="width: 134px;">Yes</button></span>

</div>
</div>
</div>
</div>


<div id="light" class="white_content">
<div class="pop_up_title"><div class="div_attachment_title">Confirm</div><div class="div_attachment_cancel"><img src="/application/modules/User/externals/images/GREYcancel.png"></div></div>
<div class="popup_content">	
	
<div class="confirm_text">Are you sure you want to Enable this property?</div>
<div class="confirm_btns" style="text-align: left;"><span class="confirm_btns"><button class="yes_btn btn_enable" style="width: 134px;">Yes</button><button class="no_btn" style="width: 134px;">No</button></span> 
<input type="hidden" value="" id="prty_id">

</div>
</div>
</div>
</div>

<div id="light1" class="white_content" >
	
<div class="pop_up_title"><div class="div_attachment_title">Confirm</div><div class="div_attachment_cancel"><img src="/application/modules/User/externals/images/GREYcancel.png"></div></div>
<div class="popup_content">	
<div class="confirm_text">Are you sure you want to Disable this property?</div>
<div class="confirm_btns" style="text-align: left;">
<span class="confirm_btns"><button class="yes_btn btn_disable" style="width: 134px;">Yes</button><button class="no_btn" style="width: 134px;">No</button></span> 
</div>
</div>
</div>
</div>

<!-- popup ------>
<div id="fade" class="black_overlay"></div>
<script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/scripts/lightbox-plus-jquery.min.js"></script>
<script>jQuery.noConflict();</script>

<script type="text/javascript">
	
var viewer_identity='<?php echo $viwer_id; ?>';

jQuery( ".property_rqst_btn" ).click(function() {	
	jQuery('.property_rqst_btn').hide(); 
	jQuery(".loader").css("display", "block");
	var property_id = '<?php echo $this->propertyData->id;?>';
	var owner_id    = '<?php echo $this->propertyData->property_owner_id?>';
	var property_name = '<?php echo $this->propertyData->property_name;?>';	
	var oData       = new Object();
	oData.property_id         = property_id;   
	oData.landlord_id         = owner_id;   
	oData.property_name       = property_name;   
	var url	=	'<?php echo $this->baseUrl()?>'+ '/user/index/submitapplication';
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {
						 if(data.status == true){
							  location.reload();
	                     }        
					 },
					   error: function(e){  }  
					}); 
	
});
jQuery( ".yes_onetimeApplication" ).click(function() {	
	jQuery('.property_rqst_btn').hide(); 
	jQuery(".loader").css("display", "block");
	location.href = '<?php echo $this->baseUrl()?>' + '/rentalapplication/create';
});
jQuery( ".yes_smartmoverenter" ).click(function() {	
	jQuery('.property_rqst_btn').hide(); 
	jQuery(".loader").css("display", "block");
	location.href = '<?php echo $this->baseUrl()?>' + '/renter/create';
});
jQuery('body').on('click', '.btn_property_enable', function(event){

	var property_id = jQuery(this).attr('data-property');
	jQuery('#prty_id').val(property_id);

});
	jQuery('body').on('click', '.btn_enable', function(event){  
    document.getElementById('light').style.display='none';
	document.getElementById('fade').style.display='none'; 	
	var property_id = jQuery('#prty_id').val(); 
	var property_id = '<?php echo $this->propertyData->id;?>'; 
	
	var oData       = new Object();
    oData.property_id       = property_id;    
    var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>'+ '/user/index/enableproperty';
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {
					
                            jQuery( ".enable_property_span_"+property_id ).html('<span class="btn_property_disable" title="Enabled" data-property="'+property_id+'" data-toggle="modal" data-target="#disablePropertyModal"><img src="/application/modules/User/externals/images/ABLE.png"></button>');                    
                                
					 },
					   error: function(e){  }  
					}); 
  jQuery('#prty_id').val(''); 
});


jQuery('body').on('click', '.btn_property_disable', function(event){
	var property_id = jQuery(this).attr('data-property');
	jQuery('#prty_id').val(property_id);
});


jQuery('body').on('click', '.btn_disable', function(event){
	document.getElementById('light1').style.display='none';
	document.getElementById('fade').style.display='none'; 
	
	var property_id = jQuery('#prty_id').val();
	var property_id = '<?php echo $this->propertyData->id;?>'; 
	var oData       = new Object();
    oData.property_id       = property_id;
    
    var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/disableproperty';
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {
					
                            jQuery( ".enable_property_span_"+property_id ).html('<span class="btn_property_enable" title="Disabled" data-property="'+property_id+'" data-toggle="modal" data-target="#enablePropertyModal"><img src="/application/modules/User/externals/images/DISABLE_red.png"></span');                    
                                
					 },
					   error: function(e){  alert('Error: '+e);  }  
					}); 
  jQuery('#prty_id').val(''); 
});

jQuery('body').on('click', '.edit_property', function(event){	
	var property_id = jQuery(this).attr('data-property'); 
	var host	=	window.location.host;
	var url	=	'<?php echo $this->baseUrl()?>' + '/property/edit/'+property_id;
	location.href= url;
	
});

jQuery('body').on('click', '.yes_delete_property', function(event){
	var property_id = '<?php echo $this->propertyData->id;?>'; 
	var action_id = '<?php echo $this->propertyData->action_id;?>'; 
	
    var oData       = new Object();
    oData.property_id       = property_id;
    oData.action_id         = action_id;
    
    var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/deleteproperty';
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {
						if(data.status == true){							
							  var url	=	'<?php echo $this->baseUrl()?>' + '/myproperties'; 
							  location.href=url; 
						}
         
					 },
					   error: function(e){  alert('Error: '+e);  }  
					}); 
	
});

jQuery('body').on('click', '.no_btn', function(event){
	jQuery('#prty_id').val('');

	document.getElementById('light').style.display='none';
	document.getElementById('light1').style.display='none';
	document.getElementById('fade').style.display='none';
});

jQuery('#videos').on('click',function(){
	jQuery('#photos').removeClass('active');
	jQuery('#comments').removeClass('active');
	jQuery('#videos').addClass('active');
	jQuery('.video_list').css('display','block');
	jQuery('.image_list').css('display','none');
	jQuery('.comment_list').css('display','none');
});
jQuery('#comments').on('click',function(){
	jQuery('#photos').removeClass('active');
	jQuery('#videos').removeClass('active');
	jQuery('#comments').addClass('active');
	jQuery('.video_list').css('display','none');
	jQuery('.image_list').css('display','none');
	jQuery('.comment_list').css('display','block');
});

jQuery('#photos').on('click',function(){
	jQuery('#photos').addClass('active');
	jQuery('#videos').removeClass('active');
	jQuery('#comments').removeClass('active');
	jQuery('.image_list').css('display','block');
	jQuery('.video_list').css('display','none');
	jQuery('.comment_list').css('display','none');
});

jQuery('body').on('click', '.div_attachment_cancel', function(event){
	
	document.getElementById('light').style.display='none';
	document.getElementById('light1').style.display='none';
	document.getElementById('light2').style.display='none';
	document.getElementById('light3').style.display='none';
	document.getElementById('fade').style.display='none';
	
});

jQuery('body').on('click', '.yes_complete', function(event){
	
    var property_id = '<?php echo $this->propertyData->id;?>'; 
    var oData       = new Object();
    oData.property_id       = property_id;
    
    var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/completegrantedproperty';
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {
						 
						if(data.status == true){
							document.getElementById('light2').style.display='none';
	                        document.getElementById('fade').style.display='none';
							jQuery('.complete_btn_div').html('');						 
						}
         
					 },
					   error: function(e){    }  
					}); 	
});
    jQuery('body').on('click', '.comments_Load_more', function(event){

    var action_id =parseInt(jQuery(this).attr('action_id'));
    var status =jQuery(this).attr('status');
    var oData           = new Object();
    var status          = oData.status =status;
    var action_id       = oData.action_id =action_id;
    if(jQuery( ".comments_Load_more").hasClass("comments_Load_more_"+action_id)){

    var formURL    = '<?php echo $this->baseUrl(); ?>' + '/user/index/viewcomments';

    jQuery.ajax( {
                        url : formURL,
                        type: "POST",
                        dataType: 'json',
                        data : oData,
                        success: function (data) {

                            jQuery('.comment_ul_'+action_id+'').html(data.html);
                        },
                            error: function(e){

                        }
        });
    }
   });
jQuery('body').on('click', '.comments_Less', function(event){

    var action_id =parseInt(jQuery(this).attr('action_id'));
    var status =jQuery(this).attr('status');
    var oData           = new Object();
    var status   = oData.status =status;
    var action_id    = oData.action_id =action_id;
    jQuery('.comments_Load_more_'+action_id).remove();
    var formURL    = '<?php echo $this->baseUrl(); ?>' + '/user/index/viewcomments';
    jQuery.ajax( {
                        url : formURL,
                        type: "POST",
                        dataType: 'json',
                        data : oData,
                        success: function (data) {
                            jQuery('.comment_ul_'+action_id+'').html(data.html);
                        },
                            error: function(e){
                        }
    });

    });
jQuery('body').on('click', '.comment_post_btn', function(event){
	
    
	var isValidate = true;
    var action_id =parseInt(jQuery(this).attr('action_id'));
    var poster_id       =parseInt(jQuery(this).attr('viewer_id'));
    var actionSubjectId =parseInt(jQuery(this).attr('actionSubjectId'));
    var propertyid      =parseInt(jQuery(this).attr('propertyid'));
    jQuery('.comment_post_btn').css('display','none');
	jQuery('.loader_'+action_id).css('display','block');
    var oData              = new Object();
    var action_id          = oData.action_id =action_id;
    var poster_id          = oData.poster_id =poster_id;
    var actionSubjectId    = oData.actionSubjectId =actionSubjectId;
    var propertyid         = oData.propertyid =propertyid;
    
    jQuery( ".feed_comment" ).removeClass("show_comment");
    var feed_comment_body = jQuery('.feed_comment_body_'+action_id+'').val();
    if(feed_comment_body == ''){
		isValidate = false;
		jQuery('.loader_'+action_id).css('display','none');
        jQuery('.comment_post_btn').show();
	}
	if(isValidate  == true){
      var feed_comment_body    = oData.feed_comment_body =feed_comment_body;
      var formURL    = '<?php echo $this->baseUrl(); ?>' + '/user/index/postfeedcomment';
            jQuery.ajax( {
                        url : formURL,
                        type: "POST",
                        dataType: 'json',
                        data : oData,
                        success: function (data) {
                            jQuery('.comment_ul_'+action_id+'').html(data.html);
                            jQuery('.feed_comment_body_'+action_id+'').val('');
                            jQuery('.loader_'+action_id).css('display','none');
                            jQuery('.comment_post_btn').css('display','block');
                            },
                            error: function(e){
                        }
                    
       });

     }   
    });
jQuery('body').on('click', '.delete_feed_comment', function(event){
   var comment_id =parseInt(jQuery(this).attr('comment_id')); 
   var poster_id =parseInt(jQuery(this).attr('poster_id'));
   var action_id    = parseInt(jQuery(this).attr('action_id'));
   jQuery(".yes_delete_comment").attr("comment_id",comment_id);
   jQuery(".yes_delete_comment").attr("action_id",action_id);   
   });
   jQuery('body').on('click', '.yes_delete_comment', function(event){
	   var comment_id = parseInt(jQuery(this).attr('comment_id'));
	   var action_id  = parseInt(jQuery(this).attr('action_id'));
	   var oData           = new Object();
	   oData.comment_id    = comment_id;
	   var URL    = '<?php echo $this->baseUrl(); ?>' + '/user/index/deletecomment';

       jQuery.ajax( {
                        url : URL,
                        type: "POST",
                        dataType: 'json',
                        data : oData,
                        success: function (data) {
                         jQuery('#DeletecommentModal .close').trigger('click');
                         jQuery(".comment_li_"+comment_id+"").css('display','none');
                         var formURL        = '<?php echo $this->baseUrl(); ?>' + '/user/index/viewcomments';
                         var status         = "view_less";
                         oData.status       = status;
                         oData.action_id    = action_id;
                         jQuery.ajax( {
                                                url : formURL,
                                                type: "POST",
                                                dataType: 'json',
                                                data : oData,
                                                success: function (data) {
                                                jQuery('.comment_ul_'+action_id+'').html(data.html);
                                                 },
                                                    error: function(e){
                                                }
                            });
                         },
                            error: function(e){
                        }
         });
    });
    jQuery('body').on('click', '.commentcount', function(event){
		
		jQuery( "#comments" ).trigger( "click" );
		 jQuery('html, body').animate({
        'scrollTop' :jQuery(".comment_list").position().top
    });
		
	});
</script>
