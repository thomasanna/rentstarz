<h3>
  <?php echo $this->translate('%1$s &raquo; %2$s',
    $this->htmlLink($this->article->getHref(), $this->string()->truncate($this->article->getTitle(), 100)),
    $this->translate('Manage Photos')
  ); ?> (<?php echo $this->totalPhotos ?>)
</h3>
<!--<div class="art_photo_link">
<?php echo $this->htmlLink($this->url(array('action' => 'allphoto', 'id' => $this->article->artarticle_id), "advancedarticles_category_specific"), $this->translate('View Photos'), array('class' => 'buttonlink icon_aphoto_all')); ?>
<?php if ($this->photo_upload) :?>
<?php echo $this->htmlLink($this->url(array('action' => 'addphoto', 'id' => $this->article->artarticle_id), "advancedarticles_category_specific"), $this->translate('Upload Photos'), array('class' => 'buttonlink icon_aphoto_upload')); ?>
<?php endif; ?>
<?php echo $this->htmlLink($this->url(array('action' => 'editphoto', 'id' => $this->article->artarticle_id), "advancedarticles_category_specific"), $this->translate('Manage Photos'), array('class' => 'buttonlink icon_aphoto_edit')); ?>
</div>-->
<?php if( !$this->totalPhotos ): ?>
    <div class="tip">
      <span>
        <?php echo $this->translate('This article does not have any photos.');?>
        <?php if ($this->photo_upload):?>
          <?php echo $this->translate('Get started by %1$suploading%2$s a new photo!', '<a href="'.$this->url(array('action' => 'addnewphoto', 'id' => $this->article->artarticle_id), "advancedarticles_category_specific").'">', '</a>'); ?>
        <?php endif; ?>
      </span>
    </div>
<?php return; endif; ?>
<?php if ($this->totalPhotos) : ?>
<form action="<?php echo $this->url(array()) ?>" method="post">
<ul class="art_edit_photo">
<?php foreach ($this->paginator as $item) : ?>
<li>
<div class="thumb">
<?php echo $this->htmlLink($item->getHref(), $this->itemPhoto($item, 'thumb.normal')) ?>
</div>
<div class="thumb_info">
<label for="title"><?php echo $this->translate('Title') ?></label>
<input type="text" name="<?php echo $item->getGuid() ?>[title]" value="<?php echo $item->getTitle() ?>" />
<label for="description"><?php echo $this->translate('Description') ?></label>
<textarea name="<?php echo $item->getGuid() ?>[description]"><?php echo $item->getDescription() ?></textarea>
<div class="thumb_action">
<input type="checkbox" name="<?php echo $item->getGuid() ?>[delete]" value="1" /><label for="delete"><?php echo $this->translate('Delete Photo') ?></label>
<input type="radio" name="art_cover" value="<?php echo $item->file_id ?>" <?php if( $this->article->photo_id == $item->file_id ): ?> checked="checked"<?php endif; ?> /><label for="art_cover"><?php echo $this->translate('Article Cover') ?></label>
</div>
</div>
</li>
<?php endforeach; ?>
</ul>
<button name="submit" type="sybmit" ignore=true><?php echo $this->translate("Save Changes") ?></button>
</form>
<br />
    <?php echo $this->paginationControl($this->paginator, null, null, array(
      'pageAsQuery' => true,
      //'query' => $this->formValues,
      //'params' => $this->formValues,
    )); ?>
<?php endif; ?>
