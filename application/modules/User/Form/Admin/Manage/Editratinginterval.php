<?php

class User_Form_Admin_Manage_Editratinginterval extends Engine_Form
{
	protected $_userIdentity;
	
	
	 public function init()
   {
	$multiOptions = array('' => 'Select days');
	
	for($i=0;$i<=100;$i++){
		     $multiOptions[$i] = $i;
		  
	  } 
    $this->addElement('Select', 'ratinginterval', array(

	  'label' => 'Days',
	  //'multioptions' => array(''=>'',1 => 'Leagal Aide',2 => 'Process Server', 3 => 'Lawyer', 4 => 'Paralegal'),
      'required' => true,
	  'multioptions' => $multiOptions,
	));  

      // Buttons
    $this->addElement('Button', 'submit', array(
      'label' => 'Save Changes',
      'type' => 'submit',
      'ignore' => true,
      'decorators' => array('ViewHelper')
    ));

    $this->addElement('Cancel', 'cancel', array(
      'label' => 'cancel',
      'link' => true,
      'prependText' => ' or ',
      'onclick' => 'parent.Smoothbox.close();',
      'decorators' => array(
        'ViewHelper'
      )
    ));

    $this->addDisplayGroup(array('submit', 'cancel'), 'buttons');
    $button_group = $this->getDisplayGroup('buttons');
    $button_group->addDecorator('DivDivDivWrapper');
   }
}
