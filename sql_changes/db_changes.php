<?php
$sql=array();
##$sql['1.1']     = " INSERT INTO `engine4_core_modules` (`name`, `title`, `description`, `version`, `enabled`, `type`) VALUES ('sqlupdates', 'Sqlupdates', 'for updating db', '4.0.0', '1', 'extra');";
##$sql['1.1.1']   = " CREATE TABLE IF NOT EXISTS `engine4_sqlupdates_updates` (`sql_id` int(11) NOT NULL,`sql_version` varchar(11) NOT NULL,`sql_date` datetime NOT NULL,PRIMARY KEY (`sql_id`)) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;";

$sql['1.1.2.1']     = "CREATE TABLE IF NOT EXISTS `engine4_country_list` (
                      `id` bigint(20) NOT NULL AUTO_INCREMENT,
                      `country` varchar(250) NOT NULL,
                       PRIMARY KEY (`id`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1";

$sql['1.1.2.2']   = "CREATE TABLE IF NOT EXISTS `engine4_state_list` (
                    `state_id` int(11) NOT NULL AUTO_INCREMENT,
                    `country_id` int(11) NOT NULL,
                    `state` varchar(100) NOT NULL,
                    PRIMARY KEY (`state_id`)
                    ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1" ;

$sql['1.1.2.3']   = "CREATE TABLE IF NOT EXISTS `engine4_city_list` (
                  `city_id` int(11) NOT NULL AUTO_INCREMENT,
                  `country_id` int(11) NOT NULL,
                  `state_id` int(11) NOT NULL,
                  `city` varchar(100) NOT NULL,
                  PRIMARY KEY (`city_id`)
                ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1" ;

$sql['1.1.2.4'] = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'core_admin_main_manage_country', 'user', 'Manage Country', '', '{\"route\":\"admin_default\",\"module\":\"user\",
                   \"controller\":\"manage\",\"action\":\"countrylist\"}', 'core_admin_main_manage', NULL, '1', '0', '999');";

$sql['1.1.2.5'] = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'core_admin_main_manage_state', 'user', 'Manage State', '', '{\"route\":\"admin_default\",\"module\":\"user\",
                   \"controller\":\"manage\",\"action\":\"statelist\"}', 'core_admin_main_manage', NULL, '1', '0', '999');";

$sql['1.1.2.6'] = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'core_admin_main_manage_city', 'user', 'Manage City', '', '{\"route\":\"admin_default\",\"module\":\"user\",
                   \"controller\":\"manage\",\"action\":\"citylist\"}', 'core_admin_main_manage', NULL, '1', '0', '999');";

$sql['1.1.3.1'] = "ALTER TABLE  `engine4_users` ADD  `services_type_id` INT( 11 ) NOT NULL AFTER  `level_id` ;";

$sql['1.1.2.7']   = "CREATE TABLE IF NOT EXISTS `engine4_property_list` (
                  `id` int(11) NOT NULL AUTO_INCREMENT,
                  `property_owner_id` int(11) NOT NULL,
                  `property_name` varchar(250) NOT NULL,
                  `country_id` int(11) NOT NULL,
                  `state_id` int(11) NOT NULL,
                  `city_id` int(11) NOT NULL,
                  `rental_type` varchar(50) NOT NULL,
                  `price` varchar(50) NOT NULL,
                  `description` varchar(50) NOT NULL,
                  `attachment_count` int(11) NOT NULL,
                  `file_id` int(11) NOT NULL,
                  PRIMARY KEY (`id`)
                ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1" ;

$sql['1.1.2.8']   = "CREATE TABLE IF NOT EXISTS `engine4_property_images` (
                  `id` int(11) NOT NULL AUTO_INCREMENT,
                  `property_id` int(11) NOT NULL,
                  `image` varchar(250) NOT NULL,
                  PRIMARY KEY (`id`)
                ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1" ;

$sql['1.1.2.9']     = "ALTER TABLE `engine4_property_list`  ADD
                    `enable` int(11) NOT NULL AFTER `description`;";

$sql['1.1.2.10']    = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'core_admin_main_manage_property', 'user', 'Manage Property', '', '{\"route\":\"admin_default\",\"module\":\"user\",
                   \"controller\":\"manage\",\"action\":\"propertylist\"}', 'core_admin_main_manage', NULL, '1', '0', '999');";

$sql['1.1.2.11']    = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'user_index_propertylist', 'user', 'Properties', 'User_Plugin_Menus', '', 'user_profile', NULL, '1', '0', '999');";

$sql['1.1.2.12']    = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'user_index_addproperty', 'user', 'Add Property', 'User_Plugin_Menus', '', 'user_home', NULL, '1', '0', '999');";

$sql['1.1.2.13']   =    "CREATE TABLE IF NOT EXISTS `engine4_property_request` (
                  `id` int(11) NOT NULL AUTO_INCREMENT,
                  `property_id` int(11) NOT NULL,
                  `landlord_id` int(11) NOT NULL,
                  `tenant_id` int(11) NOT NULL,
                  `landlord_approve` int(11) NOT NULL,
                  `admin_approve` int(11) NOT NULL,

                  PRIMARY KEY (`id`)
                ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1" ;


$sql['1.1.2.14']    = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'core_admin_main_manage_propertyrequest', 'user', 'Manage Property Request', '', '{\"route\":\"admin_default\",\"module\":\"user\",
                   \"controller\":\"manage\",\"action\":\"propertyrequestlist\"}', 'core_admin_main_manage', NULL, '1', '0', '999');";

$sql['1.1.2.15']    = "ALTER TABLE  `engine4_property_list` ADD  `created_at`  varchar(50) NOT NULL AFTER  `file_id` ;";

$sql['1.1.2.16']    = "ALTER TABLE  `engine4_property_request` ADD  `created_at`  varchar(50) NOT NULL AFTER  `admin_approve` ;";

$sql['1.1.2.17']    = "ALTER TABLE  `engine4_property_request` ADD  `landlord_approve_date`  varchar(50) NOT NULL AFTER  `admin_approve` ;";

$sql['1.1.2.18']    = "ALTER TABLE  `engine4_property_request` ADD  `admin_approve_date`  varchar(50) NOT NULL AFTER  `admin_approve` ;";

$sql['1.1.2.19']    = "ALTER TABLE  `engine4_property_list` CHANGE  `description`  `description` VARCHAR( 5000 ) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL ;";

$sql['1.1.2.20']   =    "CREATE TABLE IF NOT EXISTS `engine4_cover_letter` (
                  `id` int(11) NOT NULL AUTO_INCREMENT,
                  `user_id` int(11) NOT NULL,
                  `title` varchar(100) NOT NULL,
                  `content` varchar(5000) NOT NULL,
                  `status` varchar(100) NOT NULL,
                  `create_at` varchar(50) NOT NULL,

                  PRIMARY KEY (`id`)
                ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1" ;

$sql['1.1.2.21']    = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'core_admin_main_manage_coverletter', 'user', 'Manage Cover Letter', '', '{\"route\":\"admin_default\",\"module\":\"user\",
                   \"controller\":\"manage\",\"action\":\"coverletterlist\"}', 'core_admin_main_manage', NULL, '1', '0', '999');";

$sql['1.1.3.2'] = "ALTER TABLE  `engine4_user_fields_search` CHANGE  `gender`  `gender` VARCHAR( 50 ) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL ;";

$sql['1.1.2.22']    = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'user_edit_document', 'user', 'Upload Document', '', '{\"route\":\"user_extended\",\"module\":\"user\",
                   \"controller\":\"edit\",\"action\":\"document\"}', 'user_edit', NULL, '1', '4', '999');";

$sql['1.1.2.23']   = "CREATE TABLE IF NOT EXISTS `engine4_user_documents` (
                  `id` int(11) NOT NULL AUTO_INCREMENT,
                  `user_id` int(11) NOT NULL,
                  `document_name` varchar(250) NOT NULL,
                  `document` varchar(500) NOT NULL,
                  `created_at` varchar(50) NOT NULL,
                  PRIMARY KEY (`id`)
                ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1" ;


$sql['1.1.2.24']    = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'user_index_myproperties', 'user', 'My Properties', 'User_Plugin_Menus', '', 'user_home', NULL, '1', '0', '6');";

$sql['1.1.2.25']    = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'user_profile_friends', 'user', 'Browse Members', 'User_Plugin_Menus', '', 'user_profile', NULL, '1', '0', '7');";

$sql['1.1.2.26']    = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'user_profile_invite', 'invite', 'Invite Your Friends', 'User_Plugin_Menus', '', 'user_profile', NULL, '1', '0', '8');";

$sql['1.1.2.27']    = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'user_profile_updates', 'user', 'View Recent Updates', 'User_Plugin_Menus', '', 'user_profile', NULL, '1', '0', '9');";

$sql['1.1.2.28']    = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'user_profile_addproperty', 'user', 'Add Property', 'User_Plugin_Menus', '', 'user_profile', NULL, '1', '0', '10');";

$sql['1.1.2.29']    = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'user_profile_view', 'user', 'View My Profile', 'User_Plugin_Menus', '', 'user_profile', NULL, '1', '0', '2');";

$sql['1.1.2.30']    = "ALTER TABLE  `engine4_property_list` ADD  `no_of_rooms` INT NOT NULL AFTER  `rental_type` ,
                      ADD  `housing_type` VARCHAR( 50 ) NOT NULL AFTER  `no_of_rooms`;";

$sql['1.1.2.31']    = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'core_main_properties', 'user', 'Properties', 'User_Plugin_Menus', '', 'core_main', NULL, '1', '0', '6');";

$sql['1.1.2.32']    = "ALTER TABLE  `engine4_property_list` ADD  `landlord_enable`  int(11) NOT NULL AFTER  `enable` ;";

//$sql['1.1.2.33']  = "UPDATE  `engine4_core_menuitems` SET  `label` =  'Documents' WHERE  `engine4_core_menuitems`.`name` =  'user_edit_document';";

$sql['1.1.2.34']    = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'user_edit_documentslist', 'user', 'Documents', 'User_Plugin_Menus', '{\"route\":\"user_extended\",\"module\":\"user\",
                   \"controller\":\"edit\",\"action\":\"documentslist\"}', 'user_edit', NULL, '1', '4', '4');";

$sql['1.1.2.35']    = "UPDATE  `engine4_core_menuitems` SET  `plugin` =  'User_Plugin_Menus' WHERE  `engine4_core_menuitems`.`name` =  'user_edit_document';";

$sql['1.1.2.36']    = "ALTER TABLE  `engine4_property_list` ADD  `zipcode`  varchar(50) NOT NULL AFTER  `city_id` ;";

$sql['1.1.2.37']    = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'advancedarticles_admin_main_add', 'advancedarticles', 'Add New Article', '', '{\"route\":\"admin_default\",\"module\":\"advancedarticles\",
                   \"controller\":\"settings\",\"action\":\"addarticle\"}', 'advancedarticles_admin_main', NULL, '1', '0', '999');";

$sql['1.1.2.38']    = "UPDATE  `engine4_core_menuitems` SET  `enabled` =  '0' WHERE  `engine4_core_menuitems`.`name` ='advancedarticles_admin_main_settings';";

$sql['1.1.2.39']    = "UPDATE  `engine4_core_menuitems` SET  `enabled` =  '0' WHERE  `engine4_core_menuitems`.`name` ='advancedarticles_page_category';";

$sql['1.1.2.40']    = "UPDATE  `engine4_core_menuitems` SET  `enabled` =  '0' WHERE  `engine4_core_menuitems`.`name` ='advancedarticles_page_my';";

$sql['1.1.2.41']    = "ALTER TABLE  `engine4_advancedarticles_artarticles` ADD  `trending_article` INT NOT NULL AFTER  `sponsored`;";

$sql['1.1.2.42']    = "ALTER TABLE  `engine4_advancedarticles_artarticles` ADD  `position` INT NOT NULL AFTER  `sponsored`;";

$sql['1.1.3.3']     = "ALTER TABLE  `engine4_property_list` ADD `pets_type` VARCHAR(100) NOT NULL AFTER  `housing_type`;";

$sql['1.1.3.4']     = "ALTER TABLE  `engine4_users` ADD  `bg_verified` tinyint( 1 ) NOT NULL AFTER  `approved` ;";

$sql['1.1.3.5']     = "ALTER TABLE  `engine4_property_list` ADD `has_pets` VARCHAR(50) NOT NULL AFTER  `housing_type`;";

$sql['1.1.2.43']    = "UPDATE  `engine4_core_menuitems` SET  `plugin` =  'User_Plugin_Menus' WHERE  `engine4_core_menuitems`.`name` =  'user_home_updates';";
$sql['1.1.2.44']    = "UPDATE  `engine4_core_menuitems` SET  `plugin` =  'User_Plugin_Menus' WHERE  `engine4_core_menuitems`.`name` =  'user_home_friends';";
$sql['1.1.2.45']    = "UPDATE  `engine4_core_menuitems` SET  `enabled` =  '0' WHERE  `engine4_core_menuitems`.`name` =  'user_edit_style';";


$sql['1.1.3.6']     = "ALTER TABLE  `engine4_property_images` ADD `type` VARCHAR(50) NOT NULL AFTER  `image`,
                    ADD `storage_file_id` int(11) NOT NULL AFTER  `type` ;";

$sql['1.1.3.7']     = "ALTER TABLE  `engine4_property_list` ADD `video_count` int(11) NOT NULL AFTER  `attachment_count`;";

$sql['1.1.2.46']   = "CREATE TABLE IF NOT EXISTS `engine4_document_share` (
                      `id` int(11) NOT NULL AUTO_INCREMENT,
                      `sender_id` int(11) NOT NULL,
                      `reciever_id` int(11) NOT NULL,
                      `share_file_id` int(11) NOT NULL,
                      `shared_document` varchar(100) NOT NULL,
                      `shared_document_name` varchar(100) NOT NULL,
                      `shared_date` varchar(100) NOT NULL,
                      PRIMARY KEY (`id`)
                    ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1" ;

$sql['1.1.2.47']    = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'user_home_documents', 'user', 'Documents', 'User_Plugin_Menus', '', 'user_home', NULL, '1', '0', '11');";

$sql['1.1.2.48']   = "CREATE TABLE IF NOT EXISTS `engine4_document_requests` (
                      `id` int(11) NOT NULL AUTO_INCREMENT,
                      `doc_requested_user_id` int(11) NOT NULL,
                      `doc_owner_id` int(11) NOT NULL,
                      `file_id` int(11) NOT NULL,
                      `doc_path` varchar(100) NOT NULL,
                      `doc_name` varchar(100) NOT NULL,
                      `doc_owner_approve` int(11) NOT NULL,
                      `admin_approve` int(11) NOT NULL,
                      `requested_date` varchar(100) NOT NULL,
                      `req_approve_date` varchar(100) NOT NULL,
                      PRIMARY KEY (`id`)
                    ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1" ;

$sql['1.1.2.49']   = "CREATE TABLE IF NOT EXISTS `engine4_dropbox_files` (
                      `id` int(11) NOT NULL AUTO_INCREMENT,
                      `dir_structure` varchar(100) NOT NULL,
                      `file_path` varchar(100) NOT NULL,
                      `file_title` varchar(100) NOT NULL,
                      `file_owner_id` int(11) NOT NULL,
                      `created_at` varchar(100) NOT NULL,
                      PRIMARY KEY (`id`)
                    ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1" ;

$sql['1.1.2.50']   = "CREATE TABLE IF NOT EXISTS `engine4_dropbox_log` (
                      `id` int(11) NOT NULL AUTO_INCREMENT,
                      `subject_id` int(11) NOT NULL,
                      `object_id` int(11) NOT NULL,
                      `path` varchar(100) NOT NULL,
                      `action` varchar(100) NOT NULL,
                      `created_at` varchar(100) NOT NULL,
                      `updated_at` varchar(100) NOT NULL,
                      PRIMARY KEY (`id`)
                    ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1" ;

$sql['1.1.2.51']    = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'core_admin_main_manage_documents', 'user', 'Manage Documents', '', '{\"route\":\"admin_default\",\"module\":\"user\",
                   \"controller\":\"manage\",\"action\":\"documents\"}', 'core_admin_main_manage', NULL, '1', '0', '999');";


$sql['1.1.2.52']    = "INSERT INTO `engine4_activity_notificationtypes` (`type`, `module`, `body`, `is_request`, `handler`, `default`) VALUES ('document_request', 'user', '{item:\$subject} has requested to access your document {item:\$object:\$label}.', '0', '', '1');";

$sql['1.1.2.53']    = "UPDATE  `engine4_core_menuitems` SET  `enabled` =  '0' WHERE  `engine4_core_menuitems`.`name` =  'user_edit_document';";

$sql['1.1.2.54']    = "UPDATE  `engine4_core_menuitems` SET  `enabled` =  '0' WHERE  `engine4_core_menuitems`.`name` =  'user_edit_documentslist';";

$sql['1.1.2.55']    = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'user_profile_documents', 'user', 'Documents', 'User_Plugin_Menus', '', 'user_profile', NULL, '1', '0', '13');";

$sql['1.1.2.56']    = "ALTER TABLE  `engine4_property_request` ADD  `granted` INT NOT NULL AFTER  `landlord_approve_date`;";

$sql['1.1.2.57']    = "ALTER TABLE  `engine4_property_request` ADD  `granted_date` VARCHAR(50) NOT NULL AFTER  `granted`;";

$sql['1.1.2.58']    = "CREATE TABLE IF NOT EXISTS `engine4_property_granted` (
                      `id` int(11) NOT NULL AUTO_INCREMENT,
                      `property_id` int(11) NOT NULL,
                      `tenant_id` int(11) NOT NULL,
                      `landlord_id` int(11) NOT NULL,
                      `granted` int(11) NOT NULL,
                      `status` int(11) NOT NULL,
                      `granted_date` varchar(50) NOT NULL,
                      `end_date` varchar(50) NOT NULL,
                      PRIMARY KEY (`id`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1" ;

$sql['1.1.2.59']    = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'core_admin_main_manage_ratingquestions', 'user', 'Manage Rating Questions', '', '{\"route\":\"admin_default\",\"module\":\"user\",
                   \"controller\":\"manage\",\"action\":\"ratingquestionslist\"}', 'core_admin_main_manage', NULL, '1', '0', '999');";

$sql['1.1.2.60']    = "CREATE TABLE IF NOT EXISTS `engine4_rating_questions` (
                      `id` int(11) NOT NULL AUTO_INCREMENT,
                      `profile_type` int(11) NOT NULL,
                      `questions` varchar(500) NOT NULL,
                      `created_at` varchar(50) NOT NULL,
                      PRIMARY KEY (`id`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 " ;

$sql['1.1.2.61']    = "CREATE TABLE IF NOT EXISTS `engine4_rating_value` (
                      `id` int(11) NOT NULL AUTO_INCREMENT,
                      `subject_id` int(11) NOT NULL,
                      `object_id` int(11) NOT NULL,
                      `rate_value` varchar(50) NOT NULL,
                      `rated_date` varchar(50) NOT NULL,
                      `next_rating_date` varchar(50) NOT NULL,
                      PRIMARY KEY (`id`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 " ;

$sql['1.1.2.62']    = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'core_admin_main_manage_rating', 'user', 'Manage Rating', '', '{\"route\":\"admin_default\",\"module\":\"user\",
                   \"controller\":\"manage\",\"action\":\"ratinglist\"}', 'core_admin_main_manage', NULL, '1', '0', '999');";

$sql['1.1.2.63']    = "ALTER TABLE  `engine4_users` ADD  `rating_value` varchar( 50 ) NOT NULL AFTER  `view_count` ;";

$sql['1.1.2.64']    = "ALTER TABLE  `engine4_users` ADD  `enable_rating_value` int( 11 ) NOT NULL AFTER  `rating_value` ;";

$sql['1.1.2.65']    = "CREATE TABLE IF NOT EXISTS `engine4_rating_questionsvalue` (
                      `id` int(11) NOT NULL AUTO_INCREMENT,
                      `subject_id` int(11) NOT NULL,
                      `object_id` int(11) NOT NULL,
                      `question_id` int(11) NOT NULL,
                      `qn_rate_value` varchar(50) NOT NULL,
                      `rated_date` varchar(50) NOT NULL,
                      `next_rating_date` varchar(50) NOT NULL,
                      PRIMARY KEY (`id`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 " ;

$sql['1.1.2.66']    = "INSERT INTO `engine4_activity_notificationtypes` (`type`, `module`, `body`, `is_request`, `handler`, `default`) VALUES ('profile_rate', 'user', '{item:\$subject}  rated you.', '0', '', '1');";

$sql['1.1.2.67']    = "ALTER TABLE  `engine4_property_list` ADD  `granted` INT NOT NULL AFTER  `created_at`;";

$sql['1.1.2.68']    = "ALTER TABLE  `engine4_property_list` ADD  `granted_date` VARCHAR(50) NOT NULL AFTER  `granted`;";


$sql['1.1.2.69']    = "CREATE TABLE IF NOT EXISTS `engine4_rating_interval` (
                      `id` int(11) NOT NULL AUTO_INCREMENT,
                      `days` int(11) NOT NULL,
                      `created_at` varchar(50) NOT NULL,
                      PRIMARY KEY (`id`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 " ;


$sql['1.1.2.70']        = "ALTER TABLE `engine4_property_list`  ADD
                    `action_id` int(11) NOT NULL AFTER `id`;";

$sql['1.1.2.71']    = "INSERT INTO `engine4_activity_actiontypes` (`type`, `module`, `body`,`enabled`, `displayable`, `attachable`, `commentable`,`shareable`,`is_generated`) VALUES ('property', 'user', '{item:\$subject} {body:\$body}', '1', '5', '1','4','1','0');";

$sql['1.1.2.72']    =  "CREATE TABLE IF NOT EXISTS `engine4_property_requirement` (
                      `id` int(11) NOT NULL AUTO_INCREMENT,
                      `action_id` int(11) NOT NULL,
                      `tenant_id` int(11) NOT NULL,
                      `country_id` int(11) NOT NULL,
                      `state_id` int(11) NOT NULL,
                      `city_id` int(11) NOT NULL,
                      `zipcode` varchar(50) NOT NULL,
                      `pets_allowed` varchar(50) NOT NULL,
                      `pets_type` varchar(100) NOT NULL,
                      `rental_type` varchar(50) NOT NULL,
                      `housing_type` varchar(100) NOT NULL,
                      `no_of_rooms` int(11) NOT NULL,
                      `budget` varchar(100) NOT NULL,
                      `created_at` varchar(50) NOT NULL,
                       PRIMARY KEY (`id`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 " ;

$sql['1.1.2.73']    = "INSERT INTO `engine4_activity_actiontypes` (`type`, `module`, `body`,`enabled`, `displayable`, `attachable`, `commentable`,`shareable`,`is_generated`) VALUES ('property_requirement', 'user', '{item:\$subject} {body:\$body}', '1', '5', '1','4','1','0');";

$sql['1.1.2.74']        = "ALTER TABLE `engine4_rating_questions`  ADD
                    `status` int(11) NOT NULL AFTER `questions`;";

$sql['1.1.2.75']    = "CREATE TABLE IF NOT EXISTS `engine4_propertymatching_log` (
                      `id` int(11) NOT NULL AUTO_INCREMENT,
                      `tenant_id` int(11) NOT NULL,
                      `property_id` int(11) NOT NULL,
                      `created_at` varchar(50) NOT NULL,
                      PRIMARY KEY (`id`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 " ;


$sql['1.1.4.1']     = "ALTER TABLE  `engine4_property_list` ADD `first_admin_enable` int(11) NOT NULL AFTER  `enable`;";

$sql['1.1.2.76']        = "ALTER TABLE  `engine4_property_requirement` ADD `budget_range_from` varchar(100) NOT NULL AFTER  `budget`;";

$sql['1.1.2.77']        = "ALTER TABLE  `engine4_property_requirement` ADD `budget_range_to` varchar(100) NOT NULL AFTER  `budget_range_from`;";

$sql['1.1.4.2']   = "CREATE TABLE IF NOT EXISTS `engine4_rating_log` (
                    `id` int(11) NOT NULL AUTO_INCREMENT,
                    `property_id` int(11) NOT NULL,
                    `subject_id` int(11) NOT NULL,
                    `object_id` int(11) NOT NULL,
                    `next_rating_date` varchar(50) NOT NULL,
                    PRIMARY KEY (`id`)
                    ) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1" ;

$sql['1.1.2.78']    = "INSERT INTO `engine4_activity_notificationtypes` (`type`, `module`, `body`, `is_request`, `handler`, `default`) VALUES ('matching_property', 'user', '{item:\$subject} has added a property {item:\$object:\$label} that matches with your requirement.', '0', '', '1');";

$sql['1.1.4.3']     = "ALTER TABLE `engine4_property_list` CHANGE `description` `description` VARCHAR( 50000 ) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL ;";

$sql['1.1.2.79']   =  "CREATE TABLE IF NOT EXISTS `engine4_cron_log` (
                      `id` int(11) NOT NULL AUTO_INCREMENT,
                      `type` varchar(50) NOT NULL,
                      `execution_count` int(11) NOT NULL,
                      `created_at` varchar(50) NOT NULL,
                      PRIMARY KEY (`id`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1" ;
$sql['1.1.4.4'] = "INSERT INTO `engine4_activity_notificationtypes` (`type`, `module`, `body`, `is_request`, `handler`, `default`) VALUES ('document_request_approve', 'user', '{item:\$subject} has approved your request for document {item:\$object:\$label}.', '0', '', '1');";

$sql['1.1.4.5'] = "INSERT INTO `engine4_activity_notificationtypes` (`type`, `module`, `body`, `is_request`, `handler`, `default`) VALUES ('document_request_reject', 'user', '{item:\$subject} has rejected your request for document {item:\$object:\$label}.', '0', '', '1');";

$sql['1.1.2.80']    = "UPDATE  `engine4_activity_notificationtypes` SET  `body` =  '{item:\$subject} has rejected your request for document {item:\$subject:\$label}' WHERE  `engine4_activity_notificationtypes`.`type` =  'document_request_reject';";

$sql['1.1.4.6'] = "INSERT INTO `engine4_activity_notificationtypes` (`type`, `module`, `body`, `is_request`, `handler`, `default`) VALUES ('document_share', 'user', '{item:\$subject} has shared document {item:\$object:\$label}.', '0', '', '1');";

$sql['1.1.2.81']   =  "CREATE TABLE IF NOT EXISTS `engine4_property_viewlog` (
                      `id` int(11) NOT NULL AUTO_INCREMENT,
                      `property_id` int(11) NOT NULL,
                      `user_id` int(11) NOT NULL,
                      `updated_at` varchar(50) NOT NULL,
                      PRIMARY KEY (`id`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1" ;

$sql['1.1.2.82']        = "ALTER TABLE `engine4_property_list`  ADD
                    `view_count` int(11) NOT NULL AFTER `file_id`;";

$sql['1.1.4.7'] = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'user_home_gallery', 'user', 'Gallery', 'User_Plugin_Menus', '', 'user_home', NULL, '1', '0', '11');";

$sql['1.1.4.8'] = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'user_home_requested_properties', 'user', 'Requested Properties', 'User_Plugin_Menus', '', 'user_home', NULL, '1', '0', '11');";

$sql['1.1.2.83'] = "ALTER TABLE `engine4_rating_questionsvalue`  ADD

                    `property_id` int(11) NOT NULL AFTER `question_id`;";

$sql['1.1.4.9'] = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'user_home_request_approved_properties', 'user', 'Approved Properties', 'User_Plugin_Menus', '', 'user_home', NULL, '1', '0', '11');";


$sql['1.1.2.84'] = "CREATE TABLE IF NOT EXISTS `engine4_property_countries` (
                  `country_id` int(11) NOT NULL AUTO_INCREMENT,
                  `prty_country` varchar(50) NOT NULL,
                  PRIMARY KEY (`country_id`)
                ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1";

$sql['1.1.2.85'] = "CREATE TABLE IF NOT EXISTS `engine4_property_states` (
                  `state_id` int(11) NOT NULL AUTO_INCREMENT,
                  `country_id` int(11) NOT NULL ,
                  `prty_state` varchar(50) NOT NULL,
                  PRIMARY KEY (`state_id`)
                ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1";

$sql['1.1.2.86'] = "CREATE TABLE IF NOT EXISTS `engine4_property_city` (
                  `city_id` int(11) NOT NULL AUTO_INCREMENT,
                  `country_id` int(11) NOT NULL ,
                  `state_id` int(11) NOT NULL ,
                  `prty_city` varchar(50) NOT NULL,
                  `zipcode` varchar(50) NOT NULL,
                  `latitude` varchar(50) NOT NULL,
                  `longitude` varchar(50) NOT NULL,
                  PRIMARY KEY (`city_id`)
                ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1";

$sql['1.1.2.87'] = "ALTER TABLE `engine4_property_list`
                    ADD `prty_country_id` INT NOT NULL AFTER `property_name`,
                    ADD `prty_state_id` INT NOT NULL AFTER `prty_country_id`,
                    ADD `prty_city_id` INT NOT NULL AFTER `prty_state_id`;";


$sql['1.1.2.88']    = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'user_edit_locationpreference', 'user', 'Edit Location Preference', '', '{\"route\":\"user_extended\",\"module\":\"user\",
                   \"controller\":\"edit\",\"action\":\"locationpreference\"}', 'user_edit', NULL, '1', '4', '999');";


$sql['1.1.2.89'] = "ALTER TABLE `engine4_users`
                    ADD `prefered_location` varchar(50) NOT NULL AFTER `enable_rating_value`;";

$sql['1.1.4.10']="UPDATE `engine4_core_menuitems` SET  `params` =  '{\"route\":\"admin_default\",\"module\":\"user\",
                   \"controller\":\"manage\",\"action\":\"landlordratingquestionslist\"}' WHERE  `engine4_core_menuitems`.`id` =201;";


$sql['1.1.2.90'] = "ALTER TABLE `engine4_property_request`
                    ADD `tenant_firstname` VARCHAR(50) NOT NULL AFTER `created_at`,
                    ADD `tenant_last_name` VARCHAR(50) NOT NULL AFTER `tenant_firstname`,
                    ADD `tenant_email` VARCHAR(50) NOT NULL AFTER `tenant_last_name`,
                    ADD `tenant_pno` VARCHAR(50) NOT NULL AFTER `tenant_email`,
                    ADD `driver_license_no` VARCHAR(50) NOT NULL AFTER `tenant_pno`,
                    ADD `current_residence_housing_type` VARCHAR(25) NOT NULL AFTER `driver_license_no`,
                    ADD `current_residence_address` VARCHAR(200) NOT NULL AFTER `current_residence_housing_type`,
                    ADD `current_residence_move_in_date` VARCHAR(50) NOT NULL AFTER `current_residence_address`,
                    ADD `current_residence_monthly_rent` VARCHAR(50) NOT NULL AFTER `current_residence_move_in_date`,
                    ADD `current_residence_landlordname` VARCHAR(50) NOT NULL AFTER `current_residence_monthly_rent`,
                    ADD `current_residence_landlord_pno` VARCHAR(50) NOT NULL AFTER `current_residence_landlordname`,
                    ADD `current_residence_leaving_reason` VARCHAR(100) NOT NULL AFTER `current_residence_landlord_pno`,
                    ADD `previous_residence_housing_type` VARCHAR(50) NOT NULL AFTER `current_residence_leaving_reason`,
                    ADD `previous_residence_address` VARCHAR(200) NOT NULL AFTER `previous_residence_housing_type`,
                    ADD `previous_residence_move_in_date` VARCHAR(50) NOT NULL AFTER `previous_residence_address`,
                    ADD `previous_residence_monthly_rent` VARCHAR(50) NOT NULL AFTER `previous_residence_move_in_date`,
                    ADD `previous_residence_landlord_name` VARCHAR(50) NOT NULL AFTER `previous_residence_monthly_rent`,
                    ADD `previous_residence_landlord_pno` VARCHAR(50) NOT NULL AFTER `previous_residence_landlord_name`,
                    ADD `previous_residence_leaving_reason` VARCHAR(100) NOT NULL AFTER `previous_residence_landlord_pno`,
                    ADD `current_occupation_status` VARCHAR(50) NOT NULL AFTER `previous_residence_leaving_reason`,
                    ADD `current_occupation_income_source` VARCHAR(100) NOT NULL AFTER `current_occupation_status`,
                    ADD `current_occupation_monthly_income` VARCHAR(50) NOT NULL AFTER `current_occupation_income_source`,
                    ADD `previous_occupation_monthly_status` VARCHAR(50) NOT NULL AFTER `current_occupation_monthly_income`,
                    ADD `previous_occupation_employer` VARCHAR(100) NOT NULL AFTER `previous_occupation_monthly_status`,
                    ADD `previous_occupation_job_title` VARCHAR(100) NOT NULL AFTER `previous_occupation_employer`,
                    ADD `previous_occupation_monthly_salary` VARCHAR(100) NOT NULL AFTER `previous_occupation_job_title`,
                    ADD `previous_occupation_manager_name` VARCHAR(100) NOT NULL AFTER `previous_occupation_monthly_salary`,
                    ADD `previous_occupation_work_address` VARCHAR(200) NOT NULL AFTER `previous_occupation_manager_name`,
                    ADD `previous_occupation_end_date` VARCHAR(100) NOT NULL AFTER `previous_occupation_work_address`,
                    ADD `additional_income_sources` VARCHAR(200) NOT NULL AFTER `previous_occupation_end_date`,
                    ADD `additional_income_amount` VARCHAR(50) NOT NULL AFTER `additional_income_sources`,
                    ADD `total_monthly_income` VARCHAR(50) NOT NULL AFTER `additional_income_amount`,
                    ADD `personal_references_full_name` VARCHAR(100) NOT NULL AFTER `total_monthly_income`,
                    ADD `personal_references_relationship` VARCHAR(100) NOT NULL AFTER `personal_references_full_name`,
                    ADD `personal_references_address` VARCHAR(100) NOT NULL AFTER `personal_references_relationship`,
                    ADD `personal_references_pno` VARCHAR(100) NOT NULL AFTER `personal_references_address`;";


$sql['1.1.2.91'] = "ALTER TABLE `engine4_property_request`
                    ADD `current_occupation_employer` VARCHAR(100) NOT NULL AFTER `current_occupation_status`,
                    ADD `current_occupation_job_title` VARCHAR(100) NOT NULL AFTER `current_occupation_employer`,
                    ADD `current_occupation_monthly_salary` VARCHAR(100) NOT NULL AFTER `current_occupation_job_title`,
                    ADD `current_occupation_work_type` VARCHAR(100) NOT NULL AFTER `current_occupation_monthly_salary`,
                    ADD `current_occupation_manager_name` VARCHAR(100) NOT NULL AFTER `current_occupation_work_type`,
                    ADD `current_occupation_pno` VARCHAR(100) NOT NULL AFTER `current_occupation_manager_name`,
                    ADD `current_occupation_work_address` VARCHAR(100) NOT NULL AFTER `current_occupation_pno`,
                    ADD `current_occupation_start_date` VARCHAR(100) NOT NULL AFTER `current_occupation_work_address`,
                    ADD `previous_occupation_work_type` VARCHAR(100) NOT NULL AFTER `previous_occupation_monthly_salary`;";


$sql['1.1.2.92'] = "ALTER TABLE `engine4_property_request`
                    ADD `previous_occupation_income_source` VARCHAR(100) NOT NULL AFTER `previous_occupation_end_date`,
                    ADD `previous_occupation_pno` VARCHAR(100) NOT NULL AFTER `previous_occupation_manager_name`,
                    ADD `previous_occupation__monthly_income` VARCHAR(100) NOT NULL AFTER `previous_occupation_income_source`;";


$sql['1.1.2.93']    = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'core_main_rentalapplication', 'user', 'CREATE APPLICATION ', 'User_Plugin_Menus', '', 'core_main', NULL, '1', '0', '6');";

$sql['1.1.2.94'] = "CREATE TABLE IF NOT EXISTS `engine4_rental_application` (
              `id` int(11) NOT NULL AUTO_INCREMENT,
              `tenant_id` int(11) NOT NULL,
              `tenant_firstname` varchar(50) NOT NULL,
              `tenant_last_name` varchar(50) NOT NULL,
              `tenant_email` varchar(50) NOT NULL,
              `tenant_pno` varchar(50) NOT NULL,
              `driver_license_no` varchar(50) NOT NULL,
              `current_residence_housing_type` varchar(25) NOT NULL,
              `current_residence_address` varchar(100) NOT NULL,
              `current_residence_move_in_date` varchar(50) NOT NULL,
              `current_residence_monthly_rent` varchar(50) NOT NULL,
              `current_residence_landlordname` varchar(50) NOT NULL,
              `current_residence_landlord_pno` varchar(50) NOT NULL,
              `current_residence_leaving_reason` varchar(100) NOT NULL,
              `previous_residence_housing_type` varchar(50) NOT NULL,
              `previous_residence_address` varchar(100) NOT NULL,
              `previous_residence_move_in_date` varchar(50) NOT NULL,
              `previous_residence_monthly_rent` varchar(50) NOT NULL,
              `previous_residence_landlord_name` varchar(50) NOT NULL,
              `previous_residence_landlord_pno` varchar(50) NOT NULL,
              `previous_residence_leaving_reason` varchar(100) NOT NULL,
              `current_occupation_status` varchar(50) NOT NULL,
              `current_occupation_employer` varchar(50) NOT NULL,
              `current_occupation_job_title` varchar(100) NOT NULL,
              `current_occupation_monthly_salary` varchar(100) NOT NULL,
              `current_occupation_work_type` varchar(100) NOT NULL,
              `current_occupation_manager_name` varchar(100) NOT NULL,
              `current_occupation_pno` varchar(100) NOT NULL,
              `current_occupation_work_address` varchar(100) NOT NULL,
              `current_occupation_start_date` varchar(50) NOT NULL,
              `current_occupation_income_source` varchar(100) NOT NULL,
              `current_occupation_monthly_income` varchar(100) NOT NULL,
              `previous_occupation_monthly_status` varchar(100) NOT NULL,
              `previous_occupation_employer` varchar(100) NOT NULL,
              `previous_occupation_job_title` varchar(100) NOT NULL,
              `previous_occupation_monthly_salary` varchar(100) NOT NULL,
              `previous_occupation_work_type` varchar(100) NOT NULL,
              `previous_occupation_manager_name` varchar(100) NOT NULL,
              `previous_occupation_pno` varchar(50) NOT NULL,
              `previous_occupation_work_address` varchar(100) NOT NULL,
              `previous_occupation_end_date` varchar(50) NOT NULL,
              `previous_occupation_income_source` varchar(100) NOT NULL,
              `previous_occupation__monthly_income` varchar(100) NOT NULL,
              `additional_income_sources` varchar(100) NOT NULL,
              `additional_income_amount` varchar(50) NOT NULL,
              `total_monthly_income` varchar(50) NOT NULL,
              `personal_references_full_name` varchar(50) NOT NULL,
              `personal_references_relationship` varchar(50) NOT NULL,
              `personal_references_address` varchar(100) NOT NULL,
              `personal_references_pno` varchar(50) NOT NULL,
              PRIMARY KEY (`id`)
            ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1";


$sql['1.1.2.95']    = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'core_admin_main_manage_smartmoveapiquestions', 'user', 'Manage SmartMove Api Questions', '', '{\"route\":\"admin_default\",\"module\":\"user\",
                   \"controller\":\"manage\",\"action\":\"smartmoveapiquestions\"}', 'core_admin_main_manage', NULL, '1', '0', '999');";


$sql['1.1.2.96'] = "CREATE TABLE IF NOT EXISTS `engine4_smartmoveapi_questions` (
                  `qid` int(11) NOT NULL AUTO_INCREMENT,
                  `qtext` varchar(200) NOT NULL ,
                  `selected_answer` varchar(50) NOT NULL,
                  PRIMARY KEY (`qid`)
                ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1";

$sql['1.1.2.97'] = "CREATE TABLE IF NOT EXISTS `engine4_smartmoveapi_questionanswers` (
                  `id` int(11) NOT NULL AUTO_INCREMENT,
                  `qid` int(11) NOT NULL,
                  `answer_text` varchar(200) NOT NULL ,
                  `answer_description` varchar(2000) NOT NULL,
                  PRIMARY KEY (`id`)
                ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1";

$sql['1.1.2.98'] = "ALTER TABLE  `engine4_users` ADD  `creditscore_view_status` INT NOT NULL AFTER  `prefered_location`;";

$sql['1.1.2.99'] = "CREATE TABLE IF NOT EXISTS `engine4_smartmoveapi_renters` (
                  `id` int(11) NOT NULL AUTO_INCREMENT,
                  `tenant_id` int(11) NOT NULL,
                  `Email` varchar(100) NOT NULL ,
                  `FirstName` varchar(100) NOT NULL,
                  `MiddleName` varchar(100) NOT NULL,
                  `LastName` varchar(100) NOT NULL,
                  `DateOfBirth` varchar(50) NOT NULL,
                  `EmploymentStatus` varchar(50) NOT NULL,
                  `StreetAddressLineOne` varchar(100) NOT NULL,
                  `StreetAddressLineTwo` varchar(100) NOT NULL,
                  `City` varchar(100) NOT NULL,
                  `State` varchar(25) NOT NULL,
                  `Zip` int(11) NOT NULL,
                  `HomePhoneNumber` int(50) NOT NULL,
                  `OfficePhoneNumber` int(50) NOT NULL,
                  `OfficePhoneExtension` int(11) NOT NULL,
                  `MobilePhoneNumber` int(50) NOT NULL,
                  `Income` varchar(50) NOT NULL,
                  `IncomeFrequency` varchar(50) NOT NULL,
                  `OtherIncome` varchar(50) NOT NULL,
                  `OtherIncomeFrequency` varchar(50) NOT NULL,
                  `AssetValue` varchar(50) NOT NULL,
                  `FcraAgreementAccepted` varchar(50) NOT NULL,
                  `SocialSecurityNumber` int(11) NOT NULL,
                  `created_at` varchar(50) NOT NULL,
                  `updated_at` varchar(50) NOT NULL,
                  PRIMARY KEY (`id`)
                ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1";

$sql['1.1.2.100'] = "CREATE TABLE IF NOT EXISTS `engine4_smartmoveapi_property` (
                  `id` int(11) NOT NULL AUTO_INCREMENT,
                  `Pid` int(11) NOT NULL,
                  `SmartmovePropertyId` int(11) NOT NULL,
                  `PropertyIdentifier` varchar(100) NOT NULL ,
                  `OrganizationName` varchar(100) NOT NULL,
                  `OrganizationId` int(11) NOT NULL,
                  `Active` varchar(20) NOT NULL,
                  `Name` varchar(50) NOT NULL,
                  `FirstName` varchar(50) NOT NULL,
                  `LastName` varchar(50) NOT NULL,
                  `Street` varchar(50) NOT NULL,
                  `City` varchar(100) NOT NULL,
                  `State` varchar(100) NOT NULL,
                  `Zip` int(11) NOT NULL,
                  `Phone` int(50) NOT NULL,
                  `PhoneExtension` int(11) NOT NULL,
                  `Classification` varchar(25) NOT NULL,
                  `IR` int(25) NOT NULL,
                  `IncludeMedicalCollections` varchar(25) NOT NULL,
                  `DeclineForOpenBankruptcies` varchar(25) NOT NULL,
                  `OpenBankruptcyWindow` varchar(25) NOT NULL,
                  `IsFcraAgreementAccepted` varchar(25) NOT NULL,
                  `IncludeForeclosures` varchar(25) NOT NULL,
                  `UnitNumber` varchar(50) NOT NULL,
                  `created_at` varchar(50) NOT NULL,
                  `updated_at` varchar(50) NOT NULL,
                  PRIMARY KEY (`id`)
                ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1";

$sql['1.1.2.101'] = "CREATE TABLE IF NOT EXISTS `engine4_smartmoveapi_application` (
                  `id` int(11) NOT NULL AUTO_INCREMENT,
                  `rental_application_id` int(11) NOT NULL,
                  `SmartmovePropertyId` int(11) NOT NULL,
                  `SmartmoveApplicationId` int(11) NOT NULL,
                  `UnitNumber` varchar(50) NOT NULL,
                  `Deposit` varchar(50) NOT NULL,
                  `Rent` varchar(50) NOT NULL,
                  `LeaseTermInMonths` int(11) NOT NULL,
                  `LandlordPays` varchar(50) NOT NULL,
                  `ProductBundle` varchar(50) NOT NULL,
                  `Applicants` varchar(50) NOT NULL,
                  `ApplicationStatus` varchar(50) NOT NULL,
                  `IdmaVerificationStatus` varchar(50) NOT NULL,
                  `created_at` varchar(50) NOT NULL,
                  `updated_at` varchar(50) NOT NULL,
                  PRIMARY KEY (`id`)
                ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1";


$sql['1.1.2.102']   = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'core_admin_main_manage_transunion', 'user', 'Manage TransUnion', '', '{\"route\":\"admin_default\",\"module\":\"user\",
                   \"controller\":\"manage\",\"action\":\"transunion\"}', 'core_admin_main_manage', NULL, '1', '0', '999');";

$sql['1.1.2.103'] = "CREATE TABLE IF NOT EXISTS `engine4_smartmoveapi_manage` (
                  `id` int(11) NOT NULL AUTO_INCREMENT,
                  `enable` int(11) NOT NULL,
                  `created_at` varchar(50) NOT NULL,
                  `updated_at` varchar(50) NOT NULL,
                  PRIMARY KEY (`id`)
                ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1";

$sql['1.1.2.104']   = "ALTER TABLE  `engine4_state_list` ADD  `state_abbr` varchar(50) NOT NULL AFTER  `state` ;";

$sql['1.1.2.105'] = "CREATE TABLE IF NOT EXISTS `engine4_smartmoveapi_examretrieve` (
                  `id` int(11) NOT NULL AUTO_INCREMENT,
                  `responseId` varchar(50) NOT NULL,
                  `SecurityToken` varchar(5000) NOT NULL,
                  `TimeOfRequest` varchar(50) NOT NULL,
                  `Email` varchar(50) NOT NULL,
                  `Evaluation` varchar(50)  NULL,
                  `QuestionsJson` varchar(10000) NOT NULL,
                  `created_at` varchar(50) NOT NULL,
                  `updated_at` varchar(50) NOT NULL,
                  PRIMARY KEY (`id`)
                ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1";

$sql['1.1.2.106']   = "ALTER TABLE  `engine4_smartmoveapi_renters` ADD  `exam_retrieve_responseId` varchar(1000) NOT NULL AFTER  `id` ;";

$sql['1.1.2.107']   = "ALTER TABLE  `engine4_smartmoveapi_renters` CHANGE  `Zip`  `Zip` varchar( 50 ) NOT NULL ;";

$sql['1.1.2.108']   = "ALTER TABLE  `engine4_smartmoveapi_renters` CHANGE  `Zip`  `Zip` varchar( 50 ) NOT NULL ;";

$sql['1.1.2.109']   = "ALTER TABLE  `engine4_smartmoveapi_renters` CHANGE  `HomePhoneNumber`  `HomePhoneNumber` varchar( 50 ) NOT NULL ;";

$sql['1.1.2.110']   = "ALTER TABLE  `engine4_smartmoveapi_renters` CHANGE  `OfficePhoneNumber`  `OfficePhoneNumber` varchar( 50 ) NOT NULL ;";

$sql['1.1.2.111']   = "ALTER TABLE  `engine4_smartmoveapi_renters` CHANGE  `OfficePhoneExtension`  `OfficePhoneExtension` varchar( 11 ) NOT NULL ;";

$sql['1.1.2.112']   = "ALTER TABLE  `engine4_smartmoveapi_renters` CHANGE  `MobilePhoneNumber`  `MobilePhoneNumber` varchar( 50 ) NOT NULL ;";

$sql['1.1.2.113']   = "ALTER TABLE  `engine4_smartmoveapi_renters` CHANGE  `SocialSecurityNumber`  `SocialSecurityNumber` varchar( 50 ) NOT NULL ;";

$sql['1.1.2.114']   = "INSERT INTO `engine4_activity_notificationtypes` (`type`, `module`, `body`, `is_request`, `handler`, `default`) VALUES ('application_request', 'user', '{item:\$subject} has sent application for the property {item:\$object:\$label}.', '0', '', '1');";

$sql['1.1.2.115']   = "INSERT INTO `engine4_activity_notificationtypes` (`type`, `module`, `body`, `is_request`, `handler`, `default`) VALUES ('application_accept', 'user', '{item:\$subject} has accepted your application for the property {item:\$object:\$label}.', '0', '', '1');";

$sql['1.1.2.116']   = "INSERT INTO `engine4_activity_notificationtypes` (`type`, `module`, `body`, `is_request`, `handler`, `default`) VALUES ('application_reject', 'user', '{item:\$subject} has rejected your application for the property {item:\$object:\$label}.', '0', '', '1');";

$sql['1.1.2.117']   = "ALTER TABLE  `engine4_property_request` ADD  `personal_reference_json` varchar(5000) NOT NULL AFTER  `personal_references_pno` ;";

$sql['1.1.2.118']   = "ALTER TABLE  `engine4_rental_application` ADD  `personal_reference_json` varchar(5000) NOT NULL AFTER  `personal_references_pno` ;";

$sql['1.1.2.119']   = "INSERT INTO `engine4_activity_notificationtypes` (`type`, `module`, `body`, `is_request`, `handler`, `default`) VALUES ('report_request', 'user', '{item:\$subject} has requested  a report for the property {item:\$object:\$label}.', '0', '', '1');";

$sql['1.1.2.120'] = "CREATE TABLE IF NOT EXISTS `engine4_smartmoveapi_report` (
                  `id` int(11) NOT NULL AUTO_INCREMENT,
                  `SmartmoveApplicationId` int(11) NOT NULL,
                  `RenterId` int(11) NOT NULL,
                  `LandlordId` int(11) NOT NULL,
                  `isReportRequest` int(11) NOT NULL,
                  `reportResponse` varchar(50000) NOT NULL,
                  `isPaid` int(11) NOT NULL,
                  `created_at` varchar(50) NOT NULL,
                  `updated_at` varchar(50) NOT NULL,
                  PRIMARY KEY (`id`)
                ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1";

$sql['1.1.2.121'] = "CREATE TABLE IF NOT EXISTS `engine4_smartmoveapireport_payment` (
                  `id` int(11) NOT NULL AUTO_INCREMENT,
                  `SmartmoveApplicationId` int(11) NOT NULL,
                  `paidUserId` int(11) NOT NULL,
                  `paymentAmount` varchar(100) NOT NULL,
                  `paymentResponse` varchar(10000) NOT NULL,
                  `created_at` varchar(50) NOT NULL,
                  `updated_at` varchar(50) NOT NULL,
                  PRIMARY KEY (`id`)
                ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1";

$sql['1.1.2.122']   = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'core_admin_main_manage_stripe', 'user', 'Manage Stripe', '', '{\"route\":\"admin_default\",\"module\":\"user\",
                   \"controller\":\"manage\",\"action\":\"stripe\"}', 'core_admin_main_manage', NULL, '1', '0', '999');";


$sql['1.1.2.123'] = "CREATE TABLE IF NOT EXISTS `engine4_payment_settings` (
                  `id` int(11) NOT NULL AUTO_INCREMENT,
                  `interval` int(11) NOT NULL,
                  `amount` varchar(50) NOT NULL,
                  `created_at` varchar(50) NOT NULL,
                  `updated_at` varchar(50) NOT NULL,
                  PRIMARY KEY (`id`)
                ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1";

$sql['1.1.4.11'] = "ALTER TABLE `engine4_property_request`
                    ADD `application_view_status` int(11) NOT NULL AFTER `personal_reference_json`;";

$sql['1.1.4.12']    = "INSERT INTO `engine4_activity_notificationtypes` (`type`, `module`, `body`, `is_request`, `handler`, `default`) VALUES ('application_review', 'user', '{item:\$subject} Your application has been under review {item:\$object:\$label}.', '0', '', '1');";

$sql['1.1.4.13']    = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'core_admin_main_manage_tips', 'user', 'Manage Tips', '', '{\"route\":\"admin_default\",\"module\":\"user\",
                   \"controller\":\"manage\",\"action\":\"tiplist\"}', 'core_admin_main_manage', NULL, '1', '0', '999');";

$sql['1.1.4.14']    = "CREATE TABLE IF NOT EXISTS `engine4_tips` (
                      `id` int(11) NOT NULL AUTO_INCREMENT,
                      `type` varchar(100) NOT NULL,
                      `content` varchar(500) NOT NULL,
                      `created_at` varchar(50) NOT NULL,
                      `updated_at` varchar(50) NOT NULL,
                      PRIMARY KEY (`id`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 " ;

$sql['1.1.4.15']    = "CREATE TABLE IF NOT EXISTS `engine4_common_settings` (
                      `id` int(11) NOT NULL AUTO_INCREMENT,
                      `type` varchar(100) NOT NULL,
                      `value` varchar(500) NOT NULL,
                      `created_at` varchar(50) NOT NULL,
                      `updated_at` varchar(50) NOT NULL,
                      PRIMARY KEY (`id`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 " ;

$sql['1.1.4.16']    = "ALTER TABLE  `engine4_users` ADD  `tip_dismiss_time` varchar(100) NOT NULL AFTER  `creditscore_view_status` ;";


$sql['1.1.2.125']   = "INSERT INTO `engine4_activity_notificationtypes` (`type`, `module`, `body`, `is_request`, `handler`, `default`) VALUES ('meeting_scheduler', 'user', '{item:\$subject} has scheduled meeting with {item:\$object}.', '0', '', '1');";

$sql['1.1.2.126']   = "CREATE TABLE IF NOT EXISTS `engine4_meeting_scheduler` (
                      `id` int(11) NOT NULL AUTO_INCREMENT,
                      `scheduled_by` int(11) NOT NULL,
                      `scheduled_with` int(11) NOT NULL,
                      `scheduled_date` varchar(100) NOT NULL,
                      `scheduled_time` varchar(100) NOT NULL,
                      `approved` int(11) NOT NULL,
                      `created_at` varchar(50) NOT NULL,
                      `updated_at` varchar(50) NOT NULL,
                      PRIMARY KEY (`id`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 " ;

$sql['1.1.4.17']    = "ALTER TABLE  `engine4_smartmoveapi_property` ADD  `landlordData` varchar(5000) NOT NULL AFTER  `UnitNumber` ;";

$sql['1.1.2.127']   = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'user_index_propertyrequirement', 'user', 'Add Property Requirement', 'User_Plugin_Menus', '', 'user_home', NULL, '1', '0', '999');";

$sql['1.1.2.128']   = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'user_profile_propertyrequirement', 'user', 'Add Property Requirement', 'User_Plugin_Menus', '', 'user_profile', NULL, '1', '0', '10');";

$sql['1.1.2.129']   = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'core_main_addproperty', 'user', 'Add Property', 'User_Plugin_Menus', '', 'core_main', NULL, '1', '0', '6');";

$sql['1.1.4.18']    = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'core_mini_edit_profile', 'user', 'Edit Profile', 'User_Plugin_Menus', '', 'core_mini', NULL, '1', '0', '6');";

$sql['1.1.2.130']   = "CREATE TABLE IF NOT EXISTS `engine4_feedpreference_unit` (
                      `id` int(11) NOT NULL AUTO_INCREMENT,
                      `userid` int(11) NOT NULL,
                      `housing_type` varchar(100) NOT NULL,
                      `is_petsallowd` varchar(50) NOT NULL,
                      `pets_type` varchar(50) NOT NULL,
                      `price` varchar(50) NOT NULL,
                      `created_at` varchar(50) NOT NULL,
                      `updated_at` varchar(50) NOT NULL,
                      PRIMARY KEY (`id`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 " ;

$sql['1.1.4.19']    = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'core_mini_gallery', 'user', 'Gallery', 'User_Plugin_Menus', '', 'core_mini', NULL, '1', '0', '6');";

$sql['1.1.4.20']    = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'core_admin_main_manage_survey_questions', 'user', 'Manage Survey Questions', '', '{\"route\":\"admin_default\",\"module\":\"user\",
                     \"controller\":\"manage\",\"action\":\"surveyquestions\"}', 'core_admin_main_manage', NULL, '1', '0', '999');";

$sql['1.1.4.21']    = "CREATE TABLE IF NOT EXISTS `engine4_survey_questions` (
                      `id` int(11) NOT NULL AUTO_INCREMENT,
                      `questions` varchar(500) NOT NULL,
                      `created_at` varchar(50) NOT NULL,
                      `updated_at` varchar(50) NOT NULL,
                      PRIMARY KEY (`id`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 " ;

$sql['1.1.2.131']    = "ALTER TABLE  `engine4_feedpreference_unit` ADD  `number_of_rooms` int(11) NOT NULL AFTER  `price` ;";

$sql['1.1.4.22']    = "UPDATE  `engine4_core_pages` SET  `layout` =  'landing_page' WHERE  `engine4_core_pages`.`name` =  'core_index_index';";

$sql['1.1.4.23']    = "INSERT INTO `engine4_common_settings` (`type`, `value`, `created_at`, `updated_at`) VALUES ('survey_mail_remainder', '2', '2017-03-24', '2017-03-24');";

$sql['1.1.4.24']    = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'core_admin_main_landlords', 'user', 'Landlords', '', '{\"route\":\"admin_default\",\"module\":\"user\",
                   \"controller\":\"manage\",\"action\":\"landlords\"}', 'core_admin_main_manage', NULL, '1', '0', '999');";

$sql['1.1.2.132']   = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'core_main_documents', 'user', 'Documents', 'User_Plugin_Menus', '', 'core_main', NULL, '1', '0', '6');";


$sql['1.1.2.133']   = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'core_main_posttoscout', 'user', 'Post to Scout', 'User_Plugin_Menus', '', 'core_main', NULL, '1', '0', '6');";



$sql['1.1.4.25'] = "ALTER TABLE `engine4_property_list`
                    ADD `vouchers` varchar(50) NOT NULL AFTER `rental_type`,
                    ADD `wheelchair_accessible` varchar(50) NOT NULL AFTER `vouchers`,
                    ADD `months_of_deposits` int(11) NOT NULL AFTER `wheelchair_accessible`,
                    ADD `property_manager` varchar(50) NOT NULL AFTER `months_of_deposits`,
                    ADD `provide_parking` varchar(50) NOT NULL AFTER `property_manager`;";

$sql['1.1.4.26'] = "ALTER TABLE `engine4_property_requirement`
                    ADD `vouchers` varchar(50) NOT NULL AFTER `rental_type`,
                    ADD `wheelchair_accessible` varchar(50) NOT NULL AFTER `vouchers`,
                    ADD `provide_parking` varchar(50) NOT NULL AFTER `wheelchair_accessible`;";

$sql['1.1.4.134']   = "UPDATE  `engine4_core_pages` SET  `name` =  'user_profile_updates' WHERE  `engine4_core_pages`.`displayname` =  'Profile Updates';";


$sql['1.1.2.134']   = "CREATE TABLE IF NOT EXISTS `engine4_photo_gallery` (
                      `id` int(11) NOT NULL AUTO_INCREMENT,
                      `user_id` int(11) NOT NULL,
                      `photo_title` varchar(150) NOT NULL,
                      `path` varchar(500) NOT NULL,
                      `created_at` varchar(50) NOT NULL,
                      `updated_at` varchar(50) NOT NULL,
                      PRIMARY KEY (`id`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 " ;


$sql['1.1.2.135']    = "ALTER TABLE  `engine4_meeting_scheduler` ADD  `survey_notification_status` int(11) NOT NULL AFTER  `approved` ;";


$sql['1.1.2.136']   = "CREATE TABLE IF NOT EXISTS `engine4_surveyquestions_response` (
                      `id` int(11) NOT NULL AUTO_INCREMENT,
                      `scheduler_id` int(11) NOT NULL,
                      `survey_question_id` int(11) NOT NULL,
                      `respondent_id` int(11) NOT NULL,
                      `response` varchar(100) NOT NULL,
                      `created_at` varchar(50) NOT NULL,
                      `updated_at` varchar(50) NOT NULL,
                      PRIMARY KEY (`id`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 " ;



$sql['1.1.4.27']    = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'core_admin_main_renters', 'user', 'Renters', '', '{\"route\":\"admin_default\",\"module\":\"user\",
                   \"controller\":\"manage\",\"action\":\"renters\"}', 'core_admin_main_manage', NULL, '1', '0', '999');";

$sql['1.1.2.137']    = "ALTER TABLE  `engine4_meeting_scheduler` ADD  `survey_notification_later` varchar(50) NOT NULL AFTER  `survey_notification_status` ;";


$sql['1.1.2.138']   = "INSERT INTO `engine4_activity_notificationtypes` (`type`, `module`, `body`, `is_request`, `handler`, `default`) VALUES ('scheduled_appoinment_remainder', 'user', '{item:\$subject} has scheduled meeting with {item:\$object}.', '0', '', '1');";

$sql['1.1.2.139']   = "INSERT INTO `engine4_activity_notificationtypes` (`type`, `module`, `body`, `is_request`, `handler`, `default`) VALUES ('survey_notification', 'user', '{item:\$subject} has initiate survey with you {item:\$object}.', '0', '', '1');";


$sql['1.1.2.140']   = "CREATE TABLE IF NOT EXISTS `engine4_surveyquestions_answeroptions` (
                      `id` int(11) NOT NULL AUTO_INCREMENT,
                      `survey_question_id` int(11) NOT NULL,
                      `option` varchar(500) NOT NULL,
                      `created_at` varchar(50) NOT NULL,
                      `updated_at` varchar(50) NOT NULL,
                      PRIMARY KEY (`id`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 " ;

$sql['1.1.2.141']    = "ALTER TABLE  `engine4_survey_questions` ADD  `profile_type` int(11) NOT NULL AFTER  `id` ;";

$sql['1.1.2.142']    = "ALTER TABLE  `engine4_meeting_scheduler` CHANGE  `survey_notification_status`  `survey_notification_status` VARCHAR(100) NOT NULL   ;";

$sql['1.1.2.143']   = "CREATE TABLE IF NOT EXISTS `engine4_like_user` (
                      `id` int(11) NOT NULL AUTO_INCREMENT,
                      `subject_id` int(11) NOT NULL,
                      `object_id` int(11) NOT NULL,
                      `created_at` varchar(50) NOT NULL,
                      `updated_at` varchar(50) NOT NULL,
                      PRIMARY KEY (`id`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 " ;

$sql['1.1.2.144']   = "CREATE TABLE IF NOT EXISTS `engine4_payment_package` (
                      `id` int(11) NOT NULL AUTO_INCREMENT,
                      `user_id` int(11) NOT NULL,
                      `package_name` varchar(50) NOT NULL,
                      `package_rate` varchar(50) NOT NULL,
                      `transunion_score_rate` varchar(50) NOT NULL,
                      `score` int(11) NOT NULL,
                      `active` int(11) NOT NULL,
                      `created_at` varchar(50) NOT NULL,
                      `updated_at` varchar(50) NOT NULL,
                      PRIMARY KEY (`id`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 " ;


$sql['1.1.2.145']   = "CREATE TABLE IF NOT EXISTS `engine4_report_share` (
                      `id` int(11) NOT NULL AUTO_INCREMENT,
                      `report_shared_by` int(11) NOT NULL,
                      `report_shared_with` int(11) NOT NULL,
                      `report_id` int(11) NOT NULL,
                      `status` varchar(50) NOT NULL,
                      `created_at` varchar(50) NOT NULL,
                      `updated_at` varchar(50) NOT NULL,
                      PRIMARY KEY (`id`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 " ;

$sql['1.1.2.146']   = "CREATE TABLE IF NOT EXISTS `engine4_report_request` (
                      `id` int(11) NOT NULL AUTO_INCREMENT,
                      `renter_id` int(11) NOT NULL,
                      `landlord_id` int(11) NOT NULL,
                      `SmartmoveApplicationId` int(11) NOT NULL,
                      `status` varchar(50) NOT NULL,
                      `expiry_date` varchar(50) NOT NULL,
                      `requested_date` varchar(50) NOT NULL,
                      `created_at` varchar(50) NOT NULL,
                      `updated_at` varchar(50) NOT NULL,
                      PRIMARY KEY (`id`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 " ;


$sql['1.1.2.147']    = "ALTER TABLE  `engine4_smartmoveapi_report` ADD  `status` varchar(50) NOT NULL AFTER  `reportResponse` ;";

$sql['1.1.2.148']    = "ALTER TABLE  `engine4_smartmoveapi_report` ADD  `expiry_date` varchar(50) NOT NULL AFTER  `status` ;";

$sql['1.1.2.149']    = "ALTER TABLE  `engine4_smartmoveapi_report` ADD  `created_date` varchar(50) NOT NULL AFTER  `expiry_date` ;";

$sql['1.1.2.150']   = "CREATE TABLE IF NOT EXISTS `engine4_report_share` (
                      `id` int(11) NOT NULL AUTO_INCREMENT,
                      `report_shared_by` int(11) NOT NULL,
                      `report_shared_with` int(11) NOT NULL,
                      `report_id` int(11) NOT NULL,
                      `status` varchar(50) NOT NULL,
                      `created_at` varchar(50) NOT NULL,
                      `updated_at` varchar(50) NOT NULL,
                      PRIMARY KEY (`id`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 " ;


$sql['1.1.2.151']    = "ALTER TABLE  `engine4_payment_package` ADD  `paymentResponse` varchar(5000) NOT NULL AFTER  `active` ;";

$sql['1.1.2.152']    = "ALTER TABLE  `engine4_payment_package` ADD  `expiry_date` varchar(50) NOT NULL AFTER  `paymentResponse` ;";

$sql['1.1.2.153']    = "ALTER TABLE  `engine4_payment_package` ADD  `payment_date` varchar(50) NOT NULL AFTER  `expiry_date` ;";



$sql['1.1.2.154']   = "INSERT INTO `engine4_activity_notificationtypes` (`type`, `module`, `body`, `is_request`, `handler`, `default`) VALUES ('share_report', 'user', '{item:\$subject} has shared report {item:\$object:\$label}.', '0', '', '1');";

$sql['1.1.2.155']    = "ALTER TABLE  `engine4_payment_settings` ADD  `type` varchar(200) NOT NULL AFTER  `id` ;";

$sql['1.1.2.156']    = "ALTER TABLE  `engine4_payment_settings` ADD  `value` varchar(200) NOT NULL AFTER  `type` ;";

$sql['1.1.2.157']    = "ALTER TABLE  `engine4_payment_settings` ADD  `payment_duration` varchar(200) NOT NULL AFTER  `id` ;";

$sql['1.1.2.158']    = "ALTER TABLE  `engine4_payment_settings` ADD  `credit_and_background_payment_amount` varchar(50) NOT NULL AFTER  `payment_duration` ;";

$sql['1.1.2.159']    = "ALTER TABLE  `engine4_payment_settings` ADD  `creditbackground_eviction_payment_amount` varchar(50) NOT NULL AFTER  `credit_and_background_payment_amount` ;";

$sql['1.1.2.160']    = "ALTER TABLE  `engine4_payment_settings` ADD  `creditscore_payment_amount` varchar(50) NOT NULL AFTER  `creditbackground_eviction_payment_amount` ;";

$sql['1.1.2.161']    = "ALTER TABLE  `engine4_payment_settings` ADD  `deduction_per_each_payment` varchar(50) NOT NULL AFTER  `creditscore_payment_amount` ;";

$sql['1.1.2.162']    = "ALTER TABLE  `engine4_feedpreference_unit` ADD  `countryId` int(11) NOT NULL AFTER  `number_of_rooms` ;";

$sql['1.1.2.163']    = "ALTER TABLE  `engine4_feedpreference_unit` ADD  `stateId` int(11) NOT NULL AFTER  `countryId` ;";


$sql['1.1.2.164']    = "ALTER TABLE  `engine4_feedpreference_unit` ADD  `cityId` int(11) NOT NULL AFTER  `stateId` ;";

$sql['1.1.2.165']   = "CREATE TABLE IF NOT EXISTS `engine4_article_comments` (
                      `commentId` int(11) NOT NULL AUTO_INCREMENT,
                      `articleId` int(11) NOT NULL,
                      `posterId` int(11) NOT NULL,
                      `body` text NOT NULL,
                      `created_at` varchar(50) NOT NULL,
                      `updated_at` varchar(50) NOT NULL,
                      PRIMARY KEY (`commentId`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 " ;

$sql['1.1.2.166']   = "CREATE TABLE IF NOT EXISTS `engine4_article_likes` (
                      `id` int(11) NOT NULL AUTO_INCREMENT,
                      `articleId` int(11) NOT NULL,
                      `likedBy` int(11) NOT NULL,
                      `created_at` varchar(50) NOT NULL,
                      `updated_at` varchar(50) NOT NULL,
                      PRIMARY KEY (`id`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 " ;

$sql['1.1.4.28']    = "ALTER TABLE  `engine4_feedpreference_unit` ADD  `zip` int(11) NOT NULL AFTER  `cityId` ;";

$sql['1.1.4.29']    = "ALTER TABLE  `engine4_like_user` ADD  `type` varchar(20) NOT NULL AFTER  `object_id` ;";

$sql['1.1.4.30']    = "ALTER TABLE  `engine4_property_request` ADD  `status` varchar(50) NOT NULL AFTER  `tenant_id` ;";

$sql['1.1.4.31']    = "CREATE TABLE IF NOT EXISTS `engine4_post_comments` (
                      `commentId` int(11) NOT NULL AUTO_INCREMENT,
                      `type` varchar(50) NOT NULL,
                      `actionId` int(11) NOT NULL,
                      `posterId` int(11) NOT NULL,
                      `body` text NOT NULL,
                      `created_at` varchar(50) NOT NULL,
                      `updated_at` varchar(50) NOT NULL,
                      PRIMARY KEY (`commentId`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 " ;


$sql['1.1.2.164']    = "ALTER TABLE  `engine4_feedpreference_unit` ADD  `cityId` int(11) NOT NULL AFTER  `stateId` ;";

$sql['1.1.2.165']   = "CREATE TABLE IF NOT EXISTS `engine4_article_comments` (
                      `commentId` int(11) NOT NULL AUTO_INCREMENT,
                      `articleId` int(11) NOT NULL,
                      `posterId` int(11) NOT NULL,
                      `body` text NOT NULL,
                      `created_at` varchar(50) NOT NULL,
                      `updated_at` varchar(50) NOT NULL,
                      PRIMARY KEY (`commentId`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 " ;

$sql['1.1.2.166']   = "CREATE TABLE IF NOT EXISTS `engine4_article_likes` (
                      `id` int(11) NOT NULL AUTO_INCREMENT,
                      `articleId` int(11) NOT NULL,
                      `likedBy` int(11) NOT NULL,
                      `created_at` varchar(50) NOT NULL,
                      `updated_at` varchar(50) NOT NULL,
                      PRIMARY KEY (`id`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 " ;

$sql['1.1.4.28']    = "ALTER TABLE  `engine4_feedpreference_unit` ADD  `zip` int(11) NOT NULL AFTER  `cityId` ;";

$sql['1.1.4.29']    = "ALTER TABLE  `engine4_like_user` ADD  `type` varchar(20) NOT NULL AFTER  `object_id` ;";

$sql['1.1.4.30']    = "ALTER TABLE  `engine4_property_request` ADD  `status` varchar(50) NOT NULL AFTER  `tenant_id` ;";

$sql['1.1.4.167']    = "ALTER TABLE  `engine4_payment_package` ADD  `cardholder_name` varchar(100) NOT NULL AFTER  `user_id` ;";

$sql['1.1.4.168']    = "ALTER TABLE  `engine4_payment_package` ADD  `billing_address` varchar(100) NOT NULL AFTER  `cardholder_name` ;";

$sql['1.1.2.167']    = "ALTER TABLE  `engine4_feedpreference_unit` ADD  `countryName` varchar(50) NOT NULL AFTER  `number_of_rooms` ;";

$sql['1.1.2.168']    = "ALTER TABLE  `engine4_feedpreference_unit` ADD  `stateName` varchar(50) NOT NULL AFTER  `countryName` ;";

$sql['1.1.2.169']    = "ALTER TABLE  `engine4_feedpreference_unit` ADD  `cityName` varchar(50) NOT NULL AFTER  `stateName` ;";

$sql['1.1.2.170']    = "ALTER TABLE  `engine4_feedpreference_unit` CHANGE  `zip`  `zip` VARCHAR( 50 ) NOT NULL ;";

$sql['1.1.4.32']     = "CREATE TABLE IF NOT EXISTS `engine4_property_neighborhood` (
					  `neighborhood_id` int(11) NOT NULL AUTO_INCREMENT,
					  `county_id` int(11) NOT NULL,
					  `city_id` int(11) NOT NULL,
					  `neighborhood` varchar(50) NOT NULL,
					   PRIMARY KEY (`neighborhood_id`)
				      ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1";
                
$sql['1.1.4.33']     = "CREATE TABLE IF NOT EXISTS `engine4_property_county` (
					  `county_id` int(11) NOT NULL AUTO_INCREMENT,
					  `city_id` int(11) NOT NULL,
					  `county` varchar(50) NOT NULL,
					   PRIMARY KEY (`county_id`)
					   ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1";
					
$sql['1.1.4.34']     = "ALTER TABLE `engine4_property_list`
						ADD `prty_county` varchar(100) NOT NULL AFTER `prty_city_id`,
						ADD `prty_neighborhood` varchar(100) NOT NULL AFTER `prty_county`;";
						
$sql['1.1.4.35']     = "ALTER TABLE `engine4_property_requirement`
						ADD `county` varchar(100) AFTER `city_id`,
						ADD `neighborhood` varchar(100) AFTER `county`;";

$sql['1.1.4.36']    = "ALTER TABLE  `engine4_property_list` CHANGE  `zipcode`  `zip` VARCHAR( 50 ) NOT NULL ;";

$sql['1.1.4.37']    = "ALTER TABLE  `engine4_property_requirement` CHANGE  `zipcode`  `zip` VARCHAR( 50 ) NOT NULL ;";

$sql['1.1.4.38']    = "ALTER TABLE  `engine4_feedpreference_unit` 
                       ADD `countyName` varchar(100) AFTER `cityName`,
					   ADD `neighborhoodName` varchar(100) AFTER `countyName`;";
					   					
$sql['1.1.4.39']     = "ALTER TABLE `engine4_users`
						ADD `prefered_county` varchar(100) AFTER `prefered_location`,
						ADD `prefered_neighborhood` varchar(100) AFTER `prefered_county`;";
						
$sql['1.1.4.40']    = "ALTER TABLE  `engine4_property_requirement`
                       ADD `description` varchar(5000) AFTER `zip`;";
                       
$sql['1.1.2.171']     = "ALTER TABLE `engine4_users`
						ADD `prefered_zipcode` varchar(50) AFTER `prefered_neighborhood`;";
						                    
$sql['1.1.4.41']    = "ALTER TABLE  `engine4_payment_package`
                       ADD `last_name` varchar(50) AFTER `cardholder_name`,
                       ADD `street` varchar(100) AFTER `last_name`,
                       ADD `city` varchar(100) AFTER `street`,
                       ADD `state` varchar(50) AFTER `city`,
                       ADD `zipcode` int(11) AFTER `state`;";

$sql['1.1.4.42']     = "CREATE TABLE IF NOT EXISTS `engine4_price` (
					  `id` int(11) NOT NULL AUTO_INCREMENT,
					  `price_from` int(11) NOT NULL,
					  `price_to` int(11) NOT NULL,
					  `created_at` varchar(50) NOT NULL,
                      `updated_at` varchar(50) NOT NULL,
                       PRIMARY KEY (`id`)
                      ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 " ;                 
                       
$sql['1.1.4.43']    = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'core_admin_main_manage_price', 'user', 'Manage Price', '', '{\"route\":\"admin_default\",\"module\":\"user\",
                   \"controller\":\"manage\",\"action\":\"pricelist\"}', 'core_admin_main_manage', NULL, '1', '0', '999');";

$sql['1.1.2.172']     = "ALTER TABLE `engine4_users`
						ADD `call_status` BOOLEAN AFTER `status_date`;";

$sql['1.1.2.173']     = "ALTER TABLE `engine4_property_list`
						ADD `property_type`  varchar(50) NOT NULL AFTER `id`;";
						
$sql['1.1.2.174']     = "ALTER TABLE `engine4_smartmoveapi_application`
						ADD `application_type`  varchar(50) NOT NULL AFTER `id`;";
						
$sql['1.1.2.175']    = "ALTER TABLE  `engine4_smartmoveapi_property`
                       ADD `Deposit` varchar(50) AFTER `UnitNumber`,
                       ADD `Rent` varchar(100) AFTER `Deposit`,
                       ADD `LeaseTermInMonths` int(11) AFTER `Rent`,
                       ADD `LandlordPays` varchar(50) AFTER `LeaseTermInMonths`,
                       ADD `ProductBundle` varchar(50) AFTER `LandlordPays`;";	

$sql['1.1.4.45']    = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'core_admin_main_manage_advertisement', 'user', 'Manage Advertisement', '', '{\"route\":\"admin_default\",\"module\":\"user\",
                   \"controller\":\"manage\",\"action\":\"advertisements\"}', 'core_admin_main_manage', NULL, '1', '0', '999');";

$sql['1.1.4.46']    = "CREATE TABLE IF NOT EXISTS `engine4_advertisement` (
                      `id` int(11) NOT NULL AUTO_INCREMENT,
                      `user_id` int(11) NOT NULL,
                      `title` varchar(100) NOT NULL,
                      `image` varchar(500) NOT NULL,
                      `created_at` varchar(50) NOT NULL,
                      `updated_at` varchar(50) NOT NULL,
                      PRIMARY KEY (`id`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 " ;					
                       
$sql['1.1.2.176']   = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'core_admin_main_manage_userpackage', 'user', 'Manage User Package', '', '{\"route\":\"admin_default\",\"module\":\"user\",
                   \"controller\":\"manage\",\"action\":\"userpackage\"}', 'core_admin_main_manage', NULL, '1', '0', '999');";       

$sql['1.1.2.177']  = "INSERT  INTO `engine4_core_settings` (`name`, `value`) VALUES
						('user.landlordProPrice', '10'),
						('user.managementGoldPrice', '10'); ";    
						
$sql['1.1.2.178']     = "CREATE TABLE IF NOT EXISTS `engine4_user_packages` (
					  `payment_id` int(11) NOT NULL AUTO_INCREMENT,
					  `user_id` int(11) NOT NULL,
					  `first_name` varchar(100) NOT NULL,
					  `last_name` varchar(100) NOT NULL,
					  `street` varchar(100) NOT NULL,
					  `city` varchar(100) NOT NULL,
					  `state` varchar(100) NOT NULL,
					  `zipcode` varchar(50) NOT NULL,					  
					  `package_type` varchar(50) NOT NULL,
					  `payment_amount` varchar(50) NOT NULL,
					  `payment_response` TEXT NOT NULL,
					  `created_at` varchar(50) NOT NULL,
                      `updated_at` varchar(50) NOT NULL,
                       PRIMARY KEY (`payment_id`)
                      ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 " ;  
                      
$sql['1.1.4.47']  = "INSERT  INTO `engine4_core_settings` (`name`, `value`) VALUES
						('user.videoPrice', '10'); ";  
												
$sql['1.1.4.48']     = "CREATE TABLE IF NOT EXISTS `engine4_payment_video` (
					  `payment_id` int(11) NOT NULL AUTO_INCREMENT,
					  `user_id` int(11) NOT NULL,
					  `first_name` varchar(100) NOT NULL,
					  `last_name` varchar(100) NOT NULL,
					  `street` varchar(100) NOT NULL,
					  `city` varchar(100) NOT NULL,
					  `state` varchar(100) NOT NULL,
					  `zipcode` varchar(50) NOT NULL,					  
					  `payment_amount` varchar(50) NOT NULL,
					  `payment_response` TEXT NOT NULL,
					  `created_at` varchar(50) NOT NULL,
                      `updated_at` varchar(50) NOT NULL,
                       PRIMARY KEY (`payment_id`)
                      ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 " ;   
$sql['1.1.2.179']  = "INSERT  INTO `engine4_core_settings` (`name`, `value`) VALUES
						('user.premiumLevelProvision', '2'); ";   
						                                                 					
$sql['1.1.2.180']  = "INSERT  INTO `engine4_core_settings` (`name`, `value`) VALUES
						('user.basicScoutLimit', '1'),                                                 					
						('user.landlordProScoutLimit', '10'),                                                 					
						('user.basicPropertyLimit', '1'),                                                 					                                               					
						('user.landlordProPropertyLimit', '10'); ";     
$sql['1.1.2.181']   = "INSERT INTO `engine4_activity_notificationtypes` (`type`, `module`, `body`, `is_request`, `handler`, `default`) VALUES ('approve_scheduler', 'user', '{item:\$subject} has approved your meeting request {item:\$object}.', '0', '', '1');";

$sql['1.1.2.182']   = "INSERT INTO `engine4_activity_notificationtypes` (`type`, `module`, `body`, `is_request`, `handler`, `default`) VALUES ('decline_meeting', 'user', '{item:\$subject} has declined your meeting request {item:\$object}.', '0', '', '1');";

$sql['1.1.2.183']   = "ALTER TABLE `engine4_feedpreference_unit`
						ADD `price_to` varchar(50) NOT NULL AFTER `price`;"; 
						
$sql['1.1.2.184'] 	= "UPDATE `engine4_property_requirement` SET  `budget_range_to` =  '0' WHERE `budget_range_to` ='';";

$sql['1.1.2.185']   = "ALTER TABLE `engine4_feedpreference_unit`
						ADD `scout_name`  TEXT NOT NULL AFTER `userid`;";	
						
$sql['1.1.2.186'] 	= "UPDATE `engine4_core_menuitems` SET  `enabled` =  '0' WHERE `name` ='user_edit_locationpreference';";						

$sql['1.1.4.49']    = "ALTER TABLE `engine4_advertisement`
						ADD `ad_url` varchar(300) NOT NULL AFTER `title`;"; 	
						
$sql['1.1.2.187']   = "INSERT INTO `engine4_activity_notificationtypes` (`type`, `module`, `body`, `is_request`, `handler`, `default`) VALUES ('property_granted', 'user', '{item:\$subject} has granted property {item:\$object:\$label}.', '0', '', '1');";

$sql['1.1.4.50']    = "ALTER TABLE `engine4_meeting_scheduler`
					   ADD `sheduledby_usertype` varchar(50) NOT NULL AFTER `scheduled_with`,	
					   ADD `property_id` int(11) NOT NULL AFTER `sheduledby_usertype`;"; 	

$sql['1.1.4.51']   = "INSERT INTO `engine4_activity_notificationtypes` (`type`, `module`, `body`, `is_request`, `handler`, `default`) VALUES ('meeting_request', 'user', '{item:\$subject} has requested a meeting {item:\$object}.', '0', '', '1');";
	
$sql['1.1.4.52']    = "ALTER TABLE `engine4_advertisement`
						ADD `date_from` varchar(50) NOT NULL AFTER `ad_url`,																	                                              					
						ADD `date_to` varchar(50) NOT NULL AFTER `date_from`;"; 																		                                              					
$sql['1.1.2.188']    = "ALTER TABLE  `engine4_meeting_scheduler` CHANGE  `approved`  `approved` VARCHAR( 50 ) NOT NULL ;"; 		

$sql['1.1.2.189']    = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'core_mini_support', 'user', 'Support', 'User_Plugin_Menus', '', 'core_mini', NULL, '1', '0', '6');";
		
$sql['1.1.2.190']    = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'core_main_scheduleviewing', 'user', 'Schedule a viewing', 'User_Plugin_Menus', '', 'core_main', NULL, '1', '0', '6');";

$sql['1.1.2.191']   = "INSERT INTO `engine4_core_menuitems` (`id`, `name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `enabled`, `custom`, `order`) VALUES (NULL, 'core_admin_main_manage_landingpage', 'user', 'Manage Landingpage', '', '{\"route\":\"admin_default\",\"module\":\"user\",
                   \"controller\":\"manage\",\"action\":\"landingpage\"}', 'core_admin_main_manage', NULL, '1', '0', '999');"; 																                                              					

$sql['1.1.2.192']  = "INSERT  INTO `engine4_core_settings` (`name`, `value`) VALUES
						('user.landingpage', 'hi'); ";
$sql['1.1.2.193']    = "ALTER TABLE  `engine4_advancedarticles_artarticles` ADD  `landingpage_article` INT NOT NULL AFTER  `sponsored`;";
$sql['1.1.2.194']    = "ALTER TABLE  `engine4_advancedarticles_artarticles` ADD  `landingpage_articledescription` TEXT NOT NULL AFTER  `sponsored`;";
$sql['1.1.2.195']  = "INSERT  INTO `engine4_core_settings` (`name`, `value`) VALUES
						('user.featuredstory', 'welcome'); ";						
$sql['1.1.2.196']  = "INSERT  INTO `engine4_core_settings` (`name`, `value`) VALUES
						('user.FeaturedstoryImage', 'application/modules/User/externals/images/team-member-1.jpg'); ";						
$sql['1.1.2.197']  = "INSERT  INTO `engine4_core_settings` (`name`, `value`) VALUES
						('user.showLandingpageFeaturedstory', '0'); ";						
$sql['1.1.2.198']  = "INSERT  INTO `engine4_core_settings` (`name`, `value`) VALUES
						('user.showLandingpagearticlesection', '0'); ";						
$sql['1.1.2.199']  = "INSERT  INTO `engine4_core_settings` (`name`, `value`) VALUES
						('user.featuredstoryTitle', 'Featured Story'); ";						
$sql['1.1.2.200']  = "INSERT  INTO `engine4_core_settings` (`name`, `value`) VALUES
						('user.backgroundReportExpiry', '30'); ";						
$sql['1.1.2.201']  = "INSERT  INTO `engine4_core_settings` (`name`, `value`) VALUES
						('user.creditAndBackgroundPaymentAmount 	', '49.99'); ";						
$sql['1.1.2.202']  = "INSERT  INTO `engine4_core_settings` (`name`, `value`) VALUES
						('user.creditAndBackgroundPlusEvictionPaymentAmount 	', '59.99'); ";						
$sql['1.1.2.203']  = "INSERT  INTO `engine4_core_settings` (`name`, `value`) VALUES
						('user.deductionPerEachPayment 	', '5'); ";						
$sql['1.1.2.204']  = "INSERT  INTO `engine4_core_settings` (`name`, `value`) VALUES
						('user.numberOfReportSharePerDay 	', '5'); ";						
$sql['1.1.2.205']  = "INSERT  INTO `engine4_core_settings` (`name`, `value`) VALUES
						('user.creditScorePaymentAmount 	', '9.99'); ";		
$sql['1.1.2.206']   = "INSERT INTO `engine4_activity_notificationtypes` (`type`, `module`, `body`, `is_request`, `handler`, `default`) VALUES ('backgroundreport_remainder_during_lastweek', 'user', 'Only few days to expire background report', '0', '', '1');";

$sql['1.1.2.207']   = "CREATE TABLE IF NOT EXISTS `engine4_user_contact` (
                      `contactId` int(11) NOT NULL AUTO_INCREMENT,
                      `name` varchar(50) NOT NULL,
                      `email` varchar(50) NOT NULL,
                      `message` text NOT NULL,
                      `created_at` varchar(50) NOT NULL,
                      `updated_at` varchar(50) NOT NULL,
                      PRIMARY KEY (`contactId`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 " ;	
                    
$sql['1.1.2.208']     = "ALTER TABLE `engine4_user_packages`
						ADD `card_number` varchar(50) AFTER `zipcode`,
						ADD `expiration_month` int(11) AFTER `card_number`,
						ADD `expiration_year` int(11) AFTER `expiration_month`,
						ADD `cvc` varchar(20) AFTER `expiration_year`,
						ADD `status` varchar(20) AFTER `cvc`,
						ADD `expiry_date` varchar(50) AFTER `updated_at`;";   
$sql['1.1.2.209']   = "INSERT INTO `engine4_activity_notificationtypes` (`type`, `module`, `body`, `is_request`, `handler`, `default`) VALUES ('package_renewal_remainder', 'user', 'You have only few days to expire your package', '0', '', '1');";
$sql['1.1.2.210']   = "INSERT INTO `engine4_activity_notificationtypes` (`type`, `module`, `body`, `is_request`, `handler`, `default`) VALUES ('package_renewal', 'user', 'Your package has been successfully renewed', '0', '', '1');";
$sql['1.1.2.211']   =  "UPDATE `engine4_user_packages` SET `status` = 'active' WHERE `status` IS NULL;";						                 									
$sql['1.1.2.212']   = "CREATE TABLE IF NOT EXISTS `engine4_cardholder_details` (
                      `id` int(11) NOT NULL AUTO_INCREMENT,
                      `userId` int(11) NOT NULL ,
                      `first_name` varchar(50) NOT NULL,
                      `last_name` varchar(50) NOT NULL,
                      `street` text NOT NULL,
                      `city` varchar(50) NOT NULL,
                      `state` varchar(50) NOT NULL,
                      `zipcode` varchar(50) NOT NULL,
                      `card_number` varchar(50) NOT NULL,
                      `expiration_month` int(11) NOT NULL,
                      `expiration_year` int(11) NOT NULL,
                      `cvc` varchar(20) NOT NULL,
                      `updated_at` varchar(50) NOT NULL,
                      PRIMARY KEY (`id`)
                    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 " ;	
$sql['1.1.2.213']   = "INSERT INTO `engine4_activity_notificationtypes` (`type`, `module`, `body`, `is_request`, `handler`, `default`) VALUES ('comment_notification_to_renter', 'user', 'landlord  has replied to your comment on property.', '0', '', '1');";
$sql['1.1.2.214']   = "INSERT INTO `engine4_activity_notificationtypes` (`type`, `module`, `body`, `is_request`, `handler`, `default`) VALUES ('comment_notification_to_pOwner', 'user', 'Renter has commented on your property.', '0', '', '1');";
$sql['1.1.2.215']   = "INSERT  INTO `engine4_core_settings` (`name`, `value`) VALUES
						('user.enableMessagingForAllRenters', '1'); ";	  
$sql['1.1.2.216']    = "INSERT INTO `engine4_activity_notificationtypes` (`type`, `module`, `body`, `is_request`, `handler`, `default`) VALUES ('invite_renter_to_property', 'user', '{item:\$subject} has been invited to property .', '0', '', '1');";

$sql['1.1.2.217']   = "CREATE TABLE `engine4_invitedrenters_backgroundreport` (
					  `id` int(11) NOT NULL,
					  `smartmovePid` int(11) NOT NULL,
					  `pid` int(11) NOT NULL,
					  `landlord_id` int(11) NOT NULL,
					  `renter_id` int(11) NOT NULL,
					  `renter_email` varchar(50) NOT NULL,
					  `backgroundReport` int(11) NOT NULL,
					  `created_at` varchar(20) NOT NULL,
					  PRIMARY KEY (`id`)
					) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;";
					
$sql['1.1.2.218']   = "CREATE TABLE `engine4_tasks` (
						`id` int(11) NOT NULL,
						`task_created_by` int(11) NOT NULL,
						`task_created_to` int(11) NOT NULL,
						`task_info` text NOT NULL,
						`image` varchar(1000) NOT NULL,
						`video` varchar(1000) NOT NULL,
						`scheduled_date` varchar(50) NOT NULL,
						`status` varchar(50) NOT NULL,
						`notes` text NOT NULL,
						`servicer_id` int(11) NOT NULL,
						`expense` varchar(50) NOT NULL,
						`location` varchar(500) NOT NULL,
						`created_at` varchar(50) NOT NULL,
						PRIMARY KEY (`id`)
						) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;
						";

$sql['1.1.2.219']   = "INSERT INTO `engine4_activity_notificationtypes` (`type`, `module`, `body`, `is_request`, `handler`, `default`) VALUES ('task_for_maintenance', 'user', '{item:\$subject} has sent task for maintenance.', '0', '', '1');";
$sql['1.1.2.220']   = "INSERT INTO `engine4_activity_notificationtypes` (`type`, `module`, `body`, `is_request`, `handler`, `default`) VALUES ('assign_task_to_agent', 'user', '{item:\$subject} has assigned a task for you.', '0', '', '1');";
$sql['1.1.2.221']   = "INSERT INTO `engine4_activity_notificationtypes` (`type`, `module`, `body`, `is_request`, `handler`, `default`) VALUES ('scheduled_task', 'user', '{item:\$subject} has scheduled task.Please check.', '0', '', '1');";


$sql['1.1.2.222']   = "CREATE TABLE `engine4_mylinks` (
						`id` int(11) NOT NULL,
						`invited_by` int(11) NOT NULL,
						`user_id` int(11) NOT NULL,
						`link_name` text NOT NULL,
						`link_address` text NOT NULL,
						`link_profile` text NOT NULL,
						`link_message` varchar(1000) NOT NULL,
						`status` text NOT NULL,
						`created_at` varchar(50) NOT NULL,
						`updated_at` varchar(50) NOT NULL,
						PRIMARY KEY (`id`)
						) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;
						";
$sql['1.1.2.223']   = "INSERT INTO `engine4_activity_notificationtypes` (`type`, `module`, `body`, `is_request`, `handler`, `default`) VALUES ('Like_to_link', 'user', '{item:\$subject} like to link', '0', '', '1');";

										
?>


