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
class User_Widget_ProfileOptionsController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
    // Don't render this if not authorized
    $viewer = Engine_Api::_()->user()->getViewer();
    if( !Engine_Api::_()->core()->hasSubject() || !$viewer->getIdentity()) {
      return $this->setNoRender();
    }

    // Get subject and check auth
    $this->view->member = $subject = Engine_Api::_()->core()->getSubject('user');
    //if( !$subject->authorization()->isAllowed($viewer, 'view') ) {
    //  return $this->setNoRender();
    //}
     
     $subject = Engine_Api::_()->core()->getSubject(); 
        
        $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($subject); 
    	
    	if( !empty($fieldsByAlias['profile_type']) ){
			
			  $optionId = $fieldsByAlias['profile_type']->getValue($subject);
			  $profile_type_id = $optionId->value; 
			  
		}
        $this->view->profile_type_id = $profile_type_id;
        
        if($profile_type_id == 1){

        $smartmoveapiRenters_table =  Engine_Api::_()->getDbtable('Smartmoveapirenters', 'user');  
        $smartmoveapiRentersData = $smartmoveapiRenters_table->fetchRow($smartmoveapiRenters_table->select()->where('tenant_id	 = ?', $subject->getIdentity()));
        if(count($smartmoveapiRentersData)>0){
			
			 $this->view->smartmoveRenterApiStatus = 1;
			
		}
		else{
			 $this->view->smartmoveRenterApiStatus = 0;
		}
        }
     
    $this->view->navigation = Engine_Api::_()
      ->getApi('menus', 'core')
      ->getNavigation('user_profile');
  }
}
