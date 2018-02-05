<?php

class YnTheme_Widget_SwitchSkinsController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {  	
  	
	if(!Zend_Registry::isRegistered('YNTHEME_MANIFEST')){
		return $this->setNoRender(true);
	}
	
	$manifest =  Zend_Registry::get('YNTHEME_MANIFEST');
	
	if(!isset($manifest['skins'])  || !is_array($manifest['skins']) || count($manifest['skins']) < 2){
		return $this->setNoRender(false);
	}

	$this->view->manifest =  $manifest;
	$this->view->theme =  $manifest['package']['name'];
	$this->view->skins =  $manifest['skins'];

  }
}