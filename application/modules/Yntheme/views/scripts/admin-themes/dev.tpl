<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.net/license/
 * @version    $Id: index.tpl 9412 2011-10-19 21:36:30Z john $
 * @author     Jung
 * 
 */
?>

<h2>
  <?php echo $this->translate("YouNet Theme Plugin") ?>
</h2>


<?php if( count($this->navigation) ): ?>
  <div class='tabs'>
    <?php
      // Render the menu
      //->setUlClass()
      echo $this->navigation()->menu()->setContainer($this->navigation)->render()
    ?>
  </div>
<?php endif; ?>

<?php if(!$this->byYouNet): ?>
<div class="tip">
<span>
  <?php echo $this->translate('CORE_VIEWS_SCRIPTS_YNADMINTHEMES_NOYN_INDEX', $this->activeThemeTitle) ?>
</span>
 </div>
<?php endif; ?>


<style type="text/css">
	li.theme_ele{
		border-top: 1px solid #ddd;
		padding: 10px 0;
	}
	li.theme_ele img{
		border: 1px solid #ddd;
		margin-right: 10px;
		width: 160px;
		height: 140px;
	}
	.theme_ele table td{
		vertical-align: top;
	}
</style>
<script type="text/javascript">
  var modifications = [];
  window.onbeforeunload = function() {
    if( modifications.length > 0 ) {
      return '<?php echo $this->translate("If you leave the page now, your changes will be lost. Are you sure you want to continue?") ?>';
    }
  }
  var pushModification = function(type) {
    modifications.push(type);
  }
  var removeModification = function(type) {
    modifications.erase(type);
  }
  var changeThemeFile = function(file) {
    var url = '<?php echo $this->url() ?>?file=' + file;
    window.location.href = url;
  }
  var saveFileChanges = function() {
    var request = new Request.JSON({
      url : '<?php echo $this->url(array('action' => 'save')) ?>',
      data : {
        'theme_id' : $('theme_id').value,
        'file' : $('file').value,
        'body' : $('body').value,
        'format' : 'json'
      },
      onComplete : function(responseJSON) {
        if( responseJSON.status ) {
          removeModification('body');
          $$('.admin_themes_header_revert').setStyle('display', 'inline');
          alert('<?php echo $this->string()->escapeJavascript($this->translate("Your changes have been saved!")) ?>');
        } else {
          alert('<?php echo $this->string()->escapeJavascript($this->translate("An error has occurred. Changes could NOT be saved.")) ?>');
        }
      }
    });
    request.send();
  }
  var revertThemeFile = function() {
    var answer = confirm('<?php echo $this->string()->escapeJavascript($this->translate("CORE_VIEWS_SCRIPTS_ADMINTHEMES_INDEX_REVERTTHEMEFILE")) ?>');
    if( !answer ) {
      return;
    }

    var request = new Request.JSON({
      url : '<?php echo $this->url(array('action' => 'revert')) ?>',
      data : {
        'theme_id' : '<?php echo $this->activeTheme->theme_id ?>',
        'format' : 'json'
      },
      onComplete : function() {
        removeModification('body');
        window.location.replace( window.location.href );
      }
    });
    request.send();
  }
</script>


<div class="admin_theme_editor_wrapper">
  
    <div class="admin_theme_edit" style="width: 600px">

      <div class="admin_theme_header_controls">
        <h3>
          <?php echo $this->translate('Available Themes') ?>
        </h3>
        <div>
         
        </div>
      </div>
	  <ul>
	  	<?php foreach($this->themes as $theme): 
	  	$thumb = $this->baseUrl() .'/application/themes/'. $theme->name .'/theme.jpg';
	  	?>
	  	<li class="theme_ele">
	  		<table>
	  			<tr>
	  				<td>
	  					<img src="<?php echo $thumb?>"?>			
	  				</td>
	  				<td>
	  					<h3><?php echo $theme->title ?></h3>
	  					<p>Author: <?php echo 'YouNet Company'?></p>
	  					<p>Version: <?php echo '4.01'?></p>
	  					<p>
	  						<a href="<?php echo $this->url(array('theme'=>$theme->name)) ?>"><?php echo $this->translate('View Skins') ?></a>
	  					</p>
	  					<p>
	  					 <?php if($this->activeThemeName == $theme->name): ?>
	  						<strong style="font-weight: bold"><?php echo $this->translate('This is your current theme') ?></strong>	
	  						<p>
		                   	  <a href="<?php echo $this->url(array('action'=>'export-theme','theme'=>$theme->name)) ?>"><?php echo $this->translate('Export This Theme')?></a>
		                   </p>
				          <?php else: ?>
				          	<form action="<?php echo $this->url(array('module'=>'yntheme','controller'=>'themes','action'=>'change','from'=>'yntheme'),'admin_default',true)?>" method="post">
				            <button class="activate_button"><?php echo $this->translate('Activate Theme') ?></button>
				          	<input type="hidden" name="theme" value="<?php echo $theme->name ?>" id="">
				          </form>
				          	<?php endif; ?>
	  					</p>
	  					
	  				</td>
	  			</tr>
	  		</table>	  		
	  	</li>
	  	<?php endforeach; ?>
	  </ul>
    </div>



  <div class="admin_theme_chooser">

    <div class="admin_theme_header_controls">
      <h3>
        <?php echo $this->translate("Available Skins") ?>
      </h3>
      <div>       	
      </div>
    </div>
    <div class="admin_theme_editor_chooser_wrapper">
      <ul class="admin_themes">
        <?php
        // @todo meta key is deprecated and pending removal in 4.1.0; b/c removal in 4.2.0
        $alt_row = true;
        foreach( $this->skins as $skin ):
          $thumb_image = isset($skin['thumb_image'])?$skin['thumb_image']:$this->baseUrl() . '/application/themes/'. $this->theme . '/'. $skin['name'] . '/theme.jpg'; 
          ?>
          
          <li <?php echo ($alt_row) ? ' class="alt_row"' : "";?>>
            <div class="theme_wrapper"><img src="<?php echo $thumb_image ?>" alt="<?php echo $skin['title']?>"></div>
            <div class="theme_chooser_info">
                  <h3><?php echo $skin['title']?></h3>
                    <?php if ( !empty($this->manifest['package']['version'])): ?>
                        <h4 class="version">v<?php echo $this->manifest['package']['version'] ?></h4>
                    <?php endif; ?>
                    <?php if ( !empty($this->manifest['package']['author'])): ?>
                      <h4><?php echo $this->translate('by %s', $this->manifest['package']['author']) ?></h4>
                    <?php endif; ?>
                    <?php if($skin['name'] != $this->defaultSkin):?>
	                   <p>
	                   	  <a href="<?php echo $this->url(array('action'=>'default-skin','theme'=>$this->theme, 'skin'=>$skin['name'])) ?>"><?php echo $this->translate('Set Default')?></a>
	                   </p>
	               <?php else: ?>
	               		<p>This is your default skin.</p>
	               		
                   <?php endif; ?>
           </div>
          </li>
          <?php $alt_row = !$alt_row; ?>
        <?php endforeach; ?>
      </ul>
    </div>

  </div>

</div>

<script type="text/javascript">
//<![CDATA[
var updateCloneLink = function(){
  var value = $$('.theme_name input:checked');
  if (!value)
    return;
  else
    var newValue = value[0].value;
  var link = $$('a.admin_themes_header_clone');
  if (link.length) {
    link.set('href', link[0].href.replace(/\/name\/[^\/]+/, '/name/'+newValue));
  }
}
//]]>
</script>