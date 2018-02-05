<?php 

$viewer = Engine_Api::_()->user()->getViewer();
$subject = Engine_Api::_()->core()->getSubject();
$viewer_id  = Engine_Api::_()->user()->getViewer()->getIdentity();

$root_dirname =   $subject->getIdentity().'_'.$subject->displayname; 

?>
<h4>
            <span></span>
</h4>


<input type="hidden" class="current_directory" value="">
<div class="menu_bar_2"  style="display:none">
<div class="menu_bar_2_menus"><span><!--<a href="javascript:void(0)" >Documents</a></span>--></div>

</div>

<div class="dir_content">
	<?php if(count($this->files['directories']) == 0 && count($this->files['files']) == 0):?>
	
	<div style="text-align: center;">No Documents</div>
	
	<?php else:?>
	
	<ul class="ul_list">
	<?php $i=1; ?>	
	<?php foreach($this->files['directories'] as $dir):  ?>
	<?php $doc_path = $root_dirname .'/'.$dir['dirname'];?>

	<li class="dir_li list<?php echo $i;?>" dir-name="<?php echo $dir['dirname'] ;?>"><a href="javascript:void(0)" class="dir_open" dir-name="<?php echo $dir['dirname'] ;?>" ><img src="/application/modules/User/externals/images/document_folder.svg">&nbsp;&nbsp;<?php echo $dir['dirname'] ;?></a>

		<hr>
	</li>

	<?php  $i=$i+1; endforeach; ?>
	
	<?php foreach($this->files['files'] as $dir):  ?>
    <?php $doc_path = $root_dirname .'/'.$dir['filename'];?>
    
    <?php  $file_name =dirname($_SERVER['SCRIPT_FILENAME']).'/filemanager/'.$doc_path;
        
         if(@is_array(getimagesize($file_name))){
			$is_image = 1;
			}
			else{
				$is_image = 0;
			} 
    
    
    ?>
    
    
    
    <?php if($viewer_id == $subject->getIdentity() ):?>
	<li class="file_li list<?php echo $i;?>" file-name="<?php echo $dir['filename'] ;?>">
	<?php if($is_image == 1):?>
	<a href="/filemanager/<?php echo $doc_path?>" target="_blank" data-lightbox="image1">
	<img src="/application/modules/User/externals/images/document_file.svg">&nbsp;&nbsp;<?php echo $dir['filetitle'] ;?>
	</a>
	<?php else:?>
	<a href="/filemanager/<?php echo $doc_path?>" target="_blank"><?php echo $dir['filetitle'] ;?></a>
	<?php endif;?>
	<?php endif;?>
	
    <?php if($viewer_id != $subject->getIdentity() ):?>
    
     <?php if($dir['is_docRequested'] == 0 ):?>
     <li class="file_li list<?php echo $i;?>" file-name="<?php echo $dir['filename'] ;?>"><?php echo $dir['filetitle'] ;?>
    <span class="document_access_span"><span class="reqst_doc_access_btn docbtn_<?php echo $dir['file_id'];?>" file-id =<?php echo $dir['file_id'];?> doc-path="<?php echo $doc_path;?>" doc-name="<?php echo $dir['filename'];?>">Ask to view</span></span>
   
    <?php elseif($dir['is_docReqApproved'] == 0):?>
    <li class="file_li list<?php echo $i;?>" file-name="<?php echo $dir['filename'] ;?>"><?php echo $dir['filetitle'] ;?>
    <span class="document_access_span"><span class="waiting_for_reqst_btn docbtn_<?php echo $dir['file_id'];?>" file-id =<?php echo $dir['file_id'];?> doc-path="<?php echo $doc_path;?>" doc-name="<?php echo $dir['filename'];?>">Waiting for approval</span></span>

    <?php else:?>
    
    <li class="file_li list<?php echo $i;?>" file-name="<?php echo $dir['filename'] ;?>">
	<?php if($is_image == 1):?>
	<a href="/filemanager/<?php echo $doc_path?>" target="_blank" data-lightbox="image1"><?php echo $dir['filetitle'] ;?></a>
	<?php else:?>
	<a href="/filemanager/<?php echo $doc_path?>" target="_blank"><?php echo $dir['filetitle'] ;?></a>
	<?php endif;?>
   
    <span class="document_access_span"><span class="approved_reqst_btn" file-id =<?php echo $dir['file_id'];?> doc-path="<?php echo $doc_path;?>" doc-name="<?php echo $dir['filename'];?>">Approved</span></span>
    <?php endif;?>
    <?php endif;?>
	<hr>
	</li>
	
	<?php $i=$i+1; endforeach; ?>
	
	</ul>
    <?php endif;?>
</div>
<script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/scripts/lightbox-plus-jquery.min.js"></script>
<script>jQuery.noConflict();</script>
<script>
jQuery('body').on('click', '.dir_open', function(event){
   
    var dirname = jQuery(this).attr('dir-name');
    var current_directory = jQuery('.current_directory').val();
    
    var oData       = new Object();
    oData.dirname       = dirname;
    oData.current_directory           = current_directory;
    oData.subject_id           = <?php echo $subject->getIdentity();?>;
    
    var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/getdirectorycontents';
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {

                    jQuery( ".dir_content ul").html(data.html);
                     jQuery( ".menu_bar_2").css('display','block');
                    jQuery( ".menu_bar_2_menus").html('<span> <a href="javascript:void(0)" onClick="callrootdirectory();">Documents</a> '+data.cur_dir_menu+'</span>');
                    jQuery('.current_directory').val(data.cur_dir);             
                    jQuery('.cur_dir').val(data.cur_dir);             
					 },
					   error: function(e){  alert('Error: '+e);  }  
					}); 
					
	
    jQuery( ".back_file_btn").css('display','block');
    var dirname = jQuery(this).attr('dir-name');
    var current_directory = jQuery('.current_directory').val(); 
    
    var oData       = new Object();
    oData.dirname       = dirname;
    oData.current_directory           = current_directory; 
    oData.menu_open           = 0;

  
    
  /*  var host	=	window.location.host;
    var url	=	'http://' + host + '/user/index/getdirectorycontents';
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
                    
                    jQuery(".back_file_btn").attr("cur_dir",current_directory);   
                    
                           
					 },
					   error: function(e){  //alert('Error: '+e);  
						   }  
					}); */
					

					
});

jQuery('body').on('click', '.reqst_doc_access_btn', function(event){
	
	var doc_path = jQuery(this).attr('doc-path'); 
	var doc_name = jQuery(this).attr('doc-name'); 
	var file_id = jQuery(this).attr('file-id');   
    jQuery('.docbtn_'+file_id).html('<div class="loader" style="display:block"></div>');
	var oData       = new Object();
	oData.doc_path   = doc_path;
	oData.doc_name   = doc_name;
	oData.file_id   = file_id;
	oData.subject_id           = '<?php echo $subject->getIdentity()?>';

	var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/documentrequestsave';
	jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {
						 
					  if(data.status == true){

						jQuery('.docbtn_'+file_id).html('Waiting for approval');
						jQuery('.docbtn_'+file_id).removeClass('reqst_doc_access_btn');
						jQuery('.docbtn_'+file_id).addClass('waiting_for_reqst_btn');
						
					   }
					   else{						   
						   
					   }
                       
					 },
					   error: function(e){   }  
					}); 
	 
});

function callrootdirectory(){
	
	var dirname = jQuery(this).attr('dir-name');
    var current_directory = "";
    
    var oData       = new Object();
    oData.dirname       = "";
    oData.current_directory           = current_directory;
    oData.subject_id           = <?php echo $subject->getIdentity();?>;
    
    var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/getdirectorycontents';
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {

                    jQuery( ".dir_content ul").html(data.html);
                    jQuery( ".menu_bar_2_menus").html('<span> <a href="javascript:void(0)" onClick="callrootdirectory();">Documents</a> </span>');
                    jQuery('.current_directory').val("");             
                    jQuery('.cur_dir').val(data.cur_dir);             
					 },
					   error: function(e){  alert('Error: '+e);  }  
					}); 
					
	
}


jQuery('body').on('click', '.back_file_btn', function(event){
	
	 var current_directory = jQuery(this).attr('cur_dir');
	 
	 var oData       = new Object();
	 oData.menu_open                   = 0;
	 oData.current_directory           = current_directory;

	 if(current_directory !='' && current_directory !='/'){
		 
	 var host	=	window.location.host;
     var url	=	'<?php echo $this->baseUrl()?>' + '/user/edit/getparentdirectory';
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

jQuery('body').on('click', '.menu_dir_open', function(event){
  
    var dirname = jQuery(this).attr('dir_path');
   // var current_directory = jQuery('.current_directory').val();
    
    var oData       = new Object();
    oData.dirname       = dirname;
    oData.current_directory           = dirname; 
    oData.menu_open           = 1;
   // alert(current_directory);
    var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/edit/getdirectory';
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
</script>
