<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Poll
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.net/license/
 * @version    $Id: AdminSettingsController.php 9076 2011-07-21 02:11:10Z john $
 * @author     Steve
 */

/**
 * @category   Application_Extensions
 * @package    Poll
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.net/license/
 */
class Yntheme_AdminSettingsController extends Core_Controller_Action_Admin
{
	public function unwriteableAction(){
		$this->view->themePath = APPLICATION_PATH . '/application/themes';
	 }
	
	public function checkWriteable($path)
  {
    if( !file_exists($path) ) {
      return false;
    }
    if( !is_writeable($path) ) {
      return false;
    }
	return true;
  }
  protected function _getManifest($theme){
  	$filename =  APPLICATION_PATH . '/application/themes/'. $theme . '/manifest.php';
	$config = array();
	if(file_exists($filename) && is_readable($filename)){
		$config  = include $filename;
	}
	return $config;
  }
		
  public function indexAction()
  {
    $this->view->navigation = $navigation = Engine_Api::_()->getApi('menus', 'core')
    	->getNavigation('yntheme_admin_main', array(), 'yntheme_admin_main_settings');
   
   $path =  APPLICATION_PATH .'/application/themes';
	
	;
	
	if(!$this->checkWriteable($path)){
		return $this->_forward('unwriteable');
	}
	 
    $this->view->form = $form = new Yntheme_Form_Admin_Global();
	
	$allThemes    = Engine_Api::_()->getDbtable('themes', 'core')->fetchAll();
	$themes = array();
	
	// get active theme.
	$this->view->activeThemeName = $activeThemeName =  'default';
	$this->view->activeThemeTitle =  'Default';
	
	
	$activeTheme = $allThemes->getRowMatching('active',1);
	
	if(is_object($activeTheme)){
		$this->view->activeThemeName =  $activeThemeName =  $activeTheme->name;
		$this->view->activeThemeTitle =  $activeTheme->title;
	}
	
	$manifest2=  $this->_getManifest($activeThemeName);
	if(isset($manifest2['package']['author']) && $manifest2['package']['author'] == 'YouNet Company'){
		$this->view->byYouNet = true;
	}else{
		$this->view->byYouNet = false;
	}

    $settings = Engine_Api::_()->getApi('settings', 'core');
	$values =  (array)$settings->yntheme;
    $form->populate($values);

    if( !$this->getRequest()->isPost() ) {
      return;
    }

    if( !$form->isValid($this->getRequest()->getPost()) ) {
      return;
    }

    $db = Engine_Db_Table::getDefaultAdapter();
    $db->beginTransaction();
    try {
      $values = $form->getValues();
      $settings->yntheme = $values;
      
      $db->commit();
    } catch( Exception $e ) {
      $db->rollback();
      throw $e;
    }

    $form->addNotice('Your changes have been saved.');
  }
}