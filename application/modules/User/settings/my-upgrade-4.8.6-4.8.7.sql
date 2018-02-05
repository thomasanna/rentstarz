
UPDATE `engine4_activity_actiontypes` SET `commentable` = '4' WHERE `engine4_activity_actiontypes`.`type` IN ('post', 'post_self', 'profile_photo_update');

-- --------------------------------------------------------

--
-- Dumping data for table `engine4_core_menus`
--

INSERT IGNORE INTO `engine4_core_menus` (`name`, `type`, `title`) VALUES
('user_browse', 'standard', 'Member Browse Navigation Menu')
;

