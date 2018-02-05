<h2><?php echo $this->translate("YouNet Responsive Plugin") ?></h2>	
<?php if (count($this->navigation)): ?>
    <div class='tabs'>
        <?php
        // Render the menu
        echo $this->navigation()->menu()->setContainer($this->navigation)->render()
        ?>
    </div>
<?php endif; ?>
<div class='clear'>
  <div class='settings'>
    <?php echo $this->form->render($this); ?>
  </div>
</div>
<script type="text/javascript">
	var customHome = 0;
    if($('ynresponsive1_setuphomepage-1').checked)
    {
    	customHome = 1;
    }
	var customHomePage = function()
	{
		if($('ynresponsive1_setuphomepage-1').checked && customHome == 0)
	    {
	    	new Request.JSON({
              'format': 'json',
              'url' : '<?php echo $this->baseUrl(); ?>/application/lite.php?module=ynresponsive1&name=homepagesetup',
              'data' : {
                'format' : 'json',
              },
              'onRequest' : function(){
              },
              'onSuccess' : function(responseJSON, responseText)
              {
              }
            }).send();
	    }
	    else if($('ynresponsive1_setuphomepage-0').checked && customHome == 1)
	    {
	    	new Request.JSON({
              'format': 'json',
              'url' : '<?php echo $this->baseUrl(); ?>/application/lite.php?module=ynresponsive1&name=homepagereset',
              'data' : {
                'format' : 'json',
              },
              'onRequest' : function(){
              },
              'onSuccess' : function(responseJSON, responseText)
              {
              }
            }).send();
	    }
	}
</script>