<?php

class User_Form_Admin_Manage_Addsurveyquestions extends Engine_Form
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
	  'multioptions' => array(4 => 'Landlord', 1 => 'Renter'),

	
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
      'attribs' => array('onclick'=>'history.go(-1); return false;'),
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
 

