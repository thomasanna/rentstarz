<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Search.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class User_Form_Propertyrequirement extends Engine_Form
{
  public function init()
  {
	 
	 $this
      ->setTitle('Property Requirement')
      
      ->setMethod('POST')
      ->setAction(Zend_Controller_Front::getInstance()->getRouter()->assemble(array()))
      ; 

	  $this->addElement('Select', 'country', array(

	  'label' => 'Country',
	  'multioptions' => array(''=>'Select Country',1 => 'United States of America'),
	
	  ));
	  $this->addElement('Select', 'state', array(

	  'label' => 'State',
	  'multioptions' => array(''=>'Select state'),
	
	  ));
	  $this->addElement('Select', 'city', array(

	  'label' => 'City',
	  'multioptions' => array(''=>'Select city'),
	
	  ));
	  
	  $this->addElement('Text', 'zipcode', array(
      'label' => 'Zipcode',
    ));
    
	  $this->addElement('Select', 'pets', array(

	  'label' => 'Pets',
	  'multioptions' => array(''=>'Select','Yes' => 'Yes','No'=>'No'),
	
	  ));
	  $this->addElement('Select', 'pets_type', array(

	  'label' => 'Type of pets',
	  'multioptions' => array(''=>'Select pets type','Cats' => 'Cats','Dogs'=>'Dogs','Cats & Dogs'=>'Cats & Dogs','Birds'=>'Birds','Small pets'=>'Small pets'),
	
	  ));
	  $this->addElement('Select', 'rental_type', array(

	  'label' => 'Type of rental',
	  'multioptions' => array(''=>'Select rental type','Rent' => 'Rental','Lease'=>'Lease'),
	
	  ));
	  $this->addElement('Select', 'housing_type', array(

	  'label' => 'Type of housing',
	  'multioptions' => array(''=>'Select housing type','Apartment' => 'Apartment','Villa'=>'Villa','House'=>'House'),
	
	  ));
	  $this->addElement('Text', 'price', array(
      'label' => 'Budget for monthly',
    ));
    
    $this->addElement('Button', 'submit', array(
      'label' => 'Share',
      'type' => 'submit',
      'ignore' => true,
      'decorators' => array('ViewHelper')
    ));
    $buttons[] = 'submit';

    $this->addElement('Cancel', 'cancel', array(
      'label' => 'cancel',
      'link' => true,
      'prependText' => ' or ',
      'href' => '',
      'onclick' => 'parent.Smoothbox.close();',
      'decorators' => array(
        'ViewHelper'
      )
    ));
    $buttons[] = 'cancel';


    $this->addDisplayGroup($buttons, 'buttons');
    $button_group = $this->getDisplayGroup('buttons');
    
    
    
  }
  
  
}
