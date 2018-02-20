<script src="/application/modules/User/externals/scripts/message_notififaction.js"></script>
<script>
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
var viewer_identity='<?php echo $viwer_id; ?>';	
</script>
 <div class="document_list_content  generic_layout_container layout_middle" style="position: relative;">
 
  
<div class="document_list">
<?php if(count($this->docRequests) >0): ?>	
<ul>


<?php foreach($this->docRequests as $reqsts): ?>

<li class="req_<?php echo $reqsts['id']; ?>"><a href="<?php echo $this->baseUrl().'/profile/'.$reqsts['doc_requested_user_id'] ?>"><?php echo $reqsts['displayname']; ?></a> has sent request to access your document '<?php echo $reqsts['doc_name'];?>'
<span style="float: right;">	
<?php 
if($reqsts['doc_owner_approve']==1):
echo "Approved";
endif;  ?>
</span>
<?php if($reqsts['doc_owner_approve'] == 0):?>  
<span style="float: right;" class="docreq_approval_<?php echo $reqsts['id']; ?>"></span>
<span style="float: right;" class="docreq_rejectbtn docreq_rejectbtn_<?php echo $reqsts['id']; ?>" req-id = <?php echo $reqsts['id']; ?> style="width: 72px;" title="Reject"><img src="/application/modules/User/externals/images/reject.svg" width="20px"></span>
<span style="float: right;padding-right: 4px;" class="docreq_approve_btn docreq_approve_btn_<?php echo $reqsts['id']; ?>" req-id = <?php echo $reqsts['id']; ?> title="Approve"><img src="/application/modules/User/externals/images/accept.svg"  width="20px"></span>
<?php endif;?>
<hr>
</li>

<?php endforeach;?>
</ul>
<?php else:?>
<div class="notfound">No requests yet</div>
<?php endif;?>
</div>

</div>
<div class="boxout_text" style="bottom: 0;padding: 12px 0px 12px 0px;">Share files with landlords like paystubs references and more. Do not reveal sensitive information.</div>


 
<script>
	
	
		jQuery('#global_header').append('<div class="affix-top extra_header mob_bar_disable_particular_pages" data-spy="affix" data-offset-top="100">'+
	'<div id="global_content">'+
	'<div class="extra_header_content">'+
	
	'<ul class="navigation">'+
    '<li><a href="documents">My Documents</a></li>'+
    '<li><a href="/documents/sharedwithme">Documents shared with me</a></li>'+
    '<li class="active"><a href="/documents/requests">Document requests</a></li>'+
      <?php if(($package_type !='' &&  $profile_type_id == 4 ) || ($user_premiumLevelProvision == 1 &&  $profile_type_id == 4)):?>
    '<li><a href="/documents/special">Special documents</a></li>'+
    <?php endif;?>
    <?php if($profile_type_id == 4):?>
    '<li><a href="/reports/shared">Reports</a></li>'+
    <?php endif;?>
    '</ul>'+
    '</ul>'+
    
	'</div>'+
	'</div>'+
	'</div>');
	
jQuery('.sub_header_dropdown').html(
                   '<select id = "sub_header_heding_select" class="input-box">'+
                   ' <option   value="documents">My Documents</option>'+
                   ' <option  value="documents/sharedwithme">Documents shared with me</option>'+
                   ' <option  selected value="documents/requests">Document requests</option>'+
                   ' <option value="documents/special">Special documents</option>'+
                    <?php if($profile_type_id == 4):?>
                   ' <option value="reports/shared">Reports</option>'+
                   <?php endif;?>
                   ' </select>'
);

jQuery(document).on('change','#sub_header_heding_select',function(){
	 location.href=jQuery('#sub_header_heding_select').val();
});

jQuery( ".docreq_approve_btn" ).click(function() {
	
	var req_id = jQuery(this).attr('req-id'); 
	var oData       = new Object();
    oData.req_id       = req_id;
    var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/docrequestapprove';
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {
                        jQuery(".docreq_approve_btn_"+req_id).fadeOut();                            
                        jQuery(".docreq_rejectbtn_"+req_id).fadeOut(); 
                        jQuery("#successModal .success_message").text('');
                        jQuery("#successModal .success_message").text('You have successfully accepted the request');
                        jQuery("#successModal").modal('show');     
                        jQuery(".docreq_approval_"+req_id).text("Approved");                      
					 },
					   error: function(e){  alert('Error: '+e);  }  
					}); 
	
	
});

jQuery( ".docreq_rejectbtn" ).click(function() {
	
	var req_id = jQuery(this).attr('req-id'); 
	var oData       = new Object();
    oData.req_id       = req_id;
    var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/docrequestreject';
     jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {
						
                        jQuery(".docreq_rejectbtn_"+req_id).fadeOut();                            
                        jQuery(".req_"+req_id).fadeOut(); 
                        jQuery("#successModal .success_message").text('');
                        jQuery("#successModal .success_message").text('You have successfully rejected the request');
                        jQuery("#successModal").modal('show');                           
                         
					 },
					   error: function(e){  //alert('Error: '+e);
						     console.log(e); }  
					}); 
    
    
	
	
});

</script>
