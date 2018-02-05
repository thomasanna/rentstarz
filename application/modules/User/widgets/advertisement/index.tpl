
<?php 
foreach($this->AdvertisementData as $item):?>
		<div class="adv">		
		<a class="example-image-link"  href="<?php echo $this->baseUrl().'/'.$item['image'];?>" data-lightbox="image1"><img src="<?php echo $this->baseUrl().'/'.$item['image']; ?>" width="150px" height="140px" style="object-fit:cover" ></a>	
		<div style="text-align: center;margin-top: 12px;">	
	    <a href="<?php echo $item['ad_url'];?>" style="color: #333;font-size: 16px;"><?php echo $item['title']; ?></a>
		</div>
		</div>
<?php endforeach; 
	
