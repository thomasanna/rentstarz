en4.core.runonce.add(function(){

	// reorder layout_right and layout_main
	// var layout_main = $('global_content').getElement('div.layout_main');
	// layout_main.grab( layout_main.getElement('div.layout_right'), 'bottom' );

	// read html in navigation class
	/* jQuery('.tabs_parent').each(function(){
		var tab_menu = jQuery(this).find("#main_tabs > li").toArray(),
			load_more = jQuery(this).find(".tab_pulldown_contents > ul");

		// reorder li for customize 
		if (tab_menu.length>=3) {
			for (index = 3; index < tab_menu.length; ++index) {
				if (!tab_menu[index].hasClass('tab_closed more_tab')) {
					// console.log( tab_menu[index].outerHTML );
					load_more.prepend( tab_menu[index].outerHTML );
					tab_menu[index].remove();
				} 
			}	
		}
	}); */

    /*** scroll smoothbox and fix body scroll ***/
     // open smoothbox
     Smoothbox.Modal.Iframe.prototype.onOpen=function()
     {
       try
       {
       document.body.addClass('ynsmoothbox_open');
       var elements = document.getElements('video');
        elements.each(function(e)
        {
         e.style.display = 'none';
        });
        var elements = document.getElements('object');
        elements.each(function(e)
        {
         e.style.display = 'none';
        });
        var elements = document.getElements('img.thumb_video');
        elements.each(function(e)
        {
         e.style.display = 'block';
        });
         }   
       catch(ex){ }
       this.fireEvent('openbefore', this);
     };

     // close smoothbox
     Smoothbox.Modal.Iframe.prototype.onClose=function()
     {
       try{ 
         document.body.removeClass('ynsmoothbox_open');
          var elements = document.getElements('video');
         elements.each(function(e)
         {
          e.style.display = 'block';
         });
         var elements = document.getElements('object');
         elements.each(function(e)
         {
          e.style.display = 'block';
         });
         var elements = document.getElements('img.thumb_video');
         elements.each(function(e)
         {
          e.style.display = 'none';
         });
       }
       catch(ex) { } 
       this.fireEvent('closeafter', this);
     };
    

	// make icon using headline breadcrumb 
	if( jQuery('.headline .tabs .navigation').length ) {
		jQuery('.headline .tabs').prepend('<span class="icon-headline glyphicon glyphicon-chevron-down"><span>');	
	}	
	
	jQuery('.headline .icon-headline').click(function(){
		var sthis 		= jQuery(this),
			dropdown = jQuery(this).parent().find(".navigation");
		if (dropdown.hasClass('open')) {
			sthis.removeClass('open');
			dropdown.removeClass('open');
		} else {
			sthis.addClass('open');
			dropdown.addClass('open');
		}
	});

	// fix long li counter (appear dropdown if count li over 5)
	if ( jQuery('.headline .tabs .navigation li').size()>4 ) {
		jQuery('.headline .tabs').addClass('navigation-over-list');
	}

	// make search icon
	if ( jQuery('.layout_right .filters').length || jQuery('.layout_right form[id$=filter_form]').length ) {
		jQuery('<span class="icon-search glyphicon glyphicon-search"></span>').insertAfter('.headline h2');
	}

	jQuery('.headline .icon-search').click(function(){
		var sthis 		= jQuery(this),
			search_down = jQuery('.layout_right .filters');
			search_form = jQuery('.layout_right form[id$=filter_form]');

		if ( sthis.hasClass('open')) {
			sthis.removeClass('open');			
			search_down.removeClass('open');			
			search_form.removeClass('open');			
		} else {
			sthis.addClass('open');
			search_down.addClass('open');
			search_form.addClass('open');
		}
	});
	
    // check exist main-button-search
    if (!jQuery('#ynevent_form_browse_filter').length) {
        jQuery('.main-button-search').hide();
    }
    
});