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
$viewer     = Engine_Api::_()->user()->getViewer(); 
date_default_timezone_set($viewer->timezone);
?>

<div style="padding: 12px 0px 12px 5px;">
<select  id="search_property" style="width: 250px;height: 37px;">
<option value="0">Search</option>
<?php foreach($this->propertyRequestList as $data):?>
<option value="<?php echo $data['property_id']; ?>"><?php echo $data['property_name'];?></option>
<?php endforeach; ?>
</select>

</div>


<div class="property_list_content generic_layout_container layout_middle">

<div>
<div id="browsemembers_ul">


<?php if(count($this->propertyRequestList) > 0 ) {?>

<?php
foreach($this->propertyRequestList as $key => $value) {?>

<div class="property_name_<?php echo $value['property_id'];?>" >
    <div class="title_color">
    <a href="<?php echo $this->baseUrl().'/property/'.$value['property_id'] ?>"><?php echo $value['property_name'];?></a>
    </div>

<ul id="property_list">

<?php for($i=0;$i<count($value);$i++){?>

<?php if($value[$i]['id'] !=''):?>

        <?php if(in_array( $value[$i]['tenantuser_id'],$online_user_id)): ?>
        <div class="led-green" style="top: 60px; margin-left: 46px;"></div>
        <?php endif; ?>

		<div  class="request_<?php echo $value[$i]['id'];?> prty_reqsts_li">
		<div>
			<?php  $userTable = Engine_Api::_()->getDbtable('users', 'user');
				  $tenantData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $value[$i]['tenantuser_id']));?>
			<?php echo $this->htmlLink($tenantData->getHref(), $this->itemPhoto($tenantData, 'thumb.icon', array('class' => 'photo'))) ?>
		<div class="position">

			<div class="user_profile col-md-3 col-sm-3 col-xs-12">
			<div>
			<a href="<?php echo $this->baseUrl().'/profile/'.$value[$i]['tenantuser_id'] ?>"><?php echo $value[$i]['tenantdisplay_name'];?></a>
			</div>
		 <div> <?php echo $this->timestamp($value[$i]['created_at']); ?>
		 </div>
		 </div>

		 <div class="view_app col-md-3 col-sm-3 col-xs-12" style="float:left;margin-bottom: 3px;"><a href="<?php echo $this->baseUrl().'/rentalapplication/'.$value[$i]['id'] ?>" class="view_application" data-requestid =<?php echo $value[$i]['id']?> data-tenantid=<?php echo $value[$i]['tenantuser_id']?> style="color: #333;"> <img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/images/view_profile.png" >&nbsp;&nbsp;View Application &nbsp;</a></div>
		 <div class="request_status_<?php echo $value[$i]['id'];?> col-md-3 col-sm-3 col-xs-12" style="float:left;margin-bottom: 3px;">
		 <?php if($value[$i]['landlord_approve'] == 0):?>
		 Waiting for approval
		 <?php endif;?>
		 <?php if($value[$i]['landlord_approve'] == 1):?>
		 Approved
		 <?php endif;?>
		 <?php if($value[$i]['landlord_approve'] == 2):?>
		 Rejected
		 <?php endif;?>
		 </div>

		<?php if($value[$i]['landlord_approve'] == '0'):?>
		<div class="col-md-3 col-sm-3 col-xs-12" style="float:left;margin-bottom: 3px;"> 
		 <a title="approve" class="req_approve_btn req_approve_btn_<?php echo $value[$i]['id'];?>" data-property="<?php echo $value[$i]['property_id'];?>" data-tenant="<?php echo $value[$i]['tenantuser_id'];?>" data-req="<?php echo $value[$i]['id'];?>" href="javascript:void(0)" class="view_coverletter" data-tenantid=<?php echo $value[$i]['tenantuser_id']?> > &nbsp;<img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/images/accept.svg" width="20px"> </a>

		 <a title="reject" class="req_reject_btn req_reject_btn_<?php echo $value[$i]['id'];?>" data-property="<?php echo $value[$i]['property_id'];?>" data-tenant="<?php echo $value[$i]['tenantuser_id'];?>" data-req="<?php echo $value[$i]['id'];?>" href="javascript:void(0)" class="view_coverletter" data-tenantid=<?php echo $value[$i]['tenantuser_id']?> > &nbsp;<img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/images/reject.svg"  width="20px"> </a>
		</div>
		<div class="loader loader_<?php echo $value[$i]['id'];?>" style="display:none"></div>

		<?php endif;?>
		</div>

		</div>

		</div>
<?php endif;?>
<?php }?>



</ul>
<hr style="clear: both;">
</div>


<?php }//endforeach;
} else { ?>
    <div class="notfound notfoundbox">No property requests</div>
    <?php } ?>
</div>
</div>
</div>

<!-- popup ------>
<div id="light" class="white_content">

</div>
<div id="fade" class="black_overlay"></div>
<script>
	
	jQuery('#global_header').append('<div class="affix-top extra_header mob_bar_disable_particular_pages" data-spy="affix" data-offset-top="100">'+
	'<div id="global_content">'+
	'<div class="extra_header_content">'+
	
	'<ul class="navigation">'+
    '<li><a href="<?php echo $this->baseUrl().'/myproperties'?>">My Properties</a></li>'+
    '<li class="active"><a href="/propertyrequestslist">Rental Applications</a></li>'+
    '<li><a href="<?php echo $this->baseUrl().'/property/approved'?>">Accepted Applications</a></li>'+
    '</ul>'+
    
	'</div>'+
	'</div>'+
	'</div>');
	
	jQuery('.sub_header_dropdown').html(
                   '<select id = "sub_header_heding_select" class="input-box">'+
                   ' <option  value="myproperties">My Properties</option>'+
                   ' <option  selected value="propertyrequestslist">Rental Applications</option>'+
                   ' <option value="property/approved">Accepted Applications</option>'+
                   ' </select>'
    );

jQuery(document).on('change','#sub_header_heding_select',function(){
	 location.href=jQuery('#sub_header_heding_select').val();
});
	

 jQuery('body').on('click', '.req_approve_btn', function(event){ 
 var property_id = jQuery(this).attr('data-property');
 var tenant_id   = jQuery(this).attr('data-tenant');
 var req_id   = jQuery(this).attr('data-req');
 jQuery(".loader_"+req_id ).css("display", "block");

 var oData       = new Object();
 oData.property_id       = property_id;
 oData.tenant_id         = tenant_id;
 oData.req_id            = req_id;
 jQuery(".req_approve_btn_"+req_id).hide();
 var host   =   window.location.host;
 var url    =   '<?php echo $this->baseUrl()?>' + '/user/index/propertyrequestapprove';
              jQuery.ajax({
                        url:  url,
                        data: oData,
                        dataType: 'json',
                        type: 'POST',
                     success: function (data) {

                    if(data.status == true){
                        jQuery(".req_approve_btn_"+req_id).fadeOut();
                        jQuery(".req_reject_btn_"+req_id).fadeOut();
                        jQuery(".loader").css("display", "none");
                        jQuery(".request_status_"+req_id).html('Approved');
                    }
                    else{
                         jQuery(".req_approve_btn_"+req_id).show();
                         jQuery(".loader_"+req_id).css("display", "none");

                    }
                     },
                       error: function(e){
                           }
                    });

 
});

 jQuery('body').on('click', '.req_reject_btn', function(event){ 

 var property_id = jQuery(this).attr('data-property');

 var count_rej_btn=jQuery('.req_reject_btn').length;
 var count_prty_reqsts_li=jQuery('.property_name_'+property_id+ ' li').length;
 


 var tenant_id   = jQuery(this).attr('data-tenant');
 var req_id   = jQuery(this).attr('data-req');
 jQuery(".loader_"+req_id).css("display", "block");

 var oData       = new Object();
 oData.property_id       = property_id;
 oData.tenant_id         = tenant_id;
 oData.req_id            = req_id;
 var host   =   window.location.host;
 var url    =   '<?php echo $this->baseUrl()?>' + '/user/index/propertyrequestreject';
              jQuery.ajax({
                        url:  url,
                        data: oData,
                        dataType: 'json',
                        type: 'POST',
                     success: function (data) {
                         jQuery(".loader").css("display", "none");
                         jQuery(".req_approve_btn_"+req_id).fadeOut();
                         jQuery(".req_reject_btn_"+req_id).fadeOut();
                         jQuery(".request_status_"+req_id).html('Rejected');
                     },
                       error: function(e){  //alert('Error: '+e);
                            }
                    });


});


jQuery( ".view_coverletter" ).click(function() {
    var tenant_id   = jQuery(this).attr('data-tenantid');
    var oData       = new Object();
    oData.tenant_id       = tenant_id;
    var host    =   window.location.host;
    var url =   '<?php echo $this->baseUrl()?>' + '/user/index/getbio';
              jQuery.ajax({
                        url:  url,
                        data: oData,
                        dataType: 'json',
                        type: 'POST',
                     success: function (data) {
                          if(data.status == true){
                              jQuery("#light").html('');
                              jQuery("#light").append(data.html);
                              jQuery("#light").css('display','block');
                              jQuery("#fade").css('display','block');


                          }
                     },
                       error: function(e){ // alert('Error: '+e);
                            }
                    });
});


jQuery('body').on('click', '.div_attachment_cancel', function(event){

    document.getElementById('light').style.display='none';
    document.getElementById('fade').style.display='none';
    jQuery("#light").html('');
})


jQuery( "#search_property" ).change(function() {
	var property_id   =   jQuery('#search_property').val();
	var oData       = new Object();
	oData.property_id       = property_id;
    var host    =   window.location.host;
    var url =   '<?php echo $this->baseUrl()?>' + '/user/index/rentalapplicationsearch';
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
