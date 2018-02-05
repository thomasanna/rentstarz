<script src="/application/modules/User/externals/scripts/message_notififaction.js"></script>
<script>
<?php $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); ?>

var viewer_identity='<?php echo $viwer_id; ?>';	
</script>


<div class="generic_layout_container layout_user_browse_menu" style="display:none">
<div class="headline">
  <h2>
    </h2>
  <div class="tabs">
      </div>
</div>
</div>

<div class="property_list_content generic_layout_container layout_middle">
	
<div class="layput_middle_main_div">	
<?php if($this->is_edit == 1):?>	
<div class="main_links">
<div class="link" style="color: #f58410;">Express Application</div>
<div class="link"><a href="property/requests">Submitted Application</a></div>
<!--<div class="link"><a href="property/requests/approved">Accepted Application</a></div>-->


</div>	
<hr style="clear:both;">

<div class="view_application_menus">
	<?php /*<div class="link" style="color: #f58410;">View application</div>
	<div class="link" ><a href="/rentalapplication/edit/<?php echo $this->applicationRequest_id?>" style="color: #333;">Edit</a></div> */?>
	
</div>
<?php endif;?>
	<div id="application_content">
	
		<div class="application_btns_div">

	<div class="application_approve_reject_btns" style="float: right;">
	<?php if($this->profile_type_id != 1): // if landlord ?>	
	
	<?php  if($this->application->landlord_approve =='0'): // echo $this->application->tenant_id	; exit();?>
	
	     <a title="approve" class="req_approve_btn req_approve_btn_<?php echo $this->applicationRequest_id;?>" data-property="<?php echo $this->application->property_id;?>" data-tenant="<?php echo $this->application->tenant_id;?>" data-req="<?php echo $this->applicationRequest_id;?>" href="javascript:void(0)" class="view_coverletter" data-tenantid=<?php echo $this->application->tenant_id?> > &nbsp;<img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/images/accept.svg" width="20px"> </a>
         <a title="reject" class="req_reject_btn req_reject_btn_<?php echo $this->applicationRequest_id;?>" data-property="<?php echo $this->application->property_id;?>" data-tenant="<?php echo $this->application->tenant_id;?>" data-req="<?php echo $this->applicationRequest_id;?>" href="javascript:void(0)" class="view_coverletter" data-tenantid=<?php echo $this->application->tenant_id?> > &nbsp;<img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/images/reject.svg"  width="20px"> </a>
<div class="loader" style="display:none"></div>
    <?php endif;?>
		
	<?php endif;?>   	
	</div>
	</div>
	<div class="application_form_div ">
	
	<span class="application_sub_title">Applicant</span>
	
	<div class="table-responsive ">
	
    <table class="table table-bordered ">
 
    <tr>     
    <th>Name of The Applicant</th>
    <th>Date Of Birth</th>
    <th>Email</th>
    <th>Driver's License No</th>
    </tr>

    <tr>
    <td><?php echo $this->application->tenant_firstname ." ". $this->application->tenant_last_name;?></td>
     <?php 
		$dob=$this->smartmoveapiRentersData->DateOfBirth;
		$datearray =  explode('T', $dob);
		?>
    <td><?php echo $datearray['0'];?> </td>
    <td><?php echo $this->application->tenant_email;?> </td>
    <td><?php echo $this->application->driver_license_no;?></td>
    </tr>
    <tr>
     
    <th>Home Phone Number</th>
    <th>Street Address Line One</th>
    <th>State</th>
    <th>City</th>
    </tr>
    <tr>
      
    <td><?php echo $this->smartmoveapiRentersData->HomePhoneNumber 	;?></td>
    <td><?php echo $this->smartmoveapiRentersData->StreetAddressLineOne 	;?></td>
    <td><?php echo $this->smartmoveapiRentersData->State 	;?></td>
    <td><?php echo $this->smartmoveapiRentersData->City 	;?></td>
    </tr>
    
    <tr>
    <th>Zip</th>
    <th>Income</th>
    <th>Income Frequency</th>
    <th>Fcra Agreement Accepted</th>
    </tr>
    
    <tr>
    <td><?php echo $this->smartmoveapiRentersData->Zip 	;?></td>
    <td><?php echo $this->smartmoveapiRentersData->Income 	;?></td>
    <td><?php echo $this->smartmoveapiRentersData->IncomeFrequency 	;?></td>
    <td>Yes</td>    
    </tr>

    </table>
    </div>
    
    <span class="application_sub_title">Residence</span>
    
    <div class="table-responsive ">
    <table class="table table-bordered">
 
    <tr>     
    <th></th>
    <th>Current Residence</th>
    <th>Previous Residence</th>    
    </tr>
    
    <tr>
    <th>Housing Type</th>
    <td><?php echo $this->application->current_residence_housing_type;?></td>
    <td><?php echo $this->application->previous_residence_housing_type;?></td>
    </tr>
    
    <tr>
    <th>Current Address</th>
    <td><?php echo $this->application->current_residence_address;?></td>
    <td><?php echo $this->application->previous_residence_address;?></td>
    </tr>
    
    <tr>
    <th>Move In Date</th>
    <td><?php echo $this->application->current_residence_move_in_date;?></td>
    <td><?php echo $this->application->previous_residence_move_in_date;?></td>
    </tr>
    
    <tr>
    <th>Monthly Rent</th>
    <td><?php echo $this->application->current_residence_monthly_rent;?></td>
    <td><?php echo $this->application->previous_residence_monthly_rent;?></td>
    </tr>
    
    <tr>
    <th>Landlord Name</th>
    <td><?php echo $this->application->current_residence_landlordname;?></td>
    <td><?php echo $this->application->previous_residence_landlord_name;?></td>
    </tr>
    
    <tr>
    <th>Landlord Phone Number</th>
    <td><?php echo $this->application->current_residence_landlord_pno;?></td>
    <td><?php echo $this->application->previous_residence_landlord_pno;?></td>
    </tr>
    
    <tr>
    <th>Reason For Leaving</th>
    <td><?php echo $this->application->current_residence_leaving_reason;?></td>
    <td><?php echo $this->application->previous_residence_leaving_reason;?></td>
    </tr>
</table>
</div>


    <span class="application_sub_title">Occupation</span>
    
    <div class="table-responsive ">
    <table class="table table-bordered">
 
    <tr>     
    <th></th>
    <th>Current Occupation</th>
    <th>Previous Occupation</th>    
    </tr>
    
    <tr>
    <th>Status</th>
    <td><?php echo $this->application->current_occupation_status;?></td>
    <td><?php echo $this->application->previous_occupation_monthly_status;?></td>
    </tr>
    
    <tr>
    <th>Employer</th>
    <td><?php echo $this->application->current_occupation_employer;?></td>
    <td><?php echo $this->application->previous_occupation_employer;?></td>
    </tr>
    
    <tr>
    <th>Job Title</th>
    <td><?php echo $this->application->current_occupation_job_title;?></td>
    <td><?php echo $this->application->previous_occupation_job_title;?></td>
    </tr>
    
    <tr>
    <th>Monthly Salary</th>
    <td><?php echo $this->application->current_occupation_monthly_salary;?></td>
    <td><?php echo $this->application->previous_occupation_monthly_salary;?></td>
    </tr>
    
    <tr>
    <th>Work Type</th>
    <td><?php echo $this->application->current_occupation_work_type;?></td>
    <td><?php echo $this->application->previous_residence_landlord_name;?></td>
    </tr>
    
    <tr>
    <th>Manager's Name</th>
    <td><?php echo $this->application->current_occupation_manager_name;?></td>
    <td><?php echo $this->application->previous_occupation_manager_name;?></td>
    </tr>
    
    <tr>
    <th>Phone Number</th>
    <td><?php echo $this->application->current_occupation_pno;?></td>
    <td><?php echo $this->application->previous_occupation_pno;?></td>
    </tr>
    <tr>
		
    <th>Work Address</th>
    <td><?php echo $this->application->current_occupation_work_address;?></td>
    <td><?php echo $this->application->previous_occupation_work_address;?></td>
    </tr>
    
    <th>Start Date</th>
    <td><?php echo $this->application->current_occupation_start_date;?></td>
    <td></td>
    </tr>
    
    <th>End Date</th>
    <td></td>
    <td><?php echo $this->application->previous_occupation_end_date;?></td>
    </tr>
    
    <th>Income Source</th>
    <td><?php echo $this->application->current_occupation_income_source;?></td>
    <td><?php echo $this->application->previous_occupation_income_source;?></td>
    </tr>
    
    <th>Monthly Income</th>
    <td><?php echo $this->application->current_occupation_monthly_income;?></td>
    <td><?php echo $this->application->previous_occupation__monthly_income;?></td>
    </tr>
    </table>
	
	</div>
	
	<span class="application_sub_title">Additional Income</span>
	
	<div class="table-responsive ">
    <table class="table table-bordered">
 
    <tr>     
    <th>Additional Income Sources</th>
    <th>Amount</th>
    <th>Financial Summary</th>
    </tr>

    <tr>
    <td><?php echo $this->application->additional_income_sources;?> </td>
    <td><?php echo $this->application->additional_income_amount;?></td>
    <td><?php echo $this->application->total_monthly_income;?></td>
    </tr>
    <tr>

    </table>
    </div>
	
	<span class="application_sub_title">Personal Reference</span>
	
	<?php $personal_reference_json = json_decode($this->application->personal_reference_json); 
	$personal_reference_data = json_decode(json_encode($personal_reference_json),true);
	
	?>
	
	<div class="table-responsive">
	<table class="table table-bordered">
 
    <tr>     
    <th>Full Name</th>
    <th>Relationship</th>
    <th>Address</th>
    <th>Phone Number</th>
    </tr>
    
    <?php foreach($personal_reference_data as $refData):?>
    <tr>
    <td><?php echo $refData['personal_references_full_name'];?> </td>
    <td><?php echo $refData['personal_references_relationship'];?> </td>
    <td><?php echo $refData['personal_references_address'];?> </td>
    <td><?php echo $refData['personal_references_phone_no'];?> </td>
    </tr>
    <?php endforeach;?>
    <tr>

    </table>
    
    </div>
    
    <span class="application_sub_title">Application Status	</span>
    
    <div class="table-responsive ">
	<table class="table table-bordered">
 
    <tr>     
    <th>Application Status	</th>
    <th>Idma Verification Status</th>
    </tr>

    <tr>
    <td><?php if($this->applicationStatus['ApplicationStatus']=="RequestAccepted"):echo "Request Accepted";
    elseif($this->applicationStatus['ApplicationStatus']=="ReportsAvailable"): echo "Reports Available"; 
    elseif($this->applicationStatus['ApplicationStatus']=="ReportsRequested"): echo "Reports Requested"; 
    elseif($this->applicationStatus['ApplicationStatus']=="IDMACompleted"): echo "IDMA Completed"; 
    else: echo "No Activity";
    endif;
    ?> </td>
    <td><?php echo $this->applicationStatus['IdmaVerificationStatus']?></td>

    </tr>
    <tr>

    </table>
	</div>

    </div>

	</div>
	</div>
		


    </div>
    <div id="stantard-dialogBox" style="font-size:30px"></div>

    
</div>		


<script>

jQuery('#about_me').on('click',function(){

		jQuery('#about_me').addClass('active');
		jQuery('#smartmove_rent').removeClass('active');
		jQuery('#residences').removeClass('active');
		jQuery('#occupation').removeClass('active');
		jQuery('#references').removeClass('active');
		jQuery('#application_status').removeClass('active');
		jQuery('.about_me_div').css('display','block');
		jQuery('.smartmove_rent_div').css('display','none');
		jQuery('.residences_div').css('display','none');
		jQuery('.occupation_div').css('display','none');
		jQuery('.references_div').css('display','none');
		jQuery('.application_status_div').css('display','none');	
});



jQuery('#residences').on('click',function(){

		jQuery('#about_me').removeClass('active');
		jQuery('#smartmove_rent').removeClass('active');
		jQuery('#residences').addClass('active');
		jQuery('#occupation').removeClass('active');
		jQuery('#references').removeClass('active');
		jQuery('#application_status').removeClass('active');
		jQuery('.about_me_div').css('display','none');
		jQuery('.smartmove_rent_div').css('display','none');
		jQuery('.residences_div').css('display','block');
		jQuery('.occupation_div').css('display','none');
		jQuery('.references_div').css('display','none');
		jQuery('.application_status_div').css('display','none');	
});

jQuery('#occupation').on('click',function(){

		jQuery('#about_me').removeClass('active');
		jQuery('#smartmove_rent').removeClass('active');
		jQuery('#residences').removeClass('active');
		jQuery('#occupation').addClass('active');
		jQuery('#references').removeClass('active');
		jQuery('#application_status').removeClass('active');
		jQuery('.about_me_div').css('display','none');
		jQuery('.smartmove_rent_div').css('display','none');
		jQuery('.residences_div').css('display','none');
		jQuery('.occupation_div').css('display','block');
		jQuery('.references_div').css('display','none');
		jQuery('.application_status_div').css('display','none');	
});

jQuery('#references').on('click',function(){

		jQuery('#about_me').removeClass('active');
		jQuery('#smartmove_rent').removeClass('active');
		jQuery('#residences').removeClass('active');
		jQuery('#occupation').removeClass('active');
		jQuery('#references').addClass('active');
		jQuery('#application_status').removeClass('active');
		jQuery('.about_me_div').css('display','none');
		jQuery('.smartmove_rent_div').css('display','none');
		jQuery('.residences_div').css('display','none');
		jQuery('.occupation_div').css('display','none');
		jQuery('.references_div').css('display','block');	
		jQuery('.application_status_div').css('display','none');	

});
jQuery('#application_status').on('click',function(){

		jQuery('#about_me').removeClass('active');
		jQuery('#smartmove_rent').removeClass('active');
		jQuery('#residences').removeClass('active');
		jQuery('#occupation').removeClass('active');
		jQuery('#references').removeClass('active');
		jQuery('#application_status').addClass('active');
		jQuery('.about_me_div').css('display','none');
		jQuery('.smartmove_rent_div').css('display','none');
		jQuery('.residences_div').css('display','none');
		jQuery('.occupation_div').css('display','none');
		jQuery('.references_div').css('display','none');	
		jQuery('.application_status_div').css('display','block');	

});

jQuery( ".req_approve_btn" ).click(function() {
 jQuery(".loader" ).css("display", "block");
 var property_id = jQuery(this).attr('data-property'); 
 var tenant_id   = jQuery(this).attr('data-tenant'); 
 var req_id   = jQuery(this).attr('data-req'); 

 var oData       = new Object();
 oData.property_id       = property_id;
 oData.tenant_id         = tenant_id;
 oData.req_id            = req_id;
 jQuery(".req_approve_btn_"+req_id).hide();
 jQuery(".req_reject_btn_"+req_id).hide();
 var host	=	window.location.host;
 var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/propertyrequestapprove';
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					success: function (data) {
						 
					if(data.status == true){
						jQuery(".loader" ).css("display", "none");
						jQuery('#stantard-dialogBox').dialogBox({
										autoHide: true,
										time: 3000,
										content: 'The application is successfully approved',
									 });
                        jQuery(".req_approve_btn_"+req_id).fadeOut();                            
                        jQuery(".req_reject_btn_"+req_id).fadeOut();  
                        location.href='<?php echo $this->baseUrl()?>'+'/property/approved';
					}      
					else{
						 jQuery(".req_approve_btn_"+req_id).show();
						 jQuery(".req_reject_btn_"+req_id).show();

						
					}                    
					},
					   error: function(e){  
						   }  
					});  
 
});

jQuery( ".req_reject_btn" ).click(function() {
 jQuery(".loader" ).css("display", "block");
 var property_id = jQuery(this).attr('data-property'); 

 var count_rej_btn=jQuery('.req_reject_btn').length;
 var count_prty_reqsts_li=jQuery('.property_name_'+property_id+ ' li').length;

 jQuery('.application_approve_reject_btns').hide(); 

 var tenant_id   = jQuery(this).attr('data-tenant'); 
 var req_id   = jQuery(this).attr('data-req'); 
 
 var oData       = new Object();
 oData.property_id       = property_id;
 oData.tenant_id         = tenant_id;
 oData.req_id            = req_id;
 var host	=	window.location.host;
 var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/propertyrequestreject';
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {
						jQuery(".loader" ).css("display", "none");
						jQuery('#stantard-dialogBox').dialogBox({
										autoHide: true,
										time: 3000,
										content: 'The application is successfully rejected',
									 });
						
						jQuery(".request_"+req_id).remove(); 
						location.href='<?php echo $this->baseUrl()?>'+'/propertyrequestslist'
						    
                                           
					    },
					    error: function(e){ 
						   jQuery('.application_approve_reject_btns').show(); 
 //alert('Error: '+e); 
				        }  
					}); 
 
 
});
</script>
