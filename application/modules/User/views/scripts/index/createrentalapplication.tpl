<script src="/application/modules/User/externals/scripts/message_notififaction.js"></script>
<script>
<?php $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); ?>
<?php $viewer     = Engine_Api::_()->user()->getViewer();
$count_rental_application=count($this->rentalApplicationsData);
?>
var viewer_identity='<?php echo $viwer_id; ?>';	
</script>


<div class="generic_layout_container layout_middle">
	
<div class="layput_middle_main_div">
	
<div class="main_links">
	
	<!--<div class="view_application_menus">
	<div class="link"><a href="rentalapplication/view" style="color: #333;">View application</a></div>
	<div class="link" style="color: #f58410;">Edit</div>
	
	</div>-->
	
<div class="generic_layout_container layout_user_profile_status">
<?php /*<div id="profile_status">

 <div class="property_status">	
  <span style="font-size: 26px;">
     Rental Application
  </span>

</div>
</div> */?>

<div class="property_list_content">


<div class="generic_layout_container layout_core_container_tabs">
<div class="tabs_alt tabs_parent">
   <ul id="main_tabs">

        <li><a id="about_me" href="javascript:void(0);" class="active">ABOUT ME</a></li>
        <li><a id="residences" href="javascript:void(0);">RESIDENCES</a></li>
        <li><a id="occupation" href="javascript:void(0);">OCCUPATION</a></li>
        <li><a id="references" href="javascript:void(0);">REFERENCES</a></li>
    </ul>
</div>
</div>

<div class="succes_message" style="color:green"></div>



<?php if(empty($this->rentalApplicationsData)):?>


				<div class="about_me_div">


				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">First Name <span class="mandatory">*</span></span>    
					<input name="tenant_first_name" type="text" maxlength="65" placeholder="First Name" id="tenant_first_name" class="prty_field" autofocus value=<?php echo $this->firstname;?> readonly>
				</div> <br>

				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Last Name <span class="mandatory">*</span></span> </span>    
					<input name="tenant_last_name" type="text" maxlength="65" placeholder="Last Name" id="tenant_last_name" class="prty_field" value=<?php echo $this->lastname;?> readonly>
				</div><br>

				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Email <span class="mandatory">*</span></span> </span>    
					<input name="tenant_email 22" type="text" maxlength="65" placeholder="Email" id="tenant_email" class="prty_field" value=<?php echo $viewer->email;?> readonly>
				</div><br>

				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Phone Number </span>    
					<input name="tenant_phone_no" type="text" maxlength="65" placeholder="Phone Number" id="tenant_phone_no" class="prty_field">
				</div><br>

				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Driver's License No. </span>    
					<input name="tenant_driver_license_no" type="text" maxlength="65" placeholder="Driver's License No" id="tenant_driver_license_no" class="prty_field">
				</div><br>


				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label"></span>
				<button class="about_me_submit application_submit_btn" type="button" value="Save" name="">Save And Continue</button>
				</div><br>
				<!--<button class="next_selection_btn" type="button" value="Next Section" name="">Next Section</button>-->

				</div>
				<div class="residences_div" style="display:none">


				<div class="field_title">Current Residence</div>

				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Housing Type </span>    
					<input type="radio" name="current_residence_housing_type" value="Rent" style="margin-right:12px;">
					<label class="radio_label" for="Rent">Rental</label>
					<input type="radio" name="current_residence_housing_type" value="Owned" style="margin-right:12px;">
					<label class="radio_label" for="Lease">Owned</label>
				</div> <br>

				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Current Address </span>    
					<textarea rows="4" cols="50" name = "current_residence_address" id="current_residence_address" class="prty_field"></textarea>
				</div> <br>

				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Move In Date </span>    
					<input name="current_residence_move_in_date" type="text" maxlength="65" placeholder="MM/YYYY" id="current_residence_move_in_date" class="prty_field">
				</div> <br>

				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Monthly Rent </span>    
					<input name="current_residence_monthly_rent" type="text" maxlength="65" placeholder="Monthly Rent" id="current_residence_monthly_rent" class="prty_field">
				</div> <br>

				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Landlord Name </span>    
					<input name="current_residence_landlord_name" type="text" maxlength="65" placeholder="Landlord Name" id="current_residence_landlord_name" class="prty_field">
				</div> <br>



				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Landlord Phone Number </span>    
					<input name="current_residence_landlord_pno" type="text" maxlength="65" placeholder="Landlord Phone Number " id="current_residence_landlord_pno" class="prty_field">
				</div> <br>


				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Reason For Leaving </span>    
					<textarea rows="4" cols="50" name = "current_residence_reson_for_leaving" id="current_residence_reson_for_leaving" class="prty_field"></textarea>
				</div> <br>




				<div class="field_title">Previous Residence</div>


				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Housing Type </span>    
					<input type="radio" name="previous_residence_housing_type" value="Rent" style="margin-right:12px;"> 
					<label class="radio_label" for="Rent">Rental</label>
					<input type="radio" name="previous_residence_housing_type" value="Owned" style="margin-right:12px;"> 
					<label class="radio_label" for="Lease">Owned</label>
				</div> <br>




				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Current Address </span>    
					<textarea rows="4" cols="50" name = "previous_residence_address" id="previous_residence_address" class="prty_field"></textarea>
				</div> <br>

				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Move In Date </span>    
					<input name="previous_residence_move_in_date" type="text" maxlength="65" placeholder="MM/YYYY" id="previous_residence_move_in_date" class="prty_field">
				</div> <br>

				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Monthly Rent </span>    
					<input name="previous_residence_monthly_rent" type="text" maxlength="65" placeholder="Monthly Rent" id="previous_residence_monthly_rent" class="prty_field">
				</div> <br>

				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Landlord Name </span>    
					<input name="previous_residence_landlord_name" type="text" maxlength="65" placeholder="Landlord Name" id="previous_residence_landlord_name" class="prty_field">
				</div> <br>



				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Landlord Phone Number </span>    
					<input name="previous_residence_landlord_pno" type="text" maxlength="65" placeholder="Landlord Phone Number " id="previous_residence_landlord_pno" class="prty_field">
				</div> <br>


				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Reason For Leaving </span>    
					<textarea rows="4" cols="50" name = "previous_residence_reson_for_leaving" id="previous_residence_reson_for_leaving" class="prty_field"></textarea>
				</div> <br>


				<button class="residences_submit application_submit_btn" type="button" value="Save" name="">Save And Continue</button>
				<!--<button class="next_selection_btn" type="button" value="Next Section" name="">Next Section</button>-->

				</div>
				<div class="occupation_div" style="display:none">



				<div class="field_title">Current Occupation</div>

				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Status </span>    
					<input type="radio" name="current_status" value="Employed" style="margin-right:12px;"> 
					<label class="radio_label" for="Employed">Employed</label>
					<input type="radio" name="current_status" value="Student" style="margin-right:12px;"> 
					<label class="radio_label" for="Student">Student</label>
					<input type="radio" name="current_status" value="Unemployed" style="margin-right:12px;"> 
					<label class="radio_label" for="Unemployed">Unemployed</label>
				</div> <br>

				<div class="cuurent_occupation_employed_div" style="display:none">

				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Employer </span>    
					<input name="current_occupation_employer" type="text" maxlength="65" placeholder="Employer" id="current_occupation_employer" class="prty_field">
				</div> <br>

				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Job Title </span>    
					<input name="current_occupation_job_title" type="text" maxlength="65" placeholder="Product Manager" id="current_occupation_job_title" class="prty_field">
				</div> <br>



				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Monthly Salary </span>    
					<input name="current_occupation_monthly_salary" type="text" maxlength="65" placeholder="$" id="current_occupation_monthly_salary" class="prty_field">
				</div> <br>

				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Work Type </span>    

				<select name="current_occupation_work_type" id="current_occupation_work_type"  class="prty_field">
															 <option value="Full Time">Full Time</option>
															 <option value="Part TIme">Part TIme</option>
											 
											 </select>
				</div> <br>

				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Manager's Name</span>    
					<input name="current_occupation_manager_name" type="text" maxlength="65" placeholder="Jane Smith" id="current_occupation_manager_name" class="prty_field">
				</div> <br>

				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Phone Number</span>    
					<input name="current_occupation_pno" type="text" maxlength="65" placeholder="(555) 555-5555 ext. 55555" id="current_occupation_pno" class="prty_field">
				</div> <br>

				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Work Address </span>    
					<textarea rows="4" cols="50" name = "current_occupation_work_address" id="current_occupation_work_address" class="prty_field"></textarea>
				</div> <br>

				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Start Date</span>    
					<input name="current_occupation_start_date" type="text" maxlength="65" placeholder="MM/YYYY" id="current_occupation_start_date" class="prty_field">
				</div> <br>

				</div>
				<div class="current_occupation_basic_div" style="display:none">
				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Income Source </span>    
					<input name="current_occupation_income_source" type="text" maxlength="65" placeholder="Investments, etc" id="current_occupation_income_source" class="prty_field">
				</div> <br>

				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Monthly Income </span>    
					<input name="current_occupation_monthly_income" type="text" maxlength="65" placeholder="Investments, etc" id="current_occupation_monthly_income" class="prty_field">
				</div> <br>

				</div>


				<div class="field_title">Previous Occupation</div>

				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Status </span>    
					<input type="radio" name="previous_status" value="Employed" style="margin-right:12px;"> 
					<label class="radio_label" for="Employed">Employed</label>
					<input type="radio" name="previous_status" value="Student" style="margin-right:12px;"> 
					<label class="radio_label" for="Student">Student</label>
					<input type="radio" name="previous_status" value="Unemployed" style="margin-right:12px;"> 
					<label class="radio_label" for="Unemployed">Unemployed</label>
					<input type="radio" name="previous_status" value="None" style="margin-right:12px;"> 
					<label class="radio_label" for="None">None</label>
				</div> <br>


				<div class="previous_occupation_employed_div" style="display:none">
					
				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Employer </span>    
					<input name="previous_occupation_employer" type="text" maxlength="65" placeholder="Employer" id="previous_occupation_employer" class="prty_field">
				</div> <br>

				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Job Title </span>    
					<input name="previous_occupation_job_title" type="text" maxlength="65" placeholder="Product Manager" id="previous_occupation_job_title" class="prty_field">
				</div> <br>

				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Monthly Salary </span>    
					<input name="previous_occupation_monthly_salary" type="text" maxlength="65" placeholder="$" id="previous_occupation_monthly_salary" class="prty_field">
				</div> <br>

				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Work Type </span>    

				<select name="previous_occupation_work_type" id="previous_occupation_work_type"  class="prty_field">
															 <option value="Full Time">Full Time</option>
															 <option value="Part TIme">Part TIme</option>
											 
											 </select>
				</div> <br>

				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Manager's Name</span>    
					<input name="previous_occupation_manager_name" type="text" maxlength="65" placeholder="Jane Smith" id="previous_occupation_manager_name" class="prty_field">
				</div> <br>

				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Phone Number</span>    
					<input name="previous_occupation_pno" type="text" maxlength="65" placeholder="(555) 555-5555 ext. 55555" id="previous_occupation_pno" class="prty_field">
				</div> <br>

				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Work Address </span>    
					<textarea rows="4" cols="50" name = "previous_occupation_work_address" id="previous_occupation_work_address" class="prty_field"></textarea>
				</div> <br>

				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">End Date</span>    
					<input name="previous_occupation_end_date" type="text" maxlength="65" placeholder="MM/YYYY" id="previous_occupation_end_date" class="prty_field">
				</div> <br>

				</div>


				<div class="previous_occupation_basic_div" style="display:none">
					
				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Income Source </span>    
					<input name="previous_occupation_income_source" type="text" maxlength="65" placeholder="Investments, etc" id="previous_occupation_income_source" class="prty_field">
				</div> <br>

				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Monthly Income </span>    
					<input name="previous_occupation__monthly_income" type="text" maxlength="65" placeholder="Investments, etc" id="previous_occupation__monthly_income" class="prty_field">
				</div> <br>

				</div>


				<div class="field_title">Additional Income</div>

				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Income Sources</span>    
					<input name="additional_income_source" type="text" maxlength="65" placeholder="Bonuses, stocks, etc" id="additional_income_source" class="prty_field">
				</div> <br>

				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Amount</span>    
					<input name="additional_income_amount" type="text" maxlength="65" placeholder="$" id="additional_income_amount" class="prty_field">
				</div> <br>

				<div class="field_title">Financial Summary</div>

				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Total Monthly Income (Monthly Income + Additional Income)</span>    
					<input name="total_monthly_income" type="text" maxlength="65" placeholder="$" id="total_monthly_income" class="prty_field">
				</div> <br>

				<button class="occupation_submit application_submit_btn" type="button" value="Save" name="">Save And Continue</button>
				<!--<button class="next_selection_btn" type="button" value="Next Section" name="">Next Section</button>-->

				</div>

				<div class="references_div" style="display:none">



				<div class="field_title">Personal Reference</div>
				
				<div class="reference_content_div">

				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Full Name </span>    
					<input name="personal_references_full_name" type="text" maxlength="65" placeholder="Full Name" id="personal_references_full_name_1" class="prty_field" autofocus >
				</div> <br>

				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Relationship </span>    
					<input name="personal_references_relationship" type="text" maxlength="65" placeholder="Friend" id="personal_references_relationship_1" class="prty_field" autofocus>
				</div> <br>

				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Address </span>    
					<textarea rows="4" cols="50" name = "personal_references_address" id="personal_references_address_1" class="prty_field"></textarea>
				</div> <br>

				<div class="pro_field_wrapper">
					<span class="prty_lablel pro_label">Phone Number </span>    
					<input name="personal_references_phone_no" type="text" maxlength="65" placeholder="Phone Number" id="personal_references_phone_no_1" class="prty_field">
				</div><br>
				<hr>
				</div>
				
				<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label"> </span>    
						<span class="reference_add_more_div" title="Add More" data-count="1" title="Add More"><img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/images/add_range.png"  width="20px"></span>
					</div><br>

				<!--<button class="personal_references_submit application_submit_btn" type="button" value="Save" name="">Save And Continue</button>-->
				<button class="rental_application_done" type="button" value="Save" name="">Submit Application</button>


				</div>

<?php else:?>

					<div class="about_me_div">


					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">First Name <span class="mandatory">*</span></span>    
						<input name="tenant_first_name" type="text" maxlength="65" placeholder="First Name" id="tenant_first_name" class="prty_field" autofocus value=<?php echo $this->rentalApplicationsData->tenant_firstname;?> readonly>
					</div> <br>

					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Last Name <span class="mandatory">*</span></span> </span>    
						<input name="tenant_last_name" type="text" maxlength="65" placeholder="Last Name" id="tenant_last_name" class="prty_field" value=<?php echo $this->rentalApplicationsData->tenant_last_name;?> readonly>
					</div><br>

					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Email <span class="mandatory">*</span></span> </span>    
						<input name="tenant_email 11" type="text" maxlength="65" placeholder="Email" id="tenant_email" class="prty_field" value=<?php echo $viewer->email;?> readonly>
					</div><br>

					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Phone Number </span>    
						<input name="tenant_phone_no" type="text" maxlength="65" placeholder="Phone Number" id="tenant_phone_no" class="prty_field" value=" <?php echo $this->rentalApplicationsData->tenant_pno;?>">
					</div><br>

					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Driver's License No. </span>    
						<input name="tenant_driver_license_no" type="text" maxlength="65" placeholder="Driver's License No" id="tenant_driver_license_no" class="prty_field" value="<?php echo $this->rentalApplicationsData->driver_license_no;?>">
					</div><br>



					<button class="about_me_submit application_submit_btn" type="button" value="Save" name="">Save And Continue</button>
					<!--<button class="next_selection_btn" type="button" value="Next Section" name="">Next Section</button>-->

					</div>
					<div class="residences_div" style="display:none">


					<div class="field_title">Current Residence</div>

					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Housing Type </span>    
						<input type="radio" name="current_residence_housing_type" value="Rent" style="margin-right:12px;">
						<label class="radio_label" for="Rent">Rental</label>
						<input type="radio" name="current_residence_housing_type" value="Owned" style="margin-right:12px;">
						<label class="radio_label" for="Lease">Owned</label>
					</div> <br>

					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Current Address </span>    
						<textarea rows="4" cols="50" name = "current_residence_address" id="current_residence_address" class="prty_field"><?php echo str_replace("<br>","\n",$this->rentalApplicationsData->current_residence_address);?></textarea>
					</div> <br>

					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Move In Date </span>    
						<input name="current_residence_move_in_date" type="text" maxlength="65" placeholder="MM/YYYY" id="current_residence_move_in_date" class="prty_field" value="<?php echo $this->rentalApplicationsData->current_residence_move_in_date;?>">
					</div> <br>

					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Monthly Rent </span>    
						<input name="current_residence_monthly_rent" type="text" maxlength="65" placeholder="Monthly Rent" id="current_residence_monthly_rent" class="prty_field" value="<?php echo $this->rentalApplicationsData->current_residence_monthly_rent;?>">
					</div> <br>

					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Landlord Name </span>    
						<input name="current_residence_landlord_name" type="text" maxlength="65" placeholder="Landlord Name" id="current_residence_landlord_name" class="prty_field" value="<?php echo $this->rentalApplicationsData->current_residence_landlordname;?>">
					</div> <br>



					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Landlord Phone Number </span>    
						<input name="current_residence_landlord_pno" type="text" maxlength="65" placeholder="Landlord Phone Number " id="current_residence_landlord_pno" class="prty_field" value="<?php echo $this->rentalApplicationsData->current_residence_landlord_pno;?>">
					</div> <br>


					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Reason For Leaving </span>    
						<textarea rows="4" cols="50" name = "current_residence_reson_for_leaving" id="current_residence_reson_for_leaving" class="prty_field"><?php echo str_replace("<br>","\n",$this->rentalApplicationsData->current_residence_leaving_reason);?></textarea>
					</div> <br>




					<div class="field_title">Previous Residence</div>


					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Housing Type </span>    
						<input type="radio" name="previous_residence_housing_type" value="Rent" style="margin-right:12px;"> 
						<label class="radio_label" for="Rent">Rental</label>
						<input type="radio" name="previous_residence_housing_type" value="Owned" style="margin-right:12px;"> 
						<label class="radio_label" for="Lease">Owned</label>
					</div> <br>




					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Current Address </span>    
						<textarea rows="4" cols="50" name = "previous_residence_address" id="previous_residence_address" class="prty_field"><?php echo str_replace("<br>","\n",$this->rentalApplicationsData->previous_residence_address);?></textarea>
					</div> <br>

					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Move In Date </span>    
						<input name="previous_residence_move_in_date" type="text" maxlength="65" placeholder="MM/YYYY" id="previous_residence_move_in_date" class="prty_field" value ="<?php echo $this->rentalApplicationsData->previous_residence_move_in_date;?>">
					</div> <br>

					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Monthly Rent </span>    
						<input name="previous_residence_monthly_rent" type="text" maxlength="65" placeholder="Monthly Rent" id="previous_residence_monthly_rent" class="prty_field" value ="<?php echo $this->rentalApplicationsData->previous_residence_monthly_rent;?>">
					</div> <br>

					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Landlord Name </span>    
						<input name="previous_residence_landlord_name" type="text" maxlength="65" placeholder="Landlord Name" id="previous_residence_landlord_name" class="prty_field" value ="<?php echo $this->rentalApplicationsData->previous_residence_landlord_name;?>">
					</div> <br>



					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Landlord Phone Number </span>    
						<input name="previous_residence_landlord_pno" type="text" maxlength="65" placeholder="Landlord Phone Number " id="previous_residence_landlord_pno" class="prty_field" value ="<?php echo $this->rentalApplicationsData->previous_residence_landlord_pno;?>">
					</div> <br>


					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Reason For Leaving </span>    
						<textarea rows="4" cols="50" name = "previous_residence_reson_for_leaving" id="previous_residence_reson_for_leaving" class="prty_field" ><?php echo str_replace("<br>","\n",$this->rentalApplicationsData->previous_residence_leaving_reason);?></textarea>
					</div> <br>


					<button class="residences_submit application_submit_btn" type="button" value="Save" name="">Save And Continue</button>
					<!--<button class="next_selection_btn" type="button" value="Next Section" name="">Next Section</button>-->

					</div>
					<div class="occupation_div" style="display:none">



					<div class="field_title">Current Occupation</div>

					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Status </span>    
						<input type="radio" name="current_status" value="Employed" style="margin-right:12px;"> 
						<label class="radio_label" for="Employed">Employed</label>
						<input type="radio" name="current_status" value="Student" style="margin-right:12px;"> 
						<label class="radio_label" for="Student">Student</label>
						<input type="radio" name="current_status" value="Unemployed" style="margin-right:12px;"> 
						<label class="radio_label" for="Unemployed">Unemployed</label>
					</div> <br>

					<div class="cuurent_occupation_employed_div" style="display:none">

					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Employer </span>    
						<input name="current_occupation_employer" type="text" maxlength="65" placeholder="Employer" id="current_occupation_employer" class="prty_field" value ="<?php echo $this->rentalApplicationsData->current_occupation_employer;?>">
					</div> <br>

					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Job Title </span>    
						<input name="current_occupation_job_title" type="text" maxlength="65" placeholder="Product Manager" id="current_occupation_job_title" class="prty_field" value ="<?php echo $this->rentalApplicationsData->current_occupation_job_title;?>">
					</div> <br>



					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Monthly Salary </span>    
						<input name="current_occupation_monthly_salary" type="text" maxlength="65" placeholder="$" id="current_occupation_monthly_salary" class="prty_field"  value ="<?php echo $this->rentalApplicationsData->current_occupation_monthly_salary;?>">
					</div> <br>

					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Work Type </span>    

					<select name="current_occupation_work_type" id="current_occupation_work_type"  class="prty_field">
																 <option value="Full Time">Full Time</option>
																 <option value="Part TIme">Part TIme</option>
												 
												 </select>
					</div> <br>

					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Manager's Name</span>    
						<input name="current_occupation_manager_name" type="text" maxlength="65" placeholder="Jane Smith" id="current_occupation_manager_name" class="prty_field" value ="<?php echo $this->rentalApplicationsData->current_occupation_manager_name;?>">
					</div> <br>

					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Phone Number</span>    
						<input name="current_occupation_pno" type="text" maxlength="65" placeholder="(555) 555-5555 ext. 55555" id="current_occupation_pno" class="prty_field" value ="<?php echo $this->rentalApplicationsData->current_occupation_pno;?>">
					</div> <br>

					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Work Address </span>    
						<textarea rows="4" cols="50" name = "current_occupation_work_address" id="current_occupation_work_address" class="prty_field"> <?php echo str_replace("<br>","\n",$this->rentalApplicationsData->current_occupation_work_address);?></textarea>
					</div> <br>

					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Start Date</span>    
						<input name="current_occupation_start_date" type="text" maxlength="65" placeholder="MM/YYYY" id="current_occupation_start_date" class="prty_field" value ="<?php echo $this->rentalApplicationsData->current_occupation_start_date;?>">
					</div> <br>

					</div>
					<div class="current_occupation_basic_div" style="display:none">
					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Income Source </span>    
						<input name="current_occupation_income_source" type="text" maxlength="65" placeholder="Investments, etc" id="current_occupation_income_source" class="prty_field" value ="<?php echo $this->rentalApplicationsData->current_occupation_income_source;?>">
					</div> <br>

					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Monthly Income </span>    
						<input name="current_occupation_monthly_income" type="text" maxlength="65" placeholder="Investments, etc" id="current_occupation_monthly_income" class="prty_field" value ="<?php echo $this->rentalApplicationsData->current_occupation_monthly_income;?>">
					</div> <br>

					</div>


					<div class="field_title">Previous Occupation</div>

					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Status </span>    
						<input type="radio" name="previous_status" value="Employed" style="margin-right:12px;"> 
						<label class="radio_label" for="Employed">Employed</label>
						<input type="radio" name="previous_status" value="Student" style="margin-right:12px;"> 
						<label class="radio_label" for="Student">Student</label>
						<input type="radio" name="previous_status" value="Unemployed" style="margin-right:12px;"> 
						<label class="radio_label" for="Unemployed">Unemployed</label>
						<input type="radio" name="previous_status" value="None" style="margin-right:12px;"> 
						<label class="radio_label" for="None">None</label>
					</div> <br>


					<div class="previous_occupation_employed_div" style="display:none">
						
					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Employer </span>    
						<input name="previous_occupation_employer" type="text" maxlength="65" placeholder="Employer" id="previous_occupation_employer" class="prty_field" value ="<?php echo $this->rentalApplicationsData->previous_occupation_employer;?>">
					</div> <br>

					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Job Title </span>    
						<input name="previous_occupation_job_title" type="text" maxlength="65" placeholder="Product Manager" id="previous_occupation_job_title" class="prty_field" value ="<?php echo $this->rentalApplicationsData->previous_occupation_job_title;?>">
					</div> <br>

					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Monthly Salary </span>    
						<input name="previous_occupation_monthly_salary" type="text" maxlength="65" placeholder="$" id="previous_occupation_monthly_salary" class="prty_field" value ="<?php echo $this->rentalApplicationsData->previous_occupation_monthly_salary;?>">
					</div> <br>

					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Work Type </span>    

					<select name="previous_occupation_work_type" id="previous_occupation_work_type"  class="prty_field">
																 <option value="Full Time">Full Time</option>
																 <option value="Part TIme">Part TIme</option>
												 
												 </select>
					</div> <br>

					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Manager's Name</span>    
						<input name="previous_occupation_manager_name" type="text" maxlength="65" placeholder="Jane Smith" id="previous_occupation_manager_name" class="prty_field" value ="<?php echo $this->rentalApplicationsData->previous_occupation_manager_name;?>">
					</div> <br>

					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Phone Number</span>    
						<input name="previous_occupation_pno" type="text" maxlength="65" placeholder="(555) 555-5555 ext. 55555" id="previous_occupation_pno" class="prty_field" value ="<?php echo $this->rentalApplicationsData->previous_occupation_pno;?>">
					</div> <br>

					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Work Address </span>    
						<textarea rows="4" cols="50" name = "previous_occupation_work_address" id="previous_occupation_work_address" class="prty_field"><?php echo str_replace("<br>","\n",$this->rentalApplicationsData->previous_occupation_work_address);?></textarea>
					</div> <br>

					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">End Date</span>    
						<input name="previous_occupation_end_date" type="text" maxlength="65" placeholder="MM/YYYY" id="previous_occupation_end_date" class="prty_field" value ="<?php echo $this->rentalApplicationsData->previous_occupation_end_date;?>">
					</div> <br>

					</div>


					<div class="previous_occupation_basic_div" style="display:none">
						
					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Income Source </span>    
						<input name="previous_occupation_income_source" type="text" maxlength="65" placeholder="Investments, etc" id="previous_occupation_income_source" class="prty_field" value ="<?php echo $this->rentalApplicationsData->previous_occupation_income_source;?>">
					</div> <br>

					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Monthly Income </span>    
						<input name="previous_occupation__monthly_income" type="text" maxlength="65" placeholder="Investments, etc" id="previous_occupation__monthly_income" class="prty_field" value ="<?php echo $this->rentalApplicationsData->previous_occupation__monthly_income;?>">
					</div> <br>

					</div>




					<div class="field_title">Additional Income</div>

					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Income Sources</span>    
						<input name="additional_income_source" type="text" maxlength="65" placeholder="Bonuses, stocks, etc" id="additional_income_source" class="prty_field" value="<?php echo $this->rentalApplicationsData->additional_income_sources;?>">
					</div> <br>

					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Amount</span>    
						<input name="additional_income_amount" type="text" maxlength="65" placeholder="$" id="additional_income_amount" class="prty_field" value="<?php echo $this->rentalApplicationsData->additional_income_amount;?>">
					</div> <br>

					<div class="field_title">Financial Summary</div>

					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Total Monthly Income (Monthly Income + Additional Income)</span>    
						<input name="total_monthly_income" type="text" maxlength="65" placeholder="$" id="total_monthly_income" class="prty_field" value="<?php echo $this->rentalApplicationsData->total_monthly_income;?>">
					</div> <br>

					<button class="occupation_submit application_submit_btn" type="button" value="Save" name="">Save And Continue</button>
					<!--<button class="next_selection_btn" type="button" value="Next Section" name="">Next Section</button>-->

					</div>

					<div class="references_div" style="display:none">



					<div class="field_title">Personal Reference</div>
					
					
					
					<div class="reference_content_div">
						
					<?php $personal_reference_json = json_decode($this->rentalApplicationsData->personal_reference_json); 
	                 $personal_reference_data = json_decode(json_encode($personal_reference_json),true);
	
                    ?>
						
					<?php 
					$i=0;
					foreach($personal_reference_data as $refData):

					$i++;?>

					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Full Name </span>    
						<input name="personal_references_full_name" type="text" maxlength="65" placeholder="Full Name" id="personal_references_full_name_<?php echo $i?>" class="prty_field" autofocus value="<?php echo $refData['personal_references_full_name'];?>">
					</div> <br>

					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Relationship </span>    
						<input name="personal_references_relationship" type="text" maxlength="65" placeholder="Friend" id="personal_references_relationship_<?php echo $i?>" class="prty_field" autofocus value="<?php echo $refData['personal_references_relationship'];?>">
					</div> <br>

					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Address </span>    
						<textarea rows="4" cols="50" name = "personal_references_address" id="personal_references_address_<?php echo $i?>" class="prty_field"><?php echo str_replace("<br>","\n",$refData['personal_references_address']);?></textarea>
					</div> <br>

					<div class="pro_field_wrapper">
						<span class="prty_lablel pro_label">Phone Number </span>    
						<input name="personal_references_phone_no" type="text" maxlength="65" placeholder="Phone Number" id="personal_references_phone_no_<?php echo $i?>" class="prty_field" value="<?php echo $refData['personal_references_phone_no'];?>">
					</div><br>
                    <hr>
                    <?php endforeach;?>  
                    </div>
                    
                    <div class="pro_field_wrapper">
						<span class="prty_lablel pro_label"> </span>    
						<span class="reference_add_more_div" title="Add More" data-count="<?php echo $i?>" title="Add More"><img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/images/add_range.png"  width="20px"></span>
					</div><br>
					<!--<button class="personal_references_submit application_submit_btn" type="button" value="Save" name="">Save And Continue</button>-->
					<button class="rental_application_done" type="button" value="Save" name="">Submit Application</button>


					</div>


<?php endif;?>

<div class="loader" style="display:none"></div>
</div>


</div>
</div>

</div>
</div>


<script type="text/javascript">
var count_rent_app='<?php echo $count_rental_application; ?>';

	if(count_rent_app>0){
	jQuery('#global_header').append('<div class="affix-top extra_header mob_bar_disable_particular_pages" data-spy="affix" data-offset-top="100">'+
	'<div id="global_content">'+
	'<div class="extra_header_content">'+	
	'<ul class="navigation">'+
    '<li class="active"><a href="rentalapplication/view">One Click Application</a></li>'+
    '<li><a href="property/requests">Submitted Applications</a></li>'+
    '</ul>'+    
	'</div>'+
	'</div>'+
	'</div>');
	
		jQuery('.sub_header_dropdown').html(
                   '<select id = "sub_header_heding_select" class="input-box">'+
                   ' <option  selected value="rentalapplication/view">One Click Application</option>'+
                   ' <option  value="property/requests">Submitted Applications</option>'+
                   ' </select>'
       );
     }else{
	 	jQuery('#global_header').append('<div class="affix-top extra_header mob_bar_disable_particular_pages" data-spy="affix" data-offset-top="100">'+
	'<div id="global_content">'+
	'<div class="extra_header_content">'+	
	'<ul class="navigation">'+
    '<li class="active"><a href="rentalapplication/view">One Click Application</a></li>'+
    '</ul>'+    
	'</div>'+
	'</div>'+
	'</div>');
	
	   jQuery('.sub_header_dropdown').html(
                   '<select id = "sub_header_heding_select" class="input-box">'+
                   ' <option  selected value="rentalapplication/view">One Click Application</option>'+
                   ' </select>'
       );
	 }
	 


jQuery(document).on('change','#sub_header_heding_select',function(){
	 location.href=jQuery('#sub_header_heding_select').val();
});

var current_residence_housing_type ='<?php echo $this->rentalApplicationsData->current_residence_housing_type?>';
var previous_residence_housing_type ='<?php echo $this->rentalApplicationsData->previous_residence_housing_type?>';
var current_occupation_status ='<?php echo $this->rentalApplicationsData->current_occupation_status?>';
var previous_occupation_monthly_status ='<?php echo $this->rentalApplicationsData->previous_occupation_monthly_status?>';
var current_occupation_work_type ='<?php echo $this->rentalApplicationsData->current_occupation_work_type?>';
var previous_occupation_work_type ='<?php echo $this->rentalApplicationsData->previous_occupation_work_type?>';

jQuery("input[name=current_residence_housing_type][value='"+current_residence_housing_type+"']").prop("checked",true);
jQuery("input[name=previous_residence_housing_type][value='"+previous_residence_housing_type+"']").prop("checked",true);
jQuery("input[name=current_status][value='"+current_occupation_status+"']").prop("checked",true);
jQuery("input[name=previous_status][value='"+previous_occupation_monthly_status+"']").prop("checked",true);

jQuery("#current_occupation_work_type").val(current_occupation_work_type);
jQuery("#previous_occupation_work_type").val(previous_occupation_work_type);


var current_status            =jQuery("input[name=current_status]:checked").val(); 
var previous_status            =jQuery("input[name=previous_status]:checked").val(); 

if(current_status != undefined){
	
	if(current_status == 'Employed'){
		
		 jQuery('.cuurent_occupation_employed_div').css('display','block');
		 jQuery('.current_occupation_basic_div').css('display','none');
		
	}else{
		
		 jQuery('.cuurent_occupation_employed_div').css('display','none');
		 jQuery('.current_occupation_basic_div').css('display','block');	
		
	}
	
	
}

if(previous_status != undefined){

if(previous_status == 'Employed'){
		
		 jQuery('.previous_occupation_employed_div').css('display','block');
		 jQuery('.previous_occupation_basic_div').css('display','none');
		
	}else{
		
		 jQuery('.previous_occupation_employed_div').css('display','none');
		 jQuery('.previous_occupation_basic_div').css('display','block');	
		
	}
	
}




jQuery('#about_me').on('click',function(){
	
	if(jQuery('#residences').hasClass('active')){
	
	//	jQuery('.residences_submit').trigger( 'click' );
		residencesubmit();

	}
	if(jQuery('#occupation').hasClass('active')){
		
		//jQuery('.occupation_submit').trigger( 'click' );
		occupationsubmit();
	}

	jQuery('#about_me').addClass('active');
	jQuery('#residences').removeClass('active');
	jQuery('#occupation').removeClass('active');
	jQuery('#references').removeClass('active');
	jQuery('.about_me_div').css('display','block');
	jQuery('.residences_div').css('display','none');
	jQuery('.occupation_div').css('display','none');
	jQuery('.references_div').css('display','none');
	
	
	
});

jQuery('#residences').on('click',function(){
	
	if(jQuery('#about_me').hasClass('active')){
	
	//	jQuery('.about_me_submit').trigger( 'click' );
		var status = aboutmesumit();
		
		if(status == true){
			
		jQuery('#about_me').removeClass('active');
		jQuery('#residences').addClass('active');
		jQuery('#occupation').removeClass('active');
		jQuery('#references').removeClass('active');
		jQuery('.about_me_div').css('display','none');
		jQuery('.residences_div').css('display','block');
		jQuery('.occupation_div').css('display','none');
		jQuery('.references_div').css('display','none');
			
		}
		
		

	}
	if(jQuery('#occupation').hasClass('active')){
		
		//jQuery('.occupation_submit').trigger( 'click' );
		occupationsubmit();
		jQuery('#about_me').removeClass('active');
		jQuery('#residences').addClass('active');
		jQuery('#occupation').removeClass('active');
		jQuery('#references').removeClass('active');
		jQuery('.about_me_div').css('display','none');
		jQuery('.residences_div').css('display','block');
		jQuery('.occupation_div').css('display','none');
		jQuery('.references_div').css('display','none');
	}
	if(jQuery('#references').hasClass('active')){

		jQuery('#about_me').removeClass('active');
		jQuery('#residences').addClass('active');
		jQuery('#occupation').removeClass('active');
		jQuery('#references').removeClass('active');
		jQuery('.about_me_div').css('display','none');
		jQuery('.residences_div').css('display','block');
		jQuery('.occupation_div').css('display','none');
		jQuery('.references_div').css('display','none');
	}
	
	
});

jQuery('#occupation').on('click',function(){
	
	
	if(jQuery('#about_me').hasClass('active')){
	
		//jQuery('.about_me_submit').trigger( 'click' );
		var status = aboutmesumit();
		if(status == true){
			
		jQuery('#about_me').removeClass('active');
		jQuery('#residences').removeClass('active');
		jQuery('#occupation').addClass('active');
		jQuery('#references').removeClass('active');
		jQuery('.about_me_div').css('display','none');
		jQuery('.residences_div').css('display','none');
		jQuery('.occupation_div').css('display','block');
		jQuery('.references_div').css('display','none');
		}

	}
	if(jQuery('#residences').hasClass('active')){
		
		//jQuery('.residences_submit').trigger( 'click' );
		residencesubmit();
		jQuery('#about_me').removeClass('active');
		jQuery('#residences').removeClass('active');
		jQuery('#occupation').addClass('active');
		jQuery('#references').removeClass('active');
		jQuery('.about_me_div').css('display','none');
		jQuery('.residences_div').css('display','none');
		jQuery('.occupation_div').css('display','block');
		jQuery('.references_div').css('display','none');
	}
	if(jQuery('#references').hasClass('active')){
		jQuery('#about_me').removeClass('active');
		jQuery('#residences').removeClass('active');
		jQuery('#occupation').addClass('active');
		jQuery('#references').removeClass('active');
		jQuery('.about_me_div').css('display','none');
		jQuery('.residences_div').css('display','none');
		jQuery('.occupation_div').css('display','block');
		jQuery('.references_div').css('display','none');
	}
	
});

jQuery('#references').on('click',function(){
	
	
	if(jQuery('#about_me').hasClass('active')){
	
		//jQuery('.about_me_submit').trigger( 'click' );
		var status = aboutmesumit();
		if(status == true){
			
		jQuery('#about_me').removeClass('active');
		jQuery('#residences').removeClass('active');
		jQuery('#occupation').removeClass('active');
		jQuery('#references').addClass('active');
		jQuery('.about_me_div').css('display','none');
		jQuery('.residences_div').css('display','none');
		jQuery('.occupation_div').css('display','none');
		jQuery('.references_div').css('display','block');	
			
			
		}

	}
	if(jQuery('#occupation').hasClass('active')){
		
		//jQuery('.occupation_submit').trigger( 'click' );
		occupationsubmit();
		jQuery('#about_me').removeClass('active');
		jQuery('#residences').removeClass('active');
		jQuery('#occupation').removeClass('active');
		jQuery('#references').addClass('active');
		jQuery('.about_me_div').css('display','none');
		jQuery('.residences_div').css('display','none');
		jQuery('.occupation_div').css('display','none');
		jQuery('.references_div').css('display','block');
	}
	if(jQuery('#residences').hasClass('active')){
		
		//jQuery('.residences_submit').trigger( 'click' );
		residencesubmit();
		jQuery('#about_me').removeClass('active');
		jQuery('#residences').removeClass('active');
		jQuery('#occupation').removeClass('active');
		jQuery('#references').addClass('active');
		jQuery('.about_me_div').css('display','none');
		jQuery('.residences_div').css('display','none');
		jQuery('.occupation_div').css('display','none');
		jQuery('.references_div').css('display','block');
	}
	
});



jQuery('.next_selection_btn').on('click',function(){
	
	if(jQuery('#about_me').hasClass('active')){
		
		 var tenant_first_name     = jQuery.trim(jQuery("#tenant_first_name").val());  
		 var tenant_last_name      = jQuery.trim(jQuery("#tenant_last_name").val());  
         var tenant_email          = jQuery.trim(jQuery("#tenant_email").val()); 
        
         var is_validate =true;
        
         if(tenant_first_name == ''){
			 is_validate =false;
			 jQuery('#tenant_first_name').css('border-color','red');
		 }
         if(tenant_last_name == ''){
			 is_validate =false;
			 jQuery('#tenant_last_name').css('border-color','red');
		 }
         if(tenant_email == ''){
			 is_validate =false;
			 jQuery('#tenant_email').css('border-color','red');
		 }
		 
		if( is_validate ==true){
		jQuery('#tenant_first_name').css('border-color','#b2c6cd');	
		jQuery('#tenant_last_name').css('border-color','#b2c6cd');	
		jQuery('#tenant_email').css('border-color','#b2c6cd');	
		jQuery('#residences').trigger( 'click' );
	    }
		
	}
	else if(jQuery('#residences').hasClass('active')){
		
		jQuery('#occupation').trigger( 'click' );
		
	}
	else {
		
		jQuery('#references').trigger( 'click' );
	}
		
	
});


jQuery('.about_me_submit').on('click',function(){
	
jQuery(".loader").css("display", "block");

 var oData       = new Object();
 var landlord_id = '<?php echo $this->propertyData->property_owner_id;?>'; 
 var property_id = '<?php echo $this->propertyData->id;?>'; 
 
 var tenant_first_name     = oData.tenant_first_name =jQuery.trim(jQuery("#tenant_first_name").val()); 
 var tenant_last_name      = oData.tenant_last_name =jQuery.trim(jQuery("#tenant_last_name").val());  
 var tenant_email          = oData.tenant_email =jQuery.trim(jQuery("#tenant_email").val());  
 var tenant_phone_no       = oData.tenant_phone_no =jQuery.trim(jQuery("#tenant_phone_no").val());  
 var tennat_driver_license_no      = oData.tennat_driver_license_no =jQuery.trim(jQuery("#tenant_driver_license_no").val());  
 
 

 

 oData.landlord_id =landlord_id;  
 oData.property_id =property_id;  
 jQuery('.about_me_submit').css('display','none');
 var host	=	window.location.host;
 var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/saveapplicationaboutme';
 
 var is_validate = true;
 
 if(tenant_first_name == '' || tenant_last_name == '' || tenant_email ==''){
	 
	 if(tenant_first_name == ''){
			 is_validate =false;
			 jQuery('#tenant_first_name').css('border-color','red');
		 }
         if(tenant_last_name == ''){
			 is_validate =false;
			 jQuery('#tenant_last_name').css('border-color','red');
		 }
         if(tenant_email == ''){
			 is_validate =false;
			 jQuery('#tenant_email').css('border-color','red');
		 }
	 
	 is_validate = false;
	
 }
 
 
 if(is_validate == true){
	 
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) { 
						 
                        jQuery(".loader").css("display", "none");
                        
                        //jQuery( ".succes_message" ).text('Succesfully Saved');
                        setTimeout(function(){
                         jQuery( ".succes_message" ).html('');
                        },5000);
                        
                         jQuery('#residences').trigger( 'click' );
                         jQuery('.about_me_submit').css('display','block');
                               
					 },
					   error: function(e){  
						   jQuery(".loader").css("display", "none");
						   jQuery('.about_me_submit').css('display','block'); }  
					}); 
					
	}
	else{
		 jQuery(".loader").css("display", "none");
		 jQuery('.about_me_submit').css('display','block');
		
	}
});

jQuery('.residences_submit').on('click',function(){
	
jQuery(".loader").css("display", "block");

 var oData       = new Object();
 var landlord_id = '<?php echo $this->propertyData->property_owner_id;?>'; 
 var property_id = '<?php echo $this->propertyData->id;?>'; 
   
 
 var current_residence_housing_type     = oData.current_residence_housing_type =jQuery("input[name=current_residence_housing_type]:checked").val();  
  
  if(current_residence_housing_type == undefined){
	 current_residence_housing_type = oData.current_residence_housing_type = '';
  } 


 var current_residence_address          = oData.current_residence_address =jQuery.trim(jQuery("#current_residence_address").val().replace(/\n/g, "<br>")); 
 var current_residence_move_in_date     = oData.current_residence_move_in_date =jQuery.trim(jQuery("#current_residence_move_in_date").val()); 
 var current_residence_monthly_rent     = oData.current_residence_monthly_rent =jQuery.trim(jQuery("#current_residence_monthly_rent").val()); 
 var current_residence_landlord_name     = oData.current_residence_landlord_name =jQuery.trim(jQuery("#current_residence_landlord_name").val()); 
 var current_residence_landlord_pno      = oData.current_residence_landlord_pno =jQuery.trim(jQuery("#current_residence_landlord_pno").val()); 
 var current_residence_reson_for_leaving     = oData.current_residence_reson_for_leaving =jQuery.trim(jQuery("#current_residence_reson_for_leaving").val().replace(/\n/g, "<br>")); 
 var previous_residence_housing_type     = oData.previous_residence_housing_type =jQuery.trim(jQuery("#previous_residence_housing_type").val()); 
 var previous_residence_address     = oData.previous_residence_address =jQuery.trim(jQuery("#previous_residence_address").val().replace(/\n/g, "<br>")); 
 var previous_residence_move_in_date     = oData.previous_residence_move_in_date =jQuery.trim(jQuery("#previous_residence_move_in_date").val()); 
 var previous_residence_monthly_rent     = oData.previous_residence_monthly_rent =jQuery.trim(jQuery("#previous_residence_monthly_rent").val()); 
 var previous_residence_landlord_name     = oData.previous_residence_landlord_name =jQuery.trim(jQuery("#previous_residence_landlord_name").val()); 
 var previous_residence_landlord_pno     = oData.previous_residence_landlord_pno =jQuery.trim(jQuery("#previous_residence_landlord_pno").val()); 
 var previous_residence_reson_for_leaving     = oData.previous_residence_reson_for_leaving =jQuery.trim(jQuery("#previous_residence_reson_for_leaving").val().replace(/\n/g, "<br>")); 
 
 var previous_residence_housing_type     = oData.previous_residence_housing_type =jQuery("input[name=previous_residence_housing_type]:checked").val();  
  
  if(previous_residence_housing_type == undefined){
	 previous_residence_housing_type = oData.previous_residence_housing_type = '';
 }

 oData.landlord_id =landlord_id;  
 oData.property_id =property_id;  

 jQuery('.residences_submit').css('display','none');
 var host	=	window.location.host;
 var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/saveapplicationresidence';
 
 var is_validate = true;
 
 if(current_residence_move_in_date != ''){
	 
	 
	// if(/^\d{1,2}\/\d{4}$/.test(current_residence_move_in_date)) {
	 if(/^((0[1-9])|(1[0-2]))\/([0-9]{4})$/.test(current_residence_move_in_date)) {

		
		 is_validate = true;
		 jQuery("#current_residence_move_in_date").css('border-color','#b2c6cd');
	}
	else{
		
		 is_validate = false;
		jQuery("#current_residence_move_in_date").css('border-color','red');
	}

}
 if(previous_residence_move_in_date != ''){
	 
	 
	// if(/^\d{1,2}\/\d{4}$/.test(previous_residence_move_in_date)) {
	 if(/^((0[1-9])|(1[0-2]))\/([0-9]{4})$/.test(previous_residence_move_in_date)) {
		
		 is_validate = true;
		 jQuery("#previous_residence_move_in_date").css('border-color','#b2c6cd');
	}
	else{
		
		 is_validate = false;
		jQuery("#previous_residence_move_in_date").css('border-color','red');
	}

}
 
 
 if(is_validate == true){
	 
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) { 
						 
                        jQuery(".loader").css("display", "none");
                        
                       // jQuery( ".succes_message" ).text('Succesfully Saved');
                        setTimeout(function(){
                         jQuery( ".succes_message" ).html('');
                        },5000);
                        
                        jQuery('#occupation').trigger( 'click' );
                        jQuery('.residences_submit').css('display','block');
                               
					 },
					   error: function(e){  
						   jQuery(".loader").css("display", "none");
						   jQuery('.residences_submit').css('display','block'); }  
					}); 
					
	}
	else{
		
		jQuery(".loader").css("display", "none");
	    jQuery('.residences_submit').css('display','block');
	}
});


jQuery('.occupation_submit').on('click',function(){
	
 jQuery(".loader").css("display", "block");

 var oData       = new Object();
 var landlord_id = '<?php echo $this->propertyData->property_owner_id;?>'; 
 var property_id = '<?php echo $this->propertyData->id;?>'; 
 
 var current_status             = oData.current_status =jQuery("input[name=current_status]:checked").val(); 
 var previous_status             = oData.previous_status =jQuery("input[name=previous_status]:checked").val(); 
 
 if(current_status == undefined){
	 current_status = oData.current_status = '';
	 var current_income_source      = oData.current_income_source =''; 
	 var current_monthly_income     = oData.current_monthly_income =''; 	 
	 var current_occupation_employer  = oData.current_occupation_employer  ='';
	 var current_occupation_job_title  =oData.current_occupation_job_title  ='';
	 var current_occupation_monthly_salary  =oData.current_occupation_monthly_salary  ='';
	 var current_occupation_work_type  =oData.current_occupation_work_type  ='';
	 var current_occupation_manager_name  =oData.current_occupation_manager_name  ='';
	 var current_occupation_pno  =oData.current_occupation_pno  ='';
	 var current_occupation_work_address  =oData.current_occupation_work_address  ='';
	 var current_occupation_start_date  =oData.current_occupation_start_date  ='';
	  
 }
 else{
 
	 if(current_status == 'Employed'){
	 
	 var current_occupation_employer      = oData.current_occupation_employer =jQuery.trim(jQuery("#current_occupation_employer").val()); 
	 var current_occupation_job_title      = oData.current_occupation_job_title =jQuery.trim(jQuery("#current_occupation_job_title").val()); 
	 var current_occupation_monthly_salary      = oData.current_occupation_monthly_salary =jQuery.trim(jQuery("#current_occupation_monthly_salary").val()); 
	 var current_occupation_work_type      = oData.current_occupation_work_type =jQuery.trim(jQuery("#current_occupation_work_type").val()); 
	 var current_occupation_manager_name      = oData.current_occupation_manager_name =jQuery.trim(jQuery("#current_occupation_manager_name").val()); 
	 var current_occupation_pno      = oData.current_occupation_pno =jQuery.trim(jQuery("#current_occupation_pno").val()); 
	 var current_occupation_work_address      = oData.current_occupation_work_address =jQuery.trim(jQuery("#current_occupation_work_address").val().replace(/\n/g, "<br>")); 
	 var current_occupation_start_date      = oData.current_occupation_start_date =jQuery.trim(jQuery("#current_occupation_start_date").val()); 
	 var current_income_source  = oData.current_income_source = '';
	 var current_monthly_income  =oData.current_monthly_income  = '';

	
	}
	else{
	 var current_income_source      = oData.current_income_source =jQuery.trim(jQuery("#current_occupation_income_source").val()); 
	 var current_monthly_income     = oData.current_monthly_income =jQuery.trim(jQuery("#current_occupation_monthly_income").val()); 	 
	 var current_occupation_employer  = oData.current_occupation_employer  ='';
	 var current_occupation_job_title  =oData.current_occupation_job_title  ='';
	 var current_occupation_monthly_salary  =oData.current_occupation_monthly_salary  ='';
	 var current_occupation_work_type  =oData.current_occupation_work_type  ='';
	 var current_occupation_manager_name  =oData.current_occupation_manager_name  ='';
	 var current_occupation_pno  =oData.current_occupation_pno  ='';
	 var current_occupation_work_address  =oData.current_occupation_work_address  ='';
	 var current_occupation_start_date  =oData.current_occupation_start_date  ='';
	 
	 }
  }
  if(previous_status == undefined){
	 previous_status = oData.previous_status = '';
	var previous_occupation_income_source             = oData.previous_occupation_income_source ='';
	var previous_occupation__monthly_income           = oData.previous_occupation__monthly_income ='';
	var previous_occupation_employer                  = oData.previous_occupation_employer ='';
	var previous_occupation_job_title                 = oData.previous_occupation_job_title ='';
	var previous_occupation_monthly_salary    =oData.previous_occupation_monthly_salary ='';
	var previous_occupation_work_type    =oData.previous_occupation_work_type ='';
	var previous_occupation_manager_name    =oData.previous_occupation_manager_name ='';
	var previous_occupation_work_address    =oData.previous_occupation_work_address ='';
	var previous_occupation_pno    =oData.previous_occupation_pno ='';
	var previous_occupation_end_date    =oData.previous_occupation_end_date ='';
 } 
 else{

 if(previous_status == 'Employed'){	 
	 
 var previous_occupation_employer             = oData.previous_occupation_employer =jQuery.trim(jQuery("#previous_occupation_employer").val());   
 var previous_occupation_job_title            = oData.previous_occupation_job_title =jQuery.trim(jQuery("#previous_occupation_job_title").val());   
 var previous_occupation_monthly_salary       = oData.previous_occupation_monthly_salary =jQuery.trim(jQuery("#previous_occupation_monthly_salary").val());   
 var previous_occupation_work_type           = oData.previous_occupation_work_type =jQuery.trim(jQuery("#previous_occupation_work_type").val());   
 var previous_occupation_manager_name         = oData.previous_occupation_manager_name =jQuery.trim(jQuery("#previous_occupation_manager_name").val());   
 var previous_occupation_work_address         = oData.previous_occupation_work_address =jQuery.trim(jQuery("#previous_occupation_work_address").val().replace(/\n/g, "<br>"));   
 var previous_occupation_pno                  = oData.previous_occupation_pno =jQuery.trim(jQuery("#previous_occupation_pno").val());   
 var previous_occupation_end_date             = oData.previous_occupation_end_date =jQuery.trim(jQuery("#previous_occupation_end_date").val());   
 var previous_occupation_income_source   = oData.previous_occupation_income_source = '';
 var previous_occupation__monthly_income = oData.previous_occupation__monthly_income ='';
 }
 else{
	 
	var previous_occupation_income_source             = oData.previous_occupation_income_source =jQuery.trim(jQuery("#previous_occupation_income_source").val());   
	var previous_occupation__monthly_income             = oData.previous_occupation__monthly_income =jQuery.trim(jQuery("#previous_occupation__monthly_income").val());   
	var previous_occupation_employer                  = oData.previous_occupation_employer ='';
	var previous_occupation_job_title                 = oData.previous_occupation_job_title ='';
	var previous_occupation_monthly_salary    =oData.previous_occupation_monthly_salary ='';
	var previous_occupation_work_type    =oData.previous_occupation_work_type ='';
	var previous_occupation_manager_name    =oData.previous_occupation_manager_name ='';
	var previous_occupation_work_address    =oData.previous_occupation_work_address ='';
	var previous_occupation_pno    =oData.previous_occupation_pno ='';
	var previous_occupation_end_date    =oData.previous_occupation_end_date ='';
	 
	 
 }
 
 
 
 
 }
 var additional_income_source             = oData.additional_income_source =jQuery.trim(jQuery("#additional_income_source").val());   
 var additional_income_amount             = oData.additional_income_amount =jQuery.trim(jQuery("#additional_income_amount").val());   
 var total_monthly_income                 = oData.total_monthly_income =jQuery.trim(jQuery("#total_monthly_income").val());
 
  if(current_occupation_start_date != ''){
	 
	 
	// if(/^\d{1,2}\/\d{4}$/.test(current_occupation_start_date)) {
	 if(/^((0[1-9])|(1[0-2]))\/([0-9]{4})$/.test(current_occupation_start_date)) {
		
		 is_validate = true;
		 jQuery("#current_occupation_start_date").css('border-color','#b2c6cd');
	}
	else{
		
		 is_validate = false;
		jQuery("#current_occupation_start_date").css('border-color','red');
	}

}
 
  if(previous_occupation_end_date != ''){
	 
	 
	// if(/^\d{1,2}\/\d{4}$/.test(previous_occupation_end_date)) {
	 if(/^((0[1-9])|(1[0-2]))\/([0-9]{4})$/.test(previous_occupation_end_date)) {
		
		 is_validate = true;
		 jQuery("#previous_occupation_end_date").css('border-color','#b2c6cd');
	}
	else{
		
		 is_validate = false;
		jQuery("#previous_occupation_end_date").css('border-color','red');
	}

}
 
 
 
 
 oData.landlord_id =landlord_id;  
 oData.property_id =property_id;  

  jQuery('.occupation_submit').css('display','none');
 var host	=	window.location.host;
 var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/saveapplicationoccupation';  
 
 var is_validate = true;
 
  if(is_validate == true){
	  
	  
	    jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) { 
						 
                        jQuery(".loader").css("display", "none");
                        
                       // jQuery( ".succes_message" ).text('Succesfully Saved');
                        setTimeout(function(){
                         jQuery( ".succes_message" ).html('');
                        },5000);
                       
                          jQuery('#references').trigger( 'click' );
                          jQuery('.occupation_submit').css('display','block');
                               
					 },
					   error: function(e){  
						   jQuery(".loader").css("display", "none");
						   jQuery('.occupation_submit').css('display','block'); }  
					}); 
	  
	  
  }
  else{
	  jQuery(".loader").css("display", "none");
	  jQuery('.occupation_submit').css('display','block'); 
	  
  }

});

jQuery('.rental_application_done').on('click',function(){
	
 jQuery(".loader").css("display", "block");

 var oData       = new Object();

 
         var tenant_first_name     = jQuery.trim(jQuery("#tenant_first_name").val());  
		 var tenant_last_name      = jQuery.trim(jQuery("#tenant_last_name").val());  
         var tenant_email          = jQuery.trim(jQuery("#tenant_email").val()); 
        
         var is_validate =true;
    var referenceoData       = new Object(); 
	var reference_count = jQuery('.reference_add_more_div').data('count');
	 
	var referenceDataArray= {};
	
	for(var i =1; i<=reference_count; i++ ){
		
		var tmpreferenceData ={};
		
		tmpreferenceData['personal_references_full_name'] = jQuery.trim(jQuery("#personal_references_full_name_"+i).val());		
		tmpreferenceData['personal_references_relationship'] = jQuery.trim(jQuery("#personal_references_relationship_"+i).val());		
		tmpreferenceData['personal_references_address'] = jQuery.trim(jQuery("#personal_references_address_"+i).val().replace(/\n/g, "<br>"));
		tmpreferenceData['personal_references_phone_no'] = jQuery.trim(jQuery("#personal_references_phone_no_"+i).val());
        referenceDataArray[i] = tmpreferenceData;
	}
	
	console.log(referenceDataArray);
	
	 var host	=	window.location.host;
	 var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/saveapplicationreferences';  
	 
	 var is_validate = true;	
	 
	 if(is_validate == true){  
	  
	    jQuery.ajax({
						url:  url,
						data: referenceDataArray,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) { 
						oData.default_lastname = '<?php echo $this->lastname;?>';
                        oData.default_firstname = '<?php echo $this->firstname;?>';
						oData.default_email = '<?php echo $viewer->email;?>';   
                          
                        var host	=	window.location.host;
                        var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/createrentalapplicationdone';  
                          
                        jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {						 
						if(data.status == true) {							
							    jQuery("#successModal .success_message").text('');
                                jQuery("#successModal .success_message").text('You have successfully submitted your one time application');
                                jQuery("#successModal").modal('show');                      
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
					 },
					   error: function(e){  
						   jQuery(".loader").css("display", "none");
						     jQuery('.personal_references_submit').css('display','block');  }  
					}); 
  }
});

jQuery("input[name='current_status']").click(function(){
	
	var current_status            =jQuery("input[name=current_status]:checked").val(); 
	
	if(current_status == 'Employed'){
		
		 jQuery('.cuurent_occupation_employed_div').css('display','block');
		 jQuery('.current_occupation_basic_div').css('display','none');
		
	}else{
		
		 jQuery('.cuurent_occupation_employed_div').css('display','none');
		 jQuery('.current_occupation_basic_div').css('display','block');	
		 jQuery('#current_occupation_income_source').val('');
		 jQuery('#current_occupation_monthly_income').val('');
	}
	
});

jQuery("input[name='previous_status']").click(function(){
	
	var previous_status            =jQuery("input[name=previous_status]:checked").val(); 
	
	if(previous_status == 'Employed'){
		
		 jQuery('.previous_occupation_employed_div').css('display','block');
		 jQuery('.previous_occupation_basic_div').css('display','none');
		
	}else{
		
		 jQuery('.previous_occupation_employed_div').css('display','none');
		 jQuery('.previous_occupation_basic_div').css('display','block');	
		
	}
	
});

function aboutmesumit(){
	
	
 jQuery(".loader").css("display", "block");

 var oData       = new Object();
 var landlord_id = '<?php echo $this->propertyData->property_owner_id;?>'; 
 var property_id = '<?php echo $this->propertyData->id;?>'; 
 
 var tenant_first_name     = oData.tenant_first_name =jQuery.trim(jQuery("#tenant_first_name").val()); 
 var tenant_last_name      = oData.tenant_last_name =jQuery.trim(jQuery("#tenant_last_name").val());  
 var tenant_email          = oData.tenant_email =jQuery.trim(jQuery("#tenant_email").val());  
 var tenant_phone_no       = oData.tenant_phone_no =jQuery.trim(jQuery("#tenant_phone_no").val());  
 var tennat_driver_license_no      = oData.tennat_driver_license_no =jQuery.trim(jQuery("#tenant_driver_license_no").val());  
 
 

 

 oData.landlord_id =landlord_id;  
 oData.property_id =property_id;  
 jQuery('.about_me_submit').css('display','none');
 var host	=	window.location.host;
 var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/saveapplicationaboutme';
 
 var is_validate = true;
 
 if(tenant_first_name == '' || tenant_last_name == '' || tenant_email ==''){
	 
	 if(tenant_first_name == ''){
			 is_validate =false;
			 jQuery('#tenant_first_name').css('border-color','red');
		 }
         if(tenant_last_name == ''){
			 is_validate =false;
			 jQuery('#tenant_last_name').css('border-color','red');
		 }
         if(tenant_email == ''){
			 is_validate =false;
			 jQuery('#tenant_email').css('border-color','red');
		 }
	 
	 is_validate = false;
	
 }
 
 
 if(is_validate == true){
	 
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) { 
						 
                        jQuery(".loader").css("display", "none");
                        
                        //jQuery( ".succes_message" ).text('Succesfully Saved');
                        setTimeout(function(){
                         jQuery( ".succes_message" ).html('');
                        },5000);
                        
                        
                         jQuery('.about_me_submit').css('display','block');
                               
					 },
					   error: function(e){  
						   jQuery(".loader").css("display", "none");
						   jQuery('.about_me_submit').css('display','block'); }  
					}); 
					
	}
	else{
		jQuery(".loader").css("display", "none");
		jQuery('.about_me_submit').css('display','block'); 
		
	}
	return is_validate;
}

function residencesubmit(){
	
	jQuery(".loader").css("display", "block");

 var oData       = new Object();
 var landlord_id = '<?php echo $this->propertyData->property_owner_id;?>'; 
 var property_id = '<?php echo $this->propertyData->id;?>'; 
   
 
 var current_residence_housing_type     = oData.current_residence_housing_type =jQuery("input[name=current_residence_housing_type]:checked").val();  
  
  if(current_residence_housing_type == undefined){
	 current_residence_housing_type = oData.current_residence_housing_type = '';
  } 


 var current_residence_address          = oData.current_residence_address =jQuery.trim(jQuery("#current_residence_address").val().replace(/\n/g, "<br>")); 
 var current_residence_move_in_date     = oData.current_residence_move_in_date =jQuery.trim(jQuery("#current_residence_move_in_date").val()); 
 var current_residence_monthly_rent     = oData.current_residence_monthly_rent =jQuery.trim(jQuery("#current_residence_monthly_rent").val()); 
 var current_residence_landlord_name     = oData.current_residence_landlord_name =jQuery.trim(jQuery("#current_residence_landlord_name").val()); 
 var current_residence_landlord_pno      = oData.current_residence_landlord_pno =jQuery.trim(jQuery("#current_residence_landlord_pno").val()); 
 var current_residence_reson_for_leaving     = oData.current_residence_reson_for_leaving =jQuery.trim(jQuery("#current_residence_reson_for_leaving").val().replace(/\n/g, "<br>")); 
 var previous_residence_address     = oData.previous_residence_address =jQuery.trim(jQuery("#previous_residence_address").val().replace(/\n/g, "<br>")); 
 var previous_residence_move_in_date     = oData.previous_residence_move_in_date =jQuery.trim(jQuery("#previous_residence_move_in_date").val()); 
 var previous_residence_monthly_rent     = oData.previous_residence_monthly_rent =jQuery.trim(jQuery("#previous_residence_monthly_rent").val()); 
 var previous_residence_landlord_name     = oData.previous_residence_landlord_name =jQuery.trim(jQuery("#previous_residence_landlord_name").val()); 
 var previous_residence_landlord_pno     = oData.previous_residence_landlord_pno =jQuery.trim(jQuery("#previous_residence_landlord_pno").val()); 
 var previous_residence_reson_for_leaving     = oData.previous_residence_reson_for_leaving =jQuery.trim(jQuery("#previous_residence_reson_for_leaving").val().replace(/\n/g, "<br>")); 

 

  var previous_residence_housing_type     = oData.previous_residence_housing_type =jQuery("input[name=previous_residence_housing_type]:checked").val();  
  
  if(previous_residence_housing_type == undefined){
	 previous_residence_housing_type = oData.previous_residence_housing_type = '';
  }

 oData.landlord_id =landlord_id;  
 oData.property_id =property_id;  

 jQuery('.residences_submit').css('display','none');
 var host	=	window.location.host;
 var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/saveapplicationresidence';
 
 var is_validate = true;
 
 if(current_residence_move_in_date != ''){
	 
	 
	// if(/^\d{1,2}\/\d{4}$/.test(current_residence_move_in_date)) {
	 if(/^((0[1-9])|(1[0-2]))\/([0-9]{4})$/.test(current_residence_move_in_date)) {
		
		 is_validate = true;
		 jQuery("#current_residence_move_in_date").css('border-color','#b2c6cd');
	}
	else{
		
		 is_validate = false;
		jQuery("#current_residence_move_in_date").css('border-color','red');
	}

}
 if(previous_residence_move_in_date != ''){
	 
	 
	// if(/^\d{1,2}\/\d{4}$/.test(previous_residence_move_in_date)) {
	 if(/^((0[1-9])|(1[0-2]))\/([0-9]{4})$/.test(previous_residence_move_in_date)) {
		
		 is_validate = true;
		 jQuery("#previous_residence_move_in_date").css('border-color','#b2c6cd');
	}
	else{
		
		 is_validate = false;
		jQuery("#previous_residence_move_in_date").css('border-color','red');
	}

}
 
 
 if(is_validate == true){
	 
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) { 
						 
                        jQuery(".loader").css("display", "none");
                        
                        //jQuery( ".succes_message" ).text('Succesfully Saved');
                        setTimeout(function(){
                         jQuery( ".succes_message" ).html('');
                        },5000);
                        
                       
                        jQuery('.residences_submit').css('display','block');
                               
					 },
					   error: function(e){  
						   jQuery(".loader").css("display", "none");
						   jQuery('.residences_submit').css('display','block'); }  
					}); 
					
	}
	else{
		
		jQuery(".loader").css("display", "none");
	    jQuery('.residences_submit').css('display','block');
	}
	
	
}

function occupationsubmit(){
	 jQuery(".loader").css("display", "block");

 var oData       = new Object();
 var landlord_id = '<?php echo $this->propertyData->property_owner_id;?>'; 
 var property_id = '<?php echo $this->propertyData->id;?>'; 
 
 var current_status             = oData.current_status =jQuery("input[name=current_status]:checked").val(); 
 var previous_status             = oData.previous_status =jQuery("input[name=previous_status]:checked").val(); 
 
 if(current_status == undefined){
	 current_status = oData.current_status = '';
	 var current_income_source      = oData.current_income_source =''; 
	 var current_monthly_income     = oData.current_monthly_income =''; 	 
	 var current_occupation_employer  = oData.current_occupation_employer  ='';
	 var current_occupation_job_title  =oData.current_occupation_job_title  ='';
	 var current_occupation_monthly_salary  =oData.current_occupation_monthly_salary  ='';
	 var current_occupation_work_type  =oData.current_occupation_work_type  ='';
	 var current_occupation_manager_name  =oData.current_occupation_manager_name  ='';
	 var current_occupation_pno  =oData.current_occupation_pno  ='';
	 var current_occupation_work_address  =oData.current_occupation_work_address  ='';
	 var current_occupation_start_date  =oData.current_occupation_start_date  ='';
	  
 }
 else{
 
	 if(current_status == 'Employed'){
	 
	 var current_occupation_employer      = oData.current_occupation_employer =jQuery.trim(jQuery("#current_occupation_employer").val()); 
	 var current_occupation_job_title      = oData.current_occupation_job_title =jQuery.trim(jQuery("#current_occupation_job_title").val()); 
	 var current_occupation_monthly_salary      = oData.current_occupation_monthly_salary =jQuery.trim(jQuery("#current_occupation_monthly_salary").val()); 
	 var current_occupation_work_type      = oData.current_occupation_work_type =jQuery.trim(jQuery("#current_occupation_work_type").val()); 
	 var current_occupation_manager_name      = oData.current_occupation_manager_name =jQuery.trim(jQuery("#current_occupation_manager_name").val()); 
	 var current_occupation_pno      = oData.current_occupation_pno =jQuery.trim(jQuery("#current_occupation_pno").val()); 
	 var current_occupation_work_address      = oData.current_occupation_work_address =jQuery.trim(jQuery("#current_occupation_work_address").val().replace(/\n/g, "<br>")); 
	 var current_occupation_start_date      = oData.current_occupation_start_date =jQuery.trim(jQuery("#current_occupation_start_date").val()); 
	 var current_income_source  = oData.current_income_source = '';
	 var current_monthly_income  =oData.current_monthly_income  = '';

	
	}
	else{
	 var current_income_source      = oData.current_income_source =jQuery.trim(jQuery("#current_occupation_income_source").val()); 
	 var current_monthly_income     = oData.current_monthly_income =jQuery.trim(jQuery("#current_occupation_monthly_income").val()); 	 
	 var current_occupation_employer  = oData.current_occupation_employer  ='';
	 var current_occupation_job_title  =oData.current_occupation_job_title  ='';
	 var current_occupation_monthly_salary  =oData.current_occupation_monthly_salary  ='';
	 var current_occupation_work_type  =oData.current_occupation_work_type  ='';
	 var current_occupation_manager_name  =oData.current_occupation_manager_name  ='';
	 var current_occupation_pno  =oData.current_occupation_pno  ='';
	 var current_occupation_work_address  =oData.current_occupation_work_address  ='';
	 var current_occupation_start_date  =oData.current_occupation_start_date  ='';
	 }
  }
  if(previous_status == undefined){
	 previous_status = oData.previous_status = '';
	var previous_occupation_income_source             = oData.previous_occupation_income_source ='';
	var previous_occupation__monthly_income           = oData.previous_occupation__monthly_income ='';
	var previous_occupation_employer                  = oData.previous_occupation_employer ='';
	var previous_occupation_job_title                 = oData.previous_occupation_job_title ='';
	var previous_occupation_monthly_salary    =oData.previous_occupation_monthly_salary ='';
	var previous_occupation_work_type    =oData.previous_occupation_work_type ='';
	var previous_occupation_manager_name    =oData.previous_occupation_manager_name ='';
	var previous_occupation_work_address    =oData.previous_occupation_work_address ='';
	var previous_occupation_pno    =oData.previous_occupation_pno ='';
	var previous_occupation_end_date    =oData.previous_occupation_end_date ='';
 } 
 else{

 if(previous_status == 'Employed'){	 
	 
 var previous_occupation_employer             = oData.previous_occupation_employer =jQuery.trim(jQuery("#previous_occupation_employer").val());   
 var previous_occupation_job_title            = oData.previous_occupation_job_title =jQuery.trim(jQuery("#previous_occupation_job_title").val());   
 var previous_occupation_monthly_salary       = oData.previous_occupation_monthly_salary =jQuery.trim(jQuery("#previous_occupation_monthly_salary").val());   
 var previous_occupation_work_type           = oData.previous_occupation_work_type =jQuery.trim(jQuery("#previous_occupation_work_type").val());   
 var previous_occupation_manager_name         = oData.previous_occupation_manager_name =jQuery.trim(jQuery("#previous_occupation_manager_name").val());   
 var previous_occupation_work_address         = oData.previous_occupation_work_address =jQuery.trim(jQuery("#previous_occupation_work_address").val().replace(/\n/g, "<br>"));   
 var previous_occupation_pno                  = oData.previous_occupation_pno =jQuery.trim(jQuery("#previous_occupation_pno").val());   
 var previous_occupation_end_date             = oData.previous_occupation_end_date =jQuery.trim(jQuery("#previous_occupation_end_date").val());   
 var previous_occupation_income_source   = oData.previous_occupation_income_source = '';
 var previous_occupation__monthly_income = oData.previous_occupation__monthly_income ='';
 }
 else{
	 
	var previous_occupation_income_source             = oData.previous_occupation_income_source =jQuery.trim(jQuery("#previous_occupation_income_source").val());   
	var previous_occupation__monthly_income             = oData.previous_occupation__monthly_income =jQuery.trim(jQuery("#previous_occupation__monthly_income").val());   
	var previous_occupation_employer                  = oData.previous_occupation_employer ='';
	var previous_occupation_job_title                 = oData.previous_occupation_job_title ='';
	var previous_occupation_monthly_salary    =oData.previous_occupation_monthly_salary ='';
	var previous_occupation_work_type    =oData.previous_occupation_work_type ='';
	var previous_occupation_manager_name    =oData.previous_occupation_manager_name ='';
	var previous_occupation_work_address    =oData.previous_occupation_work_address ='';
	var previous_occupation_pno    =oData.previous_occupation_pno ='';
	var previous_occupation_end_date    =oData.previous_occupation_end_date ='';
	 
	 
 }
 
 
 
 
 }
 var additional_income_source             = oData.additional_income_source =jQuery.trim(jQuery("#additional_income_source").val());   
 var additional_income_amount             = oData.additional_income_amount =jQuery.trim(jQuery("#additional_income_amount").val());   
 var total_monthly_income                 = oData.total_monthly_income =jQuery.trim(jQuery("#total_monthly_income").val());
 
  if(current_occupation_start_date != ''){
	 
	 
	// if(/^\d{1,2}\/\d{4}$/.test(current_occupation_start_date)) {
	 if(/^((0[1-9])|(1[0-2]))\/([0-9]{4})$/.test(current_occupation_start_date)) {
		
		 is_validate = true;
		 jQuery("#current_occupation_start_date").css('border-color','#b2c6cd');
	}
	else{
		
		 is_validate = false;
		jQuery("#current_occupation_start_date").css('border-color','red');
	}

}
 
  if(previous_occupation_end_date != ''){
	 
	 
	 //if(/^\d{1,2}\/\d{4}$/.test(previous_occupation_end_date)) {
	 if(/^((0[1-9])|(1[0-2]))\/([0-9]{4})$/.test(previous_occupation_end_date)) {
		
		 is_validate = true;
		 jQuery("#previous_occupation_end_date").css('border-color','#b2c6cd');
	}
	else{
		
		 is_validate = false;
		jQuery("#previous_occupation_end_date").css('border-color','red');
	}

}
 
 
 
 
 oData.landlord_id =landlord_id;  
 oData.property_id =property_id;  

  jQuery('.occupation_submit').css('display','none');
 var host	=	window.location.host;
 var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/saveapplicationoccupation';  
 
 var is_validate = true;
 
  if(is_validate == true){
	  
	  
	    jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) { 
						 
                        jQuery(".loader").css("display", "none");
                        
                       // jQuery( ".succes_message" ).text('Succesfully Saved');
                        setTimeout(function(){
                         jQuery( ".succes_message" ).html('');
                        },5000);
                        
                         
                          jQuery('.occupation_submit').css('display','block');
                               
					 },
					   error: function(e){  
						   jQuery(".loader").css("display", "none");
						   jQuery('.occupation_submit').css('display','block'); }  
					}); 
	  
	  
  }
  else{
	  jQuery(".loader").css("display", "none");
	  jQuery('.occupation_submit').css('display','block'); 
	  
  }
	
	
}

jQuery('body').on('click', '.reference_add_more_div', function(event){

   
    var count = jQuery('.reference_add_more_div').data('count');
    jQuery('.reference_add_more_div').data('count',count+1); 
	var new_count = jQuery('.reference_add_more_div').data('count');
	
	var html_content = '<div class="pro_field_wrapper">'+
	'<span class="prty_lablel pro_label">Full Name </span>'+    
	'<input name="personal_references_full_name" type="text" maxlength="65" placeholder="Full Name" id="personal_references_full_name_'+new_count+'" class="prty_field" autofocus >'+
     '</div> <br>'+

    '<div class="pro_field_wrapper">'+
	'<span class="prty_lablel pro_label">Relationship </span>'+    
	'<input name="personal_references_relationship" type="text" maxlength="65" placeholder="Friend" id="personal_references_relationship_'+new_count+'" class="prty_field" autofocus>'+
    '</div> <br>'+

    '<div class="pro_field_wrapper">'+
	'<span class="prty_lablel pro_label">Address </span> '+   
	'<textarea rows="4" cols="50" name = "personal_references_address" id="personal_references_address_'+new_count+'" class="prty_field"></textarea>'+
    '</div> <br>'+

    '<div class="pro_field_wrapper">'+
	'<span class="prty_lablel pro_label">Phone Number </span> '+   
	'<input name="personal_references_phone_no" type="text" maxlength="65" placeholder="Phone Number" id="personal_references_phone_no_'+new_count+'" class="prty_field">'+
    '</div><br>'+
    '<hr>';
	
	jQuery('.reference_content_div').append(html_content);
	
});
jQuery('#successModal .close').on('click',function(){ 
 location.href = '<?php echo $this->baseUrl(); ?>' + '/rentalapplication/view';
});
</script>
