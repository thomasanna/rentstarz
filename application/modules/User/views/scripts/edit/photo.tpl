<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: photo.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */
?>

<div class="headline">
  <h2>
    <?php if ($this->viewer->isSelf($this->user) ):?>
      <?php echo $this->translate('Edit My Profile');?>
    <?php else:?>
      <?php echo $this->translate('%1$s\'s Profile', $this->htmlLink($this->user->getHref(), $this->user->getTitle()));?>
    <?php endif;?>
  </h2>
  <div class="tabs">
    <?php
      // Render the menu
      echo $this->navigation()
        ->menu()
        ->setContainer($this->navigation)
        ->render();
    ?>
  </div>
</div>
<?php /* <div class="generic_layout_container layout_left">
<?php
echo $this->content()->renderWidget('user.home-photo');
echo $this->content()->renderWidget('user.home-links');
?>
</div> */?>
 <div class="generic_layout_container layout_middle">
<?php echo $this->form->render($this) ?>
</div>
<script>
	
jQuery(document).ready(function()  {


    jQuery('#Filedata-element').attr('title', 'Supported file types : jpg,png,gif,jpeg');

});
   jQuery( "#done" ).click(function() {
	    jQuery('#status').val('1');
	
   
 
  jQuery( "#EditPhoto" ).submit();
  jQuery('#status').val('');
      }); 
    

jQuery('#global_page_user-edit-photo .headline').append('<span class="profile_click mob_bar" style="float:right;width: 5%;font-size: medium;"><i class="fa fa-bars" aria-hidden="true"></i></span>');

jQuery( ".profile_click" ).click(function() {
	if(jQuery( ".profile_click" ).hasClass("show_dropdown")){
        jQuery('.tabs .navigation').css('display','none');
	    jQuery('.profile_click').removeClass('show_dropdown');
		
	}
	else{
		jQuery('.profile_click').addClass('show_dropdown');
        jQuery('.tabs .navigation').css('display','block');
	
	}
});
</script>
