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

    <link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Muli" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/assets/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/assets/css/font-awesome.css" rel="stylesheet">
    <link rel="stylesheet" href="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/assets/css/style.css" rel="stylesheet">
    <link rel="stylesheet" href="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/assets/css/slick.css" rel="stylesheet">
    <link rel="stylesheet" href="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/assets/css/custom.css" rel="stylesheet">
    <link rel="stylesheet" href="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/assets/css/sh.css" rel="stylesheet">

    <script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/assets/js/jquery-3.1.1.min.js"></script>
    <script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/assets/js/bootstrap.min.js"></script>
    <script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/assets/js/slick.min.js"></script>
    <script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/assets/js/paginathing.min.js"></script>
    <script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/assets/js/custom.js"></script> 
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
<body id="global_page_<?php echo $identity ?>" class="landing">
      <?php echo $this->layout()->content ?> 
      <?php echo $this->content()->renderWidget('user.footer'); ?> 
</body>
</html>
