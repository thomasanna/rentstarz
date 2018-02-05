<script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/scripts/lightbox-plus-jquery.min.js"></script>
<link href="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/styles/lightbox.min.css" rel="stylesheet" type="text/css">
<?php $viewer        =   Engine_Api::_()->user()->getViewer(); ?>
<?php if($viewer->getIdentity()):?>
    <script src="/application/modules/User/externals/scripts/message_notififaction.js"></script>
<?php endif;?>            

<?php  $settings = Engine_Api::_()->getApi('settings', 'core');  ?>

<div class="generic_layout_container layout_right" style=" margin-top: 35px;">
<?php echo $this->content()->renderWidget('user.advertisement'); ;?>
</div>

<div class="generic_layout_container layout_middle">
	<div style="padding: 12px 8px 12px 8px;">
    <h1 style="margin: 0px;"><?php echo $settings->user_featuredstoryTitle;?></h1>
</div> 
	<div class="featuredstory_content_div" style="padding: 0px 8px 0px 8px;">
	<div class="featuredstory_image" > 
      <a href="<?php echo $this->baseUrl().'/'.$settings->user_FeaturedstoryImage ;?>" data-lightbox="image2"><img src="<?php echo $this->baseUrl().'/'.$settings->user_FeaturedstoryImage ;?>" alt="">	</a>	
   </div>
   <div class="featuredstory_description" style="padding: 25px 0px 0px 0px;font-size: 14px;">
    <?php echo $settings->user_featuredstory;?>
   </div>
	
	</div>	
</div>	

<script type="text/javascript">
if( jQuery.trim( jQuery('#global_page_user-index-featuredstory .layout_right').html() ).length  == 12) {
	  jQuery('#global_page_user-index-featuredstory .layout_right').css('display',"none");
	}
</script>
