<?php
/**
 * SocialEngine
 *
 * @category   Application_Themes
 * @package    Template
 * @copyright  Copyright YouNet Company
 */
?>
<?php $index = 0; ?>
<div class="flexslider" id="<?php echo $this->slider_id; ?>">
  <ul class="slides">
    <?php foreach( $this->items as $item): ?> 
    <?php $title  =  $item->getTitle(); ?>
    <li class="<?php echo ++$index==1?'active':''; ?>">
      <div class="overflow-hidden" style="height:<?php echo $this->height;?>px">
		  <span style="background-image: url(<?php echo $item -> getPhotoUrl()?>);"></span>
            <?php if($title && $this->show_title): ?>
            <div class="carousel-caption">
              <p><?php echo $this->htmlLink($item->getHref(), $title) ?></p>
            </div>
            <?php endif; ?>
      </div>
    </li>
    <?php endforeach; ?>
    
  </ul>
</div>
<script type="text/javascript">
jQuery(window).load(function() {
  jQuery('#<?php echo $this -> slider_id; ?>').flexslider({
    animation: "slide"
  });
});
</script>