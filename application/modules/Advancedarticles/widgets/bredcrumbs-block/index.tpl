<?php  if (isset($this->category->category_id)) : 
$url = !empty($this->category->url) ? '/'.$this->category->url : '';
?>
<div class="bred_crumbs">
  <div class="bred_path"><h3><a href='<?php echo $this->url(array(), 'advancedarticles_general', true) ?>'>Articles</a></h3></div>
  <div class="bred_icon"><h3>&raquo;</h3></div>
  <div class="bred_path"><h3><a href='<?php echo $this->url(array('id' => $this->category->category_id), 'advancedarticles_category_specific', true) . $url ?>'><?php echo $this->category->name ?></a></h3></div>

</div>
<?php endif; ?>
  
