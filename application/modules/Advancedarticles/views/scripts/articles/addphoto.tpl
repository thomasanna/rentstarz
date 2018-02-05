<h3>
  <?php echo $this->translate('%1$s &raquo; %2$s',
    $this->htmlLink($this->article->getHref(), $this->string()->truncate($this->article->getTitle(), 100)),
    $this->translate('Photos')
  ); ?>
</h3>
<div class="art_photo_link">
<?php echo $this->htmlLink($this->url(array('action' => 'allphoto', 'id' => $this->article->artarticle_id), "advancedarticles_category_specific"), $this->translate('View Photos'), array('class' => 'buttonlink icon_aphoto_all')); ?>
</div>
<?php echo $this->form->render($this) ?>
