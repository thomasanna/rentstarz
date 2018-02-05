<script src="/application/modules/User/externals/scripts/message_notififaction.js"></script>
<link href="/application/modules/User/externals/styles/lightbox.min.css" rel="stylesheet" type="text/css">

<?php   
$viewer = Engine_Api::_()->user()->getViewer(); 
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
<div class="document_list_content generic_layout_container layout_middle">



<input type="hidden" class="current_directory" value="">
<div class="msg" style="display:none"></div>
<div class="menu_bar_1">
	<button class="back_file_btn" cur_dir="" style="width: 104px;display:none">Back</button>
</div>
<div class="menu_bar_2" style="display:none;padding: 12px;">
  <div class="menu_bar_2_menus"><span></span></div>

</div>



	<div class="document_list">
	<?php if(count($this->files['directories']) == 0 && count($this->files['files']) == 0):?>
	  <div class="notfound" style="text-align: center;">No documents yet</div>
	<?php else:?>
	
	<ul class="ul_list">
	<?php $i=1; ?>	
	<?php foreach($this->files['directories'] as $dir):  ?>
	<li class="dir_li list<?php echo $i;?>" dir-name="<?php echo $dir['dirname'] ;?>"><a href="javascript:void(0)" class="dir_open" dir-name="<?php echo $dir['dirname'] ;?>" ><img src="/application/modules/User/externals/images/document_folder.svg">&nbsp;&nbsp;<?php echo $dir['dirname'] ;?></a>
	<span class="option_links">
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
	</span>
	<hr>
	</li>
	
	<?php $i=$i+1; endforeach; ?>
	
	</ul>
	<?php endif;?>

	</div>
</div>

<script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/scripts/lightbox-plus-jquery.min.js"></script>

<script>
	
	jQuery('#global_header').append('<div class="affix-top extra_header mob_bar_disable_particular_pages" data-spy="affix" data-offset-top="100">'+
	'<div id="global_content">'+
	'<div class="extra_header_content">'+
	
	'<ul class="navigation">'+
    '<li><a href="/documents">My Documents</a></li>'+
    '<li><a href="/documents/sharedwithme">Documents shared with me</a></li>'+
    '<li><a href="/documents/requests">Document requests</a></li>'+
      <?php if(($package_type !='' &&  $profile_type_id == 4 ) || ($user_premiumLevelProvision == 1 &&  $profile_type_id == 4)):?>
    '<li class="active"><a href="/documents/special">Special documents</a></li>'+
    <?php endif;?>
    '</ul>'+
    '</ul>'+
    
	'</div>'+
	'</div>'+
	'</div>');
	jQuery('.sub_header_dropdown').html(
                   '<select id = "sub_header_heding_select" class="input-box">'+
                   ' <option  value="documents">My Documents</option>'+
                   ' <option  value="documents/sharedwithme">Documents shared with me</option>'+
                   ' <option  value="documents/requests">Document requests</option>'+
                   ' <option selected value="documents/special">Special documents</option>'+
                   ' </select>'
    );

jQuery(document).on('change','#sub_header_heding_select',function(){
	 location.href=jQuery('#sub_header_heding_select').val();
});
	
jQuery('body').on('click', '.dir_open', function(event){
  
    var dirname = jQuery(this).attr('dir-name');
    var current_directory = jQuery('.current_directory').val(); 
    
    var oData       = new Object();
    oData.dirname       = dirname;
    oData.current_directory           = current_directory; 
    oData.menu_open           = 0;
    oData.rootdir           = 'specialdocuments';
   // alert(current_directory);
    var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/getspecialdocumentdirectorycontents';
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {
				    jQuery( ".back_file_btn").css('display','block');
                    jQuery( ".document_list ul").html('');
                    jQuery( ".document_list ul").html(data.html);
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
    oData.rootdir           = 'specialdocuments';
   // alert(current_directory);
    var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/getspecialdocumentdirectorycontents';
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

jQuery('body').on('click', '.back_file_btn', function(event){
	
	 var current_directory = jQuery(this).attr('cur_dir');
	 
	 var oData       = new Object();
	 oData.menu_open                   = 0;
	 oData.current_directory           = current_directory;
	 oData.rootdir           = 'specialdocuments';
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
		location.href='<?php echo $this->baseUrl().'/documents/special'?>';		
	}	
});
</script>
