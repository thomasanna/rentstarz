<?php

class Advancedarticles_Form_PhotoEdit extends Engine_Form
{
  public function init()
  {
    $this->setTitle('Edit Article Photo')
      ->setAction(Zend_Controller_Front::getInstance()->getRouter()->assemble(array()))
      ->setAttrib('class', 'global_form_popup');
	  
    // Element: title
    $this->addElement('Text', 'title', array(
      'label' => 'Title',
	  'style' => 'width:350px',
      'filters' => array(
        'StripTags',
        new Engine_Filter_Censor(),
      )	  
    ));
    
    // Element: title
    $this->addElement('Textarea', 'description', array(
      'label' => 'Description',
	  'style' => 'width:350px',
      'filters' => array(
        'StripTags',
        new Engine_Filter_Censor(),
      )	  
    ));    

    $this->addElement('Button', 'save', array(
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
    $this->addDisplayGroup(array('submit', 'save', 'cancel'), 'buttons');
    $button_group = $this->getDisplayGroup('buttons');    
  }
}