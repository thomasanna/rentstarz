<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: index.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */
?>

<ul>
	
	<?php if($this->profile_type_id == 4):?>
	
	<li>
    <span><?php echo $this->locale()->toNumber($this->tenantsCount); ?></span>
    <div><?php echo $this->translate(array('Tenants', 'Renters', $this->tenantsCount)) ?></div>
    </li>
	<li>
    <span><?php echo $this->locale()->toNumber($this->matching_requirementsCount); ?></span>
    <div><?php echo $this->translate(array('Property match', 'Property match', $this->matching_requirementsCount)) ?></div>
    </li>
	<li>
    <span><?php echo $this->locale()->toNumber($this->mypropertiesCount); ?></span>
    <div><?php echo $this->translate(array('Properties', 'Properties', $this->mypropertiesCount)) ?></div>
    </li>
	<li>
    <span><?php echo $this->locale()->toNumber($this->mydocumentsCount); ?></span>
    <div><?php echo $this->translate(array('My Documents', 'My Documents', $this->mydocumentsCount)) ?></div>
    </li>
	
  <?php elseif($this->profile_type_id == 1): ?>
  
    <li>
    <span><?php echo $this->locale()->toNumber($this->landlordCount); ?></span>
    <div><?php echo $this->translate(array('Landlords', 'Landlords', $this->landlordCount)) ?></div>
    </li>
	<li>
    <span><?php echo $this->locale()->toNumber($this->matchingPropertiesCount); ?></span>
    <div><?php echo $this->translate(array('Property match', 'Property match', $this->matchingPropertiesCount)) ?></div>
    </li>
	<li>
    <span><?php echo $this->locale()->toNumber($this->propertyCount); ?></span>
    <div><?php echo $this->translate(array('Properties', 'Properties', $this->propertyCount)) ?></div>
    </li>
	<li>
    <span><?php echo $this->locale()->toNumber($this->mydocumentsCount); ?></span>
    <div><?php echo $this->translate(array('My Documents', 'My Documents', $this->mydocumentsCount)) ?></div>
    </li>
  
  <?php else: ?>
  <li>
    <span><?php echo $this->locale()->toNumber($this->member_count); ?></span>
    <div><?php echo $this->translate(array('Member', 'Members', $this->member_count)) ?></div>
  </li>
  <?php /* if ($this->friend_count > 0): ?>
    <li>
      <span><?php echo $this->locale()->toNumber($this->friend_count) ?></span>
      <div><?php echo $this->translate(array('friendship', 'friendships', $this->friend_count)) ?></div>
    </li>
  <?php endif; ?>
  <?php if ($this->post_count > 0): ?>
    <li>
      <span><?php echo $this->locale()->toNumber($this->post_count) ?></span>
      <div><?php echo $this->translate(array('post', 'posts', $this->post_count)) ?></div>
    </li>
  <?php endif; */?>
  
    <li>
    <span><?php echo $this->locale()->toNumber($this->landlordCount); ?></span>
    <div><?php echo $this->translate(array('Landlords', 'Landlords', $this->landlordCount)) ?></div>
    </li>
    
   <li>
    <span><?php echo $this->locale()->toNumber($this->tenantsCount); ?></span>
    <div><?php echo $this->translate(array('Renters', 'Renters', $this->tenantsCount)) ?></div>
    </li>
  
  
  <?php if ($this->comment_count > 0): ?>
    <li>
      <span><?php echo $this->locale()->toNumber($this->comment_count) ?></span>
      <div><?php echo $this->translate(array('comment', 'comments', $this->comment_count)) ?></div>
    </li>
  <?php endif; ?>

  <?php if (is_array($this->hooked_stats) && !empty($this->hooked_stats)): ?>
  <?php foreach ($this->hooked_stats as $key => $value): ?>
    <?php if ($value > 0): ?>
      <li>
        <span><?php echo $this->locale()->toNumber($value) ?></span>
        <div><?php echo $this->translate(array($key, $key, $value)) ?></div>
      </li>
    <?php endif; ?>
  <?php endforeach; endif; ?>
  
   <?php endif; ?>

</ul>

<script>

jQuery('body').on('click', '.arrow2', function(event){ 
	
    if(jQuery( ".arrow2" ).hasClass("stat")){
	   jQuery('.layout_core_statistics > ul').css('display','block');
       jQuery( ".arrow2" ).removeClass("stat");
    }

    else
    {       
	  jQuery('.layout_core_statistics > ul').css('display','none');         
      jQuery( ".arrow2" ).addClass("stat");
        
    }
});
</script>
