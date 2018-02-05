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

$bg_verified = $viewer->bg_verified; ?>


<?php /*<div>
<center>
	<?php if($bg_verified == 1):?>
	<img src="application/modules/User/externals/images/tick.svg" height="30" >
	

    <h2 class="profile_verified_text">Verified</h2>
    <?php else:?>
    <img src="application/modules/User/externals/images/esclamation.svg" height="30" >

    <h2 class="profile_verified_text">Unverified</h2>
    <?php endif;?>
<br>
</center>
</div>*/ ?>

<div class="profile_image_div">
  <?php echo $this->htmlLink($this->viewer()->getHref(), $this->itemPhoto($this->viewer(), 'thumb.profile'),array('title'=>'View Profile')) ?>
</div>

<h3>
  <!-- <?php //echo $this->translate('Hi %1$s!', $this->viewer()->getTitle()); ?>-->
 <?php echo $this->htmlLink($this->viewer()->getHref(), $this->viewer()->getTitle(),array('title'=>'View Profile')) ?>
</h3>
