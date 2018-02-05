<script src="/application/modules/User/externals/scripts/message_notififaction.js"></script>
<script>
<?php $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); ?>

var viewer_identity='<?php echo $viwer_id; ?>';	
</script>
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
<div class="generic_layout_container layout_main">

<div class="generic_layout_container layout_left">
	
	<?php if($dev_type == 2):?> 
	
<div class="generic_layout_container layout_user_profile_photo">
<div id="profile_photo">

 <img src= "/application/modules/User/externals/images/property_requiremnet.png" >
</div>
</div>

<div class="generic_layout_container layout_user_profile_info">

<div class="ybo_headline"><h3>Requirement Info</h3></div>
<?php
$teanant_name = $this->tenantUser->displayname;

?>
<ul>

<li><?php echo $this->htmlLink($this->tenantUser->getHref(), $this->itemPhoto($this->tenantUser, 'thumb.icon', $this->tenantUser->getTitle()), array('title'=>$this->tenantUser->getTitle())) ?></li>	
<li>
    <span class="qwerty">Posted by</span> <span class="sep"> :</span> <span class="xyz"><?php echo $teanant_name;?></span>  </li>
<li>
<li>
    <span class="qwerty">Country</span> <span class="sep">: </span> <span class="xyz"><?php echo $this->propertyRequirementData->prty_country;?></span>  
<li>
<li>
    <span class="qwerty">State</span> <span class="sep">:</span> <span class="xyz"> <?php echo $this->propertyRequirementData->prty_state;?></span> 
<li>
<li>
    <span class="qwerty">City</span> <span class="sep">:</span> <span class="xyz"> <?php echo $this->propertyRequirementData->prty_city;?> </span> 
<li>
<li>
    <span class="qwerty">Housing type</span> <span class="sep">: </span> <span class="xyz">   <?php echo $this->propertyRequirementData->housing_type;?> </span> 
<li>
	  
<li>
    <span class="qwerty">Number of bedrooms</span> <span class="sep">: </span> <span class="xyz">  <?php echo $this->propertyRequirementData->no_of_rooms;?> </span> 
<li>
  
<li>
    <span class="qwerty">Pets allowed</span> <span class="sep">: </span> <span class="xyz">   <?php echo $this->propertyRequirementData->pets_allowed;?> </span> 
<li>
<?php if($this->propertyRequirementData->pets_allowed == 'Yes'):?>
<li>
    <span class="qwerty">Type of pets</span> <span class="sep">: </span> <span class="xyz"> <?php echo $this->propertyRequirementData->pets_type;?> </span> 
<li>
<?php endif;?> 
<li>
    <span class="qwerty">Budget</span> <span class="sep">: </span> <span class="xyz">  <?php echo $this->propertyRequirementData->budget;?> 
    <?php if($this->propertyRequirementData->budget_range_to !=''):?>
    <?php echo " - ". $this->propertyRequirementData->budget_range_to;?> 
    <?php endif;?>
     </span> 
<li> 
	
</ul>
<?php endif; ?>
</div>
</div>


<h3>
<ul class="navigation">
<li class="active"></li>
</ul>
</h3>

<div class="generic_layout_container layout_middle">

	<?php if($dev_type == 1):?> 
	<div class="generic_layout_container layout_user_profile_status" >
	<div id="profile_status">
	<div class="property_status" >
		<?php echo "Property requirement for " ; ?>
<?php echo $this->propertyRequirementData->no_of_rooms." ";?>
<?php if($this->propertyRequirementData->no_of_rooms > 1):
echo "bedrooms " ;
else:
echo "bedroom";
?>
<?php endif; ?>
<?php echo $this->propertyRequirementData->housing_type." at ";?>
<?php echo $this->propertyRequirementData->prty_city.", ";?>
<?php echo $this->propertyRequirementData->prty_state;?>

</div>
</div>

</div>
<?php endif; ?>


<div class="property_list_content">
	
	<div id="map"></div>
<div class="back-button"><a href="<?php echo $this->baseUrl().'/members/home'; ?>" >  <button type="button" id="back" class="backtohome"><?php echo $this->translate("Back") ?></button></a></div>

</div>

</div>
</div>


</div>


<script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAOdWM32gJ4t6-csxQQxCVDigYfq261xi0&libraries&callback=initMap">
    </script>
<script>
	
	var latitude = <?php echo $this->propertyRequirementData->latitude;?>;
	var longitude = <?php echo $this->propertyRequirementData->longitude;?>;
	var title = '<?php echo $this->propertyRequirementData->prty_city;?>';

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
