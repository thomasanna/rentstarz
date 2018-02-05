<?php

class User_Form_Admin_Manage_Editcity extends Engine_Form
{
	
	protected $_countryIdentity;
	protected $_stateIdentity;
	protected $_cityIdentity;
  
    public function setCountryIdentity($countryIdentity)
    {
    $this->_countryIdentity = (int) $countryIdentity;
    return $this;
    }
    public function setStateIdentity($stateIdentity)
    {
    $this->_stateIdentity = (int) $stateIdentity;
    return $this;
    }
    public function setCityIdentity($cityIdentity)
    {
    $this->_cityIdentity = (int) $cityIdentity;
    return $this;
    }
    public function init()
   {
  
     $country_table   =  Engine_Api::_()->getDbtable('countries', 'user');
//echo $this->_countryIdentity; exit;
//echo $this->_stateIdentity; exit;
    $country   =  Engine_Api::_()->getDbtable('countries', 'user');
	  $oCountry = $country->fetchRow(array(
      'id = ?' => $this->_countryIdentity,
    ));
    
    $state   =  Engine_Api::_()->getDbtable('state', 'user');
	  $oState = $state->fetchRow(array(
      'state_id = ?' => $this->_stateIdentity,
    ));
    
    $city   =  Engine_Api::_()->getDbtable('city', 'user');
	  $oCity = $city->fetchRow(array(
      'city_id = ?' => $this->_cityIdentity,
    ));
    
    $this->addElement('Text', 'country', array(
      'label' => 'Country',
      'allowEmpty' => false,
      //'required' => true,
      'value' => $oCountry->country,
      'attribs'    => array('disabled' => 'disabled')
    )); 
    
    $this->addElement('Text', 'state', array(
      'label' => 'State',
      'allowEmpty' => false,
     // 'required' => true,
      'value' => $oState->state,
      'attribs'    => array('disabled' => 'disabled')
    )); 
    
    $this->addElement('Text', 'city', array(
      'label' => 'City',
      'allowEmpty' => false,
      'required' => true,
      'value' => $oCity->city,
     
    )); 
    $this->addElement('hidden', 'city_id', array(
      'label' => 'city_id',
      'allowEmpty' => false,
      'required' => true,
      'value' => $this->_cityIdentity,
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
 

