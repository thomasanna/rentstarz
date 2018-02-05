<?php

class User_Form_Admin_Manage_Editpropertyrequest extends Engine_Form
{
	protected $_propertyreqIdentity;
	
	public function setPropertyreqIdentity($propertyreqIdentity)
    {
    $this->_propertyreqIdentity = (int) $propertyreqIdentity;
    return $this;
    }
	
	 public function init()
   {
	   
	   
	$propertyreqTable =  Engine_Api::_()->getDbtable('propertyrequest', 'user');	  
	  $oProperty = $propertyreqTable->fetchRow(array(
      'id = ?' => $this->_propertyreqIdentity,
    ));   
	     // Init enabled
	 
	$this->addElement('Checkbox', 'enabled', array(
      'label' => 'Enable',
     ));  
      
	if($oProperty->admin_approve == '1'):    
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
