
<?php if($this->subjectId == $this->viewerId) :?>

<div class="gallery_options">
<div class="add_photo" data-toggle="modal" data-target="#addphotoModal"><img src="/application/modules/User/externals/images/image-add-button.svg">Add Photo</div>
<div class="manage_photo"  data-toggle="modal" data-target="#deletephotoModal"><img src="/application/modules/User/externals/images/manage_photo.svg">Manage Photo</div>
<input type="hidden" class="totalPhotogalleryData" value="<?php echo $this->totalPhotogalleryData; ?>">
</div>
<?php endif;?>
<div class="gallery_photos">	
	<?php 
	if(count($this->PhotogalleryData) > 0):?>	
	<?php foreach($this->PhotogalleryData as $data):?>
	<div class="photo">	
	<div style="text-align: center;margin-bottom: 5px;"><a class="example-image-link"  href="<?php echo $this->baseUrl().'/'.$data['path'];?>" data-lightbox="image1"><img src="<?php echo $this->baseUrl().'/'.$data['path']; ?>" width="130px" height="130px" style="object-fit:cover" ></a></div>
	<div style="text-align: center;"><?php echo $data['photo_title'];?></div>		
	</div>
	<?php endforeach;?>	
	<?php else:?>	
	<div class="pto_uploads">Nothing has been uploaded here yet</div>
	<?php endif;?>
</div>
<script>


jQuery(".photo_upload_frm").submit(function (event) {

 event.preventDefault();
 
 jQuery('.image_upload_submit_btn').prop('disabled', true);
 jQuery('.image_upload_submit_btn').css('display', 'none');
 jQuery('.loader').css('display', 'block');

 var upload_image_title = jQuery('.upload_image_title').val(); 
 var photopath = jQuery('.upload_image').val(); 
 var ext = jQuery('.upload_image').val().split('.').pop().toLowerCase();
 if(upload_image_title !='' && photopath != ''){
	 
 if(ext != "jpg" && ext != "JPG" && ext != "png" && ext != "jpeg" && ext != "JPEG" &&  ext != "PNG") {
		jQuery('.error_msg').text('');
		jQuery('.error_msg').text('Sorry, only JPG, JPEG, & PNG  files are allowed');
		jQuery('.image_upload_submit_btn').prop('disabled', false);
		jQuery('.image_upload_submit_btn').css('display', 'block');
        jQuery('.loader').css('display', 'none');
		
 } 
 else{
	 
 var totalPhotogalleryData =  jQuery('.totalPhotogalleryData').val(); 
 
 if(totalPhotogalleryData < 6){
 
 var url =  '<?php echo $this->baseUrl().'/user/index/savegalleryphoto' ?>';
 jQuery.ajax({
	url: url,
	type: "POST",
	data:  new FormData(this),
	contentType: false,
	cache: false,
	processData:false,
	dataType: 'json',
	success: function(data){
		
		var url = '<?php echo $this->baseUrl().'/user/index/galleryphotoajax' ?>';		
		var oData       = new Object();		
		var subjectId = oData.subjectId = '<?php echo $this->subjectId;?>';
		jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					    success: function (result) {
							
						 var totalPhotogalleryData = result.totalPhotogalleryData;
						 jQuery('.totalPhotogalleryData').val(totalPhotogalleryData);							
						
						jQuery('.gallery_photos').html(''); 
						var html   = jQuery(result.html);
						jQuery('.gallery_photos').append(html);
						
						jQuery('.close').trigger('click');
                        goToByScroll('layout_user_gallery_new');
                        
                        jQuery('.image_upload_submit_btn').prop('disabled', false);
                        jQuery('.image_upload_submit_btn').css('display', 'block');
                        jQuery('.loader').css('display', 'none');
                        jQuery('.upload_image_title').val('');
                        jQuery('.error_msg').text('');
						jQuery('.upload_image').val('');		
						jQuery('#deletephotoModal .modal-body-content').html(''); 
						jQuery('#deletephotoModal .modal-body-content').append(data.PhotogallerydeleteModalHtml); 					
						
         
					 },
					   error: function(e){ }  
					}); 

	},
		
	error: function(){} 	        
	});
	
	
    }
    else{
		
		jQuery('.error_msg').text('');
		jQuery('.error_msg').text('You have exceeded photo upload limit, You can upload upto 6 photos only');
		jQuery('.image_upload_submit_btn').css('display', 'block');
        jQuery('.loader').css('display', 'none');
		
	}
	}
	
  }
  
  else{
	  jQuery('.error_msg').text('');
	  jQuery('.error_msg').text('Please fill all fields');
	  jQuery('.image_upload_submit_btn').prop('disabled', false);
	  jQuery('.image_upload_submit_btn').css('display', 'block');
      jQuery('.loader').css('display', 'none');
  }


});

function goToByScroll(id){
      // Remove "link" from the ID
    id = id.replace("link", "");
      // Scroll
    jQuery('html,body').animate({
        scrollTop: jQuery("."+id).offset().top},
        'slow');
}

jQuery('body').on('click', '.yes_delete_photo', function(event){
	
	jQuery('.yes_delete_photo').prop('disabled', true);
	jQuery('.yes_delete_photo').css('display', 'none');
    jQuery('.loader').css('display', 'block');
	
	var allVals = [];
	
	jQuery.each(jQuery("input[name='deletephotochk']:checked"), function(){            
                allVals.push(jQuery(this).val());
            });

    console.log(allVals);
    
    
    var url = '<?php echo $this->baseUrl().'/user/index/deletegalleryphoto' ?>';
		
	var oData       = new Object();
	
	oData.photoIds = allVals;
	var subjectId = oData.subjectId = '<?php echo $this->subjectId;?>';
	
	if (allVals.length === 0) {
	
		jQuery('.error_msg').text('');
	    jQuery('.error_msg').text('Select image');
	    jQuery('.yes_delete_photo').prop('disabled', false);
	    jQuery('.yes_delete_photo').css('display', 'block');
        jQuery('.loader').css('display', 'none');
	}
	else{
		
		jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					    success: function (data) { console.log(data);
						
						var url = '<?php echo $this->baseUrl().'/user/index/galleryphotoajax' ?>';
		
						var oData       = new Object();
							
						var subjectId = oData.subjectId = '<?php echo $this->subjectId;?>';

					    jQuery.ajax({
											url:  url,
											data: oData,						
											dataType: 'json',
											type: 'POST',
										    success: function (result) { //console.log(data);
											
											var totalPhotogalleryData = result.totalPhotogalleryData;	
						 
						                    jQuery('.totalPhotogalleryData').val(totalPhotogalleryData);	

											jQuery('.gallery_photos').html(''); 
											var html   = jQuery(result.html);
											jQuery('.gallery_photos').append(html);
											
											
											// update data in deletephotoModal							
											
											 console.log(data.PhotogallerydeleteModalHtml);			
											jQuery('#deletephotoModal .modal-body-content').html(''); 
											jQuery('#deletephotoModal .modal-body-content').append(data.PhotogallerydeleteModalHtml); 
											
											jQuery('.close').trigger('click');
											goToByScroll('layout_user_gallery_new');
											
											jQuery('.yes_delete_photo').prop('disabled', false);
											jQuery('.yes_delete_photo').css('display', 'block');
                                            jQuery('.loader').css('display', 'none');
											
											jQuery('.error_msg').text('');

										 },
								error: function(e){ }  
						}); 
         
					 },
					   error: function(e){ }  
					}); 
		
	}
	
});


jQuery('body').on('click', '.close', function(event){
	
	jQuery('.yes_delete_photo').prop('disabled', false);
	jQuery('.error_msg').text('');
	jQuery('.image_upload_submit_btn').prop('disabled', false);
    jQuery('.upload_image_title').val('');
    jQuery('.upload_image').val('');

	
});

jQuery('body').on('click', '.manage_photo', function(event){ 
	
	var totalPhotogalleryData =  jQuery('.totalPhotogalleryData').val(); 
	
	if(totalPhotogalleryData == 0){
		
		jQuery('.error_msg').text('');
		jQuery('.error_msg').text('Nothing has been uploaded here yet');
		jQuery('.yes_delete_photo').css('display','none');
		
	}
	else{
		
		
						var url = '<?php echo $this->baseUrl().'/user/index/deletegalleryphoto' ?>';
		
						var oData       = new Object();
							
						var subjectId = oData.subjectId = '<?php echo $this->subjectId;?>';

					    jQuery.ajax({
											url:  url,
											data: oData,						
											dataType: 'json',
											type: 'POST',
										    success: function (data) { //console.log(data);

											// update data in deletephotoModal							
											
											 console.log(data.PhotogallerydeleteModalHtml);			
											jQuery('#deletephotoModal .modal-body-content').html(''); 
											jQuery('#deletephotoModal .modal-body-content').append(data.PhotogallerydeleteModalHtml); 

											
											jQuery('.error_msg').text('');

										 },
								error: function(e){ }  
						}); 
		
		
		
		
		
		jQuery('.yes_delete_photo').css('display','block');
	}
	
	
});

</script>
