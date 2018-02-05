
UPDATE `engine4_core_menuitems` SET
  `order` = '3'
  WHERE `name` = 'group_admin_main_level';

UPDATE `engine4_core_menuitems` SET
  `order` = '4'
  WHERE `name` = 'group_admin_main_categories';

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES
  ('group_admin_main_settings', 'group', 'Global Settings', '', '{"route":"admin_default","module":"group","controller":"settings"}', 'group_admin_main', '', 2);

INSERT IGNORE INTO `engine4_core_settings` VALUES 
  ('group.html', 1),
  ('group.bbcode', 1);

INSERT IGNORE INTO `engine4_authorization_permissions`
  SELECT
    level_id as `level_id`,
    'group' as `type`,
    'commentHtml' as `name`,
    3 as `value`,
    'blockquote, strong, b, em, i, u, strike, sub, sup, p, div, pre, address, h1, h2, h3, h4, h5, h6, span, ol, li, ul, a, img, embed, br, hr' as `params`
  FROM `engine4_authorization_levels` WHERE `type` NOT IN('public');