
// custom javascripting start

jQuery(document).ready(function(){
    jQuery('#selectAll').on('change',function(){
        if(this.checked){
            jQuery('.notificationList .checkbox input[type="checkbox"]').each(function(){
                jQuery('.notificationList .checkbox input[type="checkbox"]').attr('checked',true);
            });
             
        }
        else{     
            jQuery('.notificationList .checkbox input[type="checkbox"]').each(function(){      
                jQuery('.notificationList .checkbox input[type="checkbox"]').attr('checked', false);
            });
        }
        
    
    });
});
