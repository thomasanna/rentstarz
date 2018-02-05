//var JQChat = jQuery.noConflict();
var onlineUsersArray   = [];
/* ==================================================================================================================================
      calling api when connect to socket, to create user's room
    ==================================================================================================================================== */
io.socket.on('connect', function (msg) {
    if(viewerId){
        io.socket.request({
            method: 'POST',
            url: '/socketSettings/socketConnection',
            data: {
                   userId : viewerId
                },
               /* headers  : {
                            },*/
                function (resData, jwres) {

                }
        });

        // Online users on refresh
        listAllUsers_request();
    }
});

/*io.socket.on('message', function (data) {

    console.log(data)
});*/

/* ==================================================================================================================================
      Get all connected socket rooms
    ==================================================================================================================================== */
io.socket.on('socketOnlineUsersList', function (data) {
    onlineUsersArray = [];
    onlineUsersArray = data.socketOnlineUsersList;
    localStorage.setItem('onlineUserList',onlineUsersArray)
    if(viewerId){
        listAllUsers_request();
    }
});
/* ==================================================================================================================================
      socket listening for saveChat Broadcast
    ==================================================================================================================================== */

io.socket.on('saveChat', function (data) {
    // var audio = new Audio('http://192.168.1.19/chatplus-web/js/first.mp3');
    var audio = new Audio('http://www.linksplace.com/wavsounds/ak47.wav');
    audio.play();

    var userName            = viewerName;
    var userId              = viewerId;
    var isWebsocket         = false;

    var final_date          = getChatTime(new Date());

    var chatAppend_params = {
                                message         : data.chatMsg,
                                chatId          : "",
                                final_date      : final_date,
                                fromId          : userId,
                                toId            : data.fromId,
                                toName          : data.fromName,
                                toProfilePic    : data.fromProfilePic,
                                focus_id        : 0,
                                page_type       : "new",
                                history_stat    : false,
                            }
    if (userId == data.fromId) {
        // append chat in page chat ##############
        pageChat_AppendSameIdFn(chatAppend_params);
    } else {
        var status = true;
        var popup_status    =   'small_popUp';
        //append chat in page chat ################
        pageChat_AppendDiffIdFn(chatAppend_params);

        //console.log(data)
        if(tiChat_DeviceType==1) {
            popup_status    =   'mobile';
            setNotification(data.fromId);
        }else {
            //alert(localStorage.getItem('onlineUserList').indexOf(data.fromId));
            if (localStorage.getItem('onlineUserList').indexOf(data.fromId) == -1 ) {
                setNotification(data.fromId);
            }
        }
        if(tiChat_jQuery(".chatpage-mainDiv").length == 0) {
            if(localStorage.getItem('chatPopup_open_datas')) {
                var chatPopup_open_datas = JSON.parse(localStorage.getItem('chatPopup_open_datas'));
                //console.log("In socket chatPopup_open_datas <<<<<<<<<<<<<<<<<<<<<<<<---------------------->>>>>>>>>>>>>>>>>>>");
                //console.log(chatPopup_open_datas);
                //console.log("In socket chatPopup_open_datas <<<<<<<<<<<<<<<<<<<<<<<<---------------------->>>>>>>>>>>>>>>>>>>");
                if (chatPopup_open_datas.length) {
                    tiChat_jQuery.each( chatPopup_open_datas, function( i, val ) {
                        console.log(i);
                        if(val.toId == data.fromId) {
                            isWebsocket= true;
                        }
                    });
                }
            }
            popUpChatClick(data.fromId,data.fromName,data.fromProfilePic,popup_status, isWebsocket);
            tiChat_jQuery("body .popup-box").css("display","block");


        }else {
            if(localStorage.getItem('chatPage_open_datas')) {
                //console.log(JSON.parse(localStorage.getItem('chatPage_open_datas').toId))
                var chatPage_data = JSON.parse(localStorage.getItem('chatPage_open_datas'));
                console.log(chatPage_data.toId)
                if(chatPage_data.toId!=data.fromId) {
                    //alert("bolddddd")
                    tiChat_jQuery('.listedUser_'+data.fromId+' .chat_chatboxDisplayDetails').css("font-weight","Bold");
                }
            }else {
                //alert("bolddddd")
                tiChat_jQuery('.listedUser_'+data.fromId+' .chat_chatboxDisplayDetails').css("font-weight","Bold");
            }
            tiChat_jQuery("body .popup-box").css("display","none");
            //alert("llllllllllllllllll")
            console.log(tiChat_jQuery(".listedUser_"+data.fromId+" .chat_displayLastMsg"))
            tiChat_jQuery(".listedUser_"+data.fromId+" .chat_displayLastMsg").html('');
            tiChat_jQuery(".listedUser_"+data.fromId+" .chat_displayLastMsg").text(data.chatMsg);
            if(tiChat_jQuery(".noUserList").length!=0) {
                listAllUsers_request();
            }
        }

       /* if(tiChat_DeviceType==1) {
            //status= 'mobile';
            //alert(data.fromId)
            setNotification(data.fromId);
        } else {
            //alert(localStorage.getItem('onlineUserList').indexOf(data.fromId));
            if (localStorage.getItem('onlineUserList').indexOf(data.fromId) == -1 ) {
                setNotification(data.fromId);
            }
        }


        if(tiChat_jQuery(".chatpage-mainDiv").length == 0) {
           tiChat_jQuery("body .popup-box").css("display","block");
        }else{
            tiChat_jQuery("body .popup-box").css("display","none");
        }*/
    }

});

/* ==================================================================================================================================
      socket listening for chatTyping Broadcast
    ==================================================================================================================================== */
io.socket.on('chatTyping', function (data) {
    var userName  = viewerName;
    var userId    = viewerId;

    if(userId == data.fromId) {
       // console.log("meeeeeeeeeeeee")
        //console.log(data.toId)
    }else {
        //$('#input'+data.toId).append(me+' is typing...');
        // $('#btn-input'+data.fromId).val('typing...');
        //$('.popup_box_'+data.fromId+' .typingDisplay').css('visibility','visible');
         //alert("From Id");
         //alert(data.fromId);
        tiChat_jQuery('#chatpage-windowContent_'+data.fromId+' .typingDisplay').css('visibility','visible');

        tiChat_jQuery('.popup_box_'+data.fromId+' .typingDisplay').css('visibility','visible');
        // var element = '<span class="typingDisplay"> '+data.fromName+' is typing...</span>';
        //$('.chatpage-userName').after(remove("div"));
        // $('.chatpage-userName').after(element);
        setTimeout(function(event){
           tiChat_jQuery('#chatpage-windowContent_'+data.fromId+' .typingDisplay').css('visibility','hidden');

           tiChat_jQuery('.popup_box_'+data.fromId+' .typingDisplay').css('visibility','hidden');
        }, 2000);
    }

});
