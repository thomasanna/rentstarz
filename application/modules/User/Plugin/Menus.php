<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Menus.php 9770 2012-08-30 02:36:05Z richard $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class User_Plugin_Menus
{
  public function canDelete()
  {
    // Check subject
    if( !Engine_Api::_()->core()->hasSubject('user') ) {
      return false;
    }
    $subject = Engine_Api::_()->core()->getSubject('user');

    // Check viewer
    $viewer = Engine_Api::_()->user()->getViewer();
    if( !$viewer || !$viewer->getIdentity() ) {
      return false;
    }

    // Check auth
    return (bool) $subject->authorization()->isAllowed($viewer, 'delete');
  }


  
  // core_main

  public function onMenuInitialize_CoreMainHome($row)
  {
    $viewer  = Engine_Api::_()->user()->getViewer();
    $request = Zend_Controller_Front::getInstance()->getRequest();
    $route   = array(
      'route' => 'default',
    );

    if( $viewer->getIdentity() ) {
      $route['route']  = 'user_general';
      $route['params'] = array(
        'action' => 'home',
      );
      if( 'user'  == $request->getModuleName() && 
          'index' == $request->getControllerName() && 
          'home'  == $request->getActionName() ) {
        $route['active'] = true;
      }
    }
    return $route;
  }



  // core_mini

  public function onMenuInitialize_CoreMiniAdmin($row)
  {
    // @todo check perms
    if( Engine_Api::_()->getApi('core', 'authorization')->isAllowed('admin', null, 'view') ) {
      return array(
        'label' => $row->label,
        'route' => 'admin_default',
        'class' => 'no-dloader',
      );
    }

    return false;
  }

  public function onMenuInitialize_CoreMiniProfile($row)
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    if( $viewer->getIdentity() ) {
      return array(
        'label' => $row->label,
        'uri' => $viewer->getHref(),
      );
    }
    
    return false;
  }

  public function onMenuInitialize_CoreMiniSettings($row)
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    if( $viewer->getIdentity() ) {
      return array(
        'label' => $row->label,
        'route' => 'user_extended',
        'params' => array(
          'controller' => 'settings',
          'action' => 'general',
        )
      );
    }
    
    return false;
  }

  public function onMenuInitialize_CoreMiniAuth($row)
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    if( $viewer->getIdentity() ) {
      return array(
        'label' => 'Sign Out',
        'route' => 'user_logout',
        'class' => 'no-dloader',
      );
    } else {
      return array(
        'label' => 'Sign In',
        'route' => 'user_login',
        'params' => array(
          // Nasty hack
          'return_url' => '64-' . base64_encode($_SERVER['REQUEST_URI']),
        ),
      );
    }
  }

  public function onMenuInitialize_CoreMiniSignup($row)
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    if( !$viewer->getIdentity() ) {
      return array(
        'label' => 'Sign Up',
        'route' => 'user_signup'
      );
    }

    return false;
  }
  
  
  
  // user_edit
  
  public function onMenuInitialize_UserEditStyle($row)
  {
    if( Engine_Api::_()->core()->hasSubject('user') ) {
      $user = Engine_Api::_()->core()->getSubject('user');
    } else {
      $user = Engine_Api::_()->user()->getViewer();
    }
    if( !$user->getIdentity() ) {
      return false;
    }
    return (bool) Engine_Api::_()->getDbtable('permissions', 'authorization')
        ->getAllowed('user', $user->level_id, 'style');
  }



  // user_home

  public function onMenuInitialize_UserHomeView($row)
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    if( $viewer->getIdentity() ) {
      return array(
        'label' => $row->label,
        'icon' => 'application/modules/User/externals/images/view_my_profile.svg',
        'route' => 'user_profile',
        'params' => array(
          'id' => $viewer->getIdentity()
        )
      );
    }
    return false;
  }

  public function onMenuInitialize_UserHomeEdit($row)
  {
    $viewer = Engine_Api::_()->user()->getViewer();

    // @todo move to authorization
    return array(
      'label' => 'Edit My Profile',
      'icon' => 'application/modules/User/externals/images/edit_profile.svg',
      'route' => 'user_extended',
      'params' => array(
        'controller' => 'edit',
        'action' => 'profile'
      )
    );
  }



  // user_profile

  public function onMenuInitialize_UserProfileEdit($row)
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    $subject = Engine_Api::_()->core()->getSubject();

    $label = "Edit My Profile";
    if( !$viewer->isSelf($subject) ) {
      $label = "Edit Member Profile";
    }

    if( $subject->authorization()->isAllowed($viewer, 'edit') ) {
    if( $viewer->isSelf($subject) ) {
      return array(
        'label' => $label,
        'icon' => 'application/modules/User/externals/images/edit_profile.svg',
        'route' => 'user_extended',
        'params' => array(
          'controller' => 'edit',
          'action' => 'profile',
          'id' => ( $viewer->getGuid(false) == $subject->getGuid(false) ? null : $subject->getIdentity() ),
        )
      );
    }
    }

    return false;
  }
  
  public function onMenuInitialize_UserProfileFriend($row)
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    $subject = Engine_Api::_()->core()->getSubject();

    // Not logged in
    if( !$viewer->getIdentity() || $viewer->getGuid(false) === $subject->getGuid(false) ) {
      return false;
    }
    
    // No blocked
    if( $viewer->isBlockedBy($subject) ) {
      return false;
    }

    // Check if friendship is allowed in the network
    $eligible = (int) Engine_Api::_()->getApi('settings', 'core')->getSetting('user.friends.eligible', 2);
    if( !$eligible ) {
      return '';
    }

    // check admin level setting if you can befriend people in your network
    else if( $eligible == 1 ){
      
      $networkMembershipTable = Engine_Api::_()->getDbtable('membership', 'network');
      $networkMembershipName = $networkMembershipTable->info('name');

      $select = new Zend_Db_Select($networkMembershipTable->getAdapter());
      $select
        ->from($networkMembershipName, 'user_id')
        ->join($networkMembershipName, "`{$networkMembershipName}`.`resource_id`=`{$networkMembershipName}_2`.resource_id", null)
        ->where("`{$networkMembershipName}`.user_id = ?", $viewer->getIdentity())
        ->where("`{$networkMembershipName}_2`.user_id = ?", $subject->getIdentity())
        ;

      $data = $select->query()->fetch();

      if( empty($data) ) {
        return '';
      }
    }

    // One-way mode
    $direction = (int) Engine_Api::_()->getApi('settings', 'core')->getSetting('user.friends.direction', 1);
    if( !$direction ) {
      $viewerRow = $viewer->membership()->getRow($subject);
      $subjectRow = $subject->membership()->getRow($viewer);
      $params = array();
      
      // Viewer?
      if( null === $subjectRow ) {
        // Follow
        $params[] = array(
          'label' => 'Follow',
          'icon' => 'application/modules/User/externals/images/friends/add.png',
          'class' => 'smoothbox',
          'route' => 'user_extended',
          'params' => array(
            'controller' => 'friends',
            'action' => 'add',
            'user_id' => $subject->getIdentity()
          ),
        );
      } else if( $subjectRow->resource_approved == 0 ) {
        // Cancel follow request
        $params[] = array(
          'label' => 'Cancel Follow Request',
          'icon' => 'application/modules/User/externals/images/friends/remove.png',
          'class' => 'smoothbox',
          'route' => 'user_extended',
          'params' => array(
            'controller' => 'friends',
            'action' => 'cancel',
            'user_id' => $subject->getIdentity()
          ),
        );
      } else {
        // Unfollow
        $params[] = array(
          'label' => 'Unfollow',
          'icon' => 'application/modules/User/externals/images/friends/remove.png',
          'class' => 'smoothbox',
          'route' => 'user_extended',
          'params' => array(
            'controller' => 'friends',
            'action' => 'remove',
            'user_id' => $subject->getIdentity()
          ),
        );
      }
      // Subject?
      if( null === $viewerRow ) {
        // Do nothing
      } else if( $viewerRow->resource_approved == 0 ) {
        // Approve follow request
        $params[] = array(
          'label' => 'Approve Follow Request',
          'icon' => 'application/modules/User/externals/images/friends/add.png',
          'class' => 'smoothbox',
          'route' => 'user_extended',
          'params' => array(
            'controller' => 'friends',
            'action' => 'confirm',
            'user_id' => $subject->getIdentity()
          ),
        );
      } else {
        // Remove as follower?
        $params[] = array(
          'label' => 'Remove as Follower',
         'icon' => 'application/modules/User/externals/images/friends/remove.png',
          'class' => 'smoothbox',
          'route' => 'user_extended',
          'params' => array(
            'controller' => 'friends',
            'action' => 'remove',
            'user_id' => $subject->getIdentity(),
            'rev' => true,
          ),
        );
      }
      if( count($params) == 1 ) {
        return $params[0];
      } else if( count($params) == 0 ) {
        return false;
      } else {
        return $params;
      }
    }

    // Two-way mode
    else {
      $row = $viewer->membership()->getRow($subject);
      if( null === $row ) {
        // Add
        return array(
          'label' => 'Add to My Friends',
         'icon' => 'application/modules/User/externals/images/friends/add.png',
          'class' => 'smoothbox',
          'route' => 'user_extended',
          'params' => array(
            'controller' => 'friends',
            'action' => 'add',
            'user_id' => $subject->getIdentity()
          ),
        );
      } else if( $row->user_approved == 0 ) {
        // Cancel request
        return array(
          'label' => 'Cancel Friend Request',
         'icon' => 'application/modules/User/externals/images/friends/cancel_frnd_reqst.png',
          'class' => 'smoothbox',
          'route' => 'user_extended',
          'params' => array(
            'controller' => 'friends',
            'action' => 'cancel',
            'user_id' => $subject->getIdentity()
          ),
        );
      } else if( $row->resource_approved == 0 ) {
        // Approve request
        return array(
          'label' => 'Approve Friend Request',
          'icon' => 'application/modules/User/externals/images/friends/add.png',
          'class' => 'smoothbox',
          'route' => 'user_extended',
          'params' => array(
            'controller' => 'friends',
            'action' => 'confirm',
            'user_id' => $subject->getIdentity()
          ),
        );
      } else {
        // Remove friend
        return array(
          'label' => 'Remove from Friends',
          'icon' => 'application/modules/User/externals/images/friends/remove.png',
          'class' => 'smoothbox',
          'route' => 'user_extended',
          'params' => array(
            'controller' => 'friends',
            'action' => 'remove',
            'user_id' => $subject->getIdentity()
          ),
        );
      }
    }
  }

  public function onMenuInitialize_UserProfileBlock($row)
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    $subject = Engine_Api::_()->core()->getSubject();

    // Can't block self or if not logged in
    if( !$viewer->getIdentity() || $viewer->getGuid() == $subject->getGuid() ) {
      return false;
    }

    if( !Engine_Api::_()->authorization()->isAllowed('user', $viewer, 'block') ) {
      return false;
    }
    
    if( !$subject->isBlockedBy($viewer) ) {
      return array(
        'label' => 'Block Member',
       'icon' => 'application/modules/User/externals/images/block.png',
        'class' => 'smoothbox',
        'route' => 'user_extended',
        'params' => array(
          'controller' => 'block',
          'action' => 'add',
          'user_id' => $subject->getIdentity()
        ),
      );
    } else {
      return array(
        'label' => 'Unblock Member',
        'icon' => 'application/modules/User/externals/images/block.png',
        'class' => 'smoothbox',
        'route' => 'user_extended',
        'params' => array(
          'controller' => 'block',
          'action' => 'remove',
          'user_id' => $subject->getIdentity()
        ),
      );
    }
  }

  public function onMenuInitialize_UserProfileReport($row)
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    $subject = Engine_Api::_()->core()->getSubject();

    if( !$viewer->getIdentity() || 
        !$subject->getIdentity() || 
        $viewer->isSelf($subject) ) {
      return false;
    } else {
      return array(
        'label' => 'Report',
       'icon' => 'application/modules/Core/externals/images/report.png',
        'class' => 'smoothbox',
        'route' => 'default',
        'params' => array(
          'module' => 'core',
          'controller' => 'report',
          'action' => 'create',
          'subject' => $subject->getGuid(),
          'format' => 'smoothbox',
        ),
      );
    }
  }

  public function onMenuInitialize_UserProfileAdmin($row)
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    $subject = Engine_Api::_()->core()->getSubject();

	if( $subject->authorization()->isAllowed($viewer, 'delete') ) {
    if( !$viewer->isAdmin()) {
      return false;
    } else {
      return array(
        'label' => 'Admin Settings',
        'icon' => 'application/modules/User/externals/images/edit.png',
        'class' => 'smoothbox',
        'route' => 'admin_default',
        'params' => array(
          'module' => 'user',
          'controller' => 'manage',
          'action' => 'edit',
          'id' => $subject->getIdentity(),
          //'open' => 1,
          'format' => 'smoothbox',
        ),
      );
    }
  }
  }
  public function onMenuInitialize_UserIndexPropertylist($row)
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    $subject = Engine_Api::_()->core()->getSubject(); 
    $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($subject); 
	if( !empty($fieldsByAlias['profile_type']) )
				{
				  $optionId = $fieldsByAlias['profile_type']->getValue($subject);
				  $profile_type_id = $optionId->value; 
				} 
				
	if( $profile_type_id == 4 ) { // only for landlords
    if($viewer->getIdentity() == $subject->getIdentity()){
	   $label = 'My Properties';
	    return array(
        'label' => 'My Properties',
         'icon' => 'application/modules/User/externals/images/my_properties.svg',
        'route' => 'user_myproperties',
        'params' => array(
          'module' => 'user',
          'controller' => 'index',
          'action' => 'myproperties',
          'id' => $viewer->getIdentity(),
        ),
      );
    }
    else{
		$label ='Properties';
		return array(
        'label' => $label,
         'icon' => 'application/modules/User/externals/images/property.png',
        'route' => 'user_propertylist',
        'params' => array(
          'module' => 'user',
          'controller' => 'index',
          'action' => 'propertylist',
          'id' => $subject->getIdentity(),
        ),
      );
	}
      
    
    }
  }
  
  public function onMenuInitialize_UserIndexMyproperties($row)
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    
    $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer); 
    
    if( !empty($fieldsByAlias['profile_type']) )
				{
				  $optionId = $fieldsByAlias['profile_type']->getValue($viewer);
				  $profile_type_id = $optionId->value; 
				} 
	if( $profile_type_id == 4 ) { // only for landlords
  
      return array(
        'label' => 'My Properties',
         'icon' => 'application/modules/User/externals/images/my_properties.svg',
        'route' => 'user_myproperties',
        'params' => array(
          'module' => 'user',
          'controller' => 'index',
          'action' => 'myproperties',
          'id' => $viewer->getIdentity(),
        ),
      );

    }
  }
  
  public function onMenuInitialize_UserIndexAddproperty($row)
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    if( $viewer->getIdentity() ) {
		
	$fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer); 
    	
    	if( !empty($fieldsByAlias['profile_type']) )
			{
			  $optionId = $fieldsByAlias['profile_type']->getValue($viewer);
			  $profile_type_id = $optionId->value; 
			}	

	if($profile_type_id == 4){ // landlord
      return array(
        'label' => $row->label,
         'icon' => 'application/modules/User/externals/images/add_property.svg',
        'route' => 'user_addproperty',
        'params' => array(
          'module' => 'user',
          'controller' => 'index',
          'action' => 'addproperty',
         
        )
      );
    }
    }
    return false;
  }
  
   public function onMenuInitialize_UserProfileFriends($row)
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    $subject = Engine_Api::_()->core()->getSubject();

    $label = "Browse Members";
    if( !$viewer->isSelf($subject) ) {
      $label = "Browse Members";
    }

    if( $viewer->getIdentity() == $subject->getIdentity() ) {
      return array(
        'label' => $label,
        'icon' => 'application/modules/User/externals/images/browse.svg',
        'route' => 'user_general',
        'params' => array(
          'controller' => 'index',
          'action' => 'browse',
          //'id' => ( $viewer->getGuid(false) == $subject->getGuid(false) ? null : $subject->getIdentity() ),
        )
      );
    }

    return false;
  }
  
   public function onMenuInitialize_UserProfileInvite($row)
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    $subject = Engine_Api::_()->core()->getSubject();

    $label = "Invite Your Friends";
    if( !$viewer->isSelf($subject) ) {
      $label = "Invite Your Friends";
    }

    if( $viewer->getIdentity() == $subject->getIdentity() ) {
      return array(
        'label' => $label,
        'icon' => 'application/modules/User/externals/images/invite-friends.png',
        'route' => 'default',
        'params' => array(
         'module' => 'invite',

          //'id' => ( $viewer->getGuid(false) == $subject->getGuid(false) ? null : $subject->getIdentity() ),
        )
      );
    }

    return false;
  }
  
   public function onMenuInitialize_UserProfileUpdates($row)
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    $subject = Engine_Api::_()->core()->getSubject();

    $label = "View Recent Updates";
    if( !$viewer->isSelf($subject) ) {
      $label = "View Recent Updates";
    }

    if( $viewer->getIdentity() == $subject->getIdentity() ) {
      return array(
        'label' => $label,
       'icon' => 'application/modules/User/externals/images/update.svg',
        'route' => 'recent_activity',
        'params' => array(
         'module' => 'user',

          //'id' => ( $viewer->getGuid(false) == $subject->getGuid(false) ? null : $subject->getIdentity() ),
        )
      );
    }

    return false;
  }
  
   public function onMenuInitialize_UserProfileAddproperty($row)
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    $subject = Engine_Api::_()->core()->getSubject();


     if( $viewer->getIdentity() == $subject->getIdentity() ) {
		$fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($subject); 
		if( !empty($fieldsByAlias['profile_type']) )
			{
			  $optionId = $fieldsByAlias['profile_type']->getValue($subject);
			  $profile_type_id = $optionId->value; 
			} 
		 
	if($profile_type_id == 4){ // landlord
      return array(
        'label' => $row->label,
        'icon' => 'application/modules/User/externals/images/add_property.svg',
        'route' => 'user_addproperty',
        'params' => array(
          'module' => 'user',
          'controller' => 'index',
          'action' => 'addproperty',
         
        )
      );
    }
    }

    return false;
  }
   public function onMenuInitialize_UserProfileView($row)
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    $subject = Engine_Api::_()->core()->getSubject();


    if( $viewer->getIdentity() == $subject->getIdentity() ) {

      return array(
        'label' => $row->label,
       'icon' => 'application/modules/User/externals/images/view_my_profile.svg',
        'route' => 'user_profile',
         'params' => array(
          'id' => $viewer->getIdentity()
        )
      );
    
    }

    return false;
  }
  
   public function onMenuInitialize_CoreMainProperties($row)
  {
    $viewer  = Engine_Api::_()->user()->getViewer();
    $request = Zend_Controller_Front::getInstance()->getRequest();
    $route   = array(
      'route' => 'search_properties',
    );

    return $route;
  }
   public function onMenuInitialize_UserEditDocumentslist($row)
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    $subject = Engine_Api::_()->core()->getSubject();

    $label = "Document Requests";
    
    $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($subject); 
   
    if( !empty($fieldsByAlias['profile_type']) )
			{
			  $optionId = $fieldsByAlias['profile_type']->getValue($subject);
			  $profile_type_id = $optionId->value; 
			}

   if($profile_type_id == 1){
      return array(
        'label' => $label,
       
        'route' => 'user_extended',
        'params' => array(
        'module' => 'user',
          'controller' => 'edit',
          'action' => 'documentrequests',
          
        )
      );
    }

    return false;
  }
   public function onMenuInitialize_UserEditDocument($row)
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    $subject = Engine_Api::_()->core()->getSubject();

    $label = "Documents";
   
    $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($subject); 
   
    if( !empty($fieldsByAlias['profile_type']) )
			{
			  $optionId = $fieldsByAlias['profile_type']->getValue($subject);
			  $profile_type_id = $optionId->value; 
			}
    if($profile_type_id  == 1){
      return array(
        'label' => $label,
       
        'route' => 'user_extended',
        'params' => array(
        'module' => 'user',
          'controller' => 'edit',
          'action' => 'document',
          
        )
      );
    }

    return false;
  }
  
   public function onMenuInitialize_UserHomeUpdates($row)
  {
    $viewer = Engine_Api::_()->user()->getViewer();

      return array(
        'label' => $row->label,
        'icon' => 'application/modules/User/externals/images/update.svg',
        'route' => 'recent_activity',
       
      );
    
    
    return false;
  }
  
    public function onMenuInitialize_UserHomeFriends($row)
  {
    
      return array(
        'label' => $row->label,
        'icon' => 'application/modules/User/externals/images/browse.svg',
        'route' => 'user_general',
       
      );
   

    return false;
  }
  
   public function onMenuInitialize_UserHomeDocuments($row)
  {
    $viewer = Engine_Api::_()->user()->getViewer(); 
    return array(
        'label' => 'Documents',
       'icon' => 'application/modules/User/externals/images/icon9.png',
       'route' => 'user_documents',
        'params' => array(
        'module' => 'user',
          'controller' => 'index',
          'action' => 'document',
         
        )
      );
   
    return false;
  }
  public function onMenuInitialize_UserProfileDocuments($row)
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    $subject = Engine_Api::_()->core()->getSubject();


     if( $viewer->getIdentity() == $subject->getIdentity() ) {
      return array(
       'label' => 'Documents',
       'icon' => 'application/modules/User/externals/images/icon9.png',
       'route' => 'user_documents',
        'params' => array(
        'module' => 'user',
          'controller' => 'index',
          'action' => 'document',
         
        )
      );
    }

    return false;
  }
  
     public function onMenuInitialize_UserHomeGallery($row)
  {
    $viewer = Engine_Api::_()->user()->getViewer(); 
    return array(
        'label' => 'Gallery',
      'icon' => 'application/modules/User/externals/images/gallery.svg',
       'route' => 'album_general',
        'params' => array(
        'module' => 'album',
          'controller' => 'index',
          'action' => 'browse',
         
        )
      );
   
    return false;
  }
     public function onMenuInitialize_UserHomeRequestedProperties($row)
  { 
    $viewer = Engine_Api::_()->user()->getViewer(); 
   
    $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
	if( !empty($fieldsByAlias['profile_type']) ){
				{
				  $optionId = $fieldsByAlias['profile_type']->getValue($viewer);
				  $profile_type_id = $optionId->value; 
				} 
			}
		
	if( $profile_type_id == 1 ) {
		
    return array(
        'label' => 'My Rental Applications',
     'icon' => 'application/modules/User/externals/images/icon10.png',
       'route' => 'tenant_property_request',
        'params' => array(
        'module' => 'user',
          'controller' => 'index',
          'action' => 'tenantpropertyrequestlist',
         
        )
      );
   }
    return false;
  }
     public function onMenuInitialize_UserHomeRequestApprovedProperties($row)
  { 
    $viewer = Engine_Api::_()->user()->getViewer(); 
   
    $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
	if( !empty($fieldsByAlias['profile_type']) ){
				{
				  $optionId = $fieldsByAlias['profile_type']->getValue($viewer);
				  $profile_type_id = $optionId->value; 
				} 
			}
		
	if( $profile_type_id == 1 ) {
		
    return array(
        'label' => 'Accepted Applications',
        'icon' => 'application/modules/User/externals/images/folder.png',
      // 'route' => 'tenant_property_approved',
        'params' => array(
        'module' => 'user',
          'controller' => 'index',
          'action' => 'tenantpropertyapproved',
         
        )
      );
   }
    return false;
  }
  
     public function onMenuInitialize_CoreMainRentalapplication($row)
  {
    $viewer  = Engine_Api::_()->user()->getViewer();
    $request = Zend_Controller_Front::getInstance()->getRequest();
    
   
    $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
	if( !empty($fieldsByAlias['profile_type']) ){
				{
				  $optionId = $fieldsByAlias['profile_type']->getValue($viewer);
				  $profile_type_id = $optionId->value; 
				} 
			}
		
	if( $profile_type_id == 1 ) {

		$route   = array(
		  'route' => 'create_rentalapplication',
		);

		return $route;
   }
   return false;
   
  }
  public function onMenuInitialize_UserIndexPropertyrequirement($row)
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    if( $viewer->getIdentity() ) {
		
	$fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer); 
    	
    	if( !empty($fieldsByAlias['profile_type']) )
			{
			  $optionId = $fieldsByAlias['profile_type']->getValue($viewer);
			  $profile_type_id = $optionId->value; 
			}	

	if($profile_type_id == 1){ // tenant
      return array(
        'label' => $row->label,
         'icon' => 'application/modules/User/externals/images/add_property.svg',
        'route' => 'user_propertyrequirement',
        'params' => array(
          'module' => 'user',
          'controller' => 'index',
          'action' => 'propertyrequirement',
         
        )
      );
    }
    }
    return false;
  }
   public function onMenuInitialize_UserProfilePropertyrequirement($row)
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    $subject = Engine_Api::_()->core()->getSubject();


     if( $viewer->getIdentity() == $subject->getIdentity() ) {
		$fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($subject); 
		if( !empty($fieldsByAlias['profile_type']) )
			{
			  $optionId = $fieldsByAlias['profile_type']->getValue($subject);
			  $profile_type_id = $optionId->value; 
			} 
		 
	if($profile_type_id == 1){ // tenant
      return array(
        'label' => $row->label,
        'icon' => 'application/modules/User/externals/images/add_property.svg',
        'route' => 'user_propertyrequirement',
        'params' => array(
          'module' => 'user',
          'controller' => 'index',
          'action' => 'propertyrequirement',
         
        )
      );
    }
    }

    return false;
  }
       public function onMenuInitialize_CoreMainAddproperty($row)
  {
    $viewer  = Engine_Api::_()->user()->getViewer();
    $request = Zend_Controller_Front::getInstance()->getRequest();
    
   
    $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
	if( !empty($fieldsByAlias['profile_type']) ){
				{
				  $optionId = $fieldsByAlias['profile_type']->getValue($viewer);
				  $profile_type_id = $optionId->value; 
				} 
			}
		
	if( $profile_type_id == 4 ) {

		$route   = array(
		  'route' => 'user_addproperty',
		);

		return $route;
   }
   return false;
   
  }
   public function onMenuInitialize_CoreMiniEditprofile($row)
  { 
    $viewer = Engine_Api::_()->user()->getViewer();
    
  if( $viewer->getIdentity() ) {

      return array(
        'label' => $row->label,
        // 'icon' => 'application/modules/User/externals/images/edit_profile.svg',
          'route' => 'user_extended',
         'params' => array(
          'module' => 'user',
          'controller' => 'edit',
          'action' => 'profile',
         
        )
      );
    }
    
    return false;
  }
   public function onMenuInitialize_CoreMiniGallery($row)
  { 
    $viewer = Engine_Api::_()->user()->getViewer();
    
  if( $viewer->getIdentity() ) {

      return array(
        'label' => 'Gallery',
      'icon' => 'application/modules/User/externals/images/gallery.svg',
       'route' => 'album_general',
        'params' => array(
        'module' => 'album',
          'controller' => 'index',
          'action' => 'browse',
         
        )
      );
    }
    
    return false;
  }
   public function onMenuInitialize_CoreMainDocuments($row)
  {
    $viewer  = Engine_Api::_()->user()->getViewer();
    $request = Zend_Controller_Front::getInstance()->getRequest();
		
	if( $viewer) {
	return array(

       'route' => 'user_documents',
        'params' => array(
        'module' => 'user',
          'controller' => 'index',
          'action' => 'document',
         
        )
      );	
   }
   return false;
   
  }
  
   public function onMenuInitialize_CoreMainPosttoscout($row)
  {
    $viewer  = Engine_Api::_()->user()->getViewer();
    $request = Zend_Controller_Front::getInstance()->getRequest();
    $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
	if( !empty($fieldsByAlias['profile_type']) ){
				{
				  $optionId = $fieldsByAlias['profile_type']->getValue($viewer);
				  $profile_type_id = $optionId->value; 
				} 
			}
		
	

		
	if( $viewer) {
		
		if( $profile_type_id == 1 ) {

	return array(

        'route' => 'user_propertyrequirement',
        'params' => array(
          'module' => 'user',
          'controller' => 'index',
          'action' => 'propertyrequirement',
         
        )
      );

    }
   }
   return false;
   
  }
     public function onMenuInitialize_CoreMiniSupport($row)
  { 
    $viewer = Engine_Api::_()->user()->getViewer();
    
  if( $viewer->getIdentity() ) {

      return array(
       'label' => 'Support',
      'icon' => 'application/modules/User/externals/images/information.svg',
       'route' => 'support',
        'params' => array(
        'module' => 'user',
          'controller' => 'index',
          'action' => 'support',
         
        )
      );
    }
    
    return false;
  }
  public function onMenuInitialize_CoreMainscheduleviewing($row)
  {
    $viewer  = Engine_Api::_()->user()->getViewer();
    $request = Zend_Controller_Front::getInstance()->getRequest();
		
	if( $viewer) {
	return array(

       'route' => 'meetings_scheduled_by_you',
        'params' => array(
        'module' => 'user',
          'controller' => 'index',
          'action' => 'scheduledmeetings',
         
        )
      );	
   }
   return false;
   
  }
     
}
