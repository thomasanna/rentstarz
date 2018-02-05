<script src="/application/modules/User/externals/scripts/message_notififaction.js"></script>
<script>
<?php $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); ?>

var viewer_identity='<?php echo $viwer_id; ?>';	
</script>

<div class="generic_layout_container layout_user_browse_menu">
<div class="headline">
  <h2>
     Report  </h2>
  <div class="tabs">
      </div>
</div>
</div>


<div class="property_list_content generic_layout_container layout_middle">
	
	

	<div id="application_content">
		
	<?php //print_r($this->applicationData);?>
    <span class="application_sub_title"></span>
    
    <div class="table-responsive ">
	<table class="table table-bordered">
 
    <tr>     
    <th>Credit Recommendation	</th>
    <td><?php echo $this->reportData['CreditRecommendation'];?></td>
    </tr>
    <tr>     
    <th>Credit Recommendation Policy Text	</th>
    <td><?php echo $this->reportData['CreditRecommendationPolicyText'];?></td>
    </tr>
    
    <?php foreach($this->reportData['Applicants'] as $applicant):?>
    
    <?php //  print_r($applicant['CreditReport']['Addresses']); exit("kk");?>
    <?php  //print_r($applicant['CreditReport']['addresses']); exit("tt");?>
    <?php  //echo $applicant['CreditReport']['firstName']; exit("kk");?>
    <?php  //print_r($applicant['CreditReport']['Status']); exit("kk");?>
    <?php  //print_r($applicant); exit("kk");?>
    
      
    <tr>		
    <th>Applicant	</th>
    <td><?php echo $applicant['FirstName'] ." ".$applicant['LastName'];?></td>
    </tr>
    <tr>
    <tr>		
    <th>Email Address	</th>
    <td><?php echo $applicant['EmailAddress'];?></td>
    </tr>
    <tr>
    <th>Request Created Date	</th>
    <td><?php echo $applicant['RequestCreatedDate'];?></td>
    </tr>
    <tr>
    <th>Request Expiration Date	</th>
    <td><?php echo $applicant['RequestExpirationDate'];?></td>
    </tr>
    <tr>
    <th>Applicant Status	</th>
    <td><?php echo $applicant['ApplicantStatus'];?></td>
    </tr>
    <tr>
    <th>Employment Income	</th>
    <td><?php echo $applicant['EmploymentIncome'];?></td>
    </tr>
    <th>Employment Income Period	</th>
    <td><?php echo $applicant['EmploymentIncomePeriod'];?></td>
    </tr>
     <tr>
    <th>Employment Status	</th>
    <td><?php echo $applicant['EmploymentStatus'];?></td>
    </tr>
    <tr>
    <th>Other Income	</th>
    <td><?php echo $applicant['OtherIncome'];?></td>
    </tr>
    <tr>
    <th>Other Income Period	</th>
    <td><?php echo $applicant['OtherIncomePeriod'];?></td>
    </tr>
    <tr>
    <th>Assets	</th>
    <td><?php echo $applicant['Assets'];?></td>
    </tr>
    
    
    <?php endforeach;?>
    
    </table>
    
    <b>Credit Report</b>
    
    <table class="table table-bordered">
    
    <?php foreach($this->reportData['Applicants'] as $applicant):?>
  
   
     <?php // print_r($applicant['CreditReport']['Status']['ReportDate']); exit("kk");?>
    <tr> 
		<th rowspan="2">Status</th> 
		<th>ReportDate</th> 
		<th>RecordFound</td> 
		<th>FrozenFile</td> 
    </tr> 
    <tr> 
		<td><?php echo $applicant['CreditReport']['Status']['ReportDate']; ?></th> 
		<td><?php echo $applicant['CreditReport']['Status']['RecordFound']; ?></th> 
		<td><?php echo $applicant['CreditReport']['Status']['FrozenFile']; ?></th> 

	</tr>
	
	<?php foreach($applicant['CreditReport']['Addresses'] as $Addresses):?>
    <tr> 
		<th rowspan="2">Addresses</th> 
		<th>StreetAddress</th> 
		<th>City</td> 
		<th>State</td> 

    </tr> 
    <tr> 
		<td><?php echo $Addresses['StreetAddress']; ?></th> 
		<td><?php echo $Addresses['City']; ?></th> 
		<td><?php echo $Addresses['State']; ?></th> 
	

	</tr>

     <?php endforeach;?>
     
     <tr>
     <th colspan="4">ProfileSummary</th>
     </tr>
     <tr>
     <th>PublicRecord Count</th>
     <td colspan="3">
      <?php if($applicant['CreditReport']['ProfileSummary']['PublicRecordCount'] == null): 
      echo "Null";
      else: 
      echo $applicant['CreditReport']['ProfileSummary']['PublicRecordCount'];  
      endif; ?>
     </td>
     </tr>
     <tr>
     <th>PublicRecord Count</th>
     <td colspan="3">
      <?php if($applicant['CreditReport']['ProfileSummary']['InstallBalance'] == null): 
      echo "Null";
      else: 
      echo $applicant['CreditReport']['ProfileSummary']['InstallBalance'];  
      endif; ?>
     </td>
     </tr>
     
     <tr>
     <th>RealEstate Balance</th>
     <td colspan="3">
      <?php if($applicant['CreditReport']['ProfileSummary']['RealEstateBalance'] == null): 
      echo "Null";
      else: 
      echo $applicant['CreditReport']['ProfileSummary']['RealEstateBalance'];  
      endif; ?>
     </td>
     </tr>
     <tr>
     <th>PastDue Amount</th>
     <td colspan="3">
      <?php if($applicant['CreditReport']['ProfileSummary']['PastDueAmount'] == null): 
      echo "Null";
      else: 
      echo $applicant['CreditReport']['ProfileSummary']['PastDueAmount'];  
      endif; ?>
     </td>
     </tr>
     <tr>
     <th>PastDue Amount</th>
     <td colspan="3">
      <?php if($applicant['CreditReport']['ProfileSummary']['PastDueAmount'] == null): 
      echo "Null";
      else: 
      echo $applicant['CreditReport']['ProfileSummary']['PastDueAmount'];  
      endif; ?>
     </td>
     </tr>
     
     
     <?php endforeach;?>
    
    </table>
    
    <b>Criminal Record</b>
    
    <table class="table table-bordered">
    
    <?php foreach($this->reportData['Applicants'] as $applicant):?>
     <tr>
    <th>Category</th>
    <th>State</th>
    <th>Rapsheet</th>
    
    </tr>
    
    <?php foreach($applicant['CriminalRecords'] as $CriminalRecords):?>
    
    <tr>
    <td><?php echo $CriminalRecords['Category'];?></td>
    <td><?php echo $CriminalRecords['State'];?></td>
    <td><?php if(empty($CriminalRecords['Rapsheet'])): echo "Nil" ; else: print_r($CriminalRecords['Rapsheet']);endif;?></td>
    </tr>
    
     <?php endforeach;?>
     
     <?php endforeach;?>
    
    
    </table>
    
    <?php if($this->PaymentpackageData->package_name == 'credit_background_eviction'):?>
    
    <b>Eviction Records</b>
    
    <table class="table table-bordered">
     <?php  //print_r($this->reportData['Applicants']); exit("kk");?>
    <?php foreach($this->reportData['Applicants'] as $applicant):?>
     <tr>
   
    <th>State</th>
    <th>Eviction</th>
    
    </tr>
     
      <?php  //print_r($applicant['EvictionRecords']); exit("kk");?>
    <?php foreach($applicant['EvictionRecords'] as $EvictionRecords):?>
    
    <tr>
    <td><?php echo $EvictionRecords['State'];?></td>
    <td><?php if(empty($EvictionRecords['Eviction'])): echo "Nil" ; else: print_r($EvictionRecords['Eviction']);endif;?></td>
    </tr>
    
     <?php endforeach;?>
     
     <?php endforeach;?>
    
    
    </table>
    
    <?php endif;?>
    
    <?php /* <tr>
    <th>Selected Bundle	</th>
    <td><?php echo $this->reportData['SelectedBundle'];?></td>
    </tr>
     <tr>
    <th>Status	</th>
    <td><?php echo $this->reportData['Status'];?></td>
    </tr>
     <tr>
    <th>Landlord Pays	</th>
    <td><?php if($this->reportData['LandlordPays'] ==1):
    echo "Yes";
    else:
    echo "No";
    endif;
    ?>
    </td>
    </tr>
    <tr>
    <th>Rent	</th>
    <td><?php echo $this->reportData['Rent'];?></td>
    </tr>
    <tr>
    <th>Deposit	</th>
    <td><?php echo $this->reportData['Deposit'];?></td>
    </tr>
    <tr>
    <th>Lease Term In Months	</th>
    <td><?php echo $this->reportData['LeaseTermInMonths'];?></td>
    </tr>
    <tr>
    <th>UnitNumber	</th>
    <td><?php echo $this->reportData['UnitNumber'];?></td>
    </tr> */ ?>
   
    
    
    </div>
    
</div>
    
    
