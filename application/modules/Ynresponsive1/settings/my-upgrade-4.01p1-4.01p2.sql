UPDATE `engine4_core_modules` SET `version` = '4.01p2' where 'name' = 'ynresponsive1';

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES
('core_admin_main_plugins_ynresponsive1', 'ynresponsive1', 'YN - Responsive', '', '{"route":"admin_default","module":"ynresponsive1","controller":"settings"}', 'core_admin_main_plugins', '', 999);
