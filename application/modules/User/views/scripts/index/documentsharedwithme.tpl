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

<div class="document_list_content generic_layout_container layout_middle" style="position: relative;">


<div class="msg" style="display:none"></div>
<div class="document_list">
	<?php if(count($this->sharedwithmedocs['directories']) == 0 && count($this->sharedwithmedocs['files']) == 0):?>
    <div class="notfound">No documents yet</div>
    <?php else:?>
	
	<div class="ul_list">
	<?php $i=1; ?>	
	<?php foreach($this->sharedwithmedocs['directories'] as $dir):  ?>
	<div class="dir_li list<?php echo $i;?>" dir-name="<?php echo $dir['dirname'] ;?>">
	<a href="javascript:void(0)" class="dir_open" dir-name="<?php echo $dir['dirname'] ;?>" doc-path="<?php echo $dir['docpath'] ;?>" shared_user="<?php echo $dir['shared_usered_id'] ;?>" ><img src="/application/modules/User/externals/images/document_folder.svg">&nbsp;&nbsp;<?php echo $dir['dirname'] ;?></a>
	<div style="margin-left:2px;margin-top: 6px;"><a href="<?php echo $this->baseUrl().'/profile/'.$dir['shared_usered_id'] ?>"><?php echo $dir['shared_usered_name'] ;?></a></div>
	<hr>
	</div>

	<?php  $i=$i+1; endforeach; ?>
	
	<?php foreach($this->sharedwithmedocs['files'] as $dir):  ?>
	<?php if($dir['is_image'] == 0):?>
	<div class="file_li list<?php echo $i;?>" file-name="<?php echo $dir['filename'] ;?>">
	<div class="col-md-3 col-sm-3 col-xs-12"> <a  style="font-size: 15px;" href="<?php echo $this->baseUrl().$dir['docpath']?>" target="_blank"><img src="/application/modules/User/externals/images/document_file.svg"><?php echo $dir['filename'] ;?></a></div>
	<?php else:?>
	<div class="file_li list<?php echo $i;?>" file-name="<?php echo $dir['filename'] ;?>">
	<div class="col-md-3 col-sm-3 col-xs-12"><a   style="font-size: 15px;" href="<?php echo $this->baseUrl().$dir['docpath']?>" data-lightbox="image1"><img src="/application/modules/User/externals/images/document_file.svg"><?php echo $dir['filename'] ;?></a></div>
	<?php endif;?>
	<div class="col-md-3 col-sm-3 col-xs-12" style="margin-top: 6px;"><span style="font-size: 13px;">Shared by  <a href="<?php echo $this->baseUrl().'/profile/'.$dir['shared_usered_id'] ?>" style="line-height: 11px;"><?php echo $dir['shared_usered_name'] ;?></a></span> </div>
	<div class="option_links col-md-3 col-sm-3 col-xs-12" style="margin-top: 6px;">

		<a href="javascript:void(0)" file-name="<?php echo $dir['filename'] ;?>" li-count="<?php echo $i;?>" file-id="<?php echo $dir['file_id'];?>" class="file_copy">Copy</a> 
		
	</div>
	
	
	</div>
	
	<hr style="clear:both">
	<?php $i=$i+1; endforeach; ?>
	
	</div>
	
   <?php endif;?>
    <div id="fade" class="black_overlay"></div>
</div>



<!-- file copy popup ------>
<div id="light9" class="white_content">

<div class="pop_up_title"><div class="div_attachment_title">Copy file</div><div class="div_attachment_cancel"><img src="/application/modules/User/externals/images/GREYcancel.png"></div></div>
<div class="popup_content">
	<div class="copy_err_msg" style="color: red;"></div>
<div>
	Destination
<div class="folder_name_input">
	<select class="destination"   style="width:100%">
	<option value="">Select folder</option>
	<?php for($i=0;$i<count($this->folder_paths);$i++){?>
		
		<option value="<?php echo $this->folder_paths[$i]?>"><?php echo $this->folder_paths[$i]?></option>
	
	<?php }?>
	
	</select>
<input type="hidden" class="copy_file_name" value="">
<input type="hidden" class="copy_li_count" value="">
<input type="hidden" class="copy_file_id" value="">

<div class="confirm_btns" style="text-align: left;">
<span class="confirm_btns"><button class="yes_file_copy" style="width: 134px;">Copy</button></span>
</div>
</div>
</div>
</div>
</div>
</div>
<div class="boxout_text" style="bottom: 0;padding: 12px 0px 12px 0px;">Share files with landlords like paystubs references and more. Do not reveal sensitive information.</div>
</div>

<script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/scripts/lightbox-plus-jquery.min.js"></script>

<script>jQuery.noConflict();</script>
<link href="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/styles/lightbox.min.css" rel="stylesheet" type="text/css">


<script type="text/javascript">

	jQuery('#global_header').append('<div class="affix-top extra_header mob_bar_disable_particular_pages" data-spy="affix" data-offset-top="100">'+
	'<div id="global_content">'+
	'<div class="extra_header_content">'+
	
	'<ul class="navigation">'+
    '<li><a href="documents">My Documents</a></li>'+
    '<li class="active"><a href="/documents/sharedwithme">Documents shared with me</a></li>'+
    '<li><a href="/documents/requests">Document requests</a></li>'+
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

jQuery('body').on('click', '.file_copy', function(event){ 	
	document.getElementById('light9').style.display='block';
	document.getElementById('fade').style.display='block';
	jQuery('.copy_file_name').val(jQuery(this).attr('file-name'));
	jQuery('.copy_li_count').val(jQuery(this).attr('li-count'));
	jQuery('.copy_file_id').val(jQuery(this).attr('file-id'));
});		
	

jQuery('body').on('click', '.dir_open', function(event){
   
    var dirname = jQuery(this).attr('dir-name'); 
    var current_directory = jQuery('.current_directory').val(); 
    
    var oData       = new Object();
    oData.dirname       = dirname;
    oData.current_directory           = current_directory;
    oData.doc_path              = jQuery(this).attr('doc-path');
    oData.shared_user           = jQuery(this).attr('shared_user');
    
    var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/getdirectorycontentsforlandlords';
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) { 

                    jQuery( ".dir_content ul").html(data.html);
                    jQuery( ".menu_bar_2_menus").append(' / <span>'+dirname+'</span>');       
					 },
					   error: function(e){  alert('Error: '+e);  }  
					}); 
					

					
});

jQuery('body').on('click', '.div_attachment_cancel', function(event){

	document.getElementById('light9').style.display='none';
	document.getElementById('fade').style.display='none';

	jQuery('.destination').val('');
	
});

jQuery('body').on('click', '.yes_file_copy', function(event){ 
	
	
	var file_id     = jQuery('.copy_file_id').val(); 
	var destination = jQuery('.destination').val();  
	var oData       = new Object();
	oData.file_id            = file_id; 
	oData.destination            = destination; 
	
	var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/copyfile';
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {
						 
						 if(data.status == true){
						 
						  document.getElementById('light9').style.display='none';
	                      document.getElementById('fade').style.display='none';

                          jQuery(".msg").css('display','block');
                          jQuery('.msg').text('Succesfully copied');
						 setTimeout(function () {
							 jQuery('.msg').text('');
							 jQuery('.msg').css('display','none');
						 }, 2500); 
						  jQuery('.destination').val('');
					     }
					     
					     else{
							 
							 
						  jQuery(".copy_err_msg").css('display','block');
                          jQuery('.copy_err_msg').text('Invalid directory');
						 setTimeout(function () {
							 jQuery('.copy_err_msg').text('');
							 jQuery('.copy_err_msg').css('display','none');
						 }, 2500);  
							  
						 }
					 },
					   error: function(e){ // alert('Error: '+e);  
						   }  
					}); 

});
</script>
