<div class="pharma" style="background:url(<?php echo $this -> background_image?>) no-repeat 0 0">
<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
  <!-- Wrapper for slides -->
	<div class="carousel-inner" role="listbox">
		<?php if($this -> sliders -> getTotalItemCount()):
			$count = 0;
			foreach ($this -> sliders as $item):?>
			<div class="item <?php echo ($count == 0)? 'active' : '' ?>" style="background-image:url(<?php echo $item -> getPhotoUrl();?>)" >
			  <div class="carousel-caption">
				  <?php if($this -> show_title):?>
						<!--<a target="_blank" href="<?php //echo $item -> link;?>">-->
						
							<h3><?php echo $item -> title;?></h3>
						<!--</a>-->
				  <?php endif;?>
				  <?php if($this -> show_description):?>
			    	<p><?php echo $item -> description;?></p>
				  <?php endif;?>
			  </div>
			</div>
			<?php $count++; endforeach;?>
		<?php else:?>
			<div class="item active" style="background-image:url(<?php echo $this -> layout() -> staticBaseUrl?>application/modules/Ynresponsivepurity/externals/images/slider_img1.jpg)" >
				<div class="carousel-caption">
					<?php if($this -> show_title):?>
						<a target="_blank" href="#">
							<h3><?php echo $this -> translate("Responsive Purity Template");?></h3>
						</a>
					<?php endif;?>
					<?php if($this -> show_description):?>
						<p><?php echo $this -> translate("Modern Purity Responsive<br/>
							3 Predefined color skins<br/>
							Modern and simple design<br/>
							Scales and adaps to any resolution<br/>
							Bootstrap framework")?></p>
					<?php endif;?>
				</div>
			</div>
			<div class="item" style="background-image:url(<?php echo $this -> layout() -> staticBaseUrl?>application/modules/Ynresponsivepurity/externals/images/slider_img1.jpg)" >
				<div class="carousel-caption">
					<?php if($this -> show_title):?>
					<a target="_blank" href="#">
						<h3><?php echo $this -> translate("Responsive Purity Template");?></h3>
					</a>
					<?php endif;?>
					<?php if($this -> show_description):?>
					<p><?php echo $this -> translate("Modern Purity Responsive<br/>
						3 Predefined color skins<br/>
						Modern and simple design<br/>
						Scales and adaps to any resolution<br/>
						Bootstrap framework")?></p>
					<?php endif;?>
				</div>
			</div>
			<div class="item" style="background-image:url(<?php echo $this -> layout() -> staticBaseUrl?>application/modules/Ynresponsivepurity/externals/images/slider_img1.jpg)" >
				<div class="carousel-caption">
					<?php if($this -> show_title):?>
					<a target="_blank" href="#">
						<h3><?php echo $this -> translate("Responsive Purity Template");?></h3>
					</a>
					<?php endif;?>
					<?php if($this -> show_description):?>
					<p><?php echo $this -> translate("Modern Purity Responsive<br/>
						3 Predefined color skins<br/>
						Modern and simple design<br/>
						Scales and adaps to any resolution<br/>
						Bootstrap framework")?></p>
					<?php endif;?>
				</div>
			</div>
		<?php endif;?>
	</div>

  <!-- Controls -->
  <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
    <span class="sr-only"><?php echo $this -> translate('Previous');?></span>
  </a>
  <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
    <span class="sr-only"><?php echo $this -> translate('Next');?></span>
  </a>
</div>
</div>

<script>
// Load this when the DOM is ready
jQuery(function(){
  // You used .myCarousel here.
  // That's the class selector not the id selector,
  // which is #myCarousel
  jQuery('#carousel-example-generic').carousel({
  	interval: 2000
  });
});
</script>
