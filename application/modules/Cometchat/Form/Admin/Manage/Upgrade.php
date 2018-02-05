<?php

class Cometchat_Form_Admin_Manage_Upgrade extends Engine_Form
{
	public function init(){
	$this -> setTitle('Upload CometChat Zip');
      $this->addElement('File', 'cometchatzip', array(
     'label' => 'Upload CometChat zip file:',
   ));
       $this->addElement('Button', 'submit', array(
     'label' => 'Install now',
     'type' => 'submit',
     'ignore' => true,
   ));
	}
}