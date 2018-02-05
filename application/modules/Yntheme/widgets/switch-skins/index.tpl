<div class="change_color_scheme_wrapper"> 
	<?php foreach($this->skins as $skin):
		$color_image =  isset($skin['thumb_image'])?$skin['color_image']:'./application/themes/'.$this->theme.'/'. $skin['name']. '/color.gif';
		$thumb_image =  isset($skin['thumb_image'])?$skin['thumb_image']:'./application/themes/'.$this->theme.'/'. $skin['name']. '/theme.jpg';
	?>
	<a href="javascript:void(0)" onclick="yntheme_switch(this);" class="tt" alt="<?php echo $skin['name']; ?>">
			<img src="<?php echo $color_image; ?>"/>
			<span class="tooltip">
				<span class="top"></span>
				<span class="middle"> 
					<img src="<?php echo $thumb_image; ?>" width="200" height="141"/> 
					<div style="text-align:center; color: <?php echo $skin['color']; ?>"><?php echo $skin['title']; ?></div>
				</span>
				<span class="bottom"></span>
			</span>
		</a>	
	<?php endforeach; ?>
</div>
