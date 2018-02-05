<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Group
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Controller.php 9747 2012-07-26 02:08:08Z john $
 * @author     John Boehr <john@socialengine.com>
 */

/**
 * @category   Application_Extensions
 * @package    Group
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Group_Widget_BrowseSearchController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    
    $request = Zend_Controller_Front::getInstance()->getRequest();
    $p = $request->getParams();
    
    // Form
    if ( $request->getModuleName() == 'group' && $request->getControllerName() == 'index' && $request->getActionName() == 'manage' ) {
      $this->view->form = $formFilter = new Group_Form_Filter_Manage();
      $defaultValues = $formFilter->getValues();
    } else {
      $this->view->form = $formFilter = new Group_Form_Filter_Browse();
      $defaultValues = $formFilter->getValues();

      if ( !$viewer || !$viewer->getIdentity() ) {
        $formFilter->removeElement('view');
      }

      // Populate options
      $categories = Engine_Api::_()->getDbtable('categories', 'group')->getCategoriesAssoc();
      $formFilter->category_id->addMultiOptions($categories);
    }

    // Populate form data
    if( $formFilter->isValid($p) ) {
      $this->view->formValues = $values = $formFilter->getValues();
    } else {
      $formFilter->populate($defaultValues);
      $this->view->formValues = $values = array();
    }

    // Prepare data
    $this->view->formValues = $values = $formFilter->getValues();

    if( $viewer->getIdentity() && @$values['view'] == 1 ) {
      $values['users'] = array();
      foreach( $viewer->membership()->getMembersInfo(true) as $memberinfo ) {
        $values['users'][] = $memberinfo->user_id;
      }
    }

    $values['search'] = 1;

    // check to see if request is for specific user's listings
    $user_id = $this->_getParam('user');
    if( $user_id ) {
      $values['user_id'] = $user_id;
    }
  }
}
