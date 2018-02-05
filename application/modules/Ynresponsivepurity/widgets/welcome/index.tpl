<div class="block_welc layout_ynresponsivepurity_blkcont clearfix">
	<?php if($this -> welcomes -> getTotalItemCount()):?>
		<?php
		$col = 0;
		foreach($this -> welcomes as $item): $col ++;?>
			<div class="welc_col col<?php echo $col?>">
				<span class="welc_pic" style="background-image:url(<?php echo $item -> getPhotoUrl();?>)"></span>
				<div class="welc_text">
					<h4><?php echo $this -> translate($item -> title);?></h4>
					<?php echo $this -> translate($item -> description);?>
				</div>
				<a href="<?php echo $item -> link;?>" class="welc_readmore"><?php echo $this -> translate($item -> text_link);?></a>
			</div>
		<?php endforeach;?>
	<?php else:?>
		<div class="welc_col col1">
			<span class="welc_pic"></span>
			<div class="welc_text">
				<h4><?php echo $this -> translate("Introduction")?></h4>
				<?php echo $this -> translate("YouNet SocialEngine is a full service stop for SocialEngine including Module/Plugin, Template, Customization, Custom Design and Dedicated Developer. With more than 100 staffs, 300+ social network projects completed and own defined consulting and development process, we can satisfy most difficult, complex and large scale project requests from customers.")?>
			</div>
			<a href="" class="welc_readmore"><?php echo $this -> translate("Read more")?></a>
		</div>
		<div class="welc_col col2">
			<span class="welc_pic"></span>
			<div class="welc_text">
				<h4><?php echo $this -> translate("Responsive Purity Template")?></h4>
				<?php echo $this -> translate("Responsive Purity Template is an magnificent template with exquisite design and flexibility. Its breath taking and modern look is complimented with ability to configure every component on landing page. It look simple yet elegant. With Responsive feature built into this theme, its beauty is unscathed when viewed on different mobile devices with different screen size.")?>
			</div>
			<a href="" class="welc_readmore"><?php echo $this -> translate("Read more")?></a>
		</div>
		<div class="welc_col col3">
			<span class="welc_pic"></span>
			<div class="welc_text">
				<h4><?php echo $this -> translate("Modern Features")?></h4>
				<?php echo $this -> translate("Inspired Thinking. Ask smarter questions, push for innovative solutions and believe in the power of creativity. Be consistently open and honest. Be true to ourselves and our values. Find, stimulate and maintain the best minds.")?>
			</div>
			<a href="" class="welc_readmore"><?php echo $this -> translate("Read more")?></a>
		</div>
	<?php endif;?>
</div>