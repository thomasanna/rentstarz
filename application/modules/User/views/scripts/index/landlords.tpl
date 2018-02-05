<script src="/application/modules/User/externals/scripts/message_notififaction.js"></script>
<script>
<?php $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); ?>

var viewer_identity='<?php echo $viwer_id; ?>';	
</script>
<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: browse.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     Jung
 */
?>

<div class='browsemembers_results' id='browsemembers_results'>
  <?php echo $this->render('_browseLandlords.tpl') ?>
</div>


<script type="text/javascript">
  en4.core.runonce.add(function() {
    var url = '<?php echo $this->url(array(), 'user_landlords', true) ?>';
    var requestActive = false;
    var browseContainer, formElement, page, totalUsers, userCount, currentSearchParams;

    formElement = $$('.layout_user_browse_search .field_search_criteria')[0];
    browseContainer = $('browsemembers_results');


    var searchMembers = window.searchMembers = function() {
      if( requestActive ) return;
      requestActive = true;

      currentSearchParams = formElement ? formElement.toQueryString() : null;

      var param = (currentSearchParams ? currentSearchParams + '&' : '') + 'ajax=1&format=html';
      if (history.replaceState){
            history.replaceState( {}, document.title, url + (currentSearchParams ? '?'+currentSearchParams : '') );
        }
      var request = new Request.HTML({
        url: url,
        onComplete: function(requestTree, requestHTML) {
          requestTree = $$(requestTree);
          browseContainer.empty();
          requestTree.inject(browseContainer);
          requestActive = false;
          Smoothbox.bind();
        }
      });
      request.send(param);
    }

    var browseMembersViewMore = window.browseMembersViewMore = function() {
      if( requestActive ) return;
      $('browsemembers_loading').setStyle('display', '');
      $('browsemembers_viewmore').setStyle('display', 'none');

      var param = (currentSearchParams ? currentSearchParams + '&' : '') + 'ajax=1&format=html&page=' + (parseInt(page) + 1);

      var request = new Request.HTML({
        url: url,
        onComplete: function(requestTree, requestHTML) {
          requestTree = $$(requestTree);
          browseContainer.empty();
          requestTree.inject(browseContainer);
          requestActive = false;
          Smoothbox.bind();
        }
      });
      request.send(param);
    }
  });
  
  
  //------------------landlord-------------------
	
	/*	jQuery( "#1_4_33_field_33" ).click(function() {
			
			jQuery("#1_4_33_field_33").attr("onchange" , "");
		var host	=	window.location.host;
		
		var url	=	'<?php echo $this->baseUrl()?>' + '/user/signup/getcountries';
			  jQuery.ajax({
						 url:  url,
						
						dataType: 'json',
						type: 'POST',
					 success: function (data) { console.log(data);
						
						jQuery("#1_4_33_field_33")
    .replaceWith('<select id="1_4_33_field_33" name="1_4_33_field_33" class="" onchange="getstates();"> </select>') ;
     jQuery('#1_4_33_field_33').append('<option></option>');
						jQuery.each(data, function (i, item) {
						jQuery('#1_4_33_field_33').append(jQuery('<option>', { 
							value: item.id,
							text : item.country 
						}));
						
						
					});},
					   error: function(e){  console.log(e);alert('Error: '+e);  }  
					});
		});*/
		


	function getstates(){

	if(jQuery('#1_4_30_field_30').hasClass('stoprepeatstate'))
	return;
		var host	=	window.location.host;
		var url	=	'<?php echo $this->baseUrl()?>' + '/user/signup/getstates';
		var country_id	=	jQuery('#1_4_33_field_33').val(); 
		var country_id	=	1; 
		jQuery("#1_4_30_field_30").attr("onchange" , "");
		//jQuery("#1_4_30_field_30").val('');
	jQuery('#1_4_31_field_30').find('option').remove();
			  jQuery.ajax({
						 url:  url,
						data: "countryId="+country_id,
						dataType: 'json',
						type: 'POST',
					 success: function (data) { console.log(data);
						 jQuery('#1_4_30_field_30').append('<option value="">Select state</option>');
						/*jQuery("#1_4_30_field_30")
    .replaceWith('<select id="1_4_30_field_30" name="1_4_30_field_30" class="" onclick="getcity();"> </select>') ;*/
     //jQuery('#1_4_30_field_30').append('<option></option>');
     jQuery('#1_4_30_field_30').addClass('stoprepeatstate');
						jQuery.each(data, function (i, item) {
													
						jQuery('#1_4_30_field_30').append(jQuery('<option>', { 
							value: item.id,
							text : item.state 
						}));

					}); },
					   error: function(e){  //alert('Error: '+e);  
						   }  
					}); }



function getcity(){
	
	//if(jQuery('#1_4_31_field_31').hasClass('stoprepeatcity'))
	//return;
	jQuery("#1_4_31_field_31").attr("onchange" , "");
		var host	=	window.location.host;
	    var url	=	'<?php echo $this->baseUrl()?>' + '/user/signup/getcity'; 
		var state_id	=	jQuery('#1_4_30_field_30').val(); 
		//jQuery("#1_4_31_field_31").val('');
		jQuery('#1_4_31_field_31').find('option').remove();
			  jQuery.ajax({
						 url:  url,
						data: "stateId="+state_id,
						dataType: 'json',
						type: 'POST',
					 success: function (data) { console.log(data);
         /*jQuery("#1_4_31_field_31")
    .replaceWith('<select id="1_4_31_field_31" name="1_4_31_field_31" class="" > </select>') ;*/
     jQuery('#1_4_31_field_31').append('<option value="">Select city</option>');
		 if(data.length != 0)
		 {
			jQuery('#1_4_31_field_31').addClass('stoprepeatcity');
		 }
	 
						jQuery.each(data, function (i, item) {
						jQuery('#1_4_31_field_31').append(jQuery('<option>', { 
							value: item.id,
							text : item.city 
						}));
					});},
					   error: function(e){  //alert('Error: '+e);
						     }  
					});
	}
	
  jQuery(document).ready(function(){
	 jQuery("#services_type_id-label").hide(); 		
     jQuery("#services_type_id").hide(); 
     jQuery("#1_4_19_alias_gender").find("option").eq(0).remove();
     jQuery('<option>').val('').text('Both').prependTo('#1_4_19_alias_gender');
     jQuery("#1_4_19_alias_gender").val("");
     
     	jQuery("#1_4_33_field_33").attr("onchange" , "");
		var host	=	window.location.host;
		
		var url	=	'<?php echo $this->baseUrl()?>' + '/user/signup/getcountries';
			  jQuery.ajax({
						 url:  url,
						
						dataType: 'json',
						type: 'POST',
					 success: function (data) { console.log(data);
						
						jQuery("#1_4_33_field_33")
    .replaceWith('<select id="1_4_33_field_33" name="1_4_33_field_33" class="" onclick="getstates();"> </select>') ;
     //jQuery('#1_4_33_field_33').append('<option></option>');
						jQuery.each(data, function (i, item) {
						jQuery('#1_4_33_field_33').append(jQuery('<option>', { 
							value: item.id,
							text : item.country 
						}));
						
						
					});},
					   error: function(e){  console.log(e);//alert('Error: '+e);  
						   }  
					});
					
					jQuery("#1_4_30_field_30")
    .replaceWith('<select id="1_4_30_field_30" name="1_4_30_field_30" class="" onclick="getcity();"> </select>') ;
    
					jQuery("#1_4_31_field_31")
    .replaceWith('<select id="1_4_31_field_31" name="1_4_31_field_31" class="" > </select>') ;
    
    
    
    
    // get states
    
    
   // getstates();


    });
</script>
