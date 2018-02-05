<?php 
$viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); 
$viewer     = Engine_Api::_()->user()->getViewer();	
$displayname  = $viewer->displayname;
$displaynameArray =explode(' ',$displayname);
?>


<div class="property_list_content">

   <div class="message" style="color:red"></div>
  
   <div class="smartmove_rent_div" style="display:block">
      <div class="pro_field_wrapper">
         <span class="prty_lablel pro_label">Deposit <span style="color:red">*</span></span>    
         <input name="Deposit" type="text" maxlength="10" placeholder="Deposit" id="Deposit" class="prty_field">
      </div>
      <br>
      <div class="pro_field_wrapper">
         <span class="prty_lablel pro_label">Rent <span style="color:red">*</span></span> </span>    
         <input name="Rent" type="text" maxlength="10" placeholder="Rent" id="Rent" class="prty_field">
      </div>
      <br>
      <div class="pro_field_wrapper">
         <span class="prty_lablel pro_label">Lease Term In Months <span style="color:red">*</span></span> </span>    
         <input name="LeaseTermInMonths" type="text" maxlength="2" placeholder="6-12" id="LeaseTermInMonths" class="prty_field" >
      </div>
      <br>
      <div class="pro_field_wrapper">
         <span class="prty_lablel pro_label">Landlord Pays </span>    
         <select name="LandlordPays" id="LandlordPays"  class="prty_field">
            <option value="true">Yes</option>
            <option value="false">No</option>
         </select>
      </div>
      <br>							 
      <div class="pro_field_wrapper">
         <span class="prty_lablel pro_label">Product Bundle </span>  
         <select name="ProductBundle" id="ProductBundle"  class="prty_field">
            <option value="PackageCore">PackageCore</option>
            <option value="PackageCorePlusEviction">PackageCorePlusEviction</option>
         </select>
      </div>

      <br>
   </div> 
      <br>
      <button class="rental_application_done" type="button" value="Save" name="">Submit Application</button>
      <button class="rental_application_back" type="button" value="Save" name="">Back</button>
   </div>
</div>


<script type="text/javascript">
	
jQuery('.rental_application_done').on('click',function(){
 jQuery(".loader").css("display", "block");

 var oData       = new Object(); 
 var Deposit                = oData.Deposit      =  jQuery.trim(jQuery("#Deposit").val()); 
 var Rent                   = oData.Rent         =  jQuery.trim(jQuery("#Rent").val());  
 var LeaseTermInMonths      = oData.LeaseTermInMonths =   jQuery.trim(jQuery("#LeaseTermInMonths").val());  
 var LandlordPays           = oData.LandlordPays      =   jQuery.trim(jQuery("#LandlordPays").val());  
 var ProductBundle          = oData.ProductBundle     =   jQuery.trim(jQuery("#ProductBundle").val());
 
 var is_validate =true;        
	 
	 if(Deposit == '' || Rent == '' || LeaseTermInMonths =='' || LandlordPays ==''|| ProductBundle ==''){	 
	 if(Deposit == ''){
			 is_validate =false;
			 jQuery('#Deposit').css('border-color','red');
		 }
         else if(Rent == ''){
			 is_validate =false;
			 jQuery('#Rent').css('border-color','red');
		 }
         else if(LeaseTermInMonths == ''){
			 is_validate =false;
			 jQuery('#LeaseTermInMonths').css('border-color','red');
		 }
         else if(LandlordPays == ''){
			 is_validate =false;
			 jQuery('#LandlordPays').css('border-color','red');
		 }
         else if(ProductBundle == ''){
			 is_validate =false;
			 jQuery('#ProductBundle').css('border-color','red');
		 }
		 else{
			 is_validate = false;
		 }
 }
 else{
	 
	if((/([0-9])+$/.test(Deposit)) == false){		
		is_validate =false;
	    jQuery('#Deposit').css('border-color','red');	 
	} 
	else if((/([0-9])+$/.test(Rent)) == false){
		is_validate =false;
	    jQuery('#Rent').css('border-color','red'); 
	}	 
	else if((/([0-9])+$/.test(LeaseTermInMonths)) == false){		
		is_validate =false;
	    jQuery('#LeaseTermInMonths').css('border-color','red');	 
	}
	 
	else if((parseInt(LeaseTermInMonths) <6) || (parseInt(LeaseTermInMonths) >12)){		 
		is_validate =false;
	    jQuery('#LeaseTermInMonths').css('border-color','red');
		 
	}
	else{
		is_validate =true;
	} 
	 
 }

	 if(is_validate == false){		 
	 jQuery(".loader").css("display", "none");	 
	 jQuery('.message').text('Rent details are mandatory');
	 }	 
	 if(is_validate == true){
                     
                        url = '<?php echo $this->baseUrl(); ?>' + '/admin/user/manage/saveholdingapplication';     
                        jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {console.log(data);
						if(data.status == true) {
						   alert('Application has been saved');
						   clearentry();
                           jQuery('.rental_application_done').show();
						   jQuery(".loader").css("display", "none");
						}
					   else{						 
						   jQuery('.rental_application_done').show();
						   jQuery(".loader").css("display", "none");						   
						   jQuery( ".succes_message" ).text(data.message);
					    }		
						},
						   error: function(e){  
							   jQuery(".loader").css("display", "none");
							   jQuery('.rental_application_done').show();  }  
						});				
     
  }	
});

function clearentry(){
	jQuery("#Deposit").val('');
	jQuery("#Rent").val('');
	jQuery("#LeaseTermInMonths").val('');
	jQuery("#LandlordPays").val('');
	jQuery("#ProductBundle").val('');
	jQuery('.message').text('');
}
jQuery('.rental_application_back').on('click',function(){
 location.href = "<?php echo $this->baseUrl().'admin/user/manage/transunion' ?>";
 
});

</script>
