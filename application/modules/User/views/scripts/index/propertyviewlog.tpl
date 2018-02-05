<script src="/application/modules/User/externals/scripts/message_notififaction.js"></script>
<script>
<?php $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); ?>

var viewer_identity='<?php echo $viwer_id; ?>';	
</script>
<div class="generic_layout_container layout_main">
<?php /*<div class="generic_layout_container layout_left">
<div class="generic_layout_container layout_user_profile_photo">
<div id="profile_photo">
	
 <img src= <?php echo $this->baseUrl().'/'. $this->propertyData->image;?>>
</div>
</div>

<div class="generic_layout_container layout_user_profile_info"><div class="ybo_headline"><h3>Property Info</h3></div>
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
  <!--<li>
    <span class="qwerty">Zipcode</span> <span class="sep">:</span> <span class="xyz"> <?php echo $this->propertyData->zipcode;?> </span> 
  <li>-->
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
</div> */?>


<h3>
<ul class="navigation">

  <li class="active"><a href="<?php echo $this->baseUrl().'/property/'.$this->propertyData->id?>">Back to <?php echo $this->propertyData->property_name;?></a></li>

  </ul>
</h3>


<div class="generic_layout_container layout_middle">
<div class="generic_layout_container layout_user_profile_status">
<div id="profile_status">
	 <h2 style="float: left;">
     <a style="color: #364347;" href="<?php echo $this->baseUrl().'/property/'.$this->propertyData->id?>"><?php echo $this->propertyData->property_name;?></a>	<br>
  </h2>
</div>	

<div class="property_viewlog_content">
	
	<?php foreach($this->propertyViewLogData as $data):?>

	<div class="property_view_user_li">

    <span class="user_profile">
		
	<?php $userTable = Engine_Api::_()->getDbtable('users', 'user');  
     $userData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $data['user_id']));

   ?>
    
    <?php echo $this->htmlLink($userData->getHref(), $this->itemPhoto($userData, 'thumb.icon', $userData->getTitle()), array('title'=>$userData->getTitle())) ?>
    
     </span>
     <span class="user_title">    <?php echo $userData->displayname;?> </span>

	</div>
    <hr>
    <?php endforeach;?>
</div>	

</div>	
</div>
</div>	
