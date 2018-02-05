<?php

class User_Form_Admin_Manage_Editcountry extends Engine_Form
{
	
	protected $_countryIdentity;
  
    public function setCountryIdentity($countryIdentity)
    {
    $this->_countryIdentity = (int) $countryIdentity;
    return $this;
    }
    public function init()
   {
  
     $country   =  Engine_Api::_()->getDbtable('countries', 'user');
	  $oCountry = $country->fetchRow(array(
      'id = ?' => $this->_countryIdentity,
    )); 

    $this->addElement('Text', 'country', array(
      'label' => 'Country',
      'allowEmpty' => false,
      'required' => true,
      'value' => $oCountry->country,
    )); 
    $this->addElement('hidden', 'cid', array(
      'label' => 'id',
      'allowEmpty' => false,
      'required' => true,
      'value' => $this->_countryIdentity,
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
 

