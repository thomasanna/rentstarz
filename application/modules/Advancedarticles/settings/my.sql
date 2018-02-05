INSERT IGNORE INTO `engine4_core_modules` (`name`, `title`, `description`, `version`, `enabled`, `type`) VALUES 
('advancedarticles', 'Advanced Articles', 'Advanced Articles', '4.1.3', 1, 'extra');

SET @iMaxOrder=(SELECT MAX(`order`) + 1 FROM `engine4_core_menuitems` WHERE `menu` LIKE "core_admin_main_plugins");

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES 
('core_admin_main_plugins_advancedarticles', 'advancedarticles', 'Advanced Articles', '', '{"route":"admin_default","module":"advancedarticles","controller":"settings", "action":"articles"}', 'core_admin_main_plugins', '', 1, 0, @iMaxOrder);

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES 
('advancedarticles_admin_main_settings', 'advancedarticles', 'List of Categories', '', '{"route":"admin_default","module":"advancedarticles","controller":"settings"}', 'advancedarticles_admin_main', '', 1, 0, 1);

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES 
('advancedarticles_admin_main_category', 'advancedarticles', 'View Articles', '', '{"route":"admin_default","module":"advancedarticles","controller":"settings","action":"articles"}', 'advancedarticles_admin_main', '', 1, 0, 2);

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES 
('advancedarticles_admin_main_global', 'advancedarticles', 'Global Settings', '', '{"route":"admin_default","module":"advancedarticles","controller":"settings","action":"settings"}', 'advancedarticles_admin_main', '', 1, 0, 3);

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES 
('advancedarticles_admin_main_level', 'advancedarticles', 'Member Level Settings', '', '{"route":"admin_default","module":"advancedarticles","controller":"settings","action":"level"}', 'advancedarticles_admin_main', '', 1, 0, 4);

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES 
('advancedarticles_admin_main_questions', 'advancedarticles', 'Article Questions', '', '{"route":"admin_default","module":"advancedarticles","controller":"fields"}', 'advancedarticles_admin_main', '', 1, 0, 5);

INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES 
('advancedarticles_admin_main_more', 'advancedarticles', 'More Plugins', '', '{"route":"admin_default","module":"advancedarticles","controller":"settings","action":"more"}', 'advancedarticles_admin_main', '', 1, 0, 10);

INSERT IGNORE INTO `engine4_activity_actiontypes` (`type`, `module`, `body`, `enabled`, `displayable`, `attachable`, `commentable`, `shareable`, `is_generated`) VALUES
('artarticle', 'advancedarticles', '{item:$subject} has added a new article:', 1, 5, 1, 3, 1, 1);
INSERT IGNORE INTO `engine4_activity_actiontypes` (`type`, `module`, `body`, `enabled`, `displayable`, `attachable`, `commentable`, `shareable`, `is_generated`) VALUES 
('comment_artarticle', 'advancedarticles', '{item:$subject} commented on {item:$owner}''s {item:$object:article}: {body:$body}', 1, 1, 1, 1, 1, 0);


CREATE TABLE IF NOT EXISTS `engine4_advancedarticles_albums` (
  `album_id` int(11) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL,
  `description` mediumtext NOT NULL,
  `owner_id` int(11) NOT NULL,
  `owner_type` varchar(24) NOT NULL,
  `created_date` datetime NOT NULL,
  `updated_date` datetime NOT NULL,
  `search` tinyint(1) NOT NULL default '1',
  `photo_id` int(11) unsigned NOT NULL default '0',
  `num_views` int(11) unsigned NOT NULL default '0',
  `num_comments` int(11) unsigned NOT NULL default '0',
  `artarticle_id` int(11) unsigned default NULL,
  PRIMARY KEY  (`album_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_unicode_ci ;

CREATE TABLE IF NOT EXISTS `engine4_advancedarticles_artarticles` (
  `artarticle_id` int(11) NOT NULL auto_increment,
  `search` binary(1) NOT NULL,
  `category_id` smallint(6) default NULL,
  `photo_id` int(11) default '0',
  `title` varchar(255) default NULL,
  `url` varchar(255) default NULL,
  `description` text,
  `body` mediumtext NOT NULL,
  `status` enum('deleted','draft','inactive','active') default 'active',
  `num_views` int(11) default '0',
  `created_date` datetime default NULL,
  `owner_id` int(11) default NULL,
  `owner_type` varchar(24) NOT NULL,
  `updated_date` datetime default NULL,
  `updated_user_id` int(11) default NULL,
  `activate_user_id` int(11) default NULL,
  `activate_date` datetime default NULL,
  `like_count` int(11) default '0',
  `featured` tinyint(1) default '0',
  `sponsored` tinyint(1) default '0',
  `comment_count` int(11) default '0',
  PRIMARY KEY  (`artarticle_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_unicode_ci ;

CREATE TABLE IF NOT EXISTS `engine4_advancedarticles_categories` (
  `category_id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL,
  `url` varchar(128) default NULL,
  `meta` text,
  `left_id` int(11) NOT NULL,
  `right_id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL default '0',
  `num_views` int(11) default NULL,
  `is_active` tinyint(4) default '1',
  `created_date` datetime default NULL,
  `modified_date` datetime default NULL,
  `user_id` int(11) default NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY  (`category_id`),
  KEY `idx_left_right` (`left_id`,`right_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_unicode_ci ;

-- 
-- Dumping data for table `engine4_advancedarticles_categories`
-- 

INSERT IGNORE INTO `engine4_advancedarticles_categories` (`name`, `url`, `left_id`, `right_id`, `parent_id`, `user_id`, `sort`) VALUES 
('Arts & Culture', 'arts-culture', 44, 47, 0, 1, 1);

INSERT IGNORE INTO `engine4_advancedarticles_categories` (`name`, `url`, `left_id`, `right_id`, `parent_id`, `user_id`, `sort`) VALUES 
('Business', 'business', 4, 19, 0, 1, 2);
SET @last_id = (SELECT LAST_INSERT_ID());
INSERT IGNORE INTO `engine4_advancedarticles_categories` (`name`, `url`, `left_id`, `right_id`, `parent_id`, `user_id`, `sort`) VALUES 
('Marketplace', 'marketplace', 17, 18, @last_id, 1, 3);
INSERT IGNORE INTO `engine4_advancedarticles_categories` (`name`, `url`, `left_id`, `right_id`, `parent_id`, `user_id`, `sort`) VALUES 
('Press Releases', 'press-releases', 15, 16, @last_id, 1, 4);
INSERT IGNORE INTO `engine4_advancedarticles_categories` (`name`, `url`, `left_id`, `right_id`, `parent_id`, `user_id`, `sort`) VALUES 
('Personal Finance', 'personal-finance', 13, 14, @last_id, 1, 5);
INSERT IGNORE INTO `engine4_advancedarticles_categories` (`name`, `url`, `left_id`, `right_id`, `parent_id`, `user_id`, `sort`) VALUES 
('Earnings', 'earnings', 11, 12, @last_id, 1, 6);
INSERT IGNORE INTO `engine4_advancedarticles_categories` (`name`, `url`, `left_id`, `right_id`, `parent_id`, `user_id`, `sort`) VALUES 
('Stocks', 'stocks', 9, 10, @last_id, 1, 7);

INSERT IGNORE INTO `engine4_advancedarticles_categories` (`name`, `url`, `left_id`, `right_id`, `parent_id`, `user_id`, `sort`) VALUES 
('Entertainment', 'entertainment', 53, 60, 0, 1, 8);
SET @last_id = (SELECT LAST_INSERT_ID());
INSERT IGNORE INTO `engine4_advancedarticles_categories` (`name`, `url`, `left_id`, `right_id`, `parent_id`, `user_id`, `sort`) VALUES 
('Arts', 'arts', 58, 59, @last_id, 1, 9);
INSERT IGNORE INTO `engine4_advancedarticles_categories` (`name`, `url`, `left_id`, `right_id`, `parent_id`, `user_id`, `sort`) VALUES 
('Fashion', 'fashion', 56, 57, @last_id, 1, 10);
INSERT IGNORE INTO `engine4_advancedarticles_categories` (`name`, `url`, `left_id`, `right_id`, `parent_id`, `user_id`, `sort`) VALUES 
('Movies', 'movies', 54, 55, @last_id, 1, 11);

INSERT IGNORE INTO `engine4_advancedarticles_categories` (`name`, `url`, `left_id`, `right_id`, `parent_id`, `user_id`, `sort`) VALUES 
('Health', 'health', 51, 52, 0, 1, 12);
INSERT IGNORE INTO `engine4_advancedarticles_categories` (`name`, `url`, `left_id`, `right_id`, `parent_id`, `user_id`, `sort`) VALUES 
('Family & Home', 'family-home', 22, 27, 0, 1, 13);
INSERT IGNORE INTO `engine4_advancedarticles_categories` (`name`, `url`, `left_id`, `right_id`, `parent_id`, `user_id`, `sort`) VALUES 
('Recreation', 'recreation', 30, 31, 0, 1, 14);
INSERT IGNORE INTO `engine4_advancedarticles_categories` (`name`, `url`, `left_id`, `right_id`, `parent_id`, `user_id`, `sort`) VALUES 
('Personal', 'personal', 32, 33, 0, 1, 15);
INSERT IGNORE INTO `engine4_advancedarticles_categories` (`name`, `url`, `left_id`, `right_id`, `parent_id`, `user_id`, `sort`) VALUES 
('Shopping', 'shopping', 34, 35, 0, 1, 16);
INSERT IGNORE INTO `engine4_advancedarticles_categories` (`name`, `url`, `left_id`, `right_id`, `parent_id`, `user_id`, `sort`) VALUES 
('Society', 'society', 36, 37, 0, 1, 17);
INSERT IGNORE INTO `engine4_advancedarticles_categories` (`name`, `url`, `left_id`, `right_id`, `parent_id`, `user_id`, `sort`) VALUES 
('Sports', 'sports', 38, 39, 0, 1, 18);
INSERT IGNORE INTO `engine4_advancedarticles_categories` (`name`, `url`, `left_id`, `right_id`, `parent_id`, `user_id`, `sort`) VALUES 
('Technology', 'technology', 40, 41, 0, 1, 19);
INSERT IGNORE INTO `engine4_advancedarticles_categories` (`name`, `url`, `left_id`, `right_id`, `parent_id`, `user_id`, `sort`) VALUES 
('Other', 'other', 42, 43, 0, 1, 20);

CREATE TABLE IF NOT EXISTS `engine4_advancedarticles_photos` (
  `photo_id` int(11) unsigned NOT NULL auto_increment,
  `album_id` int(11) unsigned NOT NULL,
  `owner_id` int(11) unsigned NOT NULL,
  `owner_type` varchar(24) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `collection_id` int(11) unsigned NOT NULL,
  `artarticle_id` int(11) default NULL,
  `file_id` int(11) unsigned NOT NULL,
  `created_date` datetime NOT NULL,
  `updated_date` datetime NOT NULL,
  `num_views` int(11) unsigned NOT NULL default '0',
  `comment_count` int(11) unsigned default '0',
  `like_count` int(11) NOT NULL,
  PRIMARY KEY  (`photo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_unicode_ci ;

CREATE TABLE IF NOT EXISTS `engine4_artarticle_fields_maps` (
  `field_id` int(11) unsigned NOT NULL,
  `option_id` int(11) unsigned NOT NULL,
  `child_id` int(11) unsigned NOT NULL,
  `order` smallint(6) NOT NULL,
  PRIMARY KEY  (`field_id`,`option_id`,`child_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_unicode_ci ;

CREATE TABLE IF NOT EXISTS `engine4_artarticle_fields_meta` (
  `field_id` int(11) unsigned NOT NULL auto_increment,
  `type` varchar(24) character set latin1 collate latin1_general_ci NOT NULL,
  `label` varchar(64) collate utf8_unicode_ci NOT NULL,
  `description` varchar(255) collate utf8_unicode_ci NOT NULL default '',
  `alias` varchar(32) character set latin1 collate latin1_general_ci NOT NULL default '',
  `required` tinyint(1) NOT NULL default '0',
  `display` tinyint(1) unsigned NOT NULL,
  `publish` tinyint(1) unsigned NOT NULL default '0',
  `search` tinyint(1) unsigned NOT NULL default '0',
  `show` tinyint(1) unsigned NOT NULL default '1',
  `order` smallint(3) unsigned NOT NULL default '999',
  `config` text collate utf8_unicode_ci,
  `validators` text collate utf8_unicode_ci,
  `filters` text collate utf8_unicode_ci,
  `style` text collate utf8_unicode_ci,
  `error` text collate utf8_unicode_ci,
  PRIMARY KEY  (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_unicode_ci ;

CREATE TABLE IF NOT EXISTS `engine4_artarticle_fields_options` (
  `option_id` int(11) unsigned NOT NULL auto_increment,
  `field_id` int(11) unsigned NOT NULL,
  `label` varchar(255) collate utf8_unicode_ci NOT NULL,
  `order` smallint(6) NOT NULL default '999',
  PRIMARY KEY  (`option_id`),
  KEY `field_id` (`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_unicode_ci ;

CREATE TABLE IF NOT EXISTS `engine4_artarticle_fields_search` (
  `item_id` int(11) unsigned NOT NULL,
  PRIMARY KEY  (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_unicode_ci ;

CREATE TABLE IF NOT EXISTS `engine4_artarticle_fields_values` (
  `item_id` int(11) unsigned NOT NULL,
  `field_id` int(11) unsigned NOT NULL,
  `index` smallint(3) unsigned NOT NULL default '0',
  `value` text collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`item_id`,`field_id`,`index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE utf8_unicode_ci ;


INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES 
('advancedarticles_page_home', 'advancedarticles', 'Articles Home', '', '{"route":"advancedarticles_general","action":"browse"}', 'advancedarticles_home', '', 1, 0, 1);
INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES 
('advancedarticles_page_category', 'advancedarticles', 'Browse Articles', '', '{"route":"advancedarticles_general","action":"category"}', 'advancedarticles_home', '', 1, 0, 2);
INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES 
('advancedarticles_page_my', 'advancedarticles', 'My Articles', 'Advancedarticles_Plugin_Menus', '', 'advancedarticles_home', '', 1, 0, 3);
INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES 
('advancedarticles_page_add', 'advancedarticles', 'Add New Article', 'Advancedarticles_Plugin_Menus', '', 'advancedarticles_home', '', 1, 0, 4);
INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES 
('advancedarticles_article', 'advancedarticles', 'Articles', '', '{"route":"advancedarticles_general","controller":"articles"}', 'core_main', '', 1, 0, 4);

-- Advanced Article Home Page

INSERT IGNORE INTO `engine4_core_pages` (`name`, `displayname`, `url`, `title`, `description`, `keywords`, `custom`, `fragment`, `layout`, `levels`, `provides`, `view_count` ) VALUES 
('advancedarticles_articles_browse', 'Advanced Article Home Page', NULL, 'Article Home Page', '', '', 0, 0, 'default', '', 'viewer;no-subject', 0);
SET @idpage=(SELECT `page_id` FROM `engine4_core_pages` WHERE `name` = 'advancedarticles_articles_browse');

DELETE FROM `engine4_core_content` WHERE `page_id`=@idpage;

-- Top Block

INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'container', 'top', NULL, 1, NULL, NULL);
SET @last_id_cont = (SELECT LAST_INSERT_ID());
INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'container', 'middle', @last_id_cont, 6, NULL, NULL);

SET @last_id = (SELECT LAST_INSERT_ID());

INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'widget', 'advancedarticles.actions-block', @last_id, 3, NULL, NULL);

-- Main Block

INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'container', 'main', NULL, 2, NULL, NULL);
SET @last_id_cont = (SELECT LAST_INSERT_ID());

-- Left Block

INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'container', 'left', @last_id_cont, 4, NULL, NULL);

SET @last_id = (SELECT LAST_INSERT_ID());

INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'widget', 'advancedarticles.categories-block', @last_id, 6, NULL, NULL);
INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'widget', 'advancedarticles.comment-block', @last_id, 7, '{"title":"Most Commented","name":"advancedarticles.comment-block","perpage":"5"}', NULL);
INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'widget', 'advancedarticles.view-block', @last_id, 8, '{"title":"Most Viewed","name":"advancedarticles.view-block","perpage":"5"}', NULL);
INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'widget', 'advancedarticles.like-block', @last_id, 9, '{"title":"Most Liked","name":"advancedarticles.like-block","perpage":"5"}', NULL);

-- Middle Block

INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'container', 'middle', @last_id_cont, 6, NULL, NULL);

SET @last_id = (SELECT LAST_INSERT_ID());

INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'widget', 'advancedarticles.featured-block', @last_id, 11, '{"title":"Featured Articles","name":"advancedarticles.featured-block","perpage":"4","category_id":"0","interval":"5","sort":"title","nomobile":"0"}', NULL);
INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'widget', 'core.container-tabs', @last_id, 12, '{"max":6}', NULL);

SET @last_id = (SELECT LAST_INSERT_ID());

INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'widget', 'advancedarticles.recent-block', @last_id, 13, '{"title":"Recent Article","name":"advancedarticles.recent-block","perpage":"10"}', NULL);
INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'widget', 'advancedarticles.random-block', @last_id, 14, '{"title":"Random","name":"advancedarticles.random-block","perpage":"5"}', NULL);
INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'widget', 'advancedarticles.tags-block', @last_id, 15, '{"title":"Popular Tags","name":"advancedarticles.tags-block","perpage":"100","link":"1","sort":"text","nomobile":"0"}', NULL);

-- Right Block

INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'container', 'right', @last_id_cont, 5, NULL, NULL);

SET @last_id = (SELECT LAST_INSERT_ID());

INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'widget', 'advancedarticles.filter-block', @last_id, 17, NULL, NULL);
INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'widget', 'advancedarticles.sponsored-block', @last_id, 18, '{"title":"Sponsored Articles","name":"advancedarticles.sponsored-block","perpage":"3","interval":"2","sort":"created_date","nomobile":"0"}', NULL);
INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'widget', 'advancedarticles.arhive-block', @last_id, 19, NULL, NULL);


-- Advanced Article Category Page

INSERT IGNORE INTO `engine4_core_pages` (`name`, `displayname`, `url`, `title`, `description`, `keywords`, `custom`, `fragment`, `layout`, `levels`, `provides`, `view_count` ) VALUES 
('advancedarticles_articles_category', 'Advanced Article Category Page', NULL, 'Article Browse Page', '', '', 0, 0, 'default', '', 'viewer;no-subject', 0);
SET @idpage=(SELECT `page_id` FROM `engine4_core_pages` WHERE `name` = 'advancedarticles_articles_category');

DELETE FROM `engine4_core_content` WHERE `page_id`=@idpage;

-- Top Block

INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'container', 'top', NULL, 1, NULL, NULL);
SET @last_id_cont = (SELECT LAST_INSERT_ID());
INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'container', 'middle', @last_id_cont, 6, NULL, NULL);

SET @last_id = (SELECT LAST_INSERT_ID());

INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'widget', 'advancedarticles.actions-block', @last_id, 3, NULL, NULL);
INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'widget', 'advancedarticles.bredcrumbs-block', @last_id, 4, NULL, NULL);

-- Main Block

INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'container', 'main', NULL, 2, NULL, NULL);
SET @last_id_cont = (SELECT LAST_INSERT_ID());

-- Middle Block

INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'container', 'middle', @last_id_cont, 6, NULL, NULL);

SET @last_id = (SELECT LAST_INSERT_ID());

INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'widget', 'advancedarticles.listarticle-block', @last_id, 7, NULL, NULL);

-- Right Block

INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'container', 'right', @last_id_cont, 5, NULL, NULL);

SET @last_id = (SELECT LAST_INSERT_ID());

INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'widget', 'advancedarticles.categories-block', @last_id, 9, NULL, NULL);
INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'widget', 'advancedarticles.filter-block', @last_id, 10, NULL, NULL);


-- Advanced Article Page

INSERT IGNORE INTO `engine4_core_pages` (`name`, `displayname`, `url`, `title`, `description`, `keywords`, `custom`, `fragment`, `layout`, `levels`, `provides`, `view_count` ) VALUES 
('advancedarticles_articles_article', 'Advanced Article Page', NULL, 'Article Profile', '', '', 0, 0, 'default', '', 'viewer;no-subject', 0);
SET @idpage=(SELECT `page_id` FROM `engine4_core_pages` WHERE `name` = 'advancedarticles_articles_article');

DELETE FROM `engine4_core_content` WHERE `page_id`=@idpage;

-- Top Block

INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'container', 'top', NULL, 1, NULL, NULL);
SET @last_id_cont = (SELECT LAST_INSERT_ID());
INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'container', 'middle', @last_id_cont, 6, NULL, NULL);

SET @last_id = (SELECT LAST_INSERT_ID());

INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'widget', 'advancedarticles.actions-block', @last_id, 3, NULL, NULL);
INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'widget', 'advancedarticles.bredcrumbs-block', @last_id, 4, NULL, NULL);

-- Main Block

INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'container', 'main', NULL, 2, NULL, NULL);
SET @last_id_cont = (SELECT LAST_INSERT_ID());

-- Middle Block

INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'container', 'middle', @last_id_cont, 6, NULL, NULL);

SET @last_id = (SELECT LAST_INSERT_ID());

INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'widget', 'advancedarticles.article-block', @last_id, 7, NULL, NULL);

-- Right Block

INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'container', 'right', @last_id_cont, 5, NULL, NULL);

SET @last_id = (SELECT LAST_INSERT_ID());

INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'widget', 'advancedarticles.user-info', @last_id, 9, '{"title":"Owner"}', NULL);
INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'widget', 'advancedarticles.arhive-block', @last_id, 10, '{"title":"Archives"}', NULL);


-- Advanced Article Tags Page

INSERT IGNORE INTO `engine4_core_pages` (`name`, `displayname`, `url`, `title`, `description`, `keywords`, `custom`, `fragment`, `layout`, `levels`, `provides`, `view_count` ) VALUES 
('advancedarticles_articles_tagscloud', 'Advanced Article Tags Page', NULL, 'Article Popular Tags Page', '', '', 0, 0, 'default', '', 'viewer;no-subject', 0);
SET @idpage=(SELECT `page_id` FROM `engine4_core_pages` WHERE `name` = 'advancedarticles_articles_tagscloud');

DELETE FROM `engine4_core_content` WHERE `page_id`=@idpage;

-- Top Block

INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'container', 'top', NULL, 1, NULL, NULL);
SET @last_id_cont = (SELECT LAST_INSERT_ID());
INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'container', 'middle', @last_id_cont, 6, NULL, NULL);

SET @last_id = (SELECT LAST_INSERT_ID());

INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'widget', 'advancedarticles.actions-block', @last_id, 3, NULL, NULL);

-- Main Block

INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'container', 'main', NULL, 2, NULL, NULL);
SET @last_id_cont = (SELECT LAST_INSERT_ID());

-- Middle Block

INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'container', 'middle', @last_id_cont, 6, NULL, NULL);

SET @last_id = (SELECT LAST_INSERT_ID());

INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'widget', 'advancedarticles.tags-block', @last_id, 7, '{"title":"Popular Tags","name":"advancedarticles.tags-block","perpage":"20","link":"0","sort":"text","nomobile":"0"}', NULL);

-- Right Block

INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'container', 'right', @last_id_cont, 5, NULL, NULL);

SET @last_id = (SELECT LAST_INSERT_ID());

INSERT IGNORE INTO `engine4_core_content` (`page_id`, `type`, `name`, `parent_content_id`, `order`, `params`, `attribs`) VALUES 
(@idpage, 'widget', 'advancedarticles.filter-block', @last_id, 8, NULL, NULL);


-- Settings
INSERT IGNORE INTO `engine4_core_settings` (`name`, `value`) VALUES ('art.per.page', '10');
INSERT IGNORE INTO `engine4_core_settings` (`name`, `value`) VALUES ('art.photo', '12');
INSERT IGNORE INTO `engine4_core_settings` (`name`, `value`) VALUES ('art.public', '1');
INSERT IGNORE INTO `engine4_core_settings` (`name`, `value`) VALUES ('art.sort', '5');

--
-- Dumping data for table `engine4_authorization_permissions`
--
INSERT IGNORE INTO `engine4_authorization_permissions` (`level_id`, `type`, `name`, `value`, `params`) VALUES
(1, 'artarticle', 'view', 1, NULL),
(1, 'artarticle', 'comment', 1, NULL),
(1, 'artarticle', 'create', 1, NULL),
(1, 'artarticle', 'edit', 1, NULL),
(1, 'artarticle', 'art_delete', 1, NULL),
(1, 'artarticle', 'art_photo', 1, NULL),
(1, 'artarticle', 'art_photo_edit', 1, NULL),
(1, 'artarticle', 'art_photo_delete', 1, NULL),
(1, 'artarticle', 'art_feature', 0, NULL),
(1, 'artarticle', 'art_sponsor', 0, NULL),
(1, 'artarticle', 'art_max', 3, '15'),
(1, 'artarticle', 'auth_view', 5, '["everyone","owner_network","owner_member_member","owner_member","owner"]'),
(1, 'artarticle', 'auth_comment', 5, '["everyone","owner_network","owner_member_member","owner_member","owner"]'),

(2, 'artarticle', 'view', 1, NULL),
(2, 'artarticle', 'comment', 1, NULL),
(2, 'artarticle', 'create', 1, NULL),
(2, 'artarticle', 'edit', 1, NULL),
(2, 'artarticle', 'art_delete', 1, NULL),
(2, 'artarticle', 'art_photo', 1, NULL),
(2, 'artarticle', 'art_photo_edit', 1, NULL),
(2, 'artarticle', 'art_photo_delete', 1, NULL),
(2, 'artarticle', 'art_feature', 0, NULL),
(2, 'artarticle', 'art_sponsor', 0, NULL),
(2, 'artarticle', 'art_max', 3, '15'),
(2, 'artarticle', 'auth_view', 5, '["everyone","owner_network","owner_member_member","owner_member","owner"]'),
(2, 'artarticle', 'auth_comment', 5, '["everyone","owner_network","owner_member_member","owner_member","owner"]'),

(3, 'artarticle', 'view', 1, NULL),
(3, 'artarticle', 'comment', 1, NULL),
(3, 'artarticle', 'create', 1, NULL),
(3, 'artarticle', 'edit', 1, NULL),
(3, 'artarticle', 'art_delete', 1, NULL),
(3, 'artarticle', 'art_photo', 1, NULL),
(3, 'artarticle', 'art_photo_edit', 1, NULL),
(3, 'artarticle', 'art_photo_delete', 1, NULL),
(3, 'artarticle', 'art_feature', 0, NULL),
(3, 'artarticle', 'art_sponsor', 0, NULL),
(3, 'artarticle', 'art_max', 3, '15'),
(3, 'artarticle', 'auth_view', 5, '["everyone","owner_network","owner_member_member","owner_member","owner"]'),
(3, 'artarticle', 'auth_comment', 5, '["everyone","owner_network","owner_member_member","owner_member","owner"]'),

(4, 'artarticle', 'view', 1, NULL),
(4, 'artarticle', 'comment', 1, NULL),
(4, 'artarticle', 'create', 1, NULL),
(4, 'artarticle', 'edit', 1, NULL),
(4, 'artarticle', 'art_delete', 1, NULL),
(4, 'artarticle', 'art_photo', 1, NULL),
(4, 'artarticle', 'art_photo_edit', 1, NULL),
(4, 'artarticle', 'art_photo_delete', 1, NULL),
(4, 'artarticle', 'art_feature', 0, NULL),
(4, 'artarticle', 'art_sponsor', 0, NULL),
(4, 'artarticle', 'art_max', 3, '15'),
(4, 'artarticle', 'auth_view', 5, '["everyone","owner_network","owner_member_member","owner_member","owner"]'),
(4, 'artarticle', 'auth_comment', 5, '["everyone","owner_network","owner_member_member","owner_member","owner"]'),

(5, 'artarticle', 'view', 1, NULL);
