<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: index.tpl 10167 2014-04-15 19:18:29Z lucas $
 * @author     John
 */
?>
<link rel="stylesheet" href="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/styles/online.css" type="text/css">
<script >
	$( function() {
  var $winHeight = $( window ).height()
  $( '.container' ).height( $winHeight );
    });
</script>
<ul>

 <?php 
   $online_users=$this->online_users;

   $online_user_id = array();
   foreach($online_users as $row):

   $online_user_id[]=$row['user_id'];
   endforeach;
?>
    
  <?php foreach( $this->paginator as $user ): ?>
 
    <li>
		
	<?php	if(in_array($user['user_id'],$online_user_id)): ?>
	
		<div class="led-green"></div>
		<?php endif; ?>
		
      <?php echo $this->htmlLink($user->getHref(), $this->itemPhoto($user, 'thumb.icon', $user->getTitle()), array('class' => 'newestmembers_thumb')) ?>
      <div class='newestmembers_info'>
        <div class='newestmembers_name'>
			<?php $attribs=Array('title'=>'View Profile'); ?>
          <?php echo $this->htmlLink($user->getHref(), $user->getTitle(),$attribs) ?>
        </div>
        <div class='newestmembers_date'>
          <?php echo $this->timestamp($user->creation_date) ?>
        </div>
      </div>
    </li>
  <?php endforeach; ?>
</ul>
