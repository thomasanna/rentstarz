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
                    <a href="javascript:void(0)" class="filterLinks">New Scout</a>
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
                                    <span>
									<?php if($viewer): ?>
										 <?php if($dev_type == 1):  $popup_status = 'mobile'; // mobile?> 
										 <a href="<?php echo $this->baseUrl().'/tichat/singlechatmob'; ?>" target="_blank" onClick="popUpChatClick('<?php echo $UserData->user_id ?>','<?php echo $UserData->displayname; ?>','<?php echo $src ?>','<?php echo $popup_status ?>')"><i class="fa fa-envelope"></i>&nbsp;&nbsp;Message</a>
									     <?php else: ?>
										 <span onClick="popUpChatClick('<?php echo $UserData->user_id ?>','<?php echo $UserData->displayname; ?>','<?php echo $src ?>','<?php echo $popup_status ?>')">
											<a href="javascript:void(0)" ><i class="fa fa-envelope"></i>&nbsp;&nbsp;Message</a>
									     <?php endif; ?>
								   <?php else:?>	
								     <a><i class="fa fa-envelope"></i>&nbsp;Message</a></span>     
								   <?php endif; ?>
                                       
                                    <span>
										<?php if($viewer): ?>
										 <?php if($dev_type == 1):  $popup_status = 'mobile'; // mobile?> 
										 <a href="<?php echo $this->baseUrl().'/tichat/singlechatmob'; ?>" target="_blank" onClick="popUpChatClick('<?php echo $UserData->user_id ?>','<?php echo $UserData->displayname; ?>','<?php echo $src ?>','<?php echo $popup_status ?>')"><i class="fa fa-video-camera"></i>&nbsp;&nbsp;Video</a>
									     <?php else: ?>
										 <span onClick="popUpChatClick('<?php echo $UserData->user_id ?>','<?php echo $UserData->displayname; ?>','<?php echo $src ?>','<?php echo $popup_status ?>')">
											<a href="javascript:void(0)" ><i class="fa fa-video-camera"></i>&nbsp;&nbsp;Video</a>
									     <?php endif; ?>
										 <?php else:?>	
											 <a><i class="fa fa-video-camera"></i>&nbsp;Video</a></span>     
										 <?php endif; ?>
                                    </span>
                                    <span>
                                        <a onClick="fbShare('<?php echo  $data['id']; ?>','<?php echo $tagtext ?>','<?php echo $feed_image; ?>','<?php echo $detailUrl; ?>')"><i class="fa fa-share"></i>&nbsp; Share</a>
                                    </span>
                                    <span>
                                        <a><i class="fa fa-heart"></i>&nbsp;<?php echo count($totalLikes);?> Likes</a></span>
                                    <span>
                                        <a><i class="fa fa-eye"></i>&nbsp;<?php echo $data['view_count'];?> Views</a>
                                    </span>
                                    <span>
                                        <a href="#" data-toggle="modal" data-target="#comments"><i class="fa fa-comment" ></i>&nbsp;<?php echo $commentCount;?> Comments </a>
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
<?php endif;?>    
  <!-- End renter home feed-->  

    <script>
        $(document).ready(function () {
            $('.Listcontainer').paginathing({
                perPage: 3,
                limitPagination: 4,
                containerClass: 'panel-footer',
                pageNumbers: true,
                cssStyle: 'light-theme'
            });

        });
    </script>
