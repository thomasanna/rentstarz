// var JQCall      =   jQuery.noConflict();
var currentBrowser  =   "";
var fromBrowser     =   "";
/* =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
                                            Call - MODAL Starts
 * =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* */

// <!-- =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* caller INITIAL CALL MODAL =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* -->
var modalElement        =   '<div id="callModals">';
    modalElement        =   '<div class="singleCallModal modal fade" id="callerInitiateCallModal" role="dialog">';
    modalElement        +=      '<div class="modal-dialog">';
    modalElement        +=          '<div class="modal-content">';
    modalElement        +=              '<div class="modal-body">';
    modalElement        +=                  '<div class="call-hide col-md-12 col-sm-12 col-xs-12 text-center" id="userNameInitiate"></div>';
    modalElement        +=                  '<div class="text-center" id="initiateImgDiv"></div>';
    modalElement        +=                  '<div class="localRemoteVideo"></div>';
    //Timer
    modalElement        +=                  '<div id="callTimerInitiate" class="callTimer text-center"><time>00:00:00</time></div>';
    // modalElement        +=                 '<audio class="callRingtone" controls="controls">';
    modalElement        +=                 '<audio id="diallerCallRing">';
    modalElement        +=              '</div>';
    modalElement        +=              '<div class="modal-footer">';
    modalElement        +=                  '<div class="text-center">';
    modalElement        +=                      '<div class="acceptDeclineBtnDiv">';
    modalElement        +=                          '<button type="button" class="btn btn-default modal-close declineBtn" title="End Call">';
    modalElement        +=                              '<span><i class="fa fa-phone phoneImgSize" aria-hidden="true"></i></span>';
    modalElement        +=                          '</button>';
    modalElement        +=                      '</div>';
    modalElement        +=                  '</div>';
    modalElement        +=                  '<div class="disconnectText"></div>';
    // modalElement        +=                  '<div class="connectText"></div>';
    modalElement        +=              '</div>';
    modalElement        +=          '</div>';
    modalElement        +=      '</div>';
    modalElement        +=  '</div>';
//<!-- =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* caller INITIAL CALL MODAL =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* -->

//<!-- =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* CALL Accept MODAL =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* -->
    //modalElement        +=  '<div id="initiateAcceptCall" data-toggle="modal" data-target="#initiateAcceptCallModal"></div>';

    modalElement        +=  '<div class="singleCallModal modal fade" id="initiateAcceptCallModal" role="dialog">';
    modalElement        +=      '<div class="modal-dialog">';
    modalElement        +=          '<div class="modal-content">';
    modalElement        +=              '<div class="modal-body">';
    modalElement        +=                  '<div class="call-hide col-md-12 col-sm-12 col-xs-12 text-center" id="userNameAccept"></div>';
    //
    modalElement        +=                  '<div class="localRemoteVideo"></div>';
    modalElement        +=                  '<div id="ansImgDiv" class="text-center"></div>';
    //Timer
    modalElement        +=              '<div id="callTimerAnswer" class="callTimer text-center"><time>00:00:00</time></div>';
    // modalElement        +=                 '<audio class="callRingtone" controls="controls">';
    modalElement        +=                 '<audio id="receiverCallRing">';
    modalElement        +=              '</div>';
    modalElement        +=              '<div class="modal-footer">';
    modalElement        +=                  '<div class="text-center">';
    modalElement        +=                      '<div class="acceptDeclineBtnDiv">';
    modalElement        +=                          '<button id="acceptCallId" class="btn btn-primary acceptBtn" data-pausetext="Pause" data-resumetext="Resume" onclick="initiateCallBrowserCheck()" title="Accept Call">';
    modalElement        +=                              '<span><i class="fa fa-phone phoneImgSize" aria-hidden="true"></i></span>';
    modalElement        +=                          '</button>';
    modalElement        +=                          '<button id="declineCallId" class="btn btn-primary modal-close declineBtn" title="End Call">';
    modalElement        +=                              '<span><i class="fa fa-phone phoneImgSize" aria-hidden="true"></i></span>';
    modalElement        +=                          '</button>';
    modalElement        +=                      '</div>';
    modalElement        +=                  '</div>';
    modalElement        +=                  '<div class="disconnectText"></div>';
    //modalElement        +=                  '<div class="connectText"></div>';
    modalElement        +=              '</div>';
    modalElement        +=          '</div>';
    modalElement        +=      '</div>';
    modalElement        +=  '</div>';
//<!-- =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* CALL Accept MODAL =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* -->

//<!-- =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* Alert CALL MODAL =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* -->
    //<!-- Modal -->
    modalElement        +=  '<div class="singleCallModal modal fade" id="alertCallModal" role="dialog">';
    modalElement        +=      '<div class="modal-dialog">';
    modalElement        +=          '<div class="modal-content">';
    modalElement        +=              '<div class="modal-header">';
    modalElement        +=                  '<button type="button" class="close" data-dismiss="modal">&times;</button>';
    modalElement        +=              '</div>';
    modalElement        +=              '<div class="modal-body">';
    modalElement        +=              '<div class="disconnectText"></div>';
    modalElement        +=              '</div>';
    modalElement        +=              '<div class="modal-footer">';

    modalElement        +=              '</div>';
    modalElement        +=          '</div>';
    modalElement        +=      '</div>';
    modalElement        +=  '</div>';
//<!-- =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* Alert CALL MODAL =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* -->

modalElement        +='</div>';

    tiChat_jQuery('body').append(modalElement);

    //Adding dynamic height to call Modal
    //var windowHeight        =  tiChat_jQuery(window).height();
    var callModalHeight;
    if( (tiChat_jQuery(window).width()) < 756 ) {
        callModalHeight     =  tiChat_windowHeight - 20 +"px";
    } else {
        callModalHeight     =  tiChat_windowHeight - 60 +"px";
    }
    tiChat_jQuery(".singleCallModal .modal-content").css("max-height",callModalHeight);
    // tiChat_jQuery('.singleCallModal .modal-content').perfectScrollbar();
/* =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
                                            Call - MODAL Ends
 * =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* */

/* =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
                                            Browser identification
 * =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* */
 // Opera 8.0+
var isOpera = (!!window.opr && !!opr.addons) || !!window.opera || navigator.userAgent.indexOf(' OPR/') >= 0;

// Firefox 1.0+
var isFirefox = typeof InstallTrigger !== 'undefined';

// Safari 3.0+ "[object HTMLElementConstructor]"
var isSafari = /constructor/i.test(window.HTMLElement) || (function (p) { return p.toString() === "[object SafariRemoteNotification]"; })(!window['safari'] || (typeof safari !== 'undefined' && safari.pushNotification));

// Internet Explorer 6-11
var isIE = /*@cc_on!@*/false || !!document.documentMode;

// Edge 20+
var isEdge = !isIE && !!window.StyleMedia;

// Chrome 1+
var isChrome = !!window.chrome && !!window.chrome.webstore;

// Blink engine detection
var isBlink = (isChrome || isOpera) && !!window.CSS;

if(isChrome){
    currentBrowser  =  "chrome";
} else if(isFirefox){
    currentBrowser  =  "firefox";
} else if(isSafari){
    currentBrowser  =  "safari";
} else if(isIE){
    currentBrowser  =  "ie";
} else if(isEdge){
    currentBrowser  =  "Edge";
}else if(isOpera){
    currentBrowser  =  "opera";
}

/* =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
                                            Browser identification
 * =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* */

// var isIOS = /iPad|iPhone|iPod/.test(navigator.userAgent) && !window.MSStream;

tiChat_jQuery( document ).ready(function() {
        if(tiChat_isIOS) {
            console.log("IOS mobile");
        } else {
            window.enableAdapter = true;
            // localStorage.setItem('ti_chat_fromUserInCall', false);
            var ti_chat_calltoId  =  localStorage.getItem('ti_chat_calltoId');
            if( ti_chat_calltoId == "" || typeof(ti_chat_calltoId) == "undefined" ) {

            } else {
                var toId  = localStorage.getItem('ti_chat_calltoId');
                updateCallStatus(toId);
                localStorage.setItem('ti_chat_calltoId', "");
            }
        }
});
if(tiChat_isIOS) {
    console.log("IOS mobile");
} else {
    //window.enableAdapter = true;
    /** browser dependent definition are aligned to one and the same standard name **/

    // navigator.getUserMedia          = navigator.getUserMedia || navigator.mozGetUserMedia || navigator.webkitGetUserMedia;
    navigator.getUserMedia          = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia;

    window.RTCPeerConnection        = window.RTCPeerConnection || window.mozRTCPeerConnection || window.webkitRTCPeerConnection;
    window.RTCIceCandidate          = window.RTCIceCandidate || window.mozRTCIceCandidate || window.webkitRTCIceCandidate;
    window.RTCSessionDescription    = window.RTCSessionDescription || window.mozRTCSessionDescription || window.webkitRTCSessionDescription;
    window.SpeechRecognition        = window.SpeechRecognition || window.webkitSpeechRecognition || window.mozSpeechRecognition
                                        || window.msSpeechRecognition || window.oSpeechRecognition;
}

/* =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
                                            Call - Timer Starts
 * =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* */

    var callTimerInitiate   =   document.getElementById('callTimerInitiate'),
        callTimerAnswer     =   document.getElementById('callTimerAnswer'),
        callTimerSeconds    =   0,
        callTimerMinutes    =   0,
        callTimerHours      =   0,
        callTimerT;

    function callTimerAdd() {
        callTimerSeconds++;
        if (callTimerSeconds >= 60) {
            callTimerSeconds = 0;
            callTimerMinutes++;
            if (callTimerMinutes >= 60) {
                callTimerMinutes = 0;
                callTimerHours++;
            }
        }
                callTimerInitiate.textContent  =    (callTimerHours ? (callTimerHours > 9 ? callTimerHours : "0" + callTimerHours) : "00") + ":" +
                                                    (callTimerMinutes ? (callTimerMinutes > 9 ? callTimerMinutes : "0" + callTimerMinutes) : "00") + ":" +
                                                    (callTimerSeconds > 9 ? callTimerSeconds : "0" + callTimerSeconds);
                callTimerAnswer.textContent    =    (callTimerHours ? (callTimerHours > 9 ? callTimerHours : "0" + callTimerHours) : "00") + ":" +
                                                    (callTimerMinutes ? (callTimerMinutes > 9 ? callTimerMinutes : "0" + callTimerMinutes) : "00") + ":" +
                                                    (callTimerSeconds > 9 ? callTimerSeconds : "0" + callTimerSeconds);
        callTimer();
    }
    function callTimer() {
        callTimerT = setTimeout(callTimerAdd, 1000);
    }

        var localVideoStream            =   null,
            localVideo                  =   null,
            remoteVideo                 =   null;
        var peerConn                    =   null,
            peerConnCfg                 =   {'iceServers':
                                                [{'url': 'stun:stun.services.mozilla.com'},
                                                {'url': 'stun:stun.l.google.com:19302'}]
                                            };
        var toUserId                    =   "";
        var initiateAcceptCall_data     =   "";
        var socketStatus                =   "";
        var notAnswerTimer;
        var singleCallModalHideTimer;
        var cancelCallTimer;
        var connectTextTimer;
        //var diallerCallRing             =   new Audio('../application/modules/User/externals/chat/wav/phone_ringing.wav');
        //var receiverCallRing            =   new Audio('../application/modules/User/externals/chat/wav/phone_ringing_2.wav');
        //var diallerCallRing       =   ' <audio controls="controls" autoplay src="../application/modules/User/externals/chat/wav/phone_ringing.wav"> ';
        //var receiverCallRing  =   ' <audio controls="controls" autoplay src="../application/modules/User/externals/chat/wav/phone_ringing_2.wav"> ';


       /* if(tiChat_DeviceType == 1) {
            //diallerCallRing             =   new Audio('../application/modules/User/externals/chat/wav/callerTune.mp3');
            //receiverCallRing            =   new Audio('../application/modules/User/externals/chat/wav/calleetune.mp3');


        }*/
        var t;

    // function to initalize peerconnection
    function prepareCall() {
          // console.log("prepareCall ------>>>>  ");
          peerConn = new RTCPeerConnection(peerConnCfg);
          // send any ice candidates to the other peer
          peerConn.onicecandidate = onIceCandidateHandler;
          // once remote stream arrives, show it in the remote video element
          //peerConn.onaddstream = onAddStreamHandler;
    };

    // function used inside callerInitiateCall
    function initiate_api_call_fn(data) {
            //diallerCallRing.play();
            //document.getElementById('diallerCallRing').currentTime = 0;
            //document.getElementById('receiverCallRing').currentTime = 0;
            document.getElementById('diallerCallRing').src      = '../application/modules/User/externals/chat/wav/alarmxperia.mp3';
            document.getElementById('receiverCallRing').src     = '../application/modules/User/externals/chat/wav/alarmxperia.mp3';
            if(tiChat_DeviceType == 1) {
                if(isChrome){
                    // alert("Its chrome")
                    document.getElementById('diallerCallRing').src = 'http://www.jivebird.com/media/slidersongs/valentine.m4a';
                    document.getElementById('receiverCallRing').src = 'http://www.jivebird.com/media/slidersongs/valentine.m4a';
                }
            }
            //document.querySelector('.callRingtone').src = '../application/modules/User/externals/chat/wav/phone_ringing.wav'
            document.getElementById('diallerCallRing').play();
            //alert(document.querySelector('.callRingtone').play)
            //document.querySelector('.callRingtone').autoplay = true;
            io.socket.request({
                method: 'POST',
                url: '/audioVideoCall/initiateCall',
                data: data,
                contentType   : false,
                function (resData, jwres) {
                }
            });
    }

    /*document.getElementById('diallerCallRing').addEventListener("playing", function(){
        //alert("rdfse")
        if(tiChat_DeviceType == 1) {
                if(isChrome){
                    alert("rdfse")
                    this.play();
                }
        }
    },false);*/

    // Request call to accept
    function callerInitiateCall(toId,toName,callType,profilePic) {
            // console.log("************************** callerInitiateCall *********************");
            //Clearing noAnswer timing
            clearTimeout(notAnswerTimer);
            clearTimeout(cancelCallTimer);
            clearTimeout(singleCallModalHideTimer);
            clearTimeout(connectTextTimer);

            // remove call accept message
            tiChat_jQuery('.disconnectText').html('');
            tiChat_jQuery("#videopaymentModal").modal('hide');

            // Hide timer in callerInitiateCall
            tiChat_jQuery('#callerInitiateCallModal .modal-body #callTimerAnswer').css("display","none");
            tiChat_jQuery('#callerInitiateCallModal .modal-body #callTimerInitiate').css("display","none");

            toUserId                =   toId;
            toUserName              =   toName;
            var userId              =   viewerId;
            var userName            =   viewerName;
            var fromUserImage       =   viewerProfilePic;

            if(tiChat_isIOS) {
                tiChat_jQuery('#alertCallModal').modal('show');
                tiChat_jQuery('.disconnectText').html("");
                tiChat_jQuery('.disconnectText').append('<i style="color: black"> Your phone doesn\'t support this call and video feature </i>');
            } else {
                // tiChat_Loadjscssfile('https://cdnjs.cloudflare.com/ajax/libs/adapterjs/0.15.0/adapter.min.js','js');
                if(socketStatus) {
                        if(tiChat_jQuery(".offlineCallClick").length) { // Offline Call click
                                // Showing the alert Modal
                                tiChat_jQuery('#alertCallModal').modal('show');

                                // Online / Offline Click
                                //if(localStorage.getItem('chatPage_open_datas')) {
                                    //var chatPage_open_datas     =   JSON.parse(localStorage.getItem('chatPage_open_datas') );
                                    //chatPage_open_datas.toId
                                    // Adding Disconnect Messages
                                    tiChat_jQuery('.disconnectText').html("");
                                    tiChat_jQuery('.disconnectText').append('<i style="color:black">'+toUserName+' is currently offline.</br> You cannot make a call or video interview now. Leave a message.</i>');
                                //}
                        } else {
                                if(callType == "video" && viewer_profile_type == "landlord" && user_premiumLevelProvision == 2 && viewer_package_type == '' && viewer_video_payment == "not_paid") {
                                            tiChat_jQuery("#videopaymentModal").modal('show');
                                } else {
                                        localStorage.setItem('ti_chat_calltoId', toId);
                                        localStorage.setItem('callType', callType);

                                        // Enable call buttons
                                        tiChat_jQuery('.declineBtn').attr('disabled',false);
                                        tiChat_jQuery('.acceptBtn').attr('disabled',false);
                                        tiChat_jQuery('.muteBtn').attr('disabled',false);

                                        tiChat_jQuery('.acceptDeclineBtnDiv .muteBtn').remove();

                                        // Hide Only callee Image and name on second call without refresh
                                        tiChat_jQuery('#initiateImgDiv').css("display","none");

                                        // Showing the Modal
                                        tiChat_jQuery('#callerInitiateCallModal').modal('show');

                                        // Hide Webcam not available
                                        tiChat_jQuery('.disconnectText').html('');

                                        //Removing cut part from decline button
                                        tiChat_jQuery('.declineBtn span').removeClass("phoneEnd");

                                        // Show Image and name of Caller aswellas Callee
                                        tiChat_jQuery('#userNameInitiate').css("display","block");

                                        // Adding caller's and receiver's image & name
                                        var caller_initiate_element = '<div class="col-md-4 col-sm-4 col-xs-4">';
                                            caller_initiate_element += '<div class="pull-right">';
                                            caller_initiate_element += '<div id="usefromProfileImage"><img class="user_image-sm profileImage" style="" src="'+ fromUserImage +'" onerror="imgError(this);" title="'+userName+'"></div>';
                                            caller_initiate_element += '<div id="fromUsername">'+userName+'</div>';
                                            caller_initiate_element += '</div>';
                                            caller_initiate_element += '</div>';
                                            caller_initiate_element += '<div class="col-md-4 col-sm-4 col-xs-4" style="margin-top:35px;">';
                                            caller_initiate_element += '<div><img style="width:100%;" src="application/modules/User/externals/images/745.gif"  title=""></div>';
                                            caller_initiate_element += '</div>';
                                            caller_initiate_element += '<div class="col-md-4 col-sm-4 col-xs-4">';
                                            caller_initiate_element += '<div id="userProfileImage"><img class="user_image-sm profileImage" style="" src="'+ profilePic +'" onerror="imgError(this);" title="'+toName+'"></div>';
                                            caller_initiate_element += '<div  id="fromUsername">'+toName+'</div>';
                                            caller_initiate_element += '</div>';
                                        tiChat_jQuery('#userNameInitiate').html("");
                                        tiChat_jQuery('#userNameInitiate').append(caller_initiate_element);

                                        // Adding modal-close class to modal-backdrop
                                        tiChat_jQuery('.singleCallModal .modal-backdrop').addClass("modal-close");

                                        var data = {
                                                        toId         : toUserId,
                                                        fromId       : userId,
                                                        fromName     : userName,
                                                        callType     : callType,
                                                        fromImage    : fromUserImage,
                                                        toProfilePic : profilePic,
                                                        toName       : toName,
                                                        fromBrowser  : currentBrowser
                                                   };

                                        if(callType=='audio') {
                                                // alert("audio -- from caller side");
                                                navigator.getUserMedia({ "audio": true, "video": false }, function (stream) {
                                                    localVideoStream  = stream;
                                                    if(localVideoStream == "" || localVideoStream == null) {
                                                        // Showing the alert Modal
                                                        tiChat_jQuery('#alertCallModal').modal('show');
                                                        tiChat_jQuery('.disconnectText').html("");
                                                        tiChat_jQuery('.disconnectText').append('<i style="color:black">Native device media streaming (getUserMedia) not supported in this browser.</i>');
                                                    } else {
                                                        tiChat_jQuery('.localRemoteVideo').css({ 'visibility' : 'hidden'});

                                                        // calling external function
                                                        initiate_api_call_fn(data);
                                                    }
                                                }, function(error) {
                                                        tiChat_jQuery('#acceptCallId').css("display","none");

                                                        // Adding Message to disconnectText
                                                        tiChat_jQuery('.disconnectText').html('');
                                                        tiChat_jQuery('.disconnectText').append('<i>Allow permission to access your camera and/or microphone</i>');

                                                        tiChat_jQuery('.declineBtn span').removeClass("phoneEnd");
                                                        // Close the ring tone
                                                        document.getElementById('diallerCallRing').pause();
                                                        document.getElementById('diallerCallRing').pause();
                                                        //diallerCallRing.pause();
                                                        //receiverCallRing.pause();

                                                        var cancelParam  = {
                                                            cancelType : "error"
                                                            }
                                                        cancelCallTimer  = setTimeout(
                                                                              function() {
                                                                                    cancelCall(cancelParam);
                                                                            },4000);
                                                });

                                        }else if(callType=='video') {
                                                // alert("video -- from caller side");
                                                tiChat_jQuery('.localRemoteVideo').css({ 'visibility' : 'visible'});
                                                navigator.getUserMedia({ "audio": true, "video": true }, function (stream) {
                                                    if (stream.getVideoTracks().length > 0) {
                                                        //webCamStat = true;
                                                        localVideoStream  = stream;
                                                        if(localVideoStream == "" || localVideoStream == null) {
                                                            // alert("localVideoStream == null");
                                                            // Showing the alert Modal
                                                            tiChat_jQuery('#alertCallModal').modal('show');
                                                            tiChat_jQuery('.disconnectText').html("");
                                                            tiChat_jQuery('.disconnectText').append('<i style="color:black">Native device media streaming (getUserMedia) not supported in this browser.</i>');
                                                        } else {
                                                            tiChat_jQuery('.localRemoteVideo').css({ 'visibility' : 'visible'});

                                                            //calling external function
                                                            initiate_api_call_fn(data);
                                                        }
                                                    } else {
                                                        tiChat_jQuery('.localRemoteVideo').css({ 'visibility' : 'hidden'});

                                                        // Adding Webcam not available message
                                                        tiChat_jQuery('.disconnectText').html('');
                                                        tiChat_jQuery('.disconnectText').append('<i>Webcam is not available!</i>');

                                                        tiChat_jQuery('.declineBtn span').addClass("phoneEnd");
                                                        // Disable call buttons
                                                        tiChat_jQuery('.declineBtn').attr('disabled',true);
                                                        tiChat_jQuery('.acceptBtn').attr('disabled',true);
                                                        tiChat_jQuery('.muteBtn').attr('disabled',true);

                                                        // Close the ring tone
                                                        //diallerCallRing.pause();
                                                        //receiverCallRing.pause();
                                                        document.getElementById('diallerCallRing').pause();
                                                        document.getElementById('receiverCallRing').pause();

                                                        singleCallModalHideTimer  = setTimeout(
                                                                                      function() {
                                                                                            tiChat_jQuery('.singleCallModal').modal('hide');
                                                                                    },3000);

                                                    }
                                                }, function(error) {

                                                    console.log(error);
                                                    tiChat_jQuery('.localRemoteVideo').css({ 'visibility' : 'hidden'});

                                                    // Adding Webcam not available message
                                                    tiChat_jQuery('.disconnectText').html('');
                                                    tiChat_jQuery('.disconnectText').append('<i>Allow permission to access your camera and/or microphone</i>');

                                                    tiChat_jQuery('.declineBtn span').addClass("phoneEnd");
                                                    // Disable call buttons
                                                    tiChat_jQuery('.declineBtn').attr('disabled',true);
                                                    tiChat_jQuery('.acceptBtn').attr('disabled',true);
                                                    tiChat_jQuery('.muteBtn').attr('disabled',true);

                                                    // Close the ring tone
                                                    //diallerCallRing.pause();
                                                    //receiverCallRing.pause();
                                                    document.getElementById('diallerCallRing').pause();
                                                    document.getElementById('receiverCallRing').pause();

                                                    singleCallModalHideTimer  = setTimeout(
                                                                                  function() {
                                                                                        tiChat_jQuery('.singleCallModal').modal('hide');
                                                                                },4000);
                                                });

                                        }
                                        notAnswerTimer = setTimeout(
                                          function() {
                                                // alert("Entered Timer part");
                                                //console.log("Entered Timer part")
                                                //console.log(peerConn)
                                                if(!peerConn) {
                                                    // var ti_chat_fromUserInCall  =  localStorage.getItem('ti_chat_fromUserInCall').toString();
                                                    // console.log(ti_chat_fromUserInCall);
                                                    // if(ti_chat_fromUserInCall == "false" || !ti_chat_fromUserInCall) {
                                                        // Close the ring tone
                                                        //diallerCallRing.pause();
                                                        //receiverCallRing.pause();
                                                        document.getElementById('diallerCallRing').pause();
                                                        document.getElementById('receiverCallRing').pause();
                                                        tiChat_jQuery('.disconnectText').append('<i>No answer</i>');
                                                        var cancelParam  = {
                                                                    cancelType : "noAnswerTimer"
                                                            }
                                                        cancelCallTimer  = setTimeout(
                                                                              function() {
                                                                                    cancelCall(cancelParam);
                                                                            },2000);
                                                    // }
                                                }
                                        },30000); //
                                }
                            // }
                        } //online click
                } else {
                    // Showing the alert Modal
                    tiChat_jQuery('#alertCallModal').modal('show');

                    tiChat_jQuery('.disconnectText').html("");
                    tiChat_jQuery('.disconnectText').append('<i> No network. Please try again </i>');
                }
            }

    }

    // Checking the browser is eligible to call
    function initiateCallBrowserCheck() {
        console.log("fromBrowser from Socket ------>>>>"+fromBrowser);
        console.log("initiateAcceptCall_data ------>>>>"+initiateAcceptCall_data.toId);
        var userId                  =   viewerId;
        var userName                =   viewerName;
        var fromUserImage           =   viewerProfilePic;
        var currentSocketId         =  localStorage.getItem('ti_chat_currentSocketId');
        var toSocketId              =  localStorage.getItem('ti_chat_fromSocketId');
        var fromPossibleBrowsers    = "";
        var toPossibleBrowsers      = "";

        if( (fromBrowser == "edge" && currentBrowser == "safari") ) {
            fromPossibleBrowsers   =  "Chrome/Firefox/Edge";
            toPossibleBrowsers     =  "Chrome/Firefox";
        }else if( (fromBrowser == "safari" && currentBrowser == "edge") ) {
            fromPossibleBrowsers   =  "Chrome/Firefox";
            toPossibleBrowsers     =  "Chrome/Firefox/Edge";
        }else if( (fromBrowser == "safari" && currentBrowser == "safari") ) {
            fromPossibleBrowsers   =  "Chrome/Firefox";
            toPossibleBrowsers     =  "Chrome/Firefox";
        } /*else if( (fromBrowser == "firefox" && currentBrowser == "chrome") ) {
            fromPossibleBrowsers   =  "Chrome/Firefox";
            toPossibleBrowsers     =  "Chrome/Firefox";
        }*/

        var data = {
                toId                    : initiateAcceptCall_data.fromId,
                fromId                  : userId,
                fromName                : userName,
                toName                  : initiateAcceptCall_data.fromName,
                callType                : initiateAcceptCall_data.callType,
                fromBrowser             : currentBrowser,
                toBrowser               : initiateAcceptCall_data.fromBrowser,
                toSocketId              : toSocketId,
                currentSocketId         : currentSocketId,
                fromPossibleBrowsers    : fromPossibleBrowsers,
        };

        io.socket.request({
            method: 'POST',
            url: '/audioVideoCall/callBrowserCheck',
            data: data,
            contentType   : false,
            function (resData, jwres) {
            }
        });
    }

    // Sub function inside initiateCall function
    function common_initiateCall_fn(video_value) {

        // tiChat_Loadjscssfile('https://cdnjs.cloudflare.com/ajax/libs/adapterjs/0.15.0/adapter.min.js','js');

        tiChat_jQuery('#ansImgDiv').css("display","block");

        // Display timer in callerInitiateCall
        tiChat_jQuery('.modal-body #callTimerAnswer').css("display","block");
        tiChat_jQuery('.modal-body #callTimerInitiate').css("display","block");

        // Call Tune pausing after accepting
        //console.log(diallerCallRing)
        //diallerCallRing.pause();
        //receiverCallRing.pause();
        document.getElementById('diallerCallRing').pause();
        document.getElementById('receiverCallRing').pause();

        //Run timer when call starts
        callTimer();

        // console.log("initiateCall ------>>>>  ");
        prepareCall();

        // Adding chat video urls frame
        var initiate_element                     = '<div class="col-md-12 col-xs-12 col-sm-12 no-padding" style="position: absolute">';
            initiate_element                     +=     '<video id="localVideo" autoplay poster="/application/modules/User/externals/chat/images/video_call_loader.gif"></video>';
            // initiate_element                     +=     '<span class="pull-right">';
            // initiate_element                     +=         '<img class="user_image-sm profileImage" style="" src="'+ viewerProfilePic +'" onerror="imgError(this);" title="'+viewerName+'">';
            // initiate_element                     +=     '</span>';
            initiate_element                     += '</div>';
            initiate_element                     += '<div class="col-md-12 col-xs-12 col-sm-12 no-padding">';
            // initiate_element                     +=     '<div class="col-md-12 col-xs-12 col-sm-12">';
            initiate_element                     +=         '<video id="remoteVideo" autoplay poster="/application/modules/User/externals/chat/images/video_call_loader.gif"></video>';
            // initiate_element                     +=     '</div>';
            // initiate_element                     +=     '<div class="col-md-12 col-xs-12 col-sm-12 text-center" id="iniVideoToImg">';
            // initiate_element                     +=          '<img class="user_image-sm profileImage" style="" src="'+ initiateAcceptCall_data.fromImage +'" onerror="imgError(this);" title="'+initiateAcceptCall_data.fromName+'">';
            // initiate_element                     +=      '</div>';
            initiate_element                     += '</div>';

        tiChat_jQuery('.localRemoteVideo').html('');
        tiChat_jQuery('.localRemoteVideo').append(initiate_element);

        //var is_safari = navigator.userAgent.indexOf("Safari") > -1;
        //if(is_safari) {
           // tiChat_jQuery('#remoteVideo').css("max-height","390px");
        //}

        // Mute localVideo
        tiChat_jQuery('.localRemoteVideo #localVideo').prop('muted', true);

         //Adding modal-close class to backdrop
        tiChat_jQuery('.singleCallModal .modal-backdrop').addClass("modal-close");

        peerConn.onaddstream = function onAddStreamHandler(evt) {
            document.querySelector("#initiateAcceptCallModal .localRemoteVideo #remoteVideo").srcObject  = evt.stream;
            // Video modal height set to auto first
            tiChat_jQuery('.localRemoteVideo #remoteVideo').css("height","auto");

            tiChat_jQuery("#initiateAcceptCallModal .localRemoteVideo #remoteVideo").on('loadedmetadata',function(){
                document.querySelector("#initiateAcceptCallModal .localRemoteVideo #remoteVideo").srcObject  = evt.stream;
                tiChat_jQuery(this).off('loadedmetadata');
            });
            /*if(!evt.stream) {
                  setInterval(function () {
                      //alert("remote videos loadingggg======>")
                      console.log(evt.stream)
                      document.querySelector("#initiateAcceptCallModal .localRemoteVideo #remoteVideo").srcObject  = evt.stream;
                  },5000);
            }*/
            // Adding height to video
            var videoCallHeight = parseInt(tiChat_jQuery("#initiateAcceptCallModal .modal-content").height() - (tiChat_jQuery('#initiateAcceptCallModal .modal-footer').height() + 20) );
            tiChat_jQuery('.localRemoteVideo #remoteVideo').css("height",videoCallHeight+"px");
        };

        // get the local stream, show it in the local video element and send it
        navigator.getUserMedia({ "audio": true, "video": video_value }, function (stream) {
            localVideoStream   =  stream;
            document.querySelector("#initiateAcceptCallModal .localRemoteVideo #localVideo").srcObject = localVideoStream;
            tiChat_jQuery("#initiateAcceptCallModal .localRemoteVideo #localVideo").on('loadedmetadata',function(){
                document.querySelector("#initiateAcceptCallModal .localRemoteVideo #localVideo").srcObject  = localVideoStream;
                tiChat_jQuery(this).off('loadedmetadata');
            });
            peerConn.addStream(localVideoStream);
            createAndSendOffer();
        }, function(error) {
            console.log(error);
        });

        var muteCall_element = '<button id="muteCallId" class="btn btn-primary muteBtn" title="Mute Call">';
        muteCall_element    +=      '<span><i class="fa fa-microphone phoneImgSize" aria-hidden="true"></i></span>';
        muteCall_element    += '</button>';

        tiChat_jQuery('.acceptDeclineBtnDiv').append(muteCall_element);

    }


    function initiateCall() {
        var callType            = localStorage.getItem('callType');
        var video_value         = true;

        // clear disconnect Text
        tiChat_jQuery('.disconnectText').html("");

        //Hide acceptButton after accept
        tiChat_jQuery('.acceptBtn').css("display","none");

        if(callType ==  'audio') {
            // alert("audio call - Initiate Call ");
            video_value  = false;

            navigator.getUserMedia({ "audio": true, "video": video_value }, function (stream) {
                localVideoStream   = stream;
                if(localVideoStream == "" || localVideoStream == null) {
                    // Showing the alert Modal
                    tiChat_jQuery('#alertCallModal').modal('show');
                    tiChat_jQuery('.disconnectText').html("");
                    tiChat_jQuery('.disconnectText').append('<i style="color:black">Native device media streaming (getUserMedia) not supported in this browser.</i>');
                } else {
                    tiChat_jQuery('.localRemoteVideo').css("display","none");

                    //common function from outside
                    common_initiateCall_fn(video_value);

                    // Hide in callee part
                    tiChat_jQuery('#initiateAcceptCallModal #userNameAccept').css("display","none");
                }
            }, function(error) {

                        // Visible in callee part
                        tiChat_jQuery('#initiateAcceptCallModal #userNameAccept').css("display","block");

                        console.log(error);
                        tiChat_jQuery('#acceptCallId').css("display","none");

                        // Adding Message to disconnectText
                        tiChat_jQuery('.disconnectText').html('');
                        tiChat_jQuery('.disconnectText').append('<i>Permission denied to access your camera and/or microphone</i>');

                        tiChat_jQuery('.declineBtn span').removeClass("phoneEnd");
                        // Close the ring tone
                        //diallerCallRing.pause();
                        //receiverCallRing.pause();
                        document.getElementById('diallerCallRing').pause();
                        document.getElementById('receiverCallRing').pause();

                        var cancelParam  = {
                            cancelType : "error"
                            }
                        cancelCallTimer  = setTimeout(
                                              function() {
                                                    cancelCall(cancelParam);
                                            },2000);
            });

        } else if(callType ==  'video') {
                // alert("video call - Initiate Call ");
                tiChat_jQuery('#ansImgDiv').html('');

                navigator.getUserMedia({ "audio": true, "video": video_value }, function (stream) {
                    if (stream.getVideoTracks().length > 0) {
                        // my code to use the camera here ...
                        // console.log("Supporttt")
                        localVideoStream = stream;
                        if(localVideoStream == "" || localVideoStream == null) {
                            // Showing the alert Modal
                            tiChat_jQuery('#alertCallModal').modal('show');
                            tiChat_jQuery('.disconnectText').html("");
                            tiChat_jQuery('.disconnectText').append('<i style="color:black">Native device media streaming (getUserMedia) not supported in this browser.</i>');
                        } else {
                            // Hide in callee part
                            tiChat_jQuery('#initiateAcceptCallModal #userNameAccept').css("display","none");

                            tiChat_jQuery('.localRemoteVideo').css("display","block");

                            //common function from outside
                            common_initiateCall_fn(video_value)
                        }
                    }else {

                        // Visible in callee part
                        tiChat_jQuery('#initiateAcceptCallModal #userNameAccept').css("display","block");

                        console.log("webcam not Supportttttt")

                        tiChat_jQuery('#acceptCallId').css("display","none");

                        // Adding Message to disconnectText
                        tiChat_jQuery('.disconnectText').html('');
                        tiChat_jQuery('.disconnectText').append('<i>Webcam is not available!</i>');

                        // Close the ring tone
                        //diallerCallRing.pause();
                        //receiverCallRing.pause();
                        document.getElementById('diallerCallRing').pause();
                        document.getElementById('receiverCallRing').pause();
                        var cancelParam  = {
                            cancelType : "noWebcam"
                            }
                        cancelCallTimer  = setTimeout(
                                              function() {
                                                    cancelCall(cancelParam);
                                            },2000);

                    }
                }, function(error) {

                        // Visible in callee part
                        tiChat_jQuery('#initiateAcceptCallModal #userNameAccept').css("display","block");

                        console.log(error);
                        tiChat_jQuery('#acceptCallId').css("display","none");

                        // Adding Message to disconnectText
                        tiChat_jQuery('.disconnectText').html('');
                        tiChat_jQuery('.disconnectText').append('<i>Allow permission to access your camera and/or microphone</i>');

                        tiChat_jQuery('.declineBtn span').removeClass("phoneEnd");
                        // Close the ring tone
                        //diallerCallRing.pause();
                        //receiverCallRing.pause();
                        document.getElementById('diallerCallRing').pause();
                        document.getElementById('receiverCallRing').pause();

                        var cancelParam  = {
                            cancelType : "error"
                            }
                        cancelCallTimer  = setTimeout(
                                              function() {
                                                    cancelCall(cancelParam);
                                            },4000);
                });
        }
    };

    // Receiver accepting the call
    function answerCall(passdata) {
            console.log("answerCall ------>>>>  ");

            // Call Tune pausing after accepting
            //diallerCallRing.pause();
            //receiverCallRing.pause();
            document.getElementById('diallerCallRing').pause();
            document.getElementById('receiverCallRing').pause();

            //Clearing noAnswer timing
            clearTimeout(notAnswerTimer);

            // Hide timer in callerInitiateCall
            tiChat_jQuery('#callerInitiateCallModal .modal-body #callTimerAnswer').css("display","block");
            tiChat_jQuery('#callerInitiateCallModal .modal-body #callTimerInitiate').css("display","block");

            var callType                =   localStorage.getItem('callType');
            initiateAcceptCall_data     =   passdata;
            var video_value             =   true;

            prepareCall();

            var answer_element                     =   '<div class="col-md-12 col-xs-12 col-sm-12 no-padding" style="position: absolute">';
                answer_element                     +=       '<video id="localVideo" autoplay poster="/application/modules/User/externals/chat/images/video_call_loader.gif"></video>';
                // answer_element                     +=       '<span class="pull-right">';
                // answer_element                     +=           '<img class="user_image-sm profileImage" src="'+ viewerProfilePic +'" onerror="imgError(this);" title="'+viewerName+'">';
                // answer_element                     +=       '</span>';
                answer_element                     +=   '</div>';
                answer_element                     +=   '<div class="col-md-12 col-xs-12 col-sm-12 no-padding">';
                // answer_element                     +=       '<div class="col-md-12 col-xs-12 col-sm-12">';
                answer_element                     +=           '<video id="remoteVideo" autoplay poster="/application/modules/User/externals/chat/images/video_call_loader.gif"></video>';
                // answer_element                     +=       '</div>';
                // answer_element                     +=       '<div class="col-md-12 col-xs-12 col-sm-12 text-center">';
                // answer_element                     +=           '<img class="user_image-sm profileImage" src="'+ initiateAcceptCall_data.fromImage +'" onerror="imgError(this);" title="'+initiateAcceptCall_data.fromName+'">';
                // answer_element                     +=       '</div>';
                answer_element                     +=   '</div>';


            tiChat_jQuery('.localRemoteVideo').html('');
            tiChat_jQuery('.localRemoteVideo').append(answer_element);

            //if(is_safari) {
               // tiChat_jQuery('#remoteVideo').css("max-height","390px");
            //}
            // Mute localVideo
            tiChat_jQuery('.localRemoteVideo #localVideo').prop('muted', true);

            //Run timer when call starts
            callTimer();

            // Hide Image and name of Caller as well as Callee
            tiChat_jQuery('#userNameInitiate').css("display","none");

            // Showing call accepted message
            tiChat_jQuery('.disconnectText').append('<i style="color: green;">Call accepted</i>');
            connectTextTimer    = setTimeout(
                                  function() {
                                     tiChat_jQuery('.disconnectText').html('');
                                },2000);

            if(callType=='audio') {
                video_value   = false;
                tiChat_jQuery('.localRemoteVideo').css("display","none");

                var initiateImgDivElem = '<div id="ansImage" class="text-center"><img class="user_image-sm" style="width:70px;height:70px;"  src="'+ initiateAcceptCall_data.fromImage +'" onerror="imgError(this);" title="'+initiateAcceptCall_data.fromName+'"></div>';
                    initiateImgDivElem += '<div id="ansName" class="text-center">'+initiateAcceptCall_data.fromName+'</div>';
                tiChat_jQuery('#initiateImgDiv').html('');
                tiChat_jQuery('#initiateImgDiv').append(initiateImgDivElem);

                // Hide Only callee Image and name
                tiChat_jQuery('#initiateImgDiv').css("display","block");
            } else {
                video_value   = true;
                tiChat_jQuery('.localRemoteVideo').css("display","block");

                // Hide Only callee Image and name
                tiChat_jQuery('#initiateImgDiv').css("display","none");
            }

            peerConn.onaddstream = function onAddStreamHandler(evt) {
                document.querySelector("#callerInitiateCallModal .localRemoteVideo #remoteVideo").srcObject = evt.stream;

                // Video modal height set to auto first
                tiChat_jQuery('.localRemoteVideo #remoteVideo').css("height","auto");

                tiChat_jQuery("#callerInitiateCallModal .localRemoteVideo #remoteVideo").on('loadedmetadata',function(){
                    document.querySelector("#callerInitiateCallModal .localRemoteVideo #remoteVideo").srcObject = evt.stream;
                    tiChat_jQuery(this).off('loadedmetadata');
                });
                 //video refreshing=============>
                /*if(!evt.stream) {
                      setInterval(function () {
                          //alert("remote videos loadingggg======>")
                          console.log(evt.stream)
                          document.querySelector("#initiateAcceptCallModal .localRemoteVideo #remoteVideo").srcObject  = evt.stream;
                      },5000);
                }*/
                // Adding height to video
                var videoCallHeight = parseInt(tiChat_jQuery("#callerInitiateCallModal .modal-content").height() - (tiChat_jQuery('#callerInitiateCallModal .modal-footer').height() + 20 ) );
                tiChat_jQuery('.localRemoteVideo #remoteVideo').css("height",videoCallHeight+"px");
            };
            // get the local stream, show it in the local video element and send it
            navigator.getUserMedia({ "audio": true, "video": video_value }, function (stream) {
                // alert("local")
                localVideoStream = stream;
                document.querySelector("#callerInitiateCallModal .localRemoteVideo #localVideo").srcObject = localVideoStream;
                tiChat_jQuery("#callerInitiateCallModal .localRemoteVideo #localVideo").on('loadedmetadata',function(){
                    document.querySelector("#callerInitiateCallModal .localRemoteVideo #localVideo").srcObject  = localVideoStream;
                    tiChat_jQuery(this).off('loadedmetadata');
                });
                peerConn.addStream(localVideoStream);
                createAndSendAnswer();
            }, function(error) {
                    console.log(error);
                    // Disable call buttons
                    tiChat_jQuery('.declineBtn').attr('disabled',true);
                    tiChat_jQuery('.acceptBtn').attr('disabled',true);
                    tiChat_jQuery('.muteBtn').attr('disabled',true);

                    //Adding Disconnect Messages
                    tiChat_jQuery('.disconnectText').html("");
                    tiChat_jQuery('.disconnectText').append('<i>Allow permission to access your camera and/or microphone</i>');
                    tiChat_jQuery('.declineBtn span').addClass("phoneEnd");

                    var cancelParam  = {
                                cancelType : "error"
                                }
                    cancelCallTimer = setTimeout(
                                          function() {
                                                cancelCall(cancelParam);
                                        },4000);
            });

            var muteCall_element = '<button id="muteCallId" class="btn btn-primary muteBtn" title="Mute Call">';
            muteCall_element    +=      '<span><i class="fa fa-microphone phoneImgSize" aria-hidden="true"></i></span>';
            muteCall_element    += '</button>';

            tiChat_jQuery('.acceptDeclineBtnDiv').append(muteCall_element);
    };

    // Function to send sdp (Offer a Call)
    function createAndSendOffer() {
        console.log("createAndSendOffer ------>>>>  ");
        peerConn.createOffer(
            function (offer) {
              var off = new RTCSessionDescription(offer);
                  peerConn.setLocalDescription(new RTCSessionDescription(off),
                    function() {
                        var userName            =   viewerName;
                        var userId              =   viewerId;
                        var toSocketId          = localStorage.getItem('ti_chat_fromSocketId');

                        var toUserId    = initiateAcceptCall_data.fromId;
                        var data = {
                                        toId         : toUserId,
                                        fromId       : userId,
                                        passdata     : JSON.stringify({"sdp": off }),
                                        type         : "createAndSendOffer",
                                        fromName     : viewerName,
                                        fromImage    : viewerProfilePic,
                                        toSocketId   : toSocketId,
                                        };
                        io.socket.request({
                                method: 'POST',
                                url: '/audioVideoCall/commonCall',
                                data: data,
                                contentType   : false,
                                //headers: {
                                        //'userToken' : userToken
                                    //},
                                function (resData, jwres) {
                                }
                            });
                    },
                    function(error) { console.log(error);}
                  );
            },
            function (error) { console.log(error);}
        );
    };

    // Function to receive sdp (Answer a Call)
    function createAndSendAnswer() {
        console.log("createAndSendAnswer ------>>>>  ");
        peerConn.createAnswer(
            function (answer) {
              var ans = new RTCSessionDescription(answer);
              peerConn.setLocalDescription(ans, function() {
                  //wsc.send(JSON.stringify({"sdp": ans }));
                    var userName            =  viewerName;
                    var userId              =  viewerId;
                    var toSocketId          =  localStorage.getItem('ti_chat_fromSocketId');

                    // console.log(userId)
                    var toUserId    = initiateAcceptCall_data.fromId;
                    var data = {
                                    toId         : toUserId,
                                    fromId       : userId,
                                    passdata     : JSON.stringify({"sdp": ans }),
                                    type         : "createAndSendAnswer",
                                    fromName     : viewerName,
                                    fromImage    : viewerProfilePic,
                                    toSocketId   : toSocketId,
                                    };
                    io.socket.request({
                            method: 'POST',
                            url: '/audioVideoCall/commonCall',
                            data: data,
                            contentType   : false,
                            //headers: {
                                    //'userToken' : userToken
                                //},
                            function (resData, jwres) {
                            }
                        });
                },
                function (error) { console.log(error);}
              );
            },
            function (error) {console.log(error);}
        );
    };

    // Function to create,send and receive Icecandidate
    function onIceCandidateHandler(evt) {
        console.log("onIceCandidateHandler ------>>>>  ");

        if (!evt || !evt.candidate) return;
        //wsc.send(JSON.stringify({"candidate": evt.candidate }));
        var userName            =   viewerName;
        var userId              =   viewerId
        var toUserId            =   initiateAcceptCall_data.fromId;

        var toSocketId          =   localStorage.getItem('ti_chat_fromSocketId');
        var data = {
                        toId         : toUserId,
                        fromId       : userId,
                        passdata     : JSON.stringify({"candidate": evt.candidate }),
                        type         : "onIceCandidateHandler",
                        fromName     : viewerName,
                        fromImage    : viewerProfilePic,
                        toSocketId   : toSocketId,
                        };
        io.socket.request({
                method: 'POST',
                url: '/audioVideoCall/commonCall',
                data: data,
                contentType   : false,
                //headers: {
                        //'userToken' : userToken
                    //},
                function (resData, jwres) {
                }
            });
    };

    // Function to End a call
    function endCall() {
        console.log("endCall ------>>>>  ");

        //Clearing noAnswer timing
        clearTimeout(notAnswerTimer);

        clearTimeout(cancelCallTimer);
        clearTimeout(singleCallModalHideTimer);
        clearTimeout(connectTextTimer);

        tiChat_jQuery('.localRemoteVideo').html('');
        var userName              =   viewerName;
        var userId                =   viewerId;
        var toSocketId            =   localStorage.getItem('ti_chat_fromSocketId');
        var toId                  =   toUserId;

        // Cancel ringtone
        //diallerCallRing.pause();
        //receiverCallRing.pause();
        document.getElementById('diallerCallRing').pause();
        document.getElementById('receiverCallRing').pause();
        if(!peerConn) {
            console.log("notttttt ========== peerConn")
            // console.log(toUserId)
            var cancelParam  = {
                                cancelType : "noPeerConnection"
                                }
            cancelCall(cancelParam);
        } else {

            tiChat_Removejscssfile('https://cdnjs.cloudflare.com/ajax/libs/adapterjs/0.15.0/adapter.min.js','js');
            peerConn.close();
            peerConn = null;
            if (localVideoStream) {
                localVideoStream.getTracks().forEach(function (track) {
                    track.stop();
                });
            }

            // Disable call buttons
            tiChat_jQuery('.declineBtn').attr('disabled',true);
            tiChat_jQuery('.acceptBtn').attr('disabled',true);
            tiChat_jQuery('.muteBtn').attr('disabled',true);

            //Adding Disconnect Messages
            tiChat_jQuery('.disconnectText').html("");
            tiChat_jQuery('.disconnectText').append('<i>Call disconnected</i>');
            tiChat_jQuery('.declineBtn span').addClass("phoneEnd");

            localStorage.setItem('ti_chat_calltoId', "");
            if(!toUserId) {
                toId    =   initiateAcceptCall_data.fromId;
            }
            var data = {
                fromId      : userId,
                toId        : toId,
                toSocketId  : toSocketId,
            };
            io.socket.request({
                method: 'POST',
                url: '/audioVideoCall/endCall',
                data: data,
                contentType : false,
                //headers: {
                //'userToken' : userToken
                //},
                function (resData, jwres) {
                }
            });

            // Ends the timer when call ends
            clearTimeout(callTimerT);
            singleCallModalHideTimer  = setTimeout(
                                              function() {
                                                    tiChat_jQuery('.singleCallModal').modal('hide');

                                                    callTimerAnswer.textContent     = "00:00:00";
                                                    callTimerInitiate.textContent   = "00:00:00";
                                                    callTimerSeconds                = 0;
                                                    callTimerMinutes                = 0;
                                                    callTimerHours                  = 0;
                                            },2000);
        }
    };

    // Function to Cancel a call
    function cancelCall(cancelParam) {
            console.log("Cancel Calllllll=============>")
            //tiChat_jQuery('.localRemoteVideo').html('');
            tiChat_Removejscssfile('https://cdnjs.cloudflare.com/ajax/libs/adapterjs/0.15.0/adapter.min.js','js');

            //Clearing noAnswer timing
            clearTimeout(notAnswerTimer);

            clearTimeout(cancelCallTimer);
            clearTimeout(singleCallModalHideTimer);
            clearTimeout(connectTextTimer);

            // Disable call buttons
            tiChat_jQuery('.declineBtn').attr('disabled',true);
            tiChat_jQuery('.acceptBtn').attr('disabled',true);
            tiChat_jQuery('.muteBtn').attr('disabled',true);

            //Adding Disconnect Messages
            tiChat_jQuery('.disconnectText').html("");
            tiChat_jQuery('.disconnectText').append('<i>Call disconnected</i>');
            tiChat_jQuery('.declineBtn span').addClass("phoneEnd");

            singleCallModalHideTimer = setTimeout(
                                          function() {
                                                // Hide all call modals
                                                tiChat_jQuery('.singleCallModal').modal('hide');
                                        },2000);

            localStorage.setItem('ti_chat_calltoId', "");

            var userName              =   viewerName;
            var userId                =   viewerId;
            var toId                  =   toUserId;

            //Cancel ringtone
            //diallerCallRing.pause();
            //receiverCallRing.pause();
            document.getElementById('diallerCallRing').pause();
            document.getElementById('receiverCallRing').pause();
            if(!toUserId) {
                toId    =   initiateAcceptCall_data.fromId;
            }

            var data = {
                fromId        : userId,
                toId          : toId,
                cancelType    : cancelParam.cancelType,
            };
            io.socket.request({
                method: 'POST',
                url: '/audioVideoCall/cancelCall',
                data: data,
                contentType : false,
                //headers: {
                //'userToken' : userToken
                //},
                function (resData, jwres) {
                }
            });
    }

    // Function to Mute a call
    function muteCall(){
        var userName              =   viewerName;
        var userId                =   viewerId;
        var toId                  =   toUserId;
        var toSocketId            =   localStorage.getItem('ti_chat_fromSocketId');

        if( !tiChat_jQuery('.muteStart').length ) {
            tiChat_jQuery('.muteBtn span').addClass("muteStart");
            tiChat_jQuery('.muteBtn').attr("title","Unmute Call");
        } else {
            tiChat_jQuery('.muteBtn span').removeClass("muteStart");
            tiChat_jQuery('.muteBtn').attr("title","Mute Call");
        }
        if(!toUserId) {
            toId    =   initiateAcceptCall_data.fromId;
        }
        var data = {
            fromId      : userId,
            toId        : toId,
            toSocketId  : toSocketId,
        };
        io.socket.request({
            method: 'POST',
            url: '/audioVideoCall/muteCall',
            data: data,
            contentType : false,
            function (resData, jwres) {
            }
        });
    }

    // Function to update call status
    function updateCallStatus(toId) {
            console.log("call status Update ")
            tiChat_Removejscssfile('https://cdnjs.cloudflare.com/ajax/libs/adapterjs/0.15.0/adapter.min.js','js');
            var userId              =   viewerId;
            var toSocketId          =   localStorage.getItem('ti_chat_fromSocketId');

            var data = {
                fromId      : userId,
                toId        : toId,
                toSocketId  : toSocketId,
            };
            io.socket.request({
                method: 'POST',
                url: '/audioVideoCall/updateCallStatus',
                data: data,
                contentType : false,
                //headers: {
                //'userToken' : userToken
                //},
                function (resData, jwres) {
                }
            });
    }


 /* =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
                                            CLIENT - SOCKET - STARTS
     * =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* */

    function socket_initiatecall_fn(data){
            //receiverCallRing.autoplay = true;
            //receiverCallRing.play();
            //document.getElementById('diallerCallRing').currentTime = 0;
            //document.getElementById('receiverCallRing').currentTime = 0;

            document.getElementById('diallerCallRing').src      = '../application/modules/User/externals/chat/wav/alarmxperia.mp3';
            document.getElementById('receiverCallRing').src     = '../application/modules/User/externals/chat/wav/alarmxperia.mp3';
            if(tiChat_DeviceType == 1) {
                if(isChrome){
                    document.getElementById('diallerCallRing').src = 'http://www.jivebird.com/media/slidersongs/valentine.m4a';
                    document.getElementById('receiverCallRing').src = 'http://www.jivebird.com/media/slidersongs/valentine.m4a';
                }
            }
            //document.querySelector('.callRingtone').src = '../application/modules/User/externals/chat/wav/phone_ringing.wav'
            document.getElementById('receiverCallRing').play();
            //alert(document.querySelector('.callRingtone').play)
            //document.querySelector('.callRingtone').autoplay = true;
            localStorage.setItem('ti_chat_calltoId', data.fromId);
            localStorage.setItem('callType', data.callType);

            // Removing end part in decline call
            tiChat_jQuery('.declineBtn span').removeClass("phoneEnd");

            initiateAcceptCall_data  = data;
    }

    io.socket.on('disconnect', function socketConnected()  {
        console.log("disconnect *******");
        socketStatus = false;

        //End a call
        endCall();
    });
    io.socket.on('connect', function socketConnected()  {
        console.log("connect");
        socketStatus = true;

        // Handling socket broadcasts and blasts in client side
        io.socket.on('message', function (data){
            // console.log(data)
            var switchKey = data.broadcast_name;
            switch(switchKey){
                case "currentSocketId" :
                        localStorage.setItem('ti_chat_currentSocketId', data.currentSocketId);
                break;

                case "fromCommonCall" :
                        // When accepting a call. Hide the modal of same user in other devices
                        console.log("fromCommonCall =======================>>>>>>>>>>>");
                        // Disable call buttons
                        tiChat_jQuery('.declineBtn').attr('disabled',true);
                        tiChat_jQuery('.acceptBtn').attr('disabled',true);
                        tiChat_jQuery('.muteBtn').attr('disabled',true);

                        // Close the ring tone
                        // diallerCallRing.pause();
                        // receiverCallRing.pause();
                        document.getElementById('diallerCallRing').pause();
                        document.getElementById('receiverCallRing').pause();

                        singleCallModalHideTimer = setTimeout(
                                                      function() {
                                                            tiChat_jQuery('.singleCallModal').modal('hide');
                                                    },2000);

                break;

                case "toCommonCall" :
                        // When accepting a call. Hide the modal of same user in other devices
                        console.log("fromCommonCall =======================>>>>>>>>>>>");
                        // Disable call buttons
                        tiChat_jQuery('.declineBtn').attr('disabled',true);
                        tiChat_jQuery('.acceptBtn').attr('disabled',true);
                        tiChat_jQuery('.muteBtn').attr('disabled',true);

                        // Close the ring tone
                        // diallerCallRing.pause();
                        // receiverCallRing.pause();
                        document.getElementById('diallerCallRing').pause();
                        document.getElementById('receiverCallRing').pause();

                        singleCallModalHideTimer  = setTimeout(
                                                      function() {
                                                            tiChat_jQuery('.singleCallModal').modal('hide');
                                                    },2000);

                break;

                case "fromEndCall" :
                        // When ending a call. Hide the modal of same user in other devices
                        console.log("fromEndCall =======================>>>>>>>>>>>");
                        // Disable call buttons
                        tiChat_jQuery('.declineBtn').attr('disabled',true);
                        tiChat_jQuery('.acceptBtn').attr('disabled',true);
                        tiChat_jQuery('.muteBtn').attr('disabled',true);

                        //Adding Disconnect Messages
                        tiChat_jQuery('.disconnectText').html("");
                        tiChat_jQuery('.disconnectText').append('<i>Call disconnected</i>');
                        tiChat_jQuery('.declineBtn span').addClass("phoneEnd");

                        singleCallModalHideTimer = setTimeout(
                                                      function() {
                                                            tiChat_jQuery('.singleCallModal').modal('hide');
                                                    },2000);

                break;
                case "fromCancelCall" :
                        // When cancelling a call. Hide the modal of same user in other devices
                        console.log("fromCancelCall =======================>>>>>>>>>>>");
                        // Disable call buttons
                        tiChat_jQuery('.declineBtn').attr('disabled',true);
                        tiChat_jQuery('.acceptBtn').attr('disabled',true);
                        tiChat_jQuery('.muteBtn').attr('disabled',true);

                        //Adding Disconnect Messages
                        tiChat_jQuery('.disconnectText').html("");
                        tiChat_jQuery('.disconnectText').append('<i>Call disconnected</i>');
                        tiChat_jQuery('.declineBtn span').addClass("phoneEnd");

                        singleCallModalHideTimer  =  setTimeout(
                                                      function() {
                                                            tiChat_jQuery('.singleCallModal').modal('hide');
                                                    },2000);

                break;

                case "initiateCallBrowserCheck" :   // Callee
                        console.log("initiateCallBrowserCheck ++++++++++++++++");
                        console.log(data);
                        if(data.isCallPossible) {
                            initiateCall();
                        } else {

                            // Adding Message to disconnectText
                            tiChat_jQuery('.disconnectText').html('');
                            // tiChat_jQuery('.disconnectText').append('<i>Caller browser is '+data.toBrowser+', please change it to chrome/firefox.</i>');
                            tiChat_jQuery('.disconnectText').append('<b>'+data.toName+'</b> is currently using '+data.toBrowser+'. You cannot make a video call from '+data.fromBrowser+' to '+data.toBrowser+'. To continue, please login to rentstarz from <b>'+data.fromPossibleBrowsers+'</b> and start a video call.');

                            tiChat_jQuery('.declineBtn').attr('disabled',true);
                            tiChat_jQuery('.acceptBtn').attr('disabled',true);
                            tiChat_jQuery('.declineBtn span').addClass("phoneEnd");
                            // Close the ring tone
                            //diallerCallRing.pause();
                            //receiverCallRing.pause();
                            document.getElementById('diallerCallRing').pause();
                            document.getElementById('receiverCallRing').pause();
                            var cancelParam  = {
                                cancelType : "browserIssue"
                                }
                            cancelCallTimer  = setTimeout(
                                                  function() {
                                                        cancelCall(cancelParam);
                                                },15000);
                        }
                break;

                case "answerCallBrowserCheck" :  // Caller
                        console.log("answerCallBrowserCheck ++++++++++++++++");
                        console.log(data);
                        if(!data.isCallPossible) { // Caller
                            // Adding Message to disconnectText
                            tiChat_jQuery('.disconnectText').html('');
                            // tiChat_jQuery('.disconnectText').append('<i>Callee browser is '+data.fromBrowser+', please change it to chrome/firefox.</i>');
                            tiChat_jQuery('.disconnectText').append('<b>'+data.fromName+'</b> is currently using '+data.fromBrowser+'. You cannot make a video call from '+data.toBrowser+' to '+data.fromBrowser+'. To continue, please login to rentstarz from <b>'+data.fromPossibleBrowsers+'</b> and start a video call.');

                            tiChat_jQuery('.declineBtn').attr('disabled',true);
                            tiChat_jQuery('.acceptBtn').attr('disabled',true);
                            tiChat_jQuery('.declineBtn span').addClass("phoneEnd");
                            // Close the ring tone
                            //diallerCallRing.pause();
                            //receiverCallRing.pause();
                            document.getElementById('diallerCallRing').pause();
                            document.getElementById('receiverCallRing').pause();
                            var cancelParam  = {
                                cancelType : "browserIssue"
                                }
                            cancelCallTimer  = setTimeout(
                                                  function() {
                                                        cancelCall(cancelParam);
                                                },15000);
                        }
                break;

                case "initiateCall" :
                    // console.log(data)

                    // Enable call buttons
                    tiChat_jQuery('.declineBtn').attr('disabled',false);
                    tiChat_jQuery('.acceptBtn').attr('disabled',false);
                    tiChat_jQuery('.muteBtn').attr('disabled',false);

                    tiChat_jQuery('.acceptDeclineBtnDiv .muteBtn').remove();

                    // Add disconnect message
                    tiChat_jQuery('.disconnectText').html("");
                    tiChat_jQuery('#callerInitiateCallModal .declineBtn').removeClass("modal-simple-cancel");
                    tiChat_jQuery('#callerInitiateCallModal .declineBtn').addClass("modal-close");

                    tiChat_jQuery('.singleCallModal .modal-backdrop').removeClass("modal-simple-cancel");
                    tiChat_jQuery('.singleCallModal .modal-backdrop').addClass("modal-close");
                    var video_value    =  true;
                    fromBrowser        =   data.fromBrowser;
                    if(data.callStatus) {
                        console.log("call status == 'true' ");

                        tiChat_jQuery('#callerInitiateCallModal .declineBtn').removeClass("modal-close");
                        tiChat_jQuery('#callerInitiateCallModal .declineBtn').addClass("modal-simple-cancel");

                        tiChat_jQuery('.singleCallModal .modal-backdrop').removeClass("modal-close");
                        tiChat_jQuery('.singleCallModal .modal-backdrop').addClass("modal-simple-cancel");

                        tiChat_jQuery('.disconnectText').html("");

                        if(data.userInCall == "fromUser"){
                            // localStorage.setItem('ti_chat_fromUserInCall', true);
                            tiChat_jQuery('#callerInitiateCallModal .disconnectText').append('<i><b>You are in another call now</b></i>');
                        } else if(data.userInCall == "toUser"){
                            tiChat_jQuery('#callerInitiateCallModal .disconnectText').append('<i><b>'+ data.toName + '</b> is busy</i>');
                        }
                        tiChat_jQuery('#callerInitiateCallModal .declineBtn span').addClass("phoneEnd");

                        // Disable call buttons
                        tiChat_jQuery('.declineBtn').attr('disabled',true);
                        tiChat_jQuery('.acceptBtn').attr('disabled',true);
                        tiChat_jQuery('.muteBtn').attr('disabled',true);

                        // Close the ring tone
                        //diallerCallRing.pause();
                        //receiverCallRing.pause();
                        document.getElementById('diallerCallRing').pause();
                        document.getElementById('receiverCallRing').pause();

                        singleCallModalHideTimer  = setTimeout(
                                                      function() {
                                                            tiChat_jQuery('.singleCallModal').modal('hide');
                                                    },3000);

                    }else {

                        if(tiChat_isIOS) {
                             console.log("IOS mobile");
                        } else {
                            localStorage.setItem('ti_chat_fromSocketId', data.fromSocketId);
                            // Hide timer in callerInitiateCall
                            tiChat_jQuery('.modal-body #callTimerAnswer').css("display","none");
                            tiChat_jQuery('.modal-body #callTimerInitiate').css("display","none");
                            tiChat_jQuery('#ansImgDiv').css("display","none");

                            // Show both caller and callee image on second time call without refresh
                            tiChat_jQuery('#userNameAccept').css("display","block");

                            // Hiding the alert Modal
                            tiChat_jQuery('#alertCallModal').modal('hide');

                            tiChat_jQuery('#initiateAcceptCallModal').modal('show');
                            tiChat_jQuery('.singleCallModal .modal-backdrop').addClass("modal-close");
                            tiChat_jQuery('#acceptCallId').css("display","block");

                            // Adding name & image of callee
                            var socket_initiate_element    = '<div class="col-md-4 col-sm-4 col-xs-4">';
                                socket_initiate_element     +=      '<div class="pull-right">';
                                socket_initiate_element     +=          '<div id="usefromProfileImage"><img class="user_image-sm profileImage" style="" src="'+ data.toProfilePic  +'" onerror="imgError(this);" title="'+ data.toName +'"></div>';
                                socket_initiate_element     +=          '<div id="fromUsername">'+data.toName+'</div>';
                                socket_initiate_element     +=      '</div>';
                                socket_initiate_element     += '</div>';
                                socket_initiate_element     += '<div class="col-md-4 col-sm-4 col-xs-4" style="margin-top:35px;">';
                                socket_initiate_element     +=      '<div><img style="width:100%;" src="application/modules/User/externals/images/30.gif"  title=""></div>';
                                socket_initiate_element     +=  '</div>';
                                socket_initiate_element     += '<div class="col-md-4 col-sm-4 col-xs-4">';
                                socket_initiate_element     +=      '<div id="userProfileImage"><img class="user_image-sm profileImage" style="" src="'+ data.fromImage +'" onerror="imgError(this);" title="'+data.fromName+'"></div>';
                                socket_initiate_element     +=      '<div  id="fromUsername">'+ data.fromName+'</div>';
                                socket_initiate_element     += '</div>';
                            tiChat_jQuery('#userNameAccept').html("");
                            tiChat_jQuery('#userNameAccept').append(socket_initiate_element);

                            if(data.callType=='video') {
                                socket_initiatecall_fn(data);
                            } else {
                                // Adding name and image of caller
                                var element     =   '<div class="text-center" id="ansImage">';
                                    element     +=      '<img class="user_image-sm" style="width:70px;height:70px;"  src="'+ data.fromImage +'" onerror="imgError(this);" title="'+data.fromName+'">';
                                    element     +=  '</div>';
                                    element     += '<div id="ansName" class="text-center">'+data.fromName+'</div>';
                                tiChat_jQuery('#ansImgDiv').html("");
                                tiChat_jQuery('#ansImgDiv').append(element);

                                socket_initiatecall_fn(data);
                            }
                        }
                    }

                break;

                case "endCall" :
                        console.log("Socket endCall");

                        //Clearing noAnswer timing
                        clearTimeout(notAnswerTimer);

                        clearTimeout(cancelCallTimer);
                        clearTimeout(singleCallModalHideTimer);
                        clearTimeout(connectTextTimer);

                        // Removing video url
                        tiChat_jQuery('.localRemoteVideo').html('');

                        // Close the ring tone
                        //diallerCallRing.pause();
                        //receiverCallRing.pause();
                        document.getElementById('diallerCallRing').pause();
                        document.getElementById('receiverCallRing').pause();

                        if(peerConn) {
                            peerConn.close();
                            peerConn = null;
                        }

                        // Adding to localstorage
                        localStorage.setItem('ti_chat_calltoId', "");
                        localStorage.setItem('callType', "");

                        // Hiding modals & Ends the timer when call ends
                        clearTimeout(callTimerT);
                        singleCallModalHideTimer  =  setTimeout(
                                                          function() {
                                                                tiChat_jQuery('.singleCallModal').modal('hide');

                                                                callTimerAnswer.textContent     = "00:00:00";
                                                                callTimerInitiate.textContent   = "00:00:00";
                                                                callTimerSeconds                = 0;
                                                                callTimerMinutes                = 0;
                                                                callTimerHours                  = 0;
                                                        },2000);

                        // Disable call buttons
                        tiChat_jQuery('.declineBtn').attr('disabled',true);
                        tiChat_jQuery('.acceptBtn').attr('disabled',true);
                        tiChat_jQuery('.muteBtn').attr('disabled',true);

                        //Adding Disconnect Messages
                        tiChat_jQuery('.disconnectText').html("");
                        tiChat_jQuery('.disconnectText').append('<i>Call disconnected</i>');
                        tiChat_jQuery('.declineBtn span').addClass("phoneEnd");

                        if (localVideoStream) {
                            localVideoStream.getTracks().forEach(function (track) {
                                track.stop();
                            });
                        }

                break;

                case "cancelCall" :
                        console.log("Socket cancelCall");

                        //Clearing noAnswer timing
                        clearTimeout(notAnswerTimer);

                        clearTimeout(cancelCallTimer);
                        clearTimeout(singleCallModalHideTimer);
                        clearTimeout(connectTextTimer);

                        // Removing video url
                        tiChat_jQuery('.localRemoteVideo').html('');

                        // Close the ring tone
                        //diallerCallRing.pause();
                        //receiverCallRing.pause();
                        document.getElementById('diallerCallRing').pause();
                        document.getElementById('receiverCallRing').pause();

                        // Adding to localstorage
                        localStorage.setItem('ti_chat_calltoId', "");
                        localStorage.setItem('callType', "");

                        // Disable call buttons
                        tiChat_jQuery('.declineBtn').attr('disabled',true);
                        tiChat_jQuery('.acceptBtn').attr('disabled',true);
                        tiChat_jQuery('.muteBtn').attr('disabled',true);
                        tiChat_jQuery('.declineBtn span').addClass("phoneEnd");

                        // Adding Disconnect Messages
                        tiChat_jQuery('.disconnectText').html("");

                        if(data.cancelType == "noWebcam") {
                            tiChat_jQuery('.disconnectText').append('<i>No webcam found for callee. Please make an audio call</i>');
                            // Hiding modals
                            singleCallModalHideTimer  = setTimeout(
                                                          function() {
                                                              tiChat_jQuery('.singleCallModal').modal('hide');
                                                        },3000);
                        } else {
                            tiChat_jQuery('.disconnectText').append('<i>Call disconnected</i>');
                            // Hiding modals
                            singleCallModalHideTimer  = setTimeout(
                                                              function() {
                                                                  tiChat_jQuery('.singleCallModal').modal('hide');
                                                            },2000);
                        }

                break;

                case "muteCall" :
                        console.log("Socket muteCall");
                        if( tiChat_jQuery('.localRemoteVideo #remoteVideo').prop('muted') == false ) {
                            tiChat_jQuery('.localRemoteVideo #remoteVideo').prop('muted', true);
                        } else {
                            tiChat_jQuery('.localRemoteVideo #remoteVideo').prop('muted', false);
                        }
                break;

                case "updateCallStatus" :
                        console.log("Socket updateCallStatus");

                        // Close the ring tone
                        //diallerCallRing.pause();
                        //receiverCallRing.pause();
                        document.getElementById('diallerCallRing').pause();
                        document.getElementById('receiverCallRing').pause();

                        // Hiding modals
                        tiChat_jQuery(".modal").fadeOut('fast');
                        tiChat_jQuery(".modal-backdrop").fadeOut('fast');

                        // Adding to localstorage
                        localStorage.setItem('ti_chat_calltoId', "");
                break;

                case "commonCall" :
                     console.log("Default < ============ > data");
                     // console.log(data);

                     // Close the ring tone
                     // diallerCallRing.pause();
                     // receiverCallRing.pause();

                      var signal = null;
                      // console.log(peerConn);
                      if (!peerConn) answerCall(data.webrtc_data);

                      signal        =   JSON.parse(data.webrtc_data.passdata);
                      // console.log("signallllllllllll")
                      // console.log(signal);
                      localStorage.setItem('ti_chat_fromSocketId', data.fromSocketId);
                      if (signal.sdp && signal.sdp != "") {
                            console.log("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^signal.sdp^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
                            console.log(signal.sdp);
                            console.log("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^signal.sdp^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
                            console.log("Received SDP from remote peer.");
                            //peerConn.onaddstream = onAddStreamHandler;
                            peerConn.setRemoteDescription(new RTCSessionDescription(signal.sdp));
                      } else if (signal.candidate && signal.candidate !="") {
                            console.log("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^signal.candidate^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
                            console.log(signal.candidate);
                            console.log("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^signal.candidate^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
                            console.log("Received ICECandidate from remote peer.");
                            peerConn.addIceCandidate(new RTCIceCandidate(signal.candidate));

                      } else if ( signal.closeConnection){
                            console.log("Received 'close call' signal from remote peer.");
                            endCall();
                      }
                break;

                default :

                break;
            }
        });

    });

/* =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
                                            CLIENT - SOCKET - ENDS
*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* */



/* =*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*
                                           tiChat_jQuery Click Part
*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* */
    // call Modal close click
    tiChat_jQuery(document).on("click",".modal-close",function() {
        endCall();
    });

    // Cancel call click
    tiChat_jQuery(document).on("click",".modal-simple-cancel",function() {
    singleCallModalHideTimer  = setTimeout(
                                    function() {
                                       tiChat_jQuery(".singleCallModal").modal("hide");
                                },2000);
        // Adding Disconnect Messages
        tiChat_jQuery('.disconnectText').html("");
        tiChat_jQuery('.disconnectText').append('<i>Call disconnected</i>');
        tiChat_jQuery('.declineBtn span').addClass("phoneEnd");
    });

    // call mute click
    tiChat_jQuery(document).on("click",".muteBtn",function() {
        muteCall();
    });
