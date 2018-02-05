<?php
    $subject        = Engine_Api::_()->core()->getSubject();
    $userHelperObj  = $this->getHelper('User');
    $userdetails    = $userHelperObj->getuserDetails($subject->getIdentity());
    $package_type   = $userdetails['user_package'];
    $CardholderdetailsData =  $this->CardholderdetailsData;
?>

<div>
	 <?php if($package_type != ''):?>
              
            <div class="payment_content_div">
              <?php if(!empty($CardholderdetailsData)):?>
				  <div style="text-align: left;
						font-size: 15px;
						font-weight: 600;
						padding: 0px 0px 12px 0px;
						color: #808080;">Card holders info
				 <span  class="cardholderedit" data-toggle="modal" data-target="#editcardholderModal" title="Edit"><img src="/application/modules/User/externals/images/edit_new.png" style="    width: 17px;
    margin-left: 12px;cursor:pointer"></span>
	
						
				  </div> 
				  <div>		

				  <div  class="row rowsep"><div class="titledesc col-md-4 col-sm-3 col-xs-12">First Name</div> <div class=" col-md-4 col-sm-3 col-xs-12"><?php echo $CardholderdetailsData->first_name;?></div></div>
				  <div  class="row rowsep"><div class="titledesc col-md-4 col-sm-3 col-xs-12">Last Name</div> <div class=" col-md-4 col-sm-3 col-xs-12"><?php echo $CardholderdetailsData->last_name;?></div></div>
				  <div  class="row rowsep"><div class="titledesc col-md-4 col-sm-3 col-xs-12">Street</div> <div class=" col-md-4 col-sm-3 col-xs-12"><?php echo $CardholderdetailsData->street;?></div></div>
				  <div  class="row rowsep"><div class="titledesc col-md-4 col-sm-3 col-xs-12">City</div> <div class=" col-md-4 col-sm-3 col-xs-12"><?php echo $CardholderdetailsData->city;?></div></div>
				  <div  class="row rowsep"><div class="titledesc col-md-4 col-sm-3 col-xs-12">State</div> <div class=" col-md-4 col-sm-3 col-xs-12"><?php echo $CardholderdetailsData->state;?></div></div>
				  <div  class="row rowsep"><div class="titledesc col-md-4 col-sm-3 col-xs-12">Zipcode</div> <div class=" col-md-4 col-sm-3 col-xs-12"><?php echo $CardholderdetailsData->zipcode;?></div></div>
				  <div style="text-align: left;
						font-size: 15px;
						font-weight: 600;
						padding: 12px 0px 12px 0px;
						color: #808080;">Card info
				 <span  class="cardholderedit" data-toggle="modal" data-target="#editcardholderModal" title="Edit"><img src="/application/modules/User/externals/images/edit_new.png" style="    width: 17px;
    margin-left: 12px;cursor:pointer"></span>
	
						
				  </div> 
				  
				  <div  class="row rowsep"><div class="titledesc col-md-4 col-sm-3 col-xs-12">Card Number</div> <div class=" col-md-4 col-sm-3 col-xs-12"><?php echo $CardholderdetailsData->card_number;?></div></div>
				  <div  class="row rowsep"><div class="titledesc col-md-4 col-sm-3 col-xs-12">Expiration Month</div> <div  class=" col-md-4 col-sm-3 col-xs-12"><?php echo $CardholderdetailsData->expiration_month;?></div></div>
				  <div  class="row rowsep"><div class="titledesc col-md-4 col-sm-3 col-xs-12">Expiration Year</div> <div  class=" col-md-4 col-sm-3 col-xs-12"><?php echo $CardholderdetailsData->expiration_year;?></div></div>
				  <div  class="row rowsep"><div class="titledesc col-md-4 col-sm-3 col-xs-12">CVC</div> <div class=" col-md-4 col-sm-3 col-xs-12"><?php echo $CardholderdetailsData->cvc;?></div></div>
				  
				  </div>
				<?php endif;?>
			</div>	
				
				
				
				
            <div class="faq_upgrade">
				 <div class="faq_upgrade_package_content" style="text-align: center;">				 
				 <div class="faq_upgrade_package" style="display: inline-block;">
				 <?php  $settings = Engine_Api::_()->getApi('settings', 'core');  ?>
				 <?php if($package_type == 'landlord_pro_package'):?>
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
				 <?php if($package_type == 'management_gold_package'):?>
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
				  <div class="cancel_renewal" data-toggle="modal" data-target="#cancelrenewalModal" style="margin-bottom: 12px;    text-align: center;"><a href="javascript:void(0);">Cancel Subscription</a></div>
                 <?php endif;?>
				  <?php if($package_type == ''):?>				   
				   <div style="text-align: center;"><a href="/support?page=upgradePackage">Please upgrade your package. </a></div>				   
				  <?php endif;?>
            </div>
            </div>

            </div>
            
             
</div>
