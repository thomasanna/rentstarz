<H2>
<?php echo $this->PluginTitle ?><br>
</H2>
<?php $this->headScript()->appendFile($this->baseUrl().'/application/modules/Advancedarticles/externals/scripts/formcheck-yui.js');?>
<form id="formDonate" action="https://usd.swreg.org/cgi-bin/s.cgi?s=133827&p=133827-donate80&q=1&v=0&d=0&vp=5" method="post" target="_blank">
<div class="price">
<?php echo $this->translate('If you want to contribute to the further development of free products then you can donate for this purpose any sum of money:') ?>
<input type="text" name="vp" id="summ" value="5"  class="validate['required','digit[1,1000]']" disabled="disabled" /> $ 
<input type="submit" value="" class=button_donate />
</div>
</form>

<script type="text/javascript">
window.addEvent('domready', function(){
    $('summ').disabled = '';
    $('summ').focus();
    new FormCheck('formDonate');
    $('formDonate').addEvent('submit', function(){
        this.action = 'https://usd.swreg.org/cgi-bin/s.cgi?s=133827&p=133827-donate80&q=1&v=0&d=0&vp='+$('summ');
    });
});
</script>
<?php echo $this->PluginDiscr ?><br><br>
<?php if( count($this->navigation) ): ?>
  <div class='tabs'>
    <?php
      // Render the menu
      //->setUlClass()
      echo $this->navigation()->menu()->setContainer($this->navigation)->render()
    ?>
  </div>
<?php endif; ?>

<div class='settings'>
  <?php echo $this->form->render($this) ?>
</div>
<script type="text/javascript">
  var changeLevel =function(level_id){
      //alert(level_id);
    window.location.href= en4.core.baseUrl+'admin/advancedarticles/settings/level/'+level_id;
  }
</script>