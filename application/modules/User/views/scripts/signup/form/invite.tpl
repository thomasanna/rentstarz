<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: invite.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     Sami
 */
?>
<div id="invite_form">
  
  <?php echo $this->form->render($this) ?>

</div>


<script>
jQuery(document).ready(function()  {

jQuery("#global_page_user-signup-index .user-profile").css('display', 'none')

});

</script>
