tiChat_jQuery(document).ready(function(){
    var ntfnCount                   = 0;

    var chatPopup_open_datas = JSON.parse(localStorage.getItem('chatPopup_open_datas'));
    console.log("chatPopup_open_datas <<<<<<<<<<<<<<<<<<<<<<<<---------------------->>>>>>>>>>>>>>>>>>>");
    console.log(chatPopup_open_datas);
    console.log("chatPopup_open_datas <<<<<<<<<<<<<<<<<<<<<<<<---------------------->>>>>>>>>>>>>>>>>>>");
    if(viewerId) {
/* ==================================================================================================================================
 append Structure to body and list all users
==================================================================================================================================== */
                //appendBodyInitialStructure();
                if(tiChat_DeviceType==1) {
                    setNotification();
                    //appendBodyInitialStructure();
                    var chatPage_mob_datas;
                    //localStorage.removeItem("chatPopup_open_datas");
                    if(localStorage.getItem('chatMobile_data')) {

                        chatPage_mob_datas     =   JSON.parse(localStorage.getItem('chatMobile_data'));
                    }

                    var url 	 = document.URL;
                        url 	 = url.split('/');
                    var inboxUrl =  url; 
                        url 	 = url.pop();
                       
                    if(url=='singlechatmob') {
                       
                      /* tiChat_jQuery('.layout_page_header').css("display","none");
                       tiChat_jQuery('body').css("border-bottom","1px solid #ccc");
                       //tiChat_jQuery('.wrapper #global_header').css('border-bottom','none','important');
                       tiChat_jQuery('.footer').css("display","none");
                       tiChat_jQuery('#global_wrapper').css("padding","0");*/
                       tiChat_jQuery('.footer').css("display","none");
                       
                        appendChatMobile();
                         if (chatPage_mob_datas.length) {
                            tiChat_jQuery.each( chatPage_mob_datas, function( i, val ) {
                                //setReadStatus(val.toId)
                                single_chat_mobile(val);
                            });
                        }
                    } else {
                        //============chat Inbox in mobile===============
                       //inboxUrl	=	inboxUrl[3]+'/inbox';     
                        appendBodyInitialStructure();
                        /*if(inboxUrl=='tichat/inbox') {
							tiChat_jQuery('.listUserSearch').css("display","none");
							var element ='<div class="listUserSearch inboxAppndSearch">';
								 element +='<span class="fa fa-search chatSearchIcon"></span>';
								 element +='<input id="listusersearchId" type="text" onkeyup="listUserSearch(this.value)" class="form-control input-sm chatSearch" placeholder="search"/>';
								 element +='<span title="Close"  class="chatSearchCloseBtn pull-right hand-symbol">';
							element +='X</a></div>';
							tiChat_jQuery('.sub_header_dropdown').append(element);
						}*/
                        tiChat_jQuery("#mainChatIndiv").hide();
                        localStorage.removeItem("chatMobile_data");
                    }
                } else {
                     appendBodyInitialStructure();
                     setNotification(viewerId);
                }

                setTimeout(function(event){
                    // var usersListHeight  =   parseInt(tiChat_jQuery('.chatpage-mainDiv').css("height")) - parseInt(tiChat_jQuery('.chatpage-userNameMainDiv').css("height"))
                    var usersListHeight  =   parseInt(tiChat_jQuery('.chatpage-windowContentInner').css("height")+1);
                    //alert("usersListHeight  "+ usersListHeight)
                    // tiChat_jQuery(".chatpage-usersListMainDiv").height(usersListHeight + 'px');
                    tiChat_jQuery(".chatpage-mainDiv .chatpage-usersListMainDiv").css("height",usersListHeight+"px");
                }, 500);
                
                 /*setTimeout(function(event){
                    // var usersListHeight  =   parseInt(tiChat_jQuery('.chatpage-mainDiv').css("height")) - parseInt(tiChat_jQuery('.chatpage-userNameMainDiv').css("height"))
                    var usersListHeight  =   parseInt(tiChat_jQuery('.chatpage-windowContentInner').css("height")) + 1;
                    var page_height		 =   parseInt(tiChat_jQuery(window).height());
                    
                    alert(page_height)
                    //tiChat_jQuery("#chatpage-id .chatpage-mainDiv .chatpage-usersListMainDiv").css("height",page_height+"px");
                    //tiChat_jQuery("#chatpage-id .chatpage-mainDiv .chatpage-dummyWindowContent").css("height",page_height+"px");
                    //tiChat_jQuery("#chatpage-id .chatpage-mainDiv .chatpage-windowContent .panel-body").css("height",page_height_chat+"px !important");
                    tiChat_jQuery("#chatpage-id .chatpage-mainDiv").css("height",page_height+"px");
                }, 500);*/

                listAllUsers_request();

                if(tiChat_jQuery(".chatpage-mainDiv").length == 0) {
                   tiChat_jQuery("body .popup-box").css("visibility","visible");
                } else {
                    tiChat_jQuery("body .popup-box").css("visibility","hidden");
                }

/* ==================================================================================================================================
      Refreshing page chat
    ==================================================================================================================================== */
        setTimeout(function(e){
            if(localStorage.getItem('chatPage_open_datas')) {
                localStorage.setItem('is_LoadMore', 0);
                var chatPage_open_datas     =   JSON.parse(localStorage.getItem('chatPage_open_datas') );
              if(tiChat_DeviceType == 2) {
					getPageChat(chatPage_open_datas);
                tiChat_jQuery(".chatpage-dummyWindowContent").hide();
                setTimeout(function(event){
                    tiChat_jQuery(".chatpage-windowContent .panel-body").animate({ scrollTop: tiChat_jQuery(".chatpage-windowContent .panel-body ul").height() }, "fast");
                }, 1000);
			  }
            }


/* ==================================================================================================================================
      Refreshing popup chat
    ==================================================================================================================================== */

                if(localStorage.getItem('chatPopup_open_datas')) {
                    var chatPopup_open_datas = JSON.parse(localStorage.getItem('chatPopup_open_datas'));
                    console.log("chatPopup_open_datas <<<<<<<<<<<<<<<<<<<<<<<<---------------------->>>>>>>>>>>>>>>>>>>");
                    console.log(chatPopup_open_datas);
                    console.log("chatPopup_open_datas <<<<<<<<<<<<<<<<<<<<<<<<---------------------->>>>>>>>>>>>>>>>>>>");
                    if (chatPopup_open_datas.length) {
                        tiChat_jQuery.each( chatPopup_open_datas, function( i, val ) {
                            console.log(i);
                            if(tiChat_DeviceType == 2) {
                                //setReadStatus(appendParams.toId)
                                register_popup(val);
                                setTimeout(function(event){
                                    tiChat_jQuery(".popup_box_"+val.toId+ " .panel-body").animate({ scrollTop: tiChat_jQuery(".popup_box_"+val.toId+" .panel-body ul").height() }, "fast");
                                }, 1000);
                            }
                        });
                    }
                } else {
                    // alert("no data");
                }
        }, 2000);

            tiChat_jQuery(document).on("click",".msgNtfnIcon",function() {
               localStorage.removeItem("chatPage_open_datas");
            });

/* ==================================================================================================================================
      Logout Click
    ==================================================================================================================================== */
            tiChat_jQuery(document).on("click",".tichatLogout",function() {

                    var user_id = viewerId;

                    io.socket.request({
                        method: 'POST',
                        url: '/socketSettings/socketDisConnection',
                        data: {
                                userId : user_id
                            },
                            /*headers  : {
                                        },*/
                            function (resData, jwres) {

                            }
                    });

                    localStorage.removeItem("lowest_chat_id");
                    localStorage.removeItem("is_LoadMore");
                    localStorage.removeItem("last_iteration_i");
                    localStorage.removeItem("chatPage_open_datas");
                    localStorage.removeItem("chatPopup_open_datas");
                    localStorage.removeItem("chatMobile_data");
                    localStorage.removeItem("onlineUserList");
                    localStorage.removeItem("ti_chat_fromUserInCall");
                    localStorage.removeItem("ti_chat_fromSocketId");
                    localStorage.removeItem("ti_chat_calltoId");
                    localStorage.removeItem("callType");

            });

    }

});
