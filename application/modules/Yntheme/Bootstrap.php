<?php

class Yntheme_Bootstrap extends Engine_Application_Bootstrap_Abstract
{
	protected function _initYounetTheme(){
		$view =  Zend_Registry::get('Zend_View');	
		$Setting = Engine_Api::_()->getApi('Settings','Core');
		$view->headScript()->appendFile(Zend_Registry::get('StaticBaseUrl') 
        	.'application/modules/Yntheme/externals/scripts/core.js');
		
		
		$enabled = $Setting->getSetting('yntheme.enabled',false);
		
		$themes = $view->layout()->themes;
		$theme = $themes[0];
		
		$filename = APPLICATION_PATH . '/application/themes/'. $theme .'/manifest.php';
		if(!file_exists($filename)){
			return ;
		}
		
		$manifest =  include $filename;
		
		if(!isset($manifest['skins']) || !is_array($manifest['skins'])){
			return ;
		}
		
		if($enabled){
			Zend_Registry::set('YNTHEME_MANIFEST',$manifest);
		}
		
		if( empty($view->layout()->themes) ) {
		  $view->layout()->themes = array("default");
		}

		$themes = $view->layout()->themes;
		$theme =  array_shift($themes);		
		
		$settingKey = 'ynthemedefault.'. $theme;
		$settingValue =  $Setting->getSetting($settingKey,'default');
		$skin =  NULL;
		
		
		if($enabled && isset($_COOKIE['yntheme_skin']) && $_COOKIE['yntheme_skin']){
			$dir =  $_COOKIE['yntheme_skin'];
			$filename = APPLICATION_PATH . '/application/themes/' . $theme . '/'. $dir. '/theme.css';
			if(is_readable($filename)){
				$skin = $dir;
			}else if($dir == 'default'){
				$skin = 'default';
			}
		}
		
		if($skin == NULL &&  $settingValue != 'default'){
			$filename = APPLICATION_PATH . '/application/themes/' . $theme . '/'. $settingValue. '/theme.css';
			if(is_readable($filename)){
				$skin = $settingValue;
			}
		}
		
		if($skin != 'default'){
			$theme =  $theme .'/' . $skin;
		}
		
		$view->layout()->themes =  array($theme);
	}
}