<?php
class Advancedarticles_Form_Admin_Widget_Recent extends Core_Form_Admin_Widget_Standard
{
  public function init()
  {
    parent::init();

    // Set form attributes
    $this
      ->setTitle('Recent Articles');
      
    $this->addElement('Text', 'perpage', array(
      'label' => 'Number of articles',
	  'description' => 'the number of articles to display by default',
      'value' => 10,
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