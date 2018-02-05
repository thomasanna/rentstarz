<?php

/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Controller.php 2015-01-22 00:00:53Z shaun $
 * @author     John Boehr <john@socialengine.com>
 */

/**
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class User_Widget_BrowseSearchController extends Engine_Content_Widget_Abstract
{
    public function indexAction()
    {
	    $current_url = explode("?", $_SERVER['REQUEST_URI']);
        $this->view->page_url=$page_url = $current_url[0] ; 
		
		$pagecount = explode("&", $_SERVER['REQUEST_URI']);
        $pagecount = $pagecount[2];
        $pcount = explode('=', $pagecount);
        $this->view->pagination_count = $pcount[1];
        // Prepare form
        
        if($page_url =='/tenants'){
        $this->view->form = $form = new User_Form_Search(array(
            'type' => 'user',
            'ptype' => 'tenants'
        ));
	    }
        if($page_url =='/members'){
        $this->view->form = $form = new User_Form_Search(array(
            'type' => 'user',
            'ptype' => 'user'
        ));
	    }
        if($page_url =='/landlords'){
        $this->view->form = $form = new User_Form_Search(array(
            'type' => 'user',
            'ptype' => 'landlords'
        ));
	    }
	    if($page_url =='/services'){
        $this->view->form = $form = new User_Form_Search(array(
            'type' => 'user',
            'ptype' => 'services'
        ));
	    }
        $p = Zend_Controller_Front::getInstance()->getRequest()->getParams();
        $form->populate($p);
        $this->view->topLevelId = $form->getTopLevelId();
        $this->view->topLevelValue = $form->getTopLevelValue();
    }
}
