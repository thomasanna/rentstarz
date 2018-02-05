<?php

class User_Form_Admin_Manage_Packagemanage extends Engine_Form
{
  public function init()
  {
	  $this->addElement('Text', 'user_landlordProPrice', array(
          'label' => 'Landlord Pro Price',
          'description' => 'Enter the price for the Landlord Pro user',
          'value' => '10',
          'required' => true,
          'allowEmpty' => false
        ));
	  $this->addElement('Text', 'user_managementGoldPrice', array(
          'label' => 'Management Gold Price',
          'description' => 'Enter the price for the Management gold user',
          'value' => '10',
          'required' => true,
          'allowEmpty' => false
        ));
	 
	  $this->addElement('Text', 'user_videoPrice', array(
          'label' => 'Video Price',
          'description' => 'Enter the price for Video call',
          'value' => '10',
          'required' => true,
          'allowEmpty' => false
        ));
	  $this->addElement('Text', 'user_basicScoutLimit', array(
          'label' => 'Scout limit for the basic free user',
          'description' => 'Enter the scout limit for basic free user',
          'value' => '1',
          'required' => true,
          'allowEmpty' => false
        ));
	  $this->addElement('Text', 'user_landlordProScoutLimit', array(
          'label' => 'Scout limit for the landlord pro user',
          'description' => 'Enter the Scout limit for the landlord pro user',
          'value' => '10',
          'required' => true,
          'allowEmpty' => false
        ));

	  $this->addElement('Text', 'user_basicPropertyLimit', array(
          'label' => 'Property limit for the basic free user',
          'description' => 'Enter the property limit for the basic free user',
          'value' => '1',
          'required' => true,
          'allowEmpty' => false
        ));
	  $this->addElement('Text', 'user_landlordProPropertyLimit', array(
          'label' => 'Property limit for the landlord pro user',
          'description' => 'Enter the property limit for the landlord pro user',
          'value' => '10',
          'required' => true,
          'allowEmpty' => false
        ));
       $this->addElement('Radio', 'user_premiumLevelProvision', array(
			'label' => 'premium level provision to all types of users',
			'description' => 'Premium level provision to all types of users during promotion, so that all users can experience the premium features',
			'multiOptions' => array(
				1 => 'Yes',
				2 => 'No',
			),
			'value' => 2
		));		 
        
      $this->addElement('Button', 'submit', array(
            'label' => 'Save',
            'type' => 'submit',
        ));
  }
  
}
