<div class="art_related">
<ul>
  <?php foreach( $this->paginator as $item ): ?>
    <li>
    <?php 
      if ($item->photo_id) echo $this->htmlLink($item->getHref(), $this->itemPhoto($item, 'thumb.icon'));
      else echo $this->htmlLink($item->getHref(), '<img class="thumb_icon item_photo_artarticle thumb_icon" src="application/modules/Advancedarticles/externals/images/no_art_icon.png" />');
    ?>
      <div class='title'><b><?php echo $this->htmlLink($item->getHref(), $this->string()->truncate($item->getTitle(), 35)) ?></b></div>
      <div class="art_timestamp">
        <?php echo $this->translate('by'); ?> <?php echo $this->advancedarticlesUser($item->owner_id) ?>
      </div>
      <div class="art_timestamp">
        <?php echo $this->timestamp($item->created_date); ?>
      </div>      
    </li>
  <?php endforeach; ?>
</ul>
</div>