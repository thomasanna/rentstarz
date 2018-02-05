<div id="accordion">
  <?php 
  $menu_current = -1;
  $main = -1;
  $parent_id = 0;
  $count_cat = count($this->categories);
  for ($i = 0; $i < $count_cat; $i++) :
  		$category = (object) $this->categories[$i];
		$url = !empty($category->url) ? '/'.$category->url : '';
		 ?>
	<?php if (!$category->parent_id && $parent_id != $category->parent_id) : ?>
	</div>
	<?php endif; ?>	
  <?php if (!$category->depth) : 
  $main++;
  if ($category->category_id == $this->cid) {
    $menu_current = $main;
  }	
  ?>
	<div class="menu-top" id="menu-top"><a href='<?php echo $this->url(array('id' => $category->category_id), 'advancedarticles_category_specific', true) . $url ?>'><?php echo $this->translate($category->name); ?></a></div>
	<div class="content_menu">
	<?php $parent_id = $category->category_id; ?>
  <?php else:
    $selected = '';
	if ($category->category_id == $this->cid) { 
	  $menu_current = $main;  
	  $selected = "font-weight:bold";
	}  
  ?>
	<p id="sub_id_<?php echo $category->category_id; ?>">
	<a href='<?php echo $this->url(array('id' => $category->category_id), 'advancedarticles_category_specific', true) . $url ?>' class="buttonlink icon_article" style = "<?php echo $selected ?>">
              <?php echo $this->translate($category->name); ?></a></p>
  <?php endif; ?>
	<?php if ($i == $count_cat-1) : ?>
	</div>
	<?php endif; ?>
  <?php endfor; ?>
</div>

<script type="text/javascript">
window.addEvent('domready', function(){
  new Fx.Accordion($('accordion'), '#accordion .menu-top', '#accordion .content_menu', {
    display: <?php echo $menu_current ?>,
    alwaysHide: true,
    onActive: function(accordion) { 
	  accordion.removeClass('no_expand');
	  accordion.addClass('expand'); 
      accordion.setStyle('font-weight', 'bold');	  
	},
    onBackground: function(accordion) {
	  accordion.setStyle('font-weight', 'normal');
	  accordion.removeClass('expand');
      accordion.addClass('no_expand');	  
    }
  });
  
  /*items = $('accordion').getElements('div[class=content_menu]');
  parents = $('accordion').getElements('div[id=menu-top]');
  items.each(function(item, i) {
    if (item.getElement('p') == null) {
      parents[i].set('style', 'background-image: none');
    }
  });*/  
});
</script>