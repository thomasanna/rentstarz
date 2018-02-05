<script src="/application/modules/User/externals/scripts/message_notififaction.js"></script>
<script>
<?php $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); ?>

var viewer_identity='<?php echo $viwer_id; ?>';	
</script>
<?php $viewer     = Engine_Api::_()->user()->getViewer();
 $viewerId=Engine_Api::_()->user()->getViewer()->getIdentity(); 
?>


<div class="generic_layout_container layout_main">
<?php /*div class="generic_layout_container layout_left">
<div class="generic_layout_container layout_user_profile_photo">
<div id="profile_photo">

 <img src= <?php echo $this->baseUrl().'/'. $this->propertyData->image;?>>
</div>
</div>

<div class="generic_layout_container layout_user_profile_info">
<div class="ybo_headline"><h3>Property Info</h3></div>
<?php
$landlord_name = $this->landlordUser->displayname;
if($landlord_name ==''){
	            $landlord_email = $this->landlordUser->email;
				$landlord_name  = ucwords(strstr($landlord_email,'@', true));				
				$landlord_name  = ucwords(str_replace("."," ",$landlord_name));	
			}
?>
<ul>
<li><?php echo $this->htmlLink($this->landlordUser->getHref(), $this->itemPhoto($this->landlordUser, 'thumb.icon', $this->landlordUser->getTitle()), array('title'=>$this->landlordUser->getTitle())) ?></li>	
  <li>
    <span class="qwerty">Owned by</span> <span class="sep"> :</span> <span class="xyz"><?php echo $landlord_name;?></span>  </li>
  <li>
  <li>
    <span class="qwerty">Rental type</span> <span class="sep">:</span> <span class="xyz"> <?php echo $this->propertyData->rental_type;?></span>  
  <li>
  <li>
    <span class="qwerty">Country</span> <span class="sep">: </span> <span class="xyz"><?php echo $this->propertyData->prty_country;?></span>  
  <li>
  <li>
    <span class="qwerty">State</span> <span class="sep">:</span> <span class="xyz"> <?php echo $this->propertyData->prty_state;?></span> 
  <li>
  <li>
    <span class="qwerty">City</span> <span class="sep">:</span> <span class="xyz"> <?php echo $this->propertyData->prty_city;?> </span> 
  <li>

  <li>
    <span class="qwerty">Housing type</span> <span class="sep">: </span> <span class="xyz">   <?php echo $this->propertyData->housing_type;?> </span> 
  <li>
	  
  <li>
    <span class="qwerty">Number of bedrooms</span> <span class="sep">: </span> <span class="xyz">  <?php echo $this->propertyData->no_of_rooms;?> </span> 
  <li>
  
  <li>
    <span class="qwerty">Pets allowed</span> <span class="sep">: </span> <span class="xyz">   <?php echo $this->propertyData->has_pets;?> </span> 
  <li>
   <?php if($this->propertyData->has_pets == 'Yes'):?>
  <li>
    <span class="qwerty">Type of pets</span> <span class="sep">: </span> <span class="xyz"> <?php echo $this->propertyData->pets_type;?> </span> 
   <li>
	<?php endif;?>  
   <li>
    <span class="qwerty">Rental prices (monthly)</span> <span class="sep">: </span> <span class="xyz"> <?php echo $this->propertyData->price;?> </span> 
   <li>

</ul>
</div>
</div> 


<h3>
<ul class="navigation">
<?php if($viewerId == $this->landlordUser->user_id):?>	
  <li class="active"><a href="<?php echo $this->baseUrl().'/myproperties'?>">My Properties</a></li>
<?php else:?> 
  <li class="active"><a href="<?php echo $this->baseUrl().'/properties/'.$this->landlordUser->user_id?>">Properties Of <?php echo $landlord_name;?></a></li>
<?php endif;?> 
  </ul>
</h3>*/ ?>

<div class="generic_layout_container layout_middle">
<div class="generic_layout_container layout_user_profile_status">
<div id="profile_status">

 <div class="property_status">	
  <span style="font-size: 26px;">
     <a href="<?php echo $this->baseUrl().'/property/'.$this->propertyData->id?>"><?php echo $this->propertyData->property_name;?></a>	
  </span>
  
  
 <?php if($this->propertyData->view_count !=0):?>
  <div><img src="/application/modules/User/externals/images/eye.png" title="views" style="margin-right: 7px;"><a href="<?php echo $this->baseUrl().'/property/view/'.$this->propertyData->id?>"><?php echo  $this->propertyData->view_count;?> views</a></div>
 <?php endif;?>
 
 </div>


</div>
</div>


<div class="property_list_content">
	
	<div id="map"></div>

</div>
</div>


</div>




<script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAOdWM32gJ4t6-csxQQxCVDigYfq261xi0&libraries&callback=initMap">
    </script>

<script>
	
	var latitude = <?php echo $this->propertyData->latitude;?>;
	var longitude = <?php echo $this->propertyData->longitude;?>;
	var title = '<?php echo $this->propertyData->prty_city;?>';

 function initMap() {
        var myLatLng = {lat: latitude, lng: longitude};

        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 4,
          center: myLatLng
        });

        var marker = new google.maps.Marker({
          position: myLatLng,
          map: map,
          title: title
        });
      }


</script>
