<?php
class Ynresponsivepurity_Model_Module extends Core_Model_Item_Abstract
{
	protected $_type = 'ynresponsivepurity_module';
	protected $_searchTriggers = FALSE;

	public function getIconURL($type = null)
	{
		if( empty($this->icon_id) ) {
			return null;
		}

		$file = Engine_Api::_()->getItemTable('storage_file')->getFile($this->icon_id, $type);
		if( !$file ) {
			return null;
		}

		return $file->map();
	}

	public function getHoverIconURL($type = null)
	{
		if( empty($this->hover_icon_id) ) {
			return null;
		}

		$file = Engine_Api::_()->getItemTable('storage_file')->getFile($this->hover_icon_id, $type);
		if( !$file ) {
			return null;
		}

		return $file->map();
	}
	
	public function setIcon($photo)
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
			throw new Ynbusinesspages_Model_Exception('invalid argument passed to setIcon');
		}

		$name = basename($file);
		$path = APPLICATION_PATH . DIRECTORY_SEPARATOR . 'temporary';
		$params = array(
			'parent_type' => 'ynresponsivepurity_module',
			'parent_id' => $this -> getIdentity()
		);

		// Save
		$storage = Engine_Api::_() -> storage();
		// Image (main)
		$image = Engine_Image::factory();
		$image -> open($file)->autoRotate()
			   ->resize(46, 46)
			   -> write($path . '/m_' . $name) -> destroy();

		// Store
		$iMain = $storage -> create($path . '/m_' . $name, $params);

		// Remove temp files
		@unlink($path . '/m_' . $name);

		// Update row
		$this -> icon_id = $iMain -> file_id;
		$this -> save();

		return $this;
	}

	public function setHoverIcon($photo)
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
					throw new Ynbusinesspages_Model_Exception('invalid argument passed to setHoverIcon');
				}

		$name = basename($file);
		$path = APPLICATION_PATH . DIRECTORY_SEPARATOR . 'temporary';
		$params = array(
			'parent_type' => 'ynresponsivepurity_module',
			'parent_id' => $this -> getIdentity()
		);

		// Save
		$storage = Engine_Api::_() -> storage();
		// Image (main)
		$image = Engine_Image::factory();
		$image 	-> open($file)->autoRotate()
				-> resize(46, 46)
				-> write($path . '/m_' . $name) -> destroy();

		// Store
		$iMain = $storage -> create($path . '/m_' . $name, $params);

		// Remove temp files
		@unlink($path . '/m_' . $name);

		// Update row
		$this -> hover_icon_id = $iMain -> file_id;
		$this -> save();

		return $this;
	}
}
