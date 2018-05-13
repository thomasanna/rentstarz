<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAAWRDCCJZYbD17HwNNUMK-6DzyHziKhN8&libraries=places" async defer></script>
<script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/scripts/autocomplete_address_googleapi.js"></script>
<?php
// member type
    $viewer = Engine_Api::_()->user()->getViewer();
    $viwer_id  = $viewer->getIdentity();
    date_default_timezone_set('EST');
    $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
    if( !empty($fieldsByAlias['profile_type']) )
    {
      $optionId = $fieldsByAlias['profile_type']->getValue($viewer);
      $this->view->profiletype = $profile_type_id = $optionId->value;
      $viewerProfileType = $profile_type_id;
    }
    if( Engine_Api::_()->core()->hasSubject() ) {
      // Get subject
        $subject = Engine_Api::_()->core()->getSubject();
        $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($subject);
        if( !empty($fieldsByAlias['profile_type']) )
        {
          $optionId = $fieldsByAlias['profile_type']->getValue($subject);
          $subjectProfileType = $optionId->value;
        }
    }

if(empty(Engine_Api::_()->core()->hasSubject())){ //  home feed
	
    if($viewerProfileType == 4 ){ $checkhomefeedtype = 'landlordfeed';}  //check  landlord
    elseif($viewerProfileType == 1 ){$checkhomefeedtype = 'tenantfeed';}//check  tenant
    else{$checkhomefeedtype = 'servicefeed';}
    
}
else{ $checkhomefeedtype = '';}

if(Engine_Api::_()->core()->hasSubject()){  //  profile feed
	
    if($subjectProfileType ==4){ $checkprofilefeedtype = 'landlordfeed';}//check  landlord
    elseif($subjectProfileType == 1){ $checkprofilefeedtype = 'tenantfeed'; } // tenant
    else{ $checkprofilefeedtype = 'servicefeed';}
}
else{ $checkprofilefeedtype = '';}

	$useragent     = $_SERVER['HTTP_USER_AGENT'];
	$iPod          = stripos($_SERVER['HTTP_USER_AGENT'],"iPod");
	$iPhone        = stripos($_SERVER['HTTP_USER_AGENT'],"iPhone");
	$iPad          = stripos($_SERVER['HTTP_USER_AGENT'],"iPad");
	$Android       = stripos($_SERVER['HTTP_USER_AGENT'],"Android");
	$webOS         = stripos($_SERVER['HTTP_USER_AGENT'],"webOS");

	if( $iPod || $iPhone || $iPad || $Android)  { $dev_type= 1; }// mobile
	else{$dev_type= 2; } // system

    $userHelperObj  = $this->getHelper('User');
    $memberPackage  = $userHelperObj->getmemberpackage($viewer->getIdentity());
    $package_type   = $memberPackage ->package_type;
    $scoutCount     = $userHelperObj->getscoutcount($viewer->getIdentity()); 
    $settings       = Engine_Api::_()->getApi('settings', 'core');
    $user_premiumLevelProvision       = $settings->user_premiumLevelProvision; 
    $user_basicPropertyLimit          = $settings->user_basicPropertyLimit;  
    $user_landlordProPropertyLimit    = $settings->user_landlordProPropertyLimit;  
    $user_basicScoutLimit             = $settings->user_basicScoutLimit;  
    $user_landlordProScoutLimit       = $settings->user_landlordProScoutLimit; 
    
    $userdetails    = $userHelperObj->getuserDetails($viewer->getIdentity());
    $profileType    = $userdetails['profile_type'];    
?> 

<!-- Start Landlord home feed--->

<?php if($checkhomefeedtype == 'landlordfeed' || $checkprofilefeedtype == 'tenantfeed'): ?>

<?php
	$userTable = Engine_Api::_()->getDbtable('users', 'user');
	$propertyRequirementTable =  Engine_Api::_()->getDbtable('propertyrequirement', 'user');
	$propertyReqResultData    = $this->propertyReqResultData;
?>
    <!--    map tabbing section-->
    <section class="filter-search searchFilter new_landlo">
        <div class="container">
            <ul class="txt-left">
                <li class="item">
                    <a href="javascript:void(0)" class="filterLinks matches"  data-toggle="modal" data-target="#matchesModal">New Scout</a>
                </li>
                <li class="item">
                    <a href="javascript:void(0)" class="filterLinks">My Scout</a>
                </li>
                <li class="item">
                    <a href="javascript:void(0)" class="filterLinks">Invites</a>
                </li>
            </ul>
        </div>
    </section>
    

    
    <section class="landlordScout">
        <div class="container">
			
	<?php   if(!empty($propertyReqResultData)): ?> <!-- Start property requirement list --->
		<?php
			$viewHelperObj      =   $this->getHelper('ItemPhoto');
			foreach($propertyReqResultData as $result):
			   $licount =  $licount + 1;
					$user = $userTable->fetchRow($userTable->select()->where('user_id = ?', $result['userId']));
			   if(!empty($user)) :    
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
            <div class="scoutBox">
                <div class="colorBox">
                   <h4>
                        <span>I</span>
                        <span>N</span>
                        <span>V</span>
                        <span>I</span>
                        <span>T</span>
                        <span>E</span>
                    </h4>
                    <img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/assets/images/newpage/renssmalllogo.png" alt="">
                </div>
                <div class="scoutDetailsBox">
                    <span class="posted">
                        <?php echo $this->timestamp($result['created_at']); ?>
                    </span>
                    <p class="scoutdescription"><?php echo substr($result['description'],0,200) . '...';?></p>
                    <div class="scoutIcons">
                        <p><i class="fa fa-bed"></i><?php  echo  $result['no_of_rooms'] ;?></p>
                        <p><i class="fa fa-parking-sign"></i>$ <?php  echo  $result['budget'] ; if($result['budget_range_to']!='0'): echo " - ".$result['budget_range_to'];endif;?></p>
                        <p><i class="fa fa-bed"></i><?php  echo  $result['housing_type'] ;?></p>
                        <?php if($result['pets_allowed']=='Yes'): ?>
							<?php if($result['pets_type']== 'Dogs'):?>
							 <p><i class="fa fa-bed"></i>Dogs</p>
							<?php elseif($result['pets_type'] == 'Cats'):?>
							<p><i class="fa fa-bed"></i>Cats</p>
							 <?php elseif($result['pets_type'] == 'Cats & Dogs'):?>
							 <p><i class="fa fa-bed"></i>Cats & Dogs</p>
							 <?php elseif($result['pets_type'] == 'Birds'):?>
							 <p><i class="fa fa-bed"></i>Birds</p>
							 <?php elseif($result['pets_type'] == 'Small pets'):?> 
							 <p><i class="fa fa-bed"></i>Small pets</p>
							 <?php endif; ?>
                        <?php endif; ?>
                        <?php if($result['vouchers']=='Yes'): ?>
                        <p><i class="fa fa-bed"></i>Vouchers</p>
						<?php endif; ?>
                        <?php if($result['wheelchair']=='Yes'): ?>
                        <p><i class="fa fa-bed"></i>wheelchair</p>
						<?php endif; ?>
                        <?php if($result['parking']=='Yes'): ?>
                        <p><i class="fa fa-bed"></i>parking</p>
						<?php endif; ?>
                    </div>
                </div>
                <div class="scoutImage">
                    <p class="name">
                    <?php  $attribs = Array('title'=>'View Profile'); ?>
                    <?php echo $this->htmlLink($user->getHref(), ucwords($user->getTitle()),$attribs) ?>
                    </p>
                        <?php echo $this->htmlLink($user->getHref(), $this->itemPhoto($user, '', array('class' => 'photo')),array('title'=>$user->getTitle())) ?>
                    <p class="message">Message</p>
                </div>
            </div>
      <?php endif;?>
  <?php endforeach; ?>
        </div>
    </section>

    <?php endif;?> <!-- End property requirement list --->
    
    
    
        
<!--matches Modal start-->

<div class="modal fade" id="matchesModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content-new">
      <div class="modal-header">
        <span class="modal-title" id="exampleModalLabel"><a href="javascript:void(0)" target="_blank">New Scout</a></span>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
       <div class="modal-body">
            <div class="message" style="color:#333;padding: 0px 0px 8px 0px;display:block;">
          <?php if($profile_type_id == 4): ?>
            <?php if($user_premiumLevelProvision == 2):  // if premium level provision to all users disabled?>

                 <?php if($package_type == '' || $package_type == 'landlord_pro_package'): ?>
                 To continue, please upgrade your package. <a href="/support?page=upgradePackage">Upgrade Package</a>
                 <?php endif;?>

            <?php endif;?>
           <?php endif;?>
            </div>
            <div class="err_msg" style="color:red"></div>
<div class="matches_div">
    <input type="hidden" name="scoutcount" value="<?php echo $scoutCount;?>" class="scoutcount">
    <div class="pro_field_wrapper" style="margin-bottom:5px;" >
        <div class="prty_lablel pro_label scount_name_mob" style="padding-bottom:12px;">Scout Name <span style="color:red;font-weight: bolder;">*</span>  </div>
        <input type="text" name="scout_name" value="" class="scout_name prty_field">

   </div>
   <!--<br>-->
    <div class="pro_field_wrapper">
        <div class="prty_lablel pro_label scount_name_mob top_space_mob" style="padding-bottom:12px;">Housing Type</div>
        <input type="radio" name="housing_type" value="Apartment" style="margin-right:3px;margin-top: 4px;">
        <label class="radio_label" for="Apartment">Apartment</label>
        <input type="radio" name="housing_type" value="Room" style="margin-right:3px;margin-top: 4px;">
        <label class="radio_label" for="Room">Room</label>
        <input type="radio" name="housing_type" value="House" style="margin-right:3px;margin-top: 4px;">
        <label class="radio_label" for="House">House</label>
        <input type="radio" name="housing_type" value="Villa" style="margin-right:3px;margin-top: 4px;">
        <label class="radio_label" for="Villa">Villa</label>
   </div> <br>
   <!--<br>-->
    <div class="pro_field_wrapper top_space_mob"><div class="prty_lablel pro_label">Pets</div>  <select name="is_petsallowd" id="is_petsallowd"  class="prty_field" onchange="petsType()">
                                             <option value="">Select</option>
                                             <option value="Yes">Yes</option>
                                             <option value="No">No</option>
    </select></div>   <br>
    <div class="pets_type_wrapper" style="display:none">
    <div class="pro_field_wrapper"><div class="prty_lablel pro_label">Type of pets</div>
                             <select name="pets_type" id="pets_type"  class="prty_field">
                                             <option value="">Select pets type</option>
                                             <option value="Cats">Cats</option>
                                             <option value="Dogs">Dogs</option>
                                             <option value="Cats & Dogs">Cats & Dogs</option>
                                             <option value="Birds">Birds</option>
                                             <option value="Small pets">Small pets</option>
                             </select>
                             </div>   <br>
        </div>
                <div class="pro_field_wrapper">
         <div class="prty_lablel pro_label">Location<span style="color:red;font-weight: bolder;">*</span> </div>
        <input id="autocomplete1" class="preference_place prty_field" placeholder="Enter Location" type="text">
        <br>

      </div>
    <div class="pro_field_wrapper"><div class="prty_lablel pro_label">Number Of Bedrooms</div>

    <select id="number_of_rooms" class="prty_field">

                                             <option value="">Select</option>
                                             <option value="1">1</option>
                                             <option value="2">2</option>
                                             <option value="3">3</option>
                                             <option value="4">4</option>
                                             <option value="4+">4+</option>
    </select>
    </div>   <br>
    <div class="pro_field_wrapper" style="overflow: hidden;"><div class="prty_lablel pro_label">Rent per Month</div>
    <input type="text" class="price_range_from prty_field" style="float:left" placeholder="Price">
    <span class="price_range_to_div" style="display:none">
        <span class="to_span">To</span>
     <input type="text" class="price_range_to prty_field" placeholder="Price">
     </span>
        <div class="price_range_span_link" style="float:left;padding-top: 3px;margin-left: 4px;">
            <a href="javascript:void(0)" class="price_range_link">
                        <img src="/application/modules/User/externals/images/add_range.png" alt="" title="Add Range" >
            </a>
        </div>

        </div> <br>
        


       <div class="matches_btn_div"><input class="submit_matches" type="button" value="Save" name=""></div>

      </div>
            <div class="loader submit_matches_loader" style="display:none"></div>
    </div>
  </div>
</div>

<!--matches Modal end-->    

<?php endif;?>

<!-- End Landlord home feed--->

<!--Start renter home feed -->

<?php if($checkhomefeedtype == 'tenantfeed'):?>

<?php  
	$licount =0; 
	$propertyimageTable    =  Engine_Api::_()->getDbtable('propertyimages', 'user');
	$likepropertyTable     =  Engine_Api::_()->getDbtable('likeuser', 'user');
	$userTable             =  Engine_Api::_()->getDbtable('users', 'user');
	$postcommentTable      =  Engine_Api::_()->getDbtable('Postcomments', 'user');
	$viewHelperObj         =  $this->getHelper('ItemPhoto');
	$status    	   =   'false';
    $popup_status  =	'large_popUp';
?>

 <!--    map tabbing section-->
    <div class="filter-search searchFilter landloard-links">
        <div class="container">
            <ul>
                <li class="item">
                    <div class="input-group">
                        <span class="input-group-addon" id="basic-addon1">
                            <i class="fa fa-map-marker"></i>
                        </span>
                        <input value="
                        <?php 
                        if(isset($this->location_mode_array['city_name'])):
                        echo $this->location_mode_array['city_name'] ." ";
                        endif;
                        if(isset($this->location_mode_array['state_name'])):
                        echo $this->location_mode_array['state_name'] ." ";
                        endif;
                        if(isset($this->location_mode_array['county_name'])):
                        echo $this->location_mode_array['county_name'] ." ";
                        endif;                        
                        ?>"
                        type="text" class="form-control" id="autocomplete1" placeholder="Enter Location, Project and Landmark" aria-describedby="basic-addon1">
                    </div>
                </li>

                <li class="dropdown propertyType_li">
                    <a class="dropdown-toggle" id="menu4" type="" data-toggle="dropdown">
                        <i class="fa fa-home"></i>
                        &nbsp;
                        <?php if(isset($this->location_mode_array['propertyType'])):
                         echo $this->location_mode_array['propertyType'];
                         else: 
                         echo "Property Type";
                         endif;
                        ?>
                        <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu" role="menu4" aria-labelledby="menu3">
                            <li role="presentation">
                                <a role="menuitem" tabindex="Apartment" href="javascript:void(0)">Apartment</a>
                            </li>
                            <li role="presentation">
                                <a role="menuitem" tabindex="Room" href="javascript:void(0)">Room</a>
                            </li>
                            <li role="presentation">
                                <a role="menuitem" tabindex="House" href="javascript:void(0)">House</a>
                            </li>
                            <li role="presentation">
                                <a role="menuitem" tabindex="Villa" href="javascript:void(0)">Villa</a>
                            </li>
                    </ul>
                </li>
                <li class="dropdown budget_li">
                    <a class="dropdown-toggle" id="menu5" type="" data-toggle="dropdown">
                        <i class="fa fa-dollar"></i>&nbsp;
                        <?php if(isset($this->location_mode_array['budget'])):
                         echo $this->location_mode_array['budget'];
                         else: 
                         echo "Budget";
                         endif;
                        ?>
                        
                        <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu" role="menu5" aria-labelledby="menu3">
                            <li role="presentation">
                                <a role="menuitem" tabindex="0-500" href="javascript:void(0)">0 - 500</a>
                            </li>
                            <li role="presentation">
                                <a role="menuitem" tabindex="500-1000" href="javascript:void(0)">500 - 1000</a>
                            </li>
                            <li role="presentation">
                                <a role="menuitem" tabindex="1001-1500" href="javascript:void(0)">1001 - 1500</a>
                            </li>
                            <li role="presentation" class="divider"></li>
                            <li role="presentation">
                                <a role="menuitem" tabindex="1501-2000" href="javascript:void(0)">1501 - 2000</a>
                            </li>
                            <li role="presentation">
                                <a role="menuitem" tabindex="2001-2500" href="javascript:void(0)">2001 - 2500</a>
                            </li>
                    </ul>
                </li>
                <li class="dropdown bedroom_li">
                    <a class="dropdown-toggle" id="menu3" type="" data-toggle="dropdown">
                        <img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/assets/images/bedroom.png" alt="">&nbsp;
                        <?php if(isset($this->location_mode_array['bedroom'])):
                         echo $this->location_mode_array['bedroom'];
                         else: 
                         echo "Bedroom";
                         endif;
                        ?>
                        
                        <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu" role="menu3" aria-labelledby="menu3">
                        <li role="presentation">
                                <a role="menuitem" tabindex="1" href="javascript:void(0)">1</a>
                            </li>
                            <li role="presentation">
                                <a role="menuitem" tabindex="2" href="javascript:void(0)">2</a>
                            </li>
                            <li role="presentation">
                                <a role="menuitem" tabindex="3" href="javascript:void(0)">3</a>
                            </li>
                            <li role="presentation">
                                <a role="menuitem" tabindex="4" href="javascript:void(0)">4</a>
                            </li>
                            <li role="presentation">
                                <a role="menuitem" tabindex="4+" href="javascript:void(0)">4+</a>
                            </li>

                    </ul>
                </li>

                <li class="item">
                    <button id="searchID" class="btn btn-primary">SEARCH</button>
                </li>
            </ul>
        </div>
    </div>

    <section class="landlordList mapsLandLord" id="landloard-map">
        <div class="container-fluid">
			
		<?php if(count($this->propertyListData) > 0):?>
	
            <ul class="Listcontainer">
			<?php foreach($this->propertyListData as $data): ?>
			<?php $UserData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $data['property_owner_id'])); ?>

			<?php 
		 if(!empty($UserData)): 
		           
                $type               =   'thumb.icon';
                $safeName           =   ( $type ? str_replace('.', '_', $type) : 'main' );
                $src                =   $UserData->getPhotoUrl($type);
                if($src):
                $src                =   $src;
                else:
                $src                =   $viewHelperObj->getNoPhoto($UserData,$safeName);
                endif;
		
		
					$licount = $licount+1; 
					$commentDataSelect             = $postcommentTable->select()
									->where('actionId = ?', $data['id']);

					$commentData = $postcommentTable->fetchAll($commentDataSelect);
					$commentCount =  count($commentData);
					
					
					
				$likepropertyData = $likepropertyTable->fetchRow($likepropertyTable->select()->where('type = ?', 'property')
				->where('object_id = ?', $data['id'])
				->where('subject_id = ?',$viwer_id ));
				
				$totalLikes = $likepropertyTable->fetchAll($likepropertyTable->select()->where('type = ?', 'property')
				->where('object_id = ?', $data['id']));

		?>
		

                <li class="media" data-lat = "28.612434" data-long= "77.387733">
                    <div class="media-left">
                        <figure class="img">
                       <?php echo $this->htmlLink($UserData->getHref(), $this->itemPhoto($UserData, 'thumb.icon', $UserData->getTitle()), array('title'=>$UserData->getTitle())) ?>

                        </figure>
                    </div>
                    <div class="media-body">
                        <div class="content">
                            <h2><a href="<?php echo $this->baseUrl()."/property/". $data['id']?>"><?php echo $data['property_name'];?></a></h2>
                            <p>
                            <?php 
                            	$propertyImageData         = $propertyimageTable->fetchRow($propertyimageTable->select()->where('property_id = ?', $data['id'])->where('type = "image"'));

								$description  = strip_tags($data['description']);
								if(strlen($description)<=300){echo $description;}
								else{$description=substr($description,0,200) . '...'; echo $description;}
								$tagtext    = $data['property_name'];
								$feed_image = '/'.$propertyImageData->image;
								$detailUrl  = '/property/'.$data['id'];
								?>					

                            </p>
                            <div class="row cotentlenks">
                                <div class="col-sm-12">
                                   
									<?php if($viewer): ?>
										 <?php if($dev_type == 1):  $popup_status = 'mobile'; // mobile?> 
										 <span><a href="<?php echo $this->baseUrl().'/tichat/singlechatmob'; ?>" target="_blank" onClick="popUpChatClick('<?php echo $UserData->user_id ?>','<?php echo $UserData->displayname; ?>','<?php echo $src ?>','<?php echo $popup_status ?>')"><i class="fa fa-envelope"></i>&nbsp;&nbsp;Message</a></span>
									     <?php else: ?>
										 <span onClick="popUpChatClick('<?php echo $UserData->user_id ?>','<?php echo $UserData->displayname; ?>','<?php echo $src ?>','<?php echo $popup_status ?>')">
											<a href="javascript:void(0)" ><i class="fa fa-envelope"></i>&nbsp;&nbsp;Message</a>
										 </span>	
									     <?php endif; ?>
								   <?php else:?>	
								         <span><a><i class="fa fa-envelope"></i>&nbsp;Message</a></span>     
								   <?php endif; ?>
                                       
                                   
										<?php if($viewer): ?>
										 <?php if($dev_type == 1):  $popup_status = 'mobile'; // mobile?> 
										  <span><a href="<?php echo $this->baseUrl().'/tichat/singlechatmob'; ?>" target="_blank" onClick="popUpChatClick('<?php echo $UserData->user_id ?>','<?php echo $UserData->displayname; ?>','<?php echo $src ?>','<?php echo $popup_status ?>')"><i class="fa fa-video-camera"></i>&nbsp;&nbsp;Video</a></span>
									     <?php else: ?>
										 <span onClick="popUpChatClick('<?php echo $UserData->user_id ?>','<?php echo $UserData->displayname; ?>','<?php echo $src ?>','<?php echo $popup_status ?>')">
											<a href="javascript:void(0)" ><i class="fa fa-video-camera"></i>&nbsp;&nbsp;Video</a>
									     </span> 
									     <?php endif; ?>
										 <?php else:?>	
										 <span><a><i class="fa fa-video-camera"></i>&nbsp;Video</a></span>     
										 <?php endif; ?>
                                    
                                    <span>
                                        <a onClick="fbShare('<?php echo  $data['id']; ?>','<?php echo $tagtext ?>','<?php echo $feed_image; ?>','<?php echo $detailUrl; ?>')"><i class="fa fa-share"></i>&nbsp; Share</a>
                                    </span>
                                    <span>
                                        <a><i class="fa fa-heart"></i>&nbsp;<?php echo count($totalLikes);?> Likes</a></span>
                                    <span>
                                        <a><i class="fa fa-eye"></i>&nbsp;<?php echo $data['view_count'];?> Views</a>
                                    </span>
                                    <span>
                                        <a href="#" data-toggle="modal" data-target="#comments" class="comment_btn" action_id = "<?php echo  $data['id']; ?>"><i class="fa fa-comment" ></i>&nbsp;<?php echo $commentCount;?> Comments </a>
                                    </span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-4">
                                    <i class="fa fa-bed"></i>
                                    <b> <?php echo $data['housing_type'];?>
                                        <br>
                                        <i><?php echo $data['no_of_rooms'];?> beds</i>
                                    </b>
                                </div>
                                <div class="col-xs-4">
                                    <i class="fa fa-dollar"></i>
                                    <b> Rent
                                        <br>
                                        <i> <?php echo $data['price'];?></i>
                                    </b>
                                </div>
                                <div class="col-xs-4">
                                    <i class="fa fa-calendar"></i>
                                    <b> Listing Date
                                        <br>
                                        <i><?php echo $this->timestamp($data['created_at'])?></i>
                                    </b>
                                </div>
                            </div>
                        </div>
                        <div class="media-button row">
                            <button class="btn btn-default full-width text-center like_property <?php echo count($likepropertyData) == 0 ? '' : 'saved'; ?>" likepropertyData= <?php echo count($likepropertyData);  ?> property_id= " <?php echo $data['id']; ?>"> Save </button>
                        </div>
                    </div>

                </li>
                <?php endif;?>
               <?php endforeach;?>

            </ul>            
        </ul>
        </div>
       <?php endif;?>  
    </section>
    
<!-- comments modal -->
<div class="modal fade" id="comments" tabindex="-1" role="dialog" aria-labelledby="commentsLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h6 class="modal-title" id="commentsLabel">Modal title <span class="pull-right">Add a Comment</span></h6>             
            </div>
            <input type="hidden" class="action_id" value="">
            <div class="content"></div>
		  <div class="modal-footer text-right">
			<form>
				<div class="form-group">
					<textarea class="form-control feed_comment_body"></textarea>
				</div>    
				<button type="button" class="btn btn-primary btn-sm comment_post_btn" >Submit</button>              
			</form>
		</div>
  </div>
</div>
</div>




<!-- comments modal -->
    
<?php endif;?>    
  <!-- End renter home feed-->  

    <script>
        jQuery(document).ready(function () {
            jQuery('.Listcontainer').paginathing({
                perPage: 3,
                limitPagination: 4,
                containerClass: 'panel-footer',
                pageNumbers: true,
                cssStyle: 'light-theme'
            });

        });
    </script>
    
<script>

jQuery('body').on('click', '.submit_matches', function(event){
	 jQuery('#matchesModal .err_msg').text('');
	 var package_type = "<?php echo $package_type;?>";
     var profile_type_id = "<?php echo $profile_type_id;?>";
     var user_premiumLevelProvision = "<?php echo $user_premiumLevelProvision;?>";
     var user_basicScoutLimit = "<?php echo $user_basicScoutLimit;?>";
     var user_landlordProScoutLimit = '<?php echo $user_landlordProScoutLimit;?>';

	
   jQuery(".submit_matches_loader").css("display", "block");
   jQuery('.submit_matches').css('display','none');

   var housing_types= jQuery('input[name="housing_type"]:checked').val();

   if(housing_types == undefined){
       housing_types = '';
   }
   var scout_name   = jQuery(".scout_name").val();
   var is_petsallowd= jQuery("#is_petsallowd").val();
   var pets_type    = jQuery("#pets_type").val();
   var price        = jQuery("#matchesModal .price_range_from").val();
   var price_to        = jQuery("#matchesModal .price_range_to").val();
   var number_of_rooms        = jQuery("#number_of_rooms").val();
   var location        = jQuery("#location").val();
   var oData           = new Object();
   var PreferenceCountry                        = oData.PreferenceCountry =jQuery.trim(jQuery(".apartement_country").val());
   var PreferenceState                          = oData.PreferenceState =jQuery.trim(jQuery(".apartement_state").val());
   var PreferenceCity                           = oData.PreferenceCity =jQuery.trim(jQuery(".apartement_city").val());
   if(PreferenceCity == ''){
   var PreferenceCity     = oData.PreferenceCity =jQuery.trim(jQuery(".apartement_sublocality_level_1").val());
   }
 
   var PreferenceCounty          =  oData.PreferenceCounty =jQuery.trim(jQuery(".apartement_sublocality_level_1").val());
   var PreferencNeighborhood     =  oData.PreferenceNeighborhood =jQuery.trim(jQuery(".apartement_neighborhood").val());
   var PreferenceZip             = oData.PreferenceZip =jQuery.trim(jQuery(".apartement_zip").val());
   oData.housing_types = housing_types;
   oData.is_petsallowd = is_petsallowd;
   oData.pets_type     = pets_type;
   oData.price         = price;
   oData.price_to         = price_to;
   oData.number_of_rooms  = number_of_rooms;
   oData.location         = location;
   oData.scout_name       = scout_name;
   
   var scoutcount         =  oData.scoutcount = jQuery.trim(jQuery(".scoutcount").val());

   var is_validate = true;

  if((package_type == '' && profile_type_id == 4 && user_premiumLevelProvision == 2)){
	   if(scoutcount >=parseInt(user_basicScoutLimit)){
		   jQuery('#matchesModal .message').css('color','red');
       is_validate = false;
     }
   }
   if((package_type == 'landlord_pro_package' && profile_type_id == 4 && user_premiumLevelProvision == 2)){
	   if(scoutcount >= parseInt(user_landlordProScoutLimit)){
		   jQuery('#matchesModal .message').css('color','red');
       is_validate = false;
     }
   }
   
   if(is_validate == true){
   
	   if(PreferenceCountry == '' &&PreferenceState == '' && PreferenceCity == ''){
			jQuery('.preference_place').css('border-color','#dd1616');
			is_validate = false;
	   }
	   else{
			jQuery('.preference_place').css('border-color','#b2c6cd');
			is_validate = true;
	   }
   
   }
   if(is_validate == true){
	  if(scout_name ==''){
		 jQuery('.scout_name').css('border-color','#dd1616');
		 is_validate = false; 
	  }else{
			jQuery('.scout_name').css('border-color','#b2c6cd');
			is_validate = true;
	   }
	   
   }
   if(is_validate == true){
	   
	  if(price == '' && price_to !=''){
		  jQuery('.price_range_from').css('border-color','#dd1616');
		  is_validate = false;		  
	  }
	  else{
		  jQuery('.price_range_from').css('border-color','#b2c6cd');
		  is_validate = true;
	  } 
   }
   if(is_validate == true){
		 if(price != '' && price_to !=''){
			 if(parseFloat(price_to) < parseFloat(price)){
				jQuery('#matchesModal .price_range_from').css('border-color','#dd1616');
			    is_validate = false;  
			 }
			 else{
			   jQuery('#matchesModal .price_range_from').css('border-color','#b2c6cd'); 
			   is_validate = true; 				 
			 }
		   
		 }		 
	  }
   if(is_validate == true) {
	   
	 if(price ==''){
		
		oData.price = 0;
	}	
	if(price_to ==''){
		
		oData.price_to = 0;
	}	
   
   var formURL    = '<?php echo $this->baseUrl(); ?>' + '/user/index/filterfeedbymatches';
        jQuery.ajax( {
                        url : formURL,
                        type: "POST",
                        //dataType: 'json',
                        data : oData,
                            success: function (returndata) {
								
							if(returndata == 'true'){								
							    var url ='<?php echo $this->baseUrl(); ?>' + '/members/home';
                                window.location.assign(url);								
							}	
							else{
								jQuery('#matchesModal .err_msg').text('You have already added this preference');
								jQuery(".submit_matches_loader").css("display", "none");
                                jQuery('.submit_matches').css('display','block');  
							}

                            },
                            error: function(e){
                           jQuery(".submit_matches_loader").css("display", "none");
                           jQuery('.submit_matches').css('display','block');  }
                        });
        } 
        else{
		  jQuery(".submit_matches_loader").css("display", "none");
          jQuery('.submit_matches').css('display','block');
			
		}               
});

jQuery(document).ready(function(){
	
initAutocomplete1();

});
jQuery('body').on('click', '.comment_btn', function(event){

  var id = jQuery(this).attr('action_id');
  jQuery('#comments .action_id').val(id);
  var oData           = new Object();
  oData.id = id;
  var formURL    = '<?php echo $this->baseUrl(); ?>' + '/user/index/getcomments';
  jQuery.ajax( {
		url : formURL,
		type: "POST",
		dataType: 'json',
		data : oData,
			success: function (returndata) {
				jQuery('#comments .content').html(returndata.html);
			
			},
			error: function(e){
			}
   });
});

 jQuery('body').on('click', '.comment_post_btn', function(event){
	var isValidate = true;
    var action_id =     jQuery('#comments .action_id').val();
    var oData              = new Object();
    oData.id =action_id;
    var feed_comment_body = jQuery('.feed_comment_body').val();
    if(feed_comment_body == ''){
		isValidate = false;
	}
	if(isValidate  == true){
      var feed_comment_body    = oData.feed_comment_body =feed_comment_body;
      var formURL    = '<?php echo $this->baseUrl(); ?>' + '/user/index/postfeedcomment';
            jQuery.ajax( {
                        url : formURL,
                        type: "POST",
                        dataType: 'json',
                        data : oData,
                        success: function (data) { 
							jQuery('#comments .content').html(data.html);
							jQuery('.feed_comment_body').val('');
                            },
                            error: function(e){
                        }
                    
       });

     }   
    });
</script>    
