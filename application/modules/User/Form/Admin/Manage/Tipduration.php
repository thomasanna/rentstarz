<?php

class User_Form_Admin_Manage_Tipduration extends Engine_Form
{
    public function init()
   {
      $tips_table =  Engine_Api::_()->getDbtable('commonsettings', 'user');
	  $otip= $tips_table->fetchRow(array(
      'type = ?' => 'tip_duration',
    ));  
    
    $this->addElement('Text', 'value', array(
      'label' => 'Duration in Hour',
      'allowEmpty' => false,
      'required' => true,
      'value' => $otip->value,
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
 

