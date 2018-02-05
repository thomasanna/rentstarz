<?php
  $this->headScript()
    ->appendFile($this->baseUrl() . '/externals/moolasso/Lasso.js')
    ->appendFile($this->baseUrl() . '/externals/moolasso/Lasso.Crop.js')
    ->appendFile($this->baseUrl() . '/externals/autocompleter/Observer.js')
    ->appendFile($this->baseUrl() . '/externals/autocompleter/Autocompleter.js')
    ->appendFile($this->baseUrl() . '/externals/autocompleter/Autocompleter.Local.js')
    ->appendFile($this->baseUrl() . '/externals/autocompleter/Autocompleter.Request.js')
    ->appendFile($this->baseUrl() . '/externals/tagger/tagger.js');    
?>  
<script type="text/javascript">
var taggerInstance;
en4.core.runonce.add(function() {
  taggerInstance = new Tagger('art_photo_next', {
    'title' : '<?php echo $this->translate('ADD TAG');?>',
    'description' : '<?php echo $this->translate('Type a tag or select a name from the list.');?>',
    'createRequestOptions' : {
      'url' : '<?php echo $this->url(array('module' => 'core', 'controller' => 'tag', 'action' => 'add'), 'default', true) ?>',
      'data' : {
        'subject' : '<?php echo $this->subject()->getGuid() ?>'
      }
    },
    'deleteRequestOptions' : {
      'url' : '<?php echo $this->url(array('module' => 'core', 'controller' => 'tag', 'action' => 'remove'), 'default', true) ?>',
      'data' : {
        'subject' : '<?php echo $this->subject()->getGuid() ?>'
      }
    },
    'cropOptions' : {
      'container' : $('art_photo_next')
    },
    'existingTags' : <?php echo $this->action('retrieve', 'tag', 'core', array('sendNow' => false)) ?>,
    'suggestParam' : "<?php echo $this->url(array('module' => 'user', 'controller' => 'friends', 'action' => 'suggest', 'includeSelf' => true), 'default', true) ?>",
    'guid' : <?php echo $this->viewer()->getIdentity() ? "'".$this->viewer()->getGuid()."'" : 'false' ?>,
    'tagListElement' : 'media_tags',
    'enableCreate' : <?php echo $this->photo_upload ?> ? 'true' : 'false',
    'enableDelete' : <?php echo $this->photo_delete ?> ? 'true' : 'false',
    'suggestProto' : 'request.json'
  });
  var nextHref = $('art_photo_next').get('href');
  taggerInstance.addEvents({
    'onBegin' : function() {
      $('art_photo_next').erase('href');
    },
    'onEnd' : function() {
      $('art_photo_next').set('href', nextHref);
    }
  });
});
</script>

<h3>
  <?php echo $this->translate('%1$s &raquo; %2$s',
    $this->htmlLink($this->article->getHref(), $this->string()->truncate($this->article->getTitle(), 100)),
    $this->translate('Photos')
  ); ?>
</h3>
<!--<div class="art_photo_link">
<?php //echo $this->htmlLink($this->url(array('action' => 'allphoto', 'id' => $this->article->artarticle_id), "advancedarticles_category_specific"), $this->translate('View Photos'), array('class' => 'buttonlink icon_aphoto_all')); ?>
<?php //if ($this->photo_upload) :?>
<?php //echo $this->htmlLink($this->url(array('action' => 'addphoto', 'id' => $this->article->artarticle_id), "advancedarticles_category_specific"), $this->translate('Upload Photos'), array('class' => 'buttonlink icon_aphoto_upload')); ?>
<?php //endif; ?>
<?php //if ($this->photo_edit) :?>
<?php //echo $this->htmlLink($this->url(array('action' => 'editphoto', 'id' => $this->article->artarticle_id), "advancedarticles_category_specific"), $this->translate('Manage Photos'), array('class' => 'buttonlink icon_aphoto_edit')); ?>
<?php //endif; ?>
</div>-->

<div class="art_view_photo">
<!--<div class="navi_bar">
    <div id="left">
    <?php echo $this->translate('Photo %1$s of %2$s', $this->locale()->toNumber($this->art_photo->getCollectionIndex() + 1), $this->locale()->toNumber($this->art_album->count())) ?>
    </div>
    <div id="right">
    <?php if ($this->art_album->count() > 1): ?>     
      <?php echo $this->htmlLink($this->art_photo->getPrevCollectible()->getHref(), $this->translate('Prev')) ?>
      <?php echo $this->htmlLink($this->art_photo->getNextCollectible()->getHref(), $this->translate('Next')) ?>
    <?php endif; ?>      
    </div>   
</div>    -->
<div class="art_view_photo_block">
<div class="art_thumb">
      <a id="art_photo_next" href='<?php echo $this->art_photo->getNextCollectible()->getHref() ?>'>
        <?php echo $this->htmlImage($this->art_photo->getPhotoUrl(), $this->art_photo->getTitle()); ?>
      </a>
</div>

<div class="navi_bar">
    <div id="left">
    <?php //echo $this->translate('Photo %1$s of %2$s', $this->locale()->toNumber($this->art_photo->getCollectionIndex() + 1), $this->locale()->toNumber($this->art_album->count())) ?>
    </div>
    <div id="right">
		<?php echo $this->translate('Photo %1$s of %2$s', $this->locale()->toNumber($this->art_photo->getCollectionIndex() + 1), $this->locale()->toNumber($this->art_album->count())) ?>
    <?php if ($this->art_album->count() > 1): ?>     
      <?php echo $this->htmlLink($this->art_photo->getPrevCollectible()->getHref(), $this->translate('Prev')) ?>
      <?php echo $this->htmlLink($this->art_photo->getNextCollectible()->getHref(), $this->translate('Next')) ?>
    <?php endif; ?>      
    </div>   
</div>  
<!--<div class="art_photo_action">
<div><b><?php echo $this->art_photo->getTitle() ?></b></div>
<div class="description"><?php echo $this->art_photo->getDescription() ?></div>
<?php echo $this->translate('Added by'); ?> <?php echo $this->htmlLink($this->article->getHref(), $this->advancedarticlesUser($this->article->owner_id)) ?> <?php echo $this->timestamp($this->art_photo->created_date) ?>

<div class="info_tags" id="media_tags" style="display: none;">
<?php echo $this->translate('Tagged:') ?>
</div>

<div class="photo_share_report">
<?php if ($this->photo_edit || $this->photo_upload ) :?>
<?php echo $this->htmlLink('javascript:void(0)', $this->translate('Add Tag'), array('onclick'=>'taggerInstance.begin()')) ?>
 -
<?php endif; ?>
<?php if ($this->photo_edit) :?> 
<?php echo $this->htmlLink($this->url(array('action' => 'photo-edit', 'id' => $this->art_photo->getIdentity()), 'advancedarticles_category_specific'), $this->translate('Edit'), array('class' => 'smoothbox', 'title' => $this->translate('Edit'))); ?>      
 -
<?php endif; ?>
<?php if ($this->photo_delete) :?>
<?php echo $this->htmlLink($this->url(array('action' => 'photo-delete', 'id' => $this->art_photo->getIdentity()), 'advancedarticles_category_specific'), $this->translate('Delete'), array('class' => 'smoothbox', 'title' => $this->translate('Delete'))); ?>      
 -
<?php endif; ?>
<?php echo $this->htmlLink(array('route' => 'default', 'module' => 'activity', 'controller' => 'index', 'action' => 'share', 'type'=>'advancedarticles_photo', 'id' => $this->art_photo->getIdentity(), 'format' => 'smoothbox'), $this->translate('Share'), array('class' => 'smoothbox', 'title' => $this->translate('Share'))); ?>
 -
<?php echo $this->htmlLink(array('route' => 'default', 'module' => 'core', 'controller' => 'report', 'action' => 'create', 'subject' => $this->art_photo->getGuid(), 'format' => 'smoothbox'), $this->translate('Report'), array('title' => $this->translate('Report'), 'onclick' => "parent.Smoothbox.open(this.href); return false;")); ?>
 -
<?php echo $this->htmlLink(array('route' => 'user_extended', 'module' => 'user', 'controller' => 'edit', 'action' => 'external-photo', 'photo' => $this->art_photo->getGuid(), 'format' => 'smoothbox'), $this->translate('Make Profile Photo'), array('class' => 'smoothbox')) ?>
</div>
</div>
</div>
<?php echo $this->action("list", "comment", "core", array("type"=>"advancedarticles_photo", "id"=>$this->art_photo->getIdentity())) ?>
</div>-->
