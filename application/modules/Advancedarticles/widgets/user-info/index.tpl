<div class="art_user_info">
<?php $owner = $this->advancedarticlesUser($this->article->owner_id);	?>
<ul>
<li>
<?php echo $this->htmlLink($owner->getHref(), $this->itemPhoto($owner, 'thumb.icon', array('class' => 'thumb'))); ?>
<div><b><?php echo $this->htmlLink($owner->getHref(), $owner->getTitle());  ?></b></div>
<div class="art_timestamp"><?php echo $this->translate('updated'); ?> <?php echo $this->timestamp($this->article->updated_date);  ?></div>
<div class="art_timestamp"><a href="<?php echo $this->url(array('action' => 'category'),'advancedarticles_general').'?owner='.$this->article->owner_id ?>"><?php echo $this->translate(array('%s article', '%s articles', $this->count_art),$this->locale()->toNumber($this->count_art)) ?></a></div>
<?php echo $this->content()->renderWidget('advancedarticles.filter-block') ?>
</li>
</ul>
</div>
<?php if( $this->viewer()->getIdentity() ):

            if ($this->article->status == 'active') { 
			  $subclass = 'icon_deactivate';
			  $label = $this->translate('Deactivate');
			}
			elseif ($this->article->status == 'inactive') {
			  $subclass = 'icon_activate';
			  $label = $this->translate('Activate');			
			}
			else {
			  $subclass = 'icon_draft';
			  $label = $this->translate('Publish Article');			
			}
	   ?>
<div id="art_actions" class="art_user_info">
      <div class="art_action_links" id="art_action_links">
          <?php if ($this->article->owner_id == $this->viewer()->getIdentity()) : ?>
          <span id="<?php echo $this->article->artarticle_id ?>"><a href="javascript:void(0);" class="buttonlink <?php echo $subclass ?>"><?php echo $label ?></a></span>
          <?php endif; ?>
          <?php if ($this->photo_upload) : ?>
          <?php echo $this->htmlLink($this->url(array('action' => 'addphoto', 'id' => $this->article->artarticle_id), "advancedarticles_category_specific"), $this->translate('Add Photos'), array(
          'class' => 'buttonlink icon_aphoto_upload', 'title' => $this->translate('Add Photos')));	?>	
          <?php endif; ?>
          <?php if ($this->art_edit) : ?>
          <?php echo $this->htmlLink($this->url(array('action' => 'edit', 'id' => $this->article->artarticle_id), "advancedarticles_category_specific"), $this->translate('Edit'), array(
          'class' => 'buttonlink icon_edit', 'title' => $this->translate('Edit')));	?>
          <?php endif; ?>
          <?php if ($this->art_delete) : ?>
          <?php echo $this->htmlLink($this->url(array('action' => 'delete', 'id' => $this->article->artarticle_id), "advancedarticles_category_specific"), $this->translate('Delete'), array(
          'class' => 'buttonlink icon_art_delete smoothbox', 'title' => $this->translate('Delete')));	?>
          <?php endif; ?>
	  </div>
</div>
<?php endif; ?>	
<script type="text/javascript">
var prefix = '';
  function mrrOff() {
	addres = window.location.href;
    if (addres.split("index.php").length > 1)    
	  prefix = 'index.php/';
  }
mrrOff();
window.addEvent('domready', function() {
   
if ($$('#art_actions div[id=art_action_links]') != null)
  $$('#art_actions div[id=art_action_links] span').addEvent('click', function(e){
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
				
				if ($$('.tip') != null && $$('.tip').getStyle('display') == 'none')
				  $$('.tip').set('style', 'display:block');
				else if ($$('.tip') != null && $$('.tip').getStyle('display') != 'none') {
				    $$('.tip').set('style', 'display:none');  
				}
	        }
		});
	 	status.send('id='+this.id);
  });	
});
</script>