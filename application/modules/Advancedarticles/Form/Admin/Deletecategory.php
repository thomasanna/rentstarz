<?php

class Advancedarticles_Form_Admin_Deletecategory extends Engine_Form
{
  public function init()
  {
    // Set form attributes
    $this->setTitle('Delete Category');
    $this->setDescription("Are you sure you want to delete this category?");

    // Buttons
    $this->addElement('Button', 'submit', array(
      'label' => 'Delete Category',
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