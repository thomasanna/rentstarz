<?php
// http:/<your-domain>/application/lite.php?module=ynresponsive1&name=homepagesetup

$db = Engine_Db_Table::getDefaultAdapter();

// insert main menu
$query = "INSERT IGNORE INTO `engine4_core_menuitems` (`name`, `module`, `label`, `plugin`, `params`, `menu`, `submenu`, `order`) VALUES
('core_main_dashboard', 'core', 'Dashboard', 'Ynresponsive1_Plugin_Menus', '{\"route\":\"dashboard_general\"}', 'core_main', '', 0)";
$db -> query($query);

// get home page id
$home_page_id = $db -> select() -> from('engine4_core_pages', 'page_id') -> where('name = ?', 'user_index_home') -> limit(1) -> query() -> fetchColumn();

$select = new Zend_Db_Select($db);
$select -> from('engine4_core_pages') -> where('name = ?', 'ynresponsive1_index_dashboard') -> limit(1);
$info = $select -> query() -> fetch();

// Add page if it does not exist
if (empty($info)) 
{
	// insert dashboar page
	$db -> insert('engine4_core_pages', array('name' => 'ynresponsive1_index_dashboard', 'displayname' => 'Dashboard Page', 'title' => 'Dashboard Page', 'description' => 'This is your site\'s dashboard page.', ));
	$page_id = $db -> lastInsertId('engine4_core_pages');
	
	$query = "SELECT * FROM `engine4_core_content` where `page_id` = ".$home_page_id;
	$contents = $db -> fetchAll($query);
	foreach ($contents as $content) 
	{
		$query = "UPDATE `engine4_core_content` set `page_id` = " .$page_id. " where `content_id` = ".$content['content_id'];
		$db -> query ($query);
	}
}

// update home page
$landing_page_id = $db -> select() -> from('engine4_core_pages', 'page_id') -> where('name = ?', 'core_index_index') -> limit(1) -> query() -> fetchColumn();
$query = "SELECT * FROM `engine4_core_content` where `page_id` = ".$landing_page_id . " order by `content_id` ASC";
$contents = $db -> fetchAll($query);
$content_parent = array();
$sub = 100000000;
foreach ($contents as $content) 
{
	$content['content_id'] = $content['content_id'] + $sub;
	if($content['parent_content_id'])
		$content['parent_content_id'] = $content['parent_content_id'] + $sub;
	$content['page_id'] = $home_page_id;
	try
	{
		$db -> insert ('engine4_core_content', $content);
	}
	catch(exception $e)
	{
		
	}
}
echo "Setup Successfully!"
?>