<?php

class Advancedarticles_Form_Edit extends Engine_Form
{
  public function init()
  {

    $this->setTitle('Edit Article')
      ->setAction(Zend_Controller_Front::getInstance()->getRouter()->assemble(array()));
	  
	$front = Zend_Controller_Front::getInstance();
	$viewer = Engine_Api::_()->user()->getViewer();

    // Element: title
    $this->addElement('Text', 'title', array(
      'label' => 'Article Title',
	  'style' => 'width:350px',
      'allowEmpty' => false,
      'required' => true,
      'filters' => array(
        'StripTags',
        new Engine_Filter_Censor(),
      )	  
    ));

	// Element: Categories
	$_module = $front->getRequest()->getModuleName();
    $categoties = Engine_Api::_()->$_module()->loadCategory($_module);

   /* if( count($categoties) > 0 ) {
      // Element: collection_id
      $this->addElement('Select', 'category_id', array(
        'label' => 'Category',
    	'allowEmpty' => false,
	    'required' => true,		
      ));
      
      $this->category_id->addMultiOption('', '');
      foreach( $categoties as $category ) {
	  	$sub = $category['depth'] ? ' - ' : '';
        $this->category_id->addMultiOption($category['category_id'], $sub.$category['name']);
      }
    }*/

    $this->addElement('TinyMce', 'description', array(
      'label' => 'Body',
      'required' => true,
      'allowEmpty' => false,
      'filters' => array(
		new Engine_Filter_Html(array('AllowedTags'=>true)),		
        new Engine_Filter_Censor(),
		//new Engine_Filter_EnableLinks(),
      ),	  
    ));
	
    // Element: search
    $this->addElement('Checkbox', 'search', array(
      'label' => 'Show this article in search results',
	  'value' => 1,
    ));
    $this->addElement('Checkbox', 'landingpage_article', array(
      'label' => 'Show this article in landingpage',
	  'value' => 0,
    ));
    $this->addElement('textarea', 'landingpage_articledescription', array(
      'label' => 'Description for landingpage',
	  'value' => 'Article',
    ));
	
    // Element: Tags
   /* $this->addElement('Text', 'tags_info', array(
      'label' => 'Tags',
	  'description' => 'Separate tags with commas',
	  'autocomplete'=>'off'
    ));
	$this->tags_info->getDecorator('Description')->setOption('placement', 'append');

    //Privacy Who View

	$privacyLabel = Engine_Api::_()->$_module()->getPrivacy();

    $privacy = array_flip((array) Engine_Api::_()->authorization()->getAdapter('levels')->getAllowed('artarticle', $viewer, 'auth_view'));
    $privacyOptions = array_intersect_key($privacyLabel, $privacy);

    if( !empty($privacyOptions) && count($privacyOptions) ) {
      $this->addElement('Select', 'auth_view', array(
          'label' => 'Privacy',
          'description' => 'Who may see this article?',
          'multiOptions' => $privacyOptions,
      ));
      $this->auth_view->getDecorator('Description')->setOption('placement', 'append');
    }

    // Privacy Comments
    $privacy = array_flip((array) Engine_Api::_()->authorization()->getAdapter('levels')->getAllowed('artarticle', $viewer, 'auth_comment'));
	
    $privacyOptions = array_intersect_key($privacyLabel, $privacy);

    if( !empty($privacyOptions) && count($privacyOptions) ) {
      $this->addElement('Select', 'auth_comment', array(
          'label'        => 'Comment Privacy',
          'description'  => 'Who may post comments on this article?',
          'multiOptions' => $privacyOptions,
      ));
      $this->auth_comment->getDecorator('Description')->setOption('placement', 'append');
    }	*/
    $this->addElement('Checkbox', 'trending_article', array(
	      'label' => 'Trending article',
		 // 'value' => 0,
	    ));
	    
  $this->addElement('Text', 'position', array(
      'label' => 'Position',
	  'style' => 'width:350px',
    //  'allowEmpty' => false,
     // 'required' => true,
      
    ));
	if (Engine_Api::_()->authorization()->isAllowed('artarticle', $viewer, 'art_feature')) {
	    // Featured
	    $this->addElement('Checkbox', 'featured', array(
	      'label' => 'Featured article',
		  'value' => 0,
	    ));
	}
	
	if (Engine_Api::_()->authorization()->isAllowed('artarticle', $viewer, 'art_sponsor')) {
	    // Sponsored
	    $this->addElement('Checkbox', 'sponsored', array(
	      'label' => 'Sponsored article',
		  'value' => 0,
	    ));
	}	
    // Get form Fields
    $questions = new Fields_Form_Standard(array(
      'item' => Engine_Api::_()->core()->getSubject(),
    ));
    $questions->removeElement('submit');
    $questions->setDecorators(array(
        'FormElements',
    ));     
    $this->addSubForm($questions, 'questions');		
	
    // init submit
    $this->addElement('Button', 'submit', array(
      'label' => 'Save Changes',
      'type' => 'submit',
      'ignore' => true,
      'decorators' => array('ViewHelper')
    ));

	$this->addElement('Cancel', 'cancel', array(
      'label' => 'view article',
      'link' => true,
      'prependText' => ' or ',
      'href' => '',
      'decorators' => array(
        'ViewHelper'
      )
    ));	
    $this->addDisplayGroup(array('submit', 'cancel'), 'buttons');
    $button_group = $this->getDisplayGroup('buttons');	
    
  }
}
