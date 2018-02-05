<?php

class User_Form_Admin_Manage_Createcoverletter extends Engine_Form
{
  public function init()
  {
    
    $this->addElement('Text', 'cover_title', array(
      'label' => 'Title',
      'allowEmpty' => false,
      'required' => true,
    )); 
    $this->addElement('Textarea', 'content', array(
      'label' => 'Content',
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
 

