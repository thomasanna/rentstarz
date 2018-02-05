<script src="/application/modules/User/externals/scripts/message_notififaction.js"></script>
<script src="/application/modules/User/externals/scripts/jQuery.print.js" type="text/JavaScript" language="javascript"></script>
<script>
<?php  
$viewer = Engine_Api::_()->user()->getViewer();
$viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); 
date_default_timezone_set($viewer->timezone);

?>
var viewer_identity='<?php echo $viwer_id; ?>';	
</script>
<?php
    $useragent=$_SERVER['HTTP_USER_AGENT'];
    $iPod = stripos($_SERVER['HTTP_USER_AGENT'],"iPod");
    $iPhone = stripos($_SERVER['HTTP_USER_AGENT'],"iPhone");
    $iPad = stripos($_SERVER['HTTP_USER_AGENT'],"iPad");
    $Android = stripos($_SERVER['HTTP_USER_AGENT'],"Android");
    if( $iPod || $iPhone ||  $Android)  {
        $dev_type= 1; // mobile
    }
    else{
        $dev_type= 2; // system
    }
$settings = Engine_Api::_()->getApi('settings', 'core');
$numberOfReportSharePerDay = $settings->user_numberOfReportSharePerDay;
?>

<div class="generic_layout_container layout_middle">
	<div class="layput_middle_main_div">	
	<div class="sub_head">		
	<div class="transunion_img" style="float: left;margin-right: 15px;"><img src="/application/modules/User/externals/images/transunionicon.png" width="61px" height="67px"></div>
	<div class="link">Amount of shares availble    :  <?php echo $numberOfReportSharePerDay - count($this->ReportshareAtTodayData);?></div>
	<div class="link">Time left before report expires   :  <?php if($this->Time_left_before_report_expires >0): echo $this->Time_left_before_report_expires ." Days"; else: echo "Expired"; endif; ?> </div>
    <div class="link">Credit Score  :  </div>
    </div>	  
       
    <div class="main_content_div">    
   <?php /*  <div class="headings">    
    <!--<div class="link credit_background_tab active">My credit and background check</div>-->
   <div class="link report_tab active">My background check</div>
    <div class="link requested_report_tab">Requested background check</div>
    <div class="link shared_report_tab">Shared background check</div>  
    </div>
    
    <hr style="clear:both;">    */ ?>   
    <?php if($dev_type == 2):?> <!-- if not mobile device-->
    
    <div class="Landlord_requesting_report" style="display:block">
		
		<?php if( $this->error_status==1):?>		
	    <div style="color:red;text-align:center;"><?php echo $this->error_message; ?></div>
	    <?php	endif;?>
	    <?php   if( $this->error_status==0): 			?>
		
		
    <div><button class="print_report" style="margin-left: 0px;">Print</button></div>    
    <div id="application_content">	
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
		<td><?php echo $this->timestamp($applicant['RequestCreatedDate']);?></td>
		</tr>
		<tr>
		<th>Request Expiration Date	</th>
		<td><?php echo $this->timestamp($applicant['RequestExpirationDate']);?></td>
		</tr>
		<tr>
		<th>Applicant Status	</th>
		<td>
		<?php if($applicant['ApplicantStatus'] == 'ReportsAvailable') : echo "Reports Available";
		      elseif($applicant['ApplicantStatus'] == 'ReportsRequested'): echo "Reports Requested";
		      else:
		      echo $applicant['ApplicantStatus'];
		      endif;
		?>
		
		</td>
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
		<tr> 
			<th rowspan="2">Status</th> 
			<th>ReportDate</th> 
			<th>RecordFound</td> 
			<th>FrozenFile</td> 
		</tr> 
		<tr> 
			<td><?php echo $this->timestamp($applicant['CreditReport']['Status']['ReportDate']); ?></th> 
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
		<?php foreach($this->reportData['Applicants'] as $applicant):?>
			<tr>   
			<th>State</th>
			<th>Eviction</th>    
			</tr>    
			<?php foreach($applicant['EvictionRecords'] as $EvictionRecords):?>    
				<tr>
				<td><?php echo $EvictionRecords['State'];?></td>
				<td><?php if(empty($EvictionRecords['Eviction'])): echo "Nil" ; else: print_r($EvictionRecords['Eviction']);endif;?></td>
				</tr>    
			 <?php endforeach;?>     
		 <?php endforeach;?>   
		</table>    
    <?php endif;?>
    </div>
    </div>
    
     <?php  endif; ?>
    <div>Complete your Transunion background check. You will be allowed to send your report to five landlords per day for thirty days. Your credit score will 
not be affected.</div>
    </div> 

    <?php endif;?>
    <?php if($dev_type == 1):?> <!-- for mobile -->
    <div class="Landlord_requesting_report" style="display:block"> 
		
		<?php if( $this->error_status==1):?>		
	    <div style="color:red;text-align:center;"><?php echo $this->error_message; ?></div>
	    <?php	endif;?>
	    <?php   if( $this->error_status==0): 			?>
		
		
    <div><button class="print_report" style="margin-left: 0px;">Print</button></div>    
    <div id="application_content">	
    <span class="application_sub_title"></span>
   
    <div>
    <div class="application_head">Credit Recommendation</div>
    <div class="application_res"><?php echo $this->reportData['CreditRecommendation'];?></div>
    <div class="application_head">Credit Recommendation Policy Text</div>
    <div class="application_res"><?php echo $this->reportData['CreditRecommendationPolicyText'];?></div>
    <?php foreach($this->reportData['Applicants'] as $applicant):?>
	
		<div class="application_head">Applicant	</div>
		<div class="application_res"><?php echo $applicant['FirstName'] ." ".$applicant['LastName'];?></div>
		<div class="application_head">Email Address	</div>
		<div class="application_res"><?php echo $applicant['EmailAddress'];?></div>
		<div class="application_head">Request Created Date	</div>
		<div class="application_res"><?php echo $this->timestamp($applicant['RequestCreatedDate']);?></div>
		<div class="application_head">Request Expiration Date	</div>
		<div class="application_res"><?php echo $this->timestamp($applicant['RequestExpirationDate']);?></div>
		<div class="application_head">Applicant Status	</div>
		<div class="application_res">
			<?php if($applicant['ApplicantStatus'] == 'ReportsAvailable') : echo "Reports Available";
		      elseif($applicant['ApplicantStatus'] == 'ReportsRequested'): echo "Reports Requested";
		      else:
		      echo $applicant['ApplicantStatus'];
		      endif;
		   ?>
		</div>
        <div class="application_head">Employment Income	</div>
		<div class="application_res"><?php echo $applicant['EmploymentIncome'];?></div>   
        <div class="application_head">Employment Income Period	</div>
		<div class="application_res"><?php echo $applicant['EmploymentIncomePeriod'];?></div>   
        <div class="application_head">Employment Status	</div>
		<div class="application_res"><?php echo $applicant['EmploymentStatus'];?></div>   
        <div class="application_head">Other Income	</div>
		<div class="application_res"><?php echo $applicant['OtherIncome'];?></div>   
        <div class="application_head">Other Income Period	</div>
		<div class="application_res"><?php echo $applicant['OtherIncomePeriod'];?></div>   
        <div class="application_head">Assets	</div>
		<div class="application_res"><?php echo $applicant['Assets'];?></div>   
        <div class="application_head">Assets	</div>
		<div class="application_res"><?php echo $applicant['Assets'];?></div>   
		
    <?php endforeach;?>
    <div class="application_head">Credit Report	</div>
   
     <?php foreach($this->reportData['Applicants'] as $applicant):?> 
          <div class="subpart">
		  <div class="application_head">Status	</div>
		  <div style="clear:both">
		  <span class="application_head sub_headpart">ReportDate	</span>
		  <span class="application_res sub_res"><?php echo $this->timestamp($applicant['CreditReport']['Status']['ReportDate']);?></span> 
		  </div>
		   <div style="clear:both">
		  <span class="application_head sub_headpart">RecordFound	</span>
		  <span class="application_res sub_res"><?php echo $applicant['CreditReport']['Status']['RecordFound'];?></span> 
		  </div>
		   <div style="clear:both">
		  <span class="application_head sub_headpart">FrozenFile	</span>
		  <span class="application_res sub_res"><?php echo $applicant['CreditReport']['Status']['FrozenFile'];?></span> 
		  </div>
		  </div> 
		  <?php foreach($applicant['CreditReport']['Addresses'] as $Addresses):?>
		      <div class="subpart">
			  <div class="application_head">Addresses	</div>
			  <div style="clear:both">
			  <span class="application_head sub_headpart">StreetAddress	</span>
			  <span class="application_res sub_res"><?php echo $Addresses['StreetAddress'];?></span> 
			  </div>
			  <div style="clear:both">
			  <span class="application_head sub_headpart">City	</span>
			  <span class="application_res sub_res"><?php echo $Addresses['City'];?></span> 
			  </div>
			  <div style="clear:both">
			  <span class="application_head sub_headpart">State	</span>
			  <span class="application_res sub_res"><?php echo $Addresses['State'];?></span> 
			  </div>
			  </div> 
		  <?php endforeach;?>
		   <div class="subpart">
		  <div class="application_head">ProfileSummary	</div>
		   <div style="clear:both">
		  <span class="application_head sub_headpart">PublicRecord Count	</span>
		  <span class="application_res sub_res">
		   <?php if($applicant['CreditReport']['ProfileSummary']['PublicRecordCount'] == null): 
			  echo "Null";
			  else: 
			  echo $applicant['CreditReport']['ProfileSummary']['PublicRecordCount'];  
			  endif; ?>
		  </span> 
		  </div>
		   <div style="clear:both">
		  <span class="application_head sub_headpart">RealEstate Balance	</span>
		  <span class="application_res sub_res">
		   <?php if($applicant['CreditReport']['ProfileSummary']['RealEstateBalance'] == null): 
			  echo "Null";
			  else: 
			  echo $applicant['CreditReport']['ProfileSummary']['RealEstateBalance'];  
			  endif; ?>
		  </span> 
		  </div>
		   <div style="clear:both">
		  <span class="application_head sub_headpart">PastDue Amount	</span>
		  <span class="application_res sub_res">
		   <?php if($applicant['CreditReport']['ProfileSummary']['PastDueAmount'] == null): 
			  echo "Null";
			  else: 
			  echo $applicant['CreditReport']['ProfileSummary']['PastDueAmount'];  
			  endif; ?>
		  </span> 
		  </div>
		  </div> 
     <?php endforeach;?> 
       <div class="subpart"> 
      <div class="application_head">Criminal Record	</div>
      <?php foreach($this->reportData['Applicants'] as $applicant):?>
		   <?php foreach($applicant['CriminalRecords'] as $CriminalRecords):?>   
		   <div style="clear:both"> 
		   <span class="application_head sub_headpart">Category	</span>
		   <span class="application_res sub_res"><?php echo $CriminalRecords['Category'];?></span> 
		   </div>
		   <div style="clear:both">  
		   <span class="application_head sub_headpart">State	</span>
		   <span class="application_res sub_res"><?php echo $CriminalRecords['State'];?></span> 
		   </div>
		   <div style="clear:both"> 
		   <span class="application_head sub_headpart">Rapsheet	</span>
		   <span class="application_res sub_res"><?php if(empty($CriminalRecords['Rapsheet'])): echo "Nil" ; else: print_r($CriminalRecords['Rapsheet']);endif;?></span> 
		   </div> 
		   <?php endforeach;?> 
      <?php endforeach;?> 
      </div> 
      <?php if($this->PaymentpackageData->package_name == 'credit_background_eviction'):?>  
       <div class="subpart">  
       <div class="application_head">Eviction Records	</div>
       <?php foreach($this->reportData['Applicants'] as $applicant):?>
		   <?php foreach($applicant['EvictionRecords'] as $EvictionRecords):?>    
		    <div style="clear:both"> 
		    <span class="application_head sub_headpart">State	</span>
		    <span class="application_res sub_res"><?php echo $EvictionRecords['State'];?></span>
		    </div> 
		    <div style="clear:both"> 
		    <span class="application_head sub_headpart">Eviction	</span>
		    <span class="application_res sub_res"><?php if(empty($EvictionRecords['Eviction'])): echo "Nil" ; else: print_r($EvictionRecords['Eviction']);endif;?></span>
		   </div> 
		   </div> 
		   <?php endforeach;?>
       <?php endforeach;?>
       </div> 
      <?php endif;?>
      
    </div>
    
    </div>
    
     <?php  endif; ?>

    </div> 

     <?php  endif; ?><!-- end for mobile -->
   

   
   
    <!-- end my background check-->

    <div class="report_requested_list" style="display:none"> <!-- start requested background check-->
    
   <?php if(count($this->ReportrequestData)>0):?>   
	   <?php 
		 $viewHelperObj = $this->getHelper('User');   	
		 $onlineuserIds = $viewHelperObj->onlineusers();	
		?>
	   <?php foreach($this->ReportrequestData as $data):?>
		   
		   <div class="request_li">	   
		  	   
			<?php if(in_array($data['landlord_id'],$onlineuserIds)): ?>			
				<span class="led-green" style="top: 49px; margin-left: 36px;display:block;"></span>			
			<?php endif; ?>	   
			<?php  $userTable = Engine_Api::_()->getDbtable('users', 'user');
				  $userData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $data['landlord_id']));?>	
		   <span style="float:left">  
			<?php echo $this->htmlLink($userData->getHref(), $this->itemPhoto($userData, 'thumb.icon', $userData->getTitle()), array('title'=>$userData->getTitle())) ?>
		   </span> 	  
		  
		   <div class="username col-md-4 col-sm-4 col-xs-12">  <?php echo $userData->displayname;?></div>	 
		   <div class="username col-md-3 col-sm-3 col-xs-12"></div>
		   <div class="requested_date col-md-3 col-sm-4 col-xs-12"><?php echo $this->timestamp($data['requested_date']); ?> </div>   
		   </div>
		   <hr>		   
	   <?php endforeach;?>
   
   <?php else:  ?>   
        <div style="text-align: center;">No one has requested yet</div>   
   <?php endif;?>   
    
    </div><!-- end requested background check-->
    
    <div class="shared_background_check" style="display:none"> <!-- start ahared background check-->
		
		
	<?php if(count($this->ReportsharedActiveData)>0):?>	   
	   <?php $viewHelperObj = $this->getHelper('User'); 
			$onlineuserIds = $viewHelperObj->onlineusers();	
		?>
	   <?php foreach($this->ReportsharedActiveData as $data):?>   
		   <div class="request_li">	   
	   
			<?php if(in_array($data['report_shared_with'],$onlineuserIds)): ?>			
				<span class="led-green" style="top: 49px; margin-left: 36px;display:block;"></span>			
			<?php endif; ?>	   
			<?php  $userTable = Engine_Api::_()->getDbtable('users', 'user');
				   $userData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $data['report_shared_with']));?>	   
			<span style="float:left">  
			<?php echo $this->htmlLink($userData->getHref(), $this->itemPhoto($userData, 'thumb.icon', $userData->getTitle()), array('title'=>$userData->getTitle())) ?>
		    </span> 
		   <div class="username col-md-4 col-sm-4 col-xs-12">  <?php echo $userData->displayname;?></div>	 	   
		   <div class="username col-md-3 col-sm-3 col-xs-12"></div>
		   <div class="requested_date col-md-3 col-sm-4 col-xs-12"><?php echo $this->timestamp($data['created_at']); ?> </div>
		   </div>
			<hr>
	   <?php endforeach;?>   
   <?php else: ?>   
         <div style="text-align: center;">No shares</div>   
   <?php endif;?>   
    </div> <!-- end ahared background check-->
   </div>

</div>

</div>

<script>


	jQuery('#global_header').append('<div class="affix-top extra_header mob_bar_disable_particular_pages" data-spy="affix" data-offset-top="100">'+
	'<div id="global_content">'+
	'<div class="extra_header_content">'+	
	'<ul class="navigation">'+
    '<li class="link report_tab active" ><a href="javascript:void(0)">My background check</a></li>'+
    '<li class="link requested_report_tab"><a href="javascript:void(0)">Requested background check</a></li>'+
    '<li  class="link shared_report_tab"><a href="javascript:void(0)">Accepted Applications</a></li>'+
    '</ul>'+    
	'</div>'+
	'</div>'+
	'</div>');

jQuery('.sub_header_dropdown').html(
                   '<select id = "sub_header_heding_select" class="input-box">'+
                   ' <option  selected value="My background check">My background check</option>'+
                   ' <option   value="Requested background check">Requested background check</option>'+
                   ' <option   value="Accepted Application">Accepted Applications</option>'+
                   ' </select>'
    );

jQuery(document).on('change','#sub_header_heding_select',function(){
	 var chValue=jQuery('#sub_header_heding_select').val();
	 
	 if(chValue == 'My background check' ){		 
		    jQuery('.report_tab').trigger( 'click' );
		    jQuery('.sub_header_heding_select').val( 'My background check' );		    
	 }
	 if(chValue == 'Requested background check' ){		 
		    jQuery('.requested_report_tab').trigger( 'click' );
		    jQuery('.sub_header_heding_select').val( 'Requested background check' );		    
	 }
	 if(chValue == 'Accepted Application' ){		 
		    jQuery('.shared_report_tab').trigger( 'click' );
		    jQuery('.sub_header_heding_select').val( 'Accepted Application' );		    
	 }
});

jQuery('.credit_background_tab').on('click',function(){

	jQuery('.credit_background_tab').addClass('active');
	jQuery('.report_tab').removeClass('active');
	jQuery('.shared_report_tab').removeClass('active');
	jQuery('.requested_report_tab').removeClass('active');
	jQuery('.My_credit_and_background_check').css('display','block');
	jQuery('.Landlord_requesting_report').css('display','none');
	jQuery('.shared_background_check').css('display','none');
	
});


jQuery('.report_tab').on('click',function(){

	jQuery('.report_tab').addClass('active');
	jQuery('.credit_background_tab').removeClass('active');
	jQuery('.shared_report_tab').removeClass('active');
	jQuery('.requested_report_tab').removeClass('active');
	jQuery('.Landlord_requesting_report').css('display','block');
	jQuery('.My_credit_and_background_check').css('display','none');
	jQuery('.shared_background_check').css('display','none');
	jQuery('.report_requested_list').css('display','none');
	
});
	jQuery('.requested_report_tab').on('click',function(){

	jQuery('.requested_report_tab').addClass('active');
	jQuery('.credit_background_tab').removeClass('active');
	jQuery('.report_tab').removeClass('active');
	jQuery('.shared_report_tab').removeClass('active');
	jQuery('.Landlord_requesting_report').css('display','none');
	jQuery('.My_credit_and_background_check').css('display','none');
	jQuery('.shared_background_check').css('display','none');
	jQuery('.report_requested_list').css('display','block');
	
});

jQuery('body').on('click', '.shared_report_tab', function(event){

	jQuery('.shared_report_tab').addClass('active');
	jQuery('.requested_report_tab').removeClass('active');
	jQuery('.credit_background_tab').removeClass('active');
	jQuery('.report_tab').removeClass('active');
	jQuery('.Landlord_requesting_report').css('display','none');
	jQuery('.My_credit_and_background_check').css('display','none');
	jQuery('.report_requested_list').css('display','none');
	jQuery('.shared_background_check').css('display','block');
	
});

jQuery('body').on('click', '.print_report', function(event){

	          jQuery("#application_content").print({
                    //Use Global styles
                    globalStyles : false,
                    //Add link with attrbute media=print
                    mediaPrint : false,
                    //Custom stylesheet
                    stylesheet : "http://fonts.googleapis.com/css?family=Inconsolata",
                    //Print in a hidden iframe
                    iframe : false,
                    //Don't print this
                    noPrintSelector : ".avoid-this",
                    //Add this at top
                    prepend : "Hello World!!!<br/>",
                    //Add this on bottom
                    append : "<br/>Buh Bye!",
                 
                });

});
        
</script>

