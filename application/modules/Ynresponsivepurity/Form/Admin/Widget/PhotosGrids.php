<?php
class Ynresponsivepurity_Form_Admin_Widget_PhotosGrids extends Engine_Form
{
	function init()
	{
		$typeOptions = array(
			'recent' => 'Recent Photos',
			'most-view' => 'Most Viewed Photos',
			'most-like' => 'Most Liked Photos',
			'most-comment' => 'Most Commented Photos',
			'random' => 'Random Photos'
		);
		if(Engine_Api::_() -> hasModuleBootstrap('advalbum'))
		{
			$typeOptions['featured'] = 'Featured Photos';
		}
		$this -> addElement('select', 'type', array(
			'label' => 'Type',
			'required' => true,
			'multiOptions' => $typeOptions
		));

		$this -> addElement('select', 'num_photos', array(
			'label' => 'Number of Photos',
			'value' => 4,
			'multiOptions' => array(
				4 => '4',
				8 => '8',
				12 => '12'
			),
		));
	}

}
