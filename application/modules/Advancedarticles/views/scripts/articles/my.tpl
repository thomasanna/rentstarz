<?php echo $this->content()->renderWidget('advancedarticles.actions-block') ?>
<br />

<div class='layout_right'>
<?php echo $this->content()->renderWidget('advancedarticles.filter-block') ?>
</div>

<div class='layout_middle'>
<?php if( !count($this->paginator) && !$this->filter ): ?>
    <div class="tip">
      <span>
        <?php echo $this->translate('You do not have any articles.');?>
        <?php if ($this->art_create):?>
          <?php echo $this->translate('Get started by %1$sposting%2$s a new article!', '<a href="'.$this->url(array('action' => 'add'), "advancedarticles_general").'">', '</a>'); ?>
        <?php endif; ?>
      </span>
    </div>
<?php return; endif; ?>
<?php if( !count($this->paginator) && $this->filter ): ?>
    <div class="tip">
      <span>
        <?php echo $this->translate('Nobody has created a article with that criteria.');?>
        <?php if ($this->art_create):?>
          <?php echo $this->translate('Be the first to %1$sadd%2$s a new article!', '<a href="'.$this->url(array('action' => 'add'), "advancedarticles_general").'">', '</a>'); ?>
        <?php endif; ?>
      </span>
    </div>
<?php return; endif; ?>
<h3>
  <?php echo $this->translate(array('%s article found.', '%s articles found.', $this->totalArticles),$this->locale()->toNumber($this->totalArticles)) ?>
</h3>
<table class='art_table' id="art_table" width="100%">
  <thead>
    <tr>
      <th></th>
      <th></th>
	  <th></th>
    </tr>
  </thead>
  <tbody>
      <?php foreach( $this->paginator as $item ): ?>
		<tr class="space">
		<td width=1%></td>
		<td></td>
		<td></td>
		</tr>	  
        <tr>
          <td valign="top">
          <?php
            if( $item->photo_id ) echo $this->htmlLink($item->getHref(), $this->itemPhoto($item, 'thumb.normal', array('class' => 'thumb')));
            else echo '<img alt="" src="application/modules/Advancedarticles/externals/images/no_art.png">';
          ?>		  
		  </td>
          <td valign="top">
		    <div class="art_title"><h3><?php echo $this->htmlLink($item->getHref(), $this->string()->truncate($item->title, 50)) ?>
			<?php if ( $item->featured ) : ?><img title="<?php echo $this->translate('featured') ?>" class="art_featured" src="application/modules/Advancedarticles/externals/images/featured.png" />
			<?php endif; ?>
			<?php if ( $item->sponsored ) : ?><img title="<?php echo $this->translate('sponsored') ?>" class="art_sponsored" src="application/modules/Advancedarticles/externals/images/sponsored.png" />
			<?php endif; ?>			
			</h3>

			</div>
				<div class="article_info_line"><?php echo $this->timestamp($item->created_date) ?> - <?php echo $this->translate(array('%s view', '%s views', $item->num_views),$this->locale()->toNumber($item->num_views)) ?> - <?php echo $this->translate(array('%s comment', '%s comments', $this->advancedarticlesComments($item) + $item->comments()->getCommentCount()), $this->locale()->toNumber($this->advancedarticlesComments($item) + $item->comments()->getCommentCount())) ?> - <?php echo $this->translate(array('%s like', '%s likes', $this->advancedarticlesLikes($item) + $item->likes()->getLikeCount()),$this->locale()->toNumber($this->advancedarticlesLikes($item) + $item->likes()->getLikeCount())) ?></div>			

			<div class="description"><?php echo $this->string()->truncate($item->description, 300) ?></div>
		  </td>
		  <td valign="top">
      <div class="art_links" id="art_links">  
      <?php if( $this->viewer()->getIdentity() ):
	  		if ($item->status == 'active') { 
			  $subclass = 'icon_deactivate';
			  $label = $this->translate('Deactivate');
			}
			elseif ($item->status == 'inactive') {
			  $subclass = 'icon_activate';
			  $label = $this->translate('Activate');			
			}
			else {
			  $subclass = 'icon_draft';
			  $label = $this->translate('Publish Article');			
			}
	   ?>
          <span id="<?php echo $item->artarticle_id ?>"><a href="javascript:void(0);" class="buttonlink <?php echo $subclass ?>"><?php echo $label ?></a></span>
          <?php if ($this->photo_upload) : ?>
          <?php echo $this->htmlLink($this->url(array('action' => 'addphoto', 'id' => $item->artarticle_id), "advancedarticles_category_specific"), $this->translate('Add Photos'), array(
          'class' => 'buttonlink icon_aphoto_upload', 'title' => $this->translate('Add Photos')));	?>	
          <?php endif; ?>
          <?php if ($this->art_edit) : ?>
          <?php echo $this->htmlLink($this->url(array('action' => 'edit', 'id' => $item->artarticle_id), "advancedarticles_category_specific"), $this->translate('Edit'), array(
          'class' => 'buttonlink icon_edit', 'title' => $this->translate('Edit')));	?>
          <?php endif; ?>
          <?php if ($this->art_delete) : ?>
          <?php echo $this->htmlLink($this->url(array('action' => 'delete', 'id' => $item->artarticle_id), "advancedarticles_category_specific"), $this->translate('Delete'), array(
          'class' => 'buttonlink icon_art_delete smoothbox', 'title' => $this->translate('Delete')));	?>
          <?php endif; ?>
      <?php endif; ?>	
	  </div>
		  </td>
        </tr>
		<tr style="height:15px">
		<td></td>
		<td></td>
		<td></td>
		</tr>		
      <?php endforeach; ?>
  </tbody>
</table>
<br />
    <?php echo $this->paginationControl($this->paginator, null, null, array(
      'pageAsQuery' => true,
      'query' => $this->formValues,
      //'params' => $this->formValues,
    )); ?>
</div>
<script type="text/javascript">
var prefix = '';
  function mrrOff() {
	addres = window.location.href;
    if (addres.split("index.php").length > 1)    
	  prefix = 'index.php/';
  }
mrrOff();
window.addEvent('domready', function() { 
if ($$('#art_table div[id=art_links]') != null)
  $$('#art_table div[id=art_links] span').addEvent('click', function(e){
  		var element = this;
		element.addClass('art_load');
  		element.tween('opacity', 0.1);
		var status = new Request({
		    url: '<?php echo $this->url(array('action' => 'status'), 'advancedarticles_general') ?>?format=html',
			method: 'post',
		    onSuccess: function(responseText){
				element.set('html', responseText);
				element.tween('opacity', 1);
				element.removeClass('art_load');
	        }
		});
	 	status.send('id='+this.id);
  });	
});
</script>
