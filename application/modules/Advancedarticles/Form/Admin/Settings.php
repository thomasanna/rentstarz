<?php

class Advancedarticles_Form_Admin_SEttings extends Engine_Form
{
	public function init()
	{
		$this
			->setTitle('Global Settings')
			->setDescription('These settings affect all members in your community.');

		$this->loadDefaultDecorators();
		$this->getDecorator('Description')->setOptions(array('tag' => 'h4', 'placement' => 'PREPEND'));
		//Settings
		$this->addElement('Text', 'art_route', array(
		  'label' => 'Subdirectory Link',
  		  'description' => 'http://you-site/subdirectory-link, (e.g. http://you-site/articles)',
	      'value' => 'articles',
	      'required' => true,
	      'allowEmpty' => false
		));
		$this->art_route->getDecorator( 'Description' )->setOptions( array( 'placement' => 'append' ) );		
		
		$this->addElement('Text', 'art_per_page', array(
		  'label' => 'Articles per Page',
  		  'description' => 'How many articles will be shown per page?',
	      'value' => '10',
	      'required' => true,
	      'allowEmpty' => false,
	      'validators' => array(
	        array('Int', true),
	        array('Between', true, array(1, 100, true)),
	      ),
		));
		$this->art_per_page->getDecorator( 'Description' )->setOptions( array( 'placement' => 'append' ) );	
		
		$this->addElement('Text', 'art_photo', array(
		  'label' => 'Article Photos',
  		  'description' => 'How many photos be shown on article`s photo gallery section?',
	      'value' => '4',
	      'required' => true,
	      'allowEmpty' => false,
	      'validators' => array(
	        array('Int', true),
	        array('Between', true, array(0, 100, true)),
	      ),
		));
		$this->art_photo->getDecorator( 'Description' )->setOptions( array( 'placement' => 'append' ) );	
 	    $this->addDisplayGroup(
    	  array(
    	  'art_route',
      	  'art_per_page',
		  'art_photo'
     	 ),
     	 'advancedarticles_articles',
     	 array('class' => 'setting_fieldset', 'legend' => 'Settings')
    	);	
		//Permissions
		$this->addElement('Radio', 'art_public', array(
			'label' => 'Public Permissions',
			'description' => '',
			'multiOptions' => array(
				1 => 'Yes, the public can view articles unless they are made private.',
				0 => 'No, the public cannot view articles.'
			),
			'value' => 1
		));		
 	    $this->addDisplayGroup(
    	  array(
      	  'art_public',
     	 ),
     	 'advancedarticles_permission',
     	 array('class' => 'setting_fieldset', 'legend' => 'Permissions')
    	);				
		//Sorting 
		$this->addElement('Radio', 'art_sort', array(
			'label' => 'Sorting Options',
			'description' => '',
			'multiOptions' => array(
				1 => 'User preference',
				2 => 'Featured articles, then user preference',
				3 => 'Featured articles, Sponsored articles, then user preference',
				4 => 'Sponsored articles, then user preference',
				5 => 'Sponsored articles, Featured articles, then user preference',
			),
			'value' => 5
		));		
 	    $this->addDisplayGroup(
    	  array(
      	  'art_sort',
     	 ),
     	 'advancedarticles_sorting',
     	 array('class' => 'setting_fieldset', 'legend' => 'Sorting')
    	);			
		
		$this->addElement('Button', 'submit', array(
			'label' => 'Save Settings',
			'type' => 'submit',
		));
	}
}