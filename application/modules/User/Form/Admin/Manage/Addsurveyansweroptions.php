<?php

class User_Form_Admin_Manage_Addsurveyansweroptions extends Engine_Form
{
  public function init()
  {
    
    $this->addElement('Textarea', 'answer', array(
      'label' => 'answer',
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


    $this->addDisplayGroup(array('submit', 'cancel'), 'buttons', array(
      'decorators' => array(
        'FormElements',
        'DivDivDivWrapper',
      ),
    )); 

  
  
  }
  
 } 
 

