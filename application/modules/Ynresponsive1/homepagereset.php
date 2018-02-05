<?php
// http:/<your-domain>/application/lite.php?module=ynresponsive1&name=homepagereset

$db = Engine_Db_Table::getDefaultAdapter();
// insert main menu
$query = "DELETE FROM `engine4_core_menuitems` where `name` = 'core_main_dashboard'";
$db -> query($query);

// get home page id
$home_page_id = $db -> select() -> from('engine4_core_pages', 'page_id') -> where('name = ?', 'user_index_home') -> limit(1) -> query() -> fetchColumn();

// delete all content of home page
$query = "DELETE FROM `engine4_core_content` where `page_id` = $home_page_id";
$db -> query($query);

$dashboard_page_id = $db -> select() -> from('engine4_core_pages', 'page_id') -> where('name = ?', 'ynresponsive1_index_dashboard') -> limit(1) -> query() -> fetchColumn();

// Add page if it does not exist
if ($dashboard_page_id) 
{
	$query = "SELECT * FROM `engine4_core_content` where `page_id` = ".$dashboard_page_id;
	$contents = $db -> fetchAll($query);
	foreach ($contents as $content) 
	{
		$query = "UPDATE `engine4_core_content` set `page_id` = " .$home_page_id. " where `content_id` = ".$content['content_id'];
		$db -> query ($query);
	}
}

// delete dashboard page
$query = "DELETE FROM `engine4_core_pages` where `page_id` = $dashboard_page_id";
$db -> query($query);

echo "Reset Successfully!"
?>