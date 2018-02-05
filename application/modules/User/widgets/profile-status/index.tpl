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
 $subject = Engine_Api::_()->core()->getSubject();
 $viewer = Engine_Api::_()->user()->getViewer();
 
 $profile_menus = Engine_Api::_()
      ->getApi('menus', 'core')
      ->getNavigation('user_profile');
      
      
?>




<div id='profile_photo'>
  <?php echo $this->itemPhoto($this->subject()) ?>
</div>
 
<div id='profile_status'>
    <div class="profile_name"style="float:left;font-weight: 600;">
		

    <?php echo $this->subject()->getTitle() ?>
    </div>
    
    <?php if( $_SERVER['REQUEST_URI']==$this->baseUrl().'/profile/'.$viewer->getIdentity()): ?>
    <div style="width: 80px;text-align: center;"> <a href="<?php echo $this->baseUrl().'/members/edit/profile'; ?>" > Edit Profile</a></div>
   <?php endif; ?>
   
   <?php if($subject->getIdentity() != $viewer -> getIdentity()): ?>

		<div class="profile_menus_div">
		<ul class="profile_menus_ul">
				<li class="dropdown">
					<a class="dropdown-toggle" data-toggle="dropdown" data-backdrop="static" data-keyboard="false" href="javascript:void(0)" >
					<i class="fa fa-caret-down" aria-hidden="true" style="font-size: 21px;"></i>
					</a> 
					 <ul class="dropdown-menu">
						
						<?php foreach( $profile_menus as $link ): ?>
						<?php if($link->getLabel() =='Block Member' || $link->getLabel() =='Report'):?>	
						<li>
						
						  <?php echo $this->htmlLink($link->getHref(), $this->translate($link->getLabel()), array(
							'class' => 'buttonlink' . ( $link->getClass() ? ' ' . $link->getClass() : '' ),
							'style' => 'background-image: url('.$link->get('icon').');',
							'target' => $link->get('target'),
						  )) ?>
						
						</li>
						<?php endif;?>  
						<?php endforeach; ?>
					  </ul>
				</li>

			</ul>
		</div>  

	<?php endif;?> 

</div>
 
<?php if($this->subjectData->rating_value != '' && $this->subjectData->rating_value !=0):?>
    <?php if($this->subjectData->enable_rating_value == 1):?>
    
  <div style="float: left;" class="basic" data-average="<?php echo $this->subjectData->rating_value;?>" data-id="1" title="<?php echo $this->subjectData->rating_value;?>"></div> 
   <!--  <div class="ratebox" data-id="1" data-rating="2.2"></div>-->
    <?php endif;?>
    <?php endif;?>
<?php if( !$this->auth ): ?>
  <div class="tip">
    <span>
      <?php echo $this->translate('This profile is private.');?>
    </span>
  </div>
  <br />
<?php endif; ?>


<div class="tabs_alt tabs_parent " style="display:block">
  <ul id="main_tabs">         <li class="tab_541 tab_layout_user_profile_fields active"><a href="javascript:void(0);">Info</a></li>
                              <li class="tab_540 tab_layout_activity_feed "><a href="javascript:void(0);">Updates</a></li>                              
                              <li class="tab_655 tab_layout_album_profile_albums"><a href="javascript:void(0);">Galleries<span>(1)</span></a></li>
                              <li class="tab_100000991 tab_layout_user_profile_documents"><a href="javascript:void(0);">Documents</a></li>
  </ul>
</div>


<script>


jQuery.noConflict();
	
		
jQuery('.basic').jRating(); 
		

</script>
