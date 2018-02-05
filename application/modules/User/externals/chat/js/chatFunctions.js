// var JQChat = jQuery.noConflict();
//this variable represents the total number of popups can be displayed according to the viewport width
var total_popups = 0;
//arrays of popups ids
var popups = [];
/* ==================================================================================================================================
       Function to short the length of a string
==================================================================================================================================== */

    function ellipsify (str) {
        if (str.length > 9) {
            return (str.substring(0, 9) + "...");
        } else {
            return str;
        }
    }

/* ==================================================================================================================================
       Function to remove json array from another json array
==================================================================================================================================== */

    function arrayRemove(property, num, arr) {
        for (var i in arr) {
            if (arr[i][property] == num) {
                arr.splice(i, 1);
            }
        }
    }

/* ==================================================================================================================================
       Function to remove a array element.
==================================================================================================================================== */

    Array.remove = function(array, from, to) {
        var rest        =   array.slice((to || from) + 1 || array.length);
        array.length    =   from < 0 ? array.length + from : from;
        return array.push.apply(array, rest);
    };

/* ==================================================================================================================================
     Function to remove duplicate values from json Array
==================================================================================================================================== */
function removeDuplicate(arr, prop) {
        var new_arr = [];
        var lookup = {};
        for (var i in arr) {
            lookup[arr[i][prop]] = arr[i];
        }
        for (i in lookup) {
            new_arr.push(lookup[i]);
        }
        //console.log(new_arr);
        return new_arr;
}

/* ==================================================================================================================================
       Function to close a popup
==================================================================================================================================== */

    function close_popup(appendParams) {
        //alert("close")
        //alert(localStorage.getItem('chatPopup_open_datas'));
        //tiChat_jQuery('#chatpage-windowContent_'+appendParams.toId).remove();
        for(var iii = 0; iii < popups.length; iii++) {
            if(appendParams.toId == popups[iii]) {
                Array.remove(popups, iii);
                tiChat_jQuery('#'+appendParams.toId).remove();

                var chatPopup_open_datasArray   = JSON.parse(localStorage.getItem('chatPopup_open_datas'))
                var pushedArray                 = [];

                if (chatPopup_open_datasArray.length) {
                    tiChat_jQuery.each( chatPopup_open_datasArray, function( i, val ) {
                        console.log("val %%%%%%%%%%%%%%%%%%%")
                        console.log(val)
                        if (val.toId == appendParams.toId) {
                            arrayRemove('toId', val.id, chatPopup_open_datasArray);
                        } else {
                            pushedArray.push(val);
                        }
                    });
                }

                // remove duplicate value from a json array
                pushedArray  = removeDuplicate(pushedArray, 'toId')
                localStorage.setItem('chatPopup_open_datas', JSON.stringify(pushedArray) );

                //calculate_popups(appendParams);
                return;
            }
        }
    }

/* ==================================================================================================================================
       Function save chat
==================================================================================================================================== */

    function sendchat_popup(toId) {
        var userProfilePic      =   viewerProfilePic;
        var sendChat_params     = {
                                    toId             : toId,
                                    userProfilePic   : userProfilePic,
                                    chat_behaviour   : "popupchat",
                                    chat_function    : "getChat"
                                }
        sendChat(sendChat_params);
    }

/* ==================================================================================================================================
       Displays the popups. Displays based on the maximum number of popups that can be displayed on the current viewport width
==================================================================================================================================== */

    function display_popups(appendParams) {
        if(tiChat_jQuery(".largeChatWindow").length == 0) {
             var right   = 0;
         }
        var iii     = 0;
        for (iii; iii < total_popups; iii++) {
            if (popups[iii] != undefined) {
                var element             =   document.getElementById(popups[iii]);
                element.style.right     =   right + "px";
                right                   =   right + 300;
                element.style.display   =   "block";
            }
        }

        for(var jjj = iii; jjj < popups.length; jjj++) {
            var element = document.getElementById(popups[jjj]);
            element.style.display = "none";
        }
        // alert("display_popups ====>>>>>>>>>>>>>>>>>>>>")
        // Function to get All chat between the room
        getChat(appendParams);
    }

/* ==================================================================================================================================
       Creates markup for a new popup. Adds the id to popups array
==================================================================================================================================== */

    function register_popup_single(appendParams) {

       for (var iii = 0; iii < popups.length; iii++) {
            //already registered. Bring it to front.
            if (appendParams.toId == popups[iii]) {
                Array.remove(popups, iii);
                popups.unshift(appendParams.toId);
                //calculate_popups(appendParams);
                return;
            }
        }

        var userId          =   appendParams.toId;
        var user_id         =   'user_id_'+appendParams.toId;
        var chatId          =   'chat_input_'+appendParams.toId;
        var sendId          =   'chat_btn_'+appendParams.toId;
        var displayId       =   'display_'+appendParams.toId;
        var inputId         =   'input_'+appendParams.toId;
        var collapseId      =   'collapse_chatBox_'+appendParams.toId;
        //var scroll_id     =   'scroll';
        var scroll_id       =   'scroll_'+appendParams.toId;
        // var popupBoxId      =   'popup_box_max_'+appendParams.toId;
        var popupBoxId      =   'popup_box_'+appendParams.toId;
        // var largePopupBoxId =   'popup_box_large_'+appendParams.toId;
        var load_more       =   "load_more_"+appendParams.toId;
        var page_type       =   'old';
        var toNameWeb       =   appendParams.toName;
        var toName          =   ellipsify(appendParams.toName);
        var popUpMinId      =   'popupMinimize'+appendParams.toId;
        var popupCallId     =   'popup_call_'+appendParams.toId;
        var audio           =   'audio';
        var video           =   'video';
        var popup_status    =   'small_popUp';




        var element = '<div class="largeChat-mainDiv '+popupBoxId+' largeChatWindow" id="'+appendParams.toId+'">';
                element +='<!---------------------- User header ------------------------------>';
                element +='<div class="row chatpage-currentUserDiv">';
                    element +='<div class="col-xs-12 col-sm-12 col-md-12 no-padding" id="popupDrag">';
                       element +='<div class="chatpage-userNameMainDiv col-xs-8 col-sm-8 col-md-8" style="top:0px;">';
                            element +='<div class="chat_chatboxDisplayDetails">';
                                  element +='<div class="ccplugins " id="cometchat_videochaticon" title="Start an audio/video call" name="ccavchat" to="117" chatroommode="0"></div>'
                                  element +='<img class="user_image-sm" src="'+appendParams.toProfilePic+'" onerror="imgError(this);"/>';
                                  element +='<span class="chat_userdisplayname" style="color:black;">'+toName+'<span class="chat_subtitle_arrow"></span>';
                                  // element +='<span style="visibility: hidden" id="user_id">'+toId+'</span>';
                                  element +='<span class="typingDisplay"> is typing...</span>';
                            element +='</div>';
                        element +='</div>';


                        element += '<div class="btn-group  popupPos col-xs-4 col-sm-4 col-md-4 popupMin" >';
                            element +='<span title="close" class="hand-symbol pull-right glyphicon glyphicon-remove popup-windowCloseBtn" style="top: 5px;padding-left: 8px;"></span>';
                            element += '<a class="popup-windowMinBtn pull-right hand-symbol" id="'+popUpMinId+'">';
                            element += '<i title="Minimize" class="fa fa-window-minimize" aria-hidden="true" style="color:#f58410;"></i></a>';
                            element =   element + '<span data-toggle="modal" onclick="callerInitiateCall(\''+appendParams.toId+'\', \''+appendParams.toName+'\',\''+video+'\',\''+appendParams.toProfilePic+'\');" title="Video call" class="common-call-symbol video-call-symbol hand-symbol" id="'+popupCallId+'">';
                            element =   element + '<img src="../application/modules/User/externals/images/video-camera.svg" style="width: 19px;height: 19px;margin-top: -4px;"></span>';
                            element =   element + '<span data-toggle="modal" onclick="callerInitiateCall(\''+appendParams.toId+'\', \''+appendParams.toName+'\',\''+audio+'\',\''+appendParams.toProfilePic+'\');" title="Audio call" class="common-call-symbol audio-call-symbol hand-symbol" id="'+popupCallId+'">';
                            element =   element + '<i class="fa fa-phone" aria-hidden="true"></i></span>';
                        element +='</div>';
                    element +='</div>';
                element +='</div>';

                element +='<!--=========================== Users List + Chat display ===========================-->';
                element +='<div class="row">';
                    element +='<div class="chatpage-chatWindowMain">';
                        element +='<div class="chatpage-windowContent">';
                            element +='<div class="panel mainPanel">';
                                 element +='<div class="panel-collapse collapse in">';
                                    element +='<div class="panel-body" id="chat_scroll_id">';
                                        element +='<span id="load_more_id_'+appendParams.toId+'"></span>';
                                        element +='<ul class="chat chatLWindow">';
                                        element +='</ul>';
                                    element +='</div>';
                                    element +='<div class="panel-footer">';
                                        element +='<div class="input-group">';
                                            element +='<input type="text" id="'+chatId+'" onkeydown="javascript:getkeyInput(event,\''+ appendParams.toId +'\', \''+appendParams.toName+'\')" class="form-control input-sm input_typing" placeholder="Type your message" />';
                                            element +='<div class="input-group-btn">';
                                                element +='<a id="sendPageChatId" class="btn btn-success btn-sm input_typing" onclick="sendchat_popup(\''+appendParams.toId+'\')" style="background:#ddd;">';
                                                    element += '<span class="fa fa-paper-plane-o"></span>';
                                                element += '</a>';
                                            element +='</div>';
                                        element +='</div>';
                                    element +='</div>';
                                 element +='</div>';
                            element +='</div>';
                        element +='</div>';
                    element +='</div>';
                element +='</div>';

        element +='</div>';


        tiChat_jQuery(".footer").append(element);
        tiChat_jQuery('.wrapper').css({'opacity' : '0.3' });

        popups.unshift(appendParams.toId);

        if (localStorage.getItem('onlineUserList').indexOf(appendParams.toId) == -1 ) {
             //alert("User is offline");
             // tiChat_jQuery('.call').css({ 'pointer-events' : 'none' });
             // '.common-call-symbol'
        }

        if(tiChat_jQuery(".chatpage-mainDiv").length == 0) {
               tiChat_jQuery("body .popup-box").css("display","block");
        }else{
            tiChat_jQuery("body .popup-box").css("display","none");
        }

        // Enable draggable and align popup to center
        tiChat_jQuery('.largeChatWindow').draggable({cursor: "move", handle: '#popupDrag'});

        tiChat_jQuery(document).on("click","#"+popUpMinId,function(e) {
            console.log("after Minimize Click")
            console.log(appendParams.toId)
            console.log(appendParams)
            var status = true;
            close_popup(appendParams);
            popUpChatClick(appendParams.toId,toName,appendParams.toProfilePic,popup_status);
            e.stopImmediatePropagation();
        });

        tiChat_jQuery(document).on("click",".largeChatWindow #popup_call_"+appendParams.toId,function(e) {

            tiChat_jQuery('.largeChatWindow').remove();
            tiChat_jQuery('.wrapper').css({'opacity' : '' });
            close_popup(appendParams);
            popUpChatClick(appendParams.toId,toNameWeb,appendParams.toProfilePic,popup_status);
        });

        getChat(appendParams);
    }


/* ==================================================================================================================================
      register function for display multiple popups
==================================================================================================================================== */

    function register_popup(appendParams) {
        //alert("register")
        for (var iii = 0; iii < popups.length; iii++) {
            //already registered. Bring it to front.
            if (appendParams.toId == popups[iii]) {
                Array.remove(popups, iii);
                popups.unshift(appendParams.toId);
                calculate_popups(appendParams);
                return;
            }
        }

        var user_id         =   'user_id_'+appendParams.toId;
        var chatId          =   'chat_input_'+appendParams.toId;
        var sendId          =   'chat_btn_'+appendParams.toId;
        var displayId       =   'display_'+appendParams.toId;
        var inputId         =   'input_'+appendParams.toId;
        var collapseId      =   'collapse_chatBox_'+appendParams.toId;
        //var scroll_id     =   'scroll';
        var scroll_id       =   'scroll_'+appendParams.toId;
        var popupBoxId      =   'popup_box_'+appendParams.toId;
        var load_more       =   "load_more_"+appendParams.toId;
        var page_type       =   'old';
        var toNameWeb       =   appendParams.toName;
        var toName          =   ellipsify(appendParams.toName);

        var popupCloseId    =   'popup_close_'+appendParams.toId;
        var popupMaxId      =   'popup_max_'+appendParams.toId;
        var popupCallId     =   'popup_call_'+appendParams.toId;
        var audio           =   'audio';
        var video           =   'video';
        var onlineStatus;
        var popup_status    =   'large_popUp';

        var element =   '<div class="popup-box '+popupBoxId+'" id="'+appendParams.toId+'">';
            element =   element + '<div class="panel mainPanel panel-primary chat_window">';
            element =   element + '<div class="panel-heading chat_head" id="accordion">';
            element =   element + '<a class="toggleClr" data-toggle="collapse"  href="#'+collapseId+'">';
            // element =   element + '<span class="online-offline-symbol"></span>';
            element =   element + '<span><img class="user_image-sm" src="'+appendParams.toProfilePic+'" onerror="imgError(this);" title=""> </span>';
            element =   element + '<span class="username">'+toName+'</span>';
            element =   element + '<span class="typingDisplay"> is typing...</span></a>';
            element =   element + '<div class="btn-group pull-right popupPos">';
            element =   element + '<span data-toggle="modal" onclick="callerInitiateCall(\''+appendParams.toId+'\', \''+toNameWeb+'\',\''+audio+'\',\''+appendParams.toProfilePic+'\');" title="Audio call" class="common-call-symbol audio-call-symbol hand-symbol" id="'+popupCallId+'">';
            element =   element + '<i class="fa fa-phone" aria-hidden="true"></i></span>';
            element =   element + '<span data-toggle="modal" onclick="callerInitiateCall(\''+appendParams.toId+'\', \''+toNameWeb+'\',\''+video+'\',\''+appendParams.toProfilePic+'\');" title="Video call" class="common-call-symbol video-call-symbol hand-symbol" id="'+popupCallId+'">';
            element =   element + '<img src="../application/modules/User/externals/images/video-camera.svg" style="width: 19px;height: 20px;margin-top: -4px;"></span>';
            element =   element + '<a class="popup-windowMinBtn" data-toggle="collapse" data-parent="#accordion" href="#'+collapseId+'">';
            element =   element + '<span title="Minimize" class="glyphicon glyphicon-chevron-down Minimize"></span></a>';
            element =   element + '<span title="Maximize" class="hand-symbol" id="'+popupMaxId+'"><i class="fa fa-window-maximize" aria-hidden="true"></i></span>';
            // element =   element + '<a type="button" class="btn btn-default btn-xs" data-parent="#accordion" href="javascript:close_popup(\''+ appendParams.toId +'\', \''+appendParams.toName+'\');">';
            element =   element + '<span title="Close" class="popupCloseId glyphicon glyphicon-remove" id="'+popupCloseId+'" data-parent="#accordion">';
            element =   element + '</span></div></div>';
            element =   element + '<div class="panel-collapse collapse in" id="'+collapseId+'"><div class="panel-body" id="'+scroll_id+'">';
            element =   element +='<span id="load_more_id_'+appendParams.toId+'"></span>';
            // element =   element + '<span id="'+load_more+'"  style="visibility:hidden;"><a href="javascript:getChat(\''+ id +'\',\''+ name +'\',\''+ scroll_chat_id +'\',\''+ page_type +'\')">load more</a></span>';
            // element =   element + '<span id="'+load_more+'"  style="visibility:hidden;"><a href="javascript:getChat(\''+ id +'\',\''+ name +'\',\''+ scroll_chat_id +'\',\''+ page_type +'\')">load more</a></span>';
            element =   element + '<ul class="chat">';
            element =   element + '</ul></div>';
           // element =   element + '<div class="loading-info" style="display:none;"><a>LOAD MORE</a></div></div>';
            element =   element + '<div class="panel-footer">';
            element =   element + '<div class="input-group" id="'+inputId+'"><input id="'+chatId+'"  onkeydown="javascript:getkeyInput(event,\''+ appendParams.toId +'\', \''+appendParams.toName+'\')" type="text" class="form-control input-sm commonchat" placeholder="Type your message" />';
            element =   element + '<div class="input-group-btn"><a style ="text-transform:none;background:#ddd;color: #fff;" class="btn btn-sm" id="'+sendId+'" onclick="sendchat_popup(\''+ appendParams.toId +'\')">';
            element =   element + '<span class="fa fa-paper-plane-o"></span>';
            element =   element + '</a></div>';
            element =   element + ' </div></div></div></div></div>';

        //document.getElementsByTagName("#global_page_user-index-landlords")[0].innerHTML = document.getElementsByTagName("#global_page_user-index-landlords")[0].innerHTML + element;
        tiChat_jQuery("body").append(element);
        popups.unshift(appendParams.toId);

        // tiChat_jQuery('.call').css({ 'pointer-events' : 'all' });
        if (localStorage.getItem('onlineUserList').indexOf(appendParams.toId) == -1 ) {
            tiChat_jQuery('.popup_box_'+appendParams.toId+' .common-call-symbol').removeClass("onlineCallClick");
            tiChat_jQuery('.popup_box_'+appendParams.toId+' .common-call-symbol').addClass("offlineCallClick");
        } else {
            tiChat_jQuery('.popup_box_'+appendParams.toId+' .common-call-symbol').removeClass("offlineCallClick");
            tiChat_jQuery('.popup_box_'+appendParams.toId+' .common-call-symbol').addClass("onlineCallClick");
        }

        tiChat_jQuery(document).on("click","#popup_max_"+appendParams.toId,function(e) {
            // alert("clicked on maximise")
            var status = 'false';
            close_popup(appendParams);
            //var isWebsocket= false;
            popUpChatClick(appendParams.toId,toName,appendParams.toProfilePic,popup_status);
            e.stopImmediatePropagation();

        });

        if(tiChat_jQuery(".chatpage-mainDiv").length == 0) {
               tiChat_jQuery("body .popup-box").css("display","block");
        } else {
               tiChat_jQuery("body .popup-box").css("display","none");
        }

        calculate_popups(appendParams);
    }

/* ==================================================================================================================================
       Calculate the total number of popups suitable and then populate the toatal_popups variable.
==================================================================================================================================== */

    function calculate_popups(appendParams) {
        //console.log("call again==>")
        var width = window.innerWidth;
        if (width < 540) {
            total_popups    = 0;
        } else {
            width           = width - 200;
            total_popups    = parseInt(width/320);//320 is width of a single popup box
            //console.log(total_popups)
        }
        display_popups(appendParams);
    }


/* ==================================================================================================================================
       this is used to get chat history
    ==================================================================================================================================== */

    function getChat(appendParams) {
        // alert("getchat")

        var userName        =   viewerName;
        var userId          =   viewerId;

        var toId            =   appendParams.toId;
        var toName          =   appendParams.toName;
        var focus_id        =   appendParams.focus_id;
        var page_type       =   appendParams.page_type;
        var is_LoadMore     =   localStorage.getItem('is_LoadMore');
        tiChat_jQuery.ajax({
            method    : 'POST',
            url       : server_base_url+"chat/getChat",
            data      : {
                            userId      :   userId,
                            focusChatId :   focus_id,
                            pageType    :   page_type,
                            toId        :   toId
                        },
            headers   : {
                        },
        }).done(function(data) {

            var scroll_limit;
            res_arr                 =   data.result;
            var lowest_chat_id      =   0;
            var last_iteration_i    =   0;
            if (res_arr.length) {
                var minusArrayLength    =   0;
                tiChat_jQuery.each( res_arr, function( i, val ) {
                    var createdAt   = new Date(val.createdAt);
                    var final_date  = getChatTime(createdAt);
                    localStorage.setItem('history_status', true);
                    scroll_id       =   'chat_id_'+val.id;

                    var chatAppend_params = {
                                            message             : val.message,
                                            chatId              : scroll_id,
                                            final_date          : final_date,
                                            fromId              : userId,
                                            toId                : toId,
                                            toProfilePic        : val.from_profilepic,
                                            history_stat        : localStorage.getItem('history_status'),
                                            append_chat_each_id : i+1,
                                            chat_behaviour      : "popup",
                                            chat_function       : "getChat"
                                        }

                    if (userId == val.fromId) {
                        // append chat in page chat ###########
                        pageChat_AppendSameIdFn(chatAppend_params);
                        setReadStatus(appendParams.toId);
                    } else {
                        // append chat in page chat ############
                        pageChat_AppendDiffIdFn(chatAppend_params);
                        setReadStatus(appendParams.toId);
                    }

                    minusArrayLength = parseInt(res_arr.length) - 1;
                    if(i == minusArrayLength) {
                        lowest_chat_id      =   val.id;
                        last_iteration_i    =   i;
                        scroll_limit        =   val.id;
                        localStorage.setItem('lowest_chat_id',lowest_chat_id);
                        localStorage.setItem('last_iteration_i', (i + 1));
                    }
                });

                // scrollChat(toId,toName,scroll_limit,res_arr,is_LoadMore);
                var decideAppend_params = {
                    toId            : toId,
                    toName          : toName,
                    scroll_limit    : scroll_limit,
                    res_arr         : res_arr,
                    is_LoadMore     : is_LoadMore,
                    lowest_chat_id  : localStorage.getItem('lowest_chat_id'),
                    array_length    : localStorage.getItem('last_iteration_i'),
                    chat_behaviour  : "popup"
                }

                decidePreviousNomore(decideAppend_params);

                // message scroll down in popup window
                if (is_LoadMore == 0) {
                    tiChat_jQuery(".popup_box_"+toId+ " .panel-body").animate({ scrollTop: tiChat_jQuery(".popup_box_"+toId+" .panel-body ul").height() }, "fast");
                } else {
                    tiChat_jQuery('.popup_box_'+toId+' .panel-body').animate({ scrollTop: tiChat_jQuery(".popup_box_"+toId+" .panel-body li#chat_id_"+focus_id).offset().top }, "slow");
                    // $('.popup_box_'+toId+' .panel-body').animate({ scrollTop: $(".popup_box_"+toId+" .panel-body li#chat_id_"+localStorage.getItem('lowest_chat_id')).offset().top }, "slow");
                    // $('.popup_box_16 .panel-body').animate({ scrollTop: $(".popup_box_16 .panel-body #chat_id_187").offset().top }, "slow");
                }
            } else {
                tiChat_jQuery('.popup_box_'+toId+' #load_more_id_'+toId+' .load_more').remove();
                tiChat_jQuery('.popup_box_'+toId+' #load_more_id_'+toId+' .no_more_chat').remove();
                tiChat_jQuery('.popup_box_'+toId+' #load_more_id_'+toId+' .no_chat_found').remove();
                if (res_arr.length == 0) {
                    tiChat_jQuery('.popup_box_'+toId+' #load_more_id_'+toId).append('<span class="no_chat_found text-center">no messages</span>');
                } else {
                    tiChat_jQuery('.popup_box_'+toId+' #load_more_id_'+toId).append('<span class="no_more_chat text-center">no more messages</span>');
                }
                tiChat_jQuery('.popup_box_'+toId+' #load_more_id_'+toId+' .no_more_chat').css({ "color" : "#AAC6D5" , "text-decoration" : "none", "display" : "block"});
                tiChat_jQuery('.popup_box_'+toId+' #load_more_id_'+toId+' .no_chat_found').css({ "color" : "#AAC6D5" , "text-decoration" : "none", "display" : "block"});
            }

            // tiChat_jQuery('.popup-box .panel-body').perfectScrollbar();
        });

        // Load more messages
        tiChat_jQuery(document).on("click",".popup_box_"+toId+" #load_more_id_"+toId+" .load_more",function(e) {
            var appendParams = {
                                    toId         :  toId,
                                    toName       :  toName,
                                    focus_id     :  localStorage.getItem('lowest_chat_id'),
                                    page_type    :  page_type,
                                    is_LoadMore  :  is_LoadMore,
                                }
            getChat(appendParams);
            e.stopImmediatePropagation();
        });

        // is Typing using socket
        /*$('#chat_input_'+toId).keypress(function(e) {
            console.log("keypresseddddddddd")
            var popUpId =   ".popup_box_"+toId;
            console.log(popUpId)
            var toUserId    =   toId;
            var message     =   $('#chat_input_'+toId).val();

            var request     = {
                                message  :  message,
                                toId     :  toId,
                                toName   :  toName,
                            };

            // Function to get typing notification
            chatTyping_request(request);

            // call save chat api on enter key press
            if (e.keyCode == 13) {
                var sendChat_params = {
                                    toId           : toId,
                                    chat_behaviour : "popupchat"
                                    }
                sendChat(sendChat_params);
            }
        });*/

        // popup chat window close button
       //tiChat_jQuery(document).on("click",".popup_box_"+toId+" .popup-windowCloseBtn",function() {
        tiChat_jQuery(document).on("click",".popup-windowCloseBtn",function() {
            tiChat_jQuery('.tooltipster-base').hide();
            var appendParams = {
                                toId         :  toId,
                                toName       :  toName,
                                focus_id     :  localStorage.getItem('lowest_chat_id'),
                                page_type    :  page_type,
                                is_LoadMore  :  is_LoadMore,
                            }
            tiChat_jQuery('.largeChatWindow').remove();
            tiChat_jQuery('.wrapper').css({'opacity' : '' });
            close_popup(appendParams);
        });

        tiChat_jQuery(document).on("click","#popup_close_"+toId,function() {
           tiChat_jQuery('.tooltipster-base').hide();
            var appendParams = {
                                toId         :  toId,
                                toName       :  toName,
                                focus_id     :  localStorage.getItem('lowest_chat_id'),
                                page_type    :  page_type,
                                is_LoadMore  :  is_LoadMore,
                            }
            //tiChat_jQuery('.largeChatWindow').remove();
            //tiChat_jQuery('.wrapper').css({'opacity' : '' });
            close_popup(appendParams);
        });
    }

/* ==================================================================================================================================
     function to get input keypress
  ==================================================================================================================================== */
function getkeyInput(e,toId,toName,toProfilePic){

        var popUpId         =   ".popup_box_"+toId;
        var userId          = viewerId;
        var userProfilePic  =   viewerProfilePic;
        var toUserId        =   toId;
        var toProfilePic    =   toProfilePic;
        var message         =   tiChat_jQuery('#chat_input_'+toId).val();

        var request         = {
                                message  :  message,
                                userId   :  userId,
                                toId     :  toId,
                                toName   :  toName,
                            };

        // Function to get typing notification
        chatTyping_request(request);

        // call save chat api on enter key press
        if (e.keyCode == 13) {
            var sendChat_params = {
                                toId             : toId,
                                userProfilePic   : userProfilePic,
                                chat_behaviour   : "popupchat"
                                }
            sendChat(sendChat_params);
        }

}



/* ==================================================================================================================================
      Append and remove Load more messages and No more messages
  ==================================================================================================================================== */
    function decidePreviousNomore(paramArray) {
        //alert(paramArray.array_length)
        var is_LoadMore         =   localStorage.getItem('is_LoadMore');
        var array_length        =   paramArray.array_length;
        var itemLengthCalc      =   parseInt( (array_length) % 10 );

        //if (paramsArr.chat_behaviour == "popup") {
            // alert("Aliya  timeout   ++++ popup");
            if (itemLengthCalc == 0) {
               //alert("Aliya  timeout   ++++ popup   ==== 0");
                tiChat_jQuery('.popup_box_'+paramArray.toId+' #load_more_id_'+paramArray.toId+' .no_more_chat').remove();
                tiChat_jQuery('.popup_box_'+paramArray.toId+' #load_more_id_'+paramArray.toId+' .load_more').remove();
                tiChat_jQuery('.popup_box_'+paramArray.toId+' #load_more_id_'+paramArray.toId).append('<span class="load_more hand-symbol text-center">load earlier messages</span>');
                tiChat_jQuery('.popup_box_'+paramArray.toId+' #load_more_id_'+paramArray.toId+' .load_more').css({ "color" : "#AAC6D5" , "text-decoration" : "none", "display" : "block"});

            } else  {
               // alert("Aliya  timeout   ++++ popup   ==== else");
                tiChat_jQuery('.popup_box_'+paramArray.toId+' #load_more_id_'+paramArray.toId+' .load_more').remove();
                tiChat_jQuery('.popup_box_'+paramArray.toId+' #load_more_id_'+paramArray.toId+' .no_more_chat').remove();
                tiChat_jQuery('.popup_box_'+paramArray.toId+' #load_more_id_'+paramArray.toId).append('<span class="no_more_chat text-center">no more messages</span>');
                tiChat_jQuery('.popup_box_'+paramArray.toId+' #load_more_id_'+paramArray.toId+' .no_more_chat').css({ "color" : "#AAC6D5" , "text-decoration" : "none", "display" : "block"});
            }
        //} else {
            if (itemLengthCalc == 0) {
                tiChat_jQuery('.chatpage-windowContent #load_more_id_'+paramArray.toId+' .no_more_chat').remove();
                tiChat_jQuery('.chatpage-windowContent #load_more_id_'+paramArray.toId+' .load_more').remove();
                tiChat_jQuery('.chatpage-windowContent #load_more_id_'+paramArray.toId).append('<span class="load_more hand-symbol text-center">load earlier messages</span>');
                tiChat_jQuery('.chatpage-windowContent #load_more_id_'+paramArray.toId+' .load_more').css({ "color" : "#AAC6D5" , "text-decoration" : "none", "display" : "block"});
            } else {
                tiChat_jQuery('.chatpage-windowContent #load_more_id_'+paramArray.toId+' .load_more').remove();
                tiChat_jQuery('.chatpage-windowContent #load_more_id_'+paramArray.toId+' .no_more_chat').remove();
                tiChat_jQuery('.chatpage-windowContent #load_more_id_'+paramArray.toId).append('<span class="no_more_chat text-center">no more messages</span>');
                tiChat_jQuery('.chatpage-windowContent #load_more_id_'+paramArray.toId+' .no_more_chat').css({ "color" : "#AAC6D5" , "text-decoration" : "none", "display" : "block"});
            }

             if (itemLengthCalc == 0) {
                 //alert("Aliya  timeout   ++++ popup   ==== 0");
                tiChat_jQuery('#chat_mob_main #load_more_id_'+paramArray.toId+' .no_more_chat').remove();
                tiChat_jQuery('#chat_mob_main #load_more_id_'+paramArray.toId+' .load_more').remove();
                tiChat_jQuery('#chat_mob_main #load_more_id_'+paramArray.toId).append('<span class="load_more hand-symbol text-center">load earlier messages</span>');
                tiChat_jQuery('#chat_mob_main #load_more_id_'+paramArray.toId+' .load_more').css({ "color" : "#ccc" , "text-decoration" : "none", "display" : "block"});
            } else {
                //alert("Aliya  timeout   ++++ popup   =====else ");
                tiChat_jQuery('#chat_mob_main #load_more_id_'+paramArray.toId+' .load_more').remove();
                tiChat_jQuery('#chat_mob_main #load_more_id_'+paramArray.toId+' .no_more_chat').remove();
                tiChat_jQuery('#chat_mob_main #load_more_id_'+paramArray.toId).append('<span class="no_more_chat text-center">no more messages</span>');
                tiChat_jQuery('#chat_mob_main #load_more_id_'+paramArray.toId+' .no_more_chat').css({ "color" : "#ccc" , "text-decoration" : "none", "display" : "block"});
            }

        //}
        /*setTimeout(function(event){
            if (itemLengthCalc == 0) {
                tiChat_jQuery('#load_more_id_'+paramArray.toId+' .no_more_chat').remove();
                tiChat_jQuery('#load_more_id_'+paramArray.toId+' .load_more').remove();
                $('#load_more_id_'+paramArray.toId).append('<span class="load_more hand-symbol text-center">load earlier messages</span>');
                $('#load_more_id_'+paramArray.toId+' .load_more').css({ "color" : "#337ab7" , "text-decoration" : "none", "display" : "block"});
            } else  {
                tiChat_jQuery('#load_more_id_'+paramArray.toId+' .load_more').remove();
                tiChat_jQuery('#load_more_id_'+paramArray.toId+' .no_more_chat').remove();
                $('#load_more_id_'+paramArray.toId).append('<span class="no_more_chat text-center">no more messages</span>');
                $('#load_more_id_'+paramArray.toId+' .no_more_chat').css({ "color" : "#337ab7" , "text-decoration" : "none", "display" : "block"});
            }
        }, 1000);*/
    }






/* ==================================================================================================================================
       send chat messages
    ==================================================================================================================================== */

    function sendChat(paramsArray) {
        //alert("sendChat")
        var userName        =   viewerName;
        var userId          =   viewerId;
        var userProfilePic  =   viewerProfilePic;

        var from            =   userId;
        var toUserId        =   paramsArray.toId;
        var toProfilePic    =   paramsArray.toProfilePic;
        var roomName        =   "room1";
        var chatId          =   '#chatpage-windowContent_'+paramsArray.toId+' #chat_input_'+paramsArray.toId;
        if(paramsArray.chat_behaviour == "popupchat") {
            chatId      =   '.popup_box_'+paramsArray.toId+' #chat_input_'+paramsArray.toId;
        }
        if(paramsArray.chat_behaviour == "mobileChat") {
            chatId      =   '#chat_mob_main #chat_input_'+paramsArray.toId;
        }
        var message     =   tiChat_jQuery(chatId).val();
        if ((tiChat_jQuery.trim( message )).length == 0) {
        } else {
            tiChat_jQuery('.popup_box_'+paramsArray.toId+' #load_more_id_'+paramsArray.toId+' .no_chat_found').remove();
            tiChat_jQuery('.chatpage-windowContent #load_more_id_'+paramsArray.toId+' .no_chat_found').remove();
            tiChat_jQuery('#chat_mob_main #load_more_id_ .no_chat_found').remove();

            var createdAt   = new Date();
            var final_date  = getChatTime(createdAt);
            var chatAppend_params = {
                                    message             : message,
                                    chatId              : "",
                                    final_date          : final_date,
                                    fromId              : userId,
                                    toId                : paramsArray.toId,
                                    history_stat        : false,
                                    append_chat_each_id : "",
                                    chat_function       : paramsArray.chat_function
                                }
            // append chat in page chat only my chat view needed , that's why calling pageChat_AppendSameIdFn only #########
            pageChat_AppendSameIdFn(chatAppend_params);

                if(tiChat_jQuery(".chatpage-mainDiv").length != 0) {
                    tiChat_jQuery(".listedUser_"+paramsArray.toId+" .chat_displayLastMsg").html('');
                    tiChat_jQuery(".listedUser_"+paramsArray.toId+" .chat_displayLastMsg").text('You:'+message);
                }


            tiChat_jQuery(chatId).val('');

            var request = {
                                userId          :  userId,
                                userName        :  userName,
                                message         :  message,
                                toId            :  toUserId,
                                userProfilePic  :  userProfilePic,
                         };
            //api to save the chat
            saveChat_request(request);
        }
    }

/* ==================================================================================================================================
       appending & prepending functions
    ==================================================================================================================================== */



 /* ==================================================================================================================================
       Same appending & prepending functions
    ==================================================================================================================================== */
function same_prepend_popupbox(paramsArr) {

    tiChat_jQuery('.popup_box_'+paramsArr.toId+' ul.chat').prepend('<li id="'+paramsArr.chatId+'" class="'+paramsArr.append_chat_each_id+'"><div class="chatboxmsg_main">'+
                            '<div class="chatboxmessagecontent chat_self   selfchat_floatR"><span>'+paramsArr.message+'</span></div>'+
                            '<div class="selfMsgArrow"><div class="after"></div></div>'+
                            '<span class="send_chat_time" >'+paramsArr.final_date+'</span>'+
                            '</div></li>');

}

function same_prepend_popupboxMax(paramsArr) {

    tiChat_jQuery('.popup_box_max_'+paramsArr.toId+' ul.chat').prepend('<li id="'+paramsArr.chatId+'" class="'+paramsArr.append_chat_each_id+'"><div class="chatboxmsg_main">'+
                            '<div class="chatboxmessagecontent chat_self   selfchat_floatR"><span>'+paramsArr.message+'</span></div>'+
                            '<div class="selfMsgArrow"><div class="after"></div></div>'+
                            '<span class="send_chat_time" >'+paramsArr.final_date+'</span>'+
                            '</div></li>');

}

function same_prepend_pageChat(paramsArr) {

    tiChat_jQuery('.chatpage-windowContent #chatpage-windowContent_'+paramsArr.toId+' ul').prepend('<li id="'+paramsArr.chatId+'" class="'+paramsArr.append_chat_each_id+'"><div class="chatboxmsg_main">'+
                            '<div class="chatboxmessagecontent chat_self   selfchat_floatR"><span>'+paramsArr.message+'</span></div>'+
                            '<div class="selfMsgArrow"><div class="after"></div></div>'+
                            '<span class="send_chat_time pull-right" >'+paramsArr.final_date+'</span>'+
                            '</div></li>');

}

function same_prepend_mobileSingle(paramsArr) {

   tiChat_jQuery('#chat_mob_main  ul').prepend('<li id="'+paramsArr.chatId+'" class="'+paramsArr.append_chat_each_id+'"><div class="chatboxmsg_main">'+
                            '<div class="chatboxmessagecontent_mob chat_self_mob   selfchat_floatR"><span>'+paramsArr.message+'</span></div>'+
                            '<div class="selfMsgArrow_mob"><div class="after"></div></div>'+
                            '<span class="send_chat_time pull-right" >'+paramsArr.final_date+'</span>'+
                            '</div></li>');

}

function same_append_popupbox(paramsArr) {
    tiChat_jQuery(".popup_box_"+paramsArr.toId+ " .panel-body").animate({ scrollTop: tiChat_jQuery(".popup_box_"+paramsArr.toId+" .panel-body ul").height() }, "fast");
    tiChat_jQuery('.popup_box_'+paramsArr.toId+' ul.chat').append('<li id="'+paramsArr.chatId+'" class="'+paramsArr.append_chat_each_id+'"><div class="chatboxmsg_main">'+
                            '<div class="chatboxmessagecontent chat_self   selfchat_floatR"><span>'+paramsArr.message+'</span></div>'+
                            '<div class="selfMsgArrow"><div class="after"></div></div>'+
                            '<span class="send_chat_time" >'+paramsArr.final_date+'</span>'+
                            '</div></li>');

}

function same_append_popupboxMax(paramsArr) {
    tiChat_jQuery(".popup_box_max_"+paramsArr.toId+ " .panel-body").animate({ scrollTop: tiChat_jQuery(".popup_box_"+paramsArr.toId+" .panel-body ul").height() }, "fast");
    tiChat_jQuery('.popup_box_max_'+paramsArr.toId+' ul.chat').append('<li id="'+paramsArr.chatId+'" class="'+paramsArr.append_chat_each_id+'"><div class="chatboxmsg_main">'+
                            '<div class="chatboxmessagecontent chat_self   selfchat_floatR"><span>'+paramsArr.message+'</span></div>'+
                            '<div class="selfMsgArrow"><div class="after"></div></div>'+
                            '<span class="send_chat_time" >'+paramsArr.final_date+'</span>'+
                            '</div></li>');

}

function same_append_pageChat(paramsArr) {
    tiChat_jQuery(".chatpage-windowContent .panel-body").animate({ scrollTop: tiChat_jQuery(".chatpage-windowContent .panel-body ul").height() }, "fast");
    tiChat_jQuery('.chatpage-windowContent #chatpage-windowContent_'+paramsArr.toId+' ul').append('<li id="'+paramsArr.chatId+'" class="'+paramsArr.append_chat_each_id+'"><div class="chatboxmsg_main">'+
                            '<div class="chatboxmessagecontent chat_self   selfchat_floatR"><span>'+paramsArr.message+'</span></div>'+
                            '<div class="selfMsgArrow"><div class="after"></div></div>'+
                            '<span class="send_chat_time pull-right" >'+paramsArr.final_date+'</span>'+
                            '</div></li>');
}

function same_append_mobileSingle(paramsArr) {
    tiChat_jQuery("#chat_mob_main .panel-body").animate({ scrollTop: tiChat_jQuery("#chat_mob_main .panel-body ul").height() }, "fast");
    tiChat_jQuery('#chat_mob_main ul').append('<li id="'+paramsArr.chatId+'" class="'+paramsArr.append_chat_each_id+'"><div class="chatboxmsg_main">'+
                            '<div class="chatboxmessagecontent_mob chat_self_mob   selfchat_floatR"><span>'+paramsArr.message+'</span></div>'+
                            '<div class="selfMsgArrow_mob"><div class="after"></div></div>'+
                            '<span class="send_chat_time pull-right" >'+paramsArr.final_date+'</span>'+
                            '</div></li>');

}
/* ==================================================================================================================================
       Same appending chat where fromId and toId are same
    ==================================================================================================================================== */

    function pageChat_AppendSameIdFn(paramsArr) {
        if (!paramsArr.chatId) {
            paramsArr.chatId    =   "current_chat_id";
        }
        if (paramsArr.history_stat) { // Prepend Chat
            same_prepend_popupbox(paramsArr);
            same_prepend_popupboxMax(paramsArr);
            same_prepend_pageChat(paramsArr);
            same_prepend_mobileSingle(paramsArr);
        } else { // Append Chat
            same_append_popupbox(paramsArr);
            same_append_popupboxMax(paramsArr);
            same_append_pageChat(paramsArr);
            same_append_mobileSingle(paramsArr);
            tiChat_jQuery('.ps__scrollbar-y').height('');
        }
    }

/* ==================================================================================================================================
       Different appending chat where fromId and toId are same
    ==================================================================================================================================== */

function different_prepend_popupbox(paramsArr) {

    tiChat_jQuery('.popup_box_'+paramsArr.toId+' ul.chat').prepend('<li id="'+paramsArr.chatId+'" class="'+paramsArr.append_chat_each_id+'"><div class="chatboxmsg_main">'+
                                '<a class="otherchat_floatL"><img class="user_image-sm" src="'+paramsArr.toProfilePic+'" onerror="imgError(this);" title=""></a>'+
                                '<div class="chatboxmessagecontent  chat_notself otherchat_floatL"><span>'+paramsArr.message+'</span></div>'+
                                '<div class="msgArrow"><div class="after"></div></div>'+
                                ' <span class="otherchat_ts_other">'+paramsArr.final_date+'</span>'+
                                '</div></li>');
}

function different_prepend_popupboxMax(paramsArr) {

    tiChat_jQuery('.popup_box_max_'+paramsArr.toId+' ul.chat').prepend('<li id="'+paramsArr.chatId+'" class="'+paramsArr.append_chat_each_id+'"><div class="chatboxmsg_main">'+
                                '<a class="otherchat_floatL"><img class="user_image-sm" src="'+paramsArr.toProfilePic+'" onerror="imgError(this);" title=""></a>'+
                                '<div class="chatboxmessagecontent  chat_notself otherchat_floatL"><span>'+paramsArr.message+'</span></div>'+
                                '<div class="msgArrow"><div class="after"></div></div>'+
                                ' <span class="otherchat_ts_other">'+paramsArr.final_date+'</span>'+
                                '</div></li>');
}

function different_prepend_pageChat(paramsArr) {

    tiChat_jQuery('.chatpage-windowContent #chatpage-windowContent_'+paramsArr.toId+' ul').prepend('<li id="'+paramsArr.chatId+'" class="'+paramsArr.append_chat_each_id+'"><div class="chatboxmsg_main">'+
                                '<a class="otherchat_floatL"><img class="user_image-sm" src="'+paramsArr.toProfilePic+'" onerror="imgError(this);" title=""></a>'+
                                '<div class="chatboxmessagecontent chat_notself otherchat_floatL"><span>'+paramsArr.message+'</span></div>'+
                                '<div class="msgArrow"><div class="after"></div></div>'+
                                ' <span class="otherchat_ts_other">'+paramsArr.final_date+'</span>'+
                                '</div></li>');
}

function different_prepend_mobileSingle(paramsArr) {

    tiChat_jQuery('#chat_mob_main ul').prepend('<li id="'+paramsArr.chatId+'" class="'+paramsArr.append_chat_each_id+'"><div class="chatboxmsg_main">'+
                                '<a class="otherchat_floatL"><img class="user_image-sm" src="'+paramsArr.toProfilePic+'" onerror="imgError(this);" title=""></a>'+
                                '<div class="chatboxmessagecontent_mob chat_notself_mob otherchat_floatL"><span>'+paramsArr.message+'</span></div>'+
                                '<div class="msgArrow_mob mobArrow"><div class="after"></div></div>'+
                                ' <span class="otherchat_ts_other">'+paramsArr.final_date+'</span>'+
                                '</div></li>');
}

function different_append_popupbox(paramsArr) {
    tiChat_jQuery(".popup_box_"+paramsArr.toId+ " .panel-body").animate({ scrollTop: tiChat_jQuery(".popup_box_"+paramsArr.toId+" .panel-body ul").height() }, "fast");
    tiChat_jQuery('.popup_box_'+paramsArr.toId+' ul.chat').append('<li id="'+paramsArr.chatId+'" class="'+paramsArr.append_chat_each_id+'"><div class="chatboxmsg_main">'+
                                '<a class="otherchat_floatL"><img class="user_image-sm" src="'+paramsArr.toProfilePic+'" onerror="imgError(this);" title=""></a>'+
                                '<div class="chatboxmessagecontent chat_notself otherchat_floatL"><span>'+paramsArr.message+'</span></div>'+
                                '<div class="msgArrow"><div class="after"></div></div>'+
                                ' <span class="otherchat_ts_other">'+paramsArr.final_date+'</span>'+
                                '</div></li>');
}

function different_append_popupboxMax(paramsArr) {
    tiChat_jQuery(".popup_box_max_"+paramsArr.toId+ " .panel-body").animate({ scrollTop: tiChat_jQuery(".popup_box_"+paramsArr.toId+" .panel-body ul").height() }, "fast");
    tiChat_jQuery('.popup_box_max_'+paramsArr.toId+' ul.chat').append('<li id="'+paramsArr.chatId+'" class="'+paramsArr.append_chat_each_id+'"><div class="chatboxmsg_main">'+
                                '<a class="otherchat_floatL"><img class="user_image-sm" src="'+paramsArr.toProfilePic+'" onerror="imgError(this);" title=""></a>'+
                                '<div class="chatboxmessagecontent chat_notself otherchat_floatL"><span>'+paramsArr.message+'</span></div>'+
                                '<div class="msgArrow"><div class="after"></div></div>'+
                                ' <span class="otherchat_ts_other">'+paramsArr.final_date+'</span>'+
                                '</div></li>');
}

function different_append_pageChat(paramsArr) {
    tiChat_jQuery(".chatpage-windowContent .panel-body").animate({ scrollTop: tiChat_jQuery(".chatpage-windowContent .panel-body ul").height() }, "fast");
    tiChat_jQuery('.chatpage-windowContent #chatpage-windowContent_'+paramsArr.toId+' ul').append('<li id="'+paramsArr.chatId+'" class="'+paramsArr.append_chat_each_id+'"><div class="chatboxmsg_main">'+
                                '<a class="otherchat_floatL"><img class="user_image-sm" src="'+paramsArr.toProfilePic+'" onerror="imgError(this);" title=""></a>'+
                                '<div class="chatboxmessagecontent chat_notself otherchat_floatL"><span>'+paramsArr.message+'</span></div>'+
                                '<div class="msgArrow"><div class="after"></div></div>'+
                                ' <span class="otherchat_ts_other">'+paramsArr.final_date+'</span>'+
                                '</div></li>');
}

function different_append_mobileSingle(paramsArr) {
    tiChat_jQuery("#chat_mob_main .panel-body").animate({ scrollTop: tiChat_jQuery("#chat_mob_main .panel-body ul").height() }, "fast");
    tiChat_jQuery('#chat_mob_main ul').append('<li id="'+paramsArr.chatId+'" class="'+paramsArr.append_chat_each_id+'"><div class="chatboxmsg_main">'+
                                '<a class="otherchat_floatL"><img class="user_image-sm" src="'+paramsArr.toProfilePic+'" onerror="imgError(this);" title=""></a>'+
                                '<div class="chatboxmessagecontent_mob chat_notself otherchat_floatL"><span>'+paramsArr.message+'</span></div>'+
                                '<div class="msgArrow_mob mobArrow"><div class="after"></div></div>'+
                                ' <span class="otherchat_ts_other">'+paramsArr.final_date+'</span>'+
                                '</div></li>');

}
/* ==================================================================================================================================
       Different appending chat where fromId and toId are same
    ==================================================================================================================================== */

/* ==================================================================================================================================
       appending chat where fromId and toId are different
    ==================================================================================================================================== */

    function pageChat_AppendDiffIdFn(paramsArr) {
        if(paramsArr.history_stat) { // Prepend Chat
            different_prepend_popupbox(paramsArr);
            different_prepend_popupboxMax(paramsArr);
            different_prepend_pageChat(paramsArr);
            different_prepend_mobileSingle(paramsArr);
        } else { // Append Chat
            different_append_popupbox(paramsArr);
            different_append_popupboxMax(paramsArr);
            different_append_pageChat(paramsArr);
            different_append_mobileSingle(paramsArr)
            tiChat_jQuery('.ps__scrollbar-y').height('');
        }
    }

/* ==================================================================================================================================
       function to get page chat history
    ==================================================================================================================================== */
     function getPageChat(appendParams) {

            if(tiChat_jQuery(".largeChatWindow").length != 0) {
                getChat(appendParams);
            } else {
                var userName        =   viewerName;
                var userId          =   viewerId;
                var userProfilePic  =   viewerProfilePic;

                var toId            =   appendParams.toId;
                var toName          =   appendParams.toName;
                var toProfilePic    =   appendParams.toProfilePic;
                var focus_id        =   appendParams.focus_id;
                var page_type       =   appendParams.page_type;
                //var popupCallId     =   appendParams.page_type;
                var popupCallId     =   'popup_call_'+appendParams.toId;
                var video           =  'video';
                var audio           =  'audio';


                var is_LoadMore     =   localStorage.getItem('is_LoadMore');
                tiChat_jQuery.ajax({
                    url       : server_base_url+"chat/getChat",
                    data      : {
                                    userId      :   userId,
                                    focusChatId :   focus_id,
                                    pageType    :   page_type,
                                    toId        :   toId
                                },
                    headers   : {
                                },
                }).done(function(data) {
                    var scroll_limit;
                    var element ='<div class="chatpage-windowContentInner no-margin">';

                        element +='<div class="col-xs-12 col-sm-12 col-md-12 chatpage-windowSubtitle">';
                            element +='<div class="col-xs-6 col-sm-8 col-md-8 chat-vertical-middle chatpage-windowUserDtls">';

                            element += '</div>';
                            element +='<div class="col-xs-6 col-sm-4 col-md-4 pull-right chat-vertical-middle chatpage-windowCallIcons">';
                                element +='<span title="close" class="btn chatpage-windowCloseBtn pull-right"> x </span>';
                                element +='<span class="common-call-symbol hand-symbol video-call-symbol pull-right"  data-toggle="modal" onclick="callerInitiateCall(\''+appendParams.toId+'\', \''+appendParams.toName+'\',\''+video+'\',\''+appendParams.toProfilePic+'\');" title="Video call"  id="'+popupCallId+'">';
                                    element +='<img src="../application/modules/User/externals/images/video-camera.svg">';
                                element +='</span>';
                                element +='<span class="common-call-symbol audio-call-symbol hand-symbol pull-right"  data-toggle="modal" onclick="callerInitiateCall(\''+appendParams.toId+'\', \''+appendParams.toName+'\',\''+audio+'\',\''+appendParams.toProfilePic+'\');" title="Audio call"  id="'+popupCallId+'">';
                                    element +='<i class="fa fa-phone" aria-hidden="true"></i>';
                                element +='</span>';
                                //element +='<div class="ccplugins " id="cometchat_videochaticon" title="Start an audio/video call" name="ccavchat" to="117" chatroommode="0"></div>'
                            element += '</div>';
                        element += '</div>';

                        element +='<div class="panel">';
                            element +='<!-- <div class="panel-heading chat_head" id="accordion">';
                                element +='<span class="online-offline-symbol"></span>';
                                element +='<span class="glyphicon glyphicon-comment"></span>';
                                element +='<span class="username">name</span>';
                            element +='</div> -->';
                            element +='<div class="panel-collapse collapse in">';
                                element +='<div class="panel-body mainPanel" id="chat_scroll_id">';
                                    element +='<span id="load_more_id_'+toId+'"></span>';
                                    element +='<ul class="chat">';
                                    element +='</ul>';
                                element +='</div>';
                                element +='<div class="panel-footer mainfooter">';
                                    element +='<div class="input-group">';
                                        element +='<input type="text" id="chat_input_'+toId+'" class="form-control input-sm input_typing" placeholder="Type your message" />';
                                        element +='<div class="input-group-btn">';
                                            element +='<a id="sendPageChatId" class="btn btn-success btn-sm input_typing" onclick="pageChatSend(\''+toId+'\')">';
                                                element += '<span class="fa fa-paper-plane-o"></span>';
                                            element += '</a>';
                                        element +='</div>';
                                    element +='</div>';
                                element +='</div>';
                            element +='</div>';
                        element +='</div>';
                    element +='</div>';

                    var res_arr     =   [];
                    if (is_LoadMore == 0) {
                        localStorage.setItem('is_LoadMore', 1);
                        tiChat_jQuery('.chatpage-windowContent').html('');
                        tiChat_jQuery('.chatpage-windowContent').append(element);

                        // var page_height      =   parseInt(tiChat_jQuery(window).height() - tiChat_jQuery('#chatpage-id .chatpage-mainDiv .chatpage-windowContent .chatpage-windowSubtitle').height() - 50 - tiChat_jQuery('.main_menu_div').height() - 27);
                        // var page_height      =   parseInt( tiChat_jQuery(window).height() - tiChat_jQuery('.chatpage-mainDiv .chatpage-windowContent .chatpage-windowSubtitle').height() - tiChat_jQuery('.main_menu_div').height() - tiChat_jQuery('.chatpage-mainDiv .chatpage-windowContent .panel-footer').height() - 15);
                        var page_height      =   parseInt( tiChat_jQuery(".chatpage-usersListMainDiv").height() - tiChat_jQuery('.chatpage-mainDiv .chatpage-windowContent .chatpage-windowSubtitle').height() - (1.67 * tiChat_jQuery('.chatpage-mainDiv .chatpage-windowContent .panel-footer').height()) );
                        tiChat_jQuery("#chatpage-id .chatpage-mainDiv .chatpage-windowContent .panel-body").css("height",page_height+"px");

                        // tiChat_jQuery('.mainWindowCall').css({ 'pointer-events' : 'all' });
                        tiChat_jQuery('.chatpage-chatWindowMain .common-call-symbol').removeClass("offlineCallClick");
                        tiChat_jQuery('.chatpage-chatWindowMain .common-call-symbol').addClass("onlineCallClick");

                        if (localStorage.getItem('onlineUserList').indexOf(appendParams.toId) == -1 ) {
                             //alert("User is offline");
                             // tiChat_jQuery('.mainWindowCall').css({ 'pointer-events' : 'none' });
                            tiChat_jQuery('.chatpage-chatWindowMain .common-call-symbol').removeClass("onlineCallClick");
                            tiChat_jQuery('.chatpage-chatWindowMain .common-call-symbol').addClass("offlineCallClick");
                        }

                        var appendElement = '<img class="user_image-sm" src="'+toProfilePic+'" onerror="imgError(this);"/>';
                            appendElement = appendElement + '<span class="chat_userdisplayname">'+toName+'<span class="chat_subtitle_arrow">';
                            appendElement = appendElement + '<img  src="../application/modules/User/externals/chat/images/rightarrow.svg" /></span></span>';
                            appendElement = appendElement + '<span style="visibility: hidden" id="user_id">'+toId+'</span>';
                            appendElement = appendElement + '<span class="typingDisplay"> is typing...</span>';
                            tiChat_jQuery('.chatpage-windowSubtitle .chatpage-windowUserDtls').append(appendElement);

                        // Append a new id to chat content
                        tiChat_jQuery("div.chatpage-windowContentInner").attr('id', 'chatpage-windowContent_'+toId);
                        res_arr     =   data.result;
                    } else{
                        res_arr     =   data.result;
                    }

                    var lowest_chat_id   = 0;
                    var last_iteration_i = 0;
                    if (res_arr.length) {
                        var minusArrayLength = 0;
                        tiChat_jQuery.each( res_arr, function( i, val ) {
                            // alert("tiChat_jQuery each"+i+"====="+res_arr.length);
                            var createdAt   = new Date(val.createdAt);
                            var final_date  = getChatTime(createdAt);
                            scroll_id       =   'chat_id_'+val.id;
                            var chatAppend_params = {
                                                    message             : val.message,
                                                    chatId              : scroll_id,
                                                    final_date          : final_date,
                                                    fromId              : userId,
                                                    toId                : toId,
                                                    toProfilePic        : val.from_profilepic,
                                                    history_stat        : true,
                                                    append_chat_each_id : i+1,
                                                    chat_function       : "getPageChat"
                                                }
                            if (userId == val.fromId) {
                                // append chat in page chat ###########
                                pageChat_AppendSameIdFn(chatAppend_params);
                                setReadStatus(appendParams.toId);
                            } else {
                                // append chat in page chat ############
                                pageChat_AppendDiffIdFn(chatAppend_params);
                                setReadStatus(appendParams.toId);
                            }

                            minusArrayLength = parseInt(res_arr.length) - 1;
                            if (i == minusArrayLength) {
                                lowest_chat_id      =   val.id;
                                last_iteration_i    =   i;
                                scroll_limit        =   val.id;
                                localStorage.setItem('lowest_chat_id',lowest_chat_id);
                                localStorage.setItem('last_iteration_i', (i + 1));
                            }
                        });

                        // scrollChat(toId,toName,scroll_limit,res_arr,is_LoadMore);
                        var decideAppend_params = {
                            toId            : toId,
                            toName          : toName,
                            scroll_limit    : scroll_limit,
                            res_arr         : res_arr,
                            is_LoadMore     : is_LoadMore,
                            lowest_chat_id  : localStorage.getItem('lowest_chat_id'),
                            array_length    : localStorage.getItem('last_iteration_i')
                        }

                        decidePreviousNomore(decideAppend_params);

                        tiChat_jQuery(document).on("click",".chatpage-windowContent #load_more_id_"+toId+" .load_more",function(e) {
                            var appendParams = {
                                                    toId         :  toId,
                                                    toName       :  toName,
                                                    toProfilePic :  toProfilePic,
                                                    focus_id     :  localStorage.getItem('lowest_chat_id'),
                                                    page_type    :  page_type,
                                                    is_LoadMore  :  is_LoadMore,
                                                }
                            getPageChat(appendParams);
                            e.stopImmediatePropagation();
                        });

                        // scroll down on page chat
                        if (is_LoadMore == 0) {
                            tiChat_jQuery(".chatpage-windowContent .panel-body").animate({ scrollTop: tiChat_jQuery(".chatpage-windowContent .panel-body ul").height() }, "fast");
                        } else {
                            tiChat_jQuery('.chatpage-windowContent .panel-body').animate({ scrollTop: tiChat_jQuery(".chatpage-windowContent .panel-body li#chat_id_"+focus_id).offset().top }, "medium");
                            // tiChat_jQuery('.chatpage-windowContent .panel-body').animate({ scrollTop: $(".chatpage-windowContent .panel-body li#chat_id_186").offset().top }, "medium");
                        }
                    } else {
                        tiChat_jQuery('.chatpage-windowContent #load_more_id_'+toId+' .load_more').remove();
                        tiChat_jQuery('.chatpage-windowContent #load_more_id_'+toId+' .no_more_chat').remove();
                        tiChat_jQuery('.chatpage-windowContent #load_more_id_'+toId+' .no_chat_found').remove();
                        if (res_arr.length == 0) {
                            tiChat_jQuery('.chatpage-windowContent #load_more_id_'+toId).append('<span class="no_chat_found text-center">no messages</span>');
                        } else {
                            tiChat_jQuery('.chatpage-windowContent #load_more_id_'+toId).append('<span class="no_more_chat text-center">no more messages</span>');
                        }

                        tiChat_jQuery('.chatpage-windowContent #load_more_id_'+toId+' .no_more_chat').css({ "color" : "#8DC63F" , "text-decoration" : "none", "display" : "block"});
                        tiChat_jQuery('.chatpage-windowContent #load_more_id_'+toId+' .no_chat_found').css({ "color" : "#8DC63F" , "text-decoration" : "none", "display" : "block"});
                    }

                    // is Typing using socket
                    tiChat_jQuery('#chat_input_'+toId).keypress(function(e){
                        var toUserId    =   toId;
                        var message     =   tiChat_jQuery('#chat_input_'+toId).val();
                        var request     = {
                                            message  :  message,
                                            userId   :  userId,
                                            toId     :  toId,
                                            toName   :  toName,
                                        };

                        // Function to get typing notification
                        chatTyping_request(request);

                        // call save chat api on enter key press
                        var sendChat_params = {
                                        toId           : toId,
                                        userProfilePic : userProfilePic,
                                        chat_behaviour : "pagechat",
                                        chat_function       : "getPageChat"
                                        }
                        if (e.keyCode == 13) {
                            sendChat(sendChat_params);
                        }
                    });

                    // chat window close button
                    tiChat_jQuery(document).on("click",".chatpage-windowCloseBtn",function() {
                        tiChat_jQuery('#chatpage-windowContent_'+toId).remove();
                        localStorage.removeItem("chatPage_open_datas");
                        tiChat_jQuery(".chatpage-dummyWindowContent").show();
                    });

                    // chat Page Panel Height
                    var chatpagePanelHeight     =   tiChat_jQuery('.chatpage-mainDiv').height() - ( tiChat_jQuery('.chatpage-currentUserDiv').height() + tiChat_jQuery(".chatpage-windowSubtitle").height() + tiChat_jQuery(".chatpage-windowContent .panel-footer").height() );
                    //tiChat_jQuery(".chatpage-windowContent .panel-body").css("height",chatpagePanelHeight+"px");

                    if(tiChat_jQuery(".chatpage-mainDiv").length == 0) {
                       tiChat_jQuery("body .popup-box").css("display","block");
                    }else{
                        tiChat_jQuery("body .popup-box").css("display","none");
                    }

                    //Adding scroll style
                    // tiChat_jQuery('.chatpage-windowContent .panel-body').jScrollPane();
                    tiChat_jQuery('.chatpage-windowContent .panel-body').perfectScrollbar();

                });
            }
    }

/* ==================================================================================================================================
       function to calculate scroll height
    ==================================================================================================================================== */

    function find_scroll_height(is_LoadMore) {
        if (is_LoadMore == 0) {
            tiChat_jQuery("#chat_scroll_id").scroll(function () {
                //$("#chat_scroll_id").scrollTop($("#chat_scroll_id")[0].scrollHeight);
                var scrollTop = tiChat_jQuery("#chat_scroll_id")[0].scrollHeight;
            });
        }
    }


/* ==================================================================================================================================
       function to display the structure to body
    ==================================================================================================================================== */
    function appendBodyInitialStructure() {
            var userName            =   viewerName;
            var userId              =   viewerId;
            var userProfilePic      =   viewerProfilePic;

            var element     = '<div id="chatpage-id" class="container">';
                    //element += '<div class="row">';
                        element +='<div class="chatpage-mainDiv">';
                            element +='<!-- User header -->';
                            element +='<div class="chatpage-currentUserDiv" style="background:#f2f2f2;">';
                                element +='<div class="col-sm-12 col-md-12 no-padding">';
                                    element +='<div class="col-sm-12 col-md-12 chatpage-userNameMainDiv">';
                                        element +='<span class="col-sm-1 col-md-1">';
                                            element +='<img class="user_image-sm" src="'+userProfilePic+'" onerror="imgError(this);"/>';
                                        element +='</span>';
                                        element +='<div class="col-sm-11 col-md-11">';
                                            //element +='<span class ="online-offline-symbol online-symbol chat_userscontentdot"></span>';
                                            element +='<div class="chatpage-userName " id="chat_page_headName" style="color:black;">'+userName+'</div>';
                                        element +='</div>';
                                    element +='</div>';
                                element +='</div>';
                            element +='</div>';
                            element +='<!-- Users List + Chat display -->';
                            //element +='<div class="row">';
                                element +='<div class="col-sm-12 col-md-12 no-padding">';
                                    element +='<div class="col-sm-12 col-md-4 col-xs-12 no-padding">';
                                    /*element +='<div class="col-sm-12 col-md-12 col-xs-12 no-padding" id="userListMainTab">';*/
                                        element +='<div class="chatpage-usersListMainDiv">';
                                            element +='<div class="listUserSearch">';
                                                 element +='<span class="fa fa-search chatSearchIcon"></span>';
                                                 element +='<input id="listusersearchId" type="text" onkeyup="listUserSearch(this.value)" class="form-control input-sm chatSearch" placeholder="search"/>';
                                                 element +='<span title="Close"  class="chatSearchCloseBtn pull-right hand-symbol">';
                                            element +='X</a></div>';
                                            element += '<ul class="listedusers"></ul>';
                                        element +='</div>';
                                    element +='</div>';
                                    element +='<div class="col-sm-12 col-md-8 col-xs-12 no-padding" id="mainChatIndiv">';
                                        element +='<div class="chatpage-chatWindowMain">';
                                            element +='<div class="chatpage-dummyWindowContent">';
                                                element +='<div class="dummyInner">';
                                                    element +='<div class="text-center dummyText"><img src="/application/modules/User/externals/images/chat.png" class="msgNtfnIcon"></div>';
                                                    element +='<div class="text-center dummyText">No messages yet<br>';
                                                    element +='<span class="subText">To get started , connect with a renter or landlord</span></div>';
                                                element +='</div>';
                                            element +='</div>';
                                            element +='<div class="chatpage-windowContent">';
                                            element +='</div>';
                                        element +='</div>';
                                    element +='</div>';
                                element +='</div>';
                            //element +='</div>';
                        element +='</div>';
                    //element +='</div>';
            element +='</div>';

            tiChat_jQuery('#global_page_user-index-tichatapp #global_wrapper').append(element)
            // var page_height          =   parseInt(tiChat_jQuery(window).height() - tiChat_jQuery('.main_menu_div').height() - 20);
            var page_height          =   parseInt(tiChat_jQuery(window).height() - (2*tiChat_jQuery('.main_menu_div').height()) );

            //alert(page_height)
            tiChat_jQuery("#chatpage-id .chatpage-mainDiv .chatpage-usersListMainDiv").css("height",page_height+"px");
            tiChat_jQuery("#chatpage-id .chatpage-mainDiv .chatpage-dummyWindowContent").css("height",page_height+"px");

            tiChat_jQuery(document).on("click",".chatSearchCloseBtn",function(e) {
                tiChat_jQuery("#listusersearchId").val('');
                listAllUsers_request();
            });

            tiChat_jQuery("#chatpage-id").css("display","block !important");
            tiChat_jQuery('.chatpage-usersListMainDiv').perfectScrollbar();
    }

/* ==================================================================================================================================
       function to display chat structure in mobile
    ==================================================================================================================================== */

       function appendChatMobile() {

        //alert("got mobile chat=========>")
        var userName            =   viewerName;
        var userId              =   viewerId;
        var userProfilePic      =   viewerProfilePic;

        var element     = '<div id="chatpage-id-mob">';
                element += '<div class="row">';
                    element += '<div class="col-sm-12 singleChatPage">';
                        element +='<!-- chat=====header========== -->';
                        element +='<div class="chatpage-currentUserDiv chatmob-currentUserDiv">';
                            element +='<div class="col-sm-12">';
                                element += '<div class="mob_chat_call">';
                                element += '</div>';
                                element +='<div class="chatpage-userNameMainDiv">';
                                    element +='<span class="chat_userscontentavatar" id="userImageMob">';
                                       // element +='<img class="user_image-sm" src="'+userProfilePic+'" onerror="imgError(this);"/>';
                                    element +='</span>';
                                    element +='<div class="chat_chatboxDisplayDetails">';
                                        //element +='<span class ="online-offline-symbol online-symbol chat_userscontentdot"></span>';
                                       element +='<div class="chat_userdisplayname chatpage-userName " id="chat_mob_headName"><div>';
                                    element +='</div></div>';
                                    element +='<span></span></div>';
                                element +='</div>';
                            element +='</div>';
                        element +='</div>';
                        element +='<!-- chat=====content========== -->';
                        element +='<div id="chat_mob_main">';
                        element +='</div>';
                    element += '</div>';
                element += '</div>';
            element    += '</div>';


        tiChat_jQuery('#global_page_user-index-singlechatmob #global_wrapper').append(element)
        tiChat_jQuery("#chatpage-id-mob").css("display","block !important");

    }

/* ==================================================================================================================================
       getChatTime
    ==================================================================================================================================== */
    function getChatTime(createdAt) {
        var createdDateTime     =   createdAt;
        var createdDateOnly     =   new Date(createdDateTime).setHours(0, 0, 0, 0);
        var currentDateTime     =   new Date();
        var currentDateOnly     =   new Date().setHours(0, 0, 0, 0);
        var day                 =   createdDateTime.getDate();
        var month               =   createdDateTime.getMonth()+1;
        var hour                =   createdDateTime.getHours();
        var minute              =   createdDateTime.getMinutes();

        if (createdDateTime.getDate() < 10 ) {
                day     = "0"+day;
        }
        if ( (createdDateTime.getMonth()+1) < 10 ) {
            month   = "0"+month;
        }
        if ( createdDateTime.getHours() < 10 ) {
            hour   = "0"+hour;
        }
        if ( createdDateTime.getMinutes() < 10 ) {
            minute   = "0"+minute;
        }

        var onlyTime    =   (hour > 12) ? (hour-12 + ':' + minute +' PM') : (hour + ':' + minute +' AM');
        var final_date  =   "";
        if ( createdDateOnly < currentDateOnly ) {
            var createdDate =   day  + "/" + month + "/" + createdDateTime.getFullYear();
            final_date  =   createdDate + ' ' + onlyTime;
        } else {
            final_date  =   onlyTime;
        }
        return final_date;
    }

/* ==================================================================================================================================
       image error function
    ==================================================================================================================================== */
    function imgError(image) {
        image.onerror = "";
        //image.src = "../application/modules/User/externals/chat/images/default_profile_pic.png";
        image.src = "../application/modules/User/externals/images/nophoto_user_thumb_icon.png";
        return true;
    }

/* ==================================================================================================================================
       Click PageChat send Button
    ==================================================================================================================================== */
    function pageChatSend(toId) {
        //alert("pageChatSend +++++++++++");
        var userName            =   viewerName;
        var userId              =   viewerId;
        var userProfilePic      =   viewerProfilePic;

        var toId                = toId;
        var sendChat_params = {
                                toId           : toId,
                                userProfilePic : userProfilePic,
                                chat_behaviour : "pagechat",
                                chat_function  : "getPageChat"
                                }
        sendChat(sendChat_params);
    }

 /* ==================================================================================================================================
      Click on user popup
    ==================================================================================================================================== */
    function popUpChatClick(userId,userName,userProfilePic,popup_status, isWebsocket) {
        //alert("popUpChatClick ---------");
        console.log("popUpChatClick ++++++++++++");
        //alert("isWebsocket ----")
        //alert(isWebsocket)
        if(!isWebsocket) {
            tiChat_jQuery('.popup_box_'+userId+' ul.chat li').remove(); // hide it if it is socket receive
        }
        console.log(JSON.parse(localStorage.getItem('chatPopup_open_datas')));

        //var chatPopup_open_datasArray   = [];
        //var chatMob_open_datasArray     = [];
        var chatPopup_open_datasArray   =   [];
        var chatMob_open_datasArray     =   [];
        var toId                        =   userId;
        var toName                      =   userName;
        var toProfilePic                =   userProfilePic;
        var focus_id                    =   0;
        var page_type                   =   "new";
        var toIdPresent                 =   false;

        localStorage.setItem('is_LoadMore',0);
        //if(popup_status!='mobile') {

        // Adding values to localstorage - chatPopup_open_datas
        if(localStorage.getItem('chatPopup_open_datas') ) {
            console.log("LOCALSTORAGE chatPopup_open_datas present ++++++++++++");
            var chatPopup_open_datas_prev   =   JSON.parse(localStorage.getItem('chatPopup_open_datas'));
            if (chatPopup_open_datas_prev.length) {
                tiChat_jQuery.each( chatPopup_open_datas_prev, function( i, val ) {
                    console.log(i);
                    //if(val.toId != toId) {
                        chatPopup_open_datasArray.push(val);
                    //}

                    if(val.toId == toId) {
                        toIdPresent   = true;
                    }
                });

                var chatPopup_open_datas  = {
                                            toId            :  toId,
                                            toName          :  toName,
                                            toProfilePic    :  toProfilePic,
                                            focus_id        :  focus_id,
                                            page_type       :  page_type,
                                            is_LoadMore     :  0
                                            };
                chatPopup_open_datasArray.push(chatPopup_open_datas);
                console.log(chatPopup_open_datasArray);

                //Remove duplicate values from jsonArray
                chatPopup_open_datasArray  = removeDuplicate(chatPopup_open_datasArray, 'toId')
                console.log(chatPopup_open_datasArray);
                localStorage.setItem('chatPopup_open_datas', JSON.stringify(chatPopup_open_datasArray) );
            } else {
                //chatPopup_open_datasArray     =  [];
                console.log("No length");
                var chatPopup_open_datas  = {
                                        toId            :  toId,
                                        toName          :  toName,
                                        toProfilePic    :  toProfilePic,
                                        focus_id        :  focus_id,
                                        page_type       :  page_type,
                                        is_LoadMore     :  0
                                    };
                chatPopup_open_datasArray.push(chatPopup_open_datas);
                console.log(chatPopup_open_datasArray);
                //Remove duplicate values from jsonArray
                //chatPopup_open_datasArray  = removeDuplicate(chatPopup_open_datasArray, 'toId')
                localStorage.setItem('chatPopup_open_datas', JSON.stringify(chatPopup_open_datasArray) );
                toIdPresent   = true;
            }
        } else {
                console.log("LOCALSTORAGE chatPopup_open_datas Absent ++++++++++++");
                var chatPopup_open_datas  = {
                                        toId            :  toId,
                                        toName          :  toName,
                                        toProfilePic    :  toProfilePic,
                                        focus_id        :  focus_id,
                                        page_type       :  page_type,
                                        is_LoadMore     :  0
                                        };
                chatPopup_open_datasArray.push(chatPopup_open_datas);
                console.log(chatPopup_open_datasArray);
                //Remove duplicate values from jsonArray
                chatPopup_open_datasArray  = removeDuplicate(chatPopup_open_datasArray, 'toId')
                localStorage.setItem('chatPopup_open_datas', JSON.stringify(chatPopup_open_datasArray) );
                toIdPresent   = true;
        }

        // Adding values to localstorage - chatMobile_data
        var chat_mobile_toId    =   localStorage.getItem('chatMobile_data_toId');
        localStorage.setItem('chatMobile_toId_prev',chat_mobile_toId);
        localStorage.setItem('chatMobile_data_toId',toId);
        if(localStorage.getItem('chatMobile_data')) {
            localStorage.removeItem("chatMobile_data");
            var  chatMobile_data     = {
                                            toId            :  toId,
                                            toName          :  toName,
                                            toProfilePic    :  toProfilePic,
                                            focus_id        :  focus_id,
                                            page_type       :  page_type,
                                            is_LoadMore     :  0
                                        };
            chatMob_open_datasArray.push(chatMobile_data);

            localStorage.setItem('chatMobile_data', JSON.stringify(chatMob_open_datasArray) );

        }else {
            localStorage.removeItem("chatMobile_data");
            var chatMobile_data  = {
                                        toId            :  toId,
                                        toName          :  toName,
                                        toProfilePic    :  toProfilePic,
                                        focus_id        :  focus_id,
                                        page_type       :  page_type,
                                        is_LoadMore     :  0
                                   };
            chatMob_open_datasArray.push(chatMobile_data);
            localStorage.setItem('chatMobile_data', JSON.stringify(chatMob_open_datasArray) );
        }
        //}

        // To get all page chat
        var appendParams = {
                            toId        :  toId,
                            toName      :  toName,
                            focus_id    :  focus_id,
                            page_type   :  page_type,
                            toProfilePic:  toProfilePic,
                            is_LoadMore :  0
                            }
        console.log(toIdPresent +"      *****     ");
        //alert("1")
        //alert(popup_status)
        //alert(isWebsocket)
        if(popup_status=='large_popUp') { //For Max popup window
            //alert("2")
            if(!toIdPresent) {//Remove only when it is first time
                close_popup(appendParams);
            }
            if(!isWebsocket) {
                // alert("no websocket")
                register_popup_single(appendParams); // hide it if it is socket receive
            }
        }else { //For Min popup window
            //alert("3")
            //alert("large popup")

            //tiChat_jQuery('.largeChatWindow').remove();
            tiChat_jQuery('.wrapper').css({'opacity' : '' });
            if (!toIdPresent) {//Remove only when it is first time
                close_popup(appendParams);
            }

            //if(popup_status != 'mobile') {
            if(popup_status == 'small_popUp') {
                if(!isWebsocket) {
                    register_popup(appendParams); // hide it if it is socket receive
                }
            }
        }
    }

 /* ==================================================================================================================================
       Function for mobile chat page
    ==================================================================================================================================== */

    function single_chat_mobile(appendParams) {

        var userName        =   viewerName;
        var userId          =   viewerId;
        var userProfilePic  =   viewerProfilePic;

        var toId            =   appendParams.toId;
        var toName          =   appendParams.toName;
        var toProfilePic    =   appendParams.toProfilePic;
        var focus_id        =   appendParams.focus_id;
        var page_type       =   appendParams.page_type;

        var audio           =   'audio';
        var video           =   'video';

        var is_LoadMore     =   localStorage.getItem('is_LoadMore');
        tiChat_jQuery.ajax({
            url       : server_base_url+"chat/getChat",
            data      : {
                            userId      :   userId,
                            focusChatId :   focus_id,
                            pageType    :   page_type,
                            toId        :   toId
                        },
        }).done(function(data) {

            tiChat_jQuery('.singleChatPage').removeClass('chatWindow_mobile_'+toId);
            tiChat_jQuery('.singleChatPage').addClass('chatWindow_mobile_'+toId);

            tiChat_jQuery('#userImageMob').append('<img class="user_image-sm" src="'+appendParams.toProfilePic+'" onerror="imgError(this);"/>');
            tiChat_jQuery('#chat_mob_headName').append(appendParams.toName);

            //========================Video/Audio Elments============================================

            var videoElem = '<span class="hand-symbol audio-call-symbol common-call-symbol" data-toggle="modal" onclick="callerInitiateCall(\''+appendParams.toId+'\', \''+appendParams.toName+'\',\''+audio+'\',\''+appendParams.toProfilePic+'\');" title="Audio Call">';
                videoElem += '<i class="fa fa-phone" aria-hidden="true"></i></span>';
                videoElem += '<span class="hand-symbol common-call-symbol video-call-symbol" data-toggle="modal" onclick="callerInitiateCall(\''+appendParams.toId+'\', \''+appendParams.toName+'\',\''+video+'\',\''+appendParams.toProfilePic+'\');" title="Video Call">';
                videoElem += '<img src="../application/modules/User/externals/images/video-camera.svg" style="width: 30px;height: 30px;margin-top: -4px;"></span>';

            tiChat_jQuery('.mob_chat_call').append(videoElem);

            var element ='<div class="panel">';
                element +='<!-- <div class="panel-heading chat_head" id="accordion">';
                    element +='<span class="online-offline-symbol"></span>';
                    element +='<span class="glyphicon glyphicon-comment"></span>';
                    element +='<span class="username">name</span>';
                element +='</div> -->';
                element +='<div class="panel-collapse collapse in">';
                    element +='<div class="panel-body panel_mobile" id="chat_scroll_id">';
                        element +='<span id="load_more_id_'+appendParams.toId+'"></span>';
                        element +='<ul class="chat">';
                        element +='</ul>';
                    element +='</div>';
                    element +='<div class="panel-footer">';
                        element +='<div class="input-group">';
                            element +='<input type="text" id="chat_input_'+appendParams.toId+'" class="form-control input-sm input_typing" placeholder="Type your message" />';
                            element +='<div class="input-group-btn">';
                                element +='<a id="sendPageChatId" style="background-color: #ddd;" class="btn btn-success btn-sm input_typing" onclick="mobChatSend(\''+appendParams.toId+'\')">';
                                    element += '<span class="fa fa-paper-plane-o"></span>';
                                element += '</a>';
                            element +='</div>';
                        element +='</div>';
                    element +='</div>';
                element +='</div>';
             element +='</div>';

            tiChat_jQuery('#chat_mob_main').html('');
            tiChat_jQuery('#chat_mob_main').append(element);
            //setReadStatus(appendParams.toId)
            setReadStatus(appendParams.toId);

            var res_arr     =   [];
            if (is_LoadMore == 0) {
                localStorage.setItem('is_LoadMore', 1);
                tiChat_jQuery('#chat_mob_main').html('');
                tiChat_jQuery('#chat_mob_main').append(element);
                res_arr     =   data.result;
            } else{
                res_arr     =   data.result;
            }

            var lowest_chat_id   = 0;
            var last_iteration_i = 0;
            if (res_arr.length) {
                var minusArrayLength = 0;
                tiChat_jQuery.each( res_arr, function( i, val ) {
                    // alert("tiChat_jQuery each"+i+"====="+res_arr.length);
                    var createdAt   = new Date(val.createdAt);
                    var final_date  = getChatTime(createdAt);
                    scroll_id       =   'chat_id_'+val.id;
                    var chatAppend_params = {
                                            message             : val.message,
                                            chatId              : scroll_id,
                                            final_date          : final_date,
                                            fromId              : userId,
                                            toId                : toId,
                                            toProfilePic        : val.from_profilepic,
                                            history_stat        : true,
                                            append_chat_each_id : i+1
                                        }
                    if (userId == val.fromId) {
                        // append chat in page chat ###########
                        pageChat_AppendSameIdFn(chatAppend_params);
                    } else {
                        // append chat in page chat ############
                        pageChat_AppendDiffIdFn(chatAppend_params);
                    }

                    minusArrayLength = parseInt(res_arr.length) - 1;
                    if (i == minusArrayLength) {
                        lowest_chat_id      =   val.id;
                        last_iteration_i    =   i;
                        scroll_limit        =   val.id;
                        localStorage.setItem('lowest_chat_id',lowest_chat_id);
                        localStorage.setItem('last_iteration_i', (i + 1));
                    }
                });

                // scrollChat(toId,toName,scroll_limit,res_arr,is_LoadMore);
                var decideAppend_params = {
                    toId            : toId,
                    toName          : toName,
                    scroll_limit    : scroll_limit,
                    res_arr         : res_arr,
                    is_LoadMore     : is_LoadMore,
                    lowest_chat_id  : localStorage.getItem('lowest_chat_id'),
                    array_length    : localStorage.getItem('last_iteration_i')
                }

                decidePreviousNomore(decideAppend_params);

                tiChat_jQuery(document).on("click","#chat_mob_main #load_more_id_"+toId+" .load_more",function(e) {
                    var appendParams = {
                                            toId         :  toId,
                                            toName       :  toName,
                                            toProfilePic :  toProfilePic,
                                            focus_id     :  localStorage.getItem('lowest_chat_id'),
                                            page_type    :  page_type,
                                            is_LoadMore  :  is_LoadMore,
                                        }
                    getPageChat(appendParams);
                    e.stopImmediatePropagation();
                });

                // scroll down on page chat
               /* if (is_LoadMore == 0) {
                    tiChat_jQuery("#chat_mob_main .panel-body").animate({ scrollTop: tiChat_jQuery("#chat_mob_main .panel-body ul").height() }, "fast");
                } else {
                    tiChat_jQuery('#chat_mob_main .panel-body').animate({ scrollTop: tiChat_jQuery("#chat_mob_main .panel-body li#chat_id_"+focus_id).offset().top }, "medium");
                    // tiChat_jQuery('.chatpage-windowContent .panel-body').animate({ scrollTop: $(".chatpage-windowContent .panel-body li#chat_id_186").offset().top }, "medium");
                }*/
            } else {
                //alert("no more messages for mobile===>")
                //alert(res_arr.length)
                tiChat_jQuery('#chat_mob_main #load_more_id_'+toId+' .load_more').remove();
                tiChat_jQuery('#chat_mob_main #load_more_id_'+toId+' .no_more_chat').remove();
                //tiChat_jQuery('.#chat_mob_main #load_more_id_'+toId+' .no_chat_found').remove();
                if (res_arr.length == 0) {
                    //alert("chat_mobile================>")
                    tiChat_jQuery('#chat_mob_main #load_more_id_'+toId).append('<span class="no_chat_found text-center">no messages</span>');
                } else {
                    //alert("chat_mobile================>")
                    tiChat_jQuery('#chat_mob_main #load_more_id_'+toId).append('<span class="no_more_chat text-center">no more messages</span>');
                }

                tiChat_jQuery('#chat_mob_main #load_more_id_'+toId+' .no_more_chat').css({ "color" : "#ccc" , "text-decoration" : "none", "display" : "block"});
                tiChat_jQuery('#chat_mob_main #load_more_id_'+toId+' .no_chat_found').css({ "color" : "#ccc" , "text-decoration" : "none", "display" : "block"});
            }

            // is Typing using socket
            tiChat_jQuery('#chat_input_'+toId).keypress(function(e){
                var toUserId    =   toId;
                var message     =   tiChat_jQuery('#chat_input_'+toId).val();
                var request     = {
                                    message  :  message,
                                    userId   :  userId,
                                    toId     :  toId,
                                    toName   :  toName,
                                };

                // Function to get typing notification
                chatTyping_request(request);

                // call save chat api on enter key press
                var sendChat_params = {
                                toId           : toId,
                                userProfilePic : userProfilePic,
                                chat_behaviour : "mobileChat"
                                }
                if (e.keyCode == 13) {
                    sendChat(sendChat_params);
                }
            });

            // Adding panel-body height
            var mainMenuDivHeight_mob           = tiChat_jQuery('.main_menu_div').height();
            var currentUserDivHeight_mob        = tiChat_jQuery('.chatmob-currentUserDiv').height();
            // var msgInputText_mob                = tiChat_jQuery('.panel-footer').height();
            var msgInputText_mob                = tiChat_jQuery('#chat_mob_main .panel-footer').height();
            //var footer_mob                      = tiChat_jQuery('.footer').height();
            var push_mob                        = tiChat_jQuery('.push').height();
            var windowHeight_mob                = tiChat_jQuery(window).height();
            var reductionTotal_mob              = mainMenuDivHeight_mob + currentUserDivHeight_mob + msgInputText_mob  + push_mob;
            var chatPanelHeight_mob             = windowHeight_mob - reductionTotal_mob;
            tiChat_jQuery("#chat_mob_main .panel-body").css("height",chatPanelHeight_mob);

            // Adding Scroll Style
            // tiChat_jQuery('#chat_mob_main .panel-body').jScrollPane();
            tiChat_jQuery('#chat_mob_main .panel-body').perfectScrollbar();

            // chat Page Panel Height
            //var chatpagePanelHeight     =   tiChat_jQuery('.chatpage-mainDiv').height() - ( tiChat_jQuery('.chatpage-currentUserDiv').height() + 2* tiChat_jQuery(".chatpage-windowSubtitle").height() + tiChat_jQuery(".chatpage-windowContent .panel-footer").height() );
           // tiChat_jQuery("#chat_mob_main .panel-body").css("height",chatpagePanelHeight+"px");


        });
    }

    /* ==================================================================================================================================
       Click PageChat send Button
    ==================================================================================================================================== */
    function mobChatSend(toId) {
        //alert("pageChatSend +++++++++++");
        var userName            =   viewerName;
        var userId              =   viewerId;
        var userProfilePic      =   viewerProfilePic;

        var toId                = toId;
        var sendChat_params = {
                                toId           : toId,
                                userProfilePic : userProfilePic,
                                chat_behaviour : "mobileChat"
                                }
        sendChat(sendChat_params);
    }

    /* ==================================================================================================================================
       Read Status Updation function
    ==================================================================================================================================== */

    function setReadStatus(fromId) {
        //alert("call readStatus???")
        tiChat_jQuery('#bold_chat_'+viewerId).css('font-weight', 'auto');

        var data = {
                            fromId  : fromId,
                            userId  : viewerId
                        };
        tiChat_jQuery.ajax({
            method    : 'POST',
            url       : server_base_url+"chat/updateReadStatus",
            data      : data,
        }).done(function(data) {
           // tiChat_jQuery("#ynadvmenu_ChatNotifyCount").html("");

           setNotification();
           listAllUsers_request();
        });
    }

/* ==================================================================================================================================
       Notification shoiwng api in mobile
    ================================ ==================================================================================================== */
    function setNotification() {
            //alert("setNotifictaion==========>")
            var data = {
                        fromId      :   viewerId,
                    };
            tiChat_jQuery.ajax({
                method    : 'POST',
                url       : server_base_url+"chat/getNotification",
                data      : data,
            }).done(function(data) {
                    var ntfnCount   =   data.result[0].count;
                    tiChat_jQuery("#ynadvmenu_ChatNotifyCount").css("display","block");
                    tiChat_jQuery("#ynadvmenu_ChatNotifyCount").html('');
                    if(ntfnCount!=0) {
                       // alert("ntfnCount not zerooooooooooo")
                        chatPage_mob_datas     =   JSON.parse(localStorage.getItem('chatMobile_data'));
                       // if(chatPage_mob_datas) {
                            //alert("have to append===========>")
                           tiChat_jQuery("#ynadvmenu_ChatNotifyCount").append('<span>'+ntfnCount+'</span>');
                        //}
                    }
            });
    }
/* ==================================================================================================================================
      click on each User from user list
    ==================================================================================================================================== */
    //tiChat_jQuery(document).on("click",".chatpage-usersListMainDiv .chatpage-eachUserList",function() {
    function listedUserClick(userId,userName,userProfilePic) {
       // var elementId           =   tiChat_jQuery(this).attr('id');
       // var splitElement        =   elementId.split("user_id^")[1];
         //   splitElement        =   splitElement.split("^");
        //tiChat_jQuery('#bold_chat_'+userId).css('font-weight', 'auto');

        var toId                =   userId;
        var toName              =   userName;
        var toProfilePic        =   userProfilePic;
        var focus_id            =   0;
        var page_type           =   "new";

        tiChat_jQuery('.chatpage-windowContent ul').html('');
        tiChat_jQuery('.chatpage-windowSubtitle').html('');

        tiChat_jQuery(".chatpage-dummyWindowContent").hide();

        localStorage.setItem('is_LoadMore',0);
        var chatPage_open_datas  = {
                                    toId            :  toId,
                                    toName          :  toName,
                                    toProfilePic    :  toProfilePic,
                                    focus_id        :  focus_id,
                                    page_type       :  page_type,

                                    is_LoadMore     :  0
                                    };
        // To get all page chat
        var appendParams = {
                            toId            :  toId,
                            toName          :  toName,
                            toProfilePic    :  toProfilePic,
                            focus_id        :  focus_id,
                            page_type       :  page_type,
                            is_LoadMore     :  0
                            }

         if(tiChat_DeviceType==1) {
             //alert("mobileee====>")
             var popup_status     =   'mobile';
             //localStorage.removeItem("chatPopup_open_datas");
             popUpChatClick(toId,toName,toProfilePic,popup_status);
             //window.location.href = baseUrl + '/tichat/singlechatmob';
             window.open(baseUrl + '/tichat/singlechatmob');
             //single_chat_mobile(appendParams);
         }else {
            localStorage.setItem('chatPage_open_datas', JSON.stringify(chatPage_open_datas));
            tiChat_jQuery("#mainChatIndiv").show();
            setReadStatus(toId,viewerId);
            getPageChat(appendParams);
        }
    //});
    }

/* ==================================================================================================================================
      Search in Users List
    ==================================================================================================================================== */
    function listUserSearch(name) {

            tiChat_jQuery('.chatpage-usersListMainDiv ul.search_listedusers').remove();
            tiChat_jQuery('.chatpage-usersListMainDiv ul.listedusers').remove();

            tiChat_jQuery('.chatpage-usersListMainDiv').append('<ul class="search_listedusers"></ul>');

            var nameString;
            var prefix = "^"+name.replace(/\s/g,'').toLowerCase();
            //haystack.startsWith(prefix); // false
            console.log("online users======================>")
            console.log(onlineUsersArray)
            if(listUsersArray){
                var searchListUsersArray    = [];
                tiChat_jQuery.each( listUsersArray, function( i, val ) {
                    //console.log("list user array ^^^^^^^^^^^^^^^^^^^^^val");
                    //console.log(val.username);
                    nameString   = val.username;
                    nameString   = nameString.replace(/\s/g,'').toLowerCase()
                    //console.log(nameString.indexOf(prefix));
                    //if(nameString.indexOf(prefix) === 0) {
                    //}
                    if (nameString.match(prefix) ) {
                       //console.log("If console");
                       searchListUsersArray.push(val);
                    }
                });


                for (var i=0; i < searchListUsersArray.length; i++) {
                    var searchUserId                =  searchListUsersArray[i].id.toString();
                    var searchUserName              =  searchListUsersArray[i].username;
                    var searchUserProfilePic        =  searchListUsersArray[i].profilePic;
                    var searchUserMsg               =  searchListUsersArray[i].last_msg;
                    var searchReadStatus            =  searchListUsersArray[i].readStatus;
                    var listUserId                  =   'listUser_'+searchUserId;
                     var sDate  =   searchListUsersArray[i].lastDate;
                         sDate  =   sDate.split('T');

                    if (onlineUsersArray.indexOf(searchUserId) != -1 ) {


                        tiChat_jQuery('.chatpage-usersListMainDiv ul.search_listedusers').append('<li onclick="listedUserClick(\''+searchUserId+'\',\''+searchUserName+'\',\''+searchUserProfilePic+'\')" id="user_id^'+searchUserId+'^'+searchUserName+'^'+searchUserProfilePic+'" class="col-md-12 listedUser_'+searchUserId+' chatpage-eachUserList col-md-12 yes-padding">'+
                                                                    '<a>'+
                                                                        '<div class="col-md-3 col-sm-3 col-xs-3 chat_userscontentavatar">'+
                                                                            '<img class="user_image-sm" src="'+searchUserProfilePic+'" onerror="imgError(this);"/>'+
                                                                            '<span class="online-offline-symbol online-symbol chat_userscontentdot"></span>'+
                                                                        '</div>'+
                                                                        '<div class="col-md-9 col-sm-9 col-xs-9 chat_chatboxDisplayDetails" style="border-bottom: 1px solid #d2d2d2;">'+
                                                                            '<div class="chat_userdisplayname">'+searchUserName+'</div>'+
                                                                            '<div class="chat_displayLastMsg">'+ellipsify(searchUserMsg)+'</div>'+
                                                                            '<div class="chatpage_arrowright">'+sDate[0]+
                                                                            '</div>'+
                                                                        '</div>'+
                                                                    '</a>'+
                                                                '</li>');
                       if((searchReadStatus==0) && (searchListUsersArray[i].id != searchListUsersArray[i].toId))  {

                                tiChat_jQuery('.search_listedusers .chat_chatboxDisplayDetails').css("font-weight","Bold");
                       }else {
                                tiChat_jQuery('.search_listedusers .chat_chatboxDisplayDetails').css("font-weight","auto");
                       }

                    } else {

                        tiChat_jQuery('.chatpage-usersListMainDiv ul.search_listedusers').append('<li onclick="listedUserClick(\''+searchUserId+'\',\''+searchUserName+'\',\''+searchUserProfilePic+'\')" id="user_id^'+searchUserId+'^'+searchUserName+'^'+searchUserProfilePic+'" class="col-md-12 listedUser_'+searchUserId+' chatpage-eachUserList col-md-12 yes-padding">'+
                                                    '<a>'+
                                                        '<div class="col-md-3 col-sm-3 col-xs-3 chat_userscontentavatar">'+
                                                            '<img class="user_image-sm" src="'+searchUserProfilePic+'" onerror="imgError(this);"/>'+
                                                            '<span class="online-offline-symbol offline-symbol chat_userscontentdot"></span>'+

                                                        '</div>'+
                                                        '<div class="col-md-9 col-sm-9 col-xs-9 chat_chatboxDisplayDetails" style="border-bottom: 1px solid #d2d2d2;">'+
                                                            '<div class="chat_userdisplayname">'+searchUserName+'</div>'+
                                                            '<div class="chat_displayLastMsg">'+ellipsify(searchUserMsg)+'</div>'+
                                                            '<div class="chatpage_arrowright">'+sDate[0]+
                                                            '</div>'+
                                                        '</div>'+
                                                    '</a>'+
                                                '</li>');
                      if((searchReadStatus==0) && (searchListUsersArray[i].id != searchListUsersArray[i].toId))  {

                              tiChat_jQuery('.search_listedusers .chat_chatboxDisplayDetails').css("font-weight","Bold");

                       }else {

                              tiChat_jQuery('.search_listedusers .chat_chatboxDisplayDetails').css("font-weight","auto");
                       }
                    }
                }
                // Adding Scroll Style
                // tiChat_jQuery('.chatpage-usersListMainDiv').jScrollPane();
                tiChat_jQuery('.chatpage-usersListMainDiv').perfectScrollbar();
            }
    }
