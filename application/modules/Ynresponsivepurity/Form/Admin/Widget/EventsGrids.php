<?php
class Ynresponsivepurity_Form_Admin_Widget_EventsGrids extends Engine_Form
{
	function init()
	{
		$typeOptions = array(
			'recent' => 'Recent Events',
			'upcoming' => 'Upcoming Events',
			'past' => 'Past Events',
			'most-view' => 'Most Viewed Events',
			'most-member' => 'Most Member Events'
		);
		$this -> addElement('select', 'type', array(
			'label' => 'Type',
			'required' => true,
			'multiOptions' => $typeOptions
		));

		$this -> addElement('select', 'num_events', array(
			'label' => 'Number of Events',
			'value' => 3,
			'multiOptions' => array(
				4 => '4',
				8 => '8',
				12 => '12'
			),
		));
	}

}
