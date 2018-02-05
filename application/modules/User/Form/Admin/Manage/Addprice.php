<?php

class User_Form_Admin_Manage_Addprice extends Engine_Form
{
  public function init()
  {
    
    $this->addElement('Text', 'price_from', array(
      'label' => 'Price range from',
      //'multioptions' => array(''=>'','Feed Preference' => 'Feed Preference','Create Rental Application' => 'Create Rental Application', 'Verification' => 'Verification', 'Start Looking' => 'Start Looking', 'Schedule Live Viewing' => 'Schedule Live Viewing'),
      'allowEmpty' => false,
      'required' => true,
    )); 
    $this->addElement('Text', 'price_to', array(
      'label' => 'Price range to',
      'allowEmpty' => false,
      'required' => true,
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
 

