/*!
 * dialogBox v0.0.1
 * by Liuyuchao
 * Copyright 2015.3
 * Date: Wed Mar 25 2015
 */

 ;(function($,window,document){

 	var pluginName = 'dialogBox',
 		defaults = {

 			width: null, //å¼¹å‡ºå±‚å®½åº¦
 			height: null,  //å¼¹å‡ºå±‚é«˜åº¦
 			autoSize: true,  //æ˜¯å¦è‡ªé€‚åº”å°ºå¯¸,é»˜è®¤è‡ªé€‚åº”
 			autoHide: false,  //æ˜¯å¦è‡ªè‡ªåŠ¨æ¶ˆå¤±ï¼Œé…åˆtimeå‚æ•°å…±ç”¨
 			time: 3000,  //è‡ªåŠ¨æ¶ˆå¤±æ—¶é—´ï¼Œå•ä½æ¯«ç§’
 			zIndex: 99999,  //å¼¹å‡ºå±‚å®šä½å±‚çº§
 			hasMask: false,  //æ˜¯å¦æ˜¾ç¤ºé®ç½©å±‚
 			hasClose: false,  //æ˜¯å¦æ˜¾ç¤ºå…³é—­æŒ‰é’®
 			hasBtn: false,  //æ˜¯å¦æ˜¾ç¤ºæ“ä½œæŒ‰é’®ï¼Œå¦‚å–æ¶ˆï¼Œç¡®å®š
 			confirmValue: null,  //ç¡®å®šæŒ‰é’®æ–‡å­—å†…å®¹
 			confirm: function(){}, //ç‚¹å‡»ç¡®å®šåŽå›žè°ƒå‡½æ•°
 			cancelValue: null,  //å–æ¶ˆæŒ‰é’®æ–‡å­—å†…å®¹
 			cancel: function(){},  //ç‚¹å‡»å–æ¶ˆåŽå›žè°ƒå‡½æ•°ï¼Œé»˜è®¤å…³é—­å¼¹å‡ºæ¡†
 			effect: '', //åŠ¨ç”»æ•ˆæžœï¼šfade(é»˜è®¤),newspaper,fall,scaled,flip-horizontal,flip-vertical,sign,
 			type: '', //å¯¹è¯æ¡†ç±»åž‹ï¼šnormal(æ™®é€šå¯¹è¯æ¡†),correct(æ­£ç¡®/æ“ä½œæˆåŠŸå¯¹è¯æ¡†),error(é”™è¯¯/è­¦å‘Šå¯¹è¯æ¡†)
 			title: '',  //æ ‡é¢˜å†…å®¹ï¼Œå¦‚æžœä¸è®¾ç½®ï¼Œåˆ™è¿žåŒå…³é—­æŒ‰é’®ï¼ˆä¸è®ºè®¾ç½®æ˜¾ç¤ºä¸Žå¦ï¼‰éƒ½ä¸æ˜¾ç¤ºæ ‡é¢˜
 			content: ''  //æ­£æ–‡å†…å®¹ï¼Œå¯ä»¥ä¸ºçº¯å­—ç¬¦ä¸²ï¼Œhtmlæ ‡ç­¾å­—ç¬¦ä¸²ï¼Œä»¥åŠURLåœ°å€ï¼Œå½“contentä¸ºURLåœ°å€æ—¶ï¼Œå°†å†…åµŒç›®æ ‡é¡µé¢çš„iframeã€‚

 		};

 	function DialogBox(element,options){
 		this.element = element;
 		this.settings = $.extend({}, defaults, options);
 		this.init();		
 	}
	
 	DialogBox.prototype = {	

 		//åˆå§‹åŒ–å¼¹å‡ºæ¡†
 		init: function(){
 			var that = this,
 				element = this.element;
 				
 			that.render(element);
 			that.setStyle();
 			that.show();
 			that.trigger(element);
 		},

 		//åˆ›å»ºå¼¹å‡ºæ¡†
 		create: function(element){
 			var that = this,
 				$this = $(element),
 				title =  that.settings.title,
 				hasBtn = that.settings.hasBtn,
 				hasMask = that.settings.hasMask,
 				hasClose = that.settings.hasClose,
 				confirmValue = that.settings.confirmValue,
 				cancelValue = that.settings.cancelValue,
 				dialogHTML = [];


 			if(!title){
 				dialogHTML[0] = '<section id="dialog-box"><div class="dialog-box-container"><div class="dialog-box-content"></div>';			
 			}else{
 				if(!hasClose){
					dialogHTML[0] = '<section id="dialog-box"><div class="dialog-box-container"><div class="dialog-box-title"><h3>'+ title + '</h3></div><div class="dialog-box-content"></div>';
 				}else{					
 					dialogHTML[0] = '<section id="dialog-box"><div class="dialog-box-container"><div class="dialog-box-title"><h3>'+ title + '</h3><span class="dialog-box-close">Ã—</span></div><div class="dialog-box-content"></div>';
 				}
 			}

 			if(!hasBtn){
 				dialogHTML[1] = '</div></section>';
 			}else{
 				if(confirmValue && cancelValue){
 					dialogHTML[1] = '<div class="dialog-btn"><span class="dialog-btn-cancel">' + cancelValue + '</span><span class="dialog-btn-confirm">' + confirmValue + '</span></div></div></section>';
 				}else if(cancelValue){
 					dialogHTML[1] = '<div class="dialog-btn"><span class="dialog-btn-cancel">' + cancelValue + '</span></div></div></section>';
 				}else if(confirmValue){
 					dialogHTML[1] = '<div class="dialog-btn"><span class="dialog-btn-confirm">' + confirmValue + '</span></div></div></section>';
 				}else{
 					dialogHTML[1] = '<div class="dialog-btn"><span class="dialog-btn-cancel">å–æ¶ˆ</span><span class="dialog-btn-confirm">ç¡®å®š</span></div></div></section>';
 				}
 			}

 			if(!hasMask){
 				dialogHTML[2] = '';
 			}else{
 				dialogHTML[2] = '<div id="dialog-box-mask"></div>';
 			}

 			return dialogHTML;	
 		},

 		//æ¸²æŸ“å¼¹å‡ºæ¡†
 		render: function(element){
 			var that = this,
 				$this = $(element),
 				dialogHTML = that.create($this),
 				$content = that.parseContent();
 				
 			$this.replaceWith(dialogHTML[0] + dialogHTML[1]);

 			if(typeof($content) === 'object'){
 				$content.appendTo('.dialog-box-content');
 			}else{
 				$('.dialog-box-content').append($content);
 			}
 			
 			$('body').append(dialogHTML[2]);
 		},

 		//è§£æžå¹¶å¤„ç†å¼¹å‡ºæ¡†å†…å®¹
 		parseContent: function(){
 			var that = this,
 				content = that.settings.content,
 				width = that.settings.width,
 				height = that.settings.height,
 				type = that.settings.type,
 				$iframe = $('<iframe>'),
 				random = '?tmp=' + Math.random(),
 				urlReg = /^(https?:\/\/|\/|\.\/|\.\.\/)/;

 			if(urlReg.test(content)){

 				$iframe.attr({
 					src: content + random,
 					frameborder: 'no',
 					scrolling: 'no',
 					name: 'dialog-box-iframe',
 					id: 'dialog-box-iframe'
 				})
 				.on('load',function(){

 					//åŠ¨æ€è‡ªé€‚åº”iframeé«˜åº¦;
 					var $iframeBody = $(window.frames['dialog-box-iframe'].document.body),
 						iframeWidth = $iframeBody.outerWidth(),
 						iframeHeight = $iframeBody.outerHeight(),
 						$dialogBox = $('#dialog-box'),
 						$content = $('.dialog-box-content'),
 						$container = $('.dialog-box-container');

 						dialogBoxWidth = iframeWidth + 40;
 						dialogBoxHeight = iframeHeight + 126;

 					console.log(iframeWidth);

 					if(that.settings.autoSize){	
 						$(this).width(iframeWidth);
 						$(this).height(iframeHeight);

 						$iframeBody.css({
 							margin: '0',
 							padding: '0'
 						});

 						$dialogBox.css({
 							width: dialogBoxWidth,
 							height: dialogBoxHeight,
 							'margin-top': function(){
 								if(type === '' || type === 'normal'){
 									return -Math.round(dialogBoxHeight/2) + 'px';
 								}else if(type === 'error' || type === 'correct'){
 									dialogBoxHeight = dialogBoxHeight + 4;
 									return -Math.round(dialogBoxHeight/2) + 'px';
 								}	
 							},
 							'margin-left': -Math.round(dialogBoxWidth/2) + 'px'
 						});

 						$content.css({
 							width: iframeWidth,
 							height: iframeHeight
 						});

 						$container.css({
 							width: dialogBoxWidth,
 							height: dialogBoxHeight
 						});

 					}else{
 						$(this).width(that.settings.width - 40);
 						$(this).height(that.settings.height - 126);
 					}
 				});
				return $iframe;
 			}else{
 				return content;
 			}
 		},

 		//æ˜¾ç¤ºå¼¹å‡ºæ¡†
 		show: function(){
 			$('#dialog-box').css({display:'block'});

 			setTimeout(function(){
 				$('#dialog-box').addClass('show');
 			},50)

 			$('#dialog-box-mask').show();
 		},

 		//éšè—å¼¹å‡ºæ¡†
 		hide: function(element){
 			var $this = $(element),
 				$dialogBox = $('#dialog-box'),
 				$iframe = $('#dialogBox-box-iframe');

 			$dialogBox.removeClass('show');

 			setTimeout(function(){
 				if($iframe){
 					$iframe.attr('src','_blank');
 				}

 				$dialogBox.replaceWith('<div id="' + $this.attr('id') + '"></div/>');
 				$('#dialog-box-mask').remove();
 			},150)
 		},

 		//è®¾ç½®å¼¹å‡ºæ¡†æ ·å¼
 		setStyle: function(){
 			var that = this,
 				$dialog = $('#dialog-box'),
 				$container = $('.dialog-box-container'),
 				$content = $('.dialog-box-content'),
 				$mask  = $('#dialog-box-mask'),
 				type = that.settings.type,
 				EFFECT = 'effect';

 			//å¼¹å‡ºæ¡†å¤–æ¡†æ ·å¼
 			$dialog.css({
 				width: function(){
 					if(that.settings.width){
 						return that.settings.width + 'px';
 					}else{
 						return;
 					}
 				},
 				height: function(){
 					if(that.settings.height){
 						return that.settings.height + 'px';
 					}else{
 						return;
 					}
 				},
 				'margin-top': function(){
 					var height;
 					if(type === '' || type === 'normal'){
 						height = $(this).height();
 					}else if(type === 'error' || type === 'correct'){
 						height = $(this).height() + 4;
 					}
 					return -Math.round(height/2) + 'px';
 				},
 				'margin-left': function(){
 					var width = $(this).width();
 					return -Math.round(width/2) + 'px';
 				},
 				'z-index': that.settings.zIndex
 			});

 			//å¼¹å‡ºæ¡†å†…å±‚å®¹å™¨æ ·å¼
 			$container.css({
 				width: function(){
 					if(that.settings.width){
						return that.settings.width + 'px';
 					}else{
 						return;
 					}
 				},
 				height: function(){
 					if(that.settings.height){
 						return that.settings.height + 'px';
 					}else{
 						return;
 					}
 				},
 			});

 			//å¼¹å‡ºæ¡†å†…å®¹æ ·å¼
 			$content.css({
 				width: function(){
 					if(that.settings.width){
 						return that.settings.width - 40 + 'px';
 					}else{
 						return;
 					}
 				},
 				height: function(){
 					if(that.settings.height){
 						return that.settings.height - 126 + 'px';
 					}else{
 						return;
 					}
 				}
 			});

 			//é®ç½©å±‚æ ·å¼
 			$mask.css({
 				height: $(document).height() + 'px'
 			});
 		

 			//åˆ¤æ–­å¼¹å‡ºæ¡†ç±»åž‹
 			switch(that.settings.type){
 				case 'correct':
 					$container.addClass('correct');
 					break;
 				case 'error':
 					$container.addClass('error');
 					break;
 				default:
 					$container.addClass('normal');;
 					break;
 			}

 			//å¼¹å‡ºæ¡†å¤šç§åŠ¨ç”»æ•ˆæžœ
 			switch(that.settings.effect){
 				case 'newspaper':
 					$dialog.addClass(EFFECT + '-newspaper');
 					break;
 				case 'fall':
 					$dialog.addClass(EFFECT + '-fall');
 					break;
 				case 'scaled':
 					$dialog.addClass(EFFECT + '-scaled');
 					break;
 				case 'flip-horizontal':
 					$dialog.addClass(EFFECT + '-flip-horizontal');
 					break;
 				case 'flip-vertical':
 					$dialog.addClass(EFFECT + '-flip-vertical');
 					break;
 				case 'sign':
 					$dialog.addClass(EFFECT + '-sign');
 					break;
 				default:
 					$dialog.addClass(EFFECT + '-fade');
 					break;
 			}

 		},

 		//å¼¹å‡ºæ¡†è§¦å±å™¨(ç³»åˆ—äº‹ä»¶)
 		trigger: function(element,event){
 			var that = this,
 				$this = $(element);

 			$('.dialog-box-close,#dialog-box-mask,.dialog-btn-cancel,.dialog-btn-confirm').on('click',function(){
 				that.hide($this);
 			});

 			$(document).keyup(function(event){
 				if(event.keyCode === 27){
 					that.hide($this);
 				}
 			});

 			if(that.settings.autoHide){
 				setTimeout(function(){
 					that.hide($this);
 				},that.settings.time)
 			}

 			if($.isFunction(that.settings.confirm)){
 				$('.dialog-btn-confirm').on('click',function(){
 					that.settings.confirm();
 				})
 			}

 			if($.isFunction(that.settings.cancel)){
 				$('.dialog-btn-cancel').on('click',function(){
 					that.settings.cancel();
 				})
 			}

 		}

 	};

 	$.fn[pluginName] = function(options) {
        this.each(function() {
            if (!$.data(this, "plugin_" + pluginName)) {
                $.data(this, "plugin_" + pluginName, new DialogBox(this, options));			
			}
        });
		return this;
    };
	
 })(jQuery,window,document)
