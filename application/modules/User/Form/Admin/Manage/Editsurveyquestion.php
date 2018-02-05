<?php

class User_Form_Admin_Manage_Editsurveyquestion extends Engine_Form
{
	
	protected $_surveyquestionIdentity;
  
    public function setsurveyquestionIdentity($_surveyquestionIdentity)
    {
    $this->_surveyquestionIdentity = (int) $_surveyquestionIdentity;
    return $this;
    }
    public function init()
    {
      $surveyquestions_table =  Engine_Api::_()->getDbtable('surveyquestions', 'user'); 
	  $osurveyquestions= $surveyquestions_table->fetchRow(array(
      'id = ?' => $this->_surveyquestionIdentity,
    )); 

    $this->addElement('Text', 'question', array(
      'label' => 'Question',
      'allowEmpty' => false,
      'required' => true,
      'value' => $osurveyquestions->questions,
    )); 
   

    
    // Buttons
    $this->addElement('Button', 'submit', array(
      'label' => 'Save Changes',
      'type' => 'submit',
      'ignore' => true,
      'decorators' => array('ViewHelper')
    ));

    $this->addElement('Cancel', 'cancel', array(
      'label' => 'cancel',
      'link' => true,
      'prependText' => ' or ',
      'onclick' => 'parent.Smoothbox.close();',
      'decorators' => array(
        'ViewHelper'
      )
    ));

    $this->addDisplayGroup(array('submit', 'cancel'), 'buttons');
    $button_group = $this->getDisplayGroup('buttons');
    $button_group->addDecorator('DivDivDivWrapper');  
  }
  
 } 
 

