<script src="/application/modules/User/externals/scripts/message_notififaction.js">
</script><link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
<script>
<?php $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); 
$viewer     = Engine_Api::_()->user()->getViewer();
$fieldsByAlias              =   Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
        if( !empty($fieldsByAlias['profile_type']) ){
              $optionId = $fieldsByAlias['profile_type']->getValue($viewer);
              $profile_type_id = $optionId->value;
        }

	?>
var viewer_identity='<?php echo $viwer_id; ?>';	
</script>
<div class="scheduler_container generic_layout_container layout_middle">

<div class="payment_content_div">	
	<div class="message" style=color:red></div>
		<div class="pro_field_wrapper">
			<span class="prty_lablel pro_label" ></span> 
			<select name="scheduled_with"   class="prty_field scheduled_with">  
				<option value=""> Select</option>
			<?php foreach($this->usersData as $data): ?>			
			<option value="<?php echo $data['user_id'];?>"><?php echo $data['displayname'];?></option>
			<?php endforeach;?>
			</select>
		</div>
        <br>
            <div class="pro_field_wrapper">
            <span class="prty_lablel pro_label" ></span>
              <!--  <input type="text" id="datepicker" class="prty_field" placeholder="date">-->
           
			<div class="demo pro_field_wrapper">
				<div class="inner_wrapper">
				<span class="demo pro_field_wrapper" id="datepicker"></span>
				</div>
			</div>
			
			
            </div>
            <br>
			 <div class="pro_field_wrapper">

                 <span class="prty_lablel pro_label" ></span> 
                  <input type="text" id="timepicker" class="prty_field" placeholder="time">
            </div>
            <br>
		<div class="pro_field_wrapper">
			<span class="prty_lablel pro_label"></span>
		<button class="scheduler_submit_btn" type="button" value="Save" name="">Submit</button>
		</div><br>
        <div class="loader" style="display:none"></div>
</div>
</div>



<script type="text/javascript">
	
	var profile_type_id = "<?php echo $profile_type_id;?>";
	
	if(profile_type_id  == 4){ // landlord
	
	jQuery('#global_header').append('<div class="affix-top extra_header mob_bar_disable_particular_pages" data-spy="affix" data-offset-top="100">'+
	'<div id="global_content">'+
	'<div class="extra_header_content">'+
	
	'<ul class="navigation">'+
	
    '<li class="active"><a href="javascript:void(0)">Schedule Viewings</a></li>'+
    '<li><a href="<?php echo $this->baseUrl().'/scheduler/meetings'?>">My Viewings</a></li>'+
    '<li><a href="<?php echo $this->baseUrl().'/scheduler/meetings/requests'?>">Viewing Requests</a></li>'+
    '<li><a href="<?php echo $this->baseUrl().'/scheduler/meetings/joined'?>">Joined Viewing</a></li>'+
    '</ul>'+
    
	'</div>'+
	'</div>'+
	'</div>');
	
	jQuery('.sub_header_dropdown').html(
                   '<select id = "sub_header_heding_select" class="input-box">'+
                   ' <option  selected value="scheduler">Schedule Viewings</option>'+
                   ' <option  value="scheduler/meetings">My Viewings</option>'+
                   ' <option  value="scheduler/meetings/requests">Viewing Requests</option>'+
                   ' <option value="scheduler/meetings/joined">Joined Viewing</option>'+
                   ' </select>'
    );
   }
   
   if(profile_type_id  == 1){ // tenant
	   
   jQuery('#global_header').append('<div class="affix-top extra_header mob_bar_disable_particular_pages" data-spy="affix" data-offset-top="100">'+
	'<div id="global_content">'+
	'<div class="extra_header_content">'+	
	'<ul class="navigation">'+   
    '<li class="active" ><a href="<?php echo $this->baseUrl().'/scheduler/meetings'?>">My Viewings</a></li>'+
    '<li><a href="<?php echo $this->baseUrl().'/scheduler/meetings/requests'?>">Viewing Requests</a></li>'+
    '<li><a href="<?php echo $this->baseUrl().'/scheduler/meetings/joined'?>">Joined Viewing</a></li>'+
    '</ul>'+
    
	'</div>'+
	'</div>'+
	'</div>');
	
	jQuery('.sub_header_dropdown').html(
                   '<select id = "sub_header_heding_select" class="input-box">'+
                   ' <option  selected value="scheduler/meetings">My Viewings</option>'+
                   ' <option  value="scheduler/meetings/requests">Viewing Requests</option>'+
                   ' <option value="scheduler/meetings/joined">Joined Viewing</option>'+
                   ' </select>'
    );
	   
   }

jQuery(document).on('change','#sub_header_heding_select',function(){
	 location.href=jQuery('#sub_header_heding_select').val();
});

	jQuery(document).ready(function(){
		 jQuery(function() {
		jQuery( "#datepicker" ).datepicker({
		  dateFormat: 'yy-mm-dd',
		  minDate: 0
		});   
		}); 
		jQuery('input#timepicker').timepicker({});
	});    
    jQuery('.scheduler_submit_btn').on('click',function(){	
	jQuery('.scheduler_submit_btn').hide();
	jQuery('.loader').css('display','block');	
	var oData       = new Object();
	var scheduled_with = oData.scheduled_with = jQuery('.scheduled_with').val();
	var scheduled_date = oData.scheduled_date = jQuery('#datepicker').val();
	var scheduled_time = oData.scheduled_time = jQuery('#timepicker').val();	
	if(scheduled_with !='' && scheduled_date !='' && scheduled_time !=''){		
		 var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/savescheduler';
	 
	    jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) { 						 
						if(data.status == true){
							 jQuery('.message').text(' ');	
							 jQuery('.scheduled_with').val('');
							 jQuery('#datepicker').val('');
							 jQuery('#timepicker').val('');		
							 jQuery("#successModal .success_message").text('');
                             jQuery("#successModal .success_message").text('You have successfully scheduled your meeting');
                             jQuery("#successModal").modal('show'); 
                             jQuery('.scheduler_submit_btn').show();
						     jQuery('.loader').css('display','none');
						}
						else{
							jQuery("#successModal .success_message").text('');
                            jQuery("#successModal .success_message").text(data.message);
                            jQuery("#successModal").modal('show'); 
							jQuery('.scheduler_submit_btn').show();
							jQuery('.loader').css('display','none');
					    }
                   
					 },
					   error: function(e){  
						   jjQuery('.scheduler_submit_btn').show();
						   jQuery('.loader').css('display','none');
						  }  
					}); 
	}
	else{		
		jQuery('.scheduler_submit_btn').show();
	    jQuery('.loader').css('display','none');
	    jQuery('.message').text('please fill all fields');	
	}	
    });    
    jQuery('#global_page_user-index-scheduler .datetimepicker-hours th.switch').text('hour');
    jQuery('#global_page_user-index-scheduler .datetimepicker-minutes th.switch').text('hour');
</script>      

