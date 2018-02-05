<?php echo $this->partial('_jsSwitch.tpl', 'fields'); ?>
<?php echo $this->form->render($this) ?>
<br />
<script type="text/javascript">
window.addEvent('domready', function(){
    $('done').addEvent('click', function(e){
        $('owner').set('value', '');
        $('start').set('value', '');
        $('end').set('value', '');
        $('tag').set('value', '');
        $('formFilter').submit();
    });
    $('isFilter').set('value', 1);
    
    if ($$('.a_formFilter') != null)
    $$('.a_formFilter').addEvent('click', function(e){
        $('owner').set('value', this.id);
        $('formFilter').submit();
    });    
});
</script>