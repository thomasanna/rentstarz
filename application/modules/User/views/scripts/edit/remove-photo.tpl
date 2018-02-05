<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: remove-photo.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */
?>

<?php echo $this->form->render($this) ?>

<script type='text/javascript'>
jQuery( "#cancel" ).click(function() {	
	 location.href= '<?php echo $this->baseUrl()?>/members/edit/photo';
});
</script>
