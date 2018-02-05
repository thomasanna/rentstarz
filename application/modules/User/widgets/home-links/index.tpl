<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: index.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */
?>
<?php $viewer = Engine_Api::_()->user()->getViewer();

 $bg_verified = $viewer->bg_verified; 
 
 

		
		$fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer); 
		
		if( !empty($fieldsByAlias['profile_type']) )
		{
		   $optionId = $fieldsByAlias['profile_type']->getValue($viewer);
		   $profile_type_id = $optionId->value; 
		}
 
 
 
 
 
 
 
 
 ?>
<div class="quicklinks">
  <?php // This is rendered by application/modules/core/views/scripts/_navIcons.tpl
    echo $this->navigation()
      ->menu()
      ->setContainer($this->navigation)
      ->setPartial(array('_navIcons.tpl', 'core'))
      ->render()
  ?>
</div>

<?php $isSmartmoveRenter=$this->isSmartmoveRenter;?>
<script>

var bg_verified = '<?php echo $bg_verified; ?>';
var isSmartmoveRenter = '<?php echo $this->isSmartmoveRenter; ?>';
var profile_type_id = '<?php echo $profile_type_id; ?>';

if(profile_type_id == 1){ // renter
	
	
	if((bg_verified==1 && isSmartmoveRenter==0) )
	{ 
		jQuery('.quicklinks ul').prepend('<li><a href="/renter/create" class="buttonlink menu_user_profile user_profile_edit verified_link" style="background-image: url(application/modules/User/externals/images/verfication_image.png); color: #46B4EA !important; " target="">Verified</a></li>');

	}
	if((bg_verified==0 && isSmartmoveRenter==1) )
	{ 
		jQuery('.quicklinks ul').prepend('<li><a href="/renter/create" class="buttonlink menu_user_profile user_profile_edit verified_link" style="background-image: url(application/modules/User/externals/images/verfication_image.png); color: #46B4EA !important; " target="">Verified</a></li>');

	}
	if(bg_verified==0 && isSmartmoveRenter==0)
	{ 
		jQuery('.quicklinks ul').prepend('<li><a href="/renter/create" class="buttonlink menu_user_profile user_profile_edit verified_link" style="background-image: url(application/modules/User/externals/images/exclamation-mark.svg); color: #46B4EA !important; background-size: 15px;" target="">Get Verified</a></li>');

	}
	if(bg_verified==1 && isSmartmoveRenter==1){
		
			jQuery('.quicklinks ul').prepend('<li><a href="javascript:void(0)" class="buttonlink menu_user_profile user_profile_edit verified_link" style="background-image: url(application/modules/User/externals/images/verfication_image.png); color: #46B4EA  !important; cursor: default; " target="">Verified</a></li>');

	}
		
		
}
else{
	
	
	if(bg_verified==1){
		
		jQuery('.quicklinks ul').prepend('<li><a href="javascript:void(0)" class="buttonlink menu_user_profile user_profile_edit verified_link" style="background-image: url(application/modules/User/externals/images/verfication_image.png); color: #46B4EA !important; cursor: default;" target="">Verified</a></li>');

		
	}
	else{
		
		jQuery('.quicklinks ul').prepend('<li><a href="javascript:void(0)" class="buttonlink menu_user_profile user_profile_edit verified_link" style="background-image: url(application/modules/User/externals/images/exclamation-mark.svg); color: #46B4EA !important;cursor: default;" target="">Get Verified</a></li>');

	}
	
	
}



</script>
