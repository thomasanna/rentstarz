var listUsersArray          = [];

/* ==================================================================================================================================
      Function to list all users who chat atleast once
    ==================================================================================================================================== */
function listAllUsers_request() {
    var userName  = viewerName;
    var userId    = viewerId;
    io.socket.request({
            method: 'post',
            url: '/user/listAllUsers',
            data: {
                limit: 15,
                userId: userId
            },
    }, function (resData, jwres) {
        listUsersArray      =   resData.result;

        var url       = document.URL;
            url       = url.split('/');
            url       = url.pop();

        if(resData.status==1){
            if(!resData.result.length){
                var listElem     ='<div class="noUserList">';
                        listElem    +='<div class="text-center dummyText_noUser">No users';
                        listElem    +='</div>';
                    listElem    +='</div>';
                tiChat_jQuery('.chatpage-usersListMainDiv ul.listedusers').remove();
                tiChat_jQuery('.chatpage-usersListMainDiv div.noUserList').remove();
                tiChat_jQuery('.chatpage-usersListMainDiv div.listUserSearch').remove();
                tiChat_jQuery('.chatpage-usersListMainDiv').append(listElem);
                tiChat_jQuery('.chatpage-usersListMainDiv .listUserSearch').hide();

            } else {
                if(tiChat_jQuery(".chatpage-mainDiv").length == 0) {
                   tiChat_jQuery("body .popup-box").css("visibility","visible");
                }else{
                    tiChat_jQuery("body .popup-box").css("visibility","hidden");
                }

                tiChat_jQuery('body .chat-list-popup').html('');
                tiChat_jQuery('body .chat-list-popup').remove();

                // Appending All active users
                var element =   '<div class="chat-list-popup" id="listAllUsers_'+resData.userId+'"><div class="row">';
                element     =   element + '<div class="panel panel-primary chat_window"><div class="panel-heading chat_list_head" id="accordion">';
                element     =   element + '<span class="online-offline-symbol"></span>';
                element     =   element + '<span class="glyphicon glyphicon-comment"></span> <span class="username">Online Users</span>';
                element     =   element + '<div class="btn-group pull-right">';
                element     =   element + '<a type="button" class="btn btn-default btn-xs" data-toggle="collapse" data-parent="#accordion" href="#allListCollapse">';
                element     =   element + '<span class="glyphicon glyphicon-chevron-down"></span></a>';
                element     =   element + '</a></div></div>';
                element     =   element + '<div class="panel-collapse collapse in chat_content_area"  id="allListCollapse"><div class="panel-body chatlist-panel-body" id="chat-list-window"';
                element     =   element + '</div></div></div></div></div>';

                var searchText   =  tiChat_jQuery("#listusersearchId").val();
                if (typeof(searchText) == 'undefined' || searchText == "") { // For all popup window undefined and searchinput empty null
                    tiChat_jQuery('.chatpage-usersListMainDiv ul.search_listedusers').remove();
                    tiChat_jQuery('.chatpage-usersListMainDiv ul.listedusers').remove();
                    tiChat_jQuery('.chatpage-usersListMainDiv').append('<ul class="listedusers"></ul>');

                    for (var i=0; i<resData.result.length; i++) {
                        var resDataUserId =  resData.result[i].id.toString();
                         var sDate  =   resData.result[i].lastDate;
                            sDate   =   sDate.split('T');
                        if (onlineUsersArray.indexOf(resDataUserId) != -1 ) {
                                // Online part
                                tiChat_jQuery('.chatpage-usersListMainDiv ul.listedusers').append('<li onclick="listedUserClick(\''+resData.result[i].id+'\',\''+resData.result[i].username+'\',\''+resData.result[i].profilePic+'\')" id="user_id^'+resData.result[i].id+'^'+resData.result[i].username+'^'+resData.result[i].profilePic+'" class="col-md-12 listedUser_'+resData.result[i].id+' chatpage-eachUserList col-md-12 yes-padding">'+
                                                                                '<a>'+
                                                                                    '<div class="col-md-3 col-sm-3 col-xs-3 chat_userscontentavatar">'+
                                                                                        '<img class="user_image-sm" src="'+resData.result[i].profilePic+'" onerror="imgError(this);"/>'+
                                                                                         '<span class="online-offline-symbol online-symbol chat_userscontentdot"></span>'+
                                                                                    '</div>'+
                                                                                    '<div class="col-md-9  col-sm-9 col-xs-9 chat_chatboxDisplayDetails" style="border-bottom: 1px solid #d2d2d2;">'+
                                                                                        '<div class="chat_userdisplayname">'+resData.result[i].username+'</div>'+
                                                                                        '<div class="chat_displayLastMsg">'+ellipsify(resData.result[i].last_msg)+'</div>'+
                                                                                        '<div class="chatpage_arrowright">'+sDate[0]+
                                                                                        '</div>'+
                                                                                    '</div>'+
                                                                                '</a>'+
                                                                            '</li>');
                                // To add "You" for last chat where currentUser and the sender are same
                                if(resData.result[i].fromId == userId) {
                                    tiChat_jQuery('.listedUser_'+resData.result[i].id+' .chat_displayLastMsg').html('');
                                    tiChat_jQuery('.listedUser_'+resData.result[i].id+' .chat_displayLastMsg').text('You : '+ ellipsify(resData.result[i].last_msg) );
                                }

                                //To add onlineclass
                                tiChat_jQuery('.popup_box_'+resData.result[i].id+' .common-call-symbol').removeClass("offlineCallClick");
                                tiChat_jQuery('.popup_box_'+resData.result[i].id+' .common-call-symbol').addClass("onlineCallClick");
                                tiChat_jQuery('.chatWindow_mobile_'+resData.result[i].id+' .common-call-symbol').removeClass("offlineCallClick");
                                tiChat_jQuery('.chatWindow_mobile_'+resData.result[i].id+' .common-call-symbol').addClass("onlineCallClick");

                                //To style unread messages
                                if((resData.result[i].readStatus==0) && (resData.result[i].id != resData.result[i].toId ))  {
                                    tiChat_jQuery('.listedusers .chat_chatboxDisplayDetails').css("font-weight","Bold");
                                } else {
                                    tiChat_jQuery('.listedusers .chat_chatboxDisplayDetails').css("font-weight","auto");
                                }
                        } else {
                                // Offline part
                                tiChat_jQuery('.chatpage-usersListMainDiv ul.listedusers').append('<li onclick="listedUserClick(\''+resData.result[i].id+'\',\''+resData.result[i].username+'\',\''+resData.result[i].profilePic+'\')" id="user_id^'+resData.result[i].id+'^'+resData.result[i].username+'^'+resData.result[i].profilePic+'" class="col-md-12 listedUser_'+resData.result[i].id+' chatpage-eachUserList col-md-12 yes-padding">'+
                                                                                '<a>'+
                                                                                    '<div class="col-md-3 col-sm-3 col-xs-3 chat_userscontentavatar">'+
                                                                                        '<img class="user_image-sm" src="'+resData.result[i].profilePic+'" onerror="imgError(this);"/>'+
                                                                                        '<span class="online-offline-symbol offline-symbol chat_userscontentdot"></span>'+
                                                                                    '</div>'+
                                                                                    '<div class="col-md-9 col-sm-9 col-xs-9 chat_chatboxDisplayDetails" style="border-bottom: 1px solid #d2d2d2;">'+
                                                                                        '<div class="chat_userdisplayname">'+resData.result[i].username+'</div>'+
                                                                                        '<div class="chat_displayLastMsg">'+ellipsify(resData.result[i].last_msg)+'</div>'+
                                                                                        '<div class="chatpage_arrowright">'+sDate[0]+
                                                                                        '</div>'+
                                                                                    '</div>'+
                                                                                '</a>'+
                                                                            '</li>');
                                // To add "You" for last chat where currentUser and the sender are same
                                if( resData.result[i].fromId == userId) {
                                    tiChat_jQuery('.listedUser_'+resData.result[i].id+' .chat_displayLastMsg').html('');
                                    tiChat_jQuery('.listedUser_'+resData.result[i].id+' .chat_displayLastMsg').text('You : '+ ellipsify(resData.result[i].last_msg) );
                                }

                                //To add offlineclass
                                tiChat_jQuery('.popup_box_'+resData.result[i].id+' .common-call-symbol').removeClass("onlineCallClick");
                                tiChat_jQuery('.popup_box_'+resData.result[i].id+' .common-call-symbol').addClass("offlineCallClick");
                                tiChat_jQuery('.chatWindow_mobile_'+resData.result[i].id+' .common-call-symbol').removeClass("onlineCallClick");
                                tiChat_jQuery('.chatWindow_mobile_'+resData.result[i].id+' .common-call-symbol').addClass("offlineCallClick");

                                //To style unread messages
                                if((resData.result[i].readStatus==0) && (resData.result[i].id != resData.result[i].toId ))  {
                                        tiChat_jQuery('.listedusers .chat_chatboxDisplayDetails').css("font-weight","Bold");
                                }else {
                                        tiChat_jQuery('.listedusers .chat_chatboxDisplayDetails').css("font-weight","auto");
                                }
                        }
                    }
                    // Online / Offline Click
                    if(localStorage.getItem('chatPage_open_datas')) {
                        var chatPage_open_datas     =   JSON.parse(localStorage.getItem('chatPage_open_datas') );
                        if (localStorage.getItem('onlineUserList').indexOf(chatPage_open_datas.toId) != -1 ) {
                            tiChat_jQuery('.chatpage-chatWindowMain .common-call-symbol').removeClass("offlineCallClick");
                            tiChat_jQuery('.chatpage-chatWindowMain .common-call-symbol').addClass("onlineCallClick");
                        } else {
                            tiChat_jQuery('.chatpage-chatWindowMain .common-call-symbol').removeClass("onlineCallClick");
                            tiChat_jQuery('.chatpage-chatWindowMain .common-call-symbol').addClass("offlineCallClick");
                        }
                    }
                    //tiChat_jQuery('chatpage-id .chatpage-usersListMainDiv').perfectScrollbar();
                }
            }
        } else if(resData.status==3) {
            logOut(userId, userToken);
        }
    });
}


/* ==================================================================================================================================
      Function to save chat
    ==================================================================================================================================== */

function saveChat_request(data){
    io.socket.request({
              method: 'POST',
              url: '/chat/saveChat',
              data: data,
                   //contentType     : false,
                    /*headers  : {
                                },*/
                    function (resData, jwres) {

                    }
            });
}


/* ==================================================================================================================================
     Function to get typing notification
    ==================================================================================================================================== */
function chatTyping_request(data){
    io.socket.request({
        method: 'POST',
        url: '/chat/socketChatTyping',
        data: data,
        contentType   : false,
        /*headers  : {

                    },*/
        function (resData, jwres) {
        }
    });
}
