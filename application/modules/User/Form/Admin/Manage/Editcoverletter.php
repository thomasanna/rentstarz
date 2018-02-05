<?php

class User_Form_Admin_Manage_Editcoverletter extends Engine_Form
{
	
	protected $_coverletterIdentity;
  
    public function setCoverletterIdentity($_coverletterIdentity)
    {
    $this->_coverletterIdentity = (int) $_coverletterIdentity;
    return $this;
    }
    public function init()
   {
  
     $coverletter_tbl   =  Engine_Api::_()->getDbtable('coverletter', 'user');
	  $oCover = $coverletter_tbl->fetchRow(array(
      'id = ?' => $this->_coverletterIdentity,
    )); 

    $this->addElement('Text', 'title', array(
      'label' => 'Title',
      'allowEmpty' => false,
      'required' => true,
      'value' => $oCover->title,
    )); 
    $this->addElement('Text', 'content', array(
      'label' => 'Content',
      'allowEmpty' => false,
      'required' => true,
      'value' => $oCover->content,
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
 

