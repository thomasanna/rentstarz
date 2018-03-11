<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAAWRDCCJZYbD17HwNNUMK-6DzyHziKhN8&libraries=places" async defer></script>
<script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/scripts/autocomplete_address_googleapi.js"></script>
<?php

 $settings         = Engine_Api::_()->getApi('settings', 'core'); 
 $bodyHtmlTemplate = $settings->user_landingpage;
 $artclecontent    = '{article-section}';
 $articlepart      = $this->content()->renderWidget('user.landingpage-article');
 $featuredStoryPart = $this->content()->renderWidget('user.landingpage-featuredstory'); 
 $featuredStoryContent    = '{featuredstory-section}';
 
      $bodyHtmlTemplate   = str_replace($artclecontent, $articlepart, $bodyHtmlTemplate); 
 echo  $bodyHtmlTemplate   = str_replace($featuredStoryContent, $featuredStoryPart, $bodyHtmlTemplate); 
 ?>
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
       
 <!-- FOOTER -->
<div class="footer-top col-md-12">
<div class="container">
		<div class="col-sm-8 col-xs-12">
						<div class="widget">
							<h6 class="upper">CONTACT US</h6>
							<p> <span><img class="footer-flag" src="/application/modules/User/externals/images/latestlandingimages/us.svg" alt="">UNITED STATES</span> <span>1956 Rockaway Parkway</span> <span>Brooklyn, New York 11236</span> 
							</p><div class="map-overlay" onclick="style.pointerEvents='none'">
								<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3027.778571182453!2d-73.89333754891832!3d40.63476497923903!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x89c25cd846024d45%3A0xbf615a26d4ede7ba!2s1956+Rockaway+Pkwy%2C+Brooklyn%2C+NY+11236%2C+USA!5e0!3m2!1sen!2sin!4v1510824237851" width="100%" height="214" frameborder="0" style="border:0" allowfullscreen=""></iframe>
							</div>
							<p></p>
						</div>
					</div>
				
					
				<div class="col-md-4  col-sm-12 col-xs-12">
				<div class="row">
					<div class="col-md-12">
						<div class="widget">
							<h6 class="upper"></h6>
							<div class="footer-newsletter">
								<div class="contact_message" style="color: #008000;"></div>
								<form data-mailchimp="true" class="inline-form">
									<div class="input-group">
										<input id="your_name" type="email" name="email" placeholder="Your Name" class="form-control">
										<span class="input-group-btn"></span> </div>
									<div class="input-group">
										<input id="your_email" type="email" name="email" placeholder="Your Email" class="form-control">
										<span class="input-group-btn"></span> </div>
									<div class="form-group">
										<textarea id="your_message" name="message" placeholder="Message" data-required="true" class="form-control"></textarea>
									</div>
								</form>
								<button type="submit" data-loading-text="Loading..." class="btn btn-color contact_btn">Send a Message</button>
							   <div class="loader" style="display:none"></div>							
							</div>
						</div>
					</div>
				</div>
			</div>	
		</div></div>

<div class="footer">
	<div class="container">
		<div class="row">
			<div class="col-md-4  col-sm-6 col-xs-6 footer-section">
				<p>Copyright © 2017 Rentstarz LLC</p>
			</div>
			<div class="col-md-4 footer-section hidden-sm hidden-xs"> </div>
			<div class="col-md-4  col-sm-6 col-xs-6 footer-section">
				
				<!-- Social Icons Container -->
				<div class="social-icons-container"> 
				<span class="fa-stack fa-lg"> 
				<a href="https://www.facebook.com/rentstarzLLC/?ref=bookmarks" target="_blank"> <i class="fa fa-circle fa-stack-2x"></i> <i class="fa fa-facebook fa-stack-1x fa-inverse"></i> </a>
				 </span> 
			
				   </div>
				<!-- end of social icons container --> 
				
			</div>
			
		</div>
		<!-- end of row --> 
	</div>
	<!-- end of container --> 
</div>

<script>// <![CDATA[
AOS.init({
				easing: 'ease-out-back',
				duration: 1000
			});
// ]]></script>

<script type="text/javascript">
jQuery(document).ready(function(){
	
initAutocomplete1();

});
jQuery('.carousel-indicators li').text('');
jQuery('.item.slides .slide-1').text('');
jQuery('.item.slides .slide-2').text('');
jQuery('.item.slides .slide-3').text('');
jQuery('.overlay').text('');
</script>
<script>
jQuery("#connect-link").click(function() {
    jQuery('html, body').animate({
        scrollTop: jQuery("#connect-link-pointer").offset().top
    }, 2000);
});
		jQuery("#visit-link").click(function() {
    jQuery('html, body').animate({
        scrollTop: jQuery("#visit-link-pointer").offset().top
    }, 2000);
});
		
			jQuery('.hero__scroll').on('click', function(e) {
				jQuery('html, body').animate({
					scrollTop: $(window).height()
				}, 1200);
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
							
							jQuery('.contact_message').html('Your message have been successfully sent');
							setTimeout(function(){
								  jQuery('.contact_message').html('');
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
                        });});
		
</script>
