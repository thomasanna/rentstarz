<?php
/*  $this->headScript()
    ->appendFile($this->baseUrl().'/externals/autocompleter/Autocompleter.js')
    ->appendFile($this->baseUrl().'/externals/autocompleter/Autocompleter.Local.js')
    ->appendFile($this->baseUrl().'/externals/autocompleter/Autocompleter.Request.js')
    ->appendFile($this->baseUrl().'/externals/autocompleter/Observer.js');*/

?>
<?php //echo $this->content()->renderWidget('advancedarticles.actions-block') ?>
<?php //echo $this->partial('_jsSwitch.tpl', 'fields'); ?>
<script src='//cdn.tinymce.com/4/tinymce.min.js'></script>
<div class="global_form">
  <?php echo $this->form->render($this) ?>
</div>
<script type="text/javascript">


tinymce.init({
    selector: '#description',
  });
 /* en4.core.runonce.add(function()
  {
	new Autocompleter.Ajax.Json('tags_info', '<?php echo $this->url(array('controller' => 'tag', 'action' => 'suggest'), 'default', true) ?>', {
	        'minLength': 1,
	        'delay' : 300,
			'selectMode': 'pick',
			'autocompleteType': 'tag',
			'className': 'tag-autosuggest',
			'postVar': 'text',
			'multiple' : true,
		    'customChoices' : true,
		    'filterSubset' : true,			
        	'injectChoice': function(tags_info){
	            var choice = new Element('li', {
	              'class': 'autocompleter-choices',
	              'id':tags_info.id,
				  'value':tags_info.label
	            });
	            new Element('div', {
	              'html': this.markQueryValue(tags_info.label),
	              'class': 'autocompleter-choice'
	            }).inject(choice);
				choice.inputValue = tags_info;
	            this.addChoiceEvents(choice).inject(this.choices);
	            choice.store('autocompleteChoice', tags_info);
		    }		
		});  
  });*/
</script>
