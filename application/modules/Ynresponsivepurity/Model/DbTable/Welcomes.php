<?php
class Ynresponsivepurity_Model_DbTable_Welcomes extends Engine_Db_Table
{
	protected $_rowClass = "Ynresponsivepurity_Model_Welcome";
	protected $_name = 'ynresponsivepurity_welcomes';
	
	public function getWelcomePaginator($params = array())
	{
		$select = $this -> getWelcomeSelect($params);
		return Zend_Paginator::factory($select);
	}

	public function getWelcomeSelect($params = array())
	{
		$tableName = $this -> info('name');
		$select = $this -> select();
		$select -> from("$tableName", array("$tableName.*"));
		$select -> order('order ASC');
		return $select;
	}
}
