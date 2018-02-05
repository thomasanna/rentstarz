<?php

class User_Form_Admin_Manage_AddState extends Engine_Form
{
  public function init()
  {

    /*$view = Zend_Registry::get('Zend_View');

    $country_list = $view->getCountries(); ;

    $country = new Zend_Form_Element_Select('country', array(								  
								   'required' => true,));
    $country ->setLabel('Country:')
            ->addMultiOptions( $country_list 
                        ); 

    $this->addElement($country);*/
    
    $country = new Zend_Form_Element_Select('country', array(								  
								   'required' => true,));
    $oCountryTb = Engine_Api::_()->getDbtable('countries', 'user');
    $country_list = $oCountryTb->fetchAll(); 
    
    foreach ($country_list as $oCountry) {
            $country->addMultiOption($oCountry['id'], $oCountry['country']);
        }
        
    $this->addElement($country);
    
    $this->addElement('Text', 'state', array(
      'label' => 'State',
      'allowEmpty' => false,
      'required' => true,
    )); 

	/*$this->addElement('Text', 'city', array(
      'label' => 'City',
      'allowEmpty' => false,
      'required' => true,
    ));*/  
 
    
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
 

