<?php
class Advancedarticles_Form_Filter extends Fields_Form_Search
{
  public function init()
  {
    parent::init();  
    $this->loadDefaultDecorators();
    $this->setAttrib('id', 'formFilter');
    $this->getDecorator('HtmlTag')->setOption('class', 'browsemembers_criteria');
    $front = Zend_Controller_Front::getInstance();
    
    $this->setAction($front->getRouter()->assemble(array('action' => 'category'), 'advancedarticles_general'));
    
    $_action = $front->getRequest()->getControllerName().'_'.$front->getRequest()->getActionName();

    if ($_action == 'articles_article')
      $this->getDecorator('HtmlTag')->setOption('style', 'display:none');
    if ($_action == 'articles_my') {
        $this->setAction($front->getRouter()->assemble(array('action' => 'my'), 'advancedarticles_general'));
    }
    else {
        $this->setAction($front->getRouter()->assemble(array('action' => 'category'), 'advancedarticles_general'));
    }
    
    $this->addElement('Hidden', 'isFilter', array(
      'label' => 'Filter',
      'order' => 1
    ));
    
    $this->addElement('Hidden', 'owner', array(
      'label' => 'Owner',
      'order' => 2
    ));

    $this->addElement('Hidden', 'start', array(
      'label' => 'Start',
      'order' => 3
    ));
    $this->addElement('Hidden', 'end', array(
      'label' => 'End',
      'order' => 4
    ));

    $this->addElement('Hidden', 'tag', array(
      'label' => 'Tag',
      'order' => 5
    ));       
    
    $this->addElement('Text', 'title', array(
      'label' => 'Title',
      'description' => '',
      'decorators' => array(
        'ViewHelper',
        array('Label', array('tag' => 'span')),
        array('HtmlTag', array('tag' => 'li'))
      ),
    ));
    
	// Element: Categories
    $categoties = Engine_Api::_()->advancedarticles()->loadCategory('advancedarticles');

    if( count($categoties) > 0 ) {
      // Element: collection_id
      $this->addElement('Select', 'id', array(
        'label' => 'Category',
        'decorators' => array(
          'ViewHelper',
          array('Label', array('tag' => 'span')),
          array('HtmlTag', array('tag' => 'li'))
        ),	    	
      ));
      
      $this->id->addMultiOption('', '');
      foreach( $categoties as $category ) {
	  	$sub = $category['depth'] ? ' - ' : '';
        $this->id->addMultiOption($category['category_id'], $sub.$category['name']);
      }
    }

    $this->addElement('Select', 'order', array(
      'label' => 'Browse By',
      'decorators' => array(
      'ViewHelper',
        array('Label', array('tag' => 'span')),
        array('HtmlTag', array('tag' => 'li'))
      ),
      'multiOptions' => array(
          '' => '',  
          'title' => 'Title',
          'num_views' => 'Most Viewed',
          'comment_count' => 'Most Commented',
          'like_count' => 'Most Liked',          
          'created_date' => 'Most Recent',
          'updated_date' => 'Last Updated',
      )
    ));    

    $this->addElement('Button', 'done', array(
      'label' => 'Search',
      'ignore' => true,
      'order' => 1000      
    ));      
  }


}