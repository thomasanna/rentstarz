<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Search.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class User_Form_Search extends Fields_Form_Search
{
  public function init()
  {
    // Add custom elements
    $this->getMemberTypeElement(); 
    $this->getDisplayNameElement();
    $this->getKeywordElement();
    $this->getAdditionalOptionsElement();
    $this->getServiceTypeIdElement();

    parent::init();

    $this->loadDefaultDecorators();
    $this->setMethod('post');
    $this->getDecorator('HtmlTag')->setOption('class', 'browsemembers_criteria');
  }

  public function getMemberTypeElement()
  {
    $multiOptions = array('' => ' ');
    $profileTypeFields = Engine_Api::_()->fields()->getFieldsObjectsByAlias($this->_fieldType, 'profile_type');
    if( count($profileTypeFields) !== 1 || !isset($profileTypeFields['profile_type']) ) return;
    $profileTypeField = $profileTypeFields['profile_type'];
    
    $options = $profileTypeField->getOptions(); 

    if( count($options) <= 1 ) {
      if( count($options) == 1 ) {
        $this->_topLevelId = $profileTypeField->field_id;
        $this->_topLevelValue = $options[0]->option_id;
      }
      return;
    }
 $ptype = $this->_pType; 

 $field_type= $this->_fieldType;
    foreach( $options as $option ) { 
		
		if($ptype == 'tenants')	 {
		if($option->option_id == '1'){
		  $multiOptions[$option->option_id] = $option->label;
	     }
	    }
		if($ptype == 'landlords')	 {
		if($option->option_id == '4'){
		  $multiOptions[$option->option_id] = $option->label;
	     }
	    }
	    if($ptype == 'services')	 {
		if($option->option_id == '6'){
		  $multiOptions[$option->option_id] = $option->label;
	     }
	    }
		if($ptype == 'user')	 {		
		  $multiOptions[$option->option_id] = $option->label;
		  unset( $multiOptions['5']);		
	    }
    }
  
 

	//print_r($multiOptions); exit;	 
    $this->addElement('Select', 'profile_type', array(
      'label' => 'Member Type',
      'order' => -1000001,
      'class' =>
        'field_toggle' . ' ' .
        'parent_' . 0 . ' ' .
        'option_' . 0 . ' ' .
        'field_'  . $profileTypeField->field_id  . ' ',
      'onchange' => 'changeFields($(this));',
      'decorators' => array(
        'ViewHelper',
        array('Label', array('tag' => 'span')),
        array('HtmlTag', array('tag' => 'li'))
      ),
      'multiOptions' => $multiOptions,
    )); 
		//echo $this->profile_type; exit;
//print_r($multiOptions); exit;
//print_r($this->profile_type); exit;	 
    return $this->profile_type;
  }
  
  public function getServiceTypeIdElement(){
	  
	  	
	   $ptype = $this->_pType; 
	  // Element: services_type
	  if($ptype == 'services')	 {
	$this->addElement('Select', 'services_type_id', array(

	  'label' => 'Services Type',
	  'order' => -1000000,
	  //'multioptions' => array(''=>'',1 => 'Leagal Aide',2 => 'Process Server', 3 => 'Lawyer', 4 => 'Paralegal'),
	  'multioptions' => array(''=>'Both',2 => 'Process Server', 3 => 'Lawyer'),
	   'decorators' => array(
        'ViewHelper',
        array('Label', array('tag' => 'span')),
        array('HtmlTag', array('tag' => 'li'))
      ),
	
	));
	return $this->services_type_id;
}
}

	  
  
  public function getDisplayNameElement()
  {
    $this->addElement('Text', 'displayname', array(
      'label' => 'Name',
      'order' => -1000000,
      'decorators' => array(
        'ViewHelper',
        array('Label', array('tag' => 'span')),
        array('HtmlTag', array('tag' => 'li'))
      ),
      //'onkeypress' => 'return submitEnter(event)',
    ));
    return $this->displayname;
  }
  public function getKeywordElement()
  {
       
    $this->addElement('Text', 'keyword', array(
      'label' => 'Keyword',
      'decorators' => array(
        'ViewHelper',
        array('Label', array('tag' => 'span')),
        array('HtmlTag', array('tag' => 'li'))
      ),
    ));
     return $this->keyword;
  }

  public function getAdditionalOptionsElement()
  {
    $subform = new Zend_Form_SubForm(array(
      'name' => 'extra',
      'order' => 1000000,
      'decorators' => array(
        'FormElements',
      )
    ));
    Engine_Form::enableForm($subform);


   /* $subform->addElement('Checkbox', 'has_photo', array(
      'label' => 'Only Members With Photos',
      'decorators' => array(
        'ViewHelper',
        array('Label', array('placement' => 'APPEND', 'tag' => 'label')),
        array('HtmlTag', array('tag' => 'li'))
      ),
    ));

    $subform->addElement('Checkbox', 'is_online', array(
      'label' => 'Only Online Members',
      'decorators' => array(
        'ViewHelper',
        array('Label', array('placement' => 'APPEND', 'tag' => 'label')),
        array('HtmlTag', array('tag' => 'li'))
      ),
    ));*/

    $subform->addElement('Button', 'done', array(
      'label' => 'Search',
      'type' => 'submit',
      'ignore' => true,
    ));

    $this->addSubForm($subform, $subform->getName());

    return $this;
  }
}
