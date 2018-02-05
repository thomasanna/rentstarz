<?php $this->headScript()->appendFile($this->baseUrl() .'/application/modules/Advancedarticles/externals/scripts/_class.noobSlide.js');?>
<div class="box_art_featured" id="art_featured">
  <ul>
    <li>

<div>
	<div class="mask_featured" id=mask_featured>
		<div id="box_featured">
<?php $circle=''; foreach($this->paginator as $item) : ?>
			<div>
    <?php 
      if ($item->photo_id) echo $this->htmlLink($item->getHref(), $this->itemPhoto($item, 'thumb.normal'), array('id' => $item->getIdentity()));
      else echo $this->htmlLink($item->getHref(), '<img id="<?php echo $item->getIdentity() ?>" src="application/modules/Advancedarticles/externals/images/no_art.png">');
    ?>
        <p><b><?php echo $this->htmlLink($item->getHref(), $this->string()->truncate($item->getTitle(), 40)) ?></b></p>
        <?php echo $this->timestamp($item->created_date) ?><span> - <?php echo $this->translate('posted by'); ?> <?php echo $this->htmlLink($item->getHref(), $this->advancedarticlesUser($item->owner_id)) ?></span>
        <span><?php echo $this->translate(array('%s view', '%s views', $item->num_views),$this->locale()->toNumber($item->num_views)) ?> - <?php echo $this->translate(array('%s comment', '%s comments', $this->advancedarticlesComments($item) + $item->comments()->getCommentCount()), $this->locale()->toNumber($this->advancedarticlesComments($item) + $item->comments()->getCommentCount())) ?> - <?php echo $this->translate(array('%s like', '%s likes', $this->advancedarticlesLikes($item) + $item->likes()->getLikeCount()),$this->locale()->toNumber($this->advancedarticlesLikes($item) + $item->likes()->getLikeCount())) ?></span>
          <p><?php echo $this->string()->truncate($item->description, 250) ?></p>
 
	
			</div>
			
  <?php $circle .= " <span id=".$item->getIdentity()."><img src='application/modules/Advancedarticles/externals/images/circle.png'></span>"; endforeach; ?>

		</div>
	</div>
	<span id="info_featured"></span>
	<?php $style = ''; if ($this->totalArticles <= 1) $style="display:none"; ?>
	<p class="buttons" id="handles_featured" style="<?php echo $style ?>">
		<?php echo $circle ?>
	</p>
</div>    

    </li>
  </ul>
</div>
<script>
window.addEvent('domready', function() {
    width = $('art_featured').offsetWidth-7;
    $('mask_featured').set('style', 'width:'+width+'px');
    $$('#box_featured div').set('style', 'width:'+width+'px');
	var nS4 = new noobSlide({
		box: $('box_featured'),
		items: $$('#box_featured div'),
		autoPlay: true,
		interval: <?php echo $this->interval ?>,
		size: width,
		handles: $$('#handles_featured span'),
		onWalk: function(currentItem,currentHandle){
			$('info_featured').set('html',currentItem.getFirst().id);
			this.handles.removeClass('circle_active');
			currentHandle.addClass('circle_active');
		}
	});
});
</script>