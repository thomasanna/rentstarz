  <script src="/application/modules/User/externals/scripts/lightbox-plus-jquery.min.js"></script>
  <link href="/application/modules/User/externals/styles/lightbox.min.css" rel="stylesheet" type="text/css">
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<h2>
  <?php echo $this->translate("Manage Advertisements") ?>
  <?php $viewer     = Engine_Api::_()->user()->getViewer(); ?>
</h2>

<div class='admin_search'>
  <?php echo $this->formFilter->render($this) ?>
</div>
<div class="advertise">
<button class="upload_file_btn">Add new Advertisement</button>
</div>
<div class='admin_results'>
	
  <div>
    <?php $count = $this->paginator->getTotalItemCount() ?>
    <?php echo $this->translate(array("%s advertisement found", "%s advertisement found", $count),
        $this->locale()->toNumber($count)) ?>
  </div>
  <div>
    <?php echo $this->paginationControl($this->paginator, null, null, array(
      'pageAsQuery' => true,
      'params' => $this->formValues,
    )); ?>
  </div>
</div>

<br />

<div class="admin_table_form">

  <table class='admin_table'>
    <thead>
      <tr>     
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('id', 'DESC');"><?php echo $this->translate("ID") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('user_id', 'ASC');;"><?php echo $this->translate("User id") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('title', 'ASC');;"><?php echo $this->translate("Title") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('ad_url', 'ASC');;"><?php echo $this->translate("Url") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('date_from', 'ASC');;"><?php echo $this->translate("From") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('date_to', 'ASC');;"><?php echo $this->translate("To") ?></a></th>
        <th style='width: 1%;' class='admin_table_options' colspan="2"><?php echo $this->translate("Image") ?></th>   
      </tr>             
    </thead>
    <tbody>      
        <?php if( count($this->paginator) ): ?>
        <?php foreach( $this->paginator as $item ): ?>
        <tr>
       <td><?php echo $item['id']; ?></td>
       <td><?php echo $item['user_id']; ?></td>
       <td><?php echo $item['title']; ?></td>
       <td><?php echo $item['ad_url']; ?></td>
       <td><?php echo $item['date_from']; ?></td>
       <td><?php echo $item['date_to']; ?></td>
        <td>
			<a class="example-image-link"  href="<?php echo $this->baseUrl().'/'.$item['image'];?>" data-lightbox="image1"><img src="<?php echo $this->baseUrl().'/'.$item['image']; ?>" width="30px" height="30px" style="object-fit:cover" ></a></td>
		<td> 
			<a class='smoothbox'  style="padding-right:12px;" href='<?php echo $this->url(array('action' => 'editadvertisement', 'id' => $item['id']));?>'>
             <?php //echo $this->translate("edit") ?>
            </a>
			<a  class="edit_popup" data-id = "<?php echo $item['id'];?>" style="padding-right:12px;" href='javascript:void(0);'>
             <?php echo $this->translate("edit") ?>
            </a>
		    <a class='smoothbox'  href='<?php echo $this->url(array('action' => 'deleteadvertisement', 'id' => $item['id']));?>'>
                  <?php echo $this->translate("delete") ?>
             </a>
        </td>
       </tr>

     <?php endforeach; ?>
      <?php endif; ?>
    </tbody>
  </table>
  <br />	
</div>   



<!-- new file popup ------>
<div id="light1" class="white_content">
	<div class="popup_title">Add advertisement</div><div class="div_attachment_cancel"><img src="/application/modules/User/externals/images/GREYcancel.png"></div>
	
	<div class="error_msg" style="color:red"></div>
            <form method="POST" enctype="multipart/form-data" action="<?php echo $this->baseUrl().'/user/admin-manage/saveadvertisementphoto' ?>" class="photo_upload_frm">
                <div class="folder_name_input">
                    <div>Title</div>
                    <div style="margin-bottom: 12px;margin-top: 2px;">
                    <input type="text" class="upload_image_title" name="upload_image_title" maxlength="30">
                    </div>
                  
                    <div>Url</div>
                    <div style="margin-bottom: 12px;margin-top: 2px;">
                    <input type="text" class="website" name="website" maxlength="100">
                    </div>
                    
                    <div>From</div>
					<div style="margin-bottom: 12px;margin-top: 2px;">
					<input type="text"  id="datepicker1" name="date_from" maxlength="100">
					</div>
                  

                    
                    <div>To</div>
					<div style="margin-bottom: 12px;margin-top: 2px;">
					<input type="text"  id="datepicker2" name="date_to" maxlength="100">
					</div>
                  

                    
                   <!-- <p>Date: <input type="text" id="datepicker"></p>-->
                    
                    <input type="file" class="upload_image" name="upload_image">
                    <div>only JPG, JPEG, and PNG  files are allowed.</div>
                    <div class="confirm_btns" style="text-align: left;">
                    <input type="submit" value="Save" class="image_upload_submit_btn" style="width: 134px;padding-bottom: 7px; padding-top: 7px; background-color: #619dbe;color: #fff;">
                   </div>
                   </div>
            </form>	



<div class="loader" style="display:none;"></div>
 </div>
 
<!-- edit advertisement popup ------>
<div id="light2" class="white_content">
	<div class="popup_title">Edit advertisement</div><div class="div_attachment_cancel"><img src="/application/modules/User/externals/images/GREYcancel.png"></div>
	
	<div class="error_msg" style="color:red"></div>
            <form method="POST" enctype="multipart/form-data" action="<?php echo $this->baseUrl().'/user/admin-manage/editadvertisement' ?>" class="edit_advertisement_form">
                <div class="folder_name_input">
					<input type="hidden" class="advertisementId" name="advertisementId" maxlength="30">
                    <div>Title</div>
                    <div style="margin-bottom: 12px;margin-top: 2px;">
                    <input type="text" class="edit_upload_image_title" name="upload_image_title" maxlength="30">
                    </div>
                  
                    <div>Url</div>
                    <div style="margin-bottom: 12px;margin-top: 2px;">
                    <input type="text" class="edit_website" name="website" maxlength="100">
                    </div>
                    
                    <div>From</div>
					<div style="margin-bottom: 12px;margin-top: 2px;">
					<input type="text"  id="datepicker3" name="date_from" maxlength="100">
					</div>
                  

                    
                    <div>To</div>
					<div style="margin-bottom: 12px;margin-top: 2px;">
					<input type="text"  id="datepicker4" name="date_to" maxlength="100">
					</div>
                    <div>Change image</div>
                    <input type="file" class="edit_upload_image" name="edit_upload_image">
                    <div>only JPG, JPEG, and PNG  files are allowed.</div>
                    <div class="confirm_btns" style="text-align: left;">
                    <input type="submit" value="Save" class="edit_advertisement_submit_btn" style="width: 134px;padding-bottom: 7px; padding-top: 7px; background-color: #619dbe;color: #fff;">
                   </div>
                   </div>
            </form>	



<div class="loader" style="display:none;"></div>
 </div>
<div id="fade" class="black_overlay"></div>

<script type="text/javascript">
  $('#ui-widget-content').css('width','auto');

  $( function() {
    $( "#datepicker1" ).datepicker(
    {
	dateFormat: 'yy-mm-dd',
//	dateFormat: 'mm-dd-yy',
	 minDate: 0
		}
    );
    $( "#datepicker2" ).datepicker({
	dateFormat: 'yy-mm-dd',
//	dateFormat: 'mm-dd-yy',
	 minDate: 0
    }
    );
    $( "#datepicker3" ).datepicker({
	dateFormat: 'yy-mm-dd',
//	dateFormat: 'mm-dd-yy',
	 minDate: 0
    }
    );
    $( "#datepicker4" ).datepicker({
	dateFormat: 'yy-mm-dd',
//	dateFormat: 'mm-dd-yy',
	 minDate: 0
    }
    );
    
  } );

	
  var currentOrder = '<?php echo $this->order ?>';
  var currentOrderDirection = '<?php echo $this->order_direction ?>';
  var changeOrder = function(order, default_direction){
    // Just change direction
    if( order == currentOrder ) {
      $('order_direction').value = ( currentOrderDirection == 'ASC' ? 'DESC' : 'ASC' );
    } else {
      $('order').value = order;
      $('order_direction').value = default_direction;
    }
    $('filter_form').submit();
  }
  
  
  
  
  
jQuery('body').on('click', '.upload_file_btn', function(event){
	document.getElementById('light1').style.display='block';
	document.getElementById('fade').style.display='block';
});
jQuery('body').on('click', '.edit_popup', function(event){
	
	var id = jQuery(this).attr('data-id'); 
	var formURL    = '<?php echo $this->baseUrl(); ?>' + '/user/admin-manage/getadvertisement'; 
	var oData      = new Object();
	oData.id       = id;
	jQuery.ajax( {
						url : formURL,
						type: "POST",
						dataType: 'json',
						data : oData,
						success: function (data) { 						
							if(data.status==true)
							{
							  jQuery('.edit_upload_image_title').val(data.title);
							  jQuery('.edit_website').val(data.ad_url);
							  jQuery('#datepicker3').val(data.date_from);
							  jQuery('#datepicker4').val(data.date_to);
							  jQuery('#datepicker4').val(data.date_to);
							  jQuery('.advertisementId').val(id);
							  document.getElementById('light2').style.display='block';
	                          document.getElementById('fade').style.display='block';
							}
							},
							error: function(e){
						   
						}
    });	
});


jQuery('body').on('click', '.div_attachment_cancel', function(event){
	    jQuery('#light1').css('display','none');
	    jQuery('#light2').css('display','none');
		jQuery('#fade').css('display','none');		
});


jQuery(".photo_upload_frm").submit(function (event) {
 event.preventDefault();

 
 
 jQuery('.image_upload_submit_btn').prop('disabled', true);
 jQuery('.image_upload_submit_btn').css('display', 'none');
 jQuery('.loader').css('display', 'block');
 var date_from = jQuery('#datepicker1').val();
 var date_to   = jQuery('#datepicker2').val();

 var upload_image_title = jQuery('.upload_image_title').val(); 
 var website = jQuery('.website').val(); 
 var photopath = jQuery('.upload_image').val(); 
 var ext = jQuery('.upload_image').val().split('.').pop().toLowerCase();
 
        var oData             = new Object();	
		var upload_image_title=	oData.upload_image_title=upload_image_title;	
		var website           =	oData.website           =website;	
		var date_from         =	oData.date_from=date_from;	
		var date_to           =	oData.date_to           =date_to;	
 

 
 if(upload_image_title !='' && photopath != '' && date_from != '' && date_to != ''){
	 
 if(ext != "jpg" && ext != "JPG" && ext != "png" && ext != "jpeg" && ext != "JPEG" &&  ext != "PNG") {
		jQuery('.error_msg').text('');
		jQuery('.error_msg').text('Sorry, only JPG, JPEG, & PNG  files are allowed');
		jQuery('.image_upload_submit_btn').prop('disabled', false);
		jQuery('.image_upload_submit_btn').css('display', 'block');
        jQuery('.loader').css('display', 'none');
		
 } 
 if(date_to<date_from){
	    
	    jQuery('.error_msg').text('');
		jQuery('.error_msg').text('Date to must be greater than Date from');
		jQuery('.image_upload_submit_btn').prop('disabled', false);
		jQuery('.image_upload_submit_btn').css('display', 'block');
        jQuery('.loader').css('display', 'none');
}
 else{

 var url =  '<?php echo $this->baseUrl().'/user/admin-manage/saveadvertisementphoto' ?>';

 jQuery.ajax({
	url: url,
	type: "POST",
	data:  new FormData(this),
	contentType: false,
	cache: false,
	processData:false,
	dataType: 'json',
	success: function(data){
		
		if(data.status==true){
		
		jQuery('#light1').css('display','none');
		jQuery('#fade').css('display','none');
         location.reload();
        }
	},
		
	error: function(){} 	        
	});
	
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
jQuery(".edit_advertisement_form").submit(function (event) {
 event.preventDefault();

 jQuery('.edit_advertisement_submit_btn').prop('disabled', true);
 jQuery('.edit_advertisement_submit_btn').css('display', 'none');
 jQuery('.loader').css('display', 'block');
 var date_from = jQuery('#datepicker3').val();
 var date_to   = jQuery('#datepicker4').val();

 var upload_image_title = jQuery('.edit_upload_image_title').val(); 
 var website                    = jQuery('.edit_website').val(); 
 var advertisementId            = jQuery('.advertisementId').val(); 
 var photopath                  = jQuery('.edit_upload_image').val(); 

 
        var oData             = new Object();	
		var upload_image_title=	oData.upload_image_title=upload_image_title;	
		var website           =	oData.website           =website;	
		var date_from         =	oData.date_from=date_from;	
		var date_to           =	oData.date_to           =date_to;	
		var advertisementId   =	oData.advertisementId           =advertisementId;	
 
	var is_valid = true;
	 
	 if( photopath != '' ){	
		 var ext           = jQuery('.edit_upload_image').val().split('.').pop().toLowerCase(); 
		 if(ext != "jpg" && ext != "JPG" && ext != "png" && ext != "jpeg" && ext != "JPEG" &&  ext != "PNG") {
				jQuery('.error_msg').text('');
				jQuery('.error_msg').text('Sorry, only JPG, JPEG, & PNG  files are allowed');
				jQuery('.edit_advertisement_submit_btn').prop('disabled', false);
				jQuery('.edit_advertisement_submit_btn').css('display', 'block');
				jQuery('.loader').css('display', 'none');	
				is_valid  = false;		
		 } 
	}

	if(is_valid  == true){
		 if(date_to<date_from){
				
				jQuery('.error_msg').text('');
				jQuery('.error_msg').text('Date to must be greater than Date from');
				jQuery('.edit_advertisement_submit_btn').prop('disabled', false);
				jQuery('.edit_advertisement_submit_btn').css('display', 'block');
				jQuery('.loader').css('display', 'none');
				is_valid  = false;	
		}
	}
	if(is_valid  == true){
		 var url =  '<?php echo $this->baseUrl().'/user/admin-manage/editadvertisement' ?>';

		 jQuery.ajax({
			url: url,
			type: "POST",
			data:  new FormData(this),
			contentType: false,
			cache: false,
			processData:false,
			dataType: 'json',
			success: function(data){				
				if(data.status==true){				
				jQuery('#light2').css('display','none');
				jQuery('#fade').css('display','none');
				location.reload();
				}
			},
				
			error: function(){} 	        
			});
	}
});



</script>  





