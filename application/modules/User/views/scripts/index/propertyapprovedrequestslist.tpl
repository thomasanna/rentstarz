<link rel="stylesheet" href="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/styles/online.css" type="text/css">
<script src="/application/modules/User/externals/scripts/message_notififaction.js"></script>
<script>
<?php $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); ?>

var viewer_identity='<?php echo $viwer_id; ?>';	
</script>
 <?php 
   $online_users=$this->online_users;
   $online_user_id = array();
   foreach($online_users as $row):
   $online_user_id[]=$row['user_id'];
   endforeach; 
?>

<?php $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); 
$viewer     = Engine_Api::_()->user()->getViewer(); ?>
<div style="padding: 12px 0px 12px 5px;">
<select style="margin-bottom: 12px;width: 250px;height: 37px;" id="search_approvedproperty">
<option value="0">Search</option>
<?php foreach($this->propertyRequestApproved as $data):?>
<option value="<?php echo $data['property_id']; ?>"><?php echo $data['property_name'];?></option>
<?php endforeach; ?>
</select>
</div>
<div class="property_list_content generic_layout_container layout_middle">

<div>
	
<div id="browsemembers_ul">

<?php 
if(count($this->propertyRequestApproved) > 0 ): 
foreach($this->propertyRequestApproved as $key => $value) :?>
 <?php
	    $propertyTable =  Engine_Api::_()->getDbtable('propertylist', 'user');		
	    $ReportshareTable           = Engine_Api::_()->getDbtable('Reportshare', 'user');
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
									->where('landlord_id = ?', $viwer_id)
									->where('renter_id = ?',   $value[$i]['user_id']);  
			  
	   $ReportrequestData = $Reportrequest_table->fetchRow($ReportrequestDataSelect);	   
	   $is_request= ''; 	   
	   if(count($ReportrequestData) == 0){	   
		   
		   $is_request= '';
		   $ReportshareData            = $ReportshareTable->fetchRow($ReportshareTable->select()->where('report_shared_with    = ?', $viwer_id)
                                                                                       ->where('report_shared_by     = ?', $value[$i]['user_id'])
                                                                                       ->where('status  = ?', 'Active'));

		   if(count($ReportshareData)>0){
			  $is_request= 'shared';  
		   }
		   
		   }
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
			<a href="<?php echo $this->baseUrl().'/scheduler' ?>">Schedule a viewing</a>
			
		</div> */?>
<div class="col-md-3 col-sm-3 col-xs-12" >
	
<?php if( $granted == 0): ?>
<span style="float:left;" class="grant_btn">Rent it<label><input type="radio" class="radio_btn" property="property_<?php echo $value['property_id'] ?>" name="user" value="<?php echo $value[$i]['user_id'] ?>" data-displayname = "<?php echo $value[$i]['display_name'];?>" property-name="<?php echo $value['property_name'] ?>" property-id="<?php echo $value['property_id'] ?>"  ></label></span>
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
<?php else:?>
<div class="notfound">No property approved requests</div>
<?php endif;?>

</div>
</div>
</div>

<!--propertyGrantModal start -->

<div class="modal fade" id="propertyGrantModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <span class="modal-title" id="exampleModalLabel">Confirm</span>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
       <div class="modal-body">    
       <div class="confirm_text"></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="yes_grant_btn">Grant</button>
      </div>
    </div>
  </div>
</div>
<!--propertyGrantModal end -->



<!--complete rent Modal start -->

<div class="modal fade" id="completeRentModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <span class="modal-title" id="exampleModalLabel">Confirm</span>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
       <div class="modal-body">    
	
<div class="grant_text"></div>

       
      </div>
      <div class="modal-footer">
        <button type="button" class="yes_btn yes_complete">Yes</button>
      </div>
    </div>
  </div>
</div>
<!--complete rent Modal end -->
<div id="stantard-dialogBox" style="font-size:30px"></div>
<script>

	jQuery('#global_header').append('<div class="affix-top extra_header mob_bar_disable_particular_pages" data-spy="affix" data-offset-top="100">'+
	'<div id="global_content">'+
	'<div class="extra_header_content">'+
	
	'<ul class="navigation">'+
    '<li><a href="<?php echo $this->baseUrl().'/myproperties'?>">My Properties</a></li>'+
    '<li><a href="<?php echo $this->baseUrl().'/propertyrequestslist'?>">Rental Applications</a></li>'+
    '<li class="active"><a href="<?php echo $this->baseUrl().'/property/approved'?>">Accepted Applications</a></li>'+
    '</ul>'+
    
	'</div>'+
	'</div>'+
	'</div>');
	jQuery('.sub_header_dropdown').html(
                   '<select id = "sub_header_heding_select" class="input-box">'+
                   ' <option  value="myproperties">My Properties</option>'+
                   ' <option   value="propertyrequestslist">Rental Applications</option>'+
                   ' <option selected value="property/approved">Accepted Applications</option>'+
                   ' </select>'
    );

jQuery(document).on('change','#sub_header_heding_select',function(){
	 location.href=jQuery('#sub_header_heding_select').val();
});

jQuery('body').on('click', '.rent_grant_btn', function(event){ 	
  
 var req_id   = jQuery(this).attr('data-req'); 

 var oData       = new Object();

 oData.req_id            = req_id;
 
 var host	=	window.location.host;
 var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/propertyrequestapprovedgrant';
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {
                        jQuery(".rent_grant_btn_"+req_id).fadeOut();                                                     
					 },
					   error: function(e){  alert('Error: '+e);  }  
					}); 
 
 
});

 jQuery('body').on('click', '.request_report', function(event){ 	
         	
	  var oData        = new Object();
	  oData.prtyId     = jQuery(this).attr('data-prtyId'); 
	  oData.renterId   = jQuery(this).attr('data-renterId'); 
	  oData.prtyName   = jQuery(this).attr('data-prtyName'); 
	  oData.requestId  = jQuery(this).attr('data-requestId'); 
     jQuery(".request_report_"+oData.requestId).text();  
     var url = '<?php echo $this->baseUrl();?>/user/index/requestreport';
     jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					success: function (data) {
						
					    jQuery('#stantard-dialogBox').dialogBox({
										autoHide: true,
										time: 3000,
										content: 'Successfully requested for report',
                        });		
					   jQuery(".request_report_"+oData.requestId).removeClass('request_report');
                       jQuery(".request_report_"+oData.requestId).text();                                                     
                       jQuery(".request_report_"+oData.requestId).text('Successfully requested for report');                                                     
					},
					error: function(e){  //alert('Error: '+e);  
					}  
	}); 
	
});



jQuery('body').on('click', '.radio_btn', function(event){

var user_id        = parseInt(jQuery("input[name=user]:checked").val())  ;
var renter_name         =jQuery("input[name=user]:checked").attr("data-displayname");
var property_name =jQuery("input[name=user]:checked").attr("property-name");
var property_id   =jQuery("input[name=user]:checked").attr("property-id");

	jQuery("#propertyGrantModal").modal('show');
	
	if(renter_name == undefined){

    jQuery("#propertyGrantModal").modal('hide');
			
	}
	else{

    jQuery( ".confirm_text" ).text(renter_name+', requested '+property_name);
		
	}	


jQuery('body').on('click', '.yes_grant_btn', function(event){
 
   
	var unselected_tenants = '';
	jQuery('input[property=property_'+property_id+']').not(':checked').each(function() {
	unselected_tenants =	 jQuery(this).val()+','+unselected_tenants;
    
    });
  /*  alert(renter_name);
    alert(property_name);
    alert(property_id);
    alert(unselected_tenants);*/
    
    var oData       = new Object();
    oData.selected_tenant          = user_id;
    oData.unselected_tenants       = unselected_tenants;
    oData.propertyid               = property_id;
    
    var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/propertyrequestapprovedgrant';
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {
						
						if(data.status == true){
							 
							
							  jQuery("#propertyGrantModal").modal('hide');
										 
							 jQuery( "#browsemembers_ul").removeClass('user_'+user_id+'_'+property_name);						 				 
                              location.reload();          
							 
							 }      
					 },
					   error: function(e){ 
						   jQuery(".grant_btn").css("display", "block");
						    }  
					}); 

});



});	
jQuery('body').on('click', '.complete_btn', function(event){
	
	jQuery("#completeRentModal").modal('show');

    var property_id = parseInt(jQuery(this).attr('property_id'));
    var type = jQuery(this).attr('type');
    var renter_name = jQuery(this).attr('renter_name');
    jQuery( ".grant_text" ).text("Are you sure you want to complete  property "+ "<?php echo $type;?> "+ "of " +renter_name );

	
	
	
	
jQuery('body').on('click', '.yes_complete', function(event){

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

                       location.reload(); 
						}
         
					 },
					   error: function(e){  alert('Error: '+e);  }  
					}); 
    
	
	
});

	
	
	
	
});


jQuery( "#search_approvedproperty" ).change(function() {
	
    var property_id   =   jQuery('#search_approvedproperty').val();
	var oData       = new Object();
	oData.property_id       = property_id;
    var host    =   window.location.host;
    var url =   '<?php echo $this->baseUrl()?>' + '/user/index/rentalapplicationapprovedsearch';
              jQuery.ajax({
                        url:  url,
                        data: oData,
                        dataType: 'json',
                        type: 'POST',
                     success: function (data) {
						 
						     console.log(data.searchhtml);
                             jQuery('#browsemembers_ul').html(data.html);
                     },
                       error: function(e){ // alert('Error: '+e);
                            }
                    });
	  	
	  	
});


	
</script>
