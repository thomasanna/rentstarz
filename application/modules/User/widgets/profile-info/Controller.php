<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Controller.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class User_Widget_ProfileInfoController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
	  //hide member info when a landlord clicks tenants profile
	$viewer = Engine_Api::_()->user()->getViewer();
    $viewerId	=	$viewer->getIdentity();
    
    $subject = Engine_Api::_()->core()->getSubject(); 
    $subject_id=$subject->getIdentity();
    
    $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer); 
    $subject_profiletype = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer); 
       if( !empty($fieldsByAlias['profile_type']) )
			{
			  $optionId = $fieldsByAlias['profile_type']->getValue($viewer);
			  $profile_type_id = $optionId->value; 
			} 
       if( !empty($subject_profiletype['profile_type']) )
			{
			  $subjectoptionId = $subject_profiletype['profile_type']->getValue($subject);
			  $subjectprofile_type_id = $subjectoptionId->value; 
			} 
    if($profile_type_id  == 4 &&  $subjectprofile_type_id==1)
	{
		return $this->setNoRender();
	}	
		
    // Don't render this if not authorized
    $this->view->viewer = $viewer = Engine_Api::_()->user()->getViewer();
    if( !Engine_Api::_()->core()->hasSubject() ) {
      return $this->setNoRender();
    }

    // Get subject and check auth
    $this->view->subject = $subject = Engine_Api::_()->core()->getSubject('user');
    if( !$subject->authorization()->isAllowed($viewer, 'view') ) {
      return $this->setNoRender();
    }

    // Member type
    $subject = Engine_Api::_()->core()->getSubject();
    $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($subject);
    //echo '<pre>'; print_r($fieldsByAlias); exit;

    if( !empty($fieldsByAlias['profile_type']) )
    {
      $optionId = $fieldsByAlias['profile_type']->getValue($subject);
      if( $optionId ) {
        $optionObj = Engine_Api::_()->fields()
          ->getFieldsOptions($subject)
          ->getRowMatching('option_id', $optionId->value);
        if( $optionObj ) {
          $this->view->memberType = $optionObj->label;
        }
      }
    }
    
    //gender
    
    $gender_id = $fieldsByAlias['gender']->getValue($subject);
    if( $gender_id ) { 
     
        $genderObj = Engine_Api::_()->fields()
          ->getFieldsOptions($subject)
          ->getRowMatching('option_id', $gender_id->value);
          if( $genderObj ) {
          $this->view->gender = $genderObj->label;
        }
          
	}

    // Networks
    $select = Engine_Api::_()->getDbtable('membership', 'network')->getMembershipsOfSelect($subject)
      ->where('hide = ?', 0);
    $this->view->networks = Engine_Api::_()->getDbtable('networks', 'network')->fetchAll($select);
    
    // Friend count
    $this->view->friendCount = $subject->membership()->getMemberCount($subject);
  }
}
