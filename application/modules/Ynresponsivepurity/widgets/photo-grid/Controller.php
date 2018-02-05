<?php
class Ynresponsivepurity_Widget_PhotoGridController extends Engine_Content_Widget_Abstract
{
	public function indexAction()
	{
		if(substr(YNRESPONSIVE_ACTIVE, 0, 18) != 'ynresponsivepurity' || (!Engine_Api::_() -> hasModuleBootstrap('album') && !Engine_Api::_() -> hasModuleBootstrap('advalbum')))
		{
			return $this -> setNoRender(true);
		}
		$type = $this -> _getParam('type', 'recent');
		$num_photos = $this -> _getParam('num_photos', 4);
		if($type == 'featured' && !Engine_Api::_() -> hasModuleBootstrap('advalbum'))
		{
			$type = 'recent';
		}

		// Get photos
		if(Engine_Api::_() -> hasModuleBootstrap('advalbum'))
		{
			$parentTable = Engine_Api::_()->getItemTable('advalbum_album');
			$table = Engine_Api::_()->getItemTable('advalbum_photo');
		}
		else
		{
			$parentTable = Engine_Api::_()->getItemTable('album');
			$table = Engine_Api::_()->getItemTable('album_photo');
		}
		$parentTableName = $parentTable->info('name');
		$tableName = $table->info('name');
		$select = $table->select()
			->from($tableName)
			->joinLeft($parentTableName, $parentTableName . '.album_id=' . $tableName . '.album_id', null)
			->where($parentTableName . '.search = ?', 1);

		switch($type)
		{
			case 'most-view':
				$select->order('view_count DESC');
				break;
			case 'most-like':
				$select->order('like_count DESC');
				break;
			case 'most-comment':
				$select->order('comment_count DESC');
				break;
			case 'random':
				$select->order('rand()');
				break;
			case 'featured':
				$fTable = Engine_Api::_() -> getDbtable('features', 'advalbum');
				$fName = $fTable -> info('name');
				$select -> joinLeft($fName, $fName . '.photo_id=' . $tableName . '.photo_id', null);
				$select -> where($fName.'.photo_good = 1');
				$select -> order('rand()');
				break;
			default:
				$select->order('photo_id DESC');
				break;
		}
		// Create new array filtering out private photos
		$viewer = Engine_Api::_()->user()->getViewer();
		$new_select = array();
		$i = 0;
		foreach ($select -> getTable() -> fetchAll($select) as $photo)
		{
			if($i > $num_photos) {
				break;
			}
			if (Engine_Api::_()->authorization()->isAllowed($photo, $viewer, 'view')) {
				$new_select[$i++] = $photo;
			}
		}

		$this->view->photos = $paginator = Zend_Paginator::factory($new_select);

		// Set item count per page and current page number
		$paginator->setItemCountPerPage($num_photos);
		$paginator->setCurrentPageNumber($this->_getParam('page', 1));

		// Hide if nothing to show
		if( $paginator->getTotalItemCount() <= 0 ) {
			return $this->setNoRender();
		}
	}

}
