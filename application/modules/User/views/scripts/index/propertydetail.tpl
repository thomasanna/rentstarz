   <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBu9XKcmt0tOyJeZFlJ4wpgNytA8f1DX2U"
        type="text/javascript"></script>
 <div class="bannerSlider">
	 <?php foreach ($this->propertyImageData as $propertyImage ):?>
          <div class="item" style="background-image:url('<?php echo $this->baseUrl().'/'.$propertyImage['image'];?>');">
            <div class="bannerText">
                <h1><?php echo $this->propertyData->property_name;?></h1>
                <?php if($this->propertyData->prty_country  !=''):?>
	             <p><?php echo $this->propertyData->prty_country;?> , <?php echo $this->propertyData->prty_state;?> , <?php echo $this->propertyData->prty_city;?> </p>
                <?php endif; ?>
            </div>
        </div>
    <?php endforeach;?>
</div>



    <section class="aboutus">
        <div class="container">
            <div class="sec1">
                <div class="row">
                    <h3>ABOUT PROPERTY</h3>
                    <p><?php echo $this->propertyData->description;?></p>
                </div>
            </div>
        </div>
    </section>


    <!--------------------------------------------features------------------------------------------------------->

    <section class="features">
        <div class="container">
            <h3>FEATURES</h3>
            <ul>
                <li>
                    <img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/images/bedroom.png" alt="">
                    <h4 class="txt-black">Bedroom</h4>
                    <p class="txt-black"><?php echo $this->propertyData->no_of_rooms;?></p>
                </li>
                <li>
                    <img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/images/apartments.svg" alt="">
                    <h4 class="txt-black">Property Type</h4>
                    <p class="txt-black"> <?php echo $this->propertyData->housing_type;?></p>
                </li>
                <li>
					<?php if($this->propertyData->has_pets == 'No'):?>
						<img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/images/nopet.png" alt="">
						<h4 class="txt-black">Pets</h4>
						<p class="txt-black">No</p>

					<?php else:?>
					   <?php if($this->propertyData->pets_type == 'Dogs'):?>
					    <img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/images/dog.svg" alt="">
						<h4 class="txt-black">Pets</h4>
						<p class="txt-black">Dog</p>
					   <?php endif; ?>
					   <?php if($this->propertyData->pets_type == 'Cats'):?>
					    <img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/images/cat.svg" alt="">
						<h4 class="txt-black">Pets</h4>
						<p class="txt-black">Cats</p>
					   <?php endif; ?>
					   <?php if($this->propertyData->pets_type == 'Cats & Dogs'):?>
					    <img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/images/catndog.svg" alt="">
						<h4 class="txt-black">Pets</h4>
						<p class="txt-black">Cats & Dogs</p>
					   <?php endif; ?>
					   <?php if($this->propertyData->pets_type == 'Birds'):?>
					    <img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/images/bird.svg" alt="">
						<h4 class="txt-black">Pets</h4>
						<p class="txt-black">Birds</p>
					   <?php endif; ?>
					   <?php if($this->propertyData->pets_type == 'Small pets'):?>
					    <img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/images/tortoise.svg" alt="">
						<h4 class="txt-black">Pets</h4>
						<p class="txt-black">Small pets</p>
					   <?php endif; ?>
						
                    <?php endif; ?>
                </li>
                <li>
                    <img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/assets/images/property/price.png" alt="">
                    <h4 class="txt-black">Price</h4>
                    <p class="txt-black"><?php echo $this->propertyData->price;?></p>
                </li>
            </ul>
            <ul id="ul2">
				<?php  if($this->propertyData->vouchers	=='Yes'):?>
                <li>
                    <img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/assets/images/property/voucher.png" alt="">
                    <h4 class="txt-black">Voucher</h4>
                </li>
                <?php endif; ?>
                
            </ul>
        </div>
    </section>


    <!--    VIDEO-->

    <section>
        <div class="container">
			<?php if(count($this->propertyVideoData)>0) : ?>
				<?php foreach($this->propertyVideoData as $videos):
					if($videos['storage_path']):
					$image_file_id	=	$videos['file_id'] + 1;
					$imglocation = Engine_Api::_()->storage()->get($image_file_id, 'storage')->getHref(); 
					endif;
				?>
				<div class="video-wrapper" id="videoElement_<?php echo $videos['file_id'];?>">
	<!--
					<video class="video" id="bVideo" loop="">
					<source src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/assets/images/property/Building.mp4" poster="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/assets/images/property/Building.mp4" type="video/mp4">
					</video>
					<div id="playButton" class="playButton" onclick="playPause()"></div>
	-->
				</div>
				<script type="text/javascript">		
				var playerInstance = jwplayer("videoElement_<?php echo $videos['file_id'];?>");
				playerInstance.setup({
					image: "<?php echo $this->baseUrl().$imglocation;?>",
					file: "<?php echo $this->baseUrl().'/'.$videos['storage_path'];?>",
					width: 205,
					height: 199
				});
				</script>
				<?php break; ?>
				<?php endforeach;?>
            <?php endif; ?>

        </div>
    </section>


    <!--    map-->
    <section>
        <div class="map" id ="mapCanvas" style=" position: relative !important;
		overflow: hidden !important;
		height: 400px !important;
		width: 100% !important;">
        </div>
    </section>

    <!--    social-->


    <section>
        <div class="container">

            <h3>SOCIAL DETAILS</h3>
            <div class="socialdetails">
                <div class="social">
                    <ul>
                        <li>
                            <h6>Views</h6>
                            <p class="txt-black"><?php echo  $this->propertyData->view_count;?></p>
                        </li>
                        <li>
                            <h6>Comments</h6>
                            <p class="txt-black"><?php echo $this->commentcount; ?></p>
                        </li>
                        <li>
                            <h6>Likes</h6>
                            <p class="txt-black">200</p>
                        </li>
                    </ul>
                </div>
                <div class="shared">
                    <h5>Shared</h5>
                    <ul>
                        <li>twitter <span>29</span></li>
                        <li>facebook <span>29</span></li>
                        <li>instagram <span>29</span></li>
                    </ul>
                </div>
            </div>
        </div>
    </section>


    <!--    agent-->

    <section>
        <div class="container">
            
                <h3>AGENT</h3>
                <div class="agent">
                <div class="row">
                   
                    <div class="col-sm-2 col-xs-12">
                        <div class="agentimg"><?php echo $this->htmlLink($this->landlordUser->getHref(), $this->itemPhoto($this->landlordUser, 'thumb.icon', $this->landlordUser->getTitle()), array('title'=>$this->landlordUser->getTitle())) ?></div>
                    </div>
                    <div class="col-sm-10  col-xs-12">
                        <div class="title">
                            <div class="col-sm-6">
                                <div class="agentName">
                                    <h3><?php echo $this->htmlLink($this->landlordUser->getHref(), ucwords($this->landlordUser->getTitle()))?></h3>
                                    <p class="txt-black">USA , <?php echo $this->landlordUser->state; ?>,  <?php echo $this->landlordUser->city; ?>		</p>
                                </div>
                            </div>
                            
                            <div class="col-sm-6">
                                <div class="agentcontact">
                                    <ul>
                                        <li>Message</li>
                                        <li>Video</li>
                                    </ul>
                                </div>
                            </div>
                            
                            <div class="col-sm-12">
                                <div class="agentInfo">
                                    <h4></h4>
                                    <p class="txt-black"></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>


<script>
// $('.bannerSlider').slick();
jQuery('.bannerSlider').slick({
	dots: true,
	autoplay: true,
	infinite: true,
	speed: 500,
	slidesToShow: 1
	//   adaptiveHeight: true
});

jQuery( document ).ready(function() {
    initMap()
});        

function initMap() {
	var lati  = '<?php echo $this->propertyData->latitude ?>'; 
    var longi = '<?php echo $this->propertyData->longitude ?>'; 
	var uluru = { lat: parseFloat(lati), lng:parseFloat(longi) };
	var map = new google.maps.Map(document.getElementById('mapCanvas'), {
		zoom: 15,
		center: uluru
	});
	var marker = new google.maps.Marker({
		position: uluru,
		map: map
	});
}
   

</script>
