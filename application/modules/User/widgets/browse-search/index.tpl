
<?php
/* Include the common user-end field switching javascript */
echo $this->partial('_jsSwitch.tpl', 'fields', array(
    'topLevelId' => (int) $this->topLevelId,
    'topLevelValue' => (int) $this->topLevelValue
))
?>
<div class="advsearch"><a href="javascript:void(0)" onclick="displayFields();">Advanced Search</a></div>
<div class="basicsearch" style="display:none"><a href="javascript:void(0)" onclick="hideFields();">Basic Search</a></div>
<?php
echo $this->form
  //->setAction($this->url(array(), 'user_general', true))
  ->render($this);
?>

<script type="text/javascript">
   jQuery(document).ready(function(){
   jQuery('#global_page_user-index-landlords span#profile_type-label').closest("li").css('display','none');
   jQuery('#global_page_user-index-tenants span#profile_type-label').closest("li").css('display','none');
   jQuery('#global_page_user-index-services span#profile_type-label').closest("li").css('display','none');
   jQuery('#global_page_user-index-browse span#keyword-label').closest("li").css('display','none');             
                    });
 </script>
    
<script type="text/javascript">
//    en4.core.runonce.add(function () {
        var formElement = jQuery('.layout_user_browse_search .field_search_criteria')[0];
        // On search
        formElement.addEvent('submit', function (event) {
			<?php if($this->page_url	==	'/members') { ?>
			// to change the value of tenants to 1
			var profiletype	=	jQuery('#profile_type').val();
			if(profiletype	==	'')
			{
				jQuery("#profile_type").find("option").eq(0).val('1');
			}
			<?php } ?>
			
            if (!window.searchMembers) {
                return;
            }
            event.stop();
            searchMembers();
        });

        window.addEvent('onChangeFields', function (event) {

            var firstSep = $$('li.browse-separator-wrapper')[0];
            var lastSep;
            var nextEl = firstSep;
            var allHidden = true;
            do {
                nextEl = nextEl.getNext();
                if (nextEl.get('class') == 'browse-separator-wrapper') {
                    lastSep = nextEl;
                    nextEl = false;
                } else {
                    allHidden = allHidden && (nextEl.getStyle('display') == 'none');
                }
            } while (nextEl);
            if (lastSep) {
				
                lastSep.setStyle('display', (allHidden ? 'none' : ''));
                 <?php if($this->page_url	==	'/services') { ?>
                jQuery('span#1_6_53_field_53-label').closest("li").removeAttr("style");
				jQuery('span#1_6_54_field_54-label').closest("li").removeAttr("style");
                jQuery('span#1_6_55_field_55-label').closest("li").removeAttr("style");
				jQuery('span#1_6_62_field_62-label').closest("li").removeAttr("style");
				jQuery('span#1_6_68_field_68-label').closest("li").removeAttr("style");
				<?php } elseif($this->page_url	==	'/tenants') { ?>
					
					jQuery('span#1_1_5_alias_gender-label').closest("li").removeAttr("style");
				   jQuery('span#1_1_13_alias_about_me-label').closest("li").removeAttr("style");
				   jQuery('.browse-range-wrapper').removeAttr("style");
				   jQuery('span#1_1_14_field_14-label').closest("li").removeAttr("style");
				   jQuery('span#1_1_15_field_15-label').closest("li").removeAttr("style");
				   jQuery('span#1_1_16_field_16-label').closest("li").removeAttr("style");
				   jQuery('span#1_1_69_field_69-label').closest("li").removeAttr("style");
				   jQuery('span#1_1_70_field_70-label').closest("li").removeAttr("style");
				    jQuery('span#1_4_75_field_75-label').closest("li").removeAttr("style");
				    jQuery('span#1_4_76_field_76-label').closest("li").removeAttr("style");
				    jQuery('span#1_4_77_field_77-label').closest("li").removeAttr("style");
				    event.stop();
				<?php } elseif($this->page_url	==	'/landlords') { ?>
				   jQuery('span#1_4_19_alias_gender-label').closest("li").removeAttr("style");
				   jQuery('span#1_4_33_field_33-label').closest("li").removeAttr("style");
				   jQuery('span#1_4_30_field_30-label').closest("li").removeAttr("style");
				   jQuery('span#1_4_31_field_31-label').closest("li").removeAttr("style");
				   jQuery('span#1_4_23_field_23-label').closest("li").removeAttr("style");
				   jQuery('span#1_4_34_field_34-label').closest("li").removeAttr("style");
				<?php } ?>
					}
        });
 //   });
    
    function displayFields(){
		var profiletype	=	jQuery('#profile_type').val();
		if(profiletype	==	'')
		{
			profiletype	=	1;
		}
		
		jQuery('.basicsearch').css('display','block');
		jQuery('.advsearch').css('display','none');
		jQuery('.basicsearch').addClass('active');
		jQuery('.advsearch').removeClass('active');
		<?php if($this->page_url	==	'/services') { ?>
		
			   jQuery('span#1_6_53_field_53-label').closest("li").removeAttr("style");
			   jQuery('span#1_6_54_field_54-label').closest("li").removeAttr("style");
			   jQuery('span#1_6_55_field_55-label').closest("li").removeAttr("style");
			   jQuery('span#1_6_62_field_62-label').closest("li").removeAttr("style");
			   jQuery('span#1_6_68_field_68-label').closest("li").removeAttr("style");
	           jQuery('span#profile_type-label').closest("li").css('display','none');
	           
	           jQuery('#global_page_user-index-services span#1_4_33_field_33-label').closest("li").css('display','none');
			   jQuery('#global_page_user-index-services span#1_4_30_field_30-label').closest("li").css('display','none');
			   jQuery('#global_page_user-index-services span#1_4_31_field_31-label').closest("li").css('display','none');
        <?php } elseif(($this->page_url	==	'/tenants')) { ?>
			   jQuery('span#1_1_5_alias_gender-label').closest("li").removeAttr("style");
			   jQuery('span#1_1_13_alias_about_me-label').closest("li").removeAttr("style");
			   jQuery('.browse-range-wrapper').removeAttr("style");
			   jQuery('span#1_1_14_field_14-label').closest("li").removeAttr("style");
			   jQuery('span#1_1_15_field_15-label').closest("li").removeAttr("style");
			   jQuery('span#1_1_16_field_16-label').closest("li").removeAttr("style");
			   jQuery('span#1_1_69_field_69-label').closest("li").removeAttr("style");
			   jQuery('span#1_1_70_field_70-label').closest("li").removeAttr("style");
			   jQuery('span#1_1_75_field_75-label').closest("li").removeAttr("style");
			   jQuery('span#1_1_76_field_76-label').closest("li").removeAttr("style");
			   jQuery('span#1_1_77_field_77-label').closest("li").removeAttr("style");
			   jQuery("#1_1_5_alias_gender").val("");
               jQuery('span#profile_type-label').closest("li").css('display','none');
		<?php } elseif($this->page_url	==	'/landlords') { ?>
                
			   jQuery('span#1_4_19_alias_gender-label').closest("li").removeAttr("style");
			   jQuery('span#1_4_33_field_33-label').closest("li").removeAttr("style");
			   jQuery('span#1_4_30_field_30-label').closest("li").removeAttr("style");
			   jQuery('span#1_4_31_field_31-label').closest("li").removeAttr("style");
			   jQuery('span#1_4_23_field_23-label').closest("li").removeAttr("style");
			   jQuery('span#1_4_34_field_34-label').closest("li").removeAttr("style");
			   jQuery("#1_4_19_alias_gender").val("");
			   jQuery('span#profile_type-label').closest("li").css('display','none');
		<?php } elseif($this->page_url	==	'/members') { ?>
			jQuery('span#keyword-label').closest("li").css('display','none');
			if(profiletype	==	6)
			{
			   jQuery('span#1_6_53_field_53-label').closest("li").removeAttr("style");
			   jQuery('span#1_6_54_field_54-label').closest("li").removeAttr("style");
			   jQuery('span#1_6_55_field_55-label').closest("li").removeAttr("style");
			   jQuery('span#1_6_62_field_62-label').closest("li").removeAttr("style");
			   jQuery('span#1_6_68_field_68-label').closest("li").removeAttr("style");
			   
			    jQuery('#1_4_33_field_33').html('');
			    jQuery('#1_1_75_field_75').html('');
			    jQuery('#1_6_53_field_53').html('');
			    jQuery('#1_6_53_field_53').append('<option value="1">United States of America</option>');
			   
			   
			}
			else if(profiletype	==	1)
			{ 
			   jQuery('span#1_1_5_alias_gender-label').closest("li").removeAttr("style");
			   jQuery('span#1_1_13_alias_about_me-label').closest("li").removeAttr("style");
			   jQuery('.browse-range-wrapper').removeAttr("style");
			   jQuery('span#1_1_14_field_14-label').closest("li").removeAttr("style");
			   jQuery('span#1_1_15_field_15-label').closest("li").removeAttr("style");
			   jQuery('span#1_1_16_field_16-label').closest("li").removeAttr("style");
			   jQuery('span#1_1_70_field_70-label').closest("li").removeAttr("style");
			   jQuery('span#1_1_69_field_69-label').closest("li").removeAttr("style");
			   jQuery('span#1_1_75_field_75-label').closest("li").removeAttr("style");
			   jQuery('span#1_1_76_field_76-label').closest("li").removeAttr("style");
			   jQuery('span#1_1_77_field_77-label').closest("li").removeAttr("style");
			   jQuery("#1_1_5_alias_gender").val("");
			   
			    jQuery('#1_4_33_field_33').html('');
			    jQuery('#1_1_75_field_75').html('');
			    jQuery('#1_6_53_field_53').html('');
			   jQuery('#1_1_75_field_75').append('<option value="1">United States of America</option>');
			   
		    }
		    else if(profiletype	==	4)
		    {
			   jQuery('span#1_4_19_alias_gender-label').closest("li").removeAttr("style");
			   jQuery('span#1_4_33_field_33-label').closest("li").removeAttr("style");
			   jQuery('span#1_4_30_field_30-label').closest("li").removeAttr("style");
			   jQuery('span#1_4_31_field_31-label').closest("li").removeAttr("style");
			   jQuery('span#1_4_23_field_23-label').closest("li").removeAttr("style");
			   jQuery('span#1_4_34_field_34-label').closest("li").removeAttr("style");
			   jQuery("#1_4_19_alias_gender").val("");
			   
			   
			    jQuery('#1_4_33_field_33').html('');
			    jQuery('#1_1_75_field_75').html('');
			    jQuery('#1_6_53_field_53').html('');
			   jQuery('#1_4_33_field_33').append('<option value="1">United States of America</option>');
		    }
			<?php } ?>
	   }
	   
	 function hideFields(){
		var profiletype	=	jQuery('#profile_type').val();
		if(profiletype	==	'')
		{
			profiletype	=	1;
		}
		
		jQuery('.basicsearch').css('display','none');
		jQuery('.advsearch').css('display','block');
		jQuery('.basicsearch').removeClass('active');
		jQuery('.advsearch').addClass('active');
		<?php if($this->page_url	==	'/services') { ?>
			   jQuery('span#1_6_53_field_53-label').closest("li").css('display','none');
			   jQuery('span#1_6_54_field_54-label').closest("li").css('display','none');
			   jQuery('span#1_6_55_field_55-label').closest("li").css('display','none');
			   jQuery('span#1_6_62_field_62-label').closest("li").css('display','none');
			   jQuery('span#1_6_68_field_68-label').closest("li").css('display','none');
			   jQuery('#1_6_62_field_62').val('');
			   jQuery('#1_6_68_field_68').val('');
			   
			   jQuery('#global_page_user-index-services span#1_6_53_field_53-label').closest("li").css('display','block');
			   jQuery('#global_page_user-index-services span#1_6_54_field_54-label').closest("li").css('display','block');
			   jQuery('#global_page_user-index-services span#1_6_55_field_55-label').closest("li").css('display','block');
               jQuery('span#keyword-label').closest("li").css('display','block');
        <?php } elseif($this->page_url	==	'/tenants') { ?>
			   jQuery('span#1_1_5_alias_gender-label').closest("li").css('display','none');
			   jQuery('span#1_1_13_alias_about_me-label').closest("li").css('display','none');
			   jQuery('.browse-range-wrapper').css('display','none');
			   jQuery('span#1_1_14_field_14-label').closest("li").css('display','none');
			   jQuery('span#1_1_15_field_15-label').closest("li").css('display','none');
			   jQuery('span#1_1_16_field_16-label').closest("li").css('display','none');
			   jQuery('span#1_1_69_field_69-label').closest("li").css('display','none');
			   jQuery('span#1_1_72_field_72-label').closest("li").css('display','none');
			   jQuery('span#1_1_73_field_73-label').closest("li").css('display','none');
			   jQuery('span#1_1_70_field_70-label').closest("li").css('display','none');
			   jQuery('span#1_1_71_field_71-label').closest("li").css('display','none');

			   jQuery('#1_1_14_field_14').val('');
			   jQuery('#1_1_15_field_15').val('');
			   jQuery('#1_1_72_field_72').val('');
			   jQuery('#1_1_73_field_73').val('');
			   jQuery('#1_1_69_field_69').val('');
			   jQuery('#1_1_70_field_70').val('');
			   jQuery('#1_1_71_field_71').val('');
			   jQuery('#1_1_76_field_76').val('');
			   jQuery('#1_1_77_field_77').val('');
			   jQuery("#1_1_5_alias_gender").val("");
			    
			   jQuery('span#1_1_75_field_75-label').closest("li").css('display','none');
			   jQuery('span#1_1_76_field_76-label').closest("li").css('display','none');
			   jQuery('span#1_1_77_field_77-label').closest("li").css('display','none');
			    
			    
			   jQuery('#global_page_user-index-tenants span#1_1_70_field_70-label').closest("li").css('display','block');
			   jQuery('#global_page_user-index-tenants span#1_1_15_field_15-label').closest("li").css('display','block');
			   jQuery('span#keyword-label').closest("li").css('display','block');
		<?php } elseif($this->page_url	==	'/landlords') { ?>
			   jQuery('span#1_4_19_alias_gender-label').closest("li").css('display','none');
			   jQuery('span#1_4_33_field_33-label').closest("li").css('display','none');
			   jQuery('span#1_4_30_field_30-label').closest("li").css('display','none');
			   jQuery('span#1_4_31_field_31-label').closest("li").css('display','none');
			   jQuery('span#1_4_23_field_23-label').closest("li").css('display','none');
			   jQuery('span#1_4_34_field_34-label').closest("li").css('display','none');
			   jQuery('#1_4_34_field_34').val('');
			   jQuery("#1_4_19_alias_gender").val("");
			    
			   jQuery('#global_page_user-index-landlords span#1_4_33_field_33-label').closest("li").css('display','block');
			   jQuery('#global_page_user-index-landlords span#1_4_30_field_30-label').closest("li").css('display','block');
			   jQuery('#global_page_user-index-landlords span#1_4_31_field_31-label').closest("li").css('display','block');
		       jQuery('span#keyword-label').closest("li").css('display','block');
		<?php } elseif($this->page_url	==	'/members') { ?>
			jQuery('span#keyword-label').closest("li").css('display','none');
			if(profiletype	==	6)
			{
			   jQuery('span#1_6_53_field_53-label').closest("li").css('display','none');
			   jQuery('span#1_6_54_field_54-label').closest("li").css('display','none');
			   jQuery('span#1_6_55_field_55-label').closest("li").css('display','none');
			   jQuery('span#1_6_62_field_62-label').closest("li").css('display','none');
			   jQuery('span#1_6_68_field_68-label').closest("li").css('display','none');
			   //jQuery('span#services_type_id-label').closest("li").css('display','none');
			   jQuery('#1_6_62_field_62').val('');
			   jQuery('#1_6_68_field_68').val('');
		   }
		   else if(profiletype	==	1)
		   {
				jQuery('span#1_1_5_alias_gender-label').closest("li").css('display','none');
			   jQuery('span#1_1_13_alias_about_me-label').closest("li").css('display','none');
			   jQuery('.browse-range-wrapper').css('display','none');
			   jQuery('span#1_1_14_field_14-label').closest("li").css('display','none');
			   jQuery('span#1_1_15_field_15-label').closest("li").css('display','none');
			   jQuery('span#1_1_16_field_16-label').closest("li").css('display','none');
			   jQuery('span#1_1_72_field_72-label').closest("li").css('display','none');
			   jQuery('span#1_1_73_field_73-label').closest("li").css('display','none');
			   jQuery('span#1_1_70_field_73-label').closest("li").css('display','none');
			   jQuery('span#1_1_70_field_70-label').closest("li").css('display','none');
			   jQuery('span#1_1_71_field_71-label').closest("li").css('display','none');
			   jQuery('span#1_1_69_field_69-label').closest("li").css('display','none');
			   jQuery('span#services_type_id-label').closest("li").css('display','none');
			   jQuery('#1_1_14_field_14').val('');
			   jQuery('#1_1_15_field_15').val('');
			   jQuery('#1_1_72_field_72').val('');
			   jQuery('#1_1_73_field_73').val('');
			   jQuery('#1_1_69_field_69').val('');
			   jQuery('#1_1_70_field_70').val('');
			   jQuery('#1_1_71_field_71').val('');
			   jQuery('#1_1_76_field_76').val('');
			   jQuery('#1_1_77_field_77').val('');
			   jQuery("#1_1_5_alias_gender").val("");
			   
			   jQuery('span#1_1_75_field_75-label').closest("li").css('display','none');
			   jQuery('span#1_1_76_field_76-label').closest("li").css('display','none');
			   jQuery('span#1_1_77_field_77-label').closest("li").css('display','none');
		   }
		   else if(profiletype	==	4)
		   {
			   jQuery('span#1_4_19_alias_gender-label').closest("li").css('display','none');
			   jQuery('span#1_4_33_field_33-label').closest("li").css('display','none');
			   jQuery('span#1_4_30_field_30-label').closest("li").css('display','none');
			   jQuery('span#1_4_31_field_31-label').closest("li").css('display','none');
			   jQuery('span#1_4_23_field_23-label').closest("li").css('display','none');
			   jQuery('span#1_4_34_field_34-label').closest("li").css('display','none');
			   jQuery('span#services_type_id-label').closest("li").css('display','none');
			   jQuery('#1_4_34_field_34').val('');
			   jQuery("#1_4_19_alias_gender").val("");
		   }
		<?php } ?>
	   }
	   
	function changetype()
	{
		var profiletype	=	jQuery('#profile_type').val();
		if(profiletype	==	'')
		{
			profiletype	=	1;
		}
		
		if(jQuery('.basicsearch').hasClass('active')){
					jQuery('.basicsearch').css('display','block');
					jQuery('.advsearch').css('display','none');
			if(profiletype	==	6)
			{  
			   //	to hide tenants fields
			   jQuery('span#1_1_5_alias_gender-label').closest("li").css('display','none');
			   jQuery('span#1_1_13_alias_about_me-label').closest("li").css('display','none');
			   jQuery('.browse-range-wrapper').css('display','none');
			   jQuery('span#1_1_14_field_14-label').closest("li").css('display','none');
			   jQuery('span#1_1_15_field_15-label').closest("li").css('display','none');
			   jQuery('span#1_1_16_field_16-label').closest("li").css('display','none');
			   jQuery('span#1_1_72_field_72-label').closest("li").css('display','none');
			   jQuery('span#1_1_73_field_73-label').closest("li").css('display','none');
			   jQuery('span#1_1_70_field_70-label').closest("li").css('display','none');
			   jQuery('span#1_1_69_field_69-label').closest("li").css('display','none');
			   jQuery('span#1_1_75_field_75-label').closest("li").css('display','none');
			   jQuery('span#1_1_76_field_76-label').closest("li").css('display','none');
			   jQuery('span#1_1_77_field_77-label').closest("li").css('display','none');
			   
			   jQuery('#1_1_14_field_14').val('');
			   jQuery('#1_1_15_field_15').val('');
			   jQuery('#1_1_72_field_72').val('');
			   jQuery('#1_1_73_field_73').val('');
			   jQuery('#1_1_69_field_69').val('');
			   jQuery('#1_1_60_field_60').val('');
			   jQuery('#1_1_70_field_60').val('');
			   jQuery('#1_1_76_field_76').val('');
			   jQuery('#1_1_77_field_77').val('');
			    jQuery("#1_1_5_alias_gender").val("");
			   
			    //	to hide landlords fields
			   jQuery('span#1_4_19_alias_gender-label').closest("li").css('display','none');
			   jQuery('span#1_4_33_field_33-label').closest("li").css('display','none');
			   jQuery('span#1_4_30_field_30-label').closest("li").css('display','none');
			   jQuery('span#1_4_31_field_31-label').closest("li").css('display','none');
			   jQuery('span#1_4_23_field_23-label').closest("li").css('display','none');
			   jQuery('span#1_4_34_field_34-label').closest("li").css('display','none');
			   jQuery('#1_4_34_field_34').val('');
			   jQuery("#1_4_19_alias_gender").val("");
				
			   jQuery('span#1_6_53_field_53-label').closest("li").removeAttr("style");
			   jQuery('span#1_6_54_field_54-label').closest("li").removeAttr("style");
			   jQuery('span#1_6_55_field_55-label').closest("li").removeAttr("style");
			   jQuery('span#1_6_62_field_62-label').closest("li").removeAttr("style");
			   jQuery('span#1_6_68_field_68-label').closest("li").removeAttr("style");
			   jQuery('span#services_type_id-label').closest("li").removeAttr("style");
			   jQuery('#1_6_62_field_62').val('');
			   jQuery('#1_6_68_field_68').val('');
			   
			    jQuery('#1_4_33_field_33').html('');
			    jQuery('#1_1_75_field_75').html('');
			    jQuery('#1_6_53_field_53').html('');
			    jQuery('#1_6_53_field_53').append('<option value="1">United States of America</option>');
			   
			}
			else if(profiletype	==	1)
			{ 
				// to hide services fields
			   jQuery('span#1_6_53_field_53-label').closest("li").css('display','none');
			   jQuery('span#1_6_54_field_54-label').closest("li").css('display','none');
			   jQuery('span#1_6_55_field_55-label').closest("li").css('display','none');
			   jQuery('span#1_6_62_field_62-label').closest("li").css('display','none');
			   jQuery('span#1_6_68_field_68-label').closest("li").css('display','none');
			   jQuery('span#services_type_id-label').closest("li").css('display','none');
			   jQuery('#1_6_62_field_62').val('');
			   jQuery('#1_6_68_field_68').val('');

			   // to hide landlords fields
			   jQuery('span#1_4_19_alias_gender-label').closest("li").css('display','none');
			   jQuery('span#1_4_33_field_33-label').closest("li").css('display','none');
			   jQuery('span#1_4_30_field_30-label').closest("li").css('display','none');
			   jQuery('span#1_4_31_field_31-label').closest("li").css('display','none');
			   jQuery('span#1_4_23_field_23-label').closest("li").css('display','none');
			   jQuery('span#1_4_34_field_34-label').closest("li").css('display','none');
			   jQuery('#1_4_34_field_34').val('');
			   jQuery("#1_4_19_alias_gender").val("");
			   
			   jQuery('span#1_1_5_alias_gender-label').closest("li").removeAttr("style");
			   jQuery('span#1_1_13_alias_about_me-label').closest("li").removeAttr("style");
			   jQuery('.browse-range-wrapper').removeAttr("style");
			   jQuery('span#1_1_14_field_14-label').closest("li").removeAttr("style");
			   jQuery('span#1_1_15_field_15-label').closest("li").removeAttr("style");
			   jQuery('span#1_1_16_field_16-label').closest("li").removeAttr("style");
			   jQuery('span#1_1_69_field_69-label').closest("li").removeAttr("style");
			   jQuery('span#1_1_75_field_75-label').closest("li").removeAttr("style");
			   jQuery('span#1_1_76_field_76-label').closest("li").removeAttr("style");
			   jQuery('span#1_1_77_field_77-label').closest("li").removeAttr("style");
			   
			    jQuery('#1_4_33_field_33').html('');
			    jQuery('#1_1_75_field_75').html('');
			    jQuery('#1_6_53_field_53').html('');
			   jQuery('#1_1_75_field_75').append('<option value="1">United States of America</option>');
			   
		    }
		    else if(profiletype	==	4)
		    {
			   // to hide services fields
			   jQuery('span#1_6_53_field_53-label').closest("li").css('display','none');
			   jQuery('span#1_6_54_field_54-label').closest("li").css('display','none');
			   jQuery('span#1_6_55_field_55-label').closest("li").css('display','none');
			   jQuery('span#1_6_62_field_62-label').closest("li").css('display','none');
			   jQuery('span#1_6_68_field_68-label').closest("li").css('display','none');
			   jQuery('span#services_type_id-label').closest("li").css('display','none');
			   jQuery('#1_6_62_field_62').val('');
			   jQuery('#1_6_68_field_68').val('');

			   // to hide tenants fields
			   jQuery('span#1_1_5_alias_gender-label').closest("li").css('display','none');
			   jQuery('span#1_1_13_alias_about_me-label').closest("li").css('display','none');
			   jQuery('.browse-range-wrapper').css('display','none');
			   jQuery('span#1_1_14_field_14-label').closest("li").css('display','none');
			   jQuery('span#1_1_15_field_15-label').closest("li").css('display','none');
			   jQuery('span#1_1_16_field_16-label').closest("li").css('display','none');
			   jQuery('span#1_1_72_field_72-label').closest("li").css('display','none');
			   jQuery('span#1_1_73_field_73-label').closest("li").css('display','none');
			   jQuery('span#1_1_70_field_70-label').closest("li").css('display','none');
			   jQuery('span#1_1_69_field_69-label').closest("li").css('display','none');
			   jQuery('span#1_1_75_field_75-label').closest("li").css('display','none');
			   jQuery('span#1_1_76_field_76-label').closest("li").css('display','none');
			   jQuery('span#1_1_77_field_77-label').closest("li").css('display','none');
			   jQuery('#1_1_14_field_14').val('');
			   jQuery('#1_1_15_field_15').val('');
			   jQuery('#1_1_72_field_72').val('');
			   jQuery('#1_1_73_field_73').val('');
			   jQuery('#1_1_69_field_69').val('');
			   jQuery('#1_1_70_field_70').val('');
			   jQuery('#1_1_76_field_76').val('');
			   jQuery('#1_1_77_field_77').val('');
			    jQuery("#1_1_5_alias_gender").val("");
				
			   jQuery('span#1_4_19_alias_gender-label').closest("li").removeAttr("style");
			   jQuery('span#1_4_33_field_33-label').closest("li").removeAttr("style");
			   jQuery('span#1_4_30_field_30-label').closest("li").removeAttr("style");
			   jQuery('span#1_4_31_field_31-label').closest("li").removeAttr("style");
			   jQuery('span#1_4_23_field_23-label').closest("li").removeAttr("style");
			   jQuery('span#1_4_34_field_34-label').closest("li").removeAttr("style");
			    jQuery('#1_4_33_field_33').html('');
			    jQuery('#1_1_75_field_75').html(''); 
			    jQuery('#1_6_53_field_53').html('');
			   jQuery('#1_4_33_field_33').append('<option value="1">United States of America</option>');
		    }
		}
		else
		{
			if(profiletype	==	6)
			{   jQuery('#1_1_75_field_75').html('');
				jQuery('span#services_type_id-label').closest("li").removeAttr("style");
			}
			else if(profiletype	==	1)
			{
				jQuery('span#services_type_id-label').closest("li").css('display','none');
			}
			else if(profiletype	==	4)
			{    jQuery('#1_1_75_field_75').html('');
				jQuery('span#services_type_id-label').closest("li").css('display','none');
			}
		}
	}
	  
	function showSpecialize()
	{
		var edu	=	jQuery("#1_1_14_field_14").val();
		if(edu	==	18)
		{
			jQuery('span#1_1_72_field_72-label').closest("li").removeAttr("style");
			jQuery('span#1_1_73_field_73-label').closest("li").css('display','none');

		}
		else if(edu == 19)
		{
			jQuery('span#1_1_73_field_73-label').closest("li").removeAttr("style");
			jQuery('span#1_1_72_field_72-label').closest("li").css('display','none');
		}
		else
		{
			jQuery('span#1_1_73_field_73-label').closest("li").css('display','none');
			jQuery('span#1_1_72_field_72-label').closest("li").css('display','none');
		}
		
	}   
	jQuery(document).ready(function(){
		jQuery("#profile_type").find("option").eq(0).remove();
		jQuery("#profile_type").find("option").eq(0).val('');
        jQuery("#profile_type").attr('onchange','changetype()');
        jQuery('span#services_type_id-label').closest("li").css('display','none');
        jQuery("#1_1_5_alias_gender").attr('onchange','');
        jQuery("#1_4_19_alias_gender").attr('onchange','');
        jQuery("#1_4_34_field_34").attr('onchange','');
        jQuery('.advsearch').addClass('active');
        jQuery("#1_1_14_field_14").attr('onchange','showSpecialize()');
		jQuery("#1_1_72_field_72").attr('onchange','');
		jQuery("#1_1_73_field_73").attr('onchange','');
		jQuery("#1_1_15_field_15").attr('onchange','');		
		jQuery("#1_1_69_field_69").attr('onchange','');
		jQuery("#1_1_14_field_14").find("option").eq(0).text('Select');
	    jQuery("#1_1_15_field_15").find("option").eq(0).text('Select Income');
	    jQuery("#1_1_72_field_72").find("option").eq(0).text('Select');
		jQuery("#1_1_73_field_73").find("option").eq(0).text('Select');
		jQuery("#1_1_70_field_70").find("option").eq(0).text('Select');
		jQuery("#1_1_70_field_70").attr('onchange','showPetsType()');
		jQuery("#1_1_71_field_71").attr('onchange','');
		
	 jQuery("#1_1_5_alias_gender").find("option").eq(0).remove();
     jQuery('<option>').val('').text('Both').prependTo('#1_1_5_alias_gender');
     jQuery("#1_1_5_alias_gender").val("");
     
     jQuery("#1_4_19_alias_gender").find("option").eq(0).remove();
     jQuery('<option>').val('').text('Both').prependTo('#1_4_19_alias_gender');
     jQuery("#1_4_19_alias_gender").val("");
     
   
		
    });
    
    jQuery( window ).load(function() {
		
		   jQuery('span#1_1_71_field_71-label').closest("li").css('display','none');
		   jQuery('span#1_1_72_field_72-label').closest("li").css('display','none');
		   jQuery('span#1_1_73_field_73-label').closest("li").css('display','none');
		   
		   jQuery('#global_page_user-index-landlords span#1_4_33_field_33-label').closest("li").css('display','block');
		   jQuery('#global_page_user-index-landlords span#1_4_30_field_30-label').closest("li").css('display','block');
		   jQuery('#global_page_user-index-landlords span#1_4_31_field_31-label').closest("li").css('display','block');
				   
		   jQuery('#global_page_user-index-services span#1_6_53_field_53-label').closest("li").css('display','block');
		   jQuery('#global_page_user-index-services span#1_6_54_field_54-label').closest("li").css('display','block');
		   jQuery('#global_page_user-index-services span#1_6_55_field_55-label').closest("li").css('display','block');
				   
		   jQuery('#global_page_user-index-tenants span#1_1_70_field_70-label').closest("li").css('display','block');
		   jQuery('#global_page_user-index-tenants span#1_1_15_field_15-label').closest("li").css('display','block');
  });

    
    function showPetsType(){
		
			var profiletype	=	jQuery('#profile_type').val(); 
			if(profiletype	==	'')
				{
					profiletype	=	1;
				}
			
			<?php if(($this->page_url	==	'/tenants')||( $this->page_url	==	'/members' )) { ?>
				
				if(profiletype == 1){
				
				var pets_allowed= jQuery("#1_1_70_field_70").val(); 
				if(pets_allowed ==11){
				
					jQuery('span#1_1_71_field_71-label').closest("li").removeAttr("style");
					jQuery("#1_1_71_field_71").find("option").eq(0).text('Select pets type');
				}
				else{
					jQuery('span#1_1_71_field_71-label').closest("li").css('display','none');
					jQuery('#1_1_71_field_71').val('');
				}
				
			}
			<?php } ?>
		
	}
	
	
	jQuery(document).ready(function(){
		
	var profiletype	=	jQuery('#profile_type').val();
	var pagination_count	=	'<?php echo $this->pagination_count;?>';
		if(profiletype	==	'')
		{
			profiletype	=	1;
		}

		if(profiletype	==	4)
		{
				   jQuery('span#1_4_30_field_30-label').closest("li").removeAttr("style");
				   jQuery('span#1_4_31_field_31-label').closest("li").removeAttr("style");
				   jQuery('.basicsearch').css('display','block');
				   jQuery('.advsearch').css('display','none');
		           jQuery('.basicsearch').addClass('active');
		           jQuery('.advsearch').removeClass('active');
		           jQuery('span#services_type_id-label').closest("li").css('display','none');
				   
		}
		
		if(profiletype	==	6)
		{
				   jQuery('span#1_6_54_field_54-label').closest("li").removeAttr("style");
				   jQuery('span#1_6_55_field_55-label').closest("li").removeAttr("style");
				   jQuery('.basicsearch').css('display','block');
				   jQuery('.advsearch').css('display','none');
		           jQuery('.basicsearch').addClass('active');
		           jQuery('.advsearch').removeClass('active');
		           jQuery('span#services_type_id-label').closest("li").removeAttr("style");
				   
		}
		
		if(profiletype	==	1 && pagination_count >= 1 )
		{
				   jQuery("#profile_type").find("option").eq(0).val(1);
				   jQuery('span#1_1_76_field_76-label').closest("li").removeAttr("style");
				   jQuery('span#1_1_77_field_77-label').closest("li").removeAttr("style");
				   jQuery('.basicsearch').css('display','block');
				   jQuery('.advsearch').css('display','none');
		           jQuery('.basicsearch').addClass('active');
		           jQuery('.advsearch').removeClass('active');
		}
	var page_url = '<?php echo $this->page_url; ?>';  
	
	//landlords	 country state start
		  
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
     if(page_url =='/landlords'){	
						jQuery.each(data, function (i, item) {
						
						jQuery('#1_4_33_field_33').append(jQuery('<option>', { 
							value: item.id,
							text : item.country 
						}));
						
						
					});
				}
				
		if(page_url == '/members' && profiletype	==	4){	
			jQuery('#1_4_33_field_33').append('<option value="1">United States of America</option>');
		}
					},
					   error: function(e){  console.log(e);//alert('Error: '+e);  
						   }  
					});
					
					jQuery("#1_4_30_field_30")
    .replaceWith('<select id="1_4_30_field_30" name="1_4_30_field_30" class="" onclick="getcity();"> </select>') ;
    
					jQuery("#1_4_31_field_31")
    .replaceWith('<select id="1_4_31_field_31" name="1_4_31_field_31" class="" > </select>') ;
    
    // get states
    
    
    getstates();  
		  
		  
	
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
					});
					
	 }

 //landlords	 country state end 
 
 jQuery("#1_6_53_field_53").attr("onchange" , "");
		var host	=	window.location.host;
		var url	=	'<?php echo $this->baseUrl()?>' + '/user/signup/getcountries';
			  jQuery.ajax({
						 url:  url,
						 dataType: 'json',
						 type: 'POST',
					 success: function (data) { console.log(data);
						
						jQuery("#1_6_53_field_53")
							.replaceWith('<select id="1_6_53_field_53" name="1_6_53_field_53" class="" onclick="getservicestates();"> </select>') ;
							 //jQuery('#1_6_53_field_53').append('<option></option>');
						if(page_url =='/services'){	 
							 
						jQuery.each(data, function (i, item) {
						jQuery('#1_6_53_field_53').append(jQuery('<option>', { 
							value: item.id,
							text : item.country 
						}));
						
						
					});
				    }
				    
				  if(page_url == '/members' && profiletype	==	6){	
			jQuery('#1_6_53_field_53').append('<option value="1">United States of America</option>');
			}
					},
					   error: function(e){  //alert('Error: '+e);
						   console.log(e);  }  
					});
					
		jQuery("#1_6_54_field_54")
							.replaceWith('<select id="1_6_54_field_54" name="1_6_54_field_54" class="" onclick="getservicecity();"> </select>') ;
							
		jQuery("#1_6_55_field_55")
							.replaceWith('<select id="1_6_55_field_55" name="1_6_55_field_55" class="" > </select>') ;
							
	getservicestates();			
 
 
 
     function getservicestates(){
		
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
 
		jQuery("#1_1_75_field_75").attr("onchange" , "");
		var host	=	window.location.host;
		
		var url	=	'<?php echo $this->baseUrl()?>' + '/user/signup/getcountries';
			  jQuery.ajax({
						 url:  url,
						
						dataType: 'json',
						type: 'POST',
					 success: function (data) { console.log(data);
						
						jQuery("#1_1_75_field_75")
    .replaceWith('<select id="1_1_75_field_75" name="1_1_75_field_75" class="" onclick="gettenantsstates();"> </select>') ;
     //jQuery('#1_4_33_field_33').append('<option></option>');
     
     if(page_url =='/tenants'){	 
						jQuery.each(data, function (i, item) {
						jQuery('#1_1_75_field_75').append(jQuery('<option>', { 
							value: item.id,
							text : item.country 
						}));
						
						
					});
				    }
				    
	 if(page_url == '/members' && profiletype	==	1){	
			jQuery('#1_1_75_field_75').append('<option value="1">United States of America</option>');
			}
					},
					   error: function(e){  console.log(e);//alert('Error: '+e);  
						   }  
					});
					
					jQuery("#1_1_76_field_76")
    .replaceWith('<select id="1_1_76_field_76" name="1_1_76_field_76" class="" onclick="gettenantcity();"> </select>') ;
    
					jQuery("#1_1_77_field_77")
    .replaceWith('<select id="1_1_77_field_77" name="1_1_77_field_77" class="" > </select>') ;
    
 
	  });
	
	
	
function getcity(){ // landlords
	
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
	
	
	
	function getservicecity(){
		
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
	

	
	
	
	
	// tenants
	
	var page_url = '<?php echo $this->page_url; ?>';  

    // get states
    
    
    gettenantsstates();


	
	
	  	function gettenantsstates(){

	if(jQuery('#1_1_76_field_76').hasClass('stoprepeatstate'))
	return;
		var host	=	window.location.host;
		var url	=	'<?php echo $this->baseUrl()?>' + '/user/signup/getstates';
		var country_id	=	jQuery('#1_1_75_field_75').val(); 
		var country_id	=	1; 
		jQuery("#1_4_30_field_30").attr("onchange" , "");
		//jQuery("#1_4_30_field_30").val('');
	jQuery('#1_1_76_field_76').find('option').remove();
			  jQuery.ajax({
						 url:  url,
						data: "countryId="+country_id,
						dataType: 'json',
						type: 'POST',
					 success: function (data) { console.log(data);
						 jQuery('#1_1_76_field_76').append('<option value="">Select state</option>');

     jQuery('#1_1_76_field_76').addClass('stoprepeatstate');
						jQuery.each(data, function (i, item) {
													
						jQuery('#1_1_76_field_76').append(jQuery('<option>', { 
							value: item.id,
							text : item.state 
						}));

					}); },
					   error: function(e){  //alert('Error: '+e);  
						   }  
					}); }
    
	
	
	    function gettenantcity(){
	

	jQuery("#1_1_77_field_77").attr("onchange" , "");
		var host	=	window.location.host;
	    var url	=	'<?php echo $this->baseUrl()?>' + '/user/signup/getcity'; 
		var state_id	=	jQuery('#1_1_76_field_76').val(); 
		//jQuery("#1_4_31_field_31").val('');
		jQuery('#1_1_77_field_77').find('option').remove();
			  jQuery.ajax({
						 url:  url,
						data: "stateId="+state_id,
						dataType: 'json',
						type: 'POST',
					 success: function (data) { console.log(data);

     jQuery('#1_1_77_field_77').append('<option value="">Select city</option>');
		 if(data.length != 0)
		 {
			jQuery('#1_1_77_field_77').addClass('stoprepeatcity');
		 }
	 
						jQuery.each(data, function (i, item) {
						jQuery('#1_1_77_field_77').append(jQuery('<option>', { 
							value: item.id,
							text : item.city 
						}));
					});},
					   error: function(e){  //alert('Error: '+e);
						     }  
					});
	}
	
	
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
					});
					
	 }

    
</script>
