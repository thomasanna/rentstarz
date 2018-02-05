INSERT IGNORE INTO `engine4_core_modules` (`name`, `title`, `description`, `version`, `enabled`, `type`) VALUES  ('ynresponsivepurity', 'YN - Responsive Purity Template', 'Responsive Purity Template', '4.01', 1, 'extra') ;
INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES
('core_admin_main_plugins_ynresponsivepurity', 'ynresponsivepurity', 'YN - Responsive Purity', '', '{"route":"admin_default","module":"ynresponsivepurity","controller":"manage-slider"}', 'core_admin_main_plugins', '', 999);

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES
('ynresponsivepurity_admin_main_manage_slider', 'ynresponsivepurity', 'Manage Slider', '', '{"route":"admin_default","module":"ynresponsivepurity","controller":"manage-slider"}', 'ynresponsivepurity_admin_main', '', 1, 0, 1),
('ynresponsivepurity_admin_main_manage_welcome', 'ynresponsivepurity', 'Manage Welcome Blocks', '', '{"route":"admin_default","module":"ynresponsivepurity","controller":"manage-welcome"}', 'ynresponsivepurity_admin_main', '', 1, 0, 2),
('ynresponsivepurity_admin_main_manage_module', 'ynresponsivepurity', 'Manage Modules', '', '{"route":"admin_default","module":"ynresponsivepurity","controller":"manage-module"}', 'ynresponsivepurity_admin_main', '', 1, 0, 3);

CREATE TABLE IF NOT EXISTS `engine4_ynresponsivepurity_sliders` (
  `slider_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(256) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(512) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `link` varchar(256) DEFAULT NULL,
  `photo_id` int(11) NOT NULL DEFAULT '0',
  `order` smallint(6) NOT NULL DEFAULT '999',
  PRIMARY KEY (`slider_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `engine4_ynresponsivepurity_welcomes` (
  `welcome_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(256) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(220) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `text_link` varchar(256) DEFAULT NULL,
  `link` varchar(256) DEFAULT NULL,
  `photo_id` int(11) NOT NULL DEFAULT '0',
  `order` smallint(6) NOT NULL DEFAULT '999',
  PRIMARY KEY (`welcome_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `engine4_ynresponsivepurity_modules` (
  `module_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(256) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(512) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `link` varchar(256) DEFAULT NULL,
  `icon_id` int(11) NOT NULL DEFAULT '0',
  `hover_icon_id` int(11) NOT NULL DEFAULT '0',
  `order` smallint(6) NOT NULL DEFAULT '999',
  PRIMARY KEY (`module_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;