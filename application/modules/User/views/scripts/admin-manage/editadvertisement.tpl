<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: edit.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     Sami
 */
?>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<div class="global_form_popup">
  <?php echo $this->form->setAttrib('class', '')->render($this) ?>
</div>
<script type="text/javascript">
	
  $( function() {	  
    $( "#datepicker1" ).datepicker(
    {
	dateFormat: 'yy-mm-dd',
	 minDate: 0
		}
    );
    $( "#datepicker2" ).datepicker({
	dateFormat: 'yy-mm-dd',
	 minDate: 0
    }
    );
    
  });
  
  
/* var date_from = jQuery('#datepicker1').val();
 var date_to = jQuery('#datepicker2').val();
   if(date_to<date_from){
	   jQuery('.error_msg').text('');
	   jQuery('.error_msg').text('Date to must be greater than Date from');
	   return false;
   }
   else{
   return true;
   }*/
  </script> 
