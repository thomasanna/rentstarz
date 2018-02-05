<?php

class Advancedarticles_Form_AddNewPhoto extends Engine_Form
{
  public function init()
  {
	  
	   $this->setTitle('Add New Photos')
	  ->setDescription('Choose photos on your computer to add to this article.')
	  ->setAttrib('enctype', 'multipart/form-data')
	  ->setAttrib('id', 'form-upload')
      ->setAction(Zend_Controller_Front::getInstance()->getRouter()->assemble(array()))
      ;
      
       $this->addElement('File', 'Filedata', array(
      
      'destination' => APPLICATION_PATH.'/public/temporary/',
      'description'=>'Supported file types : jpg,png,gif,jpeg',
      'multiFile' => 1,
      'validators' => array(
        array('Count', false, 1),
        // array('Size', false, 612000),
        array('Extension', false, 'jpg,jpeg,png,gif'),
      ),
      ));
      
      $this->addElement('Button', 'done', array(
      'label' => 'Save Photo',
      'type' => 'submit',
      'decorators' => array(
        'ViewHelper'
      ),
     
    ));
    
	  
  }
  
}

?>
