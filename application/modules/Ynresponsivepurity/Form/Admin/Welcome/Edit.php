<?php
class Ynresponsivepurity_Form_Admin_Welcome_Edit extends Ynresponsivepurity_Form_Admin_Welcome_Create
{
 	public function init()
	{
		parent::init();
		$this ->setTitle('Edit Welcome Item');
		$this -> submit -> setLabel('Edit');
		
		$this -> photo -> setRequired(false);
		$this -> photo -> setLabel("Photo");
		$this -> photo -> setValidators(array());
		$this -> photo -> addValidator('Extension', false, 'jpg,png,gif,jpeg');
	}
}