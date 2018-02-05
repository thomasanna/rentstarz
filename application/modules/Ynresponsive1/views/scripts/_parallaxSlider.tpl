<div id="<?php echo $this->slider_id; ?>" class="pxs_container" style="height:<?php echo $this->height;?>px">
	<div class="pxs_bg" style="background-image: url(<?php echo $this->background_image; ?>)"></div>
	<div class="pxs_loading">Loading images...</div>
	<div class="pxs_slider_wrapper">
		<ul class="pxs_slider">
			<?php foreach($this->items as $item): ?>
			<li>
			  <?php if($this->show_description || $this->show_title): ?>
				<div class = "pxs_slider_content" >
				  <?php if($this->show_title && $item -> getTitle()): ?>
					<h2><?php echo $this->htmlLink($item->getHref(), $item -> getTitle()) ?></h2>
					<?php endif; ?>
					<?php if($this->show_description && $item->getDescription()): ?>
					<P><?php echo $this->escape($item->getDescription());?></P>
					<?php endif; ?>
				</div>
				<?php endif; ?>
				<img src="<?php echo $this->escape($item->getPhotoUrl());?>" alt="<?php echo $this->escape($item->getTitle());?>" />
			</li>
			<?php endforeach; ?>
		</ul>
		<div class="pxs_navigation">
			<span class="pxs_next"></span>
			<span class="pxs_prev"></span>
		</div>
		<ul class="pxs_thumbnails">
		<?php foreach($this->items as $item): ?>
			<li>
			  <img src="<?php echo $this->escape($item->getPhotoUrl('thumb.icon'));?>" alt="<?php echo $this->escape($item->getTitle());?>" />
			</li>
		 <?php endforeach; ?>
		</ul>
	</div>
</div>
<script type="text/javascript">
	jQuery('#<?php echo $this->slider_id; ?>').parallaxSlider();
</script>