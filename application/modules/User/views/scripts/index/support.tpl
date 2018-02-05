<?php
$actual_link = (isset($_SERVER['HTTPS']) ? "https" : "http") . "://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
$parts = parse_url($actual_link);
parse_str($parts['query'], $query);
$pageparam =  $query['page']; 
    $viewer        =   Engine_Api::_()->user()->getViewer();
 
    $userHelperObj  = $this->getHelper('User');
    $userdetails    = $userHelperObj->getuserDetails($viewer->getIdentity());
    $package_type   = $userdetails['user_package'];
    $profile_type   = $userdetails['profile_type'];
?>
<link rel="stylesheet" type="text/css" href="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/styles/faq.css" />
<script type="text/javascript" src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/scripts/faq.js"></script>
<script src="/application/modules/User/externals/scripts/message_notififaction.js"></script>
<div class="generic_layout_container layout_main">
   <div class="generic_layout_container layout_middle">
      <div class="agreement_content">
        <!-- <P STYLE="margin-bottom: 0.11in"><FONT SIZE=4 STYLE="font-size: 16pt"><B>FAQ</B></FONT></P>-->
         <div class="faq_body_li">
        <?php /* <div class="faq_left_container">
         <ul>
         <li class="faq_basic_info_menu active">Basic Info</li>
         <?php if($profile_type  =='landlord'):?>
         <li class="faq_upgrade_menu">Upgrade</li>
         <?php endif;?>
         <li class="faq_background_check_menu">Background Check</li>
         <li class="faq_contact_us_menu">Contact Us</li>
         </ul>
         
         </div> */?>
         <div class="faq_container faq_basic_info_container"  style="display:none">
            <!-- Question -->
            <div class="faq">
               <div class="faq_question">
                  <p>Is Rentstarz a real estate company?</p>
               </div>
               <div class="faq_answer_container">
                  <div class="faq_answer">
                     <P STYLE="margin-bottom: 0.11in; line-height: 150%">
						 No, we are not a real estate company. We are a social network that focuses on the rental market.
                     </P>
                     <ul>
                     </ul>
                  </div>
               </div>
            </div>
            <!-- Question -->
            <div class="faq" id="barchart">
               <div class="faq_question">
                  <p>How do I use the scout board?</p>
               </div>
               <div class="faq_answer_container">
                  <div class="faq_answer">
                     <P STYLE="margin-bottom: 0.11in; line-height: 150%">
						 Renters post ads for the type of rental they are looking for, Landlords receives the post and then filters them based on what they have available. The scout board is a way of matching renters to landlords.
                     </P>
                  </div>
               </div>
            </div>
            <!-- Question -->
            <div class="faq">
               <div class="faq_question">
                  <p>How do I use the documents page?</p>
               </div>
               <div class="faq_answer_container">
                  <div class="faq_answer">
                     <P STYLE="margin-bottom: 0.11in; line-height: 150%">
						 The Documents page allows you to upload files and folders you want to share. Use this page to exchange rental documents such as reference letters, leases, or pay stubs. Landlords and renters can request these documents but it’s up to you to shared them.
                     </P>
                     <P STYLE="margin-bottom: 0.11in; line-height: 150%">
						 The "Shared With Me" page shows the people that have received your documents. Here, you can also edit the document page and withdraw access to any previously shared document.
                     </P>
                     <P STYLE="margin-bottom: 0.11in; line-height: 150%">
						 It is advised that you upload your documents so that you can share them when the request is made. Please do not have your social security number, bank account number or any other sensitive information visible. 
                     </P>
                  </div>
               </div>
            </div>
            <!-- Question -->
            <div class="faq">
               <div class="faq_question">
                  <p>How do I submit a rental application?</p>
               </div>
               <div class="faq_answer_container">
                  <div class="faq_answer">
                     <P STYLE="margin-bottom: 0.11in; line-height: 150%">
						 The rental application is submitted after viewing a property, completing the application and clicking the submit button. If you are not verified, you will not be able to submit your request. 
                     </P>
                     <P STYLE="margin-bottom: 0.11in; line-height: 150%">
						 When you submit an application, you will be prompted to complete a background check. If you have already completed a background check, your application will be submitted immediately. You can revise your application adding or deleting info before you submit it. 
                  </div>
               </div>
            </div>
            <!-- Question -->
            <div class="faq">
               <div class="faq_question">
                  <p>How do I avoid scams?</p>
               </div>
               <div class="faq_answer_container">
                  <div class="faq_answer">
                     <p>
						 One of our major focuses is security. Although, we are not responsible for an individual or members’ malicious acts, we are dedicated and vigilant about weeding out unscrupulous members. Users should report and block unscrupulous characters.
                     </p>
                     <p>
						 A landlord might request a member’s social security number but it is the member’s responsibility for when they share their private information. 
                     </p>
                     <p>
						 Never place a deposit directly to a landlord account online. Deposits should be given directly to a landlord after the signing of a lease. 
                     </p>
                  </div>
               </div>
            </div>
           
            <!-- Question -->
            <div class="faq">
               <div class="faq_question">
                  <p>Does TransUnion report unpaid rent and employment history?</p>
               </div>
               <div class="faq_answer_container">
                  <div class="faq_answer">
                     <P STYLE="margin-bottom: 0.11in; line-height: 150%">
						 They do not. However, Rentstarz provides an alternative called "Ratestarz" where members rate each other.
                     </P>
                  </div>
               </div>
            </div>        
           
            <!-- Question -->
            <div class="faq">
               <div class="faq_question">
                  <p>Can
                     I save my background check?
                  </p>
               </div>
               <div class="faq_answer_container">
                  <div class="faq_answer">
                     <P STYLE="margin-bottom: 0.11in; line-height: 150%">Yes, you can save
                        and print your report. However, after thirty days, you will not have
                        access to that report from the TransUnion. Landlords may request a
                        more recent one. At that point you will have to order a new report. 
                        You will only be charged $29.99 for a background and credit check and
                        $39.99 with eviction.
                     </P>
                  </div>
               </div>
            </div>           
            <!-- Question -->
            <div class="faq">
               <div class="faq_question">
                  <p>How
                     do landlords choose what shows up on a renters background check?
                  </p>
               </div>
               <div class="faq_answer_container">
                  <div class="faq_answer">
                     <P STYLE="margin-bottom: 0.11in; line-height: 150%">Our partner at
                        TransUnion offers recommendations based on the landlords criteria.
                        TransUnion will interrupt any applications base on that criteria once
                        you post a property. Those criteria are foreclosures, bankruptcy,
                        credit card payments and rent to income ratio. 
                     </P>
                  </div>
               </div>
            </div>
            <!-- Question -->
            <div class="faq">
               <div class="faq_question">
                  <p>Why
                     are Rentstarz rates higher than other background checks?
                  </p>
               </div>
               <div class="faq_answer_container">
                  <div class="faq_answer">
                     <P STYLE="margin-bottom: 0.11in; line-height: 150%">We don't charge a
                        percent or commission for using our platforms or services like real
                        estate agencies do. We pay TransUnion for they services as well as
                        staff and other overheads. To maintain the highest quality of service
                        we charge a bit more for the background.
                     </P>
                  </div>
               </div>
            </div>
            <!-- Question -->
           <?php /* <div class="faq">
               <div class="faq_question">
                  <p>Why
                     can I not change my name and birth date after I sign up?
                  </p>
               </div>
               <div class="faq_answer_container">
                  <div class="faq_answer">
                     <P STYLE="margin-bottom: 0.11in; line-height: 150%">As part of our
                        security feature and to maintain a high level of integrity, we do not
                        allow users to change their names and birthday once they complete the
                        sign-up process. 
                     </P>
                  </div>
               </div>
            </div> */?>
           
            <!-- Question -->
            <div class="faq">
               <div class="faq_question">
                  <p>What
                     is Ratestarz?
                  </p>
               </div>
               <div class="faq_answer_container">
                  <div class="faq_answer">
                     <P STYLE="margin-bottom: 0.11in; line-height: 150%">
						 Ratestarz is a feature where members volunteer to rate each other after the signing of a lease and one month of rental has occurred. Ratestarz is a great feature for both landlords and renters. It is a way of establishing credibility among other members on the site. A renter can move and easily be accepted by another landlord on the site because of his ratings. Or the opposite, a renter could have skipped on his rent and trash the rental. Landlords will know to be wary of that renter. A landlord may be neglecting his property and renters can reflect that in their ratings warning other potential renters. The Stars system is a check on both landlords and renters to cooperate and maintain their rentals. Landlords must upgrade to our premium feature Landlord Pro to have this 
                     </P>
                  </div>
               </div>
            </div>
            <!-- Question -->
            <div class="faq">
               <div class="faq_question">
                  <p>How
                     am I rated?
                  </p>
               </div>
               <div class="faq_answer_container">
                  <div class="faq_answer">
                     <P STYLE="margin-bottom: 0.11in; line-height: 150%">
						 Users are given a rating of one to five stars based on a survey questionnaire conducted by both members of the lease. Every month the same survey is given and the ratings are updated. A history of the ratings is shown and can be viewed by the members in Rentstarz.
                     </P>
                  </div>
               </div>
            </div>
            <!-- Question -->
            <div class="faq">
               <div class="faq_question">
                  <p>How
                     do I challenge a negative rating?
                  </p>
               </div>
               <div class="faq_answer_container">
                  <div class="faq_answer">
                     <P STYLE="margin-bottom: 0.11in; line-height: 150%">
						 Both parties can submit a request at support@rentstarz.com and a Rentstarz customer support team member will respond and mediate the dispute. 
                     </P>
                     <P STYLE="margin-bottom: 0.11in; line-height: 150%">
						 Note: We cannot change a rating. We can re-submit the rating to be changed by the other member 
                     </P>
                  </div>
               </div>
            </div>
            <!-- Question -->
            <div class="faq">
               <div class="faq_question">
                  <p>Is
                     video interview free and who pays?
                  </p>
               </div>
               <div class="faq_answer_container">
                  <div class="faq_answer">
                     <P STYLE="margin-bottom: 0.11in; line-height: 150%">
						 Video interviews are free only to premium users. We charge $1.99 per interview regardless of the time spent. The initiator of the interview will be charge. We recommended video interview before scheduling a viewing this allows both members to make good use of their available time.
                     </P>
                  </div>
               </div>
            </div>
            <!-- Question -->

            
         </div> 
         
         
         
           <!-- upgrade start-->
           
         
      
         <div class="faq_container faq_upgrade_container" style="display:none">
			  <?php if($profile_type == 'landlord'): ?> 
			 <div class="faq_upgrade">
				 <div class="faq_upgrade_package_content" style="text-align: center;">				 
				 <div class="faq_upgrade_package" style="display: inline-block;">
				 <?php  $settings = Engine_Api::_()->getApi('settings', 'core');  ?>
				 <?php if($package_type == ''):?>
				 <div class="package1 landlord_pro_package">
                  <div class="part1"> Landlord Pro</div>
                  <div class="part2">Premium upgrade to scout master</div>
                  <div class="part2">Free video interviews</div>
                  <div class="part2">10 listing at a time</div>
                  <div class="part2">Upgrade to document pro</div>
                  <div class="part2">Email support</div>
                  <div class="part2">
					  <span style="font-size: 20px;"><?php echo '$' . $settings->user_landlordProPrice ; ?></span><br>
					  <span style="color: #999;">per month </span>
					  
				 </div>				 
				 </div>
				 <?php endif;?>
				 <?php if($package_type == '' || $package_type == 'landlord_pro_package'):?>
				 <div class="package1 management_gold_package">
					 
				 <div class="part1"> Management Gold</div>
                  <div class="part2">Landlord Pro features</div>
                  <div class="part2">Upto 100 listing at a time</div>
                  <div class="part2">Assign account manager</div>
                  <div class="part2">
					  <span style="font-size: 20px;"><?php echo '$' . $settings->user_managementGoldPrice ; ?></span><br>
					    <span style="color: #999;">per month </span>
					  
				 </div>
				 
				  </div>
				  <?php endif;?>
				 </div>
				 
				 </div>

             </div>
              <?php endif;?>
             <div class="faq_upgrade">
				   <div class="faq_upgrade_head" style="text-align: center;font-weight: bold;clear:both;font-size: 17px;">You can stay basic but why?</div>
				   <div class="faq_upgrade_p">
					   <p>
						Rentstarz premium packages are design for lanlords and property
						managers to run their business efficently and cost effectively.
						Anytime a tenant moves out you run the risk of loosing thousands of
						dollars in revenue that a deposit does not cover. It make sense to
						get that rental rented out to a new renter as quickly as possibble.
						Rentstarz is the place that makes this happen.</p>               
				   </div>
               </div>
              <div class="faq_upgrade">				 
				   <div class="faq_upgrade_p">
						  <div style="font-weight: bold; margin-bottom: 12px;">Landlord Pro</div>
						   <p>
						   The Landlord Pro is a tool that enables landlords to be cost and time efficient.
							The scoutboard in Landlord Pro allows you to organize and manage your scouts (tenants).
							Also included in Landlord Pro is an upgraded documents folder. In the documents folder,
							landlords will find local rental eviction court documents and exclusive editorials. Other
							advantages of the Landlord Pro are free video interviews and access to the lease builder and
							maintenance manager apps. Limited scout slots are also available in Landlord Pro.</p>
					   
					</div>
               </div>
              <div class="faq_upgrade">				 
				   <div class="faq_upgrade_p">
						<div style="font-weight: bold; margin-bottom: 12px;">Management Gold</div>
				        <p>
					    Management Gold is suited for property manage companies with
						thousands of units. Management Gold offers unlimited scout slots, an assigned account
						manager, plus all the advantages of the Landlord.</p>
				   
				   </div>
               </div>          
             
         </div>
         
         <!-- upgrade end-->
         
                   <!-- background check start-->
         

            <div class="faq_container faq_background_check_container" style="display:none">
				 <!-- Question -->
            <div class="faq">
               <div class="faq_question">
                  <p>What
                     do TransUnion background and credit checks consist of?
                  </p>
               </div>
               <div class="faq_answer_container">
                  <div class="faq_answer">
                     <P STYLE="margin-bottom: 0.11in; line-height: 150%">You get a
                        comprehensive report from the nation's leading credit bureau. 
                     </P>
                     <P STYLE="margin-bottom: 0.11in; line-height: 150%">You will receive
                        a fully detailed credit report, criminal and background reports from
                        45 states, most wanted databases, national sex offender public
                        registry and a resident score. You can get the details behind that
                        score for an additional fee. 
                     </P>
                  </div>
               </div>
            </div>
            
             <!-- Question -->
            <div class="faq">
               <div class="faq_question">
                  <p>How much does the background check cost and who pays?</p>
               </div>
               <div class="faq_answer_container">
                  <div class="faq_answer">
                     <P STYLE="margin-bottom: 0.11in; line-height: 150%">
						 Background checks are $29.99 and $39.99 with eviction. How ever your first background is slightly higher due to one time enrollment fee. Typically it is the renter who pays for the background check but landlords can also pay for renters. 
                     </P>
                  </div>
               </div>
            </div>
            <!-- Question -->
            <div class="faq">
               <div class="faq_question">
                  <p>How often can the renter share their TransUnion background checks?</p>
               </div>
               <div class="faq_answer_container">
                  <div class="faq_answer">
                     <P STYLE="margin-bottom: 0.11in; line-height: 150%">
						 Renters are allowed to send five reports per day for thirty days to five different landlords:
                     </P>
                  </div>
               </div>
            </div>
            <!-- Question -->
            
            
            <!-- Question -->
            <div class="faq">
               <div class="faq_question">
                  <p>Is my credit affected when I run a rental check?</p>
               </div>
               <div class="faq_answer_container">
                  <div class="faq_answer">
                     <P STYLE="margin-bottom: 0.11in; line-height: 150%">
						 Your credit is not affected. TransUnion Credit Bureau conducts what is referred to as a soft pull, a credit check, a background check and a rental score are generated. 
                     </P>
                     <P STYLE="margin-bottom: 0.11in; line-height: 150%"><A NAME="_GoBack"></A>
                        Your social security number and other private information are secure and safe. We don't share bank accounts or social with anyone not even landlords.
                     </P>
                  </div>
               </div>
            </div>
             <!-- Question -->
            <div class="faq">
               <div class="faq_question">
                  <p>When am I charge?</p>
               </div>
               <div class="faq_answer_container">
                  <div class="faq_answer">
                     <P STYLE="margin-bottom: 0.11in; line-height: 150%">
						 You are charged after you completes the application request and successfully pass the identity authentication online and choose a package.
                     </P>
                  </div>
               </div>
            </div>
             <!-- Question -->
            <div class="faq">
               <div class="faq_question">
                  <p>Can I get a refund?</p>
               </div>
               <div class="faq_answer_container">
                  <div class="faq_answer">
                     <P STYLE="margin-bottom: 0.11in; line-height: 150%">
						 There are no refunds once you've successfully submitted your order. Rentstarz cannot under any circumstance give you a refund.
                     </P>
                  </div>
               </div>
            </div>
             <!-- Question -->
            <div class="faq">
               <div class="faq_question">
                  <p>Can I save my background check?</p>
               </div>
               <div class="faq_answer_container">
                  <div class="faq_answer">
                     <P STYLE="margin-bottom: 0.11in; line-height: 150%">
                      Yes, you can save and print your report. However, after thirty days, you will not have access to that report from the TransUnion. Landlords may request a more recent one. At that point you will have to order a new report.  You will only be charged $29.99 for a background and credit check and $39.99 with eviction.
                     </P>
                  </div>
               </div>
            </div>
             <!-- Question -->
            <div class="faq">
               <div class="faq_question">
                  <p>What do TransUnion background and credit checks consist of?</p>
               </div>
               <div class="faq_answer_container">
                  <div class="faq_answer">
                     <P STYLE="margin-bottom: 0.11in; line-height: 150%">
						You get a comprehensive report from the nation's leading credit bureau. 
						You will receive a fully detailed credit report, criminal and background reports from 45 states, most wanted databases, national sex offender public registry and a resident score. You can get the details behind that score for an additional fee. 
					 </P>
                  </div>
               </div>
            </div>
             <!-- Question -->
            <div class="faq">
               <div class="faq_question">
                  <p>How do landlords choose what shows up on a renters background check?</p>
               </div>
               <div class="faq_answer_container">
                  <div class="faq_answer">
                     <P STYLE="margin-bottom: 0.11in; line-height: 150%">
						Our partner at TransUnion offers recommendations based on the landlords criteria. TransUnion will interrupt any applications base on that criteria once you post a property. Those criteria are foreclosures, bankruptcy, credit card payments and rent to income ratio. 
					 </P>
                  </div>
               </div>
            </div>
             <!-- Question -->
            <div class="faq">
               <div class="faq_question">
                  <p>Why are Rentstarz rates higher than other background checks?</p>
               </div>
               <div class="faq_answer_container">
                  <div class="faq_answer">
                     <P STYLE="margin-bottom: 0.11in; line-height: 150%">
                      We don't charge a percent or commission for using our platforms or services like real estate agencies do. We pay TransUnion for they services as well as staff and other overheads. To maintain the highest quality of service we charge a bit more for the background.
					 </P>
                  </div>
               </div>
            </div>
             <!-- Question -->
            <div class="faq">
               <div class="faq_question">
                  <p>Are
                     Landlords verified?
                  </p>
               </div>
               <div class="faq_answer_container">
                  <div class="faq_answer">
                     <P STYLE="margin-bottom: 0.11in; line-height: 150%">
						 We provide a service that demands trust, high security, and utmost integrity so we implement security to enforce those values. It is not enough to ask members to be truthful and honest we guide them. All members undergo the TransUnion identity verification check. Being verified allows users to know that your identity has been confirmed and you are who you say you are. 
                     </P>
                  </div>
               </div>
            </div>
            
            
			</div>

         <!-- background check end-->         
         
			 <div class="faq_container faq_contact_container" style="display:none">
				 <div class="success_msg" style="color: #008000;"></div>
				  <!--<div class="faq_upgrade_head" style="text-align: center;font-weight: bold;padding: 12px;">Email support are for premium users (Landlord Pro and
                   Management Gold).</div>-->

             <div class="contact_rec">
              <div class="rec">
              <div class="pro_field_wrapper" style="text-align: center;">
                            <input name="your_name" type="text" maxlength="65" placeholder="Your Name" id="your_name" class="prty_field input-box" autofocus="" style="background-color: #ffff !important;">
                             <span style="color:red;font-weight: bolder;">*</span> 
               </div>
               <br>
              <div class="pro_field_wrapper" style="text-align: center;">
                            <input name="your_email" type="text" maxlength="65" placeholder="Your Email" id="your_email" class="prty_field input-box" autofocus="" style="background-color: #ffff !important;">
                             <span style="color:red;font-weight: bolder;">*</span> 
              </div><br>
              <div class="pro_field_wrapper" style="text-align: center;">
                 <textarea name="your_message"  placeholder="Your Message" id="your_message" class="prty_field inputbox_textarea" style="background-color: #ffff !important;"></textarea>
                  <span style="color:red;font-weight: bolder;">*</span>    
               </div><br>

              <button class="contact_btn" >Send Message</button>
              <div class="loader" style="display:none;"></div>

              </div>
             </div>
			</div>

         </div>

		</div>
 
      </div>
   </div>
</div>

<script type="text/javascript">
	
	jQuery('#global_header').append('<div class="affix-top extra_header mob_bar_disable_particular_pages" data-spy="affix" data-offset-top="100">'+
	'<div id="global_content">'+
	'<div class="extra_header_content">'+
	
	'<ul class="navigation">'+
    '<li class="faq_basic_info_menu active"><a href="javascript:void(0)">Basic Info</a></li>'+
     <?php if($profile_type == 'landlord'): ?> 
    '<li class="faq_upgrade_menu"><a href="javascript:void(0)">Upgrade</a></li>'+
    <?php endif;?>
    '<li class="faq_background_check_menu"><a href="javascript:void(0)">Background Check</a></li>'+
    '<li class="faq_contact_us_menu"><a href="javascript:void(0)">Contact Us</a></li>'+
    '</ul>'+
    
	'</div>'+
	'</div>'+
	'</div>');	
	jQuery('.sub_header_dropdown').html(
                   '<select id = "sub_header_heding_select" class="input-box">'+
                   ' <option  selected value="Basic Info">Basic Info</option>'+
                   <?php if($profile_type == 'landlord'): ?> 
                   ' <option  value="Upgrade">Upgrade</option>'+
                   <?php endif;?>
                   ' <option  value="Background Check">Background Check</option>'+
                   ' <option  value="Contact Us">Contact Us</option>'+
                   ' </select>'
    );
    
    jQuery( "#sub_header_heding_select" ).change(function() {

    var head_title= jQuery("#sub_header_heding_select").val();
    if(head_title =='Basic Info'){
		jQuery('.faq_basic_info_menu').trigger( 'click' );        
    }
    if(head_title =='Upgrade'){
		jQuery('.faq_upgrade_menu').trigger( 'click' );        
    }
    if(head_title =='Background Check'){
		jQuery('.faq_background_check_menu').trigger( 'click' );        
    }
    if(head_title =='Contact Us'){
		jQuery('.faq_contact_us_menu').trigger( 'click' );        
    }
    

});
jQuery( document ).ready(function() {


var pageparam = '<?php echo $pageparam;?>';
if(pageparam == 'upgradePackage'){
     jQuery('.faq_upgrade_menu').trigger( 'click' );  
}
else{
	jQuery('.faq_basic_info_menu').trigger( 'click' );      
}

});

jQuery('.faq_basic_info_menu').on('click',function(){	
	 jQuery('.faq_basic_info_menu').addClass('active');
	 jQuery('.faq_upgrade_menu').removeClass('active');
	 jQuery('.faq_background_check_menu').removeClass('active');
	 jQuery('.faq_contact_us_menu').removeClass('active');
	 jQuery('.faq_basic_info_container').css('display','block');
	 jQuery('.faq_upgrade_container').css('display','none');
	 jQuery('.faq_background_check_container').css('display','none');
	 jQuery('.faq_contact_container').css('display','none'); 

 });
jQuery('.faq_upgrade_menu').on('click',function(){  
	 jQuery('.faq_basic_info_menu').removeClass('active');
	 jQuery('.faq_upgrade_menu').addClass('active');
	 jQuery('.faq_background_check_menu').removeClass('active');
	 jQuery('.faq_contact_us_menu').removeClass('active');
	 jQuery('.faq_basic_info_container').css('display','none');
	 jQuery('.faq_upgrade_container').css('display','block');
	 jQuery('.faq_background_check_container').css('display','none');
	 jQuery('.faq_contact_container').css('display','none');
 });
jQuery('.faq_background_check_menu').on('click',function(){ 
	 jQuery('.faq_basic_info_menu').removeClass('active');
	 jQuery('.faq_upgrade_menu').removeClass('active');
	 jQuery('.faq_background_check_menu').addClass('active');
	 jQuery('.faq_contact_us_menu').removeClass('active');
	 jQuery('.faq_basic_info_container').css('display','none');
	 jQuery('.faq_upgrade_container').css('display','none');
	 jQuery('.faq_background_check_container').css('display','block');
	 jQuery('.faq_contact_container').css('display','none');
 });
jQuery('.faq_contact_us_menu').on('click',function(){	  
	 jQuery('.faq_basic_info_menu').removeClass('active');
	 jQuery('.faq_upgrade_menu').removeClass('active');
	 jQuery('.faq_background_check_menu').removeClass('active');
	 jQuery('.faq_contact_us_menu').addClass('active');
	 jQuery('.faq_basic_info_container').css('display','none');
	 jQuery('.faq_upgrade_container').css('display','none');
	 jQuery('.faq_background_check_container').css('display','none');
	 jQuery('.faq_contact_container').css('display','block');
 });
 
  jQuery('body').on('click', '.landlord_pro_package', function(event){
	  var oData       = new Object();
	  oData.pacakage = 'landlord_pro_package';
	  var url    =   '<?php echo $this->baseUrl()?>' + '/user/index/packagesessionset';
      jQuery.ajax({
                        url:  url,
                        data: oData,
                        dataType: 'json',
                        type: 'POST',
                        success: function (data) {
                        if(data.status == true){
                          location.href= '<?php echo $this->baseUrl()?>' + '/member/package/payment';
                        }
                        else{
                           
                        }
                     },
                       error: function(e){}
                });
	  
  });
  jQuery('body').on('click', '.management_gold_package', function(event){
	  
	  var oData       = new Object();
	  oData.pacakage = 'management_gold_package';
	  var url    =   '<?php echo $this->baseUrl()?>' + '/user/index/packagesessionset';
      jQuery.ajax({
                        url:  url,
                        data: oData,
                        dataType: 'json',
                        type: 'POST',
                        success: function (data) {
                        if(data.status == true){
                          location.href= '<?php echo $this->baseUrl()?>' + '/member/package/payment';
                        }
                        else{
                           
                        }
                     },
                       error: function(e){}
                });
  });
  
jQuery('body').on('click', '.contact_btn', function(event){
	  jQuery('.contact_btn').hide();
	  jQuery('.loader').css('display','block');
	  var oData        = new Object();
	  var yourName     = oData.yourName     = jQuery('#your_name').val(); 
	  var yourEmail    = oData.yourEmail    = jQuery('#your_email').val(); 
	  var yourMessage  = oData.yourMessage  = jQuery('#your_message').val(); 
	  var isValidate = true; 
	 
	  if(yourName ==''){ 
			  jQuery('#your_name').css('border-color','#e62828');      
			  isValidate = false;     
		  }
	  else{ 
			jQuery('#your_name').css('border-color','#b2c6cd');   			 
	  } 
       	  
	  if(isValidate == true){
		  if(yourEmail =='')     { 
			  jQuery('#your_email').css('border-color','#e62828'); 
			  isValidate = false;          
		  }
		  else{ 
			jQuery('#your_email').css('border-color','#b2c6cd');   
		  } 
      }  
      if(isValidate == true){ 	
            var emailRegex   =  /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;     
			if( !emailRegex.test(yourEmail) ) {
				jQuery('#your_email').css('border-color','#e62828'); 
			    isValidate = false;   
			}
			else{
				jQuery('#your_email').css('border-color','#b2c6cd');  

			}  
     }
	  if(isValidate == true){
		  if(yourMessage =='')     { 
			  jQuery('#your_message').css('border-color','#e62828'); 
			  isValidate = false;          
		  }
		  else{ 
			jQuery('#your_message').css('border-color','#b2c6cd');   
		  } 
      }   	
        
      if(isValidate == true){
	     var url    =   '<?php echo $this->baseUrl()?>' + '/user/index/contact';
         jQuery.ajax({
                        url:  url,
                        data: oData,
                        dataType: 'json',
                        type: 'POST',
                        success: function (data) {
                        if(data.status == true){
							
							jQuery('.faq_contact_container .success_msg').html('Your message have been successfully sent');
							setTimeout(function(){
								  jQuery('.faq_contact_container .success_msg').html('');
								}, 3000);
							jQuery('#your_name').val('');
							jQuery('#your_email').val('');
							jQuery('#your_message').val('');
							jQuery('.contact_btn').show();
	                        jQuery('.loader').css('display','none');
	                        
                        }
                        else{
                           jQuery('.contact_btn').show();
	                       jQuery('.loader').css('display','none');
                        }
                     },
                       error: function(e){}
                });
	  }
	  else{
		  jQuery('.loader').css('display','none');
		  jQuery('.contact_btn').show();
	  }
  });
</script>
