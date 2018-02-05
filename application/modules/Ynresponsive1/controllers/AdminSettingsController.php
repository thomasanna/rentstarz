<?php

class Ynresponsive1_AdminSettingsController extends Core_Controller_Action_Admin
{
	public function init()
	{
	    $this -> view -> navigation = Engine_Api::_() -> getApi('menus', 'core') -> getNavigation('ynresponsive1_admin_main', array(), 'ynresponsive1_admin_main_settings');
	}

	public function indexAction()
	{
		$this -> view -> form = $form = new Ynresponsive1_Form_Admin_Global();		
		if ($this -> getRequest() -> isPost() && $form -> isValid($this -> _getAllParams()))
		{
			$values = $form -> getValues();
			foreach ($values as $key => $value){
				Engine_Api::_()->getApi('settings', 'core')->setSetting($key, $value);
			}					
			$form -> addNotice('Your changes have been saved.');
		}

	}

}
