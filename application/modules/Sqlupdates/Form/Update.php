<?php
/**
 * unii.com
 *
 * @category   Application_Extensions
 * @package    Poll
 * @copyright  Copyright 2012-2013 unii.com
 * @license    http://www.unii.com/license
 * @version    $Id: default.tpl 9747 2012-07-26 02:08:08Z Ti Technologies (www.titechnologies.in) $
 * @author     Ti Technologies (www.titechnologies.in)
 */

/**
 * @category   Application_Extensions
 * @package    Poll
 * @copyright  Copyright 2012-2013 unii.com
 * @license    http://www.unii.com/license
 */
class Sqlupdates_Form_Update extends Engine_Form
{
  public function init()
  {
    $this
      ->setAttribs(array(
        'id' => 'filter_form',
        'class' => 'global_form_box',
      ))
      ->setMethod('POST')
      ->setAction(Zend_Controller_Front::getInstance()->getRouter()->assemble(array('page' => null)))
      ;

    parent::init();

    $this->addElement('File', 'files', array(
      'label' => 'Insert file:',
    ));

 // Submit
    $this->addElement('Button', 'submit', array(
      'label' => 'Update Database',
      'ignore' => true,
      'decorators' => array('ViewHelper'),
      'type' => 'submit'
    ));
  }
}
