<?php
class Ynresponsivepurity_Model_DbTable_Sliders extends Engine_Db_Table
{
	protected $_rowClass = "Ynresponsivepurity_Model_Slider";
	protected $_name = 'ynresponsivepurity_sliders';
	
	public function getSliderPaginator($params = array())
	{
		$select = $this -> getSliderSelect($params);
		return Zend_Paginator::factory($select);
	}

	public function getSliderSelect($params = array())
	{
		$tableName = $this -> info('name');
		$select = $this -> select();
		$select -> from("$tableName", array("$tableName.*"));
		$select -> order('order ASC');
		return $select;
	}
}
