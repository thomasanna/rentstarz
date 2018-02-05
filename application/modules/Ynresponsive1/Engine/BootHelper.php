<?php
/**
 * Zend Framework
 *
 * LICENSE
 *
 * This source file is subject to the new BSD license that is bundled
 * with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://framework.zend.com/license/new-bsd
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@zend.com so we can send you a copy immediately.
 *
 * @category   Zend
 * @package    Zend_Controller
 * @subpackage Zend_Controller_Action_Helper
 * @copyright  Copyright (c) 2005-2009 Zend Technologies USA Inc. (http://www.zend.com)
 * @license    http://framework.zend.com/license/new-bsd     New BSD License
 * @version    $Id: ViewRenderer.php 16541 2009-07-07 06:59:03Z bkarwin $
 */

/**
 * @see Zend_Controller_Action_Helper_Abstract
 */
// require_once 'Zend/Controller/Action/Helper/Abstract.php';

/**
 * @see Zend_View
 */
// require_once 'Zend/View.php';

/**
 * View script integration
 *
 * Zend_Controller_Action_Helper_ViewRenderer provides transparent view
 * integration for action controllers. It allows you to create a view object
 * once, and populate it throughout all actions. Several global options may be
 * set:
 *
 * - noController: if set true, render() will not look for view scripts in
 *   subdirectories named after the controller
 * - viewSuffix: what view script filename suffix to use
 *
 * The helper autoinitializes the action controller view preDispatch(). It
 * determines the path to the class file, and then determines the view base
 * directory from there. It also uses the module name as a class prefix for
 * helpers and views such that if your module name is 'Search', it will set the
 * helper class prefix to 'Search_View_Helper' and the filter class prefix to ;
 * 'Search_View_Filter'.
 *
 * Usage:
 * <code>
 * // In your bootstrap:
 * Zend_Controller_Action_HelperBroker::addHelper(new Zend_Controller_Action_Helper_ViewRenderer());
 *
 * // In your action controller methods:
 * $viewHelper = $this->_helper->getHelper('view');
 *
 * // Don't use controller subdirectories
 * $viewHelper->setNoController(true);
 *
 * // Specify a different script to render:
 * $this->_helper->viewRenderer('form');
 *
 * </code>
 *
 * @uses       Zend_Controller_Action_Helper_Abstract
 * @package    Zend_Controller
 * @subpackage Zend_Controller_Action_Helper
 * @copyright  Copyright (c) 2005-2009 Zend Technologies USA Inc. (http://www.zend.com)
 * @license    http://framework.zend.com/license/new-bsd     New BSD License
 */
class Ynresponsive1_BootHelper extends Zend_Controller_Action_Helper_Abstract
{
	/**
	* @var Zend_View_Interface
	*/
	public $view;

	/**
	* postDispatch - auto render a view
	*
	* Only autorenders if:
	* - _noRender is false
	* - action controller is present
	* - request has not been re-dispatched (i.e., _forward() has not been called)
	* - response is not a redirect
	*
	* @return void
	*/
	public function postDispatch()
	{

	  	$request = Zend_Controller_Front::getInstance() -> getRequest();
	  	$controller_name = $request -> getControllerName();
	  	if (strpos($controller_name,'admin-') !== false)
	  	{
	  		return;
	  	}
	  	$view  =  Zend_Registry::get('Zend_View');
		
		// init for mobile view
	  	$view -> doctype('HTML5');

	  	$view->headMeta()
	  	->appendHttpEquiv('X-UA-Compatible', 'IE=edge');

	  	$view ->headMeta()->appendName("viewport","width=device-width, minimum-scale=0.25, maximum-scale=1, user-scalable=no");

	  	$PORTING = array(
	  		'album.album.view' => 'album',
	  		'album.index.browse' => 'album',
	  		);

	  	$full_name = implode('.', array(
	  		$request -> getModuleName(),
	  		$request -> getControllerName(),
	  		$request -> getActionName()
	  		));

  		$staticUrl = $view -> layout() -> staticBaseUrl;
        $protocol = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off' || $_SERVER['SERVER_PORT'] == 443) ? "https://" : "http://";

        if ( YNRESPONSIVE_ACTIVE == "ynresponsive-event" ) 
        {
            $view -> headScript() -> appendFile($staticUrl.'application/modules/Ynresponsive1/externals/scripts/jquery-1.7.min.js');
        }
        else 
        {
            $view -> headScript() -> appendFile($staticUrl.'application/modules/Ynresponsive1/externals/scripts/jquery-1.11.2.min.js');
            $view -> headScript() -> appendFile($protocol.'code.jquery.com/jquery-migrate-1.2.1.min.js');
        }
	  	$view -> headScript() -> appendScript('jQuery.noConflict();');
        $view -> headScript() -> appendFile($staticUrl . 'application/modules/Ynresponsive1/externals/scripts/bootstrap.min.js');
		$view -> headScript() -> appendFile($staticUrl . 'application/modules/Ynresponsive1/externals/ParallaxSlider/js/jquery.easing.1.3.js');

		// init for bootstrap
        if ( YNRESPONSIVE_ACTIVE == "ynresponsive-event" ) 
        {
            $view -> headLink() -> appendStylesheet('http://fonts.googleapis.com/css?family=Oswald:300&subset=latin,latin-ext');
        }
		else if(YNRESPONSIVE_ACTIVE == "ynresponsive-photo")
		{
			$view -> headLink() -> appendStylesheet($protocol.'fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,700,600,800&subset=latin,vietnamese');
		}
		else
		{
	  	    $view -> headLink() -> appendStylesheet($protocol.'fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800&subset=latin,vietnamese');
        }
            
	  	$view -> headLink() -> appendStylesheet($staticUrl . 'application/modules/Ynresponsive1/externals/styles/bootstrap.min.css');
	  	$view -> headLink() -> appendStylesheet($staticUrl . 'application/css.php?request=application/themes/'.YNRESPONSIVE_ACTIVE.'/grid.css');

		/**
		 * parallax slider
		 */
		$view -> headScript() -> appendFile($staticUrl . 'application/modules/Ynresponsive1/externals/ParallaxSlider/js/slider.js');
		$view -> headLink() -> appendStylesheet($staticUrl . 'application/modules/Ynresponsive1/externals/ParallaxSlider/css/style.css');

		/**
		 * flex slider
		 */
		$view -> headScript() -> appendFile($staticUrl . 'application/modules/Ynresponsive1/externals/FlexSlider/modernizr.js');
		$view -> headScript() -> appendFile($staticUrl . 'application/modules/Ynresponsive1/externals/FlexSlider/jquery.flexslider.js');
		$view -> headLink() -> appendStylesheet($staticUrl . 'application/modules/Ynresponsive1/externals/FlexSlider/flexslider.css');

		if (isset($PORTING[$full_name]))
		{
		 	$script_path  =  APPLICATION_PATH . '/application/modules/Ynresponsive1/views/scripts/' . $PORTING[$full_name];
		 	$view -> addScriptPath($script_path);
		}
		
		// the custom style important over all style
		$view -> headLink() -> appendStylesheet($staticUrl . 'application/css.php?request=application/themes/'.YNRESPONSIVE_ACTIVE.'/yncustom.css');
		$view -> headLink() -> appendStylesheet($staticUrl . 'application/css.php?request=application/themes/'.YNRESPONSIVE_ACTIVE.'/yncustom-tablet.css');
		$view -> headLink() -> appendStylesheet($staticUrl . 'application/css.php?request=application/themes/'.YNRESPONSIVE_ACTIVE.'/yncustom-mobile.css');
		
		// check homepage setup
		$db = Engine_Db_Table::getDefaultAdapter();
		$select = new Zend_Db_Select($db);
		$select -> from('engine4_core_pages') -> where('name = ?', 'ynresponsive1_index_dashboard') -> limit(1);
		$info = $select -> query() -> fetch();
		if($info && YNRESPONSIVE_ACTIVE != 'ynresponsive1')
		{
			$view -> headLink() -> appendStylesheet($staticUrl . 'application/css.php?request=application/themes/'.YNRESPONSIVE_ACTIVE.'/yncustom-homepage.css');
		}

		
		$view -> headScript() -> appendFile($staticUrl . 'application/modules/Ynresponsive1/externals/scripts/yncustom.js');
		
		// check module responsive file
		$view -> headLink() -> appendStylesheet($staticUrl . 'application/css.php?request=application/themes/'.YNRESPONSIVE_ACTIVE.'/ynresponsive1.css');
        
       	/*
		remove not check device js (only html)
        */
		if(Engine_Api::_()->ynresponsive1()->isMobile())
		{
			$view -> headLink() -> appendStylesheet($staticUrl . 'application/modules/Ynresponsive1/externals/styles/fix-mobile.css');
			$view -> headScript() -> appendFile($staticUrl . 'application/modules/Ynresponsive1/externals/scripts/fix-mobile.js');
		}
		
		if ( YNRESPONSIVE_ACTIVE == "ynresponsive-metro" ) 
		{
			/* bxslider */
			
			$view -> headLink() -> prependStylesheet('application/themes/ynresponsive-metro/jquery.bxslider.css');
			$view -> headScript() -> appendFile('application/themes/ynresponsive-metro/scripts/jquery.bxslider.min.js');
			
			/* animation */
			
			$view -> headLink() -> prependStylesheet('application/themes/ynresponsive-metro/animate.css');
			$view -> headScript() -> appendFile('application/themes/ynresponsive-metro/scripts/jquery.viewportchecker.js');
			$view -> headScript() -> appendFile('application/themes/ynresponsive-metro/scripts/animation.js');
			
			//check logged in
			if(!Engine_Api::_()->user()->getViewer()->getIdentity()){
				$view -> headLink() -> appendStylesheet($staticUrl . 'application/css.php?request=application/themes/'.YNRESPONSIVE_ACTIVE.'/yncustom-notlogin.css');
			}else{
				$view -> headLink() -> appendStylesheet($staticUrl . 'application/css.php?request=application/themes/'.YNRESPONSIVE_ACTIVE.'/yncustom-login.css');
			}	
		}

		$bootstrap_script = "
			window.addEvent('domready', function(){
				$$('body')[0].addClass('".YNRESPONSIVE_ACTIVE."');
			});";
		$view->headScript()->appendScript( $bootstrap_script );
	}

}
