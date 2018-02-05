/*  JavaScript Document                       */
/*  Written by Chris Converse for Lynda.com   */

jQuery(document).ready(function() {

	jQuery('.faq').each(function(){
		jQuery(this).append('<div class="letter_q"></div><div class="letter_a"></div>');
	});
	
	jQuery('.faq_question').click(function(){
		if (jQuery(this).parent().is('.open')) {
			jQuery(this).closest('.faq').find('.faq_answer_container').animate({'height':'0'},500);
			jQuery(this).closest('.faq').find('.letter_a').fadeOut(500);
			jQuery(this).closest('.faq').find('.letter_q').animate({'left':'25px'});
			jQuery(this).closest('.faq').removeClass('open');
		}else{
			var newHeight = jQuery(this).closest('.faq').find('.faq_answer').height() + 'px';
			jQuery(this).closest('.faq').find('.faq_answer_container').animate({'height':newHeight},500);
			jQuery(this).closest('.faq').find('.letter_a').fadeIn(500);
			jQuery(this).closest('.faq').find('.letter_q').animate({'left':'10px'});
			jQuery(this).closest('.faq').addClass('open');
		}
	});
	findAnchorLink();
    			
});

function findAnchorLink(){
	if (location.href.indexOf('#') != -1) {
		var namedAnchor = window.location.hash;
		var faqToFind = namedAnchor + ' .faq_question';
		jQuery(faqToFind).trigger('click');
	}
}

