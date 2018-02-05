<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: index.tpl 10158 2014-04-10 19:07:53Z lucas $
 * @author     John
 */
?>

<ul>
  <?php if( !empty($this->memberType) ): ?>
  <li>
    <span class="qwerty"><?php echo $this->translate('Member Type') ?></span>
    <span class="sep"> :</span>
    <?php // @todo implement link ?>
    <span class="xyz"><?php if($this->translate($this->memberType)=="Tenant"):echo "Renter";else:echo $this->translate($this->memberType);endif; ?></span>
  </li>
  <li>
    <span class="qwerty"><?php echo $this->translate('Gender') ?></span>
    <span class="sep"> :</span>
    <?php // @todo implement link ?>
    <span class="xyz"><?php echo $this->translate($this->gender) ?></span>
  </li>
  <?php endif; ?>
  <?php if( !empty($this->networks) && count($this->networks) > 0 ): ?>
  <li>
    <span class="qwerty"><?php echo $this->translate('Networks') ?></span>
    <span class="sep"> :</span>
    <span class="xyz"><?php echo $this->fluentList($this->networks, true) ?></span>
  </li>
  <?php endif; ?>
  <li>
   <span class="qwerty"> <?php echo $this->translate('Profile Views') ?></span>
   <span class="sep"> :</span>
   <span class="xyz"> <?php echo $this->translate(array('%s view', '%s views', $this->subject->view_count),
        $this->locale()->toNumber($this->subject->view_count)) ?></span>
  </li>
  <li>
    <?php $direction = Engine_Api::_()->getApi('settings', 'core')->getSetting('user.friends.direction');
    if ( $direction == 0 ): ?>
      <span class="qwerty"><?php echo $this->translate('Followers') ?></span> 
      <span class="sep"> :</span> 
      <span class="xyz"><?php echo $this->translate(array('%s follower', '%s followers', $this->subject->member_count),
        $this->locale()->toNumber($this->subject->member_count)) ?></span>       
    <?php //else: ?>  
    <!-- <span class="qwerty"><?php //echo $this->translate('Friends') ?></span> 
      <span class="sep"> :</span> 
    <span class="xyz"><? //php echo $this->translate(array('%s friend', '%s friends', $this->subject->member_count),
       // $this->locale()->toNumber($this->subject->member_count)) ?></span> -->
    <?php endif; ?>
  </li>
  <li>
     <span class="qwerty"><?php echo $this->translate('Last Update'); ?></span> 
      <span class="sep"> :</span> 
     <span class="xyz"><?php 
      if($this->subject->modified_date != "0000-00-00 00:00:00"){
        echo $this->timestamp($this->subject->modified_date);
      }
      else{
          echo $this->timestamp($this->subject->creation_date);
      }
      ?></span> 
  </li>
  <li>
    <span class="qwerty"><?php echo $this->translate('Joined') ?></span> 
     <span class="sep"> :</span> 
    <span class="xyz"> <?php echo $this->timestamp($this->subject->creation_date) ?></span> 
  </li>
  <?php if( !$this->subject->enabled && $this->viewer->isAdmin() ): ?>
  <li>
    <em>
      <span class="qwerty"><?php echo $this->translate('Enabled') ?></span> 
       <span class="sep"> :</span> 
      <span class="xyz"><?php echo $this->translate('No') ?></span> 
    </em>
  </li>
  <?php endif; ?>
</ul>


<script type="text/javascript">
  $$('.core_main_user').getParent().addClass('active');
</script>
