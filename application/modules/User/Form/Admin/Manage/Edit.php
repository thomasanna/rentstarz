<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Edit.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class User_Form_Admin_Manage_Edit extends Engine_Form
{
  protected $_userIdentity;
  
  public function setUserIdentity($userIdentity)
  {
    $this->_userIdentity = (int) $userIdentity;
    return $this;
  }
  
  public function init()
  {
    $this
      ->setAttrib('id', 'admin_members_edit')
      ->setTitle('Edit Member')
      ->setDescription('You can change the details of this member\'s account here.')
      ->setAction($_SERVER['REQUEST_URI']);

    // init email
    $this->addElement('Text', 'email', array(
      'label' => 'Email Address',
      'validators' => array(
        array('NotEmpty', true),
        array('EmailAddress', true),
        array('Db_NoRecordExists', true, array(
          Engine_Db_Table::getTablePrefix() . 'users', 'email', array(
            'field' => 'user_id',
            'value' => (int) $this->_userIdentity
        )))
      ),
      'filters' => array(
        'StringTrim'
      )
    ));
    $this->email->getValidator('EmailAddress')->getHostnameValidator()->setValidateTld(false);
    // init username
    if( Engine_Api::_()->getApi('settings', 'core')->getSetting('user.signup.username', 1) > 0 ) {
      $this->addElement('Text', 'username', array(
        'label' => 'Username'
      ));
    }

    // init password
    $this->addElement('Password', 'password', array(
      'label' => 'Password',
    ));
    $this->addElement('Password', 'password_conf', array(
      'label' => 'Password Again',
    ));
    $user = Engine_Api::_()->getItem('user', $this->_userIdentity);
    
    $fieldsByAlias    = Engine_Api::_()->fields()->getFieldsObjectsByAlias($user);
        if( !empty($fieldsByAlias['profile_type']) )
        {
           $optionId        = $fieldsByAlias['profile_type']->getValue($user);
           $profile_type_id = $optionId->value;
        }
        if($profile_type_id  == 4){ //profile type is landlord or not
            $is_landlord = 1;
            $lev_id=6;
        }
        if($profile_type_id  == 1){ //profile type is tenant or not
            $is_landlord = 1;
            $lev_id=7;
        }
        
        
    // Init level
    $levelMultiOptions = array(); //0 => ' ');
    $levels = Engine_Api::_()->getDbtable('levels', 'authorization')->fetchAll();
    foreach( $levels as $row ) {
	  if(($user->level_id ==	$row->level_id )|| ($row->level_id == 1) || ($row->level_id==$lev_id) )	{
      $levelMultiOptions[$row->level_id] = $row->getTitle();
      }
    }
   // $levelMultiOptions = array('Select','Super Admin');
    //print_r($levelMultiOptions);exit;
    $this->addElement('Select', 'level_id', array(
      'label' => 'Member Level',
      'multiOptions' => $levelMultiOptions
    ));
    
    
    
     if($user->level_id	==	7)
     {
			$this->addElement('Text', 'creditscore', array(
				  'label' => 'Credit Score',
				  'filters' => array(
					'StringTrim'
				  )
		));
	 }

    // Init level
    $networkMultiOptions = array(); //0 => ' ');
    $networks = Engine_Api::_()->getDbtable('networks', 'network')->fetchAll();
    foreach( $networks as $row ) {
      $networkMultiOptions[$row->network_id] = $row->getTitle();
    }
    $this->addElement('Multiselect', 'network_id', array(
      'label' => 'Networks',
      'multiOptions' => $networkMultiOptions
    ));

    // Init approved
    $this->addElement('Checkbox', 'approved', array(
      'label' => 'Approved?',
    ));

    // Init verified
    $this->addElement('Checkbox', 'verified', array(
      'label' => 'Email Verified?'
    ));

    // Init enabled
    $this->addElement('Checkbox', 'enabled', array(
      'label' => 'Enabled?',
    ));
    
     //if($user->level_id	==	7)
    // {
		$this->addElement('Checkbox', 'bg_verified', array(
		  'label' => 'Background verified?',
		));
	 //}

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
