<?php
class Ynresponsivepurity_Model_DbTable_Modules extends Engine_Db_Table
{
	protected $_rowClass = "Ynresponsivepurity_Model_Module";
	protected $_name = 'ynresponsivepurity_modules';
	
	public function getModulePaginator($params = array())
	{
		$select = $this -> getModuleSelect($params);
		return Zend_Paginator::factory($select);
	}

	public function getModuleSelect($params = array())
	{
		$tableName = $this -> info('name');
		$select = $this -> select();
		$select -> from("$tableName", array("$tableName.*"));
		$select -> order('order ASC');
		return $select;
	}
}
