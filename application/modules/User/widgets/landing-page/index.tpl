<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAAWRDCCJZYbD17HwNNUMK-6DzyHziKhN8&libraries=places" async defer></script>
<script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/scripts/autocomplete_address_googleapi.js"></script>
<?php

/* $settings         = Engine_Api::_()->getApi('settings', 'core'); 
 $bodyHtmlTemplate = $settings->user_landingpage;
 $artclecontent    = '{article-section}';
 $articlepart      = $this->content()->renderWidget('user.landingpage-article');
 $featuredStoryPart = $this->content()->renderWidget('user.landingpage-featuredstory'); 
 $featuredStoryContent    = '{featuredstory-section}';
 
      $bodyHtmlTemplate   = str_replace($artclecontent, $articlepart, $bodyHtmlTemplate); 
 echo  $bodyHtmlTemplate   = str_replace($featuredStoryContent, $featuredStoryPart, $bodyHtmlTemplate); */
 ?>
   <div class="header">
        <div class="container-fluild">
            <nav class="navbar">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar2">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="index.html">
                        <img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/assets/images/logo.png" alt="">
                    </a>
                </div>
                <div id="navbar2" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li class="active">
                            <a href="<?php echo $this->baseUrl(); ?>/signup">SIGNUP</a>
                        </li>
                        <li>
                            <a href="<?php echo $this->baseUrl(); ?>/login/return_url/64-Lw%3D%3D">LOGIN</a>
                        </li>
                      
                    </ul>
                </div>
                <!--/.nav-collapse -->
            </nav>
        </div>
    </div>

    <!--    map tabbing section-->


    <div class="landingPage newlanding-page">
        <video loop autoplay src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/assets/images/landing/rentstarz_girl_dancing.mp4"></video>
        <div class="filter-search searchFilter ">
		<input type="hidden" class="apartement_street" id="street_number" ></input>
        <input type="hidden" class="apartement_route" id="route"></input>
        <input type="hidden" class="apartement_neighborhood" id="neighborhood" ></input>
        <input type="hidden" class="apartement_city" id="locality"></input>
        <input type="hidden" class="apartement_sublocality_level_1 county" id="sublocality_level_1"></input>
        <input type="hidden" class="apartement_state" id="administrative_area_level_1">
        <input type="hidden" class="apartement_zip" id="postal_code">
        <input type="hidden" class="apartement_country" id="country">
        <input type="hidden" class="apartement_latitude" id="latitude">
        <input type="hidden" class="apartement_longitude" id="longitude">

            <div class="">
                <ul>
                    <li class="item">
                        <input type="text" id="autocomplete1" placeholder="Enter Location, Project and Landmark"><img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/assets/images/location.png" alt="">
                    </li>
                  
                    <div class="clearfix visible-xs"></div>
                    <li class="dropdown bedroom_li">
                        <a class="dropdown-toggle" id="menu3" type="" data-toggle="dropdown">
                            <img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/assets/images/bedroom.png" alt="">Bedroom
                            <span class="caret"></span>
                        </a>
                        
                        <ul class="dropdown-menu" role="menu3" aria-labelledby="menu3">
                            <li role="presentation">
                                <a role="menuitem" tabindex="1" href="javascript:void(0)">1</a>
                            </li>
                            <li role="presentation">
                                <a role="menuitem" tabindex="2" href="javascript:void(0)">2</a>
                            </li>
                            <li role="presentation">
                                <a role="menuitem" tabindex="3" href="javascript:void(0)">3</a>
                            </li>
<!--
                            <li role="presentation" class="divider"></li>
-->
                            <li role="presentation">
                                <a role="menuitem" tabindex="4" href="javascript:void(0)">4</a>
                            </li>
                            <li role="presentation">
                                <a role="menuitem" tabindex="4+" href="javascript:void(0)">4+</a>
                            </li>
                        </ul>
                    </li>

                    <li class=" dropdown propertyType_li">
                        <a class="dropdown-toggle" id="menu4" type="" data-toggle="dropdown">Property Type
                            <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu" role="menu4" aria-labelledby="menu3">
                            <li role="presentation">
                                <a role="menuitem" tabindex="Apartment" href="javascript:void(0)">Apartment</a>
                            </li>
                            <li role="presentation">
                                <a role="menuitem" tabindex="Room" href="javascript:void(0)">Room</a>
                            </li>
                            <li role="presentation">
                                <a role="menuitem" tabindex="House" href="javascript:void(0)">House</a>
                            </li>
                            <li role="presentation">
                                <a role="menuitem" tabindex="Villa" href="javascript:void(0)">Villa</a>
                            </li>
                        </ul>
                    </li>
                    <li class=" dropdown budget_li">
                        <a class="dropdown-toggle" id="menu5" type="" data-toggle="dropdown">Budget
                            <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu" role="menu5" aria-labelledby="menu3">
                            <li role="presentation">
                                <a role="menuitem" tabindex="0-500" href="javascript:void(0)">0 - 500</a>
                            </li>
                            <li role="presentation">
                                <a role="menuitem" tabindex="500-1000" href="javascript:void(0)">500 - 1000</a>
                            </li>
                            <li role="presentation">
                                <a role="menuitem" tabindex="1001-1500" href="javascript:void(0)">1001 - 1500</a>
                            </li>
                            <li role="presentation" class="divider"></li>
                            <li role="presentation">
                                <a role="menuitem" tabindex="1501-2000" href="javascript:void(0)">1501 - 2000</a>
                            </li>
                            <li role="presentation">
                                <a role="menuitem" tabindex="2001-2500" href="javascript:void(0)">2001 - 2500</a>
                            </li>
                            
                        </ul>
                    </li>
                    <li class="item">
                        <button class="btn btn-primary search_apartment_btn">SEARCH</button>
                    </li>
                </ul>
            </div>
        </div>
    </div>


    <!--    /*post to scouts*/-->


    <section class="postOfScouts">
        <div class="container">

            <ul>
                <li>
                    <h4>Post TO Scout</h4>
                    <p>Tell landlord what you’re<br> looking for and they’<br> recontact you</p>
                </li>
                <li>
                    <h4>GET A BACKGROUND <br>   CHECK NOW</h4>
                </li>
            </ul>
        </div>
    </section>

    <section class="scoutsHotel">
        <div class="container">
            <ul>
                <li>
                    <a href="">

                        <div class="scoutsImg" style="background-image: url(../rentstarz/<?php echo $this->baseUrl(); ?>/application/modules/User/externals/assets/images/landing/home1.png); background-repeat: no-repeat;">
                            <div class="scoutsInfo">
                                <p>24-26 wheellock Street</p>
                                <span>$ 1300 / month</span>
                            </div>

                        </div>
                    </a>

                </li>
                <li>
                    <a href="">

                        <div class="scoutsImg" style="background-image: url(../rentstarz/<?php echo $this->baseUrl(); ?>/application/modules/User/externals/assets/images/landing/home1.png); background-repeat: no-repeat;">
                            <div class="scoutsInfo">
                                <p>24-26 wheellock Street</p>
                                <span>$ 1300 / month</span>
                            </div>

                        </div>
                    </a>

                </li>
                <li>
                    <a href="">

                        <div class="scoutsImg" style="background-image: url(../rentstarz/<?php echo $this->baseUrl(); ?>/application/modules/User/externals/assets/images/landing/home1.png); background-repeat: no-repeat;">
                            <div class="scoutsInfo">
                                <p>24-26 wheellock Street</p>
                                <span>$ 1300 / month</span>
                            </div>

                        </div>
                    </a>

                </li>
                <li>
                    <a href="">

                        <div class="scoutsImg" style="background-image: url(../rentstarz/<?php echo $this->baseUrl(); ?>/application/modules/User/externals/assets/images/landing/home1.png); background-repeat: no-repeat;">
                            <div class="scoutsInfo">
                                <p>24-26 wheellock Street</p>
                                <span>$ 1300 / month</span>
                            </div>

                        </div>
                    </a>

                </li>
                <li>
                    <a href="">

                        <div class="scoutsImg" style="background-image: url(../rentstarz/<?php echo $this->baseUrl(); ?>/application/modules/User/externals/assets/images/landing/home1.png); background-repeat: no-repeat;">
                            <div class="scoutsInfo">
                                <p>24-26 wheellock Street</p>
                                <span>$ 1300 / month</span>
                            </div>

                        </div>
                    </a>

                </li>
                <li>
                    <a href="">

                        <div class="scoutsImg" style="background-image: url(../rentstarz/<?php echo $this->baseUrl(); ?>/application/modules/User/externals/assets/images/landing/home1.png); background-repeat: no-repeat;">
                            <div class="scoutsInfo">
                                <p>24-26 wheellock Street</p>
                                <span>$ 1300 / month</span>
                            </div>

                        </div>
                    </a>

                </li>
            </ul>
        </div>
    </section>

    <section class="rent_socially" style="background-image: url(../rentstarz/<?php echo $this->baseUrl(); ?>/application/modules/User/externals/assets/images/landing/socially_rent_bg.png); background-repeat: no-repeat;">
        <div class="container">
            <div class="row">
                <div class="col-sm-5 col-xs-12">
                    <div class="rentIcon">
                        <img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/assets/images/landing/rent_socialy.png" alt="">
                    </div>
                </div>
                <div class="col-sm-7 col-xs-12">
                    <div class="rentInfo">
                        <h4>RENT SOCIALLY</h4>
                        <p>We’ve put the best of social networking in a rental platformRentstarz puts you in control and helps you to rent more efciently.We've broken the barrier between landlords and renters. Now its just people renting to people.</p><br>
                        <p>Rentstarz is perfect for small and mid level property owners who really want to get to known who they’re renting to. Our networking approach to renting enables Landlords to quickly pre-screen renters through basic conversation and profle review. So build your profle show of to renters and landlords.</p>
                    </div>
                </div>
                <div class="clearfix"></div>
                <div class="col-sm-12">
                    <div class="rentInfo1">
                        <div class="col-sm-5 col-xs-12 visible-xs">
                            <div class="rentIcon">
                                <img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/assets/images/landing/rent_socially2.png" alt="">
                            </div>
                        </div>
                        <div class="col-sm-7 col-xs-12">
                            <div class="rentInfo">

                                <p>You can complete the entire rental process from sharing rental documents like paystubs, to getting a credit and background check. We dont want you to waste time either: traveling form rental to rental or as landlord meeting dozens of renters who are not qualifed for your rental..</p>
                                <br>
                                <p>We want you do a video call before schuduling a viewing. Video calls helps landlord make a dicision before the viewing, and renters get an assurance on the apartment their about to view.</p>
                            </div>
                        </div>
                        <div class="col-sm-5 hidden-xs">
                            <div class="rentIcon">
                                <img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/assets/images/landing/rent_socially2.png" alt="">
                            </div>
                        </div>
                    </div>

                </div>


            </div>
        </div>
    </section>

    <section class="renthappy" style="background-image: url(../rentstarz/<?php echo $this->baseUrl(); ?>/application/modules/User/externals/assets/images/landing/rent_happy.png); background-repeat: no-repeat; background-color: #fafafa;">
        <div class="container">
            <div class="row">
                <div class="col-sm-5 col-xs-12">
                    <div class="rent_happy_icon">
                        <img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/assets/images/landing/live_video.png" alt="">
                    </div>
                </div>
                <div class="col-sm-7 col-xs-12">
                    <div class="rentHappyInfo">
                        <h4>RENT HAPPY</h4>
                        <p>Rentstarz is Perfect for Management companies and agents. Agents can use our site to efently communicate with renters and landlords, and fnd renter. You can also connect with other agents and form groups share listings and compete. Use our video feature to do a video viewing when the renter cant make it but the landlord is there, no need reschudule.</p><br><br>

                        <h4>LIVE VIDEO VIEWING</h4>
                        <p>If a renter can’t make a viewinghers give renters a live walk trough of your units. </p><br><br>

                        <h4>NETWORK AND SHARE LISTING</h4>
                        <p>Form team and groups, network, share listing and compete with other agents. Stay in touch using revolutionize video and messaging featute. </p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <div class="maintain">
        <div class="container">
            <div class="row">
                <div>
                    <div class="col-sm-12">
                        <img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/assets/images/landing/manage_maintainance.png" alt="">
                    </div>
                    <div class="col-sm-6">
                        <div class="rentHappyInfo">
                            <h4>MANAGE MAINATENANCE</h4>
                            <p>Your tenant can take a picture or video of the task and send it to you. You can coordinate your repairs between you the repair man and your tenant</p>


                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <section class="our_mission">
        <div class="container">
            <div class="row">
                <div class="col-sm-8">
                    <div class="rentHappyInfo">
                        <h4 class="txt-black">OUR MISSION</h4>
                        <p>Our goal is to make people happy and when things work the way it should and there’s less bumps on the road and life is bettter. We want you to worry less and by helping you the things that might seem too much to handle are suddenly not anymore. We created Rentstarz so you can communicate better and when you comminicate better you rent better. </p>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="imgMission">
                        <img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/assets/images/landing/Asset%202@3x.png" alt="">
                    </div>

                </div>
            </div>

        </div>
    </section>

<section>
     <div class="who_we_are">
        <div class="container">
            <div class="row">
                <div class="col-sm-6">
                    <div class="rentHappyInfo">
                        <h4 class="txt-black">HOW WE’RE DIFFERENT</h4>

                        <div class="manage margin50">
                            <span class="txt-black">Manage your tenants</span>
                            <p>
                                Manage tenants lease, rental income , rent increase, rental forecast and repair expense. We give you an overall summerry of your properties operation.</p>
                        </div>

                        <div class="manage">
                            <span class="txt-black">We help you manage your repairs </span>
                            <p>
                                Your Tenant takes a picture or video of a needed repair, gives a brief description and then send it to the you. You now can schedule an appointment with your renter or coordinate with a repair man.Using our Maintenance solution, you can manage expense, keep detail logs and notes of each repair. have excess to repair man or invite your own to join.
                            </p>
                        </div>


                    </div>
                </div>
                <div class="col-sm-6"></div>
            </div>
        </div>

    </div>
</section>
   
    <!--    map-->

    <div class="map">
        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3027.778571177857!2d-73.8933321841472!3d40.634764979340375!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x89c25cd846024d45%3A0xbf615a26d4ede7ba!2s1956+Rockaway+Pkwy%2C+Brooklyn%2C+NY+11236%2C+USA!5e0!3m2!1sen!2sin!4v1522138847223" width="600" height="550" frameborder="0" style="border:0" allowfullscreen></iframe>
    </div>



    <section class="registration">
        <div class="container">
            <div class="row">
                <div class="col-sm-7">
                    <div>
                        <h4 class="txt-black">JOIN OUR LIST OR SIMPLY SEND US A MESSAGE </h4>
                        <div class="contact_message" style="padding:0px 0px 12px 0px"></div>
                        <form action="">
                            <input type="text" class="form-control your_name" placeholder="Enter Your Name">
                            <input type="text" class="form-control your_email" placeholder="Enter Your Email id">
                            <textarea name="" class="your_message" id="" cols="30" rows="8" placeholder="Message"></textarea>
                            <button class="btn btn-primary contact_btn">SUBMIT</button>
                        </form>
                    </div>
                </div>
                <div class="col-sm-5 hidden-xs">
                    <img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/assets/images/landing/circle_pattern.png" alt="">
                </div>
            </div>
        </div>
    </section>
    <!--form-->



 
<script type="text/javascript">
jQuery(document).ready(function(){
	
initAutocomplete1();

});

</script>
<script>

jQuery('body').on('click', '.contact_btn', function(event){
	  event.preventDefault();
	  jQuery('.contact_btn').hide();
	  jQuery('.loader').css('display','block');
	  var oData        = new Object();
	  var yourName     = oData.yourName     = jQuery('.your_name').val(); 
	  var yourEmail    = oData.yourEmail    = jQuery('.your_email').val(); 
	  var yourMessage  = oData.yourMessage  = jQuery('.your_message').val(); 
	  var isValidate = true; 
	 
	  if(yourName ==''){ 
			  jQuery('.your_name').css('border-color','#e62828');      
			  isValidate = false;     
		  }
	  else{ 
			jQuery('.your_name').css('border-color','#b2c6cd');   			 
	  } 
       	  
	  if(isValidate == true){
		  if(yourEmail =='')     { 
			  jQuery('.your_email').css('border-color','#e62828'); 
			  isValidate = false;          
		  }
		  else{ 
			jQuery('.your_email').css('border-color','#b2c6cd');   
		  } 
      }  
      if(isValidate == true){ 	
            var emailRegex   =  /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;     
			if( !emailRegex.test(yourEmail) ) {
				jQuery('.your_email').css('border-color','#e62828'); 
			    isValidate = false;   
			}
			else{
				jQuery('.your_email').css('border-color','#b2c6cd');  

			}  
     }
	  if(isValidate == true){
		  if(yourMessage =='')     { 
			  jQuery('.your_message').css('border-color','#e62828'); 
			  isValidate = false;          
		  }
		  else{ 
			jQuery('.your_message').css('border-color','#b2c6cd');   
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
							
							jQuery('.contact_message').html('Your message have been successfully sent');
							setTimeout(function(){
								  jQuery('.contact_message').html('');
								}, 3000);
							jQuery('.your_name').val('');
							jQuery('.your_email').val('');
							jQuery('.your_message').val('');
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
jQuery('body').on('click', '.search_apartment_btn', function(event){
	var street = jQuery('.apartement_street').val();
	var neighborhood = jQuery('.apartement_neighborhood').val();
	var city = jQuery('.apartement_city').val();
	var county = jQuery('.apartement_sublocality_level_1').val();
	var state = jQuery('.apartement_state').val();
	var zip = jQuery('.apartement_zip').val();
	var latitude = jQuery('.apartement_latitude').val();
	var longitude = jQuery('.apartement_longitude').val();
	
	var oData           = new Object();
    var street    = oData.street =jQuery.trim(jQuery("#country").val());
    var state      = oData.state =jQuery.trim(jQuery("#administrative_area_level_1").val());
    var city       = oData.city =jQuery.trim(jQuery("#locality").val());
    var country       = oData.country =jQuery.trim(jQuery("#country").val());
    if(city == ''){
         var city        = oData.city =jQuery.trim(jQuery("#sublocality_level_1").val());
    }
    var county           =  oData.county =jQuery.trim(jQuery("#sublocality_level_1").val());
    var neighborhood     =  oData.neighborhood =jQuery.trim(jQuery("#neighborhood").val());
    var street   = oData.street =jQuery.trim(jQuery("#street_number").val());
    var zip          = oData.zip =jQuery.trim(jQuery("#postal_code").val());
    var latitude         = oData.latitude =jQuery.trim(jQuery("#latitude").val());
    var longitude        = oData.longitude =jQuery.trim(jQuery("#longitude").val());
    
    var bedroom       = jQuery('.bedroom_li a').attr('dataVal');
    var propertyType  = jQuery('.propertyType_li a').attr('dataVal');
    var budget        = jQuery('.budget_li a').attr('dataVal');
    
    oData.bedroom =  bedroom;
    oData.propertyType =  propertyType;
    oData.budget =  budget;
   
	
     var formURL    = '<?php echo $this->baseUrl(); ?>' + '/user/index/locationsearch';
     jQuery.ajax( {
                        url : formURL,
                        type: "POST",
                        dataType: 'json',
                        data : oData,
                            success: function (returndata) {
                                       location.href = '<?php echo $this->baseUrl(); ?>' + '/apartments';
                            },
                            error: function(e){
                           jQuery(".set_location_loader").css("display", "none");
                           jQuery(".results-pane-loader").css("display", "none");
                           jQuery('.set_location').css('display','block');  }
                        });
                        
  });
		
		
$(".dropdown-menu li a").click(function(){
  $(this).parents(".dropdown").find('.dropdown-toggle').html($(this).text() + ' <span class="caret"></span>');
  $(this).parents(".dropdown").find('.dropdown-toggle').attr('dataVal',$(this).attr('tabindex')); 
});		
		
</script>
