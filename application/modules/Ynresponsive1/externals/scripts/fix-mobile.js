en4.core.runonce.add(function(){
    
	// check if smoothbox windows auto add class in body
	var window_url = document.URL;
	if( window_url.contains("smoothbox") ) {
 	  
		// jQuery('html').addClass('ynsmoothbox_window');
		document.body.addClass('ynsmoothbox_content');
        
	}
});