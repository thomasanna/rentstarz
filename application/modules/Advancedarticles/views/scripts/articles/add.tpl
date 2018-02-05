<?php
  $this->headScript()
    ->appendFile($this->baseUrl().'/externals/autocompleter/Autocompleter.js')
    ->appendFile($this->baseUrl().'/externals/autocompleter/Autocompleter.Local.js')
    ->appendFile($this->baseUrl().'/externals/autocompleter/Autocompleter.Request.js')
    ->appendFile($this->baseUrl().'/externals/autocompleter/Observer.js');
?>
<?php echo $this->content()->renderWidget('advancedarticles.actions-block') ?>
<?php echo $this->partial('_jsSwitch.tpl', 'fields'); ?>

<?php if( $this->max_upload > 0 && $this->max_upload <= $this->total_articles ): ?>
    <div class="tip">
      <span>
        <?php echo $this->translate('You have already created the maximum number of articles allowed.');?>
        <?php echo $this->translate('If you would like to create a new article, please %1$sdelete%2$s an old one first.', '<a href="'.$this->url(array('action' => 'my'), "advancedarticles_general").'">', '</a>'); ?>
      </span>
    </div>
<?php return; endif; ?>
<style>
.global_form > div > div
{
  width: 820px;
}
.global_form div.form-element
{
  max-width: 600px;
}
</style>
<div class="global_form">
  <?php echo $this->form->render($this) ?>
</div>
<script type="text/javascript">

  en4.core.runonce.add(function()
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
  });
</script>
