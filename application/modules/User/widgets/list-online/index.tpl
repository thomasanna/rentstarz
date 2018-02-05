
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

<!--
<h3><?php //echo $this->count ?> Members Online1111</h3>
-->


<script >
	jQuery( function() {
    var $winHeight = jQuery( window ).height()
    jQuery( '.container' ).height( $winHeight );
    });
</script>

<div>
	<!--<div class="led-yellow"></div>-->
  <?php foreach( $this->paginator as $user ): ?>
    <div class='whosonline_thumb'>
		 <div class="led-green"></div> 
		<!--<div><img src="/application/modules/User/externals/images/online.png" style="margin-right: 7px; width:10px;height:10px"></img></div>-->
      <?php echo $this->htmlLink($user->getHref(), $this->itemPhoto($user, 'thumb.icon', $user->getTitle()), array('title'=>$user->getTitle())) ?>
    </div>
  <?php endforeach; ?>
  
  <?php if( $this->guestCount ): ?>
    <div class="online_guests">
      <?php echo $this->translate(array('%s guest online', '%s guests online', $this->guestCount),
          $this->locale()->toNumber($this->guestCount)) ?>
    </div>
  <?php endif ?>
</div>
<script> 
	
jQuery(document).ready(function(){
jQuery('.layout_user_list_online .ybo_headline h3').append('<span class="arrow onlinedropdown"><img style="width: 20px; margin-left: 7px; " src="application/modules/User/externals/images/down-arrow.svg"></span>');
jQuery('.layout_user_list_online .whosonline_thumb').css('display','none'); 
});

jQuery('body').on('click', '.arrow', function(event){ 
	
    if(jQuery( ".arrow" ).hasClass("onlinedropdown")){
	   jQuery('.layout_user_list_online .whosonline_thumb').css('display','block');   
       jQuery( ".arrow" ).removeClass("onlinedropdown");
    }

    else
    { 
	  jQuery('.layout_user_list_online .whosonline_thumb').css('display','none');        
      jQuery( ".arrow" ).addClass("onlinedropdown");
        
    }
});

</script>
