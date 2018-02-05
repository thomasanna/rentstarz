<link rel="stylesheet" href="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/styles/online.css" type="text/css">
<script src="/application/modules/User/externals/scripts/message_notififaction.js"></script>
<script>
<?php $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); ?>

var viewer_identity='<?php echo $viwer_id; ?>';	
</script>
<script >
	$( function() {
  var $winHeight = $( window ).height()
  $( '.container' ).height( $winHeight );
    });
</script>
 <?php 
   $online_users=$this->online_users;

   $online_user_id = array();
   foreach($online_users as $row):

   $online_user_id[]=$row['user_id'];
   endforeach;
 
?>
<?php $viewer     = Engine_Api::_()->user()->getViewer();
 $viewerId=Engine_Api::_()->user()->getViewer()->getIdentity(); 
 $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); ?>

<div class="generic_layout_container layout_main">
<div class="generic_layout_container layout_left">


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
    <span class="qwerty">Allowed pets</span> <span class="sep">: </span> <span class="xyz"> <?php echo $this->propertyData->pets_type;?> </span> 
   <li>
	<?php endif;?>  
   <li>
    <span class="qwerty">Rental prices (monthly)</span> <span class="sep">: </span> <span class="xyz"> <?php echo $this->propertyData->price;?> </span> 
   <li>

</ul>

</div>
</div>

<h3>
	
<?php $type = $this->propertyData->rental_type;

	

?>
	
	
<ul class="navigation">
<?php if($viewerId == $this->landlordUser->user_id):?>	
<li><a href="<?php echo $this->baseUrl().'/myproperties'?>">My Properties</a></li>
<li><a href="<?php echo $this->baseUrl().'/propertyrequestslist'?>">Rental Applications</a></li>
<li class="active"><a href="<?php echo $this->baseUrl().'/property/approved'?>">Accepted Applications</a></li>
<?php endif;?> 
  </ul>
</h3>


<div class="generic_layout_container layout_middle">
<div class="generic_layout_container layout_user_profile_status">
<div id="profile_status" class="title_color">
  <h2 style="float: left;">
     <a href="<?php echo $this->baseUrl().'/property/'.$this->propertyData->id ?>" target="_blank"><?php echo $this->propertyData->property_name;?></a>	<br>
  </h2>
  <div class="complete_btn_div" style="text-align: right;">
  <?php if($this->is_granted == 1):?>

  <button class="complete_btn">Complete <?php echo $type;?></button>
  <?php endif;?>
  
  </div>
</div>
</div>

<div class="property_list_content">
	
<div class ="err_msg" style="color:red;"></div>

<?php if($this->is_granted == 0):?>
<div class="tenant_list_title">Select a renter to grant the property for <?php echo $this->propertyData->rental_type;?></div>
<ul class="tenant_list_ul">
<?php foreach($this->propertyRequestApproved as $data):?>

 <?php if(in_array( $data['tenant_id'],$online_user_id)): ?>
	    <div class="led-green" style="top: 60px; margin-left: 68px;"></div>
		<?php endif; ?>
<?php $userTable = Engine_Api::_()->getDbtable('users', 'user');  
     $tenantData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $data['tenant_id']));

?>
<li class="li_<?php echo $data['tenant_id']?> select_tenent_li" style="margin-top: 12px;"><span title="View Profile" style="margin-right: 13px;"><label><input type="radio" name="user" value="<?php echo $data['tenant_id']?>" data-displayname = "<?php echo $data['displayname'];?>">&nbsp;&nbsp;&nbsp;<?php echo $this->htmlLink($tenantData->getHref(), $this->itemPhoto($tenantData, 'thumb.icon',array('class' => 'photo'))); ?> &nbsp;&nbsp;<?php echo $data['displayname'];?></label></span></li>
<?php endforeach;?>
</ul>

<div class="grant_btn_div"><button class="grant_btn">Grant for <?php echo $this->propertyData->rental_type;?></button></div>

<?php else:?>
<ul>

	<?php $userTable = Engine_Api::_()->getDbtable('users', 'user');  
     $tenantData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $this->propertygrantedTenant->user_id));?>
     	 <?php if(in_array( $this->propertygrantedTenant->user_id,$online_user_id)): ?>
	    <div class="led-green" style="top: 60px; margin-left: 71px;"></div>
		<?php endif; ?>
<li style="margin-top: 12px;"><span style="margin-right: 13px;"><input type="radio" name="user" value="<?php echo $data['tenant_id']?>" checked></span>   <span title="View Profile" ><a href="<?php echo $this->baseUrl().'/profile/'.$this->propertygrantedTenant->displayname ?>"><?php echo $this->htmlLink($tenantData->getHref(), $this->itemPhoto($tenantData, 'thumb.icon',array('class' => 'photo'))); ?> &nbsp;&nbsp;<?php echo $this->propertygrantedTenant->displayname;?></span></a></li>
</ul>

<!--<div class="grant_btn_div"><button class="granted_btn"><?php echo $type;?> has been granted</button></div>-->

<div class ="property_granted_msg">
<?php if($type == "Rent"): ?>
<img src="/application/modules/User/externals/images/Group-8.png" >
<?php else:
?>
<img src="/application/modules/User/externals/images/tag.png">
<?php endif; ?>
</div>

<?php endif;?>
<div class="loader" style="display:none;"></div>
</div>




</div>

</div>

<!-- popup ------>
<div id="light" class="white_content">
<div class="pop_up_title"><div class="div_attachment_title">Confirm</div><div class="div_attachment_cancel"><img src="/application/modules/User/externals/images/GREYcancel.png"></div></div>
<div class="popup_content">	
	
<div class="confirm_text"></div>
<div class="confirm_btns" style="text-align: left;"><span class="confirm_btns"><button class="yes_grant_btn" style="width: 134px;">Grant</button></span> 

</div>
</div>
</div>
</div>
<div id="fade" class="black_overlay"></div>

<div id="light2" class="white_content">
	
<div class="pop_up_title"><div class="div_attachment_title">Confirm</div><div class="div_attachment_cancel"><img src="/application/modules/User/externals/images/GREYcancel.png"></div></div>
<div class="popup_content">
<?php if($this->is_granted == 1):?>		
<div class="confirm_text">Are you sure you want to complete  property <?php echo $type;?> of  <?php echo $this->propertygrantedTenant->displayname;?> ?</div>
<?php endif;?>
<div class="confirm_btns" style="text-align: left;">
<span class="confirm_btns"><button class="yes_btn yes_complete" style="width: 134px;">Yes</button></span> 
</div>
</div>
</div>
</div>
<div id="fade" class="black_overlay"></div>

<script>
	
	
jQuery('body').on('click', '.grant_btn', function(event){
	
	jQuery('#fade').css('display','block');
	jQuery('#light').css('display','block');
	var label =jQuery("input[name=user]:checked").attr("data-displayname");
	var propertyname = "<?php echo $this->propertyData->property_name;?>";
	if(label == undefined){
		
	jQuery('#fade').css('display','none');
	jQuery('#light').css('display','none');
	
		jQuery('.err_msg').text('Please select renter to grant property');
						 setTimeout(function () {
							 jQuery('.err_msg').text('');							 
						 }, 2500); 
			
	}
	else{
		
		jQuery( ".confirm_text" ).text(label+', requested '+propertyname);
		
	}	



});	

jQuery('body').on('click', '.div_attachment_cancel', function(event){
	
	jQuery('#fade').css('display','none');
	jQuery('#light').css('display','none');
	jQuery('#light2').css('display','none');
})
	

jQuery('body').on('click', '.yes_grant_btn', function(event){
	
	jQuery('#fade').css('display','none');
	jQuery('#light').css('display','none');

	var selected_tenant = jQuery('input[name=user]:checked').val(); 
	var propertyid = '<?php echo $this->propertyData->id; ?>';
	var type       = '<?php echo $this->propertyData->rental_type;?>';

	var unselected_tenants = '';
	jQuery('input[name=user]').not(':checked').each(function() {
	unselected_tenants =	 jQuery(this).val()+','+unselected_tenants;
    
    });

	if(selected_tenant != undefined){
		
	jQuery(".loader").css("display", "block");
	jQuery(".grant_btn").css("display", "none");
	var oData       = new Object();
    oData.selected_tenant          = selected_tenant;
    oData.unselected_tenants       = unselected_tenants;
    oData.propertyid               = propertyid;
    
    
    var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/propertyrequestapprovedgrant';
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {
						 
						 if(data.status == true){
							 
							 jQuery(".loader").css("display", "none");	
							 jQuery( ".li_"+selected_tenant ).removeClass('select_tenent_li');						 
							 jQuery( ".select_tenent_li" ).css('display','none');						 
							 jQuery( ".tenant_list_title" ).css('display','none');						 
							 jQuery( ".grant_btn_div" ).html('<button class="granted_btn">'+type+' has been granted</button>');                     
							 //jQuery( ".complete_btn_div" ).html('<button class="complete_btn">Complete '+type+'</button>');  
							 location.reload();                   
							 
							 }       
					 },
					   error: function(e){ 
						   jQuery(".grant_btn").css("display", "block");
						    }  
					}); 

    }
    else{
		jQuery(".grant_btn").css("display", "block");
	    jQuery(".loader").css("display", "none");	
		jQuery('.err_msg').text('Please select tenant to grand property');
						 setTimeout(function () {
							 jQuery('.err_msg').text('');							 
						 }, 2500); 
		
	}
	
});


jQuery('body').on('click', '.complete_btn', function(event){
	
	jQuery('#fade').css('display','block');
	jQuery('#light2').css('display','block');
	
	
});

jQuery('body').on('click', '.yes_complete', function(event){
	
    var property_id = '<?php echo $this->propertyData->id;?>'; 
    var oData       = new Object();
    oData.property_id       = property_id;
    
    var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/completegrantedproperty';
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {
						 
						if(data.status == true){
							document.getElementById('light2').style.display='none';
	                        document.getElementById('fade').style.display='none';
							 
							//jQuery('.complete_btn_div').html('<button class="rent_peroid_over">rental period is over</button>');
							jQuery('.complete_btn_div').html('');
							location.href = '<?php echo $this->baseUrl()?>' +'/property/'+property_id;
							
							 
 
						}
         
					 },
					   error: function(e){  alert('Error: '+e);  }  
					}); 
    
	
	
});

</script>

