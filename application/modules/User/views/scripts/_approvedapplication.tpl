<?php 

        $viewer     = Engine_Api::_()->user()->getViewer();
        $viewer_id            =  Engine_Api::_()->user()->getViewer()->getIdentity();
if(count($this->propertyRequestApproved) > 0 ): 
foreach($this->propertyRequestApproved as $key => $value) :?>
 <?php
	    $propertyTable =  Engine_Api::_()->getDbtable('propertylist', 'user');		
		$propertyData =  $propertyTable->fetchRow($propertyTable->select()->where('id = ?', $value['property_id']));		
		$type     = $propertyData->rental_type;
		?>
	
<div class="title_color" >
	<div class="col-md-6 col-sm-6 col-xs-12" style="padding: 3px;"> 
	 <a href="<?php echo $this->baseUrl().'/property/'.$value['property_id'] ?>"><?php echo $property_name = $value['property_name'];?></a>
	 </div>
	<div  class="col-md-3 col-sm-3 col-xs-12" style="float: right;text-align: right;padding: 3px;" >
		<?php 
		$propertyGrantedTable =  Engine_Api::_()->getDbtable('propertygranted', 'user');
		$propertyGranted_select = $propertyGrantedTable->select()
                        ->where('property_id = ?', $value['property_id'])
                        ->where('status = ?', 1);
        $propertyGrantedTableData = $propertyGrantedTable->fetchRow($propertyGranted_select);
        if(count($propertyGrantedTableData)>0){

            $granted = 1; 
            $property_granted_tenent_id = $propertyGrantedTableData->tenant_id;          
           $userTable = Engine_Api::_()->getDbtable('users', 'user');
           $property_granted_tenent = $userTable->fetchRow($userTable->select()->where('user_id = ?', $property_granted_tenent_id));
           $renter_name=  $property_granted_tenent['displayname'];
      }
        else{
        $granted  = 0;
	}
		?>
	<?php if( $granted == 1): ?>
	<button class="complete_btn"  property_id="<?php echo $value['property_id']; ?>" type="<?php echo $type;?>" renter_name="<?php echo $renter_name;?>">Complete <?php echo $type;?></button>
	<?php  endif; ?>
	</div>
</div>
	<?php $userTable = Engine_Api::_()->getDbtable('users', 'user');?>
<?php for($i=0;$i<count($value);$i++){?>
	
	    <?php
   	    if(in_array( $value[$i]['user_id'],$online_user_id)): ?>
	    <div class="led-green" style="top: 46px; margin-left: 36px;"></div>
		<?php endif; ?>
		
<?php if($value[$i]['user_id'] !=''): ?>
<?php $userTable = Engine_Api::_()->getDbtable('users', 'user');  
     $tenantData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $value[$i]['user_id']));

      ?>
<div style="clear:both" class="user_<?php echo $value[$i]['user_id'] ?>_<?php echo $value['property_name'] ?>">
	<?php echo $this->htmlLink($tenantData->getHref(), $this->itemPhoto($tenantData, 'thumb.icon', array('class' => 'photo'))); ?> 
    
   <div class="property_rqst_approved_users_li">	
	<div class="col-md-3 col-sm-3 col-xs-12"><a href="<?php echo $this->baseUrl().'/profile/'.$value[$i]['user_id'] ?>"><?php echo $value[$i]['display_name'];?></a></div>
	<div class="col-md-3 col-sm-3 col-xs-12" >
	
	<?php

		$Reportrequest_table =  Engine_Api::_()->getDbtable('Reportrequest', 'user');  		
        $ReportrequestDataSelect = $Reportrequest_table->select()
									->where('landlord_id = ?', $viewer_id)
									->where('renter_id = ?',   $value[$i]['user_id']);  
	  
	   $ReportrequestData = $Reportrequest_table->fetchRow($ReportrequestDataSelect);	   
	   $is_request= ''; 	   
	   if(count($ReportrequestData) == 0){ $is_request= '';}
	   else{
		   if($ReportrequestData -> status == 'Closed')   { $is_request= '';         }
		   if($ReportrequestData -> status == 'Requested'){ $is_request= 'requested';}
		   if($ReportrequestData -> status == 'Shared')   { $is_request= 'shared';   }
        }
		
		?>
	
	<div class="property_request_btns ">
		
		<?php if($is_request== 'shared'):?>		
				<a href="<?php echo $this->baseUrl().'/report/'.$value[$i]['user_id']?>" class="view_report">View Reort</a> 
		<?php endif;?>
		<?php if($is_request== 'requested'):?>		
				<a href="javascript:void(0)" class="view_report">Waiting for the report</a> 
		<?php endif;?>
		<?php  if($is_request== ''):?>		
		<a href="javascript:void(0)" class="request_report request_report_<?php echo $value[$i]['request_id'];?>" data-requestId="<?php echo $value[$i]['request_id'];?>" data-prtyId="<?php echo $value['property_id'];?>" data-prtyName="<?php echo $value['property_name']?>" data-renterId = <?php echo $value[$i]['user_id'];?>>Request report</a>		
		<?php endif;?>
	</div>
	</div>
		<?php /*<div class="col-md-3 col-sm-3 col-xs-12 view_details schedule_viewing"  > 
			<a href="<?php echo $this->baseUrl().'/scheduler' ?>">SCHEDULE A VIEWING</a>
			
		</div>*/?>
<div class="col-md-3 col-sm-3 col-xs-12" >
	
<?php if( $granted == 0): ?>
<span style="float:left;" class="grant_btn">RENT IT<label><input type="radio" class="radio_btn" property="property_<?php echo $value['property_id'] ?>" name="user" value="<?php echo $value[$i]['user_id'] ?>" data-displayname = "<?php echo $value[$i]['display_name'];?>" property-name="<?php echo $value['property_name'] ?>" property-id="<?php echo $value['property_id'] ?>"  ></label></span>
<?php endif; ?>
<?php 	
    	$propertyGrantedTable =  Engine_Api::_()->getDbtable('propertygranted', 'user');   	 	
    	$propertyGranted_select = $propertyGrantedTable->select()
						->where('property_id = ?', $value['property_id'])
						->where('granted = ?', 1)
						->where('tenant_id = ?', $value[$i]['user_id'] )
						->where('status = ?', 1); 
		$oData = $propertyGrantedTable->fetchRow($propertyGranted_select);
    	if(count($oData)>0):
		   $property_granted_tenent_id = $oData->tenant_id;			
		   $userTable = Engine_Api::_()->getDbtable('users', 'user');
		   $property_granted_tenent = $userTable->fetchRow($userTable->select()->where('user_id = ?', $value[$i]['user_id'] ));
?> 

<div class ="property_granted_msg">
<?php  if($property_granted_tenent_id==  $value[$i]['user_id']): ?>
<?php  if($type == "Rent" ): ?>
<img src="/application/modules/User/externals/images/Group-8.png" >
<?php else:
?>
<img src="/application/modules/User/externals/images/tag.png">
<?php endif; ?>
<?php endif;  ?>
</div>

<?php endif; ?>
</div>	
   </div>
</div>
<?php  
endif;
 } ?>

<hr>
<?php endforeach; ?>
<?php endif;?>
