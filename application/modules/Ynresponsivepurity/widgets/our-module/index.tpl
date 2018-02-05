<!-- Our Modules Widget-->
<div class="block_ourmodule layout_ynresponsivepurity_blkcont clearfix">
	<h3>
		<?php echo $this -> translate($this -> title);?>
		<small><?php echo $this -> translate($this -> short_description);?></small>
	</h3>
	<p class="leadtext"><?php echo $this -> translate($this -> description)?></p>
	<?php if($this ->modules -> getTotalItemCount()):?>
		<ul class="moduleico_list">
			<?php $i = 0; foreach($this ->modules as $item):?>
			<li>
				<a id = "ynres-purity-module_<?php echo $item -> getIdentity()?>" href="javascript:;" class="md_app <?php if($i == 0) echo 'active';?>" title="<?php echo $item -> title?>" onclick="ynres_active_module(<?php echo $item -> getIdentity()?>)">
					<span style = "background-image:url(<?php echo $item -> getIconURL()?>)"></span>
				</a>
			</li>
			<style type="text/css">
				#ynres-purity-module_<?php echo $item -> getIdentity()?>:hover span,
				#ynres-purity-module_<?php echo $item -> getIdentity()?>.active span,
				li:hover #ynres-purity-module_<?php echo $item -> getIdentity()?> span
				{
					background-image:url(<?php echo $item -> getHoverIconURL()?>) !important;
				}
			</style>
			<?php $i ++; endforeach;?>
		</ul>
		<?php $i = 0; foreach($this ->modules as $item):?>
			<div class="md_desc <?php if($i == 0) echo 'active';?>" id = "ynres-purity-module_des_<?php echo $item -> getIdentity()?>">
				<a href="<?php echo $item -> link;?>"> <h4><?php echo $this -> translate($item -> title)?></h4></a>
				<p><?php echo $this -> translate($item ->description) ?></p>
			</div>
		<?php $i ++; endforeach;?>
	<?php else:?>
		<ul class="moduleico_list">
			<?php for($i = 0; $i < $this -> number_of_module; $i ++):?>
				<li>
					<a id="ynres-purity-module_<?php echo $i?>" href="javascript:;" class="md_app <?php if($i == 0) echo 'active';?>" title="Module name" onclick="ynres_active_module(<?php echo $i?>)">
						<span></span>
					</a>
				</li>
			<?php endfor;?>
		</ul>
		<?php for($i = 0; $i < $this -> number_of_module; $i ++):?>
			<div class="md_desc <?php if($i == 0) echo 'active';?>" id="ynres-purity-module_des_<?php echo $i?>">
				<h4><?php echo $this -> translate("Social Engine")?></h4>
				<p><?php echo $this -> translate("SocialEngine is the best way to create your own social website or online community.<br />No coding or design skills needed. Launch in minutes.")?></p>
			</div>
		<?php endfor;?>
	<?php endif;?>
</div>
<script>
	var ynres_active_module = function(id)
	{
		$$('.md_app').removeClass('active');
		$$('.md_desc').removeClass('active');
		var linkElement = $("ynres-purity-module_" + id);
		var desElement = $("ynres-purity-module_des_" + id);
		linkElement.addClass("active");
		desElement.addClass("active");
	}
</script>