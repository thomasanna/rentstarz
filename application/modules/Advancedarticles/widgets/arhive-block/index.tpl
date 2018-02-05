<div class="art_user_categories">
<ul>
<?php foreach ($this->archive as $item) : ?>
<li>
<?php echo $this->htmlLink($this->url(array('action' => 'category'),'advancedarticles_general').'?start='.$item["start"].'&end='.$item["end"], $this->translate($item['label']), array('title' => $this->translate($item['label']))); ?>
</li>
<?php endforeach; ?>
</ul>
</div>