<?php

class User_Form_Admin_Manage_AddCity extends Engine_Form
{
  public function init()
  {
    
    $country = new Zend_Form_Element_Select('country', array(								  
								   'required' => true,
								   'Label' => 'Country'));
    $oCountryTb = Engine_Api::_()->getDbtable('countries', 'user');
    $state_table   =  Engine_Api::_()->getDbtable('state', 'user');
    $country_list = $oCountryTb->fetchAll(); 
    
    foreach ($country_list as $oCountry) {
            $country->addMultiOption($oCountry['id'], $oCountry['country']);
            $country->setOptions(array('onchange' => 'getStates()'));
        }
        
    $this->addElement($country);
    
    $state = new Zend_Form_Element_Select('state', array(								  
								   'required' => true,
								   'Label' => 'State'));

    $this->addElement($state);
    
    $this->addElement('Text', 'city', array(
      'label' => 'City',
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
  
  
  public function getStates($id){
	  
	  $state_table   =  Engine_Api::_()->getDbtable('state', 'user');
	  $state_list = $state_table->fetchAll(array(
      'country_id = ?' => $id,
    )); 
    $this->state_list = $state_list;
    return $this->state_list;
	}
  
 } 
 

