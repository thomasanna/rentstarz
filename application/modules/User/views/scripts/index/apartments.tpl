<!--
 <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBu9XKcmt0tOyJeZFlJ4wpgNytA8f1DX2U&callback=initMap"
        type="text/javascript"></script>
-->
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAAWRDCCJZYbD17HwNNUMK-6DzyHziKhN8&libraries=places" async defer></script>
<script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/scripts/autocomplete_address_googleapi.js"></script>

<?php
	$userTable             =  Engine_Api::_()->getDbtable('users', 'user');
	$viewHelperObj         =  $this->getHelper('ItemPhoto');

    $postcommentTable =  Engine_Api::_()->getDbtable('Postcomments', 'user');
    $propertyimageTable    =  Engine_Api::_()->getDbtable('propertyimages', 'user');
    $likepropertyTable     =  Engine_Api::_()->getDbtable('likeuser', 'user');


    $status    	   =   'false';
    $popup_status  =	'large_popUp';
    $viewer        =   Engine_Api::_()->user()->getViewer();
    $viwer_id      =   $viewer->getIdentity();
       
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
<!--
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
-->

                <li class="item">
                    <button id="searchID" class="btn btn-primary">SEARCH</button>
                </li>
            </ul>
        </div>
    </div>

    <section class="landlordList mapsLandLord" id="landloard-map">
        <div class="container-fluid">
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
    </section>
<div id="fb-root"></div>


<script type="text/javascript">
jQuery(document).ready(function(){
	
initAutocomplete1();

});



//~ jQuery( "li.media" ).hover(function() {
  //~ var lat  = parseFloat(jQuery(this).attr('data-lat'));
  //~ var longi  = parseFloat(jQuery(this).attr('data-long'));
  //~ initMap(lat,longi); 
//~ });
//~ function initMap(lat,longi) { 
	//~ var uluru = { lat: lat, lng:longi };
	//~ var map = new google.maps.Map(document.getElementById('map'), {
		//~ zoom: 15,
		//~ center: uluru
	//~ });
	//~ var marker = new google.maps.Marker({
		//~ position: uluru,
		//~ map: map
	//~ });
 //}
jQuery(".dropdown  a").click(function(){
 jQuery(this).parents(".dropdown").find('.dropdown-toggle').html(jQuery(this).text() + ' <span class="caret"></span>');
 jQuery(this).parents(".dropdown").find('.dropdown-toggle').attr('dataVal',jQuery(this).attr('tabindex')); 
});		

jQuery('body').on('click', '#searchID', function(event){
	var street = jQuery('.apartement_street').val();
	var neighborhood = jQuery('.apartement_neighborhood').val();
	var city = jQuery('.apartement_city').val();
	var county = jQuery('.apartement_sublocality_level_1').val();
	var state = jQuery('.apartement_state').val();
	var zip = jQuery('.apartement_zip').val();
	var latitude = jQuery('.apartement_latitude').val();
	var longitude = jQuery('.apartement_longitude').val();
	
	var oData           = new Object();
    var street    = oData.street =jQuery.trim(jQuery("#country").val());
    var state      = oData.state =jQuery.trim(jQuery("#administrative_area_level_1").val());
    var city       = oData.city =jQuery.trim(jQuery("#locality").val());
    var country       = oData.country =jQuery.trim(jQuery("#country").val());
    if(city == ''){
         var city        = oData.city =jQuery.trim(jQuery("#sublocality_level_1").val());
    }
    var county           =  oData.county =jQuery.trim(jQuery("#sublocality_level_1").val());
    var neighborhood     =  oData.neighborhood =jQuery.trim(jQuery("#neighborhood").val());
    var street   = oData.street =jQuery.trim(jQuery("#street_number").val());
    var zip          = oData.zip =jQuery.trim(jQuery("#postal_code").val());
    var latitude         = oData.latitude =jQuery.trim(jQuery("#latitude").val());
    var longitude        = oData.longitude =jQuery.trim(jQuery("#longitude").val());
    
    var bedroom       = jQuery('.bedroom_li a').attr('dataVal');
    var propertyType  = jQuery('.propertyType_li a').attr('dataVal');
    var budget        = jQuery('.budget_li a').attr('dataVal');
    
    oData.bedroom =  bedroom;
    oData.propertyType =  propertyType;
    oData.budget =  budget;
   
	
     var formURL    = '<?php echo $this->baseUrl(); ?>' + '/user/index/locationsearch';
     jQuery.ajax( {
                        url : formURL,
                        type: "POST",
                        dataType: 'json',
                        data : oData,
                            success: function (returndata) {
                                       location.href = '<?php echo $this->baseUrl(); ?>' + '/apartments';
                            },
                            error: function(e){
                           jQuery(".set_location_loader").css("display", "none");
                           jQuery(".results-pane-loader").css("display", "none");
                           jQuery('.set_location').css('display','block');  }
                        });
                        
  });
  
   // this loads the Facebook API
    (function (d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) { return; }
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/en_US/sdk.js";
        fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));

    window.fbAsyncInit = function () {
        var appId = '317350178671936';
        FB.init({
            appId: appId,
            status : true, // check login status
			cookie : true, // enable cookies to allow the server to access the session
			xfbml : true, // parse XFBML
            version: 'v2.11'
        });
    }; 
		
    // FB Share with custom OG data.


function fbShare(id,tagText,shareImage,detailedurl){

            var shareBody = jQuery('.feedbody_'+id).val(); 
            var image = '<?php echo $this->baseUrl(); ?>'+shareImage;	
	        var url   = '<?php echo $this->baseUrl(); ?>'+detailedurl; 

                // Dynamically gather and set the FB share data. 
                var FBDesc      = shareBody;
                var FBTitle     = tagText;
                var FBLink      = url;
                var FBPic       = image;

                // Open FB share popup
                FB.ui({
                    method: 'share_open_graph',
                    action_type: 'og.shares',
                    action_properties: JSON.stringify({
                        object: {
                            'og:url': FBLink,
                            'og:title': FBTitle,
                            'og:description': FBDesc,
                            'og:image': FBPic
                        }
                    })
                },
                function (response) {
                // Action after response
                })
}

jQuery('body').on('click', '.like_property', function(event){

	var oData       = new Object();
	var property_id =oData.property_id =parseInt(jQuery(this).attr('property_id'));alert(property_id);
    var self = jQuery(this);
    if(!self.hasClass('saved')){
            var url = '<?php echo $this->baseUrl().'/user/index/likeproperty' ?>';
            jQuery.ajax( {
                        url : url,
                        type: "POST",
                        dataType: 'json',
                        data : oData,
                        success: function (data) {
                        if(data.status==true)
                          {
							self.addClass('saved');

							//~ jQuery('.save_btn_div_'+property_id).html('<button class="unlike_property like_property_'+property_id+'" user_id ="'+property_id+'" title="Unsave">Save</button>');
							//~ jQuery('.like_property_loader_'+property_id).css('display','none');

							//~ var url = '<?php echo $this->baseUrl().'/user/index/getlikedproperties' ?>';
							//~ jQuery.ajax({

								//~ url:  url,
								//~ data: oData,
								//~ dataType: 'json',
								//~ type: 'POST',
								//~ success: function (result) { console.log(result.html);

									//~ jQuery('#likePropertyModal .modal-body').html(result.html);


									//~ },
							   //~ error: function(e){ }
							//~ });

                         }
                        },
                            error: function(e){

                        }
          });
   }

});

</script>
