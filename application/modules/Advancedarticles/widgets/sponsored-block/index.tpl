<?php $this->headScript()->appendFile($this->baseUrl() .'/application/modules/Advancedarticles/externals/scripts/_class.noobSlide.js');?>
<div class="box_art_featured" id="art_sponsored">
  <ul>
    <li>

<div>
	<div class="mask_sponsored" id=mask_sponsored>
		<div id="box_sponsored">
<?php $circle=''; foreach($this->paginator as $item) : ?>
	<div>
	<p>
    <?php 
      if ($item->photo_id) echo $this->htmlLink($item->getHref(), $this->itemPhoto($item, 'thumb.normal'), array('id' => $item->getIdentity()));
      else echo $this->htmlLink($item->getHref(), '<img id="<?php echo $item->getIdentity() ?>" src="application/modules/Advancedarticles/externals/images/no_art.png">');
    ?>
    </p>
        <p><b><?php echo $this->htmlLink($item->getHref(), $this->string()->truncate($item->getTitle(), 25)) ?></b></p>
        <p><span><?php echo $this->translate('posted by'); ?> <?php echo $this->htmlLink($item->getHref(), $this->advancedarticlesUser($item->owner_id)) ?></span></p>
        <p><?php echo $this->string()->truncate($item->description, 100) ?></p>
	</div>
			
  <?php $circle .= " <span id=".$item->getIdentity()."><img src='application/modules/Advancedarticles/externals/images/circle.png'></span>"; endforeach; ?>

		</div>
	</div>
	<span id="info_sponsored"></span>
	<?php $style = ''; if ($this->totalArticles <= 1) $style="display:none"; ?>
	<p class="buttons" id="handles_sponsored" style="<?php echo $style ?>">
		<?php echo $circle ?>
	</p>
</div>    

    </li>
  </ul>
</div>
<script>
window.addEvent('domready', function() {
    width = $('art_sponsored').offsetWidth-7;
    $('mask_sponsored').set('style', 'width:'+width+'px');
    $$('#box_sponsored div').set('style', 'width:'+width+'px');
	var nS4 = new noobSlide({
		box: $('box_sponsored'),
		items: $$('#box_sponsored div'),
		autoPlay: true,
		interval: <?php echo $this->interval ?>,
		size: width,
		handles: $$('#handles_sponsored span'),
		onWalk: function(currentItem,currentHandle){
			$('info_sponsored').set('html',currentItem.getFirst().id);
			this.handles.removeClass('circle_active');
			currentHandle.addClass('circle_active');
		}
	});
});
</script>