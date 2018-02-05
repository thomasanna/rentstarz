<?php

class User_Form_Admin_Manage_Editprice extends Engine_Form
{
	
	protected $_priceIdentity;
  
    public function setpriceIdentity($_priceIdentity)
    {
    $this->_priceIdentity = (int) $_priceIdentity;
    return $this;
    }
    public function init()
    {
      $price_table =  Engine_Api::_()->getDbtable('price', 'user');
	  $oprice= $price_table->fetchRow(array(
      'id = ?' => $this->_priceIdentity,
    )); 
    $this->addElement('Text', 'price_from', array(
      'label' => 'Price range from',
      'allowEmpty' => false,
      'required' => true,
      'value' => $oprice->price_from,
    )); 
    $this->addElement('Text', 'price_to', array(
      'label' => 'Price range to',
      'allowEmpty' => false,
      'required' => true,
      'value' => $oprice->price_to,
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
 

