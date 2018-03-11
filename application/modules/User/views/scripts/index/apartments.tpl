<?php
    $licount =0; 
	$propertyimageTable    =  Engine_Api::_()->getDbtable('propertyimages', 'user');
	$userTable             =  Engine_Api::_()->getDbtable('users', 'user');
	$postcommentTable      =  Engine_Api::_()->getDbtable('Postcomments', 'user');
	$viewHelperObj         =  $this->getHelper('ItemPhoto');

?>
<ul class='feed' id="activity-feed">
<?php if(count($this->propertyListData) ==0):?>
       <li><div class="notfoundbox">There are no post available for this location</div></li>
<?php else:?>
		<?php foreach($this->propertyListData as $data): ?>
		<?php $UserData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $data['property_owner_id'])); ?>
		<?php if(!empty($UserData)):?>
		<?php
              //  $profileNoPicInfo   =   $viewHelperObj->getNoPhoto($UserData);
                $type               =   'thumb.icon';
                $safeName           =   ( $type ? str_replace('.', '_', $type) : 'main' );
                $src                =   $UserData->getPhotoUrl($type);
                if($src):
                $src                =   $src;
                else:
                $src                =   $viewHelperObj->getNoPhoto($UserData,$safeName);
                endif;
		?>
		
		<?php $licount = $licount+1; ?>
		
			<li  class="activity_item_li activity_item_li_<?php echo $licount?>" licount=<?php echo $licount;?> id="activity-item-<?php echo $data['action_id'] ?>" data-activity-feed-item="<?php echo $data['action_id'] ?>">
			 <div class='feed_item_body feed_item_body_<?php echo $licount?>' licount=<?php echo $licount;?> >
			 
				 <div class="feed_property_locality">
					 <div class="feed_property_name">
						<a class="feed_property_name_link" href="<?php echo $this->baseUrl().'/property/'.$data['id']; ?>" title="View Property"><?php echo $data['property_name'];?> </a>
					 </div>
					 <div class="timestamp feed_timestamp">Posted on: <?php echo $this->timestamp($data['created_at']) ?></div>
					 <div class="feed_property_locality_meta">
						<?php if($data['prty_country'] !=''):?>						
						<?php echo $data['prty_country'];?>
						<?php if($data['prty_state'] !=''):?>
						<?php echo " , ".$data['prty_state']; ?>
						<?php endif;?>
						<?php if($data['prty_city'] !='' && $data['prty_city'] != $data['prty_state']):?>
						<?php echo " , ".$data['prty_city']; ?>
						<?php endif;?>				        
						 <?php if(($data['prty_county'] !='') && ($data['prty_county'] != $data['prty_city'])):?>
						 <?php echo " , ".$data['prty_county']; ?>
						 <?php endif;?>
						 <?php if($data['prty_neighborhood'] !=''):?>
						 <?php echo " , ".$data['prty_neighborhood']; ?>
						 <?php endif;?>
					   
						<?php if($dev_type == 1): // mobile?>
						<a href="<?php echo $this->baseUrl().'/property/map/'.$data['id'] ?>" target="_blank"><img src= "<?php echo $this->baseUrl(); ?>/application/modules/User/externals/images/LOCATION.png" style="margin-top: -4px;"></a>
						<?php else:?>
						<span class="location_icon" data-city= "<?php echo $data['prty_city'];?>" data-id ="<?php echo $data['id'];?>" data-type= "<?php echo 'property';?>" data-lat=<?php echo $data['latitude'];?> data-lng= <?php echo $data['longitude'];?>><img src= "<?php echo $this->baseUrl(); ?>/application/modules/User/externals/images/LOCATION.png" style="margin-top: -4px;"></span>
						<?php endif;?>
						<?php endif;?>				 
					</div>		 
				</div>	
				
				<div class='feed_item_attachments'>
					<span class='feed_attachment_album_photo'>
						
						<div class="feed_property_div">
							<div class="row" style="padding: 12px;">
							<div class="feed_property_image_div">
								<?php
								$propertyImageData         = $propertyimageTable->fetchRow($propertyimageTable->select()->where('property_id = ?', $data['id'])->where('type = "image"'));
								?>
								<a href="<?php echo $this->baseUrl().'/property/'.$data['id'] ?>" title="View Property"><img src="<?php echo $this->baseUrl().'/'.$propertyImageData->image ?>" alt="" class="feed_property_image item_photo_album_photo feed_property_image"></a>
							</div>	
							<div class="property_description">
								<?php 
								$description  = strip_tags($data['description']);
								if(strlen($description)<=300){echo $description;}
								else{$description=substr($description,0,300) . '...'; echo $description;}
								$feedBody =  str_replace("'"," ",$description);
								$feedBody = str_replace(","," ",$feedBody);
								$tagtext    = $data['property_name'];
								$feed_image = '/'.$propertyImageData->image;
								$detailUrl  = '/property/'.$data['id'];
								?>
							</div>
							</div>
						<div class="feed_property_details row" style="margin-bottom: 27px;margin-left: 0px;">
							<div class="property_list_spl housing_type"><span class="qwerty"><img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/images/apartments.svg"></span>  <span class="qwerty_label"><?php echo $data['housing_type'];?></span></div>
							<div class="property_list_spl price"><span class="qwerty"><img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/images/price.png"></span><span class="qwerty_label"> <?php echo $data['price'];?></span></div>
							<div class="property_list_spl bedroom"><span class="qwerty"><img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/images/bedroom.png"></span><span class="qwerty_label"> <?php echo $data['no_of_rooms'];?> Bedroom</span></div>
							<div class="property_list_spl pets"><span class="qwerty">
								<?php if($data['has_pets'] == 'No'):?>
								<img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/images/nopet.png"></span><span class="qwerty_label"> No </span>
								<?php else:?>
								<?php if($data['pets_type']== 'Dogs'):?>
								<img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/images/dog.svg"></span><span class="qwerty_label"> Dog </span>
								<?php elseif($data['pets_type'] == 'Cats'):?>
								<img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/images/cat.svg"></span><span class="qwerty_label"> Cat </span>
								<?php elseif($data['pets_type'] == 'Cats & Dogs'):?>
								<img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/images/catndog.png"></span><span class="qwerty_label"> Cats & Dogs </span>
								<?php elseif($data['pets_type'] == 'Birds'):?>
								<img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/images/bird.svg"></span><span class="qwerty_label"> Birds </span>
								<?php elseif($data['pets_type'] == 'Small pets'):?>
								<img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/images/tortoise.svg"></span><span class="qwerty_label"> Small pets </span>
								<?php endif;?>
								<?php endif;?>
							</div>
						</div>	
						</div>	
					</span>		
				</div>	
				    
			 </div>
		</li>
		<?php endif;?>
		<?php  endforeach; ?>
		
  <?php endif;?>

	</ul>
