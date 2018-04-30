 <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBu9XKcmt0tOyJeZFlJ4wpgNytA8f1DX2U&callback=initMap"
        type="text/javascript"></script>
<?php
	$userTable             =  Engine_Api::_()->getDbtable('users', 'user');
	$viewHelperObj         =  $this->getHelper('ItemPhoto');



?>        
 <!--    map tabbing section-->
    <div class="filter-search searchFilter">
        <div class="container">
            <ul>
                <li class="item">
                    <div class="input-group">
                        <span class="input-group-addon" id="basic-addon1">
                            <i class="fa fa-map-marker"></i>
                        </span>
                        <input type="text" class="form-control" placeholder="Enter Location, Project and Landmark" aria-describedby="basic-addon1">
                    </div>
                    <!-- <a href="javascript:void(0)" class="filterLinks">&nbsp; Enter Location, Project and Landmark</a> -->
                </li>

                <li class=" dropdown">
                    <a class="dropdown-toggle" id="menu4" type="" data-toggle="dropdown">
                        <i class="fa fa-home"></i>&nbsp;Property Type
                        <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu" role="menu4" aria-labelledby="menu3">
                        <li role="presentation">
                            <a role="menuitem" tabindex="-1" href="#">HTML</a>
                        </li>
                        <li role="presentation">
                            <a role="menuitem" tabindex="-1" href="#">CSS</a>
                        </li>
                        <li role="presentation">
                            <a role="menuitem" tabindex="-1" href="#">JavaScript</a>
                        </li>
                        <li role="presentation" class="divider"></li>
                        <li role="presentation">
                            <a role="menuitem" tabindex="-1" href="#">About Us</a>
                        </li>
                    </ul>
                </li>
                <li class=" dropdown">
                    <a class="dropdown-toggle" id="menu5" type="" data-toggle="dropdown">
                        <i class="fa fa-dollar"></i>&nbsp;Budget
                        <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu" role="menu5" aria-labelledby="menu3">
                        <li role="presentation">
                            <a role="menuitem" tabindex="-1" href="#">HTML</a>
                        </li>
                        <li role="presentation">
                            <a role="menuitem" tabindex="-1" href="#">CSS</a>
                        </li>
                        <li role="presentation">
                            <a role="menuitem" tabindex="-1" href="#">JavaScript</a>
                        </li>
                        <li role="presentation" class="divider"></li>
                        <li role="presentation">
                            <a role="menuitem" tabindex="-1" href="#">About Us</a>
                        </li>
                    </ul>
                </li>
                <li class=" dropdown">
                    <a class="dropdown-toggle" id="menu3" type="" data-toggle="dropdown">
                        <img src="assets/images/bedroom.png" alt="">&nbsp;Bedroom
                        <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu" role="menu3" aria-labelledby="menu3">
                        <li role="presentation">
                            <a role="menuitem" tabindex="-1" href="#">HTML</a>
                        </li>
                        <li role="presentation">
                            <a role="menuitem" tabindex="-1" href="#">CSS</a>
                        </li>
                        <li role="presentation">
                            <a role="menuitem" tabindex="-1" href="#">JavaScript</a>
                        </li>
                        <li role="presentation" class="divider"></li>
                        <li role="presentation">
                            <a role="menuitem" tabindex="-1" href="#">About Us</a>
                        </li>
                    </ul>
                </li>
                <li class=" dropdown">
                    <button class="dropdown-toggle morebutton" id="more" type="" data-toggle="dropdown">More &nbsp;
                        <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu" role="more" aria-labelledby="more">
                        <li role="presentation">
                            <a role="menuitem" tabindex="-1" href="#">HTML</a>
                        </li>
                        <li role="presentation">
                            <a role="menuitem" tabindex="-1" href="#">CSS</a>
                        </li>
                        <li role="presentation">
                            <a role="menuitem" tabindex="-1" href="#">JavaScript</a>
                        </li>
                        <li role="presentation" class="divider"></li>
                        <li role="presentation">
                            <a role="menuitem" tabindex="-1" href="#">About Us</a>
                        </li>
                    </ul>
                </li>

                <li class="item">
                    <button id="searchID" class="btn btn-primary">SEARCH</button>
                </li>
            </ul>
        </div>
    </div>

    <section class="landlordList mapsLandLord">
        <div class="container-fluid">
            <div id="map"></div>
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
		?>
		

                <li class="media" onclick="initMap(28.612434,77.387733);">
                    <div class="media-left">
                        <figure class="img">
                       <?php echo $this->htmlLink($UserData->getHref(), $this->itemPhoto($UserData, 'thumb.icon', $UserData->getTitle()), array('title'=>$UserData->getTitle())) ?>

                        </figure>
                    </div>
                    <div class="media-body">
                        <div class="content">
                            <h2><?php echo $data['property_name'];?></h2>
                            <p>
                            <?php 
								$description  = strip_tags($data['description']);
								if(strlen($description)<=300){echo $description;}
								else{$description=substr($description,0,300) . '...'; echo $description;}
								?>					

                            </p>
                            <div class="row cotentlenks">
                                <div class="col-sm-12">
                                    <span>
                                        <a><i class="fa fa-envelope"></i>&nbsp;Message</a></span>
                                    <span>
                                        <a><i class="fa fa-video-camera"></i>&nbsp; Video</a>
                                    </span>
                                    <span>
                                        <a><i class="fa fa-share"></i>&nbsp; Share</a>
                                    </span>
                                    <span>
                                        <a><i class="fa fa-heart"></i>&nbsp;56 Likes</a></span>
                                    <span>
                                        <a><i class="fa fa-eye"></i>&nbsp;563 Views</a>
                                    </span>
                                    <span>
                                        <a href="#" data-toggle="modal" data-target="#comments"><i class="fa fa-comment" ></i>&nbsp;36 Comments </a>
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
                            <button class="btn btn-default full-width text-center"> Save </button>
                        </div>
                    </div>

                </li>
                <?php endif;?>
               <?php endforeach;?>

            </ul>            
        </div>
    </section>
