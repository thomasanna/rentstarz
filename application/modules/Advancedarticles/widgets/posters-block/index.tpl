<div class="art_top_posters">
<ul>
  <?php foreach($this->paginator as $item) : ?>
  <li>
    <?php
      $user = $this->advancedarticlesUser($item->id);
      echo $this->htmlLink($user->getHref(), $this->itemPhoto($user, 'thumb.icon'));
    ?>
      <div class='title'>
          <?php echo $this->htmlLink($user->getHref(), $user->getTitle()) ?>
      </div>
      <div class="posters_articles"><a href="<?php echo $this->url(array('action' => 'category'),'advancedarticles_general').'?owner='.$user->getIdentity() ?>" id="<?php echo $user->getIdentity() ?>"><?php echo $this->translate(array('%s article', '%s articles', $item->articles_count),$this->locale()->toNumber($item->articles_count)) ?></a></div>
  </li>
  <?php endforeach; ?>
</ul>
</div>