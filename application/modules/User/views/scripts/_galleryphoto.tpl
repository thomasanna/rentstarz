

<?php foreach($this->PhotogalleryData as $data):?>
	
	
	<div class="photo">
	
	<div style="text-align: center;margin-bottom: 5px;"><a class="example-image-link" href="<?php echo $this->baseUrl().'/'.$data['path'];?>" data-lightbox="image1"><img src="<?php echo $this->baseUrl().'/'.$data['path']; ?>" width="130px" height="130px"></a></div>
	<div style="text-align: center;"><?php echo $data['photo_title'];?></div>	
	</div>
	
<?php endforeach;?>

