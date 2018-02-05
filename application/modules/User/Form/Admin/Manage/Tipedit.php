<?php

class User_Form_Admin_Manage_Tipedit extends Engine_Form
{
	
	protected $_tipIdentity;
  
    public function settipIdentity($_tipIdentity)
    {
    $this->_tipIdentity = (int) $_tipIdentity;
    return $this;
    }
    public function init()
    {
      $tips_table =  Engine_Api::_()->getDbtable('tips', 'user');
	  $otip= $tips_table->fetchRow(array(
      'id = ?' => $this->_tipIdentity,
    )); 
    $this->addElement('Textarea', 'content', array(
      'label' => 'Content',
      'allowEmpty' => false,
      'required' => true,
      'value' => $otip->content,
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
 

