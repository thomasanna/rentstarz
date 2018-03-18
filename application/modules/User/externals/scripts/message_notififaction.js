//notification,message header icon
  //refresh box
  var refreshBox = function(box) {
      var img_loading = '<i class="fa fa-circle-o-notch fa-spin fa-lg fa-fw"></i>';
      if (box == 1) {
          // refresh message box
          inbox_count_down = 1;
          jQuery('ynadvmenu_messages_content').innerHTML = '<center>'+img_loading+'</center>';
          inbox();
      } else if (box == 2) {
          // refresh friend box
          friend_count_down = 1;
          jQuery('ynadvmenu_friends_content').innerHTML = '<center>'+img_loading+'</center>';
          freq();
      } else if (box == 3) {
          // refresh notification box
          notification_count_down = 1;
          notification();
      }
  }
var hide_all_drop_box = function(except)
  {
      //hide all sub-minimenu
      jQuery('.updates_pulldown_active').addClass('updates_pulldown');
      // reset inbox
      if (except != 1) {
          jQuery('#ynadvmenu_messages').removeClass('notifyactive');
          jQuery('#ynadvmenu_messageUpdates').hide();
          inbox_status = false;
          inbox_count_down = 1;
      }
      if (except != 3) {
            // reset notification
          jQuery('#ynadvmenu_updates').removeClass('notifyactive');
          jQuery('#ynadvmenu_notificationUpdates').hide();
          notification_status = false;
          notification_count_down = 1;
      }
      jQuery('#user-profile-info').addClass('collapsed');
      jQuery('#user-profile-submenu').removeClass('in').addClass('collapse').hide();
  }
  //header notification
   var notification = function() {
        var oData       = new Object();
        var url =  host+'/ynresponsive1/index/notification';
        jQuery.ajax({
                        url:  url,
                        data: oData,
                        dataType : 'html',
                        type: 'POST',
                        success: function (data) {
                        if(data){
                        jQuery('#ynadvmenu_updates_content').append(data);
                        jQuery('#ynadvmenu_NotificationsUpdates').removeClass('ynadvmenu_hasNotify');
                        }
                     },
                       error: function(e){  }
                    });
   }

  //header message icon
    var inbox = function() {
         var url    =  host+'/ynresponsive1/index/message';
         jQuery.ajax({
                        url:  url,
                        dataType : 'html',
                        type: 'POST',
                        success: function (data) {
                         if(data){
                            jQuery('#ynadvmenu_messages_content').append(data);
                            jQuery('#ynadvmenu_MessagesUpdates').removeClass('ynadvmenu_hasNotify');
                         }
                     },
                       error: function(e){  }
                 });
     };
   var isLoaded = [0, 0, 0]; // friend request, message, notifcation
   var notification_count_down = 1;
   var notification_status = false;
   jQuery("#ynadvmenu_updates").click(function () {
      hide_all_drop_box(3);
      if (notification_status) notification_count_down = 1;
      if (!notification_status) {
          // active
          jQuery(this).addClass('notifyactive');
          jQuery('#ynadvmenu_notificationUpdates').css('display', 'block');
      }
       else {
          jQuery(this).removeClass('notifyactive');
          jQuery('#ynadvmenu_notificationUpdates').css('display', 'none');
      }
      notification_status = notification_status ? false : true;
      if (isLoaded[2] == 0) {
          refreshBox(3);
          isLoaded[2] = 1;
      }
  });
  // Show Inbox Message
  var inbox_count_down = 1;
  var inbox_status = false; // false -> not shown, true -> shown
  jQuery("#ynadvmenu_messages").click(function () {
      hide_all_drop_box(1);
      if (inbox_status) inbox_count_down = 1;
      if (!inbox_status) {
          // show
          jQuery(this).addClass('notifyactive');
          jQuery('#ynadvmenu_messageUpdates').css('display', 'block');

      } else {
          // hide
          jQuery(this).removeClass('notifyactive');
          jQuery('#ynadvmenu_messageUpdates').css('display', 'none');

      }
      inbox_status = inbox_status ? false : true;
      if (isLoaded[1] == 0)
      {
          refreshBox(1);
          isLoaded[1] = 1;
      }
  });

//hide popup when outside click
 jQuery(document).mouseup(function (e)
{
    var container_notification = jQuery("#ynadvmenu_notificationUpdates");
    var container_message = jQuery("#ynadvmenu_messageUpdates");
    if (!container_notification.is(e.target) // if the target of the click isn't the container...
        && container_notification.has(e.target).length === 0) // ... nor a descendant of the container
    {
        container_notification.hide();
    }
    if (!container_message.is(e.target) // if the target of the click isn't the container...
        && container_message.has(e.target).length === 0) // ... nor a descendant of the container
    {
        container_message.hide();
    }
});
     jQuery('body').on('click', '.user-profile-info', function(event){
        if(jQuery( ".user-profile-info" ).hasClass("collapsed")){
            jQuery('#user-profile-submenu').css('display', 'block');
            jQuery( ".user-profile-info" ).removeClass("collapsed");
        }
        else
        {
            jQuery( ".user-profile-info" ).addClass("collapsed");
             jQuery('#user-profile-submenu').css('display', 'none');
        }
});

 var getNotificationsTotal = function()
  {
         var url    =  host+'/application/lite.php?module=ynresponsive1&name=total&viewer_id='+viewer_identity;
         jQuery.ajax({
                        url:  url,
                        dataType : 'json',
                        type: 'POST',
                        success: function (data) {
                        if(data != null) {
                           if (data.notification > 0) {
                             jQuery('#ynadvmenu_NotifyCount').text(data.notification);
                             jQuery('#ynadvmenu_NotifyIconCount').css('display','block');
                           }
                          }
                     },
                       error: function(e){   }
                 });
  }
 jQuery(document).ready(function(){
      getNotificationsTotal();
  });
 jQuery('#ynadvmenu_updates').click(function(){
        jQuery('#ynadvmenu_NotifyIconCount').css('display','none');
 });
