<?php

class User_Form_Admin_Manage_Editsmartmoveapiquestion extends Engine_Form
{
	
	protected $_questionIdentity;
  
    public function setQuestionIdentity($_questionIdentity)
    {
    $this->_questionIdentity = (int) $_questionIdentity;
    return $this;
    }
    public function init()
   {
 
     $smartmoveapiquestions_table =  Engine_Api::_()->getDbtable('smartmoveapiquestions', 'user'); 
	 $oquestions = $smartmoveapiquestions_table->fetchRow(array(
      'qid = ?' => $this->_questionIdentity,
    )); 

    $this->addElement('Textarea', 'QuestionText', array(
      'label' => 'QuestionText',
      'allowEmpty' => false,
      'required' => true,
      'value' => $oquestions->qtext,
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
 

