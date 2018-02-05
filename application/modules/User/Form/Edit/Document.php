<?php


class User_Form_Edit_Document extends Engine_Form
{
	public function init()
  {
	
	    $this
      ->setAttrib('enctype', 'multipart/form-data');
      //->setAttrib('name', 'EditPhoto');
	
	$this->addElement('Text', 'title', array(
      'label' => 'Document Title',
      'allowEmpty' => false,
      //'required' => true,
   
    )); 
	
	
	$this->addElement('File', 'document', array(
      'label' => 'Upload document',
     'destination' => APPLICATION_PATH.'/public/temporary/',
     // 'required' => true,
    //  'multiFile' => 1,
      'validators' => array(
        array('Count', false, 1),
        // array('Size', false, 612000),
       // array('Extension', false, 'jpg,jpeg,png,gif'),
      ),
      
    ));
    
    $this->addElement('Button', 'save_document', array(
      'label' => 'Save Document',
      'type' => 'submit',
      'decorators' => array(
        'ViewHelper'
      ),
    ));

   


    
}
}
