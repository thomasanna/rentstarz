INSERT IGNORE INTO `engine4_core_modules` (`name`, `title`, `description`, `version`, `enabled`, `type`) VALUES  ('ynresponsive1', 'YouNet Responsive Simple Module', 'YouNet Responsive Simple Module', '4.04p1', 1, 'extra') ;

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES
('core_admin_main_plugins_ynresponsive1', 'ynresponsive1', 'YN - Responsive', '', '{"route":"admin_default","module":"ynresponsive1","controller":"settings"}', 'core_admin_main_plugins', '', 999);

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES
('ynresponsive1_admin_main_settings', 'ynresponsive1', 'Global Settings', '', '{"route":"admin_default","module":"ynresponsive1","controller":"settings"}', 'ynresponsive1_admin_main', '', 1, 0, 1);