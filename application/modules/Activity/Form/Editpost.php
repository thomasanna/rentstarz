<?php

class Activity_Form_Editpost extends Engine_Form
{
	
	
	protected $_actionIdentity;
	
	public function setActionIdentity($actionIdentity)
    {
    $this->_actionIdentity = (int) $actionIdentity;
    return $this;
    }
	
	public function init()
    {
		
	$this
	  ->setTitle('Edit post')
	
	  ->setMethod('POST')
	  ->setAction(Zend_Controller_Front::getInstance()->getRouter()->assemble(array())) ;
		  
	$action       = Engine_Api::_()->getDbtable('actions', 'activity')->getActionById($this->_actionIdentity); 
	
	$body = preg_replace('/<br[^<>]*>/', "\n", $action->body); 
	
		$this->addElement('Textarea', 'editpostbody', array(
      'label' => 'Body',
      'allowEmpty' => false,
      'required' => true,
     // 'value' => $body,
      
      'filters' => array(
        new Engine_Filter_HtmlSpecialChars(),
        new Engine_Filter_EnableLinks(),
        new Engine_Filter_Censor(),
        //  'StripTags',
        ),

    ));  
    
    
     $this->addElement('Button', 'submit', array(
      'label' => 'Edit',
      'type' => 'submit',
      'ignore' => true,
      'decorators' => array('ViewHelper')
    ));
    $buttons[] = 'submit';

    $this->addElement('Cancel', 'cancel', array(
      'label' => 'cancel',
      'link' => true,
      'prependText' => ' or ',
      'href' => '',
      'onclick' => 'parent.Smoothbox.close();',
      'decorators' => array(
        'ViewHelper'
      )
    ));
    $buttons[] = 'cancel';


    $this->addDisplayGroup($buttons, 'buttons');
    $button_group = $this->getDisplayGroup('buttons');
    
	}
  
  
}
