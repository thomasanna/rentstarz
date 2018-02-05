<div  id="products" class="products">
		<div class="container text-center">
			<h2>ARTICLES</h2>
			<hr class="under-heading">
			<div class="row">
			<?php foreach($this->landingpageArticleData as $item) : ?>
				<div class="col-sm-4">
					<div class="product-container first">
						<a class="popup-with-move-anim" href="#">
							<div class="image-container">
								<?php 
      if ($item->photo_id) echo $this->htmlLink($item->getHref(), $this->itemPhoto($item, ''), array('class' => 'a_comments_thumb landinpagearticle'));
      else echo $this->htmlLink($item->getHref(), '<img class="thumb_icon item_photo_artarticle thumb_icon" src="application/modules/Advancedarticles/externals/images/no_art_icon.jpg">', array('class' => 'a_comments_thumb landinpagearticle'));
    ?>
							</div>
						</a>
						<h4 class="landinpagearticle-pricing-pane"> <?php echo $this->htmlLink($item->getHref(), $this->string()->truncate($item->getTitle(), 25)) ?></h4>
						<p><?php echo $this->string()->truncate($item['landingpage_articledescription'],200); ?></p>
						<?php echo $this->htmlLink($item->getHref(), $this->string()->truncate('Read More', 25), array('class' => 'button-solid')) ?>					
					</div>
				</div>
				<?php endforeach;?>	
			</div>
		</div> <!-- end of container -->
	</div>
