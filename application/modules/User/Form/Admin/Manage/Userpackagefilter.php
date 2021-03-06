<?php

class User_Form_Admin_Manage_Userpackagefilter extends Engine_Form
{
  public function init()
  {
	 $this
      ->clearDecorators()
      ->addDecorator('FormElements')
      ->addDecorator('Form')
      ->addDecorator('HtmlTag', array('tag' => 'div', 'class' => 'search'))
      ->addDecorator('HtmlTag2', array('tag' => 'div', 'class' => 'clear'))
      ;

    $this
      ->setAttribs(array(
        'id' => 'filter_form',
        'class' => 'global_form_box',
      ))
      ->setMethod('GET');
      
    $customername = new Zend_Form_Element_Text('customername');
    $customername
      ->setLabel('Customer Name')
      ->clearDecorators()
      ->addDecorator('ViewHelper')
      ->addDecorator('Label', array('tag' => null, 'placement' => 'PREPEND'))
      ->addDecorator('HtmlTag', array('tag' => 'div'));
        $this->addElement('Hidden', 'order', array(
      'order' => 10001,
    ));
     $submit = new Zend_Form_Element_Button('search', array('type' => 'submit'));
    $submit
      ->setLabel('Search')
      ->clearDecorators()
      ->addDecorator('ViewHelper')
      ->addDecorator('HtmlTag', array('tag' => 'div', 'class' => 'buttons'))
      ->addDecorator('HtmlTag2', array('tag' => 'div'));

    $this->addElement('Hidden', 'order_direction', array(
      'order' => 10002,
    ));

    $this->addElement('Hidden', 'id', array(
      'order' => 10003,
    ));

    
    $this->addElements(array(
      $customername,
      $submit,

    )); 
    
        // Set default action without URL-specified params
    $params = array();
    foreach (array_keys($this->getValues()) as $key) {
      $params[$key] = null;
    }
    $this->setAction(Zend_Controller_Front::getInstance()->getRouter()->assemble($params)); 
  }
  
}
