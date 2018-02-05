 <?php 
 $propertyReqResultData = $this->propertyReqResultData; 
 $viewer = Engine_Api::_()->user()->getViewer();
 $status    =   'false';
 	$useragent     = $_SERVER['HTTP_USER_AGENT'];
	$iPod          = stripos($_SERVER['HTTP_USER_AGENT'],"iPod");
	$iPhone        = stripos($_SERVER['HTTP_USER_AGENT'],"iPhone");
	$iPad          = stripos($_SERVER['HTTP_USER_AGENT'],"iPad");
	$Android       = stripos($_SERVER['HTTP_USER_AGENT'],"Android");
	$webOS         = stripos($_SERVER['HTTP_USER_AGENT'],"webOS");

	if( $iPod || $iPhone || $iPad || $Android)  { $dev_type= 1; }// mobile
	else{$dev_type= 2; } // system
	 
	    $userTable             =  Engine_Api::_()->getDbtable('users', 'user');
        $viewHelperObj      =   $this->getHelper('ItemPhoto');
        foreach($propertyReqResultData as $result):
           $licount =  $licount + 1;

                $user = $userTable->fetchRow($userTable->select()->where('user_id = ?', $result['userId']));
                $profileNoPicInfo   =   $viewHelperObj->getNoPhoto($user);
                $type               =   'thumb.icon';
                $safeName           =   ( $type ? str_replace('.', '_', $type) : 'main' );
                $src                =   $user->getPhotoUrl($type);
                if($src):
                $src                =   $src;
                else:
                $src                =   $viewHelperObj->getNoPhoto($user,$safeName);
                endif;

     $userselect    =   $userTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('user'=>'engine4_users',))
                        ->joinLeft(array('search_field'=>'engine4_user_fields_search'),'search_field.item_id=user.user_id',null)
                        ->joinLeft(array('state'=>'engine4_state_list',),'state.state_id=search_field.field_76',array('state'))
                        ->joinLeft(array('city'=>'engine4_city_list',),'city.city_id=search_field.field_77',array('city'))
                        ->where('user.search=?' , 1)
                        ->where('user.enabled=?' , 1)
                        ->where('search_field.profile_type =?' , '1')
                        ->where('user.user_id = ?', $result['userId'])
                        ->group('user.user_id');          
    $userData = $userTable->fetchRow($userselect);          
    ?>
            <li class="results_pane_li results_pane_li_<?php echo $licount?>" licount = <?php echo  $licount;?>>
            <div class="results_pane_body">
          <!--  <div class="mob_bar_iphone_ipad feed_heading">-->
            <div class="feed_heading">
					
			<span><?php echo $this->timestamp($result['created_at']); ?></span> 
					
			<span class="feed_location">     
          	<?php if($result['prty_country'] !=''):?>
	        <?php if($dev_type == 1): // mobile?>
			<a href="<?php echo $this->baseUrl().'/property/requirement/map/'.$data->id ?>" target="_blank"><img src= "/application/modules/User/externals/images/LOCATION.png" style="margin-top: -4px;"></a>
			<?php else:?>
			<span class="location_icon" style="height: 30px;width: 15px;" data-city= "<?php echo $result['prty_city'];?>"  data-id ="<?php echo  $result['reqId'];?>"  data-lat=<?php echo $result['latitude'];?> data-lng= <?php echo $result['longitude'];?>><img src= "/application/modules/User/externals/images/LOCATION.png" style="margin-top: -4px;"></span>
			<?php endif;?>
			<span>	
			<?php  //echo $result['prty_country']." , ".$result['prty_state']." , ".$result['prty_city'] ;?>		 
			 <?php if($result['prty_state'] !=''):?>
			 <?php echo $result['prty_state']; ?>   
			 <?php endif;?>
			 <?php if($result['prty_city'] !='' && $result['prty_city'] != $result['prty_state']):?>
			 <?php echo " , ".$result['prty_city']; ?>   
			 <?php endif;?>		 
			 <?php if($result['prty_county'] !='' && $result['prty_county'] != $result['prty_city']):?>
			 <?php echo " , ".$result['prty_county']; ?>
			 <?php endif;?>
			 <?php if($result['prty_neighborhood'] !=''):?>
			 <?php echo " , ".$result['prty_neighborhood']; ?>   
			 <?php endif;?>
			 <?php endif;?>
			</span>  
			</span>
								
			</div>
            <div class="results_pane_li_content">
            <div class="scrolling-row-inner">
			<div class="row">	
		   <?php if($dev_type == 1): // mobile?>
		   <div class="col-md-3 col-sm-2 col-xs-3 profile_image">
		   <?php else:?>		
            <div class="col-md-4 col-sm-4 col-xs-12 profile_image">
			<?php endif;?>	
            <?php echo $this->htmlLink($user->getHref(), $this->itemPhoto($user, '', array('class' => 'photo')),array('title'=>$user->getTitle())) ?>
          </div>

          </div>
         <div class="row">
                     <div class="col-md-4 col-sm-4 col-xs-12">
                        <?php  if($user->bg_verified == 1 && $result['isSmartmoveRenter'] == 0):?>
                          <span class="verified">Verified</span>
                        <?php endif;?>
                        <?php  if($user->bg_verified == 0 && $result['isSmartmoveRenter'] == 1):?>
                          <span  class="verified">Verified</span>
                        <?php endif;?>
                        <?php  if($user->bg_verified == 0 && $result['isSmartmoveRenter'] == 0):?>
                          <span class="feed_notverified_span">Not Verified</span>
                        <?php endif;?>
                        <?php  if($user->bg_verified == 1 && $result['isSmartmoveRenter'] == 1):?>
                          <span class="verified">Verified</span>
                        <?php endif;?>
                    <h2 class="vcard">
                    <span class="hover-card-parent">
                        <span class="url" style="display:block;">
                            <?php  $attribs = Array('title'=>'View Profile'); ?>
                             <?php echo $this->htmlLink($user->getHref(), ucwords($user->getTitle()),$attribs) ?>
                        </span>
                    </span>
                <span class="meta locality">
                    <?php echo "USA" . " , ";  if($userData['state'] !=''):?><?php echo $userData['state']?>, <?php endif;?> <?php echo $userData['city']?>
                </span>
                </h2>

                <?php if($viewer->getIdentity()!=$result['userId']): ?>
                <?php if($dev_type == 1): // mobile?> 
				  <div style="padding-bottom:3px;">
					<a href="<?php echo $this->baseUrl().'/tichat/inbox'; ?>"  class="feed_message_btn">Message</a>
				  </div>	
                <?php else:?>
					<div style="padding-bottom:3px;">
						<a href="javascript:void(0)" onClick="popUpChatClick('<?php echo $result['userId'] ?>','<?php echo $user->displayname; ?>','<?php echo $src ?>','<?php echo $status ?>')" class="feed_message_btn">Message</a>
					</div>
                 <?php endif;?>                 
                 <?php endif;?>                 
                
                <div class="feed_rating">
                <?php if($user->rating_value != '' && $user->rating_value !=0): ?>
                <?php if($user->enable_rating_value == 1):?>
                  <div  class="basic" data-average="<?php echo $user->rating_value;?>" data-id="1" title="<?php echo $user->rating_value;?>"></div>
                  <?php else:?>
                  <div style="color: #f58410;">Not Rated</div>  
                <?php endif;?>
                <?php else:?>
                <div class="not_rated">Not Rated</div>
                <?php endif;?>
                 </div>              
                 </div>
                 <div class="col-md-7 col-sm-8 col-xs-12">
                     <?php echo substr($result['description'],0,200) . '...';?>
                </div>

                </div>
                
                </div>
                <div class="row" style="padding-top: 4px;">
                <div class="feed_icons">

                 <div class="wert" style="float:right;margin-top: 9px;">
                    <div class="feed_filter_count_icons">
                    <?php if($dev_type== 1):?>
                    
                   <?php if($result['no_of_rooms']!="Room"): ?>
                    <div class="voucher1" ><img src="/application/modules/User/externals/images/feed_bedroom_orange.png" width="22px" height="22px"><h5 style="line-height: 0.8;float: right;padding-left: 7px;"><?php  echo  $result['no_of_rooms'] ;?></h5></div>
                   <?php endif; ?>
                    <div class="voucher1" ><img src="/application/modules/User/externals/images/dollar-symbol.svg" width="22px" height="22px"> <h5 style="line-height: 0.8;float: right;"><?php  echo  $result['budget'] ;?></h5></div>
                    <div class="voucher1" title="<?php  echo  $result['housing_type'] ;?>" style="margin-right: 3px;" ><img src="/application/modules/User/externals/images/orangeapartments.svg" width="22px" height="22px"> <h5 style="line-height: 0.8;float: right; "></h5></div>
                   
                    
                    <?php if($result['pets_allowed']=='Yes'): ?>
                       <span class="feed_icons dev1" ?>
						  <?php if($result['pets_type']== 'Dogs'):?>                     
							<div class="voucher" title="Dogs"><img src="/application/modules/User/externals/images/dog.png" width="22px" height="22px"></div>
						 <?php elseif($result['pets_type'] == 'Cats'):?>
							 <div class="voucher" title="Cats"><img src="/application/modules/User/externals/images/cat.png" width="22px" height="22px"></div>
						 <?php elseif($result['pets_type'] == 'Cats & Dogs'):?>
							  <div class="voucher" title="Cats & Dogs"><img src="/application/modules/User/externals/images/Layer-18.png" width="22px" height="22px"></div>
						 <?php elseif($result['pets_type'] == 'Birds'):?>
							   <div class="voucher" title="Birds"><img src="/application/modules/User/externals/images/bird.svg" width="22px" height="22px"></div>
						 <?php elseif($result['pets_type'] == 'Small pets'):?> 
							  <div class="voucher" title="Small pets"><img src="/application/modules/User/externals/images/tortoise.svg" width="22px" height="22px"></div> 
						 <?php endif; ?>
						 </span>
                    <?php endif; ?>
                    
                    
                    <?php if($result['vouchers']=='Yes'): ?>
                    <div class="voucher voucher_image" style="float:left;"><img src="/application/modules/User/externals/images/vochericon.jpg" width="22px" height="22px"></div>
                    <?php endif; ?>
                    <?php if($result['wheelchair']=='Yes'): ?>
                    <div class="voucher" ><img src="/application/modules/User/externals/images/wheelchair.svg" width="27px" height="22px"></div>
                    <?php endif;   ?>
                    <?php  if($result['parking']=='Yes'): ?>
                    <div class="voucher" ><img src="/application/modules/User/externals/images/parking-sign.svg" width="27px" height="22px"></div>
                    <?php endif; ?>
                    
                    
                 
                    <?php endif; ?>

                     </div> <!-- feed_icons div end-->
            
             <div class="feed_filter_count_icons dev2">
                 <?php if($dev_type== 2):?>
                               
                    <?php if($result['no_of_rooms']!="Room"): ?>
                    <div class="voucher1" ><img src="/application/modules/User/externals/images/feed_bedroom_orange.png" width="22px" height="22px"><h5 style="line-height: 0.8;float: right;padding-left: 7px;"><?php  echo  $result['no_of_rooms'] ;?></h5></div>
                    <?php endif; ?>
                    <div class="voucher1" ><img src="/application/modules/User/externals/images/dollar-symbol.svg" width="22px" height="22px"> <h5 style="line-height: 0.8;float: right;"><?php  echo  $result['budget'] ;?></h5></div>
                    <div class="voucher1" title="<?php  echo  $result['housing_type'] ;?>" ><img src="/application/modules/User/externals/images/orangeapartments.svg" width="22px" height="22px"> <h5 style="line-height: 0.8;float: right;"></h5></div>


                   <?php if($result['pets_allowed']=='Yes'): ?>
                        <?php if($result['pets_type']== 'Dogs'):?>                     
							<div class="voucher1" title="Dogs"><img src="/application/modules/User/externals/images/dog.png" width="22px" height="22px"></div>
						 <?php elseif($result['pets_type'] == 'Cats'):?>
							 <div class="voucher1" title="Cats"><img src="/application/modules/User/externals/images/cat.png" width="22px" height="22px"></div>
						 <?php elseif($result['pets_type'] == 'Cats & Dogs'):?>
							  <div class="voucher1" title="Cats & Dogs"><img src="/application/modules/User/externals/images/Layer-18.png" width="22px" height="22px"></div>
						 <?php elseif($result['pets_type'] == 'Birds'):?>
							   <div class="voucher1" title="Birds"><img src="/application/modules/User/externals/images/bird.png" width="22px" height="22px"></div>
						 <?php elseif($result['pets_type'] == 'Small pets'):?> 
							  <div class="voucher1" title="Small pets"><img src="/application/modules/User/externals/images/tortoise.png" width="22px" height="22px"></div> 
						 <?php endif; ?>
                    <?php endif; ?>


                    <?php if($result['vouchers']=='Yes'): ?>
                    <div class="voucher1" ><img src="/application/modules/User/externals/images/vochericon.jpg" width="22px" height="22px"></div>
                    <?php endif; ?>
                    <?php if($result['wheelchair']=='Yes'): ?>
                    <div class="voucher1" ><img src="/application/modules/User/externals/images/wheelchair.svg" width="27px" height="22px"></div>
                    <?php endif;   ?>
                      <?php  if($result['parking']=='Yes'): ?>
                    <div class="voucher1" ><img src="/application/modules/User/externals/images/parking-sign.svg" width="27px" height="22px"></div>
                    <?php endif; ?>
                   
                   
                 <?php endif;  ?>
            </div>
            
            <?php if($result['is_like'] == 0):?>
            <div class="save_btn_div save_btn_div_<?php echo $result['userId'];?>"><button class="like_user like_user_<?php echo $result['userId'];?>" user_id ="<?php echo $result['userId'];?>" title="Save">Save</button></div>
            <?php else: ?>
             <div class="save_btn_div save_btn_div_<?php echo $result['userId'];?>"><button class="unlike_user like_user_<?php echo $result['userId'];?>" user_id ="<?php echo $result['userId'];?>" title="Unsave">Save</button></div>
            <?php endif;?>
            
            </div>
            </div>
      </div>
     </div>
     </div>
     </li>
  <?php   endforeach;   ?>
