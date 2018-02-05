<h2>
  <?php echo $this->translate("Advanced Articles") ?>
</h2>
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
<p>
  <?php echo $this->translate("ADVANCED_ARTICLES_DESCRIPTION") ?>
</p>
<br/>
<?php if( count($this->navigation) ): ?>
  <div class='tabs'>
    <?php
      // Render the menu
      //->setUlClass()
      echo $this->navigation()->menu()->setContainer($this->navigation)->render()
    ?>
  </div>
<?php endif; ?>
<?php echo $this->content()->renderWidget('advancedarticles.more-plugins') ?>
