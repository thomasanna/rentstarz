<?php

class User_Form_Admin_Manage_Editpaymentsettings extends Engine_Form
{
	
	protected $_paymentIdentity;

  
    public function setPaymentIdentity($paymentIdentity)
    {
    $this->_paymentIdentity = (int) $paymentIdentity;
    return $this;
    }

    public function init()
    {
  
     $StripeSettingsTable =  Engine_Api::_()->getDbtable('Stripesettings', 'user'); 	
	 $StripeSettingsData = $StripeSettingsTable->fetchRow($StripeSettingsTable->select()->where('id = ?', $this->_paymentIdentity));


    
    $this->addElement('Text', 'payment_duration', array(
      'label' => 'Payment Duration in days',
      'allowEmpty' => false,
      'required' => true,
      'value' => $StripeSettingsData->payment_duration
    
    )); 
    
    $this->addElement('Text', 'credit_and_background_payment_amount', array(
      'label' => 'Credit and background payment amount',
      'allowEmpty' => false,
      'required' => true,
      'value' => $StripeSettingsData->credit_and_background_payment_amount
    
    )); 
    
    $this->addElement('Text', 'creditbackground_eviction_payment_amount', array(
      'label' => 'Credit and background + eviction payment amount',
      'allowEmpty' => false,
      'required' => true,
      'value' => $StripeSettingsData->creditbackground_eviction_payment_amount
    
    )); 
    
    $this->addElement('Text', 'creditscore_payment_amount', array(
      'label' => 'Creditscore payment amount',
      'allowEmpty' => false,
      'required' => true,
      'value' => $StripeSettingsData->creditscore_payment_amount
    
    )); 
    
    $this->addElement('Text', 'deduction_per_each_payment', array(
      'label' => 'Deduction per each payment',
      'allowEmpty' => false,
      'required' => true,
      'value' => $StripeSettingsData->deduction_per_each_payment
    
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
 

