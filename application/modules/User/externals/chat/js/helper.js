var tiChat_jQuery              =   jQuery.noConflict();
var tiChat_isiDevice           =   /ipad|iphone|ipod/i.test(navigator.userAgent.toLowerCase());
var tiChat_isAndroid           =   /android/i.test(navigator.userAgent.toLowerCase());
var tiChat_isBlackBerry        =   /blackberry/i.test(navigator.userAgent.toLowerCase());
var tiChat_isWindowsPhone      =   /windows phone/i.test(navigator.userAgent.toLowerCase());
// Safari 3.0+ "[object HTMLElementConstructor]"
var tiChat_isSafari            =   /constructor/i.test(window.HTMLElement) || (function (p) { return p.toString() === "[object SafariRemoteNotification]"; })(!window['safari'] || (typeof safari !== 'undefined' && safari.pushNotification));
var tiChat_DeviceType;

if(tiChat_isiDevice || tiChat_isAndroid || tiChat_isBlackBerry || tiChat_isWindowsPhone){
    tiChat_DeviceType   =  1;
} else {
    tiChat_DeviceType   =  2;
}

var tiChat_isIOS               =   /iPad|iPhone|iPod/.test(navigator.userAgent) && !window.MSStream;
var tiChat_windowHeight        =   tiChat_jQuery(window).height();

// Function to add js/css
function tiChat_Loadjscssfile(filename, filetype) {
    var fileref;
    if (filetype=="js") { //if filename is a external JavaScript file
        fileref=document.createElement('script')
        fileref.setAttribute("type","text/javascript")
        fileref.setAttribute("src", filename)
    } else if (filetype=="css") { //if filename is an external CSS file
        fileref=document.createElement("link")
        fileref.setAttribute("rel", "stylesheet")
        fileref.setAttribute("type", "text/css")
        fileref.setAttribute("href", filename)
    }
    document.body.appendChild(fileref);
}

// Function to replace js/css
function tiChat_Replacejscssfile(oldfilename, newfilename, filetype) {
    var targetelement=(filetype=="js")? "script" : (filetype=="css")? "link" : "none" //determine element type to create nodelist using
    var targetattr=(filetype=="js")? "src" : (filetype=="css")? "href" : "none" //determine corresponding attribute to test for
    var allsuspects=document.getElementsByTagName(targetelement)
    for (var i=allsuspects.length; i>=0; i--) { //search backwards within nodelist for matching elements to remove
        if (allsuspects[i] && allsuspects[i].getAttribute(targetattr)!=null && allsuspects[i].getAttribute(targetattr).indexOf(oldfilename)!=-1){
            var newelement=createjscssfile(newfilename, filetype)
            allsuspects[i].parentNode.replaceChild(newelement, allsuspects[i])
        }
    }
}


// Function to remove css/js file
function tiChat_Removejscssfile(filename, filetype){
    var targetelement=(filetype=="js")? "script" : (filetype=="css")? "link" : "none" //determine element type to create nodelist from
    var targetattr=(filetype=="js")? "src" : (filetype=="css")? "href" : "none" //determine corresponding attribute to test for
    var allsuspects=document.getElementsByTagName(targetelement)
    for (var i=allsuspects.length; i>=0; i--) { //search backwards within nodelist for matching elements to remove
        if (allsuspects[i] && allsuspects[i].getAttribute(targetattr)!=null && allsuspects[i].getAttribute(targetattr).indexOf(filename)!=-1) {
            allsuspects[i].parentNode.removeChild(allsuspects[i]) //remove element by calling parentNode.removeChild()
        }
    }

}


/*tiChat_Loadjscssfile("/application/modules/User/externals/chat/css/style.css", "css");
tiChat_Loadjscssfile("/application/modules/User/externals/chat/css/responsive-style.css", "css");
tiChat_Loadjscssfile("https://cdnjs.cloudflare.com/ajax/libs/jquery.perfect-scrollbar/0.7.0/css/perfect-scrollbar.min.css", "css");

tiChat_Loadjscssfile("/application/modules/User/externals/chat/js/sails.io.js", "js");
tiChat_Loadjscssfile("https://cdnjs.cloudflare.com/ajax/libs/jquery.perfect-scrollbar/0.7.0/js/perfect-scrollbar.jquery.min.js", "js");
tiChat_Loadjscssfile("https://cdnjs.cloudflare.com/ajax/libs/jquery-mousewheel/3.1.13/jquery.mousewheel.min.js", "js");
tiChat_Loadjscssfile("/application/modules/User/externals/chat/js/config.js", "js");
tiChat_Loadjscssfile("/application/modules/User/externals/chat/js/chatFunctions.js", "js");
tiChat_Loadjscssfile("/application/modules/User/externals/chat/js/websocketRequest.js", "js");
tiChat_Loadjscssfile("/application/modules/User/externals/chat/js/websocket.js", "js");
tiChat_Loadjscssfile("/application/modules/User/externals/chat/js/chatPageScripts.js", "js");
tiChat_Loadjscssfile("/application/modules/User/externals/chat/js/webrtc.js", "js");*/

