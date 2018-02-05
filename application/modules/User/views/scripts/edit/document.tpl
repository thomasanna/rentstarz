<?php   $viewer = Engine_Api::_()->user()->getViewer(); 
$root_dirname =   $viewer->getIdentity().'_'.$viewer->displayname;  ?>
<div class="headline">
  <h2>
    <?php if ($this->viewer->isSelf($this->user) ):?>
      <?php echo $this->translate('Edit My Profile');?>
    <?php else:?>
      <?php echo $this->translate('%1$s\'s Profile', $this->htmlLink($this->user->getHref(), $this->user->getTitle()));?>
    <?php endif;?>
  </h2>
  <div class="tabs">
    <?php
      // Render the menu
      echo $this->navigation()
        ->menu()
        ->setContainer($this->navigation)
        ->render();
    ?>
  </div>
</div>
 <div class="generic_layout_container layout_left">
<?php
echo $this->content()->renderWidget('user.home-photo');
echo $this->content()->renderWidget('user.home-links');
?>
</div>
 <div class="generic_layout_container layout_middle">
<?php //echo $this->form->render($this); ?>
<input type="hidden" class="current_directory" value="">
<div class="msg" style="display:none"></div>
<div class="menu_bar_1">
<button class="new_folder_btn">Create Folder</button>
<button class="upload_file_btn">Upload FIle</button>
</div>
<div class="menu_bar_2">
<div class="menu_bar_2_menus"><span>Documents</span></div>

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
	<li class="file_li list<?php echo $i;?>" file-name="<?php echo $dir['filename'] ;?>"><a href="<?php echo $this->baseUrl().'/filemanager/'.$root_dirname.'/'.$dir['filename'];?>" target="_blank"><?php echo $dir['filename'] ;?></a>
	<span class="option_links">
		<a href="javascript:void(0)" file-name="<?php echo $dir['filename'] ;?>" li-count="<?php echo $i;?>" class="file_share">Share</a> |
		<a href="javascript:void(0)" file-name="<?php echo $dir['filename'] ;?>" li-count="<?php echo $i;?>" class="file_rename">Rename</a> |
		<a href="javascript:void(0)" file-name="<?php echo $dir['filename'] ;?>" li-count="<?php echo $i;?>" class="file_delete">Delete</a>
	</span>
	<hr>
	</li>
	
	<?php $i=$i+1; endforeach; ?>
	
	</ul>

</div>


<!-- New folder popup ------>
<div id="light" class="white_content"><div class="folder_name_input"><input type="text" class="folder_name">
<input type="hidden" class="cur_dir" value=""></div>
<span class="confirm_btns"><button class="create_folder">Create folder</button></span>
<span class="confirm_btns"><button class="cancel">Cancel</button></span> </div>
<div id="fade" class="black_overlay"></div>

<!-- ne file popup ------>
<div id="light1" class="white_content">
<form method="POST" enctype="multipart/form-data" action="<?php echo $this->baseurl('user/edit/savefile'); ?>" class="file_upload_frm">
<div class="folder_name_input">
<div>Title</div>	<input type="text" class="upload_file_title" name="upload_file_title">
<input type="file" class="upload_files" name="upload_files">
<input type="hidden" class="cur_dir" value="" name="cur_dir"></div>
<span class="confirm_btns"><input type="submit" value="Submit" class="file_upload_submit_btn"></span>
<span class="confirm_btns"><button class="cancel_upload">Cancel</button></span>
</form>
 </div>
<div id="fade" class="black_overlay"></div>


<!-- rename popup ------>
<div id="light3" class="white_content">New Name<div class="folder_name_input"><input type="text" class="new_name">
<input type="hidden" class="cur_dir" value="">
<input type="hidden" class="old_name" value="">
<input type="hidden" class="rename_li_count" value="">
</div>
<span class="confirm_btns"><button class="rename">Rename</button></span>
<span class="confirm_btns"><button class="cancel">Cancel</button></span> </div>
<div id="fade" class="black_overlay"></div>

<!-- share popup ------>
<div id="light4" class="white_content">
<input type="hidden" class="share_dir_name" value="">	
	<div><h2>Select Landlords</h2></div>
	<?php foreach($this->requestApprovedLandlords as $lanlords):?>
	<label><input type="checkbox" name="landlords[]" class="landlords" value="<?php echo $lanlords['landlord_id']?>" /> <?php echo $lanlords['displayname']?></label>
	<?php endforeach;?>
	
<div>
<span class="confirm_btns"><button class="share_document">Share</button></span>
<span class="confirm_btns"><button class="cancel">Cancel</button></span>
</div>
</div>
<div id="fade" class="black_overlay"></div>






























</div>
<script type="text/javascript">

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
	document.getElementById('fade').style.display='block';
});

jQuery('body').on('click', '.cancel', function(event){
	
	document.getElementById('light').style.display='none';
	document.getElementById('light3').style.display='none';
	document.getElementById('light4').style.display='none';
	document.getElementById('fade').style.display='none';
	
});
jQuery('body').on('click', '.create_folder', function(event){
    document.getElementById('light').style.display='none';
	document.getElementById('fade').style.display='none'; 
	
	var folder_name = jQuery('.folder_name').val(); 
	var cur_dir     = jQuery('.cur_dir').val(); 
	var li_count = parseInt(jQuery(".ul_list li").length); 
	var oData       = new Object();
    oData.folder_name       = folder_name;
    oData.cur_dir           = cur_dir;
    oData.li_count           = li_count;
    
    var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/createdirectory';
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					    success: function (data) {
                           jQuery(".msg").css('display','block');
                           jQuery(".msg").text(data.msg);
                           jQuery( ".dir_content ul").append(data.content);
                           setTimeout(function () {
							 jQuery('.msg').text('');
							 jQuery('.msg').css('display','none');
						 }, 2500); 
                                
					 },
					   error: function(e){  alert('Error: '+e);  }  
					}); 

	
});

jQuery('body').on('click', '.upload_file_btn', function(event){
	document.getElementById('light1').style.display='block';
	document.getElementById('fade').style.display='block';
});
jQuery('body').on('click', '.cancel_upload', function(event){
	
	document.getElementById('light1').style.display='none';
	document.getElementById('fade').style.display='none';
	
});

jQuery('body').on('click', '.cancel_upload', function(event){
	
	document.getElementById('light1').style.display='none';
	document.getElementById('fade').style.display='none';
	
});


jQuery(".file_upload_frm").on('submit',(function(e){
e.preventDefault();
 var li_count = parseInt(jQuery(".ul_list li").length)+1; 
 var host	=	window.location.host;
 var filepath = jQuery('.upload_files').val();
 var filename = jQuery('input[type=file]').val().split('\\').pop();
 var current_directory = jQuery('.current_directory').val();
 var  root_dirname  = '<?php echo $root_dirname; ?>';
 var file_path = '<?php echo $this->baseUrl()?>' + '/filemanager/' + root_dirname +'/'+current_directory+'/'+filename;
 var url	=	'<?php echo $this->baseUrl()?>' + '/user/edit/savefile';
	jQuery.ajax({
	url: url,
	type: "POST",
	data:  new FormData(this),
	contentType: false,
	cache: false,
	processData:false,
	success: function(data){console.log(data); 
	//var filename= data.replace(/\"/g, "");
	document.getElementById('light1').style.display='none';
	document.getElementById('fade').style.display='none';
	if(data == 'true'){
	jQuery( ".dir_content ul").append('<li class="file_li list'+li_count+'" file-name="'+filename+'"><a href="'+file_path+'" target="_blank">'+filename+'</a><span class="option_links"><a href="javascript:void(0)" file-name="'+filename+'" li-count="'+li_count+'" class="file_share">Share</a> |<a href="javascript:void(0)" class="file_rename" file-name="'+filename+'" li-count="'+li_count+'">Rename</a> | <a href="javascript:void(0)" class="file_delete" file-name="'+filename+'" li-count="'+li_count+'">Delete</a></span><hr></li>');
    jQuery(".msg").css('display','block');
                           jQuery(".msg").text('File is successfully uploaded.');  
						 setTimeout(function () {
							 jQuery('.msg').text('');
							 jQuery('.msg').css('display','none');
						 }, 2500); 
    
    }
    else{
		jQuery(".msg").css('display','block');
                           jQuery(".msg").text('Sorry, only PDF files are allowed.');  
						 setTimeout(function () {
							 jQuery('.msg').text('');
							 jQuery('.msg').css('display','none');
						 }, 2500); 
		
	}
	},
	error: function(){} 	        
	});
}));


jQuery('body').on('click', '.dir_open', function(event){
   
    var dirname = jQuery(this).attr('dir-name');
    var current_directory = jQuery('.current_directory').val();
    
    var oData       = new Object();
    oData.dirname       = dirname;
    oData.current_directory           = current_directory;
    
    var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/edit/getdirectorycontents';
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {

                    jQuery( ".dir_content ul").html(data.html);
                    jQuery( ".menu_bar_2_menus").html('<span> Documents '+data.cur_dir_menu+'</span>');
                    jQuery('.current_directory').val(data.cur_dir);             
                    jQuery('.cur_dir').val(data.cur_dir);             
					 },
					   error: function(e){  alert('Error: '+e);  }  
					}); 
					

					
});


jQuery('body').on('click', '.file_delete', function(event){
	
	var file_name = jQuery(this).attr('file-name');
	var li_count = jQuery(this).attr('li-count');
    var current_directory = jQuery('.current_directory').val();
    var oData       = new Object();
    oData.file_name        = file_name;
    oData.current_directory           = current_directory;
    
    var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/edit/deletefile';
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
					   error: function(e){  alert('Error: '+e);  }  
					}); 
    
	
});


jQuery('body').on('click', '.dir_delete', function(event){
	var dir_name = jQuery(this).attr('dir-name');
	var li_count = jQuery(this).attr('li-count');
    var current_directory = jQuery('.current_directory').val();
    var oData       = new Object();
    oData.dir_name        = dir_name;
    oData.current_directory           = current_directory;
    
    var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/edit/deletedir';
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
					   error: function(e){  alert('Error: '+e);  }  
					}); 
    
    
    
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
	var li_count = jQuery(this).attr('li-count');
	jQuery('.rename_li_count').val(li_count);
	
});	
jQuery('body').on('click', '.rename', function(event){ 
	
    document.getElementById('light3').style.display='none';
	document.getElementById('fade').style.display='none';
	
	var new_name = jQuery('.new_name').val(); 
	var old_name = jQuery('.old_name').val(); 
	var current_directory     = jQuery('.current_directory').val(); 
	var li_count = jQuery('.rename_li_count').val(); 
	var oData       = new Object();
    oData.new_name       = new_name;
    oData.old_name       = old_name;
    oData.current_directory       = current_directory;
    
     var  root_dirname  = '<?php echo $root_dirname; ?>';
    var host	=	window.location.host;
     var file_path = '<?php echo $this->baseUrl()?>' + '/filemanager/' + root_dirname +'/'+current_directory+'/'+new_name;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/edit/renamefile';
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
							jQuery( ".list"+li_count).html('<a href="'+file_path+'" target="blank">'+ new_name +'</a><span class="option_links"><a href="javascript:void(0)" file-name="'+new_name+'" li-count="'+li_count+'" class="file_share">Share</a> | <a href="javascript:void(0)" file-name="'+new_name+'" li-count="'+li_count+'" class="file_rename">Rename</a> |<a href="javascript:void(0)" file-name="'+li_count+'" li-count="'+li_count+'" class="file_delete">Delete</a></span><hr>');
	
						}
						 setTimeout(function () {
							 jQuery('.msg').text('');
							 jQuery('.msg').css('display','none');
						 }, 2500); 
					 },
					   error: function(e){  alert('Error: '+e);  }  
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
});


jQuery('body').on('click', '.share_document', function(event){ 
	
	document.getElementById('light4').style.display='none';
	document.getElementById('fade').style.display='none';
	var share_dir_name = jQuery('.share_dir_name').val(); 
	var current_directory     = jQuery('.current_directory').val(); 
	
	if (jQuery('.landlords:checked').length) {
          var chkId = '';
          jQuery('.landlords:checked').each(function () {
            chkId += jQuery(this).val() + ",";
          });
          chkId = chkId.slice(0, -1);  
    }
    var landlord_ids =  chkId;   
    var oData       = new Object();
    oData.share_dir_name          = share_dir_name;
    oData.current_directory       = current_directory;
    oData.landlord_ids            = landlord_ids;
    
    var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/edit/sharedocument';
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
					   error: function(e){  alert('Error: '+e);  }  
					}); 
       
	
});
</script>
