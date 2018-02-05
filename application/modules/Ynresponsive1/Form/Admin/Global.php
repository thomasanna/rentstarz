<?php


class Ynresponsive1_Form_Admin_Global extends Engine_Form
{
  public function init()
  {
    $this
      ->setTitle('Global Settings')
      ->setDescription('These settings affect all members in your community.');
     $this->addElement('Checkbox', 'form_mode', array(
        'label' => 'Apply WYSIHTML5 on mobile',
        'description' => 'Select the way you want to choose Editor on mobile',        
        'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('form.mode', 1),
      )); 
	
	// Customized homepage after login
     $this->addElement('Radio', 'ynresponsive1_setuphomepage', array(
      'label' => 'Customized Homepage After Login',
      'description' => "Your site will have landing page as homepage and user home page will be moved to Dashboard.",
      'multiOptions' => array(
        1 => 'Yes, allow customize homepage.',
        0 => 'No, not allow customize homepage.'
      ),
      'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('ynresponsive1.setuphomepage', 0),
    ));
	
    // Add submit button
    $this->addElement('Button', 'submit', array(
      'label' => 'Save Changes',
      'onclick' => 'customHomePage()',
      'type' => 'submit',
      'ignore' => true
    ));
  }
}