<script src="/application/modules/User/externals/scripts/message_notififaction.js"></script>
<?php
$useragent   = $_SERVER['HTTP_USER_AGENT'];
$iPod        = stripos($_SERVER['HTTP_USER_AGENT'],"iPod");
$iPhone      = stripos($_SERVER['HTTP_USER_AGENT'],"iPhone");
$iPad        = stripos($_SERVER['HTTP_USER_AGENT'],"iPad");
$Android     = stripos($_SERVER['HTTP_USER_AGENT'],"Android");
$webOS       = stripos($_SERVER['HTTP_USER_AGENT'],"webOS");
if( $iPod || $iPhone || $iPad || $Android)	{ $dev_type= 1; } // mobile	
else{	$dev_type= 2;}   // system
?>

<div class="generic_layout_container layout_user_browse_menu">
<div class="headline">
  <h2> Properties Of <?php echo $this->landlordetails->displayname;?>  </h2>

</div>
</div>
<?php $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); 
$viewer     = Engine_Api::_()->user()->getViewer(); ?>
<div class="property_list_content">
 <?php //echo $this->translate(array('%s properties found', '%s properties found', count($this->propertyData)),$this->locale()->toNumber(count($this->propertyData))) ?>
<div id="browsemembers_ul">
<?php if(count($this->propertyData) > 0):?>
<?php foreach($this->propertyData as $data):?>
<?php
			$propertyimageTable =  Engine_Api::_()->getDbtable('propertyimages', 'user');	
			$propertyVideoSelect   =   $propertyimageTable->select()
							->setIntegrityCheck(false)
							->from(array('pimages'=>'engine4_property_images'))
							->joinLeft(array('file'=>'engine4_storage_files'),'pimages.storage_file_id=file.file_id',array('storage_path','file_id'))
							->where('pimages.property_id=?',$data['id'])
							->where('pimages.type="video"')
							->where('pimages.storage_file_id != ?', 0)
							->group('pimages.property_id');

$propertyVideoData=$propertyimageTable->fetchRow($propertyVideoSelect);			
$video_count=count($propertyVideoData);
$propertyImageDat = $propertyimageTable->fetchAll($propertyimageTable->select()->where('property_id = ?',$data['id'] )->where('type="image"'));
$count=count($propertyImageDat);					
 ?>
<div class="abcd">

<div class="property_title">

	<a href="<?php echo $this->baseUrl().'/property/'.$data['id'] ?>" style="margin-right: 7px;"><?php echo $data['property_name'];?></a>
	
	
    <div class="property_location">
	<?php if($data['prty_country'] !=''):?>
	
		<?php echo $data['prty_country'];?> , <?php echo $data['prty_state'];?> , <?php echo $data['prty_city'];?> 
		<?php if($dev_type == 1): // mobile?>
		<a href="<?php echo $this->baseUrl().'/property/map/'.$data['id'] ?>" target="_blank"><img src= "/application/modules/User/externals/images/LOCATION.png"></a>
	   <?php else:?>
	    <span class="location_icon" data-city ="<?php echo $data['prty_city'];?>" data-id ="<?php echo $data['id'];?>"  data-lat=<?php echo $data['latitude'];?> data-lng= <?php echo $data['longitude'];?>><img src= "/application/modules/User/externals/images/LOCATION.png"></span>
	   <?php endif;?>   	
	<?php endif;?>   	
	</div>
</div>
<div class="property_content">	
	<?php $i=0;
	foreach($propertyImageDat as $image):
	 ?>
	<div class="image_tab">
<span><a href="<?php echo $this->baseUrl().'/property/'.$data['id'] ?>"><img src= <?php echo $this->baseUrl().'/'.$image['image']?> width ="220px" height="200px"></a></span>
	</div>	
    <?php 
				if($video_count>0):
					break;				
				endif;
				if($i == 1): break; endif;	
				$i++;
    endforeach; ?>
		
	<?php if($propertyVideoData['storage_path']):
	$image_file_id	=	$propertyVideoData['file_id'] + 1;
	$imglocation = Engine_Api::_()->storage()->get($image_file_id, 'storage')->getHref(); 
	?>
	<div class="video_tab">

	<div id="videoElement_<?php echo $propertyVideoData['file_id'];?>"></div>
	<script type="text/javascript">
	var playerInstance = jwplayer("videoElement_<?php echo $propertyVideoData['file_id'];?>");
	playerInstance.setup({
		image: "<?php echo $this->baseUrl().$imglocation;?>",
		file: "<?php echo $this->baseUrl().'/'.$propertyVideoData['storage_path'];?>",
		width: 220,
		height: 200
	});

	jQuery('#videoElement_<?php echo $propertyVideoData['file_id'];?>').on('click',function(){
	jwplayer("videoElement_<?php echo $propertyVideoData['file_id'];?>").play();
	});
	</script>

	<?php if($data['video_count']>1):?>
	<!--<span class="video_cnt">+ <?php //echo $data['video_count']-1; ?></span>-->
	<?php endif;?>
	</div>
	<?php endif;?>
	
   <div class="property_discription">
	
	<?php 						
						$description  = strip_tags($data['description']); 
						if(strlen($description)<=300)
						  {
							echo $description;
						  }
						  else
						  {
							$y=substr($description,0,300) . '...';
							echo $y;
						  }?>
	</div>	
	
	<div class="property_list">
	
	<div class="property_list_spl"><span class="qwerty"><img src="/application/modules/User/externals/images/apartments.svg"></span>  <span class="qwerty_label"><?php echo $data['housing_type'];?></span></div>
	<div class="property_list_spl"><span class="qwerty"><img src="/application/modules/User/externals/images/price.png"></span><span class="qwerty_label"> <?php echo $data['price'];?></span></div>
	<div class="property_list_spl"><span class="qwerty"><img src="/application/modules/User/externals/images/bedroom.png"></span><span class="qwerty_label"> <?php echo $data['no_of_rooms'];?> Bedroom</span></div>
	<div class="property_list_spl">
		<?php if($data['has_pets'] == 'No'):?>
		<span class="qwerty"><img src="/application/modules/User/externals/images/nopet.png" width= "29px"></span><span class="qwerty_label"> No </span>
		<?php else: ?>
		<?php if($data['pets_type'] == 'Dogs'):?>
		<span class="qwerty"><img src="/application/modules/User/externals/images/dog.svg" width= "29px"></span><span class="qwerty_label"> Dog </span>
		<?php elseif($data['pets_type'] == 'Cats'):?>
		<span class="qwerty"><img src="/application/modules/User/externals/images/cat.svg" width= "29px"></span><span class="qwerty_label"> Cat </span>
		<?php elseif($data['pets_type'] == 'Cats & Dogs'):?>
		<span class="qwerty"><img src="/application/modules/User/externals/images/catndog.png" width= "29px"></span><span class="qwerty_label"> Cats & Dogs </span>
		<?php elseif($data['pets_type'] == 'Birds'):?>
		<span class="qwerty"><img src="/application/modules/User/externals/images/bird.svg" width= "29px"></span><span class="qwerty_label"> Birds </span>
		<?php elseif($data['pets_type'] == 'Small pets'):?>
		<span class="qwerty"><img src="/application/modules/User/externals/images/tortoise.svg" width= "29px"></span><span class="qwerty_label"> Small pets </span>
	    <?php endif;?>
	    <?php endif;?>
    </div>
    </div>
	
    <?php if($data['status'] != 0):?>
<div class ="property_granted_msg">
<?php if($data['rental_type'] == "Rent"): ?>
<img src="/application/modules/User/externals/images/Group-8.png">
<?php else:
?>
<img src="/application/modules/User/externals/images/tag.png">
<?php endif; ?></div>
    <?php endif; ?>

   <div class="pr_list" ><span class="created_on">Created on  : <?php echo $this->timestamp($data['created_at']);?></span></div>
   <?php if($data['view_count'] !=0):?>
	<img src="/application/modules/User/externals/images/property_views1.png" title="views" style="margin-right: 7px;"> <a class= "view_count" href="javascript:void(0);"><?php echo $data['view_count'];?> views</a>
  <?php endif;?>
	
</div>
</div>

<?php endforeach; ?>
<?php else:?>
<div class="notfound notfoundbox">No properties</div>
<?php endif;?>
</div>
</div>


<!-- map popup ------>
<div id="light2" class="white_content map_popup">

<div class="pop_up_title"><div class="div_attachment_title"></div><div class="div_attachment_cancel"><img src="/application/modules/User/externals/images/GREYcancel.png"></div></div>
<div class="popup_content">
<div class="map_div">
<div id="map"></div>

</div>
</div>
</div>

<div id="fade" class="black_overlay"></div>
<script>
jQuery( ".location_icon" ).click(function() {	

	var id  = jQuery(this).data("id");
	var city  = jQuery(this).data("city");
    var url =  '<?php echo $this->baseUrl().'/property/map/' ?>' +id;	
	 
	jQuery('.div_attachment_title').html();
	jQuery('.div_attachment_title').html('<a href="'+url+'" target="_blank">View Full Map</a>');
	
	jQuery('.map_div').html();
	jQuery('.map_div').html('<div id="map"></div>');
	
	jQuery('#light2').css('display','block');
	jQuery('#fade').css('display','block');
	
    var latitude  = jQuery(this).data("lat");
	var longitude = jQuery(this).data("lng");
	
	var myLatLng = {lat: latitude, lng: longitude};

        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 4,
          center: myLatLng
        });

        var marker = new google.maps.Marker({
          position: myLatLng,
          map: map,
          title: city
        });
});
jQuery('body').on('click', '.div_attachment_cancel', function(event){

	jQuery('#light2').css('display','none');
	jQuery('#fade').css('display','none');
    jQuery('.map_div').html('');
});
</script>
