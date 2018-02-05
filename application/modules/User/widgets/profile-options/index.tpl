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
<?php $subject = Engine_Api::_()->core()->getSubject(); 
$viewer     = Engine_Api::_()->user()->getViewer();

$bg_verified = $subject->bg_verified;?>
<div id='profile_options'>
  <?php // This is rendered by application/modules/core/views/scripts/_navIcons.tpl
    echo $this->navigation()
      ->menu()
      ->setContainer($this->navigation)
      ->setPartial(array('_navIcons.tpl', 'core'))
      ->render()
  ?>
</div>


<script>
jQuery(".user_profile_friend").css('display','none');

<?php //if($viewer->getIdentity() == $subject->getIdentity()):?>

<?php //if($this->profile_type_id == 1):?>

<?php //if($this->smartmoveRenterApiStatus == 0):?>

//jQuery('#profile_options ul').prepend('<li><a href="<?php echo $this->baseUrl().'/renter/create'?>" class="buttonlink menu_user_profile user_profile_edit" style="background-image: url(application/modules/User/externals/images/create-group-button.svg); color: #f58410; background-size: 19px;"  target="">Create Renter</a></li>');

<?php //else:?>

//jQuery('#profile_options ul').prepend('<li><a href="<?php echo $this->baseUrl().'/renter/create'?>" class="buttonlink menu_user_profile user_profile_edit" style="background-image: url(application/modules/User/externals/images/edit2.svg); color: #f58410; background-size: 15px;"  target="">Update Renter</a></li>');


<?php //endif;?>

<?php //endif;?>

<?php //endif;?>
</script>


<script>
/*var bg_verified = '<?php echo $bg_verified;?>';

if(bg_verified == 1){
jQuery('#profile_options ul').prepend('<li><a href="javascript:void(0)" class="buttonlink menu_user_profile user_profile_edit verified_link" style="background-image: url(application/modules/User/externals/images/verfication_image.png); color: #46B4EA !important;" target="">Get Verified</a></li>');
}*/

</script>
