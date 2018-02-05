<?php

class Advancedarticles_Form_Admin_Level extends Authorization_Form_Admin_Level_Abstract
{
	public function init()
	{
		$this
			->setTitle('Member Level Settings')
			->setDescription('ADVANCEDARTICLES_LEVEL_DESCRIPTION');

		$this->loadDefaultDecorators();
		$this->getDecorator('Description')->setOptions(array('tag' => 'h4', 'placement' => 'PREPEND'));

		// prepare user levels
		$table = Engine_Api::_()->getDbtable('levels', 'authorization');
		$select = $table->select();
		$user_levels = $table->fetchAll($select);
    
		foreach ($user_levels as $user_level)
			$levels[$user_level->level_id]= $user_level->getTitle();
    
		// category field
		$this->addElement('Select', 'level_id', array(
			'label' => 'Select Member Level',
			'multiOptions' => $levels,
			'onchange' => 'javascript:changeLevel(this.value);',
			'ignore' => true,
		));
		
		$this->addElement('Radio', 'view', array(
			'label' => 'Allow Viewing of Articles',
			'description' => 'Do you want to let users view articles? If set to no, some other settings on this page may not apply.',
			'multiOptions' => array(
				2 => 'Yes, allow members to view all articles, even private ones.',
				1 => 'Yes, allow members to view articles.',
				0 => 'No, do not allow articles to be viewed.'
			),
			'value' => ( $this->isModerator() ? 2 : 1 ),
		));
        if( !$this->isModerator() ) unset($this->view->options[2]);
        
        
      if (!$this->isPublic()) {
        
		$this->addElement('Radio', 'comment', array(
			'label' => 'Allow Commenting of Articles',
			'description' => 'Do you want to let users comment articles? If set to no, some other settings on this page may not apply.',
			'multiOptions' => array(
				1 => 'Yes, allow members to comment articles.',
				0 => 'No, do not allow members to comment articles.'
			)
		));		
		
		$this->addElement('Radio', 'create', array(
			'label' => 'Allow Creation of Articles',
			'description' => 'Do you want to let users create articles? If set to no, some other settings on this page may not apply.',
			'multiOptions' => array(
				1 => 'Yes, allow members to create articles.',
				0 => 'No, do not allow articles to be created.'
			)
		));		
		
		$this->addElement('Radio', 'edit', array(
			'label' => 'Allow Editing of Articles',
			'description' => 'Do you want to let users edit articles? If set to no, some other settings on this page may not apply.',
			'multiOptions' => array(
				2 => 'Yes, allow members to edit all articles.',
				1 => 'Yes, allow members to edit their own articles.',
				0 => 'No, do not allow to edit their articles.'
			),
			'value' => ( $this->isModerator() ? 2 : 1 ),
		));
		if( !$this->isModerator() ) unset($this->edit->options[2]);
		
		$this->addElement('Radio', 'art_delete', array(
			'label' => 'Allow Deletion of Articles',
			'description' => 'Do you want to let users delete articles? If set to no, some other settings on this page may not apply.',
			'multiOptions' => array(
				2 => 'Yes, allow members to delete all articles.',
				1 => 'Yes, allow members to delete their own articles.',
				0 => 'No, do not allow to delete their articles.'
			),
			'value' => ( $this->isModerator() ? 2 : 1 ),
		));
		if( !$this->isModerator() ) unset($this->art_delete->options[2]);	
		
		$this->addElement('Radio', 'art_photo', array(
			'label' => 'Allow Uploading of Photos',
			'description' => 'Do you want to let users upload photos to an article?',
			'multiOptions' => array(
				1 => 'Yes, allow photo uploading to article.',
				0 => 'No, do not allow photo uploading.'
			)
		));
		$this->addElement('Radio', 'art_photo_edit', array(
			'label' => 'Allow Editing of Photos',
			'description' => 'Do you want to let users edit photos?',
			'multiOptions' => array(
				1 => 'Yes, allow photo editing.',
				0 => 'No, do not allow photo editing.'
			)
		));	
		$this->addElement('Radio', 'art_photo_delete', array(
			'label' => 'Allow Deletion of Photos',
			'description' => 'Do you want to let users delete photos?',
			'multiOptions' => array(
				1 => 'Yes, allow members to delete.',
				0 => 'No, do not allow members to delete.'
			)
		));					
		
		$this->addElement('Radio', 'art_feature', array(
			'label' => 'Mark as Featured on Creation',
			'description' => 'Would you like to mark article as Featured when created?',
			'multiOptions' => array(
				1 => 'Yes, mark article as Featured.',
				0 => 'No, do not mark article as Featured.'
			)
		));	
		
		$this->addElement('Radio', 'art_sponsor', array(
			'label' => 'Mark as Sponsored on Creation',
			'description' => 'Would you like to mark article as Sponsored when created?',
			'multiOptions' => array(
				1 => 'Yes, mark article as Sponsored.',
				0 => 'No, do not mark article as Sponsored.'
			)
		));						
	    $this->addElement('Text', 'art_max', array(
	      'label' => 'Maximum Allowed Articles',
		  'description' => 'Enter the maximum number of allowed articles. Enter 0 for unlimited articles.',
	      'value' => '15',
	      'required' => true,
	      'allowEmpty' => false,
	      'validators' => array(
	        array('Int', true),
	        array('GreaterThan', true, array(-1)),
	      ),
	    ));	
		$this->art_max->getDecorator( 'Description' )->setOptions( array( 'placement' => 'append' ) );	
 	    $this->addDisplayGroup(
    	  array(
      	  'view',
		  'comment',
		  'create',
		  'edit',
		  'art_delete',
		  'art_photo',
		  'art_photo_edit',
		  'art_photo_delete',
		  'art_feature',
		  'art_sponsor',
		  'art_max'
     	 ),
     	 'advancedarticles_settings',
     	 array('class' => 'setting_fieldset', 'legend' => 'Article Settings')
    	);		
		
		//Privacy
		$this->addElement('MultiCheckbox', 'auth_view', array(
			'label' => 'Article Privacy',
			'description' => 'ART_PRIVACY_DESCRIPTION',
			'multiOptions' => array(
			'everyone' => 'Everyone',
			'registered' => 'All Registered Members',
			'owner_network' => 'Friends and Networks',
			'owner_member_member' => 'Friends of Friends',
			'owner_member' => 'Friends Only',
			'owner' => 'Just Me'
			),
			'value' => array('everyone', 'owner_network','owner_member_member', 'owner_member', 'owner'),
		));		
		$this->addElement('MultiCheckbox', 'auth_comment', array(
			'label' => 'Comment Privacy',
			'description' => '',
			'multiOptions' => array(
			'everyone' => 'Everyone',
			'registered' => 'All Registered Members',
			'owner_network' => 'Friends and Networks',
			'owner_member_member' => 'Friends of Friends',
			'owner_member' => 'Friends Only',
			'owner' => 'Just Me'
			),
			'value' => array('everyone', 'owner_network','owner_member_member', 'owner_member', 'owner'),
		));		
 	    $this->addDisplayGroup(
    	  array(
      	  'auth_view',
		  'auth_comment',
     	 ),
     	 'advancedarticles_privacy',
     	 array('class' => 'setting_fieldset', 'legend' => 'Privacy Settings')
    	);
	  }
	  
		$this->addElement('Button', 'submit', array(
			'label' => 'Save Settings',
			'type' => 'submit',
			'order' => 1000
		));
			
	}
}