<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @author     John
 */
return array(
  // Package -------------------------------------------------------------------
  'package' => array(
    'type' => 'module',
    'name' => 'user',
    'version' => '4.8.10',
    'revision' => '$Revision: 10271 $',
    'path' => 'application/modules/User',
    'repository' => 'socialengine.com',
    'title' => 'Members',
    'description' => 'Members',
    'author' => 'Webligo Developments',
    'changeLog' => 'settings/changelog.php',
    'dependencies' => array(
      array(
        'type' => 'module',
        'name' => 'core',
        'minVersion' => '4.2.0',
      ),
    ),
    'actions' => array(
       'install',
       'upgrade',
       'refresh',
       //'enable',
       //'disable',
     ),
    'callback' => array(
      'path' => 'application/modules/User/settings/install.php',
      'class' => 'User_Installer',
      'priority' => 3000,
    ),
    'directories' => array(
      'application/modules/User',
    ),
    'files' => array(
      'application/languages/en/user.csv',
    ),
  ),
  // Compose -------------------------------------------------------------------
  'compose' => array(
    array('_composeFacebook.tpl', 'user'),
    array('_composeTwitter.tpl', 'user'),
  ),
  'composer' => array(
    'facebook' => array(
      'script' => array('_composeFacebook.tpl', 'user'),
    ),
    'twitter' => array(
      'script' => array('_composeTwitter.tpl', 'user'),
    ),
  ),
  // Hooks ---------------------------------------------------------------------
  'hooks' => array(
    array(
      'event' => 'onUserEnable',
      'resource' => 'User_Plugin_Core',
    ),
    array(
      'event' => 'onUserDeleteBefore',
      'resource' => 'User_Plugin_Core',
    ),
    array(
      'event' => 'onUserCreateAfter',
      'resource' => 'User_Plugin_Core',
    ),
    array(
      'event' => 'getAdminNotifications',
      'resource' => 'User_Plugin_Core',
    )
  ),
  // Items ---------------------------------------------------------------------
  'items' => array(
    'user',
    'user_list',
    'user_list_item',
  ),
  // Routes --------------------------------------------------------------------
  'routes' => array(
    // User - General
    'user_extended' => array(
      'route' => 'members/:controller/:action/*',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'index'
      ),
      'reqs' => array(
        'controller' => '\D+',
        'action' => '\D+',
      )
    ),
    'user_general' => array(
      'route' => 'members/:action/*',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'browse'
      ),
      'reqs' => array(
        'action' => '(home|browse)',
      )
    ),

    // User - Specific
    'user_profile' => array(
      'route' => 'profile/:id/*',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'profile',
        'action' => 'index'
      )
    ),

    'user_login' => array(
      //'type' => 'Zend_Controller_Router_Route_Static',
      'route' => '/login/*',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'auth',
        'action' => 'login'
      )
    ),
    'user_logout' => array(
      'type' => 'Zend_Controller_Router_Route_Static',
      'route' => '/logout',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'auth',
        'action' => 'logout'
      )
    ),
    'user_signup' => array(
      'route' => '/signup/:action/*',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'signup',
        'action' => 'index'
      )
    ),
    'user_tenants' => array(
      'route' => '/tenants',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'tenants'
      )
    ),
    'user_landlords' => array(
      'route' => '/landlords',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'landlords'
      )
    ),
    'user_services' => array(
      'route' => '/services',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'services'
      )
    ),
    'user_addproperty' => array(
      'route' => '/addproperty',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'addproperty'
      )
    ),
    'user_propertylist' => array(
      'route' => '/properties/:id',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'propertylist'
      )
    ),
    'user_propertydetail' => array(
      'route' => '/property/:id/*',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'propertydetail'
      )
    ),
    'user_propertyrequestslist' => array(
      'route' => '/propertyrequestslist',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'propertyrequestslist'
      )
    ),
     'user_myproperties' => array(
      'route' => '/myproperties',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'myproperties'
      )
    ),
     'search_properties' => array(
      'route' => '/properties',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'searchproperties'
    )
      ),
     'edit_property' => array(
      'route' => '/property/edit/:id',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'editproperty'
      )
    ),
     'user_documentssharedwithme' => array(
      'route' => '/documents/sharedwithme',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'documentsharedwithme'
      )
    ),
    'user_documents' => array(
      'route' => '/documents',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'document'
      )
    ),
     'user_documentsrequests' => array(
      'route' => '/documents/requests',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'documentrequests'
      )
    ),
     'file_open' => array(
      'route' => '/fileopen/:id',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'fileopen'
      )
    ),
     'approved_requests' => array(
      'route' => '/property/approved',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'propertyapprovedrequestslist'
      )
    ),
     'propertyapproved_users' => array(
      'route' => '/property/approved/:id',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'propertyapproveduserslist'
      )
    ),
    'user_rate' => array(
      'route' => '/rate',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'rate'
      )
    ),
    'user_rateindividual' => array(
      'route' => '/rate/:id/:pid',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'ratebyindividualuser'
      )
    ),
    'user_propertyrequirement' => array(
      'route' => '/property/requirement',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'propertyrequirement'
      )
    ),
    'user_getmachingproperties' => array(
      'route' => '/getmachingproperties',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'getmachingproperties'
      )
    ),
    'edit_requirement' => array(
      'route' => '/property/requirement/edit/:id',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'editrequirement'
      )
    ),
    'property_viewlog' => array(
      'route' => '/property/view/:id',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'propertyviewlog'
      )
    ),
    'tenant_property_request' => array(
      'route' => '/property/requests',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'tenantpropertyrequestlist'
      )
    ),
    'tenant_property_approved' => array(
      'route' => '/property/requests/approved',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'tenantpropertyapproved'
      )
    ),
    'property_map' => array(
      'route' => '/property/map/:id',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'propertymap'
      )
    ),
    'property_requirement_map' => array(
      'route' => '/property/requirement/map/:id',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'propertyrequirementmap'
      )
    ),
    'change_location' => array(
      'route' => '/location',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'changelocation'
      )
    ),
    'create_application' => array(
      'route' => '/rentalapplication/create/:id',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'createapplication'
      )
    ),
    'view_application' => array(
      'route' => '/rentalapplication/:id',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'viewapplication'
      )
    ),
    'edit_application' => array(
      'route' => '/rentalapplication/edit/:id',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'editapplication'
      )
    ),
     'create_rentalapplication' => array(
      'route' => '/rentalapplication/create',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'createrentalapplication'
      )
    ),

     'smartmoveapi_createrenter' => array(
      'route' => '/renter/create',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'smartmoveapicreaterenterform'
      )
    ),
     'smartmoveapi_updaterenter' => array(
      'route' => '/renter/update',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'smartmoveapiupdaterenterform'
      )
    ),
     'smartmoveapi_evaluateexam' => array(
      'route' => '/exam',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'smartmoveapicreatereport'
      )
    ),
   /*  'smartmoveapi_reportpayment' => array(
      'route' => '/smartmove/report/payment/:id',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'reportpayment'
      )
    ),*/
     'smartmoveapi_reportpayment' => array(
      'route' => '/payment',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'reportpayment'
      )
    ),
     'smartmoveapi_report' => array(
      'route' => '/report/:id',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'report'
      )
    ),
     'requirement_list' => array(
      'route' => '/requirement/:id',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'requirementlist'
      )
    ),
     'scheduler' => array(
      'route' => '/scheduler',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'scheduler'
      )
    ),
     'meetings_scheduled_by_you' => array(
      'route' => '/scheduler/meetings',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'scheduledmeetings'
      )
    ),
    'meeting_requests' => array(
      'route' => '/scheduler/meetings/requests',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'meetingrequests'
      )
    ),
    'meeting_joined' => array(
      'route' => '/scheduler/meetings/joined',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'joinedmeetings'
      )
    ),
    'support' => array(
      'route' => '/support',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'support'
      )
    ),

      'user_updates' => array(
      'route' => 'updates/:id/*',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'profile',
        'action' => 'updates'
      )
    ),
      'default_rentalapplication' => array(
      'route' => 'rentalapplication/view',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'defaultapplicationview'
      )
    ),
      'choose_package' => array(
      'route' => 'report/package',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'package'
      )
    ),

    'credit_background' => array(
      'route' => 'credit/background',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'creditbackground'
      )
    ),

    'ti_chat_app' => array(
      'route' => 'tichat/inbox',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'tichatapp'
    )
  ),
    'fcra_agreement' => array(
      'route' => 'fcra',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'fcraagreement'

      )
    ),
    'reportstatus_updates' => array(
      'route' => 'reportstatusupdates',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'reportstatusupdates'

      )
    ),
    'scheduledappoinmentremainder_threehrbefore' => array(
      'route' => 'scheduledappoinmentremainderthreehrbefore',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'scheduledappoinmentremainderthreehrbefore'

      )
    ),
    'scheduledappoinmentremainder_twodaybefore' => array(
      'route' => 'scheduledappoinmentremaindertwodaybefore',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'scheduledappoinmentremaindertwodaybefore'

      )
    ),
    'survey_notification' => array(
      'route' => 'surveynotification',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'surveynotification'

      )
    ),
    'smartmove_notification' => array(
      'route' => 'smartmove/notification',
      'defaults' => array(
        'module' => 'user',
        'controller' => 'index',
        'action' => 'smartmovenotification'

      )
    ),
    'tichat_singlechat' => array(
		'route' => 'tichat/singlechatmob',
		'defaults' => array(
		'module' => 'user',
		'controller' => 'index',
		'action' => 'singlechatmob'

		)
	 ),
    'member_packagepayment' => array(
		'route' => 'member/package/payment',
		'defaults' => array(
		'module' => 'user',
		'controller' => 'index',
		'action' => 'memberpackagepayment'

		)
	 ),
    'special_documents' => array(
		'route' => 'documents/special',
		'defaults' => array(
		'module' => 'user',
		'controller' => 'index',
		'action' => 'specialdocuments'

		)
	 ),
    'featured_story' => array(
		'route' => 'featuredstory',
		'defaults' => array(
		'module' => 'user',
		'controller' => 'index',
		'action' => 'featuredstory'

		)
	 ),
    'automaticpackage_renewal' => array(
		'route' => 'automaticpackagerenewal',
		'defaults' => array(
		'module' => 'user',
		'controller' => 'index',
		'action' => 'automaticpackagerenewal'

		)
	 ),
    'manage_subscription' => array(
		'route' => 'manage/subscription',
		'defaults' => array(
		'module' => 'user',
		'controller' => 'edit',
		'action' => 'managesubscription'

		)
	 ),
    'backgroundreport_expiry_notification' => array(
		'route' => 'backgroundreportexpirynotification',
		'defaults' => array(
		'module' => 'user',
		'controller' => 'index',
		'action' => 'backgroundreportexpirynotification'

		)
	 ),
    'shared_reports' => array(
		'route' => 'reports/shared',
		'defaults' => array(
		'module' => 'user',
		'controller' => 'index',
		'action' => 'sharedreports'

		)
	 ),
  )
); ?>
