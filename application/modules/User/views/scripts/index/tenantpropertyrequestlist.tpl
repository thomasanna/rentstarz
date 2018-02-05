<script src="/application/modules/User/externals/scripts/message_notififaction.js"></script>
<link rel="stylesheet" href="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/styles/online.css" type="text/css">
<script>
<?php $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); ?>

var viewer_identity='<?php echo $viwer_id; ?>';	
</script>

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

<?php
$useragent=$_SERVER['HTTP_USER_AGENT'];
$iPod = stripos($_SERVER['HTTP_USER_AGENT'],"iPod");
$iPhone = stripos($_SERVER['HTTP_USER_AGENT'],"iPhone");
$iPad = stripos($_SERVER['HTTP_USER_AGENT'],"iPad");
$Android = stripos($_SERVER['HTTP_USER_AGENT'],"Android");
$webOS = stripos($_SERVER['HTTP_USER_AGENT'],"webOS");
if( $iPod || $iPhone || $iPad || $Android)	{$dev_type= 1; }// mobile
else{ $dev_type= 2; }// system
?>

<div class="property_requests_content generic_layout_container layout_middle">	
	<?php if((count($this->propertyRequestList) == 0) && (empty($this->rentalApplicationsData))):?>	
	<?php $rent_app_data="null"; ?>
	<div class="blue_notification"><a href="rentalapplication/create">Create your one click application</a></div>	
	<?php else: 
	$rent_app_data="notnull";
	?>

<!--<div class="headline heading"><span class="page_icon"><img src="/application/modules/User/externals/images/icon10.png" width="50px" style="padding-top: 3px;float: left;margin-right: 1%;"></span><h2>Manage Applications</h2>	</div>-->
<div class="layout_middle_content">	
<div class="tenant_property_request_list" id="tenant_property_request_list">


<div class="sub_app_scroll">
<?php 
if(count($this->propertyRequestList) > 0 ):  ?>
<?php 
foreach($this->propertyRequestList as $data):

			$propertyimageTable =  Engine_Api::_()->getDbtable('propertyimages', 'user');	

		    $propertyImageDat = $propertyimageTable->fetchAll($propertyimageTable->select()->where('property_id = ?',$data['property_id'] )->where('type="image"'));

            $propertyVideoSelect   =   $propertyimageTable->select()
							->setIntegrityCheck(false)
							->from(array('pimages'=>'engine4_property_images'))
							->joinLeft(array('file'=>'engine4_storage_files'),'pimages.storage_file_id=file.file_id',array('storage_path','file_id'))
							->where('pimages.property_id=?',$data['property_id'])
							->where('pimages.type="video"')
							->where('pimages.storage_file_id != ?', 0)
							->group('pimages.property_id');

			$propertyVideoData=$propertyimageTable->fetchRow($propertyVideoSelect);
			
			 $video_count=count($propertyVideoData);
			 $count=count($propertyImageDat);
 ?>
	<div class="row">


	<div class="property_title col-md-6 col-sm-6 col-xs-12">
	 <div class="property_location">
		 <span > <a href="<?php echo $this->baseUrl().'/property/'.$data['property_id'] ?>"><?php echo $data['property_name'];?></a></span> 
		  <div><?php echo $data['prty_country'];?> , <?php echo $data['prty_state'];?> , <?php echo $data['prty_city'];?></div> 
	 
	  <?php if($dev_type == 1): // mobile?>
	   <a href="<?php echo $this->baseUrl().'/property/map/'.$data['property_id'] ?>" target="_blank"> 
	   <!-- <img src= "/application/modules/User/externals/images/LOCATION.png">-->
	    	   <?php else:?>    <span class="location_icon" data-city ="<?php echo $data['prty_city'];?>" data-id ="<?php echo $data['property_id'];?>"  data-lat=<?php echo $data['latitude'];?> data-lng= <?php echo $data['longitude'];?>><!--<img src= "/application/modules/User/externals/images/LOCATION.png">--></span>
	  <?php endif;?>  
     </div>
     
    </div> 


		<div class="col-md-3 col-sm-3 col-xs-12 rental_application" >
			</br>
		<div class="rental_status">
		<?php if($data['landlord_approve']=='1'): ?>Application under review<?php endif; ?>
		<?php if($data['landlord_approve']=='2'): ?>Denied<?php endif; ?>		
		<?php if($data['landlord_approve']=='0'): ?>Pending<?php endif; ?>
		</div>
		</div>
<div class="property_content col-md-3 col-sm-3 col-xs-12">
	</br>
<?php if($data['landlord_approve']=='1'): 

        $Reportrequest_table     =  Engine_Api::_()->getDbtable('Reportrequest', 'user');
        $ReportrequestDataSelect = $Reportrequest_table->select()
                                    ->where('status = ?', 'Requested')
                                    ->orWhere('status = ?', 'Requested')
                                    ->where('landlord_id = ?', $data['property_owner_id'])
                                    ->where('renter_id = ?',   $viwer_id);
        $ReportrequestData = $Reportrequest_table->fetchRow($ReportrequestDataSelect); 
		 if(count($ReportrequestData)>0){
				$SmartmoveapireportTable      = Engine_Api::_()->getDbtable('Smartmoveapireport', 'user');
				$SmartmoveapireportDataSelect = $SmartmoveapireportTable->select()
											->where('RenterId = ?', $viwer_id)
											->where('status = ?', 'Active');
				$SmartmoveapireportData       = $SmartmoveapireportTable->fetchRow($SmartmoveapireportDataSelect); 
				if(count($SmartmoveapireportData) > 0){
					 $today_date     = strtotime($today_date);
					 $expiry_date    = strtotime($SmartmoveapireportData->expiry_date);
					 if($today_date > $expiry_date){ $status ="create_report";  }
					 else{ $status ="share_report"; }
				}
				else{  $status ="create_report"; }
		}
      else{ $status =""; }
?>

     <?php if($status == 'create_report'):?>
     <div class="process_application process_application_create_report">
		 <a  class="create_report" href="<?php echo $this->baseUrl().'/credit/background' ?>">Create Report</a>
		   </div>

     <?php endif;?>
     <?php if($status == 'share_report'):?>
     <?php
     $ReportshareTable =  Engine_Api::_()->getDbtable('Reportshare', 'user');
     $ReportshareData = $ReportshareTable->fetchRow($ReportshareTable->select()->where('report_shared_with  = ?', $data['property_owner_id'])
                                                                               ->where('report_shared_by    = ?', $viwer_id)
                                                                               ->where('status  = ?', 'Active'));
                                                                        
     if(count($ReportshareData) > 0):
     $is_reportShared = 1;
     else:
     $is_reportShared = 0;
     endif;
      ?>
     <?php if($is_reportShared == 0):?>
     <div class="process_application share_report_btn" report_shared_with="<?php echo $data['property_owner_id'];?>"><a href="javascript:void(0);" class="share_report" >Share Report</a> </div>
   <?php else:?>
         <div class="process_application shared_report" report_shared_with="<?php echo $data['property_owner_id'];?>">Report Shared</div>
    <?php endif;?>
<?php endif; ?>
<?php endif; ?>
	</div>	 	
</div>
<hr>
<?php endforeach; 
else:  ?>

</div>
	<div class="notfound" style="text-align:center;padding: 30px;">No property requests</div>
<?php endif; ?>
</div>

</div>
</div>
<?php endif; ?>
</div>




<!-- map popup ------>
<div id="light2" class="white_content map_popup">

<div class="pop_up_title"><div class="div_attachment_title"></div><div class="div_attachment_cancel"><img src="/application/modules/User/externals/images/GREYcancel.png"></div></div>
<div class="popup_content">
<div class="map_div">
<div id="map"></div>

</div>
</div>
</div>
<div id="stantard-dialogBox" style="font-size:30px"></div>

<div id="fade" class="black_overlay"></div>

<script type="text/javascript">
	var rent_app_data='<?php echo $rent_app_data ; ?>';
	if(rent_app_data=="notnull"){
		jQuery('#global_header').append('<div class="affix-top extra_header mob_bar_disable_particular_pages" data-spy="affix" data-offset-top="100">'+
	'<div id="global_content">'+
	'<div class="extra_header_content">'+	
	'<ul class="navigation">'+
    '<li><a href="rentalapplication/view">One Click Application</a></li>'+
    '<li class="active"><a href="javascript:void(0)">Submitted Applications</a></li>'+
    '</ul>'+    
	'</div>'+
	'</div>'+
	'</div>');
	
	jQuery('.sub_header_dropdown').html(
                   '<select id = "sub_header_heding_select" class="input-box">'+
                   ' <option  value="rentalapplication/view">One Click Application</option>'+
                   ' <option  selected value="property/requests">Submitted Applications</option>'+
                   ' </select>'
    );
}
	jQuery(document).on('change','#sub_header_heding_select',function(){
		 location.href=jQuery('#sub_header_heding_select').val();
	});	
jQuery( ".location_icon" ).click(function() {
	

	var id  = jQuery(this).data("id");
	var city  = jQuery(this).data("city");

    var url =  '<?php echo $this->baseUrl().'/property/map/' ?>' +id;	
	 
	jQuery('.div_attachment_title').html();
	jQuery('.div_attachment_title').html('<a href="'+url+'" target="_blank">View Full Map</a>');
	
	jQuery('.map_div').html();
	jQuery('.map_div').html('<div id="map"></div>');
	
	jQuery('#light2').css('display','block');
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
	jQuery('#light2').css('display','none');
	
});
jQuery('body').on('click', '.share_report_btn', function(event){
     var report_shared_with  = jQuery(this).attr("report_shared_with");
     var oData       = new Object();
     oData.report_shared_with = report_shared_with;
     var url    =   '<?php echo $this->baseUrl()?>' + '/user/index/sharereport';
     jQuery.ajax({
                        url:  url,
                        data: oData,
                        dataType: 'json',
                        type: 'POST',
                        success: function (data) {
                        if(data.status == true){
                            jQuery('.share_report_btn').css('display','none');
                               jQuery('#stantard-dialogBox').dialogBox({
                                        autoHide: true,
                                        time: 3000,
                                        content: 'Report has been succesfully shared',
                                     });
                        }
                        else{
                            jQuery('#stantard-dialogBox').dialogBox({
                                        autoHide: true,
                                        time: 3000,
                                        content: data.message,
                                     });
                        }
                     },
                       error: function(e){}
                });
});
</script>
