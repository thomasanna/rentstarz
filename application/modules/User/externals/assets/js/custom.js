
// custom javascripting start

$(document).ready(function(){
    $('#selectAll').on('change',function(){
        if(this.checked){
            $('.notificationList .checkbox input[type="checkbox"]').each(function(){
                $('.notificationList .checkbox input[type="checkbox"]').attr('checked',true);
            });
             
        }
        else{     
            $('.notificationList .checkbox input[type="checkbox"]').each(function(){      
                $('.notificationList .checkbox input[type="checkbox"]').attr('checked', false);
            });
        }
        
    
    });
});