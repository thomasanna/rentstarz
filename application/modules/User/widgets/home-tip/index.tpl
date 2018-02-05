<?php
echo $this->message; 
// member type 
    $viewer = Engine_Api::_()->user()->getViewer(); 
    $viewerId = $viewer->getIdentity();
   // $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer); 
  /* if( !empty($fieldsByAlias['profile_type']) )
    {
      $optionId = $fieldsByAlias['profile_type']->getValue($viewer);
      $this->view->profiletype = $profile_type_id = $optionId->value; 
      $viewerProfileType = $profile_type_id;
    }*/
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
	<?php foreach ($this->tipData as $data): ?>
	<?php if($data['type']=='Feed Preference'): ?>
	<?php $feed_preference=$data['content'];  ?>
	<?php endif ; ?>
	<?php if($data['type']=='Create Rental Application'): ?>
	<?php $rental_applicatione=$data['content'];  ?>
	<?php endif ; ?>
	<?php if($data['type']=='Verification'):   ?>
	<?php $verification=$data['content'];  ?>
	<?php endif ; ?>
	<?php if($data['type']=='Start Looking'):  ?>
	<?php $start_looking=$data['content'];  ?>
	<?php endif ; ?>
	<?php if($data['type']=='Schedule Live Viewing'):  ?>
	<?php $live_viewing=$data['content'];  ?>
	<?php endif ; ?>
	<?php 
	
	
	endforeach; 
	?>
	
	<?php /*if($dev_type==2): ?>
	<div style="font-size:  24px; padding-top:17px;float: left;">Scout Board</div><!--<img style="width: 38px; margin-left: 7px; float: left;margin-top: 23px;" src="application/modules/User/externals/images/ScoutBoardIcon.png">-->
	<?php else: ?>
	
	<div class="col-md-4"><span style="font-size: 24px; padding-top: 17px; float: left;">Scout board</span><!--<img style="width: 38px; margin-left: 7px; " src="application/modules/User/externals/images/ScoutBoardIcon.png">--></div>
	<?php endif; */ ?>
	


<script type="text/javascript">
	
	jQuery(document).ready(function(){
 jQuery('#global_header').append('<div class="tip_content"></div>');
 
<?php if($this->profile_type_id==4): //landlordfeed ?> 
<?php if( $this->viewer()->prefered_location==''): ?>	
jQuery('.tip_content').append('<a href="<?php echo $this->baseUrl().'/members/edit/locationpreference'; ?>" ><span class="tooltip_message" style="color: #fff;">&nbsp;	<?php echo $feed_preference;  ?></span></a><i style="    color: #fff;float: right;'+
'padding: 3px 18px 2px 2px;"class="fa fa-times-circle-o delete_tipicon" aria-hidden="true"></i>');
<?php elseif($viewer->bg_verified==0): ?>
jQuery('.tip_content').append('<a href="<?php echo $this->baseUrl().'/members/edit/locationpreference'; ?>" ><span class="tooltip_message" style="color: #fff;">&nbsp;	<?php echo $verification;  ?></span></a><i style="    color: #fff;float: right;'+
'padding: 3px 18px 2px 2px;"class="fa fa-times-circle-o delete_tipicon" aria-hidden="true"></i>');
<?php elseif(!empty($this->landlordapproveData)):?>
jQuery('.tip_content').append('<a href="/scheduler" ><span class="tooltip_message" style="color: #fff;">&nbsp;	<?php echo $live_viewing;  ?></span></a><i style="    color: #fff;float: right;'+
'padding: 3px 18px 2px 2px;"class="fa fa-times-circle-o delete_tipicon" aria-hidden="true"></i>');
<?php elseif($viewer->bg_verified==1): ?>
jQuery('.tip_content').append('<a href="javascript:void(0)" ><span class="tooltip_message" style="color: #fff;">&nbsp;	<?php echo $start_looking;  ?></span></a><i style="    color: #fff;float: right;'+
'padding: 3px 18px 2px 2px;"class="fa fa-times-circle-o delete_tipicon" aria-hidden="true"></i>');
<?php endif; ?>
<?php endif; ?>


<?php if($this->profile_type_id==1): //tenantfeed ?>
	<?php 
	
	 $smartmoveapiRenters_table =  Engine_Api::_()->getDbtable('Smartmoveapirenters', 'user');  
   
    $this->view->smartmoveapiRentersData = $smartmoveapiRenters = $smartmoveapiRenters_table->fetchRow($smartmoveapiRenters_table->select()->where('tenant_id = ?', $viewerId));   	  

    if(!empty($smartmoveapiRenters)){
			
			$isSmartmoveRenter = 1;
	}
	else{
			
			$isSmartmoveRenter = 0;
	}
	
	?>   
	
<?php if( $this->viewer()->prefered_location==''): ?>    
jQuery('.tip_content').append('<a href="<?php echo $this->baseUrl().'/members/edit/locationpreference'; ?>" ><span class="tooltip_message" style="color: #fff;">&nbsp;	<?php echo $feed_preference;?></span></a><i style="    color: #fff;float: right;'+
'padding: 3px 18px 2px 2px;"class="fa fa-times-circle-o delete_tipicon" aria-hidden="true"></i>');
<?php elseif(empty($this->rentalApplicationsData)): ?>
jQuery('.tip_content').append('<a href="<?php echo $this->baseUrl().'/rentalapplication/create'; ?>" ><span class="tooltip_message" style="color: #fff;">&nbsp;	<?php echo $rental_applicatione;  ?></span></a><i style="    color: #fff;float: right;'+
'padding: 3px 18px 2px 2px;"class="fa fa-times-circle-o delete_tipicon" aria-hidden="true"></i>');
<?php elseif($isSmartmoveRenter == 0): ?>	
jQuery('.tip_content').append('<a href="/renter/create"><span class="tooltip_message" style="color: #fff;">&nbsp;	<?php echo $verification;  ?></span></a><i style="    color: #fff;float: right;'+
'padding: 3px 18px 2px 2px;"class="fa fa-times-circle-o delete_tipicon" aria-hidden="true"></i>');
<?php elseif(!empty($this->propertyRequestData)): ?> 
jQuery('.tip_content').append('<a href="/scheduler"><span class="tooltip_message" style="color: #fff;">&nbsp;	<?php echo $live_viewing;  ?></span></a><i style="    color: #fff;float: right;'+
'padding: 3px 18px 2px 2px;"class="fa fa-times-circle-o delete_tipicon" aria-hidden="true"></i>');
<?php elseif($isSmartmoveRenter==1): ?>
jQuery('.tip_content').append('<a href="javascript:void(0)"><span class="tooltip_message" style="color: #fff;">&nbsp;	<?php echo $start_looking;  ?></span></a><i style="    color: #fff;float: right;'+
'padding: 3px 18px 2px 2px;"class="fa fa-times-circle-o delete_tipicon" aria-hidden="true"></i>');
    <?php endif; ?>	
  
  <?php endif; ?>	 
  
  
		var tip_block='<?php echo $this->tipblock;?>';


		        if(tip_block==1)
		        {
					
					//jQuery(".feedtip").css('display','block');  
					jQuery(".tip_content").css('display','block');  
				}
				else
				{
					
					// jQuery(".feedtip").css('display','none');  
					 jQuery(".tip_content").css('display','none');  
				}
	});
	
	//jQuery( ".delete_tipicon" ).click(function(e) {
   	 jQuery('body').on('click', '.delete_tipicon', function(e){
	//jQuery(".feedtip").css('display','none');
	jQuery(".tip_content").css('display','none');
	
	var formURL    = '<?php echo $this->baseUrl(); ?>' + '/user/index/tipdismisstime';
		
	jQuery.ajax( {
						url : formURL,
						type: "POST",
						dataType: 'json',
				//		data : oData,
						success: function (data) { 
								
							},
							error: function(e){  
						   
						}
    });	
   // e.stopPropagation();
   // return(false);
    });



function call()
 {  
	
	var formURL    = '<?php echo $this->baseUrl(); ?>' + '/user/index/gettipdismisstime';
		
	jQuery.ajax( {
						url : formURL,
						type: "POST",
						dataType: 'json',
						success: function (data) {
   
			   if(data.status==true)
		        {
					if(data.block==1)
					{
					//jQuery(".feedtip").css('display','block');  
					jQuery(".tip_content").css('display','block');  
				    }
				    else
				    {
						//jQuery(".feedtip").css('display','none'); 
						jQuery(".tip_content").css('display','none'); 
					}
				}
				else
				{
					//jQuery(".feedtip").css('display','block'); 
					jQuery(".tip_content").css('display','block'); 
				}
				},

			
			error: function(e){  
						   
			}
			
			});
		}	

        setInterval(call,40000);
</script>


<script>


</script>



	
