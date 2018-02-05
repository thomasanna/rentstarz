INSERT IGNORE INTO `engine4_core_modules` (`name`, `title`, `description`, `version`, `enabled`, `type`) VALUES  ('yntheme', 'YouNet Themes', 'Manage YouNet Themes', '4.01', 1, 'extra') ;

INSERT IGNORE INTO `engine4_core_settings` (`name`, `value`) VALUES ('yntheme.enabled', '0');
INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES ('yntheme_admin_main_settings', 'yntheme', 'Global Settings', NULL, '{"route":"admin_default","module":"yntheme","controller":"settings"}', 'yntheme_admin_main', NULL, 1, 0, 999);
INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES ('yntheme_admin_main_themes', 'yntheme', 'Themes', NULL, '{"route":"admin_default","module":"yntheme","controller":"themes"}', 'yntheme_admin_main', NULL, 1, 0, 999);
INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES ('core_admin_main_plugins_yntheme', 'yntheme', 'YouNet Themes', NULL, '{"route":"admin_default","module":"yntheme","controller":"themes"}', 'core_admin_main_plugins', NULL, 0, 0, 999);

