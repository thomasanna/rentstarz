<div class="block_photo layout_ynresponsivepurity_blkcont">
	<ul class="ynresponsivepurity_albumgrid clearfix">
	<?php foreach($this -> photos as $item):?>
		<li>
			<?php
				$thumb_profile = $item -> getPhotoUrl();
				if(!$thumb_profile)
					$thumb_profile = $this -> layout() -> staticBaseUrl.'application/modules/Ynresponsivepurity/externals/images/no_thumb.png';
			?>
			<div>
				<a class="img_albthumb" title="<?php echo $item -> getTitle()?>" href="<?php echo $item -> getHref()?>">
					<span style="background-image:url('<?php echo $thumb_profile?>')"></span>
				</a>
				<span class="text_albname">
					<em><?php echo $this -> translate("in album %s", $item -> getParent());?></em>
				</span>
			</div>
		</li>
	<?php endforeach;?>
	</ul>
</div>