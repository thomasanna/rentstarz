/**
* SocialEngine
*
* @category   Application_Extensions
* @package    Birthday
* @copyright  Copyright 2009-2010 BigStep Technologies Pvt. Ltd.
* @license    http://www.socialengineaddons.com/license/
* @version    $Id: my.sql 6590 2010-17-11 9:40:21Z SocialEngineAddOns $
* @author     SocialEngineAddOns
*/


-- --------------------------------------------------------

--
-- Dumping data for table `engine4_core_modules`
--

INSERT IGNORE INTO `engine4_core_modules` (`name`, `title`, `description`, `version`, `enabled`, `type`) VALUES  ('cometchat', 'CometChat', 'Enable audio/video/text chat on your site in minutes and increase user activity exponentially!', '1.0.0', 1, 'extra') ;

-- --------------------------------------------------------

INSERT IGNORE INTO `engine4_core_menuitems`  (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES ('core_admin_main_cometchat', 'core', 'CometChat', '', '{"uri":"javascript:void(0);this.blur();"}', 'core_admin_main', 'core_admin_main_cometchat', '1', '0',99);
INSERT IGNORE INTO `engine4_core_menuitems`  (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES ('core_admin_main_cometchat_adminpanel', 'core', 'CometChat Admin Panel', '', '{"route":"admin_default","module":"cometchat",  "controller":"manage", "action":"index"}', 'core_admin_main_cometchat', '', '1', '0', 1);

INSERT IGNORE INTO `engine4_core_menuitems`  (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES ('core_admin_main_cometchat_advance', 'core', 'Advance Setting', '', '{"route":"admin_default","module":"cometchat" , "controller":"manage", "action":"advance"}', 'core_admin_main_cometchat', '', '1', '0', 2);

INSERT IGNORE INTO `engine4_core_menuitems`  (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES ('core_admin_main_cometchat_upgrade', 'core', 'Upgrade CometChat', '', '{"route":"admin_default", "module":"cometchat", "controller":"manage", "action":"upgrade"}', 'core_admin_main_cometchat', '', '1', '0', 3);
INSERT INTO `engine4_authorization_permissions` (`level_id`, `type`, `name`,`value`, `params`) VALUES(100,'cometchat','cometchat',1,'');

INSERT INTO `engine4_authorization_permissions` (`level_id`, `type`, `name`,`value`, `params`) (SELECT `level_id`,'CometChat','view',1,'' FROM `engine4_authorization_levels`);