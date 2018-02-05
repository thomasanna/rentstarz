<script src="/application/modules/User/externals/scripts/message_notififaction.js"></script>
<link rel="stylesheet" href="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/styles/online.css" type="text/css">
<?php $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); ?>
<script >
	var viewer_identity='<?php echo $viwer_id; ?>';
	jQuery( function() {
  var $winHeight = jQuery( window ).height()
  jQuery( '.container' ).height( $winHeight );
    });
</script>
<?php 
$online_users=$this->online_users;

   $online_user_id = array();
   foreach($online_users as $row):

   $online_user_id[]=$row['user_id'];
   endforeach;
  // print_r($online_user_id);exit;
    ?>
<?php
$useragent=$_SERVER['HTTP_USER_AGENT'];

$iPod = stripos($_SERVER['HTTP_USER_AGENT'],"iPod");
$iPhone = stripos($_SERVER['HTTP_USER_AGENT'],"iPhone");
$iPad = stripos($_SERVER['HTTP_USER_AGENT'],"iPad");
$Android = stripos($_SERVER['HTTP_USER_AGENT'],"Android");
$webOS = stripos($_SERVER['HTTP_USER_AGENT'],"webOS");
//if(preg_match('/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino/i',$useragent)||preg_match('/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i',substr($useragent,0,4))){
if( $iPod || $iPhone || $iPad || $Android)	{		
	$dev_type= 1; // mobile
	
}
else{
	
	$dev_type= 2; // system
}
?>
<!--<script src="http://p.jwpcdn.com/6/10/jwplayer.js"></script>-->
<div class="layout_page_user_index_browse">
<div class="generic_layout_container layout_top">
<div class="generic_layout_container layout_middle">

</div>
</div>

<div class="generic_layout_container layout_main">
<div class="generic_layout_container layout_left">
<div class="generic_layout_container layout_user_browse_search">


<input type="hidden" id="sPage" value="1"/>
<form  id="search_properties" class="field_search_criteria" method="post" action="<?php echo $this->baseUrl().'/properties' ?>"><div class="browsemembers_criteria">
	<input type="hidden" value="" name="is_search" class="is_search">
<ul>
	<li><span id="keyword-label"><label for="keyword" class="optional">Keyword</label></span>
	<input name="keyword" type="text" maxlength="15" placeholder="Property name" id="keyword"  >
	</li>
	<li><span id="country-label"><label for="country" class="optional">Country</label></span>
	<select name="country" id="country" class="field_toggle parent_0 option_0 field_1 " onchange=""></select>
	</li>
	
	<li><span id="state-label"><label for="state" class="optional">State</label></span>
	<select name="state" id="state" class="field_toggle parent_0 option_0 field_1 " onchange=""></select>
	</li>
	<li><span id="city-label"><label for="city" class="optional">City</label></span>
	<select name="city" id="city" class="field_toggle parent_0 option_0 field_1 " onchange=""></select>
	</li>
	<li><span id="city-label"><label for="city" class="optional">Zip Code</label></span>
	<input name="zipcode" type="text" maxlength="15" placeholder="Zip Code" id="zipcode"  >
	</li>
	
	<li><span id="housing_type-label"><label for="housing_type" class="optional">Type of housing</label></span>
	<select name="housing_type" id="housing_type" class="field_toggle parent_0 option_0 field_1 " onchange="">
		
		<option value="">Select housing type</option>
		<option value="Apartment">Apartment</option>
		<option value="Villa">Villa</option>
		<option value="House">House</option>
		<!--<option value="Bedroom">Bedroom</option>-->

	</select></li>
	
	<li><span id="no_of_rooms-label"><label for="no_of_rooms" class="optional">Number of bedrooms</label></span>


	<select name="no_of_rooms" id="no_of_rooms" class="field_toggle parent_0 option_0 field_1 " onchange="">
		
		<option value="">Number of bedrooms</option>
		<option value="1">1</option>
		<option value="2">2</option>
		<option value="3">3</option>
		<option value="4">4</option>
		<option value="4+">4+</option>

	</select>
	
    </li>
    
	<li><span id="allowed_pets-label"><label for="allowed_pets" class="optional">Pets allowed</label></span>


	<select name="allowed_pets" id="allowed_pets" class="field_toggle parent_0 option_0 field_1 " onchange="displayPetsType()">
		
		 <option value="">Select</option>
		 <option value="Yes">Yes</option>
		 <option value="No">No</option>

	</select>
	
    </li>
    
	<li><span class="pets_type_span" style="display:none;"><span id="pets_type-label"><label for="pets_type" class="optional">Type of pets</label></span>


	<select name="pets_type" id="pets_type" class="field_toggle parent_0 option_0 field_1 " onchange="">
		
		 <option value="">Select pets type</option>
		 <option value="Cats">Cats</option>
		 <option value="Dogs">Dogs</option>
		 <option value="Cats & Dogs">Cats & Dogs</option>
		 <option value="Birds">Birds</option>
		 <option value="Small pets">Small pets</option>

	</select>
	</span>
    </li>
    
	<li><span id="rental_type-label"><label for="rental_type" class="optional">Type of rental</label></span>
	<select name="rental_type" id="rental_type" class="field_toggle parent_0 option_0 field_1 " onchange="">
		
		<option value="">Select rental type</option>
		<option value="Rent">Rent</option>
		<option value="Lease">Lease</option>

	</select></li>

	
	<li><span id="price-label"><label for="price" class="optional">Rental prices (monthly)</label></span>
	<select name="price" id="price" class="field_toggle parent_0 option_0 field_1 " onchange="">
		
		                               <!--     <option value="">Select price</option>
											 <option value="500 - 1,000">500 - 1,000</option>
											 <option value="1,100 - 1,800">1,100 - 1,800</option>
											 <option value="2,000 - 2,800">2,000 - 2,800</option>
											 <option value="3,000 - 3,800">3,000 - 3,800</option>
											 <option value="4,000 - 4,800">4,000 - 4,800</option>
											 <option value="5,000+">5,000+</option> -->
											 
											 
											 
											 			<option value="">Select price</option>
											 <option value="500 - 1,000">500 - 1,000</option>
											 <option value="1,001 - 1,800">1,001 - 1,800</option>
											 <option value="1,801 - 2,000">1,801 - 2,000</option>
											 <option value="2,001 - 2,800">2,001 - 2,800</option>
											 
											 <option value="2,801 - 3,000">2,801 - 3,000</option>
											 <option value="3,001 - 3,800">3,001 - 3,800</option>
											 
											 <option value="3,801 - 4000">3,801 - 4000</option>
											 <option value="4,001 - 4,800">4,001 - 4,800</option>
											 <option value="4,801 - 5000">4,801 - 5,000</option>
											 <option value="5,000+">5,000+</option>
											 

	</select></li>
</ul>

<div id="done-wrapper" class="form-wrapper"><div id="done-label" class="form-label">&nbsp;</div><div id="done-element" class="form-element">
<button name="" id="search_btn" type="submit" onClick="search();">Search</button></div></div></ul></div></form>

</div>
</div>

<div class="generic_layout_container layout_middle">
<div class="generic_layout_container layout_core_content">

<div class="browsemembers_results" id="browsemembers_results">
  <h3>
<?php  echo $this->totalproperties; ?> Properties found</h3>

    <ul id="browsemembers_ul">
	  
	  <?php foreach($this->propertyData as $properities):  ?>
	  
	  
	  
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
         <a href="<?php echo $this->baseUrl().'/property/'.$properities['id'] ?>" title="View Property"><?php echo $properities['property_name']; ?></a>                                 
        

        
        
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
				/*if($video_count>0):
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
				   
		   <?php //else:?>
		   <!-- <span><img src="/application/modules/User/externals/images/rent.png" alt="" class="feed_property_rentaltype_image"> </span>
				 -->  
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
    
 <?php /*   <div class="property_owner_data">
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
        </div> */ ?>
        </li>
        <?php endforeach;?> 
    </ul>


    
 <?php if($this->totalproperties > 10):?>
 <div class="holder_div_inn loadmore"> <a href="javascript:void(0);">Load More +</a> </div>
 <?php endif;?>
					
</div>

</div>
</div>
</div>
</div>


<!-- map popup ------>
<div id="light" class="white_content map_popup">

<div class="pop_up_title"><div class="div_attachment_title"></div><div class="div_attachment_cancel"><img src="/application/modules/User/externals/images/GREYcancel.png"></div></div>
<div class="popup_content">
<div class="map_div">
<div id="map"></div>

</div>
</div>
</div>


<div id="fade" class="black_overlay"></div>

<script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAOdWM32gJ4t6-csxQQxCVDigYfq261xi0&libraries">
</script>


<script type="text/javascript">




	    
jQuery( document ).ready(function() {
	
	var is_search ='<?php echo $this->is_search;?>'; 
	if(is_search ==1){
		
		var country ='<?php echo $this->country; ?>';
		var state ='<?php echo $this->state; ?>';
		var city ='<?php echo $this->city; ?>';
		var no_of_rooms ='<?php echo $this->no_of_rooms; ?>';
		var rental_type ='<?php echo $this->rental_type; ?>';
		var housing_type ='<?php echo $this->housing_type; ?>';
		var price ='<?php echo $this->price; ?>';
		var zipcode ='<?php echo $this->zipcode; ?>';
		var keyword ='<?php echo $this->keyword; ?>';
		var allowed_pets ='<?php echo $this->allowed_pets; ?>';
		var pets_type ='<?php echo $this->pets_type; ?>';

		if(state !=''){
			
		   var url = '<?php echo $this->baseUrl(); ?>' + '/user/index/getpropertystates';  
	       var country_id	=	country; 
	       jQuery('#state').html('');
		   jQuery.ajax({
					 url:  url,
					data: "countryId="+country_id,
					dataType: 'json',
					type: 'POST',
				 success: function (data) { console.log(data);
                    jQuery('#state').append('<option value="">Select state</option>');
					jQuery.each(data, function (i, item) {
				    if(state == item.id){
						jQuery('#state').append(jQuery('<option>', { 
						value: item.id,
						text : item.state,
						selected : "selected" 
					}));
					}
					else{								
					jQuery('#state').append(jQuery('<option>', { 
						value: item.id,
						text : item.state 
					}));
				}
				});},
				   error: function(e){  alert('Error: '+e);  }  
				});

		}
		if(city!=''){
			
		   var url = '<?php echo $this->baseUrl(); ?>' + '/user/index/getpropertycity'; 
           var state_id	=	state;  
	       jQuery('#city').html('');
		   jQuery.ajax({
					 url:  url,
					data: "stateId="+state_id,
					dataType: 'json',
					type: 'POST',
				 success: function (data) { console.log(data);
                    jQuery('#city').append('<option value="">Select city</option>');
					jQuery.each(data, function (i, item) {
						if(city ==item.id ){
							
						jQuery('#city').append(jQuery('<option>', { 
						value: item.id,
						text : item.city,
						selected:"selected" 
					}));
						}
					else{	
					jQuery('#city').append(jQuery('<option>', { 
						value: item.id,
						text : item.city 
					}));
				}
				});},
				   error: function(e){  alert('Error: '+e);  }  
				});
			
		}
		if(no_of_rooms !=''){
			
			 jQuery('#no_of_rooms').val('<?php echo $this->no_of_rooms; ?>'); 			
			
			
		}
		if(rental_type !=''){
			
			 jQuery("#rental_type option[value='"+rental_type+"']").attr('selected', true);			
			
			
		}
		if(housing_type !=''){
			
			 jQuery("#housing_type option[value='"+housing_type+"']").attr('selected', true);			
			
			
		}
		if(price !=''){
			
			 jQuery("#price option[value='"+price+"']").attr('selected', true);			
			
			
		}
		
		if(zipcode !=''){
			
			  jQuery('#zipcode').val('<?php echo $this->zipcode; ?>'); 			
			
			
		}
	
		if(allowed_pets !=''){
			
			  jQuery("#allowed_pets option[value='"+allowed_pets+"']").attr('selected', true); 			
		
		}
		if(pets_type !=''){
			  jQuery('.pets_type_span').css("display","block");
			  jQuery("#pets_type option[value='"+pets_type+"']").attr('selected', true); 			
		
		}
		if(keyword !=''){
			
			  jQuery('#keyword').val('<?php echo $this->keyword; ?>'); 			
			
			
		}
		
	}
	else{
		var keyword ='';
		var country ='';
		var state ='';
		var city ='';
		var no_of_rooms ='';
		var rental_type ='';
		var housing_type ='';
		var price ='';
		var zipcode ='';
		var allowed_pets ='';
		var pets_type ='';
		
	}
	
	
var url = '<?php echo $this->baseUrl(); ?>' + '/user/index/getpropertycountries'; 
		  jQuery.ajax({
					 url:  url,
					
					dataType: 'json',
					type: 'POST',
				 success: function (data) { 
					 jQuery('loadmore#country').append('<option value="">Select country</option>');

					jQuery.each(data, function (i, item) {
					
							if(country !='' && item.id == country && is_search == 1){
								jQuery('#country').append(jQuery('<option>', { 
								value: item.id,
								text : item.country,
								selected:"selected" 
					        }));
							}
						
						else{
					jQuery('#country').append(jQuery('<option>', { 
						value: item.id,
						text : item.country 
					}));
				}
				});},
				   error: function(e){  alert('Error: '+e);  }  
				});
    
});	

jQuery( "#country" ).change(function() {
	
  var url = '<?php echo $this->baseUrl(); ?>' + '/user/index/getpropertystates';  
	var country_id	=	jQuery('#country').val(); 
	jQuery('#state').html('');
		  jQuery.ajax({
					 url:  url,
					data: "countryId="+country_id,
					dataType: 'json',
					type: 'POST',
				 success: function (data) { console.log(data);
					 
					 jQuery('#city').html('');
                    
					 
                    jQuery('#state').append('<option value="">Select state</option>');
                    
					jQuery.each(data, function (i, item) {						
					jQuery('#state').append(jQuery('<option>', { 
						value: item.id,
						text : item.state 
					}));
				});},
				   error: function(e){  alert('Error: '+e);  }  
				});
});

jQuery( "#state" ).change(function() {
	
  var url = '<?php echo $this->baseUrl(); ?>' + '/user/index/getpropertycity'; 
  var state_id	=	jQuery('#state').val();  
	jQuery('#city').html('');
		  jQuery.ajax({
					 url:  url,
					data: "stateId="+state_id,
					dataType: 'json',
					type: 'POST',
				 success: function (data) { console.log(data);
                    jQuery('#city').append('<option value="">Select city</option>');
					jQuery.each(data, function (i, item) {
					jQuery('#city').append(jQuery('<option>', { 
						value: item.id,
						text : item.city 
					}));
				});},
				   error: function(e){  alert('Error: '+e);  }  
				});
});




function search() {
	
	jQuery('.is_search').val(1);
	jQuery('form#search_properties').submit();
	
};

jQuery( ".loadmore" ).click(function() {
	
	   var is_search ='<?php echo $this->is_search;?>';   
	    var oData       = new Object();
	     if(is_search ==1){
		
			oData.country ='<?php echo $this->country; ?>';
			oData.keyword ='<?php echo $this->keyword; ?>';
			oData.state ='<?php echo $this->state; ?>';
			oData.city ='<?php echo $this->city; ?>';
			oData.no_of_rooms ='<?php echo $this->no_of_rooms; ?>';
			oData.rental_type ='<?php echo $this->rental_type; ?>';
			oData.housing_type ='<?php echo $this->housing_type; ?>';
			oData.price ='<?php echo $this->price; ?>';
			oData.allowed_pets ='<?php echo $this->allowed_pets; ?>';
			oData.pets_type ='<?php echo $this->pets_type; ?>';
			oData.is_search =1;
		
	    }
	    else{
			
			 oData.country ='';
			 oData.state ='';
			 oData.city ='';
			 oData.no_of_rooms ='';
			 oData.rental_type ='';
			 oData.housing_type ='';
			 oData.is_search ='';
			 oData.price ='';
			 oData.allowed_pets ='';
			 oData.pets_type ='';
			
		}

			var total_count='<?php echo $this->totalproperties;?>'; 
	        var listperpage=10;
	        var totalpages = Math.ceil(total_count/listperpage); 
			var licontent=(jQuery("#browsemembers_ul li") .children()).length;
			
			if(totalpages >  jQuery('#sPage').val()){


						var noRecordsprecent = parseInt(jQuery("#browsemembers_ul li").length); 
						var sBaseUrl         = '<?php echo $this->baseUrl(); ?>';
						var sUrl             = sBaseUrl + '/user/index/searchpropertiesajax/offset/'+noRecordsprecent+'/limit/'+listperpage;
						
						pagecount            = parseInt(jQuery('#sPage').val()) + 1;
						jQuery('#sPage').val(pagecount);
						
						jQuery.ajax({
							async:false,
							url:sUrl,
							data : oData,
							type: "POST",
							dataType: 'json',
							//data:oRpost,
							success:function(data) {
							var html   = jQuery(data.html);
								
								jQuery("#browsemembers_ul").append(html);
								if(totalpages == jQuery('#sPage').val()){
				
									jQuery( ".loadmore" ).hide();
								}
								
							}
						});

				if(licontent==0)
				{
				
				}
			}

		});
		
    function displayPetsType(){

				var pets_allowed= jQuery("#allowed_pets").val(); 
				if(pets_allowed =='No' || pets_allowed==''){
				
					jQuery('.pets_type_span').css("display","none");
					jQuery("#pets_type").val(''); 
				}
				else{
					jQuery('.pets_type_span').css("display","block");
				}

	}
	
	
jQuery( ".location_icon" ).click(function() {
	

	var id  = jQuery(this).data("id");
	var city  = jQuery(this).data("city");

    var url =  '<?php echo $this->baseUrl().'/property/map/' ?>' +id;
		
	 
	jQuery('.div_attachment_title').html();
	jQuery('.div_attachment_title').html('<a href="'+url+'" target="_blank">View Full Map</a>');
	
	jQuery('.map_div').html();
	jQuery('.map_div').html('<div id="map"></div>');
	
	jQuery('#light').css('display','block');
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

	jQuery('#fade').css('display','none');
	jQuery('#light').css('display','none');
	
});
</script>















