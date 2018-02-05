<?php

class User_Form_Admin_Manage_Addratingquestions extends Engine_Form
{
  public function init()
  {
    
    $this->addElement('Textarea', 'question', array(
      'label' => 'Question',
      'allowEmpty' => false,
      'required' => true,
    )); 

    $this->addElement('Select', 'profile_type', array(

	  'label' => 'Profile Type',
	  'order' => -1000000,
	  //'multioptions' => array(''=>'',1 => 'Leagal Aide',2 => 'Process Server', 3 => 'Lawyer', 4 => 'Paralegal'),
	  'multioptions' => array(4 => 'Landlord', 1 => 'Renter'),

	
	));
	
	$this->addElement('radio', 'status', array(
    'label'=>'Question Status',
    'multiOptions'=>array(
        '0' => 'Positive',
        '-1' => 'Negative',
    ),
    ));
	
     // Buttons
    $this->addElement('Button', 'submit', array(
      'label' => 'Save Changes',
      'type' => 'submit',
      'ignore' => true,
      'decorators' => array(
        'ViewHelper',
      ),
    ));

    $this->addElement('Cancel', 'cancel', array(
      'label' => 'back',
      //'link' => true,
      'prependText' => ' or ',
      'attribs' => array('onclick'=>'history.go(-2); return false;'),
      'decorators' => array(
        'ViewHelper',
      ),
    ));
    
    $this->addDisplayGroup(array('submit', 'cancel'), 'buttons', array(
      'decorators' => array(
        'FormElements',
        'DivDivDivWrapper',
      ),
    )); 

  }
  
 } 
 

