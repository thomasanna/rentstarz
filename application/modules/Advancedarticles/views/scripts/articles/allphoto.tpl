<h3>
  <?php echo $this->translate('%1$s &raquo; %2$s',
    $this->htmlLink($this->article->getHref(), $this->string()->truncate($this->article->getTitle(), 100)),
    $this->translate('Photos')
  ); ?>
</h3>
<div class="art_photo_link">
<?php echo $this->htmlLink($this->url(array('action' => 'allphoto', 'id' => $this->article->artarticle_id), "advancedarticles_category_specific"), $this->translate('View Photos'), array('class' => 'buttonlink icon_aphoto_all')); ?>
<?php if ($this->photo_upload) :?>
<?php echo $this->htmlLink($this->url(array('action' => 'addphoto', 'id' => $this->article->artarticle_id), "advancedarticles_category_specific"), $this->translate('Upload Photos'), array('class' => 'buttonlink icon_aphoto_upload')); ?>
<?php endif; ?>
<?php if ($this->photo_edit) :?>
<?php echo $this->htmlLink($this->url(array('action' => 'editphoto', 'id' => $this->article->artarticle_id), "advancedarticles_category_specific"), $this->translate('Manage Photos'), array('class' => 'buttonlink icon_aphoto_edit')); ?>
<?php endif; ?>
</div>
<?php if( !$this->totalPhotos ): ?>
    <div class="tip">
      <span>
        <?php echo $this->translate('This article does not have any photos.');?>
        <?php if ($this->photo_upload):?>
          <?php echo $this->translate('Get started by %1$suploading%2$s a new photo!', '<a href="'.$this->url(array('action' => 'addphoto', 'id' => $this->article->artarticle_id), "advancedarticles_category_specific").'">', '</a>'); ?>
        <?php endif; ?>
      </span>
    </div>
<?php return; endif; ?>
<?php if ($this->totalPhotos) : ?>
<ul class="thumbs thumbs_nocaptions">
<?php foreach ($this->paginator as $item) : ?>
<li>
<a class="thumbs_photo" href="<?php echo $item->getHref(); ?>">
<span style="background-image: url(<?php echo $item->getPhotoUrl('thumb.normal'); ?>);"></span>
</a>
</li>
<?php endforeach; ?>
</ul>
<br />
    <?php echo $this->paginationControl($this->paginator, null, null, array(
      'pageAsQuery' => true,
      //'query' => $this->formValues,
      //'params' => $this->formValues,
    )); ?>
<?php endif; ?>
