<?php

class User_Form_Admin_Manage_Editproperty extends Engine_Form
{
	protected $_propertyIdentity;
	
	public function setPropertyIdentity($propertyIdentity)
    {
    $this->_propertyIdentity = (int) $propertyIdentity;
    return $this;
    }
	
	 public function init()
   {
	   
	   
	$propertyTable =  Engine_Api::_()->getDbtable('propertylist', 'user');	  
	  $oProperty = $propertyTable->fetchRow(array(
      'id = ?' => $this->_propertyIdentity,
    ));   
	     // Init enabled
	 
	$this->addElement('Checkbox', 'enabled', array(
      'label' => 'Enable',
     ));  
      
	if($oProperty->enable == '1'):    
    $this->addElement('Checkbox', 'enabled', array(
      'label' => 'Enable',
     'checked' => 'checked',
    ));
    endif;
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
