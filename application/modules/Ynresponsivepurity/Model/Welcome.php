<?php
class Ynresponsivepurity_Model_Welcome extends Core_Model_Item_Abstract
{
	protected $_type = 'ynresponsivepurity_welcome';
	protected $_searchTriggers = FALSE;
	
	public function setPhoto($photo)
	{
		if ($photo instanceof Zend_Form_Element_File)
		{
			$file = $photo -> getFileName();
		}
		else
		if (is_array($photo) && !empty($photo['tmp_name']))
		{
			$file = $photo['tmp_name'];
		}
		else
		if (is_string($photo) && file_exists($photo))
		{
			$file = $photo;
		}
		else
		{
			throw new Ynbusinesspages_Model_Exception('invalid argument passed to setPhoto');
		}

		$name = basename($file);
		$path = APPLICATION_PATH . DIRECTORY_SEPARATOR . 'temporary';
		$params = array(
			'parent_type' => 'ynresponsivepurity_welcome',
			'parent_id' => $this -> getIdentity()
		);

		// Save
		$storage = Engine_Api::_() -> storage();
		// Image (main)
		$image = Engine_Image::factory();
		$image 	-> open($file)->autoRotate()
				-> resize(150, 150)
				-> write($path . '/m_' . $name) -> destroy();

		// Store
		$iMain = $storage -> create($path . '/m_' . $name, $params);

		// Remove temp files
		@unlink($path . '/m_' . $name);
		// Update row
		$this -> photo_id = $iMain -> file_id;
		$this -> save();

		return $this;
	}
}
