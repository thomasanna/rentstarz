<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: content.php 9868 2013-02-12 21:50:45Z shaun $
 * @author     John
 */
return array(
  array(
    'title' => 'Quick Links',
    'description' => 'Displays a list of quick links.',
    'category' => 'User',
    'type' => 'widget',
    'name' => 'user.home-links',
    'requirements' => array(
      'viewer',
    ),
  ),
  array(
    'title' => 'User Photo',
    'description' => 'Displays the logged-in member\'s photo.',
    'category' => 'User',
    'type' => 'widget',
    'name' => 'user.home-photo',
    'requirements' => array(
      'viewer',
    ),
  ),
  array(
    'title' => 'Online Users',
    'description' => 'Displays a list of online members.',
    'category' => 'User',
    'type' => 'widget',
    'name' => 'user.list-online',
    'isPaginated' => true,
    'defaultParams' => array(
      'title' => '%d Members Online',
    ),
    'requirements' => array(
      'no-subject',
    ),
  ),
  array(
    'title' => 'Popular Members',
    'description' => 'Displays the list of most popular members.',
    'category' => 'User',
    'type' => 'widget',
    'name' => 'user.list-popular',
    'isPaginated' => true,
    'defaultParams' => array(
      'title' => 'Popular Members',
    ),
    'requirements' => array(
      'no-subject',
    ),
  ),
  array(
    'title' => 'Recent Signups',
    'description' => 'Displays the list of most recent signups.',
    'category' => 'User',
    'type' => 'widget',
    'name' => 'user.list-signups',
    'isPaginated' => true,
    'defaultParams' => array(
      'title' => 'Recent Signups',
    ),
    'requirements' => array(
      'no-subject',
    ),
  ),
  array(
    'title' => 'Login or Signup',
    'description' => 'Displays a login form and a signup link for members that are not logged in.',
    'category' => 'User',
    'type' => 'widget',
    'name' => 'user.login-or-signup',
    'requirements' => array(
      'no-subject',
    ),
  ),
  array(
    'title' => 'Profile Fields',
    'description' => 'Displays a member\'s profile field data on their profile.',
    'category' => 'User',
    'type' => 'widget',
    'name' => 'user.profile-fields',
    'defaultParams' => array(
      'title' => 'Info',
    ),
    'requirements' => array(
      'subject' => 'user',
    ),
  ),
  array(
    'title' => 'Profile Friends',
    'description' => 'Displays a member\'s friends on their profile.',
    'category' => 'User',
    'type' => 'widget',
    'name' => 'user.profile-friends',
    'isPaginated' => true,
    'defaultParams' => array(
      'title' => 'Friends',
      'titleCount' => true,
    ),
    'requirements' => array(
      'subject' => 'user',
    ),
  ),
  array(
    'title' => 'Profile Followers',
    'description' => 'Displays a member\'s followers on their profile.',
    'category' => 'User',
    'type' => 'widget',
    'name' => 'user.profile-friends-followers',
    'isPaginated' => true,
    'defaultParams' => array(
      'title' => 'Followers',
      'titleCount' => true,
    ),
    'requirements' => array(
      'subject' => 'user',
    ),
  ),
  array(
    'title' => 'Profile Following',
    'description' => 'Displays the members a member is following on their profile.',
    'category' => 'User',
    'type' => 'widget',
    'name' => 'user.profile-friends-following',
    'isPaginated' => true,
    'defaultParams' => array(
      'title' => 'Following',
      'titleCount' => true,
    ),
    'requirements' => array(
      'subject' => 'user',
    ),
  ),
  array(
    'title' => 'Profile Mutual Friends',
    'description' => 'Displays the mutual friends between the viewer and the subject.',
    'category' => 'User',
    'type' => 'widget',
    'name' => 'user.profile-friends-common',
    'isPaginated' => true,
    'defaultParams' => array(
      'title' => 'Mutual Friends'
    ),
    'requirements' => array(
      'subject' => 'user',
    ),
  ),
  array(
    'title' => 'Profile Info',
    'description' => 'Displays a member\'s info (signup date, friend count, etc) on their profile.',
    'category' => 'User',
    'type' => 'widget',
    'name' => 'user.profile-info',
    'requirements' => array(
      'subject' => 'user',
    ),
  ),
  array(
    'title' => 'Profile Options',
    'description' => 'Displays a list of actions that can be performed on a member on their profile (report, add as friend, etc).',
    'category' => 'User',
    'type' => 'widget',
    'name' => 'user.profile-options',
    'requirements' => array(
      'subject' => 'user',
    ),
  ),
  array(
    'title' => 'Profile Photo',
    'description' => 'Displays a member\'s photo on their profile.',
    'category' => 'User',
    'type' => 'widget',
    'name' => 'user.profile-photo',
    'requirements' => array(
      'subject' => 'user',
    ),
  ),
  array(
    'title' => 'Profile Status',
    'description' => 'Displays a member\'s name and most recent status on their profile.',
    'category' => 'User',
    'type' => 'widget',
    'name' => 'user.profile-status',
    'requirements' => array(
      'subject' => 'user',
    ),
  ),
  array(
    'title' => 'Profile Tags',
    'description' => 'Displays photos, blogs, etc that a member has been tagged in.',
    'category' => 'User',
    'type' => 'widget',
    'name' => 'user.profile-tags',
    'isPaginated' => true,
    'defaultParams' => array(
      'title' => 'Tags',
      'titleCount' => true,
    ),
    'requirements' => array(
      'subject' => 'user',
    ),
  ),
  array(
    'title' => 'User Settings Menu',
    'description' => 'Displays a menu in the user settings pages.',
    'category' => 'User',
    'type' => 'widget',
    'name' => 'user.settings-menu',
    'requirements' => array(
      'no-subject',
    ),
  ),
  array(
    'title' => 'Member Browse Menu',
    'description' => 'Displays a menu in the member browse page.',
    'category' => 'User',
    'type' => 'widget',
    'name' => 'user.browse-menu',
    'requirements' => array(
      'no-subject',
    ),
  ),
  array(
    'title' => 'Member Browse Search',
    'description' => 'Displays a search form in the member browse page.',
    'category' => 'User',
    'type' => 'widget',
    'name' => 'user.browse-search',
    'requirements' => array(
      'no-subject',
    ),
  ),
  array(
    'title' => 'Profile Documents',
    'description' => 'Displays a member\'s documents on their profile.',
    'category' => 'User',
    'type' => 'widget',
    'name' => 'user.profile-documents',
    'defaultParams' => array(
      'title' => 'Documents',
    ),
    'requirements' => array(
      'subject' => 'user',
    ),
  ),
  array(
    'title' => 'Home Tip',
    'description' => 'Display tip in home feed.',
    'category' => 'User',
    'type' => 'widget',
    'name' => 'user.home-tip',
    'defaultParams' => array(
      'title' => 'Tips',
    ),
    'requirements' => array(
      'no-subject',
    ),
  ),
  array(
    'title' => 'Image Header',
    'description' => 'Display image in top of the page content.',
    'category' => 'User',
    'type' => 'widget',
    'name' => 'user.image-header',
    'defaultParams' => array(
      'title' => 'Image Header',
    ),
    'requirements' => array(
      'no-subject',
    ),
  ),
  array(
    'title' => 'Online Members',
    'description' => 'Displays a list of online members.',
    'category' => 'User',
    'type' => 'widget',
    'name' => 'user.online-members',
    'isPaginated' => true,
    'defaultParams' => array(
      'title' => '%d Members Online',
    ),
    'requirements' => array(
      'no-subject',
    ),
  ),
  array(
    'title' => 'Profile New',
    'description' => 'Member Profile.',
    'category' => 'User',
    'type' => 'widget',
    'name' => 'user.profile-new',
    'isPaginated' => true,
    'defaultParams' => array(
      'title' => 'Profile New',
    ),
    'requirements' => array(
      'no-subject',
    ),
  ),
  array(
    'title' => 'Gallery New',
    'description' => 'Gallery.',
    'category' => 'User',
    'type' => 'widget',
    'name' => 'user.gallery-new',
    'isPaginated' => true,
    'defaultParams' => array(
      'title' => 'Gallery New',
    ),
    'requirements' => array(
      'no-subject',
    ),
  ),
  array(
    'title' => 'Landing Page',
    'description' => 'Landing Page.',
    'category' => 'User',
    'type' => 'widget',
    'name' => 'user.landing-page',
    'isPaginated' => true,
    'defaultParams' => array(
      'title' => 'Landing Page',
    ),
    'requirements' => array(
      'no-subject',
    ),
  ),
    array(
    'title' => 'Advertisement',
    'description' => 'Advertisement',
    'category' => 'User',
    'type' => 'widget',
    'name' => 'user.advertisement',
    'isPaginated' => true,
    'defaultParams' => array(
      'title' => 'Advertisement',
    ),
    'requirements' => array(
      'no-subject',
    ),
  ),
    array(
    'title' => 'Landingpage Article',
    'description' => 'Landingpage Article',
    'category' => 'User',
    'type' => 'widget',
    'name' => 'user.landingpage-article',
    'isPaginated' => true,
    'defaultParams' => array(
      'title' => 'Landingpage Article',
    ),
    'requirements' => array(
      'no-subject',
    ),
  ),
    array(
    'title' => 'Featured Story',
    'description' => 'Featured Story',
    'category' => 'User',
    'type' => 'widget',
    'name' => 'user.landingpage-featuredstory',
    'isPaginated' => true,
    'defaultParams' => array(
      'title' => 'Featured Story',
    ),
    'requirements' => array(
      'no-subject',
    ),
  ),
   array(
    'title' => 'Profile Manage Subscription',
    'description' => 'Manage subscription.',
    'category' => 'User',
    'type' => 'widget',
    'name' => 'user.profile-manage-subscription',
    'isPaginated' => true,
    'defaultParams' => array(
      'title' => 'Profile Manage Subscription',
    ),
    'requirements' => array(
      'no-subject',
    ),
  ),
   array(
    'title' => 'Renter Task',
    'description' => 'Renter task management',
    'category' => 'User',
    'type' => 'widget',
    'name' => 'user.renter-task',
    'isPaginated' => true,
    'defaultParams' => array(
      'title' => 'Renter task management',
    ),
    'requirements' => array(
      'no-subject',
    ),
    ),
   array(
    'title' => 'Landlord Task',
    'description' => 'Landlord task management',
    'category' => 'User',
    'type' => 'widget',
    'name' => 'user.landlord-task',
    'isPaginated' => true,
    'defaultParams' => array(
      'title' => 'Landlord task management',
    ),
    'requirements' => array(
      'no-subject',
    ),
  ),
   array(
    'title' => 'Repairagent Task',
    'description' => 'Repairagent task management',
    'category' => 'User',
    'type' => 'widget',
    'name' => 'user.repairagent-task',
    'isPaginated' => true,
    'defaultParams' => array(
      'title' => 'Repairagent task management',
    ),
    'requirements' => array(
      'no-subject',
    ),
  ),
) ?>
