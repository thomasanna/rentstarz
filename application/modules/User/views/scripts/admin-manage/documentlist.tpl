<h2>
  <?php echo $this->translate("Documents Of ").$this->username; ?>
  <?php $viewer     = Engine_Api::_()->user()->getViewer(); ?>
</h2>

<input type="hidden" class="current_directory" value="">
<div class="msg" style="display:none"></div>
<div class="menu_bar_1">
<button class="new_folder_btn">Create Folder</button>
<button class="upload_file_btn" style="display:none">Upload FIle</button>
<a href="<?php echo $this->url(array('action' => 'documents'));?>">Document list</a>
</div>
<div class="menu_bar_2" style="display:none">
<div class="menu_bar_2_menus"><span><!--<a href="javascript:void(0)" >Documents</a>--></span></div>

</div>



<div class="dir_content">
	
	<ul class="ul_list">
	<?php $i=1; ?>	
	<?php foreach($this->files['directories'] as $dir):  ?>
	
	<li class="dir_li list<?php echo $i;?>" dir-name="<?php echo $dir['dirname'] ;?>"><a href="javascript:void(0)" class="dir_open" dir-name="<?php echo $dir['dirname'] ;?>" ><?php echo $dir['dirname'] ;?></a>
	<span class="option_links">
		<!--<a href="javascript:void(0)" dir-name="<?php echo $dir['dirname'] ;?>" li-count="<?php echo $i;?>" class="dir_share">Share</a> |-->
		<a href="javascript:void(0)" dir-name="<?php echo $dir['dirname'] ;?>" li-count="<?php echo $i;?>" class="dir_rename">Rename</a> |
		<a href="javascript:void(0)" dir-name="<?php echo $dir['dirname'] ;?>" li-count="<?php echo $i;?>" class="dir_delete">Delete</a>
	</span>
		<hr>
	</li>

	<?php  $i=$i+1; endforeach; ?>
	
	<?php foreach($this->files['files'] as $dir):  ?>
	<li class="file_li list<?php echo $i;?>" file-name="<?php echo $dir['filename'] ;?>"><a href="javascript:void(0)"  class="file_link" file-id="<?php echo $dir['file_id'];?>"><?php echo $dir['file_title'] ;?></a>
	<span class="option_links">
		<a href="javascript:void(0)" file-name="<?php echo $dir['filename'] ;?>" li-count="<?php echo $i;?>" file-id="<?php echo $dir['file_id'];?>" class="file_share">Share</a> |
		<a href="javascript:void(0)" file-name="<?php echo $dir['filename'] ;?>" li-count="<?php echo $i;?>" file-id="<?php echo $dir['file_id'];?>" class="file_rename">Rename</a> |
		<a href="javascript:void(0)" file-name="<?php echo $dir['filename'] ;?>" li-count="<?php echo $i;?>" file-id="<?php echo $dir['file_id'];?>" class="file_delete">Delete</a>
	</span>
	<hr>
	</li>
	
	<?php $i=$i+1; endforeach; ?>
	
	</ul>

</div>

<!-- New folder popup ------>
<div id="light" class="white_content">
<div class="popup_title">Create new folder</div>
<div class="folder_name_input"><input type="text" class="folder_name">
<input type="hidden" class="cur_dir" value=""></div>
<span class="confirm_btns"><button class="create_folder">Create folder</button></span>
<span class="confirm_btns"><button class="cancel">Cancel</button></span> </div>
<div id="fade" class="black_overlay"></div>



<!-- new file popup ------>
<div id="light1" class="white_content">
	<div class="popup_title">Upload new file</div><div class="div_attachment_cancel"><img src="/application/modules/User/externals/images/GREYcancel.png"></div>
	<div class="err_msg" style="color: red;"></div>
	
<form method="POST" enctype="multipart/form-data" action="<?php echo $this->baseurl('user/edit/savefile'); ?>" class="file_upload_frm">
<div class="folder_name_input">
<div>Title</div><div style="margin-bottom: 12px;margin-top: 2px;"><input type="text" class="upload_file_title" name="upload_file_title"></div>
	<input type="file" class="upload_files" name="upload_files">
	<div>only PDF, JPG, JPEG, and PNG files are allowed.</div>
	<input type="hidden" class="user_id" name="user_id">
<input type="hidden" class="cur_dir" value="" name="cur_dir"></div>
<span class="confirm_btns"><input type="submit" value="Submit" class="file_upload_submit_btn"></span>

</form>
<div class="loader" style="display:none;"></div>
 </div>
<div id="fade" class="black_overlay"></div>


<!-- rename popup ------>
<div id="light3" class="white_content">
	<div class="rename_err_msg" style="color: red;"></div>	
	<div class="popup_title">Rename file</div><div class="div_attachment_cancel"><img src="/application/modules/User/externals/images/GREYcancel.png"></div>
	
	New Name<div class="folder_name_input"><input type="text" class="new_name">
<input type="hidden" class="cur_dir" value="">
<input type="hidden" class="old_name" value="">
<input type="hidden" class="file_id" value="">
<input type="hidden" class="rename_li_count" value="">
</div>
<span class="confirm_btns"><button class="rename">Rename</button></span>
</div>
<div id="fade" class="black_overlay"></div>



<!-- list shared users popup ------>
<div id="light5" class="white_content">

</div>

<div id="fade" class="black_overlay"></div>

<!-- share popup ------>
<div id="light4" class="white_content">
<input type="hidden" class="share_dir_name" value="">	
<input type="hidden" class="share_file_id" value="">	

<?php if($this->profiletype == 1): // tenant?>
	<div><h2>Select Users</h2></div>
	<ul>
	<?php foreach($this->requestApprovedLandlords as $lanlords):?>
	<li><label><span class="chk_shared_users"><input type="checkbox" name="recievers[]" class="recievers" value="<?php echo $lanlords['landlord_id']?>" /></span> <?php echo $lanlords['displayname']?></label></li>
	<?php endforeach;?>
	<?php foreach($this->allservices as $data):?>
	<li><label><span class="chk_shared_users"><input type="checkbox" name="recievers[]" class="recievers" value="<?php echo $data['user_id']?>" /></span> <?php echo $data['displayname']?></label></li>
	<?php endforeach;?>
	</ul>
<?php endif;?>	

<?php if($this->profiletype == 4): // landlord?>
	<div><h2>Select Users</h2></div>
	<ul>
	<?php foreach($this->propertyRequestedTenants as $data):?>
	<li><label><span class="chk_shared_users"><input type="checkbox" name="recievers[]" class="recievers" value="<?php echo $data['tenant_id']?>" /></span> <?php echo $data['displayname']?></label></li>
	<?php endforeach;?>
	<?php foreach($this->allservices as $data):?>
	<li><label><span class="chk_shared_users"><input type="checkbox" name="recievers[]" class="recievers" value="<?php echo $data['user_id']?>" /></span> <?php echo $data['displayname']?></label></li>
	<?php endforeach;?>
    </ul>
<?php endif;?>	

<?php if($this->profiletype == 6): // service?>
	<div><h2>Select users</h2></div>
	<ul>
	<?php foreach($this->allusers as $data):?>
	<li><label><span class="chk_shared_users"><input type="checkbox" name="recievers[]" class="recievers" value="<?php echo $data['user_id']?>" /></span> <?php echo $data['displayname']?></label></li>
	<?php endforeach;?>
    </ul>
<?php endif;?>	
<div style="margin-top: 15px;">
<span class="confirm_btns"><button class="share_document" style="width: 99px;">Share</button></span>

</div>
</div>
<div id="fade" class="black_overlay"></div>





<script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/scripts/lightbox-plus-jquery.min.js"></script>
<script>jQuery.noConflict();</script>


<script>


jQuery('body').on('click', '.dir_open', function(event){
	jQuery('.new_folder_btn').hide();
	jQuery('.upload_file_btn').show();
   
    var dirname = jQuery(this).attr('dir-name');
    var current_directory = jQuery('.current_directory').val();
    var user_id ='<?php echo $this->userid;?>'; 
    
    var oData       = new Object();
    oData.dirname       = dirname;
    oData.current_directory           = current_directory;
    oData.user_id           = user_id;
    oData.root_dir           = '<?php echo $this->root_dir;?>';
    oData.menu_open           = 0;
    var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/admin-manage/getdirectorycontents';
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {

                    jQuery( ".dir_content ul").html(data.html);
                     jQuery( ".menu_bar_2").css('display','block');
                    jQuery( ".menu_bar_2_menus").html('<span> <a href="javascript:void(0)" onclick="window.location.reload( true );">Documents</a> '+data.cur_dir_menu+'</span>');
                    jQuery('.current_directory').val(data.cur_dir);             
                    jQuery('.cur_dir').val(data.cur_dir);             
					 },
					   error: function(e){  //alert('Error: '+e); 
						    }  
					}); 
					

					
});
jQuery('body').on('click', '.menu_dir_open', function(event){
   
    var dirname = jQuery(this).attr('dir_path');
   // var current_directory = jQuery('.current_directory').val();
   
    var user_id ='<?php echo $this->userid;?>'; 
    
    var oData       = new Object();
    oData.dirname       = dirname;
    oData.current_directory           = dirname; 
    oData.menu_open           = 1;
    oData.user_id           = user_id;
    oData.root_dir           = '<?php echo $this->root_dir;?>';
   // alert(current_directory);
    var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/admin-manage/getdirectorycontents';
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
					 },
					   error: function(e){  //alert('Error: '+e);  
						   }  
					}); 
					

					
});

jQuery('body').on('click', '.new_folder_btn', function(event){
	document.getElementById('light').style.display='block';
	document.getElementById('fade').style.display='block';
});



jQuery('body').on('click', '.create_folder', function(event){
    document.getElementById('light').style.display='none';
	document.getElementById('fade').style.display='none'; 
	
	var user_id ='<?php echo $this->userid;?>'; 
	var folder_name = jQuery('.folder_name').val(); 
	var cur_dir     = jQuery('.cur_dir').val(); 
	var li_count = parseInt(jQuery(".ul_list li").length); 
	var oData       = new Object();
    oData.folder_name       = folder_name;
    oData.cur_dir           = cur_dir;
    oData.li_count           = li_count;
    oData.user_id           = user_id;
    
    var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/admin-manage/createdirectory';
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {
                           jQuery(".msg").css('display','block');
                           jQuery(".msg").text(data.msg);
                           jQuery(".folder_name").val('');
                           jQuery( ".dir_content ul").append(data.content);
                           setTimeout(function () {
							 jQuery('.msg').text('');
							 jQuery('.msg').css('display','none');
						 }, 2500); 
                                
					 },
					   error: function(e){ // alert('Error: '+e); 
						    }  
					}); 

	
});




jQuery('body').on('click', '.upload_file_btn', function(event){
	document.getElementById('light1').style.display='block';
	document.getElementById('fade').style.display='block';
	var user_id ='<?php echo $this->userid;?>'; 
	jQuery('.user_id').val(user_id);
	var current_directory = jQuery('.current_directory').val(); 
	jQuery('.cur_dir').val(current_directory);
});

jQuery('body').on('click', '.div_attachment_cancel', function(event){
	
	jQuery('.loader').css('display','none');
	jQuery('#light').css('display','none');
	jQuery('#light1').css('display','none');
	jQuery('#light3').css('display','none');
	jQuery('#light4').css('display','none');
	jQuery('#light5').css('display','none');
	jQuery('#light6').css('display','none');
	jQuery('#fade').css('display','none');
	jQuery('#light5').html('');
	jQuery(".rename_err_msg").text('');
	jQuery(".folder_name").val('');
	jQuery('.destination').val('');
	
});



jQuery(".file_upload_frm").on('submit',(function(e){
e.preventDefault();

jQuery('.file_upload_submit_btn').prop('disabled', true);

 var li_count = parseInt(jQuery(".ul_list li").length)+1; 
 var host	=	window.location.host;
 var filepath = jQuery('.upload_files').val(); 
 var filetitle = jQuery('.upload_file_title').val();
 
  jQuery('.loader').css('display','block');

 if(filepath  == ''|| filetitle == ''){
	 
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
 
 var current_directory = jQuery('.current_directory').val();
 var root_dirname  = '<?php echo $root_dirname; ?>';
 var file_path = '<?php echo $this->baseUrl()?>' + '/filemanager/' + root_dirname +'/'+current_directory+'/'+filename;
 var url	=	'<?php echo $this->baseUrl()?>' + '/user/admin-manage/savefile';
	jQuery.ajax({
	url: url,
	type: "POST",
	data:  new FormData(this),
	contentType: false,
	cache: false,
	processData:false,
	success: function(data){console.log(data); 
	//var filename= data.replace(/\"/g, "");

	if(data != ' '){var fileid= data.replace(/\"/g, ""); 
		
	//jQuery( ".dir_content ul").append('<li class="file_li list'+li_count+'" file-name="'+filename+'" ><a href="javascript:void(0)" target="_blank" file-id ="'+fileid+'" class="file_link">'+filetitle+'</a><span class="option_links"><a href="javascript:void(0)" file-name="'+filename+'" li-count="'+li_count+'" file-id="'+fileid+'" class="file_share">Share</a> |<a href="javascript:void(0)" class="file_rename" file-name="'+filename+'" li-count="'+li_count+'" file-id="'+fileid+'">Rename</a> | <a href="javascript:void(0)" class="file_delete" file-name="'+filename+'" li-count="'+li_count+'" file-id ="'+fileid+'">Delete</a></span><hr></li>');
	var res = fileid.split("_"); 
	var file_id = res['0'];
	var filename = res['1'];
	var file_path = '<?php echo $this->baseUrl()?>' + '/filemanager/' + root_dirname +current_directory+'/'+res['1'];
	
	if(fileExt =='.jpg' || fileExt == '.png' ||  fileExt == '.jpeg'){
		
		
	jQuery( ".dir_content ul").append('<li class="file_li list'+li_count+'" file-name="'+filename+'" ><a href="'+file_path+'" target="_blank" file-id ="'+fileid+'" class="file_link1" data-lightbox="image1">'+filetitle+'</a><span class="option_links"> <a href="javascript:void(0)" file-name="'+filename+'" li-count="'+li_count+'" file-id="'+file_id+'" class="file_share">Share</a> | <a href="javascript:void(0)" class="file_rename" file-name="'+filename+'" li-count="'+li_count+'" file-id="'+file_id+'">Rename</a> | <a href="javascript:void(0)" class="file_delete" file-name="'+filename+'" li-count="'+li_count+'" file-id ="'+file_id+'">Delete</a></span><hr></li>');	
		
	}
	else{
	jQuery( ".dir_content ul").append('<li class="file_li list'+li_count+'" file-name="'+filename+'" ><a href="'+file_path+'" target="_blank" file-id ="'+fileid+'" class="file_link1">'+filetitle+'</a><span class="option_links"> <a href="javascript:void(0)" file-name="'+filename+'" li-count="'+li_count+'" file-id="'+file_id+'" class="file_share">Share</a> | <a href="javascript:void(0)" class="file_rename" file-name="'+filename+'" li-count="'+li_count+'" file-id="'+file_id+'">Rename</a> | <a href="javascript:void(0)" class="file_delete" file-name="'+filename+'" li-count="'+li_count+'" file-id ="'+file_id+'">Delete</a></span><hr></li>');
    }
       jQuery('.file_upload_submit_btn').prop('disabled', false); 
       jQuery('.loader').css('display','block');
	   jQuery("#light1").css('display','none');
	   jQuery("#fade").css('display','none');
    
       jQuery('.upload_file_title').val('');
       jQuery('.upload_files').val(''); 
    
    jQuery(".msg").css('display','block');
                           jQuery(".msg").text('File is successfully uploaded.');  
						 setTimeout(function () {
							 jQuery('.msg').text('');
							 jQuery('.msg').css('display','none');
						 }, 2500); 
    
    }
    else{
		//jQuery(".msg").css('display','block');
                           jQuery(".err_msg").text('Sorry, only PDF, JPG, JPEG, & PNG files are allowed.');  
						 setTimeout(function () {
							 jQuery('.err_msg').text('');
						 }, 2500); 
		
	}
	},
	error: function(){} 	        
	});
	
	
}
}));

jQuery('body').on('click', '.file_delete', function(event){
	
	var file_name = jQuery(this).attr('file-name');
	var li_count = jQuery(this).attr('li-count');
	var file_id = jQuery(this).attr('file-id');
    var current_directory = jQuery('.current_directory').val();
    var user_id ='<?php echo $this->userid;?>'; 
    
    var oData       = new Object();
    oData.file_name        = file_name;
    oData.current_directory           = current_directory;
    oData.file_id           = file_id;
    oData.user_id           = user_id;

    var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/admin-manage/deletefile';
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {

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
	var dir_name = jQuery(this).attr('dir-name');
	var li_count = jQuery(this).attr('li-count');
    var current_directory = jQuery('.current_directory').val();
    var user_id ='<?php echo $this->userid;?>'; 
    var oData       = new Object();
    oData.dir_name        = dir_name;
    oData.current_directory           = current_directory;
    oData.user_id           = user_id;
    
    var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/admin-manage/deletedir';
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {
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

jQuery('body').on('click', '.cancel', function(event){

    jQuery("#fade").css('display','none');
    jQuery("#light").css('display','none');
    jQuery("#light3").css('display','none');
    jQuery("#light4").css('display','none');
    jQuery("#light5").css('display','none');
	
	jQuery('#light5').html('');
	jQuery(".rename_err_msg").text('');
	
});

jQuery('body').on('click', '.cancel_upload', function(event){
	
	document.getElementById('light1').style.display='none';
	document.getElementById('fade').style.display='none';
	jQuery('.err_msg').text('');
	
});



jQuery('body').on('click', '.dir_rename', function(event){ 
	
	document.getElementById('light3').style.display='block';
	document.getElementById('fade').style.display='block';
	jQuery('.old_name').val(jQuery(this).attr('dir-name'));
	var li_count = jQuery(this).attr('li-count');
	jQuery('.rename_li_count').val(li_count);
	
});	

jQuery('body').on('click', '.file_rename', function(event){ 
	
	document.getElementById('light3').style.display='block';
	document.getElementById('fade').style.display='block';
	jQuery('.old_name').val(jQuery(this).attr('file-name'));
	jQuery('.file_id').val(jQuery(this).attr('file-id'));
	var li_count = jQuery(this).attr('li-count');
	jQuery('.rename_li_count').val(li_count);
	
});	



jQuery('body').on('click', '.rename', function(event){ 
	

	
	var user_id ='<?php echo $this->userid;?>'; 
	
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
    oData.user_id       = user_id;
    
     var  root_dirname  = '<?php echo $root_dirname; ?>';
    jQuery(".rename_err_msg").text(' ');
    if(new_name != ''){
		
	document.getElementById('light3').style.display='none';
	document.getElementById('fade').style.display='none';
		
    var host	=	window.location.host;
     var file_path = '<?php echo $this->baseUrl()?>' + '/filemanager/' + root_dirname +'/'+current_directory+'/'+new_name;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/admin-manage/renamefile';
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) { 
						 jQuery('.old_name').val('');
						 jQuery('.new_name').val('');
                         jQuery(".msg").css('display','block');
                           jQuery(".msg").text(data.msg);
                           if(data.type=='dir') {
                           jQuery( ".list"+li_count).html('<a href="javascript:void(0)" class="dir_open" dir-name="'+new_name+'" >'+new_name+'</a><span class="option_links"><a href="javascript:void(0)" dir-name="'+new_name+'" li-count="'+li_count+'" class="dir_rename">Rename</a> |<a href="javascript:void(0)" dir-name="'+li_count+'" li-count="'+li_count+'" class="dir_delete">Delete</a></span><hr>');
					    }
					    else{
							jQuery( ".list"+li_count).html('<a href="javascript:void(0)" class="file_link" file-id="'+data.file_id+'">'+ new_name +'</a><span class="option_links"><a href="javascript:void(0)" file-name="'+old_name+'" li-count="'+li_count+'" file-id="'+data.file_id+'" class="file_share">Share</a> | <a href="javascript:void(0)" file-name="'+old_name+'" li-count="'+li_count+'" file-id="'+data.file_id+'" class="file_rename">Rename</a> |<a href="javascript:void(0)" file-name="'+old_name+'" li-count="'+li_count+'" file-id="'+data.file_id+'" class="file_delete">Delete</a></span><hr>');
	
						}
						 setTimeout(function () {
							 jQuery('.msg').text('');
							 jQuery('.msg').css('display','none');
						 }, 2500); 
					 },
					   error: function(e){  //alert('Error: '+e);
						    }  
					}); 
					
				}
				else{
					
					jQuery(".rename_err_msg").text('Please fill the field.');
				}

});	


jQuery('body').on('click', '.file_link', function(event){ 
	
	var file_id = jQuery(this).attr('file-id');
	var oData       = new Object();
    oData.file_id          = file_id;
	var host	=	window.location.host;
	url= '<?php echo $this->baseUrl()?>' + '/user/admin-manage/documentfile';
	
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
	url= '<?php echo $this->baseUrl()?>' + '/user/admin-manage/revokefileaccess';
	
	jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {

						 jQuery('.li_count_'+li_count).css('display','none');    

					 },
					   error: function(e){  //alert('Error: '+e);
						     }  
					}); 

});


jQuery('body').on('click', '.dir_share', function(event){ 
	
	document.getElementById('light4').style.display='block';
	document.getElementById('fade').style.display='block';
	jQuery('.share_dir_name').val(jQuery(this).attr('dir-name'));
	
});
jQuery('body').on('click', '.file_share', function(event){ 
	
	document.getElementById('light4').style.display='block';
	document.getElementById('fade').style.display='block';
	jQuery('.share_dir_name').val(jQuery(this).attr('file-name'));
	jQuery('.share_file_id').val(jQuery(this).attr('file-id'));
});


jQuery('body').on('click', '.share_document', function(event){ 
	
	document.getElementById('light4').style.display='none';
	document.getElementById('fade').style.display='none';
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
    var user_id ='<?php echo $this->userid;?>'; 
    var oData       = new Object();
    oData.share_dir_name          = share_dir_name;
    oData.current_directory       = current_directory;
    oData.reciever_ids            = reciever_ids;
    oData.share_file_id            = share_file_id;
    oData.user_id                  = user_id;
    
    var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/admin-manage/sharedocument';
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {

                          jQuery(".msg").css('display','block');
                           jQuery(".msg").text(data.msg);  
						 setTimeout(function () {
							 jQuery('.msg').text('');
							 jQuery('.msg').css('display','none');
						 }, 2500); 
					 },
					   error: function(e){  //alert('Error: '+e); 
						    }  
					}); 
       
	
});

function callrootdirectory(){
	
	var dirname = jQuery(this).attr('dir-name');
    var current_directory = "";
    var user_id ='<?php echo $this->userid;?>';     
    var oData       = new Object();
    oData.dirname       = "";
    oData.current_directory           = current_directory;
    oData.user_id           = user_id;
    oData.root_dir           = '<?php echo $this->root_dir;?>';
    
    var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/admin-manage/getdirectorycontents';
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {

                    jQuery( ".dir_content ul").html(data.html);
                    jQuery( ".menu_bar_2_menus").html('<span> <a href="javascript:void(0)" onclick="window.location.reload( true );">Documents</a> </span>');
                    jQuery('.current_directory').val("");             
                    jQuery('.cur_dir').val(data.cur_dir);             
					 },
					   error: function(e){  alert('Error: '+e);  }  
					}); 
					
	
}

</script>
