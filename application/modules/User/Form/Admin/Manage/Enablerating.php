<?php

class User_Form_Admin_Manage_Enablerating extends Engine_Form
{
	protected $_userIdentity;
	
	public function setUserIdentity($userIdentity)
    {
    $this->_userIdentity = (int) $userIdentity;
    return $this;
    }
	
	 public function init()
   {
	 
	   
	$userTable = Engine_Api::_()->getDbtable('users', 'user');
	  $oUser = $userTable->fetchRow(array(
      'user_id = ?' => $this->_userIdentity,
    ));   
	     // Init enabled
	 
	$this->addElement('Checkbox', 'enabled', array(
      'label' => 'Enable',
      
     ));  
      
	if($oUser->enable_rating_value == '1'){ 
    $this->addElement('Checkbox', 'enabled', array(
      'label' => 'Enable',
     'checked' => 'checked',
    
    ));
    }
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
