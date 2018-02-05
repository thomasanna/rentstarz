<?php

class User_Form_Admin_Manage_Addsmartmoveapiquestionanswer extends Engine_Form
{
	
	protected $_questionsIdentity;
  
    public function setRatingquestionsIdentity($_questionsIdentity)
    {
    $this->_questionsIdentity = (int) $_questionsIdentity;
    return $this;
    }
    public function init()
   {
  
    /* $smartmoveapiquestions_table =  Engine_Api::_()->getDbtable('smartmoveapiquestions', 'user'); 
	 $oquestions = $smartmoveapiquestions_table->fetchRow(array(
      'qid = ?' => $this->_questionsIdentity,
    )); */

    $this->addElement('text', 'AnswerText', array(
      'label' => 'AnswerText',
      'allowEmpty' => false,
      'required' => true,
    )); 
    $this->addElement('Textarea', 'AnswerDescription', array(
      'label' => 'AnswerDescription',
      'allowEmpty' => false,
      'required' => true,
    )); 
    
    $this->addElement('checkbox', 'status', array(
    'label'=>'Select this answer as your selected answer',
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
 

