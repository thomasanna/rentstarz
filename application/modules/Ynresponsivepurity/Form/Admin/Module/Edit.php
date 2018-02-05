<?php
class Ynresponsivepurity_Form_Admin_Module_Edit extends Ynresponsivepurity_Form_Admin_Module_Create
{
 	public function init()
	{
		parent::init();
		$this ->setTitle('Edit Welcome Item');
		$this -> submit -> setLabel('Edit');
		
		$this -> photo -> setRequired(false);
		$this -> photo -> setLabel("Icon");
		$this -> photo -> setValidators(array());
		$this -> photo -> addValidator('Extension', false, 'jpg,png,gif,jpeg');

		$this -> hover_photo -> setRequired(false);
		$this -> hover_photo -> setLabel("Hover Icon");
		$this -> hover_photo -> setValidators(array());
		$this -> hover_photo -> addValidator('Extension', false, 'jpg,png,gif,jpeg');
	}
}