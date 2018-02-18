<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: default.tpl 10227 2014-05-16 22:43:27Z andres $
 * @author     John
 */ 
?>
<?php $viewer         = Engine_Api::_()->user()->getViewer(); ?>
<?php echo $this->doctype()->__toString() ?>
<?php $locale = $this->locale()->getLocale()->__toString(); $orientation = ( $this->layout()->orientation == 'right-to-left' ? 'rtl' : 'ltr' ); ?>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="<?php echo $locale ?>" lang="<?php echo $locale ?>" dir="<?php echo $orientation ?>">
<head>
    <?php if($this->metaTitle != ''):?>
    <title><?php echo $this->metaTitle; ?> | Rentstarz </title>
    <?php else:?>
    <title>Rentstarz </title>
    <?php endif;?>
    <meta name="google-site-verification" content="IyeQmae8bkHckvyjWGGFzu6S71OhV6jfRUuwlEHRhpE" />
    <script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/scripts/jquery.min.js"></script>
    <script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/scripts/jquery-ui.js"></script>
    <script src="<?php echo $this->baseUrl(); ?>/application/modules/Ynresponsive1/externals/scripts/bootstrap.min.js"></script>
    <script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/scripts/jquery.dialogBox.js"></script>
    <script>jQuery.noConflict();</script>
    
    <link href="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/styles/style.css" rel="stylesheet" type="text/css">
    <link href="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/styles/newstyles.css" rel="stylesheet" type="text/css">
    <link href="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/styles/theme_style.css" rel="stylesheet" type="text/css">
    <link rel="icon" type="image/png" href="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/images/rentstarz_favicon.png" />
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.10.3/themes/blitzer/jquery-ui.css" type="text/css" />
    <link href="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/styles/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet">
    <link href="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/styles/jquery.dialogbox.css" rel="stylesheet" type="text/css">


  <base href="<?php echo rtrim('//' . $_SERVER['HTTP_HOST'] . $this->baseUrl(), '/'). '/' ?>" />


  <?php // ALLOW HOOKS INTO META ?>
  <?php echo $this->hooks('onRenderLayoutDefault', $this) ?>


  <?php // TITLE/META ?>
  <?php
    $counter = (int) $this->layout()->counter;
    $staticBaseUrl = $this->layout()->staticBaseUrl;
    $headIncludes = $this->layout()->headIncludes;

    $request = Zend_Controller_Front::getInstance()->getRequest();
    $this->headTitle()
      ->setSeparator(' - ');
    $pageTitleKey = 'pagetitle-' . $request->getModuleName() . '-' . $request->getActionName()
        . '-' . $request->getControllerName();
    $pageTitle = $this->translate($pageTitleKey);
    if( $pageTitle && $pageTitle != $pageTitleKey ) {
      $this
        ->headTitle($pageTitle, Zend_View_Helper_Placeholder_Container_Abstract::PREPEND);
    }
    $this
      ->headTitle($this->translate($this->layout()->siteinfo['title']), Zend_View_Helper_Placeholder_Container_Abstract::PREPEND)
      ;
    $this->headMeta()
      ->appendHttpEquiv('Content-Type', 'text/html; charset=UTF-8')
      ->appendHttpEquiv('Content-Language', $this->locale()->getLocale()->__toString());

    // Make description and keywords
    $description = '';
    $keywords = '';

    $description .= ' ' .$this->layout()->siteinfo['description'];
    $keywords = $this->layout()->siteinfo['keywords'];

    if( $this->subject() && $this->subject()->getIdentity() ) {
      $this->headTitle($this->subject()->getTitle());

      $description .= ' ' .$this->subject()->getDescription();
      // Remove the white space from left and right side
      $keywords = trim($keywords);
      if ( !empty($keywords) && (strrpos($keywords, ',') !== (strlen($keywords) - 1)) ) {
        $keywords .= ',';
      }
      $keywords .= $this->subject()->getKeywords(',');
    }

    $keywords = trim($keywords, ',');

    $this->headMeta()->appendName('description', trim($description));
    $this->headMeta()->appendName('keywords', trim($keywords));

    // Get body identity
    if( isset($this->layout()->siteinfo['identity']) ) {
      $identity = $this->layout()->siteinfo['identity'];
    } else {
      $identity = $request->getModuleName() . '-' .
          $request->getControllerName() . '-' .
          $request->getActionName();
    }
  ?>
  <?php //echo $this->headTitle()->toString()."\n" ?>

  <?php //echo $this->headTitle($this->metaTitle)."\n"; ?>

  <?php echo $this->headMeta()->toString()."\n" ?>


  <?php // LINK/STYLES ?>
  <?php
    $this->headLink(array(
      'rel' => 'favicon',
      'href' => ( isset($this->layout()->favicon)
        ? $staticBaseUrl . $this->layout()->favicon
        : '/favicon.ico' ),
      'type' => 'image/x-icon'),
      'PREPEND');
    $themes = array();
    if( !empty($this->layout()->themes) ) {
      $themes = $this->layout()->themes;
    } else {
      $themes = array('default');
    }
    foreach( $themes as $theme ) {
      if( APPLICATION_ENV != 'development' ) {
        $this->headLink()
          ->prependStylesheet($staticBaseUrl . 'application/css.php?request=application/themes/' . $theme . '/theme.css');
      } else {
        $this->headLink()
          ->prependStylesheet(rtrim($this->baseUrl(), '/') . '/application/css.php?request=application/themes/' . $theme . '/theme.css');
      }
    }

  ?>
  <?php echo $this->headLink()->toString()."\n" ?>
  <?php echo $this->headStyle()->toString()."\n" ?>



</head>
<body id="global_page_<?php echo $identity ?>">

 <div class="wrapper">

  <script type="javascript/text">
    if(DetectIpad()){
      $$('a.album_main_upload').setStyle('display', 'none');
      $$('a.album_quick_upload').setStyle('display', 'none');
      $$('a.icon_photos_new').setStyle('display', 'none');
    }

  </script>

  <div id="global_header">
    <?php echo $this->content('header') ?>
  <script>
 jQuery(document).on('click', function (e) {
    if (jQuery(e.target).closest(".user-profile").length === 0) {
        jQuery("#user-profile-submenu").css('display','none');
        jQuery("#user-profile-submenu").removeClass('in');
    }
});



</script>
  </div>
  <div id='global_wrapper'>
    <?php $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); ?>
    <?php
    if($viewer->getIdentity() != 0): 
    // echo $this->content()->renderWidget('user.image-header');
    endif; 
    ?>

    <div id='global_content'>
      <?php //echo $this->content('global-user', 'before') ?>
      <?php echo $this->layout()->content ?>
      <?php //echo $this->content('global-user', 'after') ?>
    </div>
  </div>


  <div class="push"></div>

   </div>
   <div class="footer">
  <div id="global_footer">
    <?php echo $this->content('footer') ?>
  </div>

  </div>


  <div id="janrainEngageShare" style="display:none">Share</div>
</body>
</html>
