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
     <script type='application/ld+json'>
    {
     "@context": "http://schema.org/",
     "@type": "LocalBusiness",
     "name": "Rentstarz LLC",
     "url": "https://www.rentstarz.com",
     "image": "https://www.rentstarz.com/application/modules/User/externals/images/latestlandingimages/logo_optimized4kb.png",
     "description": "Rentstarz is a social driven rental platform. This means we do not rely on real estate agencies nor do we piggy back off of rental platforms to get property listings. Our listings comes straight from landlords and property managers. Simply build your profile and start connecting with landlords and renters all over the country.",
     "address": {
     "@type": "PostalAddress",
     "streetAddress": "1956 Rockaway Parkway",
     "addressLocality": "Brooklyn",
     "addressRegion": "NY",
     "postalCode": "11236",
     "addressCountry": "USA"
      },
     "telephone": "1(877) 5075335"
    }
    </script> 

    <script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/scripts/latestlandingjs/aos.js"></script> 
    <script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/scripts/latestlandingjs/jquery-2.2.4.min.js"></script>
	<script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/scripts/latestlandingjs/jquery.easing.min_optimized.js" type="text/javascript"></script> 
	<script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/scripts/latestlandingjs/swiper.min.js" type="text/javascript"></script> 
	<script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/scripts/latestlandingjs/scripts_optimized.js"></script>
	<script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/scripts/latestlandingjs/bootstrap.min.js"></script>
	<script>jQuery.noConflict();</script>
	
	
    <link rel="icon" type="image/png" href="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/images/rentstarz_favicon.png" />
    <link rel="stylesheet" href="/application/modules/User/externals/styles/latestlanding/jquery-ui.min.css" type="text/css" />
    <link href="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/styles/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="<?php echo $this->baseUrl(); ?>/application/modules/Ynresponsive1/externals/styles/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/styles/latestlanding/styles_optimized.css" type="text/css">
    <link rel="stylesheet" href="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/styles/latestlanding/swiper_optimized.css" type="text/css">
    <link rel="stylesheet" href="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/styles/latestlanding/aos.css" type="text/css">
        <link href="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/styles/newstyles.css" rel="stylesheet" type="text/css">

	<link href="https://fonts.googleapis.com/css?family=Montserrat:300,500,600" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css?family=Khula:300,400,600" rel="stylesheet">
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

  <?php echo $this->headMeta()->toString()."\n" ?>

 
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

  <div id='global_wrapper'>	  
    <div id='global_content'>    
      <?php echo $this->layout()->content ?>   
    </div>
  </div>
 
  <div class="push"></div>
  
   </div>

  <div id="janrainEngageShare" style="display:none">Share</div>
</body>
</html>
