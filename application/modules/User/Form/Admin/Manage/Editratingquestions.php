<?php

class User_Form_Admin_Manage_Editratingquestions extends Engine_Form
{
	
	protected $_ratingquestionsIdentity;
  
    public function setRatingquestionsIdentity($_ratingquestionsIdentity)
    {
    $this->_ratingquestionsIdentity = (int) $_ratingquestionsIdentity;
    return $this;
    }
    public function init()
   {
  
     $ratingquestions_table =  Engine_Api::_()->getDbtable('ratingquestions', 'user'); 
	 $oquestions = $ratingquestions_table->fetchRow(array(
      'id = ?' => $this->_ratingquestionsIdentity,
    )); 

    $this->addElement('Textarea', 'question', array(
      'label' => 'Question',
      'allowEmpty' => false,
      'required' => true,
      'value' => $oquestions->questions,
    )); 
    
    $this->addElement('radio', 'status', array(
    'label'=>'Question Status',
    'value' => $oquestions->status,
    'multiOptions'=>array(
        '0' => 'Positive',
        '-1' => 'Negative',
    ),
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
 

