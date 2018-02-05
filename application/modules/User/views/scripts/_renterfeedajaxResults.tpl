<?php 
    $status    =   'false';
    
	$useragent     = $_SERVER['HTTP_USER_AGENT'];
	$iPod          = stripos($_SERVER['HTTP_USER_AGENT'],"iPod");
	$iPhone        = stripos($_SERVER['HTTP_USER_AGENT'],"iPhone");
	$iPad          = stripos($_SERVER['HTTP_USER_AGENT'],"iPad");
	$Android       = stripos($_SERVER['HTTP_USER_AGENT'],"Android");
	$webOS         = stripos($_SERVER['HTTP_USER_AGENT'],"webOS");

	if( $iPod || $iPhone || $iPad || $Android)  { $dev_type= 1; }// mobile
	else{$dev_type= 2; } // system
	 
	$licount =0; 
	$propertyimageTable    =  Engine_Api::_()->getDbtable('propertyimages', 'user');
	$likepropertyTable     =  Engine_Api::_()->getDbtable('likeuser', 'user');
	$userTable             =  Engine_Api::_()->getDbtable('users', 'user');
	$postcommentTable      =  Engine_Api::_()->getDbtable('Postcomments', 'user');
	$viewHelperObj         =  $this->getHelper('ItemPhoto');
?>
  <?php $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); ?>
<?php foreach($this->propertyListData as $data): ?>
		<?php $UserData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $data['property_owner_id'])); ?>
		<?php if(!empty($UserData)):?>
		<?php
                $profileNoPicInfo   =   $viewHelperObj->getNoPhoto($UserData);
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
						<a href="<?php echo $this->baseUrl().'/property/map/'.$data['id'] ?>" target="_blank"><img src= "/application/modules/User/externals/images/LOCATION.png" style="margin-top: -4px;"></a>
						<?php else:?>
						<span class="location_icon" data-city= "<?php echo $data['prty_city'];?>" data-id ="<?php echo $data['id'];?>" data-type= "<?php echo 'property';?>" data-lat=<?php echo $data['latitude'];?> data-lng= <?php echo $data['longitude'];?>><img src= "/application/modules/User/externals/images/LOCATION.png" style="margin-top: -4px;"></span>
						<?php endif;?>
						<?php endif;?>				 
					</div>		 
				</div>	
				
				<div class='feed_item_attachments'>
					<span class='feed_attachment_album_photo'>
						
						<div class="feed_property_div">
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
								else{$y=substr($description,0,300) . '...'; echo $y;}
								?>
							</div>
						<div class="feed_property_details">
							<div class="property_list_spl"><span class="qwerty"><img src="/application/modules/User/externals/images/apartments.svg"></span>  <span class="qwerty_label"><?php echo $data['housing_type'];?></span></div>
							<div class="property_list_spl"><span class="qwerty"><img src="/application/modules/User/externals/images/price.png"></span><span class="qwerty_label"> <?php echo $data['price'];?></span></div>
							<div class="property_list_spl"><span class="qwerty"><img src="/application/modules/User/externals/images/bedroom.png"></span><span class="qwerty_label"> <?php echo $data['no_of_rooms'];?> Bedroom</span></div>
							<div class="property_list_spl"><span class="qwerty">
								<?php if($data['has_pets'] == 'No'):?>
								<img src="/application/modules/User/externals/images/nopet.png"></span><span class="qwerty_label"> No </span>
								<?php else:?>
								<?php if($data['pets_type']== 'Dogs'):?>
								<img src="/application/modules/User/externals/images/dog.svg"></span><span class="qwerty_label"> Dog </span>
								<?php elseif($data['pets_type'] == 'Cats'):?>
								<img src="/application/modules/User/externals/images/cat.svg"></span><span class="qwerty_label"> Cat </span>
								<?php elseif($data['pets_type'] == 'Cats & Dogs'):?>
								<img src="/application/modules/User/externals/images/catndog.png"></span><span class="qwerty_label"> Cats & Dogs </span>
								<?php elseif($data['pets_type'] == 'Birds'):?>
								<img src="/application/modules/User/externals/images/bird.svg"></span><span class="qwerty_label"> Birds </span>
								<?php elseif($data['pets_type'] == 'Small pets'):?>
								<img src="/application/modules/User/externals/images/tortoise.svg"></span><span class="qwerty_label"> Small pets </span>
								<?php endif;?>
								<?php endif;?>
							</div>
						</div>	
						</div>	
					</span>		
				</div>	
				
				 <?php          
				 $likepropertyData = $likepropertyTable->fetchRow($likepropertyTable->select()->where('type = ?', 'property')
				->where('object_id = ?', $data['id'])
				->where('subject_id = ?',$viwer_id ));
				?>
					 <?php if(count($likepropertyData) == 0):?>
					  <div class="save_btn_div save_btn_div_<?php echo $data['id'];?>">
					  <button class="like_property like_property_<?php echo $data['id'];?>" property_id="<?php echo $data['id']; ?>" title="Save">Save</button>
					  </div>
					  <span class="loader loader_<?php echo $data['id'];?>" style="display:none;float:right"></span>
					  <?php else: ?>
					  <div class="save_btn_div save_btn_div_<?php echo $data['id'];?>"><button class="unlike_property like_user_<?php echo $data['id'];?>" property_id ="<?php echo $data['id'];?>" >Save</button></div>
					 <?php endif; ?>
				<div id='comment-likes-activity-item-<?php echo $data['action_id']?>'>
					<div class='feed_item_date feed_item_icon activity_icon_property item_icon_album_photo '>
						 <ul>
							 <li class="feed_item_option_share">
								 <?php if($dev_type == 1): // mobile?> 
									 <a href="<?php echo $this->baseUrl().'/tichat/inbox'; ?>" >&nbsp;&nbsp;Contact</a>
								  <?php else: ?>
									<span onClick="popUpChatClick('<?php echo $UserData->user_id ?>','<?php echo $UserData->displayname; ?>','<?php echo $src ?>','<?php echo $status ?>')">
										<a href="javascript:void(0)" >&nbsp;&nbsp;Contact</a>
								 <?php endif; ?>
							 </li>	
							<li> <a href="javascript:void(0)" class="feed_comment" action_id="<?php echo $data['action_id']; ?>" >&nbsp;&nbsp;Comment</a></li>
							<div class="feed_comment_post feed_comment_post_<?php echo $data['action_id']?>" style="display:none">
								<form>
								<textarea class="feed_comment_body feed_comment_body_<?php echo $data['action_id'];?>" ></textarea>

								<input type="button" value="Post" class="comment_post_btn" status="<?php echo 'post_comment' ?>" action_id="<?php echo $data['action_id'];?>" viewer_id="<?php echo $viwer_id ;?>" actionSubjectId = "<?php echo $data['property_owner_id'];?>">
								</form>
							</div>
							<span class="loader loader_<?php echo $data['action_id'];?>" style="display:none;float:right !important"></span>
						 </ul>		 
					</div>
				
					<div class='comments comments_<?php echo $data['action_id'];?>'>
						 <ul>
								 <?php 
									$postcommentData = $postcommentTable->fetchAll($postcommentTable->select()
									 ->where('actionId = ?',$data['action_id'] )
									  ->order('commentId DESC')
									 ->limit(2)
									 ); 
								?>
							<ul class="comment_ul comment_ul_<?php echo $data['action_id']; ?>">
									<?php foreach($postcommentData as $commentData):?>
											<li class="comment_li comment_li_<?php echo $commentData['commentId'] ;?>">
											<?php $commentedUserData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $commentData['posterId'])); ?>
											<?php if(!empty($commentedUserData)) : ?>
											<div class="comment_auther_photo">
													<?php echo $this->htmlLink($commentedUserData->getHref(), $this->itemPhoto($commentedUserData, 'thumb.icon', $commentedUserData->getTitle()), array('title'=>$commentedUserData->getTitle())) ?>
											</div>
											<div class="comments_info">
												<span class="comments_author"><a href="<?php echo $this->baseUrl().'/profile/'.$commentData['posterId'] ?>"><?php echo $commentedUserData->getTitle();?></a></span>
												<span class="comment_content"><?php echo $commentData['body'];?></span>
												<div class="comment_timestamp" comment_time="<?php echo $commentData['created_at']; ?>"><?php echo $this->timestamp($commentData['created_at']); ?></div>
												<?php if(($viwer_id == $commentData['posterId'])): ?>
												<span class="delete_feed_comment" comment_id="<?php echo $commentData['commentId'] ?>" action_id="<?php echo $data['action_id']; ?>" poster_id="<?php echo $commentData['posterId'] ?>">
												<a href="javascript:void(0)">Delete</a>
												</span>            
												<?php endif;?>
											</div>
											<?php endif;?>		
											</li>
											</br>
									<?php endforeach;?>
									
									<?php  
									 $allpostcommentData = $postcommentTable->fetchAll($postcommentTable->select()
									 ->where('actionId = ?',$data['action_id'] )
									  ->order('commentId DESC'));
									 $comment_count= count($allpostcommentData);  
									?>
									<?php if( $comment_count > 2): ?>
									   <div class="feed_view_comment">
											 <a href="javascript:void(0)" class="comments_Load_more comments_Load_more_<?php echo $data['action_id']; ?>" action_id="<?php echo $data['action_id']; ?>" status="<?php echo 'view_more' ?>">View more</a>
									   </div>
									<?php endif;?>		
							</ul> 
						</ul>        
					</div>
				</div>     
			 </div>
		</li>

		<?php endif;?>
		<?php  endforeach; ?>
