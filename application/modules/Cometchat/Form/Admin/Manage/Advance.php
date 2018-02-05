<?php

class Cometchat_Form_Admin_Manage_Advance extends Engine_Form
{
	public function init(){
		$multiOptions = array();
		foreach( Engine_Api::_()->getDbtable('levels', 'authorization')->fetchAll() as $level ) {
			$multiOptions[$level->getIdentity()] = $level->getTitle();
		}
		$per_table = Engine_Api::_()->getDbtable('permissions', 'authorization');
		$per_select = $per_table->select()
		->where('type = ?', 'cometchat')
		->where('level_id = ?', 100);
		$type = $per_table->fetchRow($per_select);
		if(empty($type)){
			$per_table->insert(
				array(
					'level_id' => 100,
					'type' => 'cometchat',
					'name' => 'cometchat',
					'value' => 1
					)
				);
			$val = 1;
		}else{
			$val = $type['value'];
		}
		$this -> setTitle('CometChat Advance Setting');
		if($val == 0){
			$this->addElement('Radio', 'inbox_sync', array(
				'label' => 'Synchronise inbox to SocialEngine ?',
				'multiOptions' => array(
					'1' => 'Yes',
					'0' => 'No',
					),
				'value' => '0',
				));
		}else{
			$this->addElement('Radio', 'inbox_sync', array(

				'label' => 'Synchronise inbox to SocialEngine ?',
				'multiOptions' => array(
					'1' => 'Yes',
					'0' => 'No',
					),
				'value' => '1',
				));

		}
		$per_table = Engine_Api::_()->getDbtable('permissions', 'authorization');
		$per_select = $per_table->select()
		->where('type = ?', 'CometChat')
		->where('name = ?','view')
		->where('value = ?',0);
		$type = $per_table->fetchAll($per_select);
		$arr = array();
		foreach($type as $key){
			array_push($arr, $key->level_id);
		}
		$this->addElement('MultiCheckbox', 'displayable', array(
			'label' => 'Hide CometChat for',
			'description' => 'Selected user groups will not see CometChat.',
			'multiOptions' => $multiOptions,
			'value'		 	=>	$arr,
			));
		$per_table = Engine_Api::_()->getDbtable('permissions', 'authorization');
		$per_select = $per_table->select()
		->where('type = ?', 'hide_cometchat')
		->where('level_id = ?', 101);
		$type = $per_table->fetchRow($per_select);
		if(empty($type)){
			$per_table->insert(
				array(
					'level_id' => 101,
					'type' => 'hide_cometchat',
					'name' => 'cometchat',
					'value' => 0
					)
				);
			$val = 0;
		}else{
			$val = $type['value'];
		}
		if($val == 0){
			$this->addElement('Radio', 'hide_bar', array(
				'label' => 'Hide CometChat bar ?',
				'multiOptions' => array(
					'1' => 'Yes',
					'0' => 'No',
					),
				'value' => '0',
				));
		}else{
			$this->addElement('Radio', 'hide_bar', array(

				'label' => 'Hide CometChat bar ?',
				'multiOptions' => array(
					'1' => 'Yes',
					'0' => 'No',
					),
				'value' => '1',
				));

		}
		$this->addElement('Button', 'submit', array(
			'label' => 'Save Changes',
			'type' => 'submit',
			'ignore' => true,
			));
	}
}