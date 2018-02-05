<?php

class Advancedarticles_Form_Admin_Editcategory extends Engine_Form
{
	
  public function init()
  {
    // Set form attributes
    $this->setTitle('Edit Category');
    $this->setDescription("");

    // Element: title
    $this->addElement('Text', 'name', array(
      'label' => 'Category name',
      'allowEmpty' => false,
      'required' => true,
    ));

    $this->addElement('Text', 'url', array(
      'label' => 'Category URL',
      'description' => 'This URL may only contain alphanumeric characters and dashes - any other characters will be stripped.',
      'filters' => array(
        array('PregReplace', array('/[^a-z0-9]+|[-]{2,}/i', '-')),
        array('StringTrim', array("- \n\r\t"))
      ),
	  'style' => 'width:300px'
    ));

	$this->addElement('Select', 'parent_id', array(
		'label' => '',
		'description' => '',
		//'multiOptions' => $options,
		'value' => '0',
		'style' => 'width:306px; visibility: hidden',
		//'disabled' => 'disabled'
	));

    // Buttons
    $this->addElement('Button', 'submit', array(
      'label' => 'Edit Category',
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