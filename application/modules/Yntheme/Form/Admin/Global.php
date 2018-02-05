<?php

class Yntheme_Form_Admin_Global extends Engine_Form
{
  public function init()
  {
    $this
      ->setTitle('Global Settings')
      ->setDescription('These settings affect all members in your community.');
	
	$this->addElement('radio','enabled',array(
		'label'=>'Enabled',
		'description'=>'Allow users select skin of theme.',
		'multiOptions'=>array(
			0=>'Do not allow users select skin of theme.',
			1=>'Allow users select skin of theme'
		),
		'value'=>1,
	));
    // Add submit button
    $this->addElement('Button', 'submit', array(
      'label' => 'Save Changes',
      'type' => 'submit',
      'ignore' => true
    ));
  }
}