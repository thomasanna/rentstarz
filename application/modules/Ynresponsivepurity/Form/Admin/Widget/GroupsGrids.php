<?php
class Ynresponsivepurity_Form_Admin_Widget_GroupsGrids extends Engine_Form
{
	function init()
	{
		$typeOptions = array(
			'recent' => 'Recent Groups',
			'most-view' => 'Most Viewed Groups',
			'most-member' => 'Most Member Groups'
		);
		$this -> addElement('select', 'type', array(
			'label' => 'Type',
			'required' => true,
			'multiOptions' => $typeOptions
		));
		
		$this -> addElement('select', 'num_groups', array(
			'label' => 'Number of Groups',
			'value' => 3,
			'multiOptions' => array(
				4 => '4',
				8 => '8',
				12 => '12'
			),
		));
	}

}
