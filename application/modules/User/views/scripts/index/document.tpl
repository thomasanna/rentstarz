<link href="/application/modules/User/externals/styles/lightbox.min.css" rel="stylesheet" type="text/css">

<?php   $viewer = Engine_Api::_()->user()->getViewer(); 
$root_dirname =   $viewer->getIdentity().'_'.$viewer->displayname; 

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
 <div style="overflow: hidden;    margin-top: 6px;">
<!--<div class="page_icon"><img src="/application/modules/User/externals/images/icon9.png" width="46px" height="46px" style="width: 38px;
    height: 31px;
    margin-bottom: 4px;
    padding: 0px;"></div>
<div class="doc-heading" style="text-align: center;">
    <h2 style="margin: 0px;">Share your Documents</h2>
  </div> -->
</div>
<div class="document_list_content generic_layout_container layout_middle" style="position: relative;">

<input type="hidden" class="current_directory" value="">
<div class="msg" style="display:none"></div>
<div class="menu_bar_1">
<button class="new_folder_btn">Create Folder</button>
<button class="upload_file_btn" style="display: none;">Upload</button>
<button class="back_file_btn" cur_dir="" style="width: 104px;display:none">Back</button>
</div>
<div class="menu_bar_2" style="display:none">
<div class="menu_bar_2_menus"><span></span></div>

</div>

<div class="dir_content">
	<ul class="ul_list">
   <?php if(count($this->files['directories']) == 0 && count($this->files['files']) == 0):?>
	  <div class="notfound">No documents yet</div>
	<?php else:?>
	
	
	<?php $i=1; ?>	
	<?php foreach($this->files['directories'] as $dir):  ?>
	<li class="dir_li list<?php echo $i;?>" dir-name="<?php echo $dir['dirname'] ;?>">
	<a href="javascript:void(0)" class="dir_open" dir-name="<?php echo $dir['dirname'] ;?>" ><img src="/application/modules/User/externals/images/document_folder.svg">&nbsp;&nbsp;<?php echo $dir['dirname'] ;?></a>
	<span class="option_links">
		<!--<a href="javascript:void(0)" dir-name="<?php echo $dir['dirname'] ;?>" li-count="<?php echo $i;?>" class="dir_share">Share</a> |-->
		<a href="javascript:void(0)" dir-name="<?php echo $dir['dirname'] ;?>" li-count="<?php echo $i;?>" class="dir_rename">Rename</a> |
		<a href="javascript:void(0)" dir-name="<?php echo $dir['dirname'] ;?>" li-count="<?php echo $i;?>" class="dir_delete">Delete</a>
	</span>
		<hr>
	</li>

	<?php  $i=$i+1; endforeach; ?>
	
	<?php foreach($this->files['files'] as $dir):  ?>
    <?php if($dir['is_image'] == 1):?>
	<li class="file_li list<?php echo $i;?>" file-name="<?php echo $dir['filename'] ;?>" is-image ="<?php echo $dir['is_image'];?>"><a href="<?php echo '/filemanager/'.$dir['file_path']; ?>"  class="file_open" file-id="<?php echo $dir['file_id'];?>" data-lightbox="image1" target="_blank"><img src="/application/modules/User/externals/images/document_file.svg">&nbsp;&nbsp;<?php echo $dir['file_title'] ;?></a>
	<?php else:?>
	<li class="file_li list<?php echo $i;?>" file-name="<?php echo $dir['filename'] ;?>" is-image ="<?php echo $dir['is_image'];?>"><a href="<?php echo '/filemanager/'.$dir['file_path']; ?>"  class="file_open" file-id="<?php echo $dir['file_id'];?>" target="_blank"><img src="/application/modules/User/externals/images/document_file.svg">&nbsp;&nbsp;<?php echo $dir['file_title'] ;?></a>
	<?php endif;?>
	<span class="option_links">
		<a href="javascript:void(0)" file-name="<?php echo $dir['filename'] ;?>" li-count="<?php echo $i;?>" file-id="<?php echo $dir['file_id'];?>" class="file_details">Details</a> |
		<a href="javascript:void(0)" file-name="<?php echo $dir['filename'] ;?>" li-count="<?php echo $i;?>" file-id="<?php echo $dir['file_id'];?>" class="file_share">Share</a> |
		<a href="javascript:void(0)" file-name="<?php echo $dir['filename'] ;?>" li-count="<?php echo $i;?>" file-id="<?php echo $dir['file_id'];?>" class="file_rename">Rename</a> |
		<a href="javascript:void(0)" file-name="<?php echo $dir['filename'] ;?>" li-count="<?php echo $i;?>" file-id="<?php echo $dir['file_id'];?>" class="file_copy">Copy</a> |
		<a href="javascript:void(0)" file-name="<?php echo $dir['filename'] ;?>" li-count="<?php echo $i;?>" file-id="<?php echo $dir['file_id'];?>" class="file_delete">Delete</a>
	</span>
	<hr>
	</li>
	
	<?php $i=$i+1; endforeach; ?>
	
	
	<?php endif;?>
</ul>

</div>


<!-- New folder popup ------>
<div id="light" class="white_content">

<div class="pop_up_title"><div class="div_attachment_title">Create new folder</div><div class="div_attachment_cancel"><img src="/application/modules/User/externals/images/GREYcancel.png"></div></div>
<div class="popup_content">
<div>
	<div class="valid_message" style="display:none;color:red">Please enter folder name</div>	
	Title
<div class="folder_name_input"><input type="text" class="folder_name">
<input type="hidden" class="cur_dir" value=""></div>

<div class="confirm_btns" style="text-align: left;">
<span class="ctreate_folder_btns"><span class="confirm_btns" ><button class="create_folder" style="width: 134px;">Create folder</button></span>


<div class="add_folder_loader" style="display:none;"></div>

</div>
</div>
</div>
</div>

<div id="fade" class="black_overlay"></div>

<!-- new file popup ------>
<div id="light1" class="white_content">

<div class="pop_up_title"><div class="div_attachment_title">Upload new file</div><div class="div_attachment_cancel"><img src="/application/modules/User/externals/images/GREYcancel.png"></div></div>
<div class="popup_content">
<div>	
	<div class="err_msg" style="color: red;"></div>	
<form method="POST" enctype="multipart/form-data" action="<?php echo $this->baseurl('user/edit/savefile'); ?>" class="file_upload_frm">
<div class="folder_name_input">
<div>Title</div><div style="margin-bottom: 12px;margin-top: 2px;"><input type="text" class="upload_file_title" name="upload_file_title"></div>
	<input type="file" class="upload_files" name="upload_files">
	<div>only PDF, JPG, JPEG, and PNG  files are allowed.</div>
<input type="hidden" class="cur_dir" value="" name="cur_dir"></div>
<div class="confirm_btns" style="text-align: left;">
<input type="submit" value="Upload File" class="file_upload_submit_btn" style="width: 134px;">
</div>
</form>
<div class="loader" style="display:none;"></div>
</div>
</div>
</div>
<div id="fade" class="black_overlay"></div>
<!-- rename popup ------>
<div id="light3" class="white_content">
<div class="pop_up_title"><div class="div_attachment_title">Rename file</div><div class="div_attachment_cancel"><img src="/application/modules/User/externals/images/GREYcancel.png"></div></div>
<div class="popup_content">
	<div>
<div class="rename_err_msg" style="color: red;"></div>	
Title<div class="folder_name_input" ><input type="text" class="new_name" style="width: 100%;">
<input type="hidden" class="cur_dir" value="">
<input type="hidden" class="old_name" value="">
<input type="hidden" class="file_id" value="">
<input type="hidden" class="rename_li_count" value="">
</div>
<div class="confirm_btns" style="text-align: left;">
<span class="confirm_btns"><button class="rename">Rename</button></span>
</div>
</div>
</div>
</div>
<div id="fade" class="black_overlay"></div>
<!-- share popup ------>
<div id="light4" class="white_content">
<input type="hidden" class="share_dir_name" value="">	
<input type="hidden" class="share_file_id" value="">	

</div>

<div id="fade" class="black_overlay"></div>
<!-- list view file details popup ------>
<div id="light5" class="white_content">
</div>
<div id="fade" class="black_overlay"></div>

<!-- file delete popup ------>
<div id="light6" class="white_content">

<div class="pop_up_title"><div class="div_attachment_title">Delete file</div><div class="div_attachment_cancel"><img src="/application/modules/User/externals/images/GREYcancel.png"></div></div>
<div class="popup_content">
<div>
<div style="margin-bottom: 12px;">Do you want to delete this file?</div>	
<input type="hidden" class="delete_file_name" value="">
<input type="hidden" class="delete_li_count" value="">
<input type="hidden" class="delete_file_id" value="">

<div class="confirm_btns" style="text-align: left;">
<span class="confirm_btns"><button class="yes_file_delete" style="width: 134px;">Yes</button></span>


</div>
</div>
</div>
</div>



<div id="fade" class="black_overlay"></div>

<!-- dir delete popup ------>
<div id="light7" class="white_content">

<div class="pop_up_title"><div class="div_attachment_title">Delete folder</div><div class="div_attachment_cancel"><img src="/application/modules/User/externals/images/GREYcancel.png"></div></div>
<div class="popup_content">
<div>	
	
<div style="margin-bottom: 12px;">Do you want to delete this folder?</div>	
<input type="hidden" class="delete_dir_name" value="">
<input type="hidden" class="delete_dir_li_count" value="">

<div class="confirm_btns" style="text-align: left;">
<span class="confirm_btns"><button class="yes_dir_delete" style="width: 134px;">Yes</button></span>

</div>
</div>
</div>
 </div>
<div id="fade" class="black_overlay"></div>

<!-- list shared users popup to revoke access ------>
<div id="light8" class="white_content">

</div>

<div id="fade" class="black_overlay"></div>



<!-- file copy popup ------>
<div id="light9" class="white_content">

<div class="pop_up_title"><div class="div_attachment_title">Copy file</div><div class="div_attachment_cancel"><img src="/application/modules/User/externals/images/GREYcancel.png"></div></div>
<div class="popup_content">
	<div class="copy_err_msg" style="color: red;"></div>
	
<div> 
<input type="hidden" class="copy_file_name" value="">
<input type="hidden" class="copy_li_count" value="">
<input type="hidden" class="copy_file_id" value="">
	
<div class="main_content_copy_popup"> 
<?php  if(count($this->folder_paths) > 0):?>
	Destination
<div class="folder_name_input">
	<select class="destination"   style="width:100%">
	<option value="">Select folder</option>
		<?php for($i=0;$i<count($this->folder_paths);$i++){?>
		
		<option value="<?php echo $this->folder_paths[$i]?>"><?php echo $this->folder_paths[$i]?></option>
	
	<?php }?>
	
	</select>
	
	<!--<input type="text" class="destination" style="width:100%">-->	


<div class="confirm_btns" style="text-align: left;"><div class="confirm_btns" style="text-align: left;">
<span class="confirm_btns"><button class="yes_file_copy" style="width: 134px;">Copy</button></span>

</div>
</div>
</div>
<?php else:?>

<span>You have no folders created to copy this document</span>

<div class="menu_bar_create_folder">
<button class="new_folder_btn">Create Folder</button>
</div>

<?php endif;?>
</div>
</div>
<div id="fade" class="black_overlay"></div>



</div>

</div>
</div>

<div class="boxout_text" style="bottom: 0;padding: 12px 0px 12px 0px;">Share files with landlords like paystubs references and more. Do not reveal sensitive information.</div>

<script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/scripts/lightbox-plus-jquery.min.js"></script>
<script>jQuery.noConflict();</script>
<script type="text/javascript">
	
	jQuery('#global_header').append('<div class="affix-top extra_header mob_bar_disable_particular_pages" data-spy="affix" data-offset-top="100">'+
	'<div id="global_content">'+
	'<div class="extra_header_content">'+
	
	'<ul class="navigation">'+
    '<li class="active"><a href="javascript:void(0)">My Documents</a></li>'+
    '<li><a href="/documents/sharedwithme">Documents shared with me</a></li>'+
    '<li><a href="/documents/requests">Document requests</a></li>'+
     <?php if(($package_type !='' &&  $profile_type_id == 4 ) || ($user_premiumLevelProvision == 1 &&  $profile_type_id == 4)):?>
    '<li><a href="/documents/special">Special documents</a></li>'+
    <?php endif;?>
     <?php if($profile_type_id == 4):?>
    '<li><a href="/reports/shared">Reports</a></li>'+
    <?php endif;?>
    '</ul>'+
    
	'</div>'+
	'</div>'+
	'</div>');
	

jQuery('.sub_header_dropdown').html(
                   '<select id = "sub_header_heding_select" class="input-box">'+
                   ' <option  selected value="documents">My Documents</option>'+
                   ' <option  value="documents/sharedwithme">Documents shared with me</option>'+
                   ' <option value="documents/requests">Document requests</option>'+
                   ' <option value="documents/special">Special documents</option>'+
                    <?php if($profile_type_id == 4):?>
                   ' <option value="reports/shared">Reports</option>'+
                   <?php endif;?>
                   ' </select>'
);

jQuery(document).on('change','#sub_header_heding_select',function(){
	 location.href=jQuery('#sub_header_heding_select').val();
});

jQuery( document ).ready(function() {
   
   var text= jQuery('.form-notices li').text();
   if(text == 'Your document is successfully saved.'){
	   jQuery('#title').val('');
   }
  setTimeout(function() {
  jQuery('.form-notices').hide();
   }, 4000);
   
});
	jQuery('#save_document').click(function(){
		var title	=	jQuery('#title').val();
		var imgVal =    jQuery('#document').val();
		
		jQuery('.validation_message_title').remove();
		jQuery('.validation_message_document').remove();
		
		var error	=	false;
		
		if(title	==	'')
		{
				jQuery("#title-element").append("<div class='validation_message_title' style='color:red';margin-left:2px;>Please enter title</div>");
				error = true;
		}
		if(imgVal	==	'')
		{
				jQuery("#document-element").append("<div class='validation_message_document' style='color:red';margin-left:2px;>Please enter document</div>");
				error = true;
		}
		
		if(error)
		{
			return false;
		}
		else
		{
				jQuery('.validation_message_title').remove();
				jQuery('.validation_message_document').remove();
		}
		
	});



//--------------------------------------------------------------------------



jQuery('body').on('click', '.new_folder_btn', function(event){
	document.getElementById('light').style.display='block';
	document.getElementById('light9').style.display='none';
	document.getElementById('fade').style.display='block';
});

jQuery('body').on('click', '.cancel', function(event){
	
	document.getElementById('light').style.display='none';
	document.getElementById('light3').style.display='none';
	document.getElementById('light4').style.display='none';
	document.getElementById('light5').style.display='none';
	document.getElementById('light6').style.display='none';
	document.getElementById('light7').style.display='none';
	document.getElementById('fade').style.display='none';
	jQuery('#light5').html('');
	jQuery(".rename_err_msg").text('');
	jQuery(".folder_name").val('');
	
});
jQuery('body').on('click', '.div_attachment_cancel', function(event){
	
	document.getElementById('light').style.display='none';
	document.getElementById('light1').style.display='none';
	document.getElementById('light3').style.display='none';
	document.getElementById('light4').style.display='none';
	document.getElementById('light5').style.display='none';
	document.getElementById('light6').style.display='none';
	document.getElementById('light7').style.display='none';
	document.getElementById('light8').style.display='none';
	document.getElementById('light9').style.display='none';
	document.getElementById('fade').style.display='none';
	jQuery('#light5').html('');
	jQuery(".rename_err_msg").text('');
	jQuery(".folder_name").val('');
	jQuery('.destination').val('');
	
});
jQuery('body').on('click', '.create_folder', function(event){
	

	var folder_name = jQuery('.folder_name').val(); 
	var cur_dir     = jQuery('.cur_dir').val(); 
	var li_count = parseInt(jQuery(".ul_list li").length); 
	var oData       = new Object();
    oData.folder_name       = folder_name;
    oData.cur_dir           = cur_dir;
    oData.li_count           = li_count;
    
    if(folder_name == '')
    {
		jQuery('.valid_message').css('display','block');
		setTimeout(function() {
			jQuery('.valid_message').hide();
		}, 4000);
		return;
	}

	
	jQuery(".ctreate_folder_btns").css('display','none');
	jQuery(".add_folder_loader").css('display','block');
	

    
    var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/edit/createdirectory';
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {
						   document.getElementById('light').style.display='none';
	                       document.getElementById('fade').style.display='none'; 
						   jQuery(".ctreate_folder_btns").css('display','block');
                           jQuery(".add_folder_loader").css('display','none');
                           jQuery(".notfound").css('display','none');
                           jQuery(".msg").css('display','block');
                           jQuery(".msg").text(data.msg);
                           jQuery(".folder_name").val('');
                           jQuery( ".dir_content ul").append(data.content);
                           setTimeout(function () {
							 jQuery('.msg').text('');
							 jQuery('.msg').css('display','none');
						 }, 2500); 
                                
					 },
					   error: function(e){  //alert('Error: '+e);
						     }  
					}); 

	
});

jQuery('body').on('click', '.upload_file_btn', function(event){
	document.getElementById('light1').style.display='block';
	document.getElementById('fade').style.display='block';
});
jQuery('body').on('click', '.cancel_upload', function(event){
	
	document.getElementById('light1').style.display='none';
	document.getElementById('fade').style.display='none';
	jQuery('.err_msg').text('');
	jQuery('.upload_file_title').val('');
	jQuery('.upload_files').val('');
	
});

jQuery('body').on('click', '.cancel_upload', function(event){
	
	document.getElementById('light1').style.display='none';
	document.getElementById('fade').style.display='none';
	
});


jQuery(".file_upload_frm").on('submit',(function(e){
e.preventDefault();
jQuery('.file_upload_submit_btn').prop('disabled', true);
 var li_count = parseInt(jQuery(".ul_list li").length)+1; 
 var host	=	window.location.host;
 var filepath = jQuery('.upload_files').val(); 
 var filetitle = jQuery('.upload_file_title').val(); 
  jQuery('.file_upload_btns').css('display','none');
  jQuery('.loader').css('display','block'); 
 if(filepath  == ''|| filetitle == ''){	 
	jQuery('.file_upload_submit_btn').prop('disabled', false); 
	jQuery('.file_upload_btns').css('display','block');
    jQuery('.loader').css('display','none');
	 
	     jQuery(".err_msg").text('Please enter all fields.');  
						setTimeout(function () {
							 jQuery('.err_msg').text('');
						 }, 2500);	 
 }
 else{
 var filename = jQuery('input[type=file]').val().split('\\').pop();
 
    var file = jQuery('.upload_files')[0].files[0];
    var fileName = file.name;
    var fileExt = '.' + fileName.split('.').pop();  
  if(fileExt != ".jpg" && fileExt != ".JPG" && fileExt != ".png" && fileExt != ".jpeg" && fileExt != ".JPEG" &&  fileExt != ".PNG" && fileExt != ".pdf") {
	  jQuery('.file_upload_submit_btn').prop('disabled', false); 	
	  jQuery('.file_upload_btns').css('display','block');
      jQuery('.loader').css('display','none'); 
                           jQuery(".err_msg").text('Sorry, only PDF, JPG, JPEG, & PNG  files are allowed.');  
						 setTimeout(function () {
							 jQuery('.err_msg').text('');
						 }, 2500); 
  }  
  else{  
 var current_directory = jQuery('.current_directory').val();
 var root_dirname  = '<?php echo $root_dirname; ?>';
 var file_path = '<?php echo $this->baseUrl()?>' + '/filemanager/' + root_dirname +current_directory+'/'+filename;
 var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/savefile';
	jQuery.ajax({
	url: url,
	type: "POST",
	data:  new FormData(this),
	contentType: false,
	cache: false,
	processData:false,
	success: function(data){console.log(data); 
	//var filename= data.replace(/\"/g, "");

	if(data != 'null' && data != ' '){var fileid= data.replace(/\"/g, "");
	
	var res = fileid.split("_"); 
	var file_id = res['0'];
	var filename = res['1'];
	var file_path = '<?php echo $this->baseUrl()?>' + '/filemanager/' + root_dirname +current_directory+'/'+res['1'];
	
	if(fileExt =='.jpg' || fileExt == '.png' ||  fileExt == '.jpeg'){
		
		
	jQuery( ".dir_content ul").append('<li class="file_li list'+li_count+'" file-name="'+filename+'" ><a href="'+file_path+'" target="_blank" file-id ="'+fileid+'" class="file_link1" data-lightbox="image1"><img src="/application/modules/User/externals/images/document_file.svg">&nbsp;&nbsp;'+filetitle+'</a><span class="option_links"><a href="javascript:void(0)" file-name="'+filename+'" li-count="'+li_count+'" file-id="'+file_id+'" class="file_details">Details</a> | <a href="javascript:void(0)" file-name="'+filename+'" li-count="'+li_count+'" file-id="'+file_id+'" class="file_share">Share</a> | <a href="javascript:void(0)" class="file_rename" file-name="'+filename+'" li-count="'+li_count+'" file-id="'+file_id+'">Rename</a> |  <a href="javascript:void(0)" class="file_copy" file-name="'+filename+'" li-count="'+li_count+'" file-id="'+file_id+'">Copy</a> | <a href="javascript:void(0)" class="file_delete" file-name="'+filename+'" li-count="'+li_count+'" file-id ="'+file_id+'">Delete</a></span><hr></li>');	
		
	}
	else{
	jQuery( ".dir_content ul").append('<li class="file_li list'+li_count+'" file-name="'+filename+'" ><a href="'+file_path+'" target="_blank" file-id ="'+fileid+'" class="file_link1"><img src="/application/modules/User/externals/images/document_file.svg">&nbsp;&nbsp;'+filetitle+'</a><span class="option_links"><a href="javascript:void(0)" file-name="'+filename+'" li-count="'+li_count+'" file-id="'+file_id+'" class="file_details">Details</a> | <a href="javascript:void(0)" file-name="'+filename+'" li-count="'+li_count+'" file-id="'+file_id+'" class="file_share">Share</a> | <a href="javascript:void(0)" class="file_rename" file-name="'+filename+'" li-count="'+li_count+'" file-id="'+file_id+'">Rename</a> | <a href="javascript:void(0)" class="file_copy" file-name="'+filename+'" li-count="'+li_count+'" file-id="'+file_id+'">Copy</a> | <a href="javascript:void(0)" class="file_delete" file-name="'+filename+'" li-count="'+li_count+'" file-id ="'+file_id+'">Delete</a></span><hr></li>');
    }
    jQuery('.file_upload_submit_btn').prop('disabled', false); 
    jQuery('.file_upload_btns').css('display','block');
    jQuery('.loader').css('display','none'); 
	 
    document.getElementById('light1').style.display='none';
	document.getElementById('fade').style.display='none';
    
    jQuery('.upload_file_title').val('');
    jQuery('.upload_files').val(''); 
    jQuery(".notfound").css('display','none');
    jQuery(".msg").css('display','block');
                           jQuery(".msg").text('File is successfully uploaded.');  
						 setTimeout(function () {
							 jQuery('.msg').text('');
							 jQuery('.msg').css('display','none');
						 }, 2500); 
    
    }
    else{
	jQuery('.file_upload_submit_btn').prop('disabled', false); 	
	jQuery('.file_upload_btns').css('display','block');
    jQuery('.loader').css('display','none'); 
	 
		//jQuery(".msg").css('display','block');
                           jQuery(".err_msg").text('Sorry, only PDF, JPG, JPEG, & PNG  files are allowed.');  
						 setTimeout(function () {
							 jQuery('.err_msg').text('');
						 }, 2500); 
		
	}
	},
	error: function(){} 	        
	});
	
}
}
}));


jQuery('body').on('click', '.dir_open', function(event){
   
    var dirname = jQuery(this).attr('dir-name');
    var current_directory = jQuery('.current_directory').val(); 
    
    var oData       = new Object();
    oData.dirname       = dirname;
    oData.current_directory           = current_directory; 
    oData.menu_open           = 0;
   // alert(current_directory);
    var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/edit/getdirectorycontents';
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {

                    jQuery( ".new_folder_btn").css('display','none');
                    jQuery( ".upload_file_btn").css('display','block');
                    jQuery( ".back_file_btn").css('display','block');
                    jQuery( ".dir_content ul").html(data.html);
                    jQuery( ".menu_bar_2").css('display','block');
                    jQuery( ".menu_bar_2_menus").html('<span><a href="javascript:void(0)" onClick="window.location.reload( true );"> Documents </a>'+data.cur_dir_menu+'</span>');
                    jQuery('.current_directory').val(data.cur_dir);             
                    jQuery('.cur_dir').val(data.cur_dir);   
                    
                    jQuery(".back_file_btn").attr("cur_dir",current_directory);   
                    
                           
					 },
					   error: function(e){  //alert('Error: '+e);  
						   }  
					}); 
					

					
});

jQuery('body').on('click', '.menu_dir_open', function(event){
   
    var dirname = jQuery(this).attr('dir_path');
   // var current_directory = jQuery('.current_directory').val();
    
    var oData       = new Object();
    oData.dirname       = dirname;
    oData.current_directory           = dirname; 
    oData.menu_open           = 1;
   // alert(current_directory);
    var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/edit/getdirectorycontents';
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {

                    jQuery( ".dir_content ul").html(data.html);
                    jQuery( ".menu_bar_2").css('display','block');
                    jQuery( ".menu_bar_2_menus").html('<span><a href="javascript:void(0)" onClick="window.location.reload( true );"> Documents </a>'+data.cur_dir_menu+'</span>');
                    jQuery('.current_directory').val(data.cur_dir);             
                    jQuery('.cur_dir').val(data.cur_dir); 
                    jQuery(".back_file_btn").attr("cur_dir",data.par_dir);                
					 },
					   error: function(e){  //alert('Error: '+e);  
						   }  
					}); 		
});
jQuery('body').on('click', '.file_delete', function(event){ 
	
	document.getElementById('light6').style.display='block';
	document.getElementById('fade').style.display='block';
	jQuery('.delete_file_name').val(jQuery(this).attr('file-name'));
	jQuery('.delete_li_count').val(jQuery(this).attr('li-count'));
	jQuery('.delete_file_id').val(jQuery(this).attr('file-id'));
});	
jQuery('body').on('click', '.yes_file_delete', function(event){
	
	var file_name = jQuery('.delete_file_name').val();
	var li_count = jQuery('.delete_li_count').val();
	var file_id = jQuery('.delete_file_id').val();
    var current_directory = jQuery('.current_directory').val();
    var oData       = new Object();
    oData.file_name        = file_name;
    oData.current_directory           = current_directory;
    oData.file_id           = file_id;
    
    var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/deletefile';
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {
						 
						 	document.getElementById('light6').style.display='none';
	                        document.getElementById('fade').style.display='none';

                           jQuery(".msg").css('display','block');
                           jQuery(".msg").text(data.msg); 
                           jQuery('.list'+li_count).css('display','none');  
						 setTimeout(function () {
							 jQuery('.msg').text('');
							 jQuery('.msg').css('display','none');
						 }, 2500); 
					 },
					   error: function(e){ // alert('Error: '+e); 
						    }  
					}); 
    
	
});
jQuery('body').on('click', '.dir_delete', function(event){ 
	
	document.getElementById('light7').style.display='block';
	document.getElementById('fade').style.display='block';
	jQuery('.delete_dir_name').val(jQuery(this).attr('dir-name'));
	jQuery('.delete_dir_li_count').val(jQuery(this).attr('li-count'));
});	


jQuery('body').on('click', '.yes_dir_delete', function(event){
	var dir_name = jQuery('.delete_dir_name').val();
	var li_count = jQuery('.delete_dir_li_count').val();
    var current_directory = jQuery('.current_directory').val();
    var oData       = new Object();
    oData.dir_name        = dir_name;
    oData.current_directory           = current_directory;
    
    var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/deletedir';
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {
						 	document.getElementById('light7').style.display='none';
	                        document.getElementById('fade').style.display='none';
                          jQuery(".msg").css('display','block');
                           jQuery(".msg").text(data.msg); 
                           jQuery('.list'+li_count).css('display','none');  
						 setTimeout(function () {
							 jQuery('.msg').text('');
							 jQuery('.msg').css('display','none');
						 }, 2500); 
					 },
					   error: function(e){  //alert('Error: '+e); 
						    }  
					}); 
});

jQuery('body').on('click', '.dir_rename', function(event){ 
	
	document.getElementById('light3').style.display='block';
	document.getElementById('fade').style.display='block';
	jQuery('.old_name').val(jQuery(this).attr('dir-name'));
	jQuery('.new_name').val(jQuery(this).attr('dir-name'));
	var li_count = jQuery(this).attr('li-count');
	jQuery('.rename_li_count').val(li_count);
		window.scrollTo(0, 0);
});	

jQuery('body').on('click', '.file_rename', function(event){ 
	
	document.getElementById('light3').style.display='block';
	document.getElementById('fade').style.display='block';
	jQuery('.old_name').val(jQuery(this).attr('file-name'));
	jQuery('.file_id').val(jQuery(this).attr('file-id'));
	var li_count = jQuery(this).attr('li-count');
	jQuery('.rename_li_count').val(li_count);
	
	var oData       = new Object();
	oData.file_id       = jQuery(this).attr('file-id');
	
	var host	=	window.location.host;
	url= '<?php echo $this->baseUrl()?>' + '/user/index/getfiledata';
	
	jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {

						
						jQuery('.new_name').val(data.filetitle);

					 },
					   error: function(e){ // alert('Error: '+e);  
						   }  
					}); 

	window.scrollTo(0, 0);
});	
jQuery('body').on('click', '.rename', function(event){ 
	

	var new_name = jQuery('.new_name').val(); 
	var old_name = jQuery('.old_name').val(); 
	var file_id = jQuery('.file_id').val(); 
	var current_directory     = jQuery('.current_directory').val(); 
	var li_count = jQuery('.rename_li_count').val(); 
	var oData       = new Object();
    oData.new_name       = new_name;
    oData.old_name       = old_name;
    oData.current_directory       = current_directory;
    oData.file_id       = file_id;
    jQuery(".rename_err_msg").text('');
    if(new_name != ''){
     
    var  root_dirname  = '<?php echo $root_dirname; ?>';
    var host	=	window.location.host;
     var file_path = '<?php echo $this->baseUrl()?>' + '/filemanager/' + root_dirname +'/'+current_directory+'/'+new_name;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/renamefile';
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {
						 
						document.getElementById('light3').style.display='none';
	                    document.getElementById('fade').style.display='none';
	
						 
						  
						 jQuery('.old_name').val('');
						 jQuery('.new_name').val('');
                         jQuery(".msg").css('display','block');
                           jQuery(".msg").text(data.msg);
                          
                           if(data.type=='dir') {
                           jQuery( ".list"+li_count).html('<a href="javascript:void(0)" class="dir_open" dir-name="'+new_name+'" ><img src="/application/modules/User/externals/images/document_folder.svg">&nbsp;&nbsp;'+new_name+'</a><span class="option_links"><a href="javascript:void(0)" dir-name="'+new_name+'" li-count="'+li_count+'" class="dir_rename">Rename</a> |<a href="javascript:void(0)" dir-name="'+li_count+'" li-count="'+li_count+'" class="dir_delete">Delete</a></span><hr>');
					    }
					    else{
							file_path = '<?php echo $this->baseUrl()?>' + '/filemanager/' +data.file_path;
							if(data.is_image == 1){
								jQuery( ".list"+li_count).html('<a href="'+file_path+'" class="file_link1" file-id="'+data.file_id+'" data-lightbox="image1" target="_blank"><img src="/application/modules/User/externals/images/document_file.svg">&nbsp;&nbsp;'+ new_name +'</a><span class="option_links"><a href="javascript:void(0)" file-name="'+old_name+'" li-count="'+li_count+'" file-id="'+data.file_id+'" class="file_details">Details</a> | <a href="javascript:void(0)" file-name="'+old_name+'" li-count="'+li_count+'" file-id="'+data.file_id+'" class="file_share">Share</a> | <a href="javascript:void(0)" file-name="'+new_name+'" li-count="'+li_count+'" file-id="'+data.file_id+'" class="file_rename">Rename</a> |  <a href="javascript:void(0)" class="file_copy" file-name="'+new_name+'" li-count="'+li_count+'" file-id="'+file_id+'">Copy</a> | <a href="javascript:void(0)" file-name="'+old_name+'" li-count="'+li_count+'" file-id="'+data.file_id+'" class="file_delete">Delete</a></span><hr>');
							}
							else{
							
							jQuery( ".list"+li_count).html('<a href="'+file_path+'" class="file_link1" file-id="'+data.file_id+'" target="_blank"><img src="/application/modules/User/externals/images/document_file.svg">&nbsp;&nbsp;'+ new_name +'</a><span class="option_links"><a href="javascript:void(0)" file-name="'+old_name+'" li-count="'+li_count+'" file-id="'+data.file_id+'" class="file_details">Details</a> | <a href="javascript:void(0)" file-name="'+old_name+'" li-count="'+li_count+'" file-id="'+data.file_id+'" class="file_share">Share</a> | <a href="javascript:void(0)" file-name="'+old_name+'" li-count="'+li_count+'" file-id="'+data.file_id+'" class="file_rename">Rename</a> |  <a href="javascript:void(0)" class="file_copy" file-name="'+new_name+'" li-count="'+li_count+'" file-id="'+file_id+'">Copy</a> | <a href="javascript:void(0)" file-name="'+new_name+'" li-count="'+li_count+'" file-id="'+data.file_id+'" class="file_delete">Delete</a></span><hr>');
						 } 
						
						
						}
						 setTimeout(function () {
							 jQuery('.msg').text('');
							 jQuery('.msg').css('display','none');
						 }, 2500); 
					 },
					   error: function(e){ // alert('Error: '+e);  
						   }  
					}); 		
	}
	else{
		
		jQuery(".rename_err_msg").text('Please fill the field.');
	}

});	



jQuery('body').on('click', '.dir_share', function(event){ 
	
	document.getElementById('light4').style.display='block';
	document.getElementById('fade').style.display='block';
	jQuery('.share_dir_name').val(jQuery(this).attr('dir-name'));
	
});
jQuery('body').on('click', '.file_share', function(event){ 

	jQuery('.share_dir_name').val(jQuery(this).attr('file-name'));
	jQuery('.share_file_id').val(jQuery(this).attr('file-id'));
	
	var file_id = jQuery(this).attr('file-id');
	var oData       = new Object();
	oData.file_id            = file_id; 
	
	var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/getuserstoshare';
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {
                      jQuery('#light4').html('');
						    jQuery('#light4').append(data.html);
						 var is_users = parseInt(jQuery(".users_to_check_div li").length); 
						 if(data.status == 'no matching users'){
							 
							 jQuery('.share_popup_label_div').html('');
							 jQuery('.share_popup_label_div').append('You have no matches to share the document with');
							 jQuery('#light4 .share_document').css('display','none');
							 
						 }
						 else{
						 if(is_users == 0){
							 jQuery('.share_popup_label_div').html('');
							 jQuery('.share_popup_label_div').append('You have already shared this document with all your match');
							 jQuery('#light4 .share_document').css('display','none');
						 }
					 }  
                        	document.getElementById('light4').style.display='block';
	                        document.getElementById('fade').style.display='block';
	                        jQuery('#light4 .popup_content').prepend('<div class="share_err_msg" style="color:red"></div>');
					 },
					   error: function(e){ // alert('Error: '+e);  
						   }  
					}); 
});
jQuery('body').on('click', '.share_document', function(event){ 
	var current_directory = jQuery('.current_directory').val(); 
	var share_dir_name = jQuery('.share_dir_name').val(); 
	var share_file_id     = jQuery('.share_file_id').val(); 
	
	if (jQuery('.recievers:checked').length) {
          var chkId = '';
          jQuery('.recievers:checked').each(function () {
            chkId += jQuery(this).val() + ",";
          });
          chkId = chkId.slice(0, -1);  
    }
    var reciever_ids =  chkId;   
    var oData       = new Object();
    oData.share_dir_name          = share_dir_name;
    oData.current_directory       = current_directory;
    oData.reciever_ids            = reciever_ids;
    oData.share_file_id            = share_file_id;
    
    var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>'+ '/user/index/sharedocument';
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {
						 
						 if(data.status == true){
                          	document.getElementById('light4').style.display='none';
	                        document.getElementById('fade').style.display='none';
                          jQuery(".msg").css('display','block');
                           jQuery(".msg").text(data.msg);  
						 setTimeout(function () {
							 jQuery('.msg').text('');
							 jQuery('.msg').css('display','none');
						 }, 2500); 
					  }
					  else{
						  
						  jQuery(".share_err_msg").css('display','block');
                           jQuery(".share_err_msg").text(data.msg);  
						 setTimeout(function () {
							 jQuery('.share_err_msg').text('');
							 jQuery('.share_err_msg').css('display','none');
						 }, 2500); 
					  }
					 },
					   error: function(e){ // alert('Error: '+e);  
						   }  
					}); 
       
	
});

jQuery('body').on('click', '.file_link', function(event){ 
	
	var file_id = jQuery(this).attr('file-id');
	var oData       = new Object();
    oData.file_id          = file_id;
	var host	=	window.location.host;
	url= '<?php echo $this->baseUrl()?>' + '/user/index/documentfile';
	
	jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {
                            jQuery('#light5').html('');
						    jQuery('#light5').append(data.html);
                        	document.getElementById('light5').style.display='block';
	                        document.getElementById('fade').style.display='block';

					 },
					   error: function(e){  //alert('Error: '+e); 
						    }  
					}); 

});
jQuery('body').on('click', '.file_details', function(event){ 
	
	var file_id = jQuery(this).attr('file-id');
	var oData       = new Object();
    oData.file_id          = file_id;
	var host	=	window.location.host;
	url= '<?php echo $this->baseUrl()?>' + '/user/index/documentfile';
	
	jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {
                            jQuery('#light5').html('');
						    jQuery('#light5').append(data.html);
                        	document.getElementById('light5').style.display='block';
	                        document.getElementById('fade').style.display='block';

					 },
					   error: function(e){  //alert('Error: '+e); 
						    }  
					}); 

});

jQuery('body').on('click', '.revoke_access', function(event){ 
	
	var file_id = jQuery(this).attr('file-id');
	var user_id = jQuery(this).attr('user-id');
	var li_count = jQuery(this).attr('li-count');
	
	var oData       = new Object();
    oData.file_id          = file_id;
    oData.user_id          = user_id;
	var host	=	window.location.host;
	url= '<?php echo $this->baseUrl()?>' + '/user/index/revokefileaccess';
	
	jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {

						 jQuery('.li_count_'+li_count).css('display','none');    

					 },
					   error: function(e){ // alert('Error: '+e);  
						   }  
					}); 

});



jQuery('body').on('click', '.revoke_access_btn', function(event){ 

	var file_id = jQuery(this).attr('file-id');
	var oData       = new Object();
	oData.file_id            = file_id; 
	
	var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/getsharedusers';
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {
						     document.getElementById('light5').style.display='none';
	                         document.getElementById('fade').style.display='none'; 
                      jQuery('#light8').html('');
						    jQuery('#light8').append(data.html);
                        	document.getElementById('light8').style.display='block';
	                        document.getElementById('fade').style.display='block';
					 },
					   error: function(e){ // alert('Error: '+e);  
						   }  
					}); 
});
jQuery('body').on('click', '.revoke_access_action', function(event){ 
	
	
	var file_id = jQuery(this).attr('file-id');
	if (jQuery('.recievers:checked').length) {
          var chkId = '';
          jQuery('.recievers:checked').each(function () {
            chkId += jQuery(this).val() + ",";
          });
          chkId = chkId.slice(0, -1);  
    }
    var reciever_ids =  chkId;   
	
	
	var oData       = new Object();
	oData.file_id            = file_id; 
	oData.reciever_ids            = reciever_ids; 
	
	var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/revokefileaccess';
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {
						 if(reciever_ids == undefined){
							 
						 jQuery(".revoke_err_msg").css('display','block');
                          jQuery('.revoke_err_msg').text('Please select users to revoke their file access permission');
						 setTimeout(function () {
							 jQuery('.revoke_err_msg').text('');
							 jQuery('.revoke_err_msg').css('display','none');
						 }, 2500);
							 
							 
						 }else{
						 
						  document.getElementById('light8').style.display='none';
	                      document.getElementById('fade').style.display='none';

                          jQuery(".msg").css('display','block');
                          jQuery('.msg').text('Succesfully revoked file access');
						 setTimeout(function () {
							 jQuery('.msg').text('');
							 jQuery('.msg').css('display','none');
						 }, 2500); 
					 }
					 },
					   error: function(e){ // alert('Error: '+e);  
						   }  
					}); 
});


jQuery('body').on('click', '.file_copy', function(event){ 

	var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/getfolders';
			  jQuery.ajax({
						url:  url,										
						dataType: 'json',
						type: 'POST',
					 success: function (data) {
			jQuery('.main_content_copy_popup').html('');
			jQuery('.main_content_copy_popup').append(data.html);			 
			document.getElementById('light9').style.display='block';
	        document.getElementById('fade').style.display='block';
					 },
					   error: function(e){ // alert('Error: '+e);  
						   }  
					}); 
	jQuery('.copy_file_name').val(jQuery(this).attr('file-name'));
	jQuery('.copy_li_count').val(jQuery(this).attr('li-count'));
	jQuery('.copy_file_id').val(jQuery(this).attr('file-id'));


	
});	

jQuery('body').on('click', '.yes_file_copy', function(event){ 
	
	
	var file_id     = jQuery('.copy_file_id').val(); 
	var destination = jQuery('.destination').val();  
	var oData       = new Object();
	oData.file_id            = file_id; 
	oData.destination            = destination; 
	
	if(destination != ''){
	
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
				}
    else{
						  jQuery(".copy_err_msg").css('display','block');
                          jQuery('.copy_err_msg').text('Please select destination to copy file');
						 setTimeout(function () {
							 jQuery('.copy_err_msg').text('');
							 jQuery('.copy_err_msg').css('display','none');
						 }, 2500); 
		
	}
});

jQuery('body').on('click', '.back_file_btn', function(event){
	
	 var current_directory = jQuery(this).attr('cur_dir');
	 
	 var oData       = new Object();
	 oData.menu_open                   = 0;
	 oData.current_directory           = current_directory;
	 oData.rootdir           = '<?php echo $root_dirname; ?>';
	 if(current_directory !='' && current_directory !='/'){		 
	 var host	=	window.location.host;
     var url	=	'<?php echo $this->baseUrl()?>' + '/user/edit/getparentdirectorycontents';
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {
                    jQuery( ".dir_content ul").html(data.html);
                    jQuery( ".menu_bar_2").css('display','block');
                    if(current_directory !='/'){
                    jQuery( ".menu_bar_2_menus").html('<span><a href="javascript:void(0)" onClick="window.location.reload( true );"> Documents </a>'+data.cur_dir_menu+'</span>');
				    }
				    else{
					jQuery( ".menu_bar_2_menus").html('<span><a href="javascript:void(0)" onClick="window.location.reload( true );"> Documents </a></span>');
				    }
                    jQuery('.current_directory').val(data.cur_dir);             
                    jQuery('.cur_dir').val(data.cur_dir);   
                    
                    jQuery(".back_file_btn").attr("cur_dir",data.par_dir);       
					 },
					   error: function(e){  //alert('Error: '+e);  
						   }  
					});    
    }
    else{		
		location.href='<?php echo $this->baseUrl().'/documents'?>';		
	}	
});


</script>
<script src="/application/modules/User/externals/scripts/message_notififaction.js"></script>
<script>
<?php $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); ?>

var viewer_identity='<?php echo $viwer_id; ?>';	
</script>
