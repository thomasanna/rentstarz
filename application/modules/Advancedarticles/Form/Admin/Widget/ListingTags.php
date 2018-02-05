<?php
class Advancedarticles_Form_Admin_Widget_ListingTags extends Core_Form_Admin_Widget_Standard
{
  public function init()
  {
    parent::init();
    // Set form attributes
    $this
      ->setTitle('Popular Tags')
      ->setDescription('');
          
    $this->addElement('Text', 'perpage', array(
      'label' => 'Count',
	  'description' => 'number of items to show',
      'value' => 20,
      'validators' => array(
        array('Int', true),
        array('GreaterThan', true, array(1)),
      ),
    ));
	$this->perpage->getDecorator( 'Description' )->setOptions( array( 'placement' => 'append' ) );
	
    $this->addElement('Select', 'link', array(
      'label' => 'Show Link Explore Tags',
      'allowEmpty' => false,
      'required' => true,
      'multioptions' => array(
          1 => 'Yes',
          0 => 'No'
      ),
      'value' => 1
    ));	
    $this->addElement('Select', 'sort', array(
      'label' => 'Sort By',
      'allowEmpty' => false,
      'required' => true,
      'multioptions' => array(
          'text' => 'Tag Name',
          'count' => 'Count Article'
      ),
    ));      
  }
}