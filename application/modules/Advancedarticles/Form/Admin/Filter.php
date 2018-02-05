<?php
class Advancedarticles_Form_Admin_Filter extends Engine_Form
{
  public function init()
  {
    $this->clearDecorators()
      ->addDecorator('FormElements')
      ->addDecorator('Form')
      ->addDecorator('HtmlTag', array('tag' => 'div', 'class' => 'search'))
      ->addDecorator('HtmlTag2', array('tag' => 'div', 'class' => 'clear'));

    $this->setAttribs(array(
      'id' => 'filter_form',
      'class' => 'global_form_box',
    ));

    $this->addElement('Hidden', 'order', array(
      'label' => 'Order',
      'order' => 1
    ));
    $this->addElement('Hidden', 'by', array(
      'label' => 'By',
      'order' => 2
    ));        
    
    // Element: title
    $this->addElement('Text', 'title', array(
      'label' => 'Article Title',
      'style' => 'width:100px'
    ));    
    
   /* $this->addElement('Text', 'username', array(
      'label' => 'Username',
      'style' => 'width:100px'
    )); 
        
	// Element: Categories
    $categoties = Engine_Api::_()->advancedarticles()->loadCategory('advancedarticles');

    if( count($categoties) > 0 ) {
      $this->addElement('Select', 'category_id', array(
        'label' => 'Category',
        'style' => 'width:200px'
      ));
      
      $this->category_id->addMultiOption('', '');
      foreach( $categoties as $category ) {
	  	$sub = $category['depth'] ? ' - ' : '';
        $this->category_id->addMultiOption($category['category_id'], $sub.$category['name']);
      }
    }    
    
    $this->addElement('Select', 'status', array(
      'label' => 'Status',
      'multiOptions' => array(
        '' => '',
        'active' => 'Active',
        'inactive' => 'Inactive',
        'draft' => 'Draft',
      )
    ));    
    
    $this->addElement('Select', 'featured', array(
      'label' => 'Featured',
      'multiOptions' => array(
        '' => '',
        1 => 'Yes',
        0 => 'No',
      ),
      'style' => 'width:80px'
    ));

    $this->addElement('Select', 'sponsored', array(
      'label' => 'Sponsored',
      'multiOptions' => array(
        '' => '',
        1 => 'Yes',
        0 => 'No',
      ),
      'style' => 'width:80px'
    ));       */

    $submit = new Zend_Form_Element_Button('search', array('type' => 'submit'));
    $submit
      ->setLabel('Search')
      ->clearDecorators()
      ->addDecorator('ViewHelper')
      ->addDecorator('HtmlTag', array('tag' => 'div', 'class' => 'buttons'))
      ->addDecorator('HtmlTag2', array('tag' => 'div'));
    
    $this->addElements(array(
      $submit
    ));

    $params = array();
    foreach (array_keys($this->getValues()) as $key) {
      $params[$key] = null;
    }
    $this->setAction(Zend_Controller_Front::getInstance()->getRouter()->assemble($params));
  }
}
