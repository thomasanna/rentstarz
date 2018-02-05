<?php  $settings = Engine_Api::_()->getApi('settings', 'core');  ?>
<div id="team" class="team">
		<div class="container text-center">		
		<div class="row">		
			<h2><?php echo $settings->user_featuredstoryTitle;?></h2>
			<hr class="under-heading">
			<div class="team-member col-sm-6">
				<div class="image-container">
					<img src="<?php echo $this->baseUrl().'/'.$settings->user_FeaturedstoryImage ;?>" alt="">				
				</div>	
			</div>
			<div class="team-member col-sm-6">
				<div class="image-container">
					<p class="text-left"><?php echo $this->string()->truncate(strip_tags($settings->user_featuredstory),1000);?>	</p>					
				<a style="width:150px;margin-top:10px; float:right;" class="button-solid" href="/featuredstory">READ MORE</a>
				</div>	
			</div>
		</div></div>
	</div>
