<div class="global_form_popup">
  <?php echo $this->form->setAttrib('class', '')->render($this) ?>

</div>

<?php 

$action_id  = $this->action_id;

$action       = Engine_Api::_()->getDbtable('actions', 'activity')->getActionById($action_id);

$body = $action->body;

?>
<script>
	
function htmlEntities(str) {
	
    return String(str).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
}
	
jQuery( document ).ready(function() {
	
var body = '<?php echo $body;?>'; 

var body = sanitize(body); 



jQuery('#editpostbody').val(body);

});

var protos = document.body.constructor === window.HTMLBodyElement;

 validHTMLTags  =/^(?:a|abbr|acronym|address|applet|area|article|aside|audio|b|base|basefont|bdi|bdo|bgsound|big|blink|blockquote|body|br|button|canvas|caption|center|cite|code|col|colgroup|data|datalist|dd|del|details|dfn|dir|div|dl|dt|em|embed|fieldset|figcaption|figure|font|footer|form|frame|frameset|h1|h2|h3|h4|h5|h6|head|header|hgroup|hr|html|i|iframe|img|input|ins|isindex|kbd|keygen|label|legend|li|link|listing|main|map|mark|marquee|menu|menuitem|meta|meter|nav|nobr|noframes|noscript|object|ol|optgroup|option|output|p|param|plaintext|pre|progress|q|rp|rt|ruby|s|samp|script|section|select|small|source|spacer|span|strike|strong|style|sub|summary|sup|table|tbody|td|textarea|tfoot|th|thead|time|title|tr|track|tt|u|ul|var|video|wbr|xmp)$/i;

function sanitize(txt) {
    var // This regex normalises anything between quotes
        normaliseQuotes = /=(["'])(?=[^\1]*[<>])[^\1]*\1/g,
        normaliseFn = function ($0, q, sym) { 
            return $0.replace(/</g, '&lt;').replace(/>/g, '&gt;'); 
        },
        replaceInvalid = function ($0, tag, off, txt) {
            var 
                // Is it a valid tag?
                invalidTag = protos && 
                    document.createElement(tag) instanceof HTMLUnknownElement
                 || !validHTMLTags.test(tag),
                
                // Is the tag complete?
                isComplete = txt.slice(off+1).search(/^[^<]+>/) > -1;
            
            return invalidTag || !isComplete ? '&lt;' + tag : $0;
        };
   
    txt = txt.replace(normaliseQuotes, normaliseFn)
             .replace(/<(\w+)/g, replaceInvalid);
    
    var tmp = document.createElement("DIV");
    tmp.innerHTML = txt;
    
    return "textContent" in tmp ? tmp.textContent : tmp.innerHTML;
}
</script>


