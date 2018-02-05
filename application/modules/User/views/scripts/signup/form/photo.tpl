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

<?php echo $this->form->render($this); ?>
<script>
jQuery(document).ready(function()  {

jQuery("#global_page_user-signup-index .user-profile").css('display', 'none')
jQuery(".errors").empty();
jQuery(".errors").append('<li>Please upload image</li>');

jQuery('#Filedata-element').attr('title', 'Supported file types : jpg,png,gif,jpeg');

});

</script>
