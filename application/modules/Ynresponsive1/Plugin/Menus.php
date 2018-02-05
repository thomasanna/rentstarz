<?php

class Ynresponsive1_Plugin_Menus
{
	public function onMenuInitialize_CoreMainDashboard()
	{
		$viewer = Engine_Api::_() -> user() -> getViewer();
		if (!$viewer -> getIdentity())
		{
			return false;
		}
		return true;
	}
}
