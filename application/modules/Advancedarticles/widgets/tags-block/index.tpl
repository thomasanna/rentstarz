<div class="a_tags">
<ul>
  <li>
  <?php 
		$minSize = 75;
	    $maxSize = 150;  
	  foreach($this->same_tags as $tag) {
        if ($this->min_tags == $this->max_tags)
            $fontSize = round(($maxSize - $minSize) / 2 + $minSize);
        else
            $fontSize = round((($tag['count'] - $this->min_tags)/($this->max_tags - $this->min_tags)) * ($maxSize - $minSize) + $minSize);
   ?><a href='<?php echo $this->url(array('action' => 'category'),'advancedarticles_general').'?tag='.$tag['tag_id'] ?>' style="font-size:<?php echo $fontSize ?>%"><?php echo $tag['text'] ?><sup><?php echo $tag['count'] ?></sup></a>  <?php } ?>
  </li>
  <?php if ($this->link) : ?>
  <li><a href="<?php echo $this->url(array('action' => 'tagscloud'), 'advancedarticles_general') ?>" class="am_explorer"><?php echo $this->translate('Explore Tags') ?> &raquo;</a></li>
  <?php endif; ?>
</ul>
</div>