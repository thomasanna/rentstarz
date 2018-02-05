<?php

class User_Form_Admin_Manage_Addsmartmoveapiquestions extends Engine_Form
{
  public function init()
  {
    
    $this->addElement('Textarea', 'QuestionText', array(
      'label' => 'Question Text',
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
 

