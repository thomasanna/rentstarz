<?php
class Ynresponsivepurity_Model_Slider extends Core_Model_Item_Abstract
{
	protected $_type = 'ynresponsivepurity_slider';
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
			'parent_type' => 'ynresponsivepurity_slider',
			'parent_id' => $this -> getIdentity()
		);

		// Save
		$storage = Engine_Api::_() -> storage();
		$angle = 0;
		if(function_exists('exif_read_data'))
		{
			$exif = exif_read_data($file);
			if (!empty($exif['Orientation']))
			{
				switch($exif['Orientation'])
				{
					case 8 :
						$angle = 90;
						break;
					case 3 :
						$angle = 180;
						break;
					case 6 :
						$angle = -90;
						break;
				}
			}
		}	
		// Resize image (main)
		$image = Engine_Image::factory();
		$image -> open($file);
		if ($angle != 0)
			$image -> rotate($angle);
		$image
			//->resize(1140, 520)
			-> write($path . '/m_' . $name) -> destroy();

		// Resize image (normal)
		$image = Engine_Image::factory();
		$image->open($file)
			->autoRotate()
			->resize(140, 160)
			->write($path.'/is_'.$name)
			->destroy();


		// Store
		$iMain = $storage -> create($path . '/m_' . $name, $params);
		$iSquare = $storage->create($path.'/is_'.$name, $params);

		$iMain -> bridge($iSquare, 'thumb.icon');
		
		// Remove temp files
		@unlink($path . '/m_' . $name);
		@unlink($path . '/is_' . $name);

		// Update row
		$this -> photo_id = $iMain -> file_id;
		$this -> save();

		return $this;
	}
}
