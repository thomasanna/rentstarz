<?php

class User_Form_Admin_Manage_Transunion extends Engine_Form
{

 public function init()
   {
   $this->addElement('Text', 'user_backgroundReportExpiry', array(
          'label' => 'Background report expiry',
          'description' => 'Enter the background report expiry in days',
          'value' => '30',
          'required' => true,
          'allowEmpty' => false
        ));
   $this->addElement('Text', 'user_creditAndBackgroundPaymentAmount', array(
          'label' => 'Credit and background payment Amount',
          'value' => '49.99',
          'required' => true,
          'allowEmpty' => false
        ));
   $this->addElement('Text', 'user_creditAndBackgroundPlusEvictionPaymentAmount', array(
          'label' => 'Credit and background plus eviction payment amount',
          'value' => '59.99',
          'required' => true,
          'allowEmpty' => false
        ));
   $this->addElement('Text', 'user_creditScorePaymentAmount', array(
          'label' => 'Credit score payment amount',
          'value' => '9.99',
          'required' => true,
          'allowEmpty' => false
        ));
   $this->addElement('Text', 'user_deductionPerEachPayment', array(
          'label' => 'Deduction per each payment',
          'value' => '5',
          'required' => true,
          'allowEmpty' => false
        ));
   $this->addElement('Text', 'user_numberOfReportSharePerDay', array(
          'label' => 'Number of report share per day',
          'value' => '5',
          'required' => true,
          'allowEmpty' => false
        ));
	
   $this->addElement('Button', 'submit', array(
            'label' => 'Save',
            'type' => 'submit',
        ));
   }
}
