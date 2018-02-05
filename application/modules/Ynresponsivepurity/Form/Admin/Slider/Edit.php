<?php
class Ynresponsivepurity_Form_Admin_Slider_Edit extends Ynresponsivepurity_Form_Admin_Slider_Create
{
 	public function init()
	{
		parent::init();
		$this ->setTitle('Edit Slider Item');
		$this -> submit -> setLabel('Edit');
		
		$this -> photo -> setRequired(false);
		$this -> photo -> setLabel("Photo");
		$this -> photo -> setValidators(array());
		$this -> photo -> addValidator('Extension', false, 'jpg,png,gif,jpeg');
	}
}