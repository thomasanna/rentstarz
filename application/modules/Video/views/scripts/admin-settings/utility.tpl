<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Video
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: utility.tpl 9916 2013-02-15 03:13:27Z alex $
 * @author     Jung
 */
?>

<h2><?php echo $this->translate("Videos Plugin") ?></h2>

<?php if( count($this->navigation) ): ?>
  <div class='tabs'>
    <?php
      // Render the menu
      //->setUlClass()
      echo $this->navigation()->menu()->setContainer($this->navigation)->render()
    ?>
  </div>
<?php endif; ?>

<p>
  <?php echo $this->translate("This page contains utilities to help configure and troubleshoot the video plugin.") ?>
</p>
<br/>

<div class="settings">
  <form onsubmit="return false;">
    <h3><?php echo $this->translate("Ffmpeg Version") ?></h3>
    <?php echo $this->translate("This will display the current installed version of ffmpeg.") ?>
    <br /><br />
    <textarea style="width: 600px;"><?php echo $this->version;?></textarea>
  </form>
</div>
<br/>
<br/>

<div class="settings">
  <form onsubmit="return false;">
    <h3><?php echo $this->translate("Supported Video Formats") ?></h3>
    <?php echo $this->translate('This will run and show the output of "ffmpeg -formats". Please see this page for more info.') ?>
    <br /><br />
    <textarea style="width: 600px;"><?php echo $this->format;?></textarea>
  </form>
</div>
<br/>
<br/>

<?php /*
<div class="settings">
  <form action="<?php echo $this->escape($this->url(array('action' => 'test-encode'))) ?>" enctype="multipart/form-data">
    <h2><?php echo $this->translate("Test Encode") ?></h2>
    <?php echo $this->translate('This will run a test encode. Please upload the file first using Layout -> File & Media Manager.') ?>
    <br/>
    <?php if( !empty($this->testFiles) ): ?>
      <?php echo $this->formSelect('file', null, $this->testFiles) ?>
    <?php endif; ?>
  </form>
</div>
<br/>
<br/>
 * 
 */ ?>
