<?php
class Advancedarticles_Form_Admin_Widget_Sponsored extends Core_Form_Admin_Widget_Standard
{
  public function init()
  {
    parent::init();

    // Set form attributes
    $this
      ->setTitle('Sponsored Articles');
      
    $this->addElement('Text', 'perpage', array(
      'label' => 'Count',
	  'description' => 'number of items to show',
      'value' => 3,
      'required' => true,
      'allowEmpty' => false,
      'validators' => array(
        array('Int', true),
        array('GreaterThan', true, array(0)),
      ),
    ));
	$this->perpage->getDecorator( 'Description' )->setOptions( array( 'placement' => 'append' ) );

	// Element: Categories
    $categoties = Engine_Api::_()->advancedarticles()->loadCategory('advancedarticles');

    if( count($categoties) > 0 ) {
      $this->addElement('Select', 'category_id', array(
        'label' => 'Category',
    	'allowEmpty' => false,
	    'required' => true,		
      ));
      
      $this->category_id->addMultiOption(0, '');
      foreach( $categoties as $category ) {
	  	$sub = $category['depth'] ? ' - ' : '';
        $this->category_id->addMultiOption($category['category_id'], $sub.$category['name']);
      }
    }	
	
    $this->addElement('Text', 'interval', array(
      'label' => 'Slideshow Interval (sec)',
      'value' => 7,
      'required' => true,
      'allowEmpty' => false,
      'validators' => array(
        array('Int', true),
        array('GreaterThan', true, array(1)),
      ),
    ));	
	
    $this->addElement('Select', 'sort', array(
      'label' => 'Sort By',
      'allowEmpty' => false,
      'required' => true,
      'multioptions' => array(
          'created_date' => 'Created Date',
          'title' => 'Title',
          'commnet_count' => 'Most Commented',
          'like_count' => 'Most Liked',
          'num_views' => 'Most Viewed',
          'RAND()' => 'Randomized'
      ),
    ));	
  }
}