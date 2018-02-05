<?php

class Advancedarticles_Form_Delete extends Engine_Form
{
  public function init()
  {
    // Set form attributes
    $this->setTitle('Delete Article');
    $this->setDescription("Are you sure you want to delete this article?");

    // Buttons
    $this->addElement('Button', 'submit', array(
      'label' => 'Delete Article',
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