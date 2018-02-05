<?php

class User_Form_Admin_Manage_Editadvertisement extends Engine_Form
{
	
	protected $_advIdentity;
  
    public function setadvIdentity($_advIdentity)
    {
    $this->_advIdentity = (int) $_advIdentity; 
    return $this;
    }
    public function init()
    {

      $Advertisement_table =  Engine_Api::_()->getDbtable('advertisement', 'user');
	  $advertisement= $Advertisement_table->fetchRow(array(
      'id = ?' => $this->_advIdentity,
    )); 
    $this
      ->setAttrib('enctype', 'multipart/form-data')
       ->setAttrib('name', 'EditAdvertisement');
    $this->addElement('Text', 'title', array(
      'label' => 'Title',
      'allowEmpty' => false,
      'required' => true,
      'value' => $advertisement->title,
    )); 
    
    $this->addElement('Text', 'website', array(
      'label' => 'Website',
      'allowEmpty' => false,
      'required' => true,
      'value' => $advertisement->ad_url,
    ));

    $this->addElement('Text', 'date_from', array(
      'label' => 'From',
      'id' => 'datepicker1',
      'allowEmpty' => false,
      'required' => true,
      'value' => $advertisement->date_from,
    )); 
    
    $this->addElement('Text', 'date_to', array(
      'label' => 'To',
      'id' => 'datepicker2',
      'allowEmpty' => false,
      'required' => true,
      'value' => $advertisement->date_to,
    ));

     $this->addElement('File', 'image', array(
      'label' => 'Change Image',
      'description'=>'Supported file types : jpg,png,gif,jpeg',
      'validators' => array(
        array('Extension', false, 'jpg,jpeg,gif,png'),
      ),	  
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
 

