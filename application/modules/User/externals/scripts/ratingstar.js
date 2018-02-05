

(function ( jQuery ) {
 
    jQuery.fn.rating = function( method, options ) {
		method = method || 'create';
        // This is the easiest way to have default options.
        var settings = jQuery.extend({
            // These are the defaults.
			limit: 4,
			value: 0,
			glyph: "glyphicon-star",
            coloroff: "gray",
			coloron: "gold",
			size: "2.0em",
			cursor: "default",
			onClick: function () {},
            endofarray: "idontmatter"
        }, options );
		var style = "";
		style = style + "font-size:" + settings.size + "; ";
		style = style + "color:" + settings.coloroff + "; ";
		style = style + "cursor:" + settings.cursor + "; ";
	

		
		if (method == 'create')
		{
			//this.html('');	//junk whatever was there
			
			//initialize the data-rating property
			this.each(function(){
				attr = jQuery(this).attr('data-rating');
				if (attr === undefined || attr === false) { jQuery(this).attr('data-rating',settings.value); }
			})
			
			//bolt in the glyphs
			for (var i = 0; i < settings.limit; i++)
			{
				if(i== 0){var tooltip ="Rarely";}
				if(i== 1){var tooltip ="Sometimes";}
				if(i== 2){var tooltip ="Most of the time";}
				if(i== 3){var tooltip ="Always";}
				
				this.append('<span title="'+tooltip+'" data-value="' + (i+1) + '" class="ratingicon glyphicon ' + settings.glyph + '" style="' + style + '" aria-hidden="true"></span>');
			}
			
			//paint
			this.each(function() { paint(jQuery(this)); });

		}
		if (method == 'create1')
		{
			//this.html('');	//junk whatever was there
			
			//initialize the data-rating property
			this.each(function(){
				attr = jQuery(this).attr('data-rating');
				if (attr === undefined || attr === false) { jQuery(this).attr('data-rating',settings.value); }
			})
			
			//bolt in the glyphs
			for (var i = 0; i < settings.limit; i++)
			{
				if(i== 0){var tooltip ="Most of the time";}
				if(i== 1){var tooltip ="Sometimes";}
				if(i== 2){var tooltip ="Rarely";}
				if(i== 3){var tooltip ="Never";}
				
				this.append('<span title="'+tooltip+'" data-value="' + (i+1) + '" class="ratingicon glyphicon ' + settings.glyph + '" style="' + style + '" aria-hidden="true"></span>');
			}
			
			//paint
			this.each(function() { paint(jQuery(this)); });

		}
		if (method == 'set')
		{
			this.attr('data-rating',options);
			this.each(function() { paint(jQuery(this)); });
		}
		if (method == 'get')
		{
			return this.attr('data-rating');
		}
		//register the click events
		this.find("span.ratingicon").click(function() {
			rating = jQuery(this).attr('data-value')
			jQuery(this).parent().attr('data-rating',rating);
			paint(jQuery(this).parent());
			settings.onClick.call( jQuery(this).parent() );
		})
		function paint(div)
		{
			rating = parseInt(div.attr('data-rating'));
			div.find("input").val(rating);	//if there is an input in the div lets set it's value
			div.find("span.ratingicon").each(function(){	//now paint the stars
				
				var rating = parseInt(jQuery(this).parent().attr('data-rating'));
				var value = parseInt(jQuery(this).attr('data-value'));
				if (value > rating) { jQuery(this).css('color',settings.coloroff); }
				else { jQuery(this).css('color',settings.coloron); }
				
				if(rating == 1){
					
					if(jQuery(this). hasClass('selected')){
						
						jQuery(this).css('color',settings.coloroff);
						jQuery(this).removeClass('selected');
					}else{
					
					jQuery(this).addClass('selected');
					
				   }
				}
				else{
					
					jQuery(this).removeClass('selected');
				}

			})
		}

    };
 
}( jQuery ));
