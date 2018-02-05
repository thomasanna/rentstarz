<div class="a_comments">
<ul>
  <?php foreach($this->paginator as $item) : ?>
  <li>
    <?php 
      if ($item->photo_id) echo $this->htmlLink($item->getHref(), $this->itemPhoto($item, 'thumb.icon'), array('class' => 'a_comments_thumb'));
      else echo $this->htmlLink($item->getHref(), '<img class="thumb_icon item_photo_artarticle thumb_icon" src="application/modules/Advancedarticles/externals/images/no_art_icon.png">', array('class' => 'a_comments_thumb'));
    ?>
      <div class='a_comments_info'>
        <div class='a_comments_title'>
          <?php echo $this->htmlLink($item->getHref(), $this->string()->truncate($item->getTitle(), 25)) ?>
        </div>
        <div class='a_comments_comment'>
          <?php echo $this->translate(array('%s view', '%s views', $item->num_views),$this->locale()->toNumber($item->num_views)) ?>
        </div>
      </div>    
  </li>
  <?php endforeach; ?>
</ul>
</div>