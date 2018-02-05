<?php

class User_Form_Admin_Manage_Editsmartmoveapiquestionanswer extends Engine_Form
{
	
	protected $_answerIdentity;
  
    public function setAnswerIdentity($_answerIdentity)
    {
    $this->_answerIdentity = (int) $_answerIdentity;
    return $this;
    }
    public function init()
   {
 
     $smartmoveapiquestionAnswer_table =  Engine_Api::_()->getDbtable('Smartmoveapiquestionanswers', 'user'); 
	 $oanswer = $smartmoveapiquestionAnswer_table->fetchRow(array(
      'id = ?' => $this->_answerIdentity,
    )); 

    $this->addElement('text', 'AnswerText', array(
      'label' => 'AnswerText',
      'allowEmpty' => false,
      'required' => true,
      'value' => $oanswer->answer_text,
    )); 
    $this->addElement('Textarea', 'AnswerDescription', array(
      'label' => 'AnswerDescription',
      'allowEmpty' => false,
      'required' => true,
      'value' => $oanswer->answer_description,
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
 

