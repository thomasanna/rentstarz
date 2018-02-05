<?php
class Advancedarticles_Form_Admin_Widget_Random extends Core_Form_Admin_Widget_Standard
{
  public function init()
  {
    parent::init();

    // Set form attributes
    $this
      ->setTitle('Random Articles');
      
    $this->addElement('Text', 'perpage', array(
      'label' => 'Count',
	  'description' => 'number of items to show',
      'value' => 5,
      'required' => true,
      'allowEmpty' => false,
      'validators' => array(
        array('Int', true),
        array('GreaterThan', true, array(0)),
      ),
    ));
	$this->perpage->getDecorator( 'Description' )->setOptions( array( 'placement' => 'append' ) );
  }
}