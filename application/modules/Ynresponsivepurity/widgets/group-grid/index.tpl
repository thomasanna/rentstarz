<div class="block_group layout_ynresponsivepurity_blkcont">
	<ul class="clearfix ynresponsivepurity_groupphotogrid">
		<?php foreach($this -> groups as $item):?>
		<li>
			<?php
			$thumb_profile = $item -> getPhotoUrl();
			if(!$thumb_profile)
				$thumb_profile = $this -> layout() -> staticBaseUrl.'application/modules/Ynresponsivepurity/externals/images/no_thumb.png';
			?>
			<a class="group_imgthumbnail" title="<?php echo $item -> getTitle()?>" href="<?php echo $item -> getHref()?>">
				<span style="background-image:url('<?php echo $thumb_profile?>')"><?php echo $item -> getTitle()?></span>
				<strong class="group_textdesc">
					<?php echo $this->string()->truncate(strip_tags($item->description), 100); ?>
				</strong>
			</a>

			<p class="group_textname"><?php echo $this->htmlLink($item->getHref(), $this->translate($item->getTitle())) ?></p>
			<div class="group_shortinfo">
				<span class="group_member"><?php echo $this -> translate(array("%s member", "%s members", $item -> member_count), $item -> member_count);?></span>
				<?php if($item -> getCategory()):?>
					<span class="group_category">
						<?php echo $this -> translate("Category")?>: <?php echo $item -> getCategory() -> getTitle()?>
					</span>
				<?php endif;?>
			</div>
		</li>
		<?php endforeach;?>
	</ul>
</div>
