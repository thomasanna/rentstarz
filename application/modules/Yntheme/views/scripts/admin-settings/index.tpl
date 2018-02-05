<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Group
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.net/license/
 * @version    $Id: index.tpl 7244 2010-09-01 01:49:53Z john $
 * @author     Jung
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


  <div class='clear'>
    <div class='settings'>

      <?php echo $this->form->render($this); ?>

    </div>
  </div>
     