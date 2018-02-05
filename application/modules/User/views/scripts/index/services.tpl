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
  <?php echo $this->render('_browseServices.tpl') ?>
</div>


<script type="text/javascript">
  en4.core.runonce.add(function() {
    var url = '<?php echo $this->url(array(), 'user_services', true) ?>';
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
  	
		/*jQuery( "#1_6_53_field_53" ).click(function() {
			
		jQuery("#1_6_53_field_53").attr("onchange" , "");
		var host	=	window.location.host;
		var url	=	'<?php echo $this->baseUrl()?>' + '/user/signup/getcountries';
			  jQuery.ajax({
						 url:  url,
						 dataType: 'json',
						 type: 'POST',
					 success: function (data) { console.log(data);
						//jQuery('#1_6_63_field_63').append('<option></option>');
						jQuery("#1_6_53_field_53")
							.replaceWith('<select id="1_6_53_field_53" name="1_6_53_field_53" class="" onclick="getstates();"> </select>') ;
						jQuery.each(data, function (i, item) {
						jQuery('#1_6_53_field_53').append(jQuery('<option>', { 
							value: item.id,
							text : item.country 
						}));
						
						
					});},
					   error: function(e){  //alert('Error: '+e);
						   console.log(e);  }  
					});
		});*/
		
	function getstates(){
		
		if(jQuery('#1_6_54_field_54').hasClass('stoprepeatstate'))
		return;
		
		//jQuery('#1_6_64_field_64').html('');
		var host	=	window.location.host;
		var url	=	'<?php echo $this->baseUrl()?>' + '/user/signup/getstates';
		var country_id	=	jQuery('#1_6_53_field_53').val(); 
		var country_id	=	1; 
		jQuery("#1_6_54_field_54").attr("onchange" , "");
		
		
			  jQuery.ajax({
						 url:  url,
						data: "countryId="+country_id,
						dataType: 'json',
						type: 'POST',
					 success: function (data) { console.log(data);
						jQuery('#1_6_54_field_54').append('<option value="">Select state</option>');
						/*jQuery("#1_6_54_field_54")
							.replaceWith('<select id="1_6_54_field_54" name="1_6_54_field_54" class="" onclick="getcity();"> </select>') ;*/
						//jQuery('#1_6_54_field_54').append('<option></option>');
						jQuery('#1_6_54_field_54').addClass('stoprepeatstate');
						jQuery.each(data, function (i, item) {						
						jQuery('#1_6_54_field_54').append(jQuery('<option>', { 
							value: item.id,
							text : item.state 
						}));
					}); },
					   error: function(e){  //alert('Error: '+e);
						   console.log(e);  }  
					}); 
	}


	function getcity(){
		
	//if(jQuery('#1_6_55_field_55').hasClass('stoprepeatcity'))
	//return;
		jQuery("#1_6_55_field_55").attr("onchange" , "");
		var host	=	window.location.host;; 
	    var url	=	'<?php echo $this->baseUrl()?>' + '/user/signup/getcity';
		var state_id	=	jQuery('#1_6_54_field_54').val();

		
			  jQuery.ajax({
						 url:  url,
						data: "stateId="+state_id,
						dataType: 'json',
						type: 'POST',
					 success: function (data) { console.log(data);
						
						jQuery('#1_6_55_field_55').html('');
						/*jQuery("#1_6_55_field_55")
							.replaceWith('<select id="1_6_55_field_55" name="1_6_55_field_55" class="" > </select>') ;*/
						jQuery('#1_6_55_field_55').append('<option value="">Select city</option>');
						if(data.length != 0)
						{
							jQuery('#1_6_55_field_55').addClass('stoprepeatcity');
						}
						jQuery.each(data, function (i, item) {
						jQuery('#1_6_55_field_55').append(jQuery('<option>', { 
							value: item.id,
							text : item.city 
						}));
					});},
					   error: function(e){  //alert('Error: '+e); 
						   console.log(e); }  
					});
	}
	
	
jQuery(document).ready(function(){
	
		jQuery("#1_6_53_field_53").attr("onchange" , "");
		var host	=	window.location.host;
		var url	=	'<?php echo $this->baseUrl()?>' + '/user/signup/getcountries';
			  jQuery.ajax({
						 url:  url,
						 dataType: 'json',
						 type: 'POST',
					 success: function (data) { console.log(data);
						
						jQuery("#1_6_53_field_53")
							.replaceWith('<select id="1_6_53_field_53" name="1_6_53_field_53" class="" onclick="getstates();"> </select>') ;
							 //jQuery('#1_6_53_field_53').append('<option></option>');
						jQuery.each(data, function (i, item) {
						jQuery('#1_6_53_field_53').append(jQuery('<option>', { 
							value: item.id,
							text : item.country 
						}));
						
						
					});},
					   error: function(e){  //alert('Error: '+e);
						   console.log(e);  }  
					});
					
		jQuery("#1_6_54_field_54")
							.replaceWith('<select id="1_6_54_field_54" name="1_6_54_field_54" class="" onclick="getcity();"> </select>') ;
							
		jQuery("#1_6_55_field_55")
							.replaceWith('<select id="1_6_55_field_55" name="1_6_55_field_55" class="" > </select>') ;
							
	//getstates();						
});
	
</script>
