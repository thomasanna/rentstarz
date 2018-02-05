<?php

class Advancedarticles_Form_AddPhoto extends Engine_Form
{
  public function init()
  {
    $this->setTitle('Add New Photos')
	  ->setDescription('Choose photos on your computer to add to this article.')
	  ->setAttrib('enctype', 'multipart/form-data')
	  ->setAttrib('id', 'form-upload')
      ->setAction(Zend_Controller_Front::getInstance()->getRouter()->assemble(array()))
      ;
    $this->addElement('FancyUpload', 'file');

    // Init submit
    $this->addElement('Button', 'submit', array(
      'label' => 'Save Photo',
      'type'  => 'submit',
    ));
  }
}