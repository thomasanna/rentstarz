<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: _browseUsers.tpl 9979 2013-03-19 22:07:33Z john $
 * @author     John
 */
?>
<?php
	$viewHelperObj      =   $this->getHelper('ItemPhoto');
?>
<link rel="stylesheet" href="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/styles/online.css" type="text/css">
<script >
	jQuery( function() {
  var $winHeight = jQuery( window ).height()
  jQuery( '.container' ).height( $winHeight );
    });
</script>
 <?php 
   $online_users=$this->online_users;

   $status 	= 	'false';
   $online_user_id = array();
   foreach($online_users as $row):

   $online_user_id[]=$row['user_id'];
   endforeach;
   
   $viewer     = Engine_Api::_()->user()->getViewer();
   
    $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer); 
    	
    	if( !empty($fieldsByAlias['profile_type']) ){
			
			  $optionId = $fieldsByAlias['profile_type']->getValue($viewer);
			  $profile_type_id = $optionId->value; 
			  
		}
 
?>
<div class='browsemembers_results' id='browsemembers_results'>
<h3>
  <?php echo 'RENTERS  : ' .  $this->translate(array('%s member found', '%s members found', $this->totalUsers),$this->locale()->toNumber($this->totalUsers)) ?>
</h3>



<div class="results-pane">
	
<?php $viewer = Engine_Api::_()->user()->getViewer();?>

<?php if( count($this->users) ): ?>
	
<?php $likeuserTable =  Engine_Api::_()->getDbtable('likeuser', 'user'); 

$smartmoveapiRenters_table =  Engine_Api::_()->getDbtable('Smartmoveapirenters', 'user');   ?>	


<ul>
	
	<?php foreach( $this->users as $user ): ?>
	<?php //echo $user['user_id']; exit;?>
<li class="results_pane_li">
	
	<div class="scrolling-row-inner">
		
		<?php if(in_array($user['user_id'],$online_user_id)): ?>
	   <!-- <div class="led-green" style="top: 111px; margin-left: 87px;"></div>-->
	    <div class="led-green" style="top: 60px;margin-left: 54px;position: absolute;float: left;z-index: 9;"></div>
	    
		<?php endif; ?>
		
		<div class="profile_image"> <?php echo $this->htmlLink($user->getHref(), $this->itemPhoto($user, '', array('class' => 'photo')),array('title'=>$user->getTitle())) ?> 
		
		 

            <?php if($viewer->getIdentity()!=$user['user_id']): ?>

            <?php
                $profileNoPicInfo   =   $viewHelperObj->getNoPhoto($user);
                $type               =   'thumb.icon';
                $safeName           =   ( $type ? str_replace('.', '_', $type) : 'main' );
                $src                =   $user->getPhotoUrl($type);
                if($src):
                $src                =   $src;
                else:
                $src                =   $viewHelperObj->getNoPhoto($user,$safeName);
                endif;
            ?>

             <span onClick="popUpChatClick('<?php echo $user['user_id'] ?>','<?php echo $user['displayname'] ?>','<?php echo $src ?>','<?php echo $status ?>')">
                 <h3 class="single_popupchat_click" id="user_id^<?php echo $user['user_id'].'^'. $user['displayname']?>">Message</h3>
              </span>
			<?php endif; ?>
		
		
		
    
   <?php $likeuserDataSelect = $likeuserTable->select()
					->where('subject_id = ?', $viewer -> getIdentity())
					->where('object_id = ?',   $user['user_id']);
					
					
    $likeuserData = $likeuserTable->fetchRow($likeuserDataSelect);
		
		
		
	?>	
	
	
	

		</div>
		
		<div class="scrolling-row-intro player-info">
			
			
		<?php	$smartmoveapiRenters = $smartmoveapiRenters_table->fetchRow($smartmoveapiRenters_table->select()->where('tenant_id = ?', $user['user_id']));   	  

		if(!empty($smartmoveapiRenters)){
				
				$isSmartmoveRenter = 1;
		}
		else{
				
				$isSmartmoveRenter = 0;
		}
			
		?>
			
			
			
		<?php  if($user['bg_verified'] == 1 && $isSmartmoveRenter == 0):?>
						  <span style="color: #00ff00; font-weight: bold;">Verified</span>
						<?php endif;?>
						
						<?php  if($user['bg_verified'] == 0 && $isSmartmoveRenter == 1):?>
						  <span style="color: #00ff00; font-weight: bold;">Verified</span>
						<?php endif;?>
						
						<?php  if($user['bg_verified'] == 0 && $isSmartmoveRenter == 0):?>
						  <span class="feed_notverified_span">Not Verified</span>
						<?php endif;?>
						
						<?php  if($user['bg_verified'] == 1 && $isSmartmoveRenter == 1):?>
						  <span style="color: #00ff00; font-weight: bold;">Verified</span>
						<?php endif;?>	
			

			
			<h2 class="vcard">
			<span class="hover-card-parent">
				
				<span class="url">

					<?php  $attribs = Array('title'=>'View Profile'); ?>
					 <?php echo $this->htmlLink($user->getHref(), ucwords($user->getTitle()),$attribs) ?>
					
				</span>
			
			</span>
						
		<span class="meta locality">
           <?php echo "USA" . " , "; if($user['state'] !=''):?><?php echo $user['state']?>, <?php endif;?><?php echo $user['city']?>
        </span>
		
	
        </h2>
       <?php 

        if($user['creditscore_view_status'] == 1):
		   
		$userTable = Engine_Api::_()->getDbtable('users', 'user');

       
        $creditscoreSelect   =   $userTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('user'=>'engine4_users',))                  
                        ->joinLeft(array('fields_value'=>'engine4_user_fields_values'),'fields_value.item_id=user.user_id',array('value'))                                             
                        ->where('fields_value.field_id=?' , 16) 
                        ->where('user.user_id=?' , $user['user_id']); 

        $creditscoreData = $userTable->fetchRow($creditscoreSelect);

		?> 
		<?php if($creditscoreData->value !=''):?>
        <b>Credit Score   : </b> <?php echo $creditscoreData->value;?>
        <?php endif;?>
        <?php endif; ?>
		
		
	<?php /*	<div class='browsemembers_results_links'>
			        <?php 
        $table = Engine_Api::_()->getDbtable('block', 'user');
        $select = $table->select()
          ->where('user_id = ?', $user->getIdentity())
          ->where('blocked_user_id = ?', $viewer->getIdentity())
          ->limit(1);
        $row = $table->fetchRow($select);
        ?>
        <?php if( $row == NULL ): ?>
          <?php if( $this->viewer()->getIdentity() ): ?>
          
            <?php echo $this->userFriendship($user) ?>
         
        <?php endif; ?>
        <?php endif; ?>
			
		</div> */?>
		</div>
		
		<?php 
		
    $propertyRequirementTable =  Engine_Api::_()->getDbtable('propertyrequirement', 'user');  
    $voucherselect = $propertyRequirementTable->select()	
                    ->setIntegrityCheck(false)
                    ->from(array('property_req'=>'engine4_property_requirement','tenant_id'))					
                    ->where('vouchers = ?', 'Yes')
                     ;
	$voucherData = $propertyRequirementTable->fetchAll($voucherselect);
    foreach($voucherData as $row):
    if( $row['tenant_id']==$user['user_id']):
    ?>
      <div class="voucher" style="float:right;"><img src="/application/modules/User/externals/images/vochericon.jpg" width="30px" height="30px"></div>
	<?php	
		break;
    endif;
    endforeach;
    
		?>
		
		<div class="bio_div">
		<?php if ($user['value']!=""): ?>
			
			<div class="tenant_bio_container">

				<?php echo substr($user['value'],0,300) . '...';?>  
			</div>	
	 <?php endif;?>	
	 </div>
	 </br>


			
	</div>
	
	<div class="feed_icons">
	
	<div class="feed_rating">
					
				<?php if($user['rating_value'] != '' && $user['rating_value'] !=0): ?>
				
                <?php if($user['enable_rating_value'] == 1):?>
    
				  <div style="float: left;" class="basic" data-average="<?php echo $user['rating_value'];?>" data-id="1" title="<?php echo $user['rating_value'];?>"></div> 
					<?php endif;?>
					
				<?php else:?>
				
				<div style="color: #f58410;font-weight: bold;float: left;">Not Rated</div>	
				<?php
	
   $propertyRequirementTable =  Engine_Api::_()->getDbtable('propertyrequirement', 'user');
	
   $propertyRequirementVillaselect = $propertyRequirementTable->select()		
                    ->setIntegrityCheck(false)
                    ->from(array('property_req'=>'engine4_property_requirement',))				
					->where('tenant_id = ?', $user['user_id'])
					->where('housing_type = ?', 'Room')
					->joinLeft(array('state'=>'engine4_property_states',),'state.state_id=property_req.state_id',array('prty_state'))                                  
                    ->joinLeft(array('city'=>'engine4_property_city',),'city.city_id=property_req.city_id',array('prty_city'))  
					; 
   $propertyRequirementVillaData = $propertyRequirementTable->fetchAll($propertyRequirementVillaselect);
  

	
  $propertyRequirementApartmentselect = $propertyRequirementTable->select()		
                    ->setIntegrityCheck(false)
                    ->from(array('property_req'=>'engine4_property_requirement',))				
					->where('tenant_id = ?', $user['user_id'])
					->where('housing_type = ?', 'Apartment')
					->where('no_of_rooms!=?','0')
					->joinLeft(array('state'=>'engine4_property_states',),'state.state_id=property_req.state_id',array('prty_state'))                                  
                    ->joinLeft(array('city'=>'engine4_property_city',),'city.city_id=property_req.city_id',array('prty_city'))  
					; 
   $propertyRequirementApartmentData = $propertyRequirementTable->fetchAll($propertyRequirementApartmentselect);

     
     
  $propertyRequirementHouseselect = $propertyRequirementTable->select()		
                    ->setIntegrityCheck(false)
                    ->from(array('property_req'=>'engine4_property_requirement',))				
					->where('tenant_id = ?', $user['user_id'])
					->where('housing_type = ?', 'House')
					->joinLeft(array('state'=>'engine4_property_states',),'state.state_id=property_req.state_id',array('prty_state'))                                  
                    ->joinLeft(array('city'=>'engine4_property_city',),'city.city_id=property_req.city_id',array('prty_city'))  
					;
   $propertyRequirementHouseData = $propertyRequirementTable->fetchAll($propertyRequirementHouseselect);
    
   $roomappartmenthouselocationselect = $propertyRequirementTable->select()	
                    ->setIntegrityCheck(false)
                    ->from(array('property_req'=>'engine4_property_requirement',))					
                   ->joinLeft(array('state'=>'engine4_property_states',),'state.state_id=property_req.state_id',array('prty_state'))                                  
                    ->joinLeft(array('city'=>'engine4_property_city',),'city.city_id=property_req.city_id',array('prty_city'))  
					->where('property_req.tenant_id = ?', $user['user_id'])
                    ->where('(property_req.housing_type = ?', 'House' )
					->orWhere('property_req.housing_type = ?', 'Apartment')
					->orWhere('property_req.housing_type = ?)', 'Room')
					->group(array('city.city_id'))
					;
$roomappartmenthouselocationData = $propertyRequirementTable->fetchAll($roomappartmenthouselocationselect);
?> 

 
<?php if(count($propertyRequirementHouseData)>0 || count($propertyRequirementApartmentData)>0 || count($propertyRequirementVillaData)>0): ?>
			<div class="iconimage" id="<?php echo $user->user_id; ?>" style="float:left;margin-left:49px;"><img src="/application/modules/User/externals/images/appartment.svg" width="31px" title="<?php if(count($propertyRequirementVillaData)>0):echo count($propertyRequirementVillaData)." Room \n";endif; 
			if(count($propertyRequirementHouseData)>0):echo count($propertyRequirementHouseData)." House \n";endif;
			if(count($propertyRequirementApartmentData)>0):echo count($propertyRequirementApartmentData)." Apartment \n";endif;
			?>" class="room" data-toggle="modal" data-target="#roomModal_<?php echo $user->user_id; ?>">
			</div>
<?php endif; ?>			
			<?php if(count($propertyRequirementHouseData)>0 || count($propertyRequirementApartmentData)>0): ?>
<div class="iconimage" id="<?php echo $user->user_id; ?>"  style="float:left;margin-left:42px;"><img src="/application/modules/User/externals/images/room.svg" width="38px" class="room" data-toggle="modal" title="<?php 	
				 	//if($result['apartmentcount'] >0):echo "Appartment-".$result['Apartmenttotalbhk'][0]."bedroom"; if($result['apartmentcount']>1) :echo "... \n";endif;if($result['apartmentcount']==1):echo "\r\n";endif;  endif;
				 			foreach ($propertyRequirementApartmentData as $row)
	{
		echo 'Apartment-'.$row['no_of_rooms'].'&nbsp;Bedroom'.'...'."\r";
		break;
    }
    		foreach ($propertyRequirementHouseData as $row)
	{
		echo 'House-'.$row['no_of_rooms'].'&nbsp;Bedroom'.'...';
		break;
    }
					//if($result['housecount'] >0): echo "House-".$result['housetotalbhk'][0]."Bedroom" ; if($result['housecount']>1) : echo "... \n";endif;endif;?>" data-target="#roomModal_<?php echo $user->user_id; ?>">
</div>
<?php //endif; ?>	

<?php //if(count($propertyRequirementHouseData)>0 || count($propertyRequirementApartmentData)>0 || count($propertyRequirementVillaData)>0): ?>
		 
			<div style="float:left;margin-left:42px;margin-top: 5px;" class="roomappartmenthouselocation roomappartmenthouselocation_<?php echo $user->user_id; ?> " user_id="<?php echo $user->user_id; ?>"><img src="/application/modules/User/externals/images/LOCATION.png" 
			 title="<?php  foreach ($roomappartmenthouselocationData as $row)
	        {
	        	echo $row['prty_state'].','.$row['prty_city']."\r\n"; 
            } ; ?>" 
			width="12px" height="18px"><span class="roomapphouseloc_<?php echo $user->user_id; ?>" style="display:none;margin-top: 8px;" ><?php print_r($result['roomappartmenthouselocation']); ?></span></div>  
                    
     <?php endif;?>

				<?php endif;?>
	</div>	
		
	<?php if($profile_type_id == 4):?>	
	<?php if(count($likeuserData) == 0):?>
             
            <?php /*<div class="like_user like_user_<?php echo $user['user_id'];?>" user_id ="<?php echo $user['user_id'];?>" title="Save"><i class="fa fa-heart" aria-hidden="true"></i></div> */ ?>
            <div class="save_btn_div save_btn_div_<?php echo $user['user_id'];?>"><button class="like_user like_user_<?php echo $user['user_id'];?>" user_id ="<?php echo $user['user_id'];?>" title="Save">Save</button></div>

            <?php else: ?>
            
             <?php /*<div class="unlike_user like_user_<?php echo $user['user_id'];?>" user_id ="<?php echo $user['user_id'];?>" title="Unsave"><i class="fa fa-heart" aria-hidden="true" style="color: #f58410;"></i></div> */ ?>
             <div class="save_btn_div save_btn_div_<?php echo $user['user_id'];?>"><button class="unlike_user like_user_<?php echo $user['user_id'];?>" user_id ="<?php echo $user['user_id'];?>" title="Unsave">Save</button></div>

    <?php endif;?>	
    <?php endif;?>	
		
		
		
	</div>	
	
				
				
				
	
</li>	


<?php endforeach; ?>
	
</ul>	

<?php endif; ?>	
	
</div>

<?php if( $this->users ):
    $pagination = $this->paginationControl($this->users, null, null, array(
      'pageAsQuery' => true,
      'query' => $this->formValues,
    ));
  ?>
  <?php if( trim($pagination) ): ?>
    <div class='browsemembers_viewmore' id="browsemembers_viewmore">
      <?php echo $pagination ?>
    </div>
  <?php endif ?>
<?php endif; ?>
</div>


<script type="text/javascript">
/* jQuery( ".iconimage" ).click(function() { 
	 
    var oData           = new Object();  
	var tenantId        = parseInt(jQuery(this).attr('id'));
    var tenantid        = oData.tenantid =tenantId; 
	    
	var formURL         = '<?php echo $this->baseUrl(); ?>' + '/user/index/roomdetails';

	jQuery.ajax({
						url : formURL,
						type: "POST",
						dataType: 'json',
						data : oData,
						success: function (data) { 
						//	console.log(data.html);
								
								  jQuery("#roomModal .modal-body").html(data.html);
						          jQuery("#roomModal").modal('show');


							},
							error: function(e){  
						   
						}
    });	
	 
	 
});*/
</script>
<script type="text/javascript">
	jQuery('.basic').jRating(); 
	
  page = '<?php echo sprintf('%d', $this->page) ?>';
  totalUsers = '<?php echo sprintf('%d', $this->totalUsers) ?>';
  userCount = '<?php echo sprintf('%d', $this->userCount) ?>';
  
  
  	jQuery('body').on('click', '.like_user', function(event){
		
		var user_id =parseInt(jQuery(this).attr('user_id'));
		
		if(!jQuery('.like_user_'+user_id).hasClass('clicked')){
			
		jQuery('.like_user_'+user_id).addClass('clicked');
		
		var oData       = new Object();
		
		oData.user_id = user_id;
		
		var url = '<?php echo $this->baseUrl().'/user/index/likeuser' ?>';
		
		jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					    success: function (data) { console.log(data);
						
						if(data.status == true){
							
							jQuery('.save_btn_div_'+user_id).html('');
							//jQuery('.like_user_'+user_id).html('<i class="fa fa-heart" aria-hidden="true" style="color: #f58410;"></i>');							
							jQuery('.save_btn_div_'+user_id).html('<button class="unlike_user like_user_'+user_id+'" user_id ="'+user_id+'" title="Unsave">Save</button>');							

							jQuery('.like_user_'+user_id).addClass('unlike_user');
							jQuery('.like_user_'+user_id).removeClass('like_user');
							jQuery('.like_user_'+user_id).attr('title','Unsave');
							
							
						var url = '<?php echo $this->baseUrl().'/user/index/getlikedusers' ?>';		
						jQuery.ajax({
							url:  url,
							data: oData,						
							dataType: 'json',
							type: 'POST',
							success: function (result) { 
							
								jQuery('#likeUserModal .modal-body').html(result.html);

								},
						   error: function(e){ }  
						}); 
						
						}

					 },
					   error: function(e){ }  
					}); 
					
		}
		else{
			
			jQuery('.like_user_'+user_id).removeClass('clicked');
			
		}
		
	});	
	
	jQuery('body').on('click', '.unlike_user', function(event){
		var user_id =parseInt(jQuery(this).attr('user_id'));
		
		var oData       = new Object();
		
		oData.user_id = user_id;
		
		var url = '<?php echo $this->baseUrl().'/user/index/unlikeuser' ?>';
		
		jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					    success: function (data) { console.log(data);
						
						if(data.status == true){
							
							jQuery('.save_btn_div_'+user_id).html('');
							//jQuery('.like_user_'+user_id).html('<i class="fa fa-heart" aria-hidden="true" ></i>');	
							jQuery('.save_btn_div_'+user_id).html('<button class="like_user like_user_'+user_id+'" user_id ="'+user_id+'" title="Save">Save</button>');							
						
							jQuery('.like_user_'+user_id).addClass('like_user');
							jQuery('.like_user_'+user_id).removeClass('unlike_user');
							jQuery('.like_user_'+user_id).attr('title','Save');
							
						var url = '<?php echo $this->baseUrl().'/user/index/getlikedusers' ?>';		
						jQuery.ajax({
							url:  url,
							data: oData,						
							dataType: 'json',
							type: 'POST',
							success: function (result) { console.log(result.html);
							
								jQuery('#likeUserModal .modal-body').html(result.html);

								},
						   error: function(e){ }  
						}); 
	
						}

					 },
					   error: function(e){ }  
					}); 
	});
</script>
