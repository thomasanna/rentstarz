<?php
/**
 * SocialEngine
 *
 * @category   Application_Themes
 * @package    Template
 * @copyright  Copyright YouNet Company
 */
?>

<?php
    $index = 0; 
?>
<?php
$this->headLink()
          ->prependStylesheet($this->baseUrl() . '/application/css.php?request=application/modules/Ynresponsive1/externals/styles/jquery.bxslider.css');
$this->headScript()
        ->appendFile('//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js')
        ->appendFile($this->baseUrl() . '/application/modules/Ynresponsive1/externals/scripts/jquery.bxslider.min.js')
;
?>
<div class="bxSlider" >
  <ul class="slides" id="<?php echo $this->slider_id; ?>">
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
    jQuery.noConflict();
    
    en4.core.runonce.add(function(){
        jQuery('#<?php echo $this->slider_id; ?>').bxSlider({
            auto: true,
            touchEnabled:false
        });
    });
</script>