UPDATE `engine4_core_modules` SET `version` = '4.04p1' where 'name' = 'ynresponsive1';

DELETE FROM `engine4_core_menuitems` WHERE `name` = 'ynresponsive1_admin_main_manage_events';
DELETE FROM `engine4_core_menuitems` WHERE `name` = 'ynresponsive1_admin_main_manage_sponsors';
DELETE FROM `engine4_core_menuitems` WHERE `name` = 'ynresponsive1_admin_main_manage_menus';
DELETE FROM `engine4_core_menuitems` WHERE `name` = 'ynresponsive1_admin_main_manage_blocks';
DELETE FROM `engine4_core_menuitems` WHERE `name` = 'ynresponsive1_admin_main_manage_introduction';
DELETE FROM `engine4_core_menuitems` WHERE `name` = 'ynresponsive1_admin_main_manage_featured_photos';
DELETE FROM `engine4_core_menuitems` WHERE `name` = 'ynresponsive1_admin_main_manage_photo_slider';
DELETE FROM `engine4_core_menuitems` WHERE `name` = 'ynresponsive1_admin_main_manage_photo_blocks';
