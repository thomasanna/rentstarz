<script src="/application/modules/User/externals/scripts/message_notififaction.js"></script>
<script>
<?php $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); ?>

var viewer_identity='<?php echo $viwer_id; ?>';	
</script>
<?php
$useragent=$_SERVER['HTTP_USER_AGENT'];

$iPod = stripos($_SERVER['HTTP_USER_AGENT'],"iPod");
$iPhone = stripos($_SERVER['HTTP_USER_AGENT'],"iPhone");
$iPad = stripos($_SERVER['HTTP_USER_AGENT'],"iPad");
$Android = stripos($_SERVER['HTTP_USER_AGENT'],"Android");
$webOS = stripos($_SERVER['HTTP_USER_AGENT'],"webOS");
if( $iPod || $iPhone || $iPad || $Android)	{	
	$dev_type= 1; // mobile	
}
else{	
	$dev_type= 2; // system
}
$userid = $this->userid;  
$viewer     = Engine_Api::_()->user()->getViewer(); 
date_default_timezone_set($viewer->timezone);
?>

<div class="property_list_content property_requirement_lists generic_layout_container layout_middle">

<?php if(count($this->propertyRequirementData)>0):?>

	<?php foreach($this->propertyRequirementData as $data):?>
	 
	<div class="requirement_div requirement_div_<?php echo $data->id; ?>">
	<div class="feed_heading">
		<span><span class="timestamp"><?php echo $this->timestamp($data['created_at']); ?>	</span></span>
		<span class="feed_location">     
		<span>
			<?php if($data->prty_country !=''):?>
	        <?php if($dev_type == 1): // mobile?>
        <a href="<?php echo $this->baseUrl().'/property/requirement/map/'.$data->id ?>" target="_blank"><img src= "/application/modules/User/externals/images/LOCATION.png" style="margin-top: -4px;"></a>
        <?php else:?>
        <span class="location_icon" data-city= "<?php echo $data->prty_city;?>"  data-id ="<?php echo $data->id;?>" data-type= "<?php //echo $action->getTypeInfo()->type;?>" data-lat=<?php echo $data->latitude;?> data-lng= <?php echo $data->longitude;?>><img src= "/application/modules/User/externals/images/LOCATION.png" style="margin-top: -4px;"></span>
        <?php endif;?>
		<?php echo $data->prty_country." , ".$data->prty_state." , ".$data->prty_city ;?>     
       <?php endif;?>     </span>
	</div>
	<div class="requirement_li">	
	<div class="row">
	<div class="profile_image" style="float: left;padding: 0px 0px 0px 10px;">
	<?php 
    $userTable    = Engine_Api::_()->getDbtable('users', 'user');
    $userselect   =   $userTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('user'=>'engine4_users',))
                        ->joinLeft(array('search_field'=>'engine4_user_fields_search'),'search_field.item_id=user.user_id',null)
                        ->joinLeft(array('fields_value'=>'engine4_user_fields_values'),'fields_value.item_id=user.user_id',array('value'))
                        ->joinLeft(array('state'=>'engine4_state_list',),'state.state_id=search_field.field_76',array('state'))
                        ->joinLeft(array('city'=>'engine4_city_list',),'city.city_id=search_field.field_77',array('city'))
                        ->where('user.search=?' , 1)
                        ->where('user.enabled=?' , 1)
                        ->where('search_field.profile_type =?' , '1')
                        ->where('fields_value.field_id=?' , 13)
                        ->where('user.user_id = ?', $data['tenant_id'])
                        ->group('user.user_id');


	$userData = $userTable->fetchRow($userselect);

	$smartmoveapiRenters_table =  Engine_Api::_()->getDbtable('Smartmoveapirenters', 'user');   
							 
	$smartmoveapiRenters = $smartmoveapiRenters_table->fetchRow($smartmoveapiRenters_table->select()->where('tenant_id = ?', $data['tenant_id']));   	  

	if(!empty($smartmoveapiRenters)){									
				$isSmartmoveRenter = 1;
	}
	else{								
				$isSmartmoveRenter = 0;
	}
			
					     
	?>	
	 <?php echo $this->htmlLink($userData->getHref(), $this->itemPhoto($userData, '', array('class' => 'photo')),array('title'=>$userData->getTitle())) ?> 
	</div>
     
	<div class="col-md-6 col-sm-6 col-xs-6 " style="float: right;text-align:right">				
    <span class="edit_requirement" data-id="<?php echo $data->id;?>" title="Edit"><img src="/application/modules/User/externals/images/edit_new.png"></span>
	<span class="delete_requirement" title="Delete" requirement_id="<?php echo $data->id; ?>"  data-toggle="modal" data-target="#requirementDeleteModal"><img src="/application/modules/User/externals/images/property_delete.png" width="26px" height="26px"></span>
	</div>	
	</div>	
	<div class="row">
		<div class="col-md-4 col-sm-4 col-xs-12">
	<span class="verification" >
	                    <?php  if($userData->bg_verified == 1 && $isSmartmoveRenter== 0):?>
                          <span style="color: #00ff00; font-weight: bold;padding-left: 14px;">Verified</span>
                        <?php endif;?>
                        <?php  if($userData->bg_verified == 0 && $isSmartmoveRenter == 1):?>
                          <span style="color: #00ff00; font-weight: bold;padding-left: 14px;">Verified</span>
                        <?php endif;?>
                        <?php  if($userData->bg_verified == 0 && $isSmartmoveRenter == 0):?>
                          <span class="feed_notverified_span">Not Verified</span>
                        <?php endif;?>
                        <?php  if($userData->bg_verified == 1 && $isSmartmoveRenter == 1):?>
                          <span style="color: #00ff00; font-weight: bold;padding-left: 14px;">Verified</span>
                        <?php endif;?>			
    </span> 			

                <h2 class="vcard">
                <div class="hover-card-parent">
                <span class="url">
                <?php  $attribs = Array('title'=>'View Profile'); ?>
                <?php echo $this->htmlLink($userData->getHref(), ucwords($userData->getTitle()),$attribs) ?>
                </span>
                </div>
                <span class="meta locality">
                <?php   echo "USA" . " , ";  if($userData['state'] !=''):?><?php echo $userData['state']?>, <?php endif;?> <?php echo $userData ['city']   ?>
                </span>  </h2>
                                
               <div class="feed_rating" style="padding-bottom: 12px;">
                <?php if($userData->rating_value != '' && $userData->rating_value !=0): ?>
                <?php if($userData->enable_rating_value == 1):?>
                  <div style="float: left;" class="basic" data-average="<?php echo $userData->rating_value;?>" data-id="1" title="<?php echo $userData->rating_value;?>"></div>
                    <?php endif;?>
                <?php else:?>
                <div style="color: #f58410;font-weight: bold;">Not Rated</div>
                <?php endif;?>
                 </div>                                   
 </div>        
<div class="col-md-7 col-sm-8 col-xs-12">
 <?php echo $data['description'];?>
 </div>
</div>
<div  class="feed_filter_count_icons row" ><div class="col-md-12">
                    <?php if($data['vouchers']=='Yes'): ?>
                    <div class="voucher1" style="float:left;"><img src="/application/modules/User/externals/images/vochericon.jpg" width="25px" height="25px"></div>
                    <?php endif; ?>
                    <?php if($data['wheelchair_accessible']=='Yes'): ?>
                    <div class="voucher1" ><img src="/application/modules/User/externals/images/wheelchair.svg" width="30px" height="25px"></div>
                    <?php endif;   ?>
                    <?php  if($data['provide_parking']=='Yes'): ?>
                    <div class="voucher1" ><img src="/application/modules/User/externals/images/parking-sign.svg" width="30px" height="25px"></div>
                    <?php endif; ?>
                    <?php if($data['pets_allowed']=='Yes'): ?>
                         <?php if($data['pets_type']== 'Dogs'):?>                     
							<div class="voucher1" title="Dogs"><img src="/application/modules/User/externals/images/dog.png" width="22px" height="22px"></div>
						 <?php elseif($data['pets_type'] == 'Cats'):?>
							 <div class="voucher1" title="Cats"><img src="/application/modules/User/externals/images/cat.png" width="22px" height="22px"></div>
						 <?php elseif($data['pets_type'] == 'Cats & Dogs'):?>
							  <div class="voucher1" title="Cats & Dogs"><img src="/application/modules/User/externals/images/Layer-18.png" width="22px" height="22px"></div>
						 <?php elseif($data['pets_type'] == 'Birds'):?>
							   <div class="voucher1" title="Birds"><img src="/application/modules/User/externals/images/bird.png" width="22px" height="22px"></div>
						 <?php elseif($data['pets_type'] == 'Small pets'):?> 
							  <div class="voucher1" title="Small pets"><img src="/application/modules/User/externals/images/tortoise.png" width="22px" height="22px"></div> 
						 <?php endif; ?>
                    <?php endif; ?>
                    <div class="voucher1">
					<img src="/application/modules/User/externals/images/dollar-symbol.svg" width="25px">
					<?php echo $data['budget'];   if($data['budget_range_to']!='0'): echo " - ".$data['budget_range_to'];endif;?></div>
                    <div class="voucher1">
					<img src="/application/modules/User/externals/images/feed_bedroom_orange.png" width="30px">
					<?php echo $data['no_of_rooms']; ?></div>
  </div>             
</div>

	</div>	
	</div>	
	<?php endforeach;?>
	
	<?php else: ?><div class="notfoundbox"> <?php echo "No post to review";?></div>
	
	<?php endif; ?>
</div>	

<script type='text/javascript'>
	
    jQuery('#global_header').append('<div class="affix-top extra_header mob_bar_disable_particular_pages" data-spy="affix" data-offset-top="100">'+
	'<div id="global_content">'+
	'<div class="extra_header_content">'+
	
	'<ul class="navigation">'+
    '<li><a href="<?php echo $this->baseUrl().'/property/requirement'; ?>">Add a Post</a></li>'+
    '<li class="active"><a href="javascript:void(0)">Review Post</a></li>'+
    '</ul>'+
    
	'</div>'+
	'</div>'+
	'</div>');	
	
jQuery('.sub_header_dropdown').html(
                   '<select id = "sub_header_heding_select" class="input-box">'+
                   ' <option  value="property/requirement">Add a Post</option>'+
                   ' <option selected value="<?php echo $this->baseUrl().'/requirement/'.$viwer_id; ?>">Review Post</option>'+
                   ' </select>'
    );

jQuery(document).on('change','#sub_header_heding_select',function(){
	 location.href=jQuery('#sub_header_heding_select').val();
});
jQuery('body').on('click', '.edit_requirement', function(event){
	var property_id = jQuery(this).attr('data-id'); 
	var url	=	'<?php echo $this->baseUrl()?>' + '/property/requirement/edit/'+property_id;
	location.href= url;
	
});
	
jQuery('body').on('click', '.delete_requirement', function(event){
	 var oData           = new Object();
     var requirement_id = oData.requirement_id =parseInt(jQuery(this).attr('requirement_id'));
     var formURL    = '<?php echo $this->baseUrl(); ?>' + '/user/index/deleterequirement'; 
  
jQuery('body').on('click', '.yes_delete_requirement', function(event){
	 jQuery("#requirementDeleteModal").modal('hide');     
    	jQuery.ajax( {
						url : formURL,
						type: "POST",
						dataType: 'json',
						data : oData,
						success: function (data) { 						
							if(data.status==true)
							{
							jQuery( ".requirement_div_"+requirement_id ).css('display','none');	
							}
								jQuery("#successModal .success_message").text('');
                                jQuery("#successModal .success_message").text('Succesfully deleted');
                                jQuery("#successModal").modal('show');   
							},
							error: function(e){  
						   
						}
    });	
    });	
    

});


</script>
