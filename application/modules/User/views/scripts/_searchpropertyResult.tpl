
<?php 
$online_users=$this->online_users;
//print_r($online_users);exit;
   $online_user_id = array();
   foreach($online_users as $row):

   $online_user_id[]=$row['user_id'];
   endforeach;

    ?>
  <?php foreach($this->propertyData as $properities):?>
  
  <?php
			$propertyimageTable =  Engine_Api::_()->getDbtable('propertyimages', 'user');	
			$propertyVideoSelect   =   $propertyimageTable->select()
							->setIntegrityCheck(false)
							->from(array('pimages'=>'engine4_property_images'))
							->joinLeft(array('file'=>'engine4_storage_files'),'pimages.storage_file_id=file.file_id',array('storage_path','file_id'))
							->where('pimages.property_id=?',$properities['id'])
							->where('pimages.type="video"')
							->where('pimages.storage_file_id != ?', 0)
							->group('pimages.property_id');

			$propertyVideoData=$propertyimageTable->fetchRow($propertyVideoSelect);
			
			$video_count=count($propertyVideoData);

			$propertyImageDat = $propertyimageTable->fetchAll($propertyimageTable->select()->where('property_id = ?',$properities['id'] )->where('type="image"'));

			$count=count($propertyImageDat);	
			
            ?>
        <li>
			
		<div class="property_title">
         <a href="<?php echo $this->baseUrl().'/property/'.$properities['id'] ?>"><?php echo $properities['property_name']; ?></a>                                 
        <div class="property_location">
		<?php if($properities['prty_country'] !=''):?>	
			<?php echo $properities['prty_country'];?> , <?php echo $properities['prty_state'];?> , <?php echo $properities['prty_city'];?>  
			<?php if($dev_type == 1): // mobile?>
			
			 <a href="<?php echo $this->baseUrl().'/property/map/'.$properities['id'] ?>" target="_blank"> 
			 <img src= "/application/modules/User/externals/images/LOCATION.png" style="margin-top: -4px;">
		     <?php else:?>
		    <span class="location_icon" data-city ="<?php echo $properities['prty_city'];?>" data-id ="<?php echo $properities['id'];?>"  data-lat=<?php echo $properities['latitude'];?> data-lng= <?php echo $properities['longitude'];?>>
			<img src= "/application/modules/User/externals/images/LOCATION.png"></span>  
		
		<?php endif;?>   	 
		<?php endif;?>   	 
		
		</div>
        
        
        </div>
        
        <div class="property_wrap_content">
        
		 <?php $i=0;
		 
		foreach($propertyImageDat as $image):
		 ?>
		 
		<div class="property_image">	
        <a href="<?php echo $this->baseUrl().'/property/'.$properities['id'] ?>"><img src= <?php echo $this->baseUrl().'/'.$image['image']?> title="View Property" width ="250px" height="200px"></a>            
        </div>
        
        <?php 
        
        $i++;
        
        if($i == 1): break; endif;	
			/*	if($video_count>0):
					break;				
				endif;
				if($i == 1): break; endif;	
				$i++; */
        endforeach; ?>
        
        

			<?php if($propertyVideoData['storage_path']):
			$image_file_id	=	$propertyVideoData['file_id'] + 1;
			$imglocation = Engine_Api::_()->storage()->get($image_file_id, 'storage')->getHref(); 
			?>
			
			<?php /*<div class="property_video">
			
			<div id="videoElement_<?php echo $propertyVideoData['file_id'];?>"></div>
			<script type="text/javascript">
			var playerInstance = jwplayer("videoElement_<?php echo $propertyVideoData['file_id'];?>");
			playerInstance.setup({
				image: "<?php echo $this->baseUrl().$imglocation;?>",
				file: "<?php echo $this->baseUrl().'/'.$propertyVideoData['storage_path'];?>",
				width: 280,
				height: 200
			});

			jQuery('#videoElement_<?php echo $propertyVideoData['file_id'];?>').on('click',function(){
			jwplayer("videoElement_<?php echo $propertyVideoData['file_id'];?>").play();
			});
			</script>
			
			<?php if($data['video_count']>1):?>
			<!--<span class="video_cnt">+ <?php //echo $data['video_count']-1; ?></span>-->
			<?php endif;?>
			</div> */ ?>
			<?php endif;?>
				
        <div class="property_description">
						
						<?php 
						$description  = strip_tags($properities['description']); 
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
        <?php if($properities['rental_type']== 'Lease'):?> 
      
	        <span><img src="/application/modules/User/externals/images/lease.png" alt="" class="feed_property_rentaltype_image"> </span>
				   
		    <?php else:?>
			<span><img src="/application/modules/User/externals/images/rent.png" alt="" class="feed_property_rentaltype_image"> </span>
				   
		<?php endif; ?>
        
        
        <div class="property_details">
	
	    <div class="property_list_spl"><span class="qwerty"><img src="/application/modules/User/externals/images/apartments.svg"></span>  <span class="qwerty_label"><?php echo $properities['housing_type'];?></span></div>
		<div class="property_list_spl"><span class="qwerty"><img src="/application/modules/User/externals/images/price.png"></span><span class="qwerty_label"> <?php echo $properities['price'];?></span></div>
		<div class="property_list_spl"><span class="qwerty"><img src="/application/modules/User/externals/images/bedroom.png"></span><span class="qwerty_label"> <?php echo $properities['no_of_rooms'];?> Bedroom</span></div>
		<div class="property_list_spl"><span class="qwerty">
			<?php if($properities['has_pets'] == 'No'):?>
			<img src="/application/modules/User/externals/images/nopet.png"></span><span class="qwerty_label"> No </span>
			<?php else:?>
			<?php if($properities['pets_type'] == 'Dogs'):?>
			<img src="/application/modules/User/externals/images/dog.svg"></span><span class="qwerty_label"> Dog </span>
			<?php elseif($properities['pets_type'] == 'Cats'):?>
			<img src="/application/modules/User/externals/images/cat.svg"></span><span class="qwerty_label"> Cat </span>
			<?php elseif($properities['pets_type'] == 'Cats & Dogs'):?>
			<img src="/application/modules/User/externals/images/catndog.png"></span><span class="qwerty_label"> Cats & Dogs </span>
			<?php elseif($properities['pets_type'] == 'Birds'):?>
			<img src="/application/modules/User/externals/images/bird.svg"></span><span class="qwerty_label"> Birds </span>
			<?php elseif($properities['pets_type'] == 'Small pets'):?>
			<img src="/application/modules/User/externals/images/tortoise.svg"></span><span class="qwerty_label"> Small pets </span>
			<?php endif;?>
			<?php endif;?>
		</div>
    </div>
    
    <?php if($properities['status'] != 0):?>
<div class ="property_granted_msg">
<?php if($properities['rental_type'] == "Rent"): ?>
<img src="/application/modules/User/externals/images/Group-8.png">
<?php else:
?>
<img src="/application/modules/User/externals/images/tag.png">
<?php endif; ?>
</div>
	<?php endif; ?> 
    
    </div>
    

    
        
      <?php /*  <div class="property_owner_data">
		<div class="property_owner_image">
        <?php 
          $userTable = Engine_Api::_()->getDbtable('users', 'user');
          $property_owner = $userTable->fetchRow($userTable->select()->where('user_id = ?', $properities['property_owner_id']));
	      echo $this->htmlLink($property_owner->getHref(), $this->itemPhoto($property_owner, 'thumb.icon', array('class' => 'photo'))); 

		  $propertyTable =  Engine_Api::_()->getDbtable('propertylist', 'user');	
		  $properties_of_user= $propertyTable->select()
                        ->setIntegrityCheck(false)
						->from(array('plist'=>'engine4_property_list',array()))
						->where('plist.enable=?' , 1)     						
						->where('plist.landlord_enable=?' , 1)     						
						->where('plist.property_owner_id =?' , $properities['property_owner_id'])     						
						->query()->fetchAll();

        ?>
        </div>	
        <div class="property_owner_name">
			    <?php	if(in_array($properities['property_owner_id'],$online_user_id)):?>

	    <span class="led-green"></span>
		
		<?php  endif; ?>
		<span>
        <?php  echo $properities['displayname'];?>
        </span>
        <span class="property_meta"><?php echo count($properties_of_user);?> Properties <img src= "/application/modules/User/externals/images/Forma-3.png" width="19px"></span>
        </div>
        </div> */?>
        </li>
        <?php endforeach;?> 


