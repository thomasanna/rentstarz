<?php

class Advancedarticles_Form_Admin_Addcategory extends Engine_Form
{
  public function init()
  {
    // Set form attributes
    $this->setTitle('Add Category');
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

	$options = array('0' => '');
    $parent_category = Engine_Api::_()->getDbtable('categories', 'advancedarticles');
	$select = $parent_category->select();
	$select->where("parent_id = ?", 0);
	
	$parent_category = $parent_category->fetchAll($select);
	
    foreach( $parent_category as $category ) {
      $options[$category->category_id] = $category->name;
    }

	$this->addElement('Select', 'parent_id', array(
		'label' => '',
		'description' => '',
		'multiOptions' => $options,
		'value' => '0',
		'style' => 'width:306px; visibility: hidden'
	));

    // Buttons
    $this->addElement('Button', 'submit', array(
      'label' => 'Add Category',
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