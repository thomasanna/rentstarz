<script src="/application/modules/User/externals/scripts/message_notififaction.js"></script>
<?php
    $viewer = Engine_Api::_()->user()->getViewer(); 
    $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
    $userHelperObj  = $this->getHelper('User'); 
    $memberPackage  = $userHelperObj->getmemberpackage($viewer->getIdentity());
	$package_type   = $memberPackage ->package_type;	
	$fieldsByAlias    = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
        if( !empty($fieldsByAlias['profile_type']) )
        {
           $optionId        = $fieldsByAlias['profile_type']->getValue($viewer);
           $profile_type_id = $optionId->value;
        }
$settings = Engine_Api::_()->getApi('settings', 'core');
$user_premiumLevelProvision = $settings->user_premiumLevelProvision;
?>

<div class="property_list_content generic_layout_container layout_middle">

<div>
<div id="browsemembers_ul">
	<?php if(count($this->ReportshareData)> 0):?>	
			<?php foreach($this->ReportshareData as $data):?>
			<?php $renterData = Engine_Api::_()->user()->getUser($data['report_shared_by']); //print_r($renterData->displayname); exit;
             ?>
             
     <div class="request_li" style="clear:both">    
		   <div class="username col-md-3 col-sm-3 col-xs-12">
			<?php echo $this->htmlLink($renterData->getHref(), $this->itemPhoto($renterData, 'thumb.icon', $renterData->getTitle()), array('title'=>$renterData->getTitle())) ?>
	        		   <div class="username">  <?php echo $renterData->displayname;?></div>	 	   

	    </div> 
		   <div class="username col-md-3 col-sm-3 col-xs-12"></div>
		   <div class="requested_date col-md-3 col-sm-4 col-xs-12">
            <a href="report/<?php echo $data['report_shared_by']?>">Report</a>
			</div>
			
     </div>
     <hr style="clear:both">
     <?php endforeach;?>
	 <?php endif;?>
</div>
</div>
</div>



<script type="text/javascript">

	jQuery('#global_header').append('<div class="affix-top extra_header mob_bar_disable_particular_pages" data-spy="affix" data-offset-top="100">'+
	'<div id="global_content">'+
	'<div class="extra_header_content">'+
	
	'<ul class="navigation">'+
    '<li><a href="documents">My Documents</a></li>'+
    '<li ><a href="/documents/sharedwithme">Documents shared with me</a></li>'+
    '<li><a href="/documents/requests">Document requests</a></li>'+
      <?php if(($package_type !='' &&  $profile_type_id == 4 ) || ($user_premiumLevelProvision == 1 &&  $profile_type_id == 4)):?>
    '<li><a href="/documents/special">Special documents</a></li>'+
    <?php endif;?>
    <?php if($profile_type_id == 4):?>
    '<li class="active"><a href="/reports/shared">Reports</a></li>'+
    <?php endif;?>
    '</ul>'+
    '</ul>'+
    
	'</div>'+
	'</div>'+
	'</div>');

	jQuery('.sub_header_dropdown').html(
                   '<select id = "sub_header_heding_select" class="input-box">'+
                   ' <option  value="documents">My Documents</option>'+
                   ' <option  selected value="documents/sharedwithme">Documents shared with me</option>'+
                   ' <option  value="documents/requests">Document requests</option>'+
                   ' <option value="documents/special">Special documents</option>'+
                   <?php if($profile_type_id == 4):?>
                   ' <option value="reports/shared">Reports</option>'+
                   <?php endif;?>
                   ' </select>'
    );

jQuery(document).on('change','#sub_header_heding_select',function(){
	 location.href=jQuery('#sub_header_heding_select').val();
});
</script>
