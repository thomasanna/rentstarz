<?php

class Advancedarticles_Model_Photo extends Core_Model_Item_Collectible
{
  protected $_collection_type = "advancedarticles_album";
  protected $_parent_type = 'advancedarticles_album';
  protected $_owner_type = 'user';
  
  public function getPhotoUrl($type_photo = null)
  {
    $photo = $this->file_id ? $this->file_id : null;

    $storageFile = Engine_Api::_()->getItemTable('storage_file')->getFile($photo, $type_photo);

    return $storageFile ? $storageFile->map() : null;
  }  
  
  public function getHref($adv_params = array())
  {
    $params = array(
	  'art_id' => $this->artarticle_id,	
      'photo_id' => $this->getIdentity()
    );
	$params = array_merge($params, $adv_params);
    return Zend_Controller_Front::getInstance()->getRouter()->assemble($params, 'advancedarticles_photo', true);
  }

  public function deleteStorage()
  {
  	$main = Engine_Api::_()->getItemTable('storage_file')->getFile($this->file_id);
    $thumbNormal = Engine_Api::_()->getItemTable('storage_file')->getFile($this->file_id, 'thumb.normal');
    
    if ($main->getIdentity()) {
        $main->delete();   
    }
    if ($thumbNormal->getIdentity()) {
        $thumbNormal->delete();   
    }
    
    return $this->file_id;
  }
  
  public function getAuthorizationItem()
  {
    return $this->getParent('artarticle');
  }  
  
  public function tags()
  {
    return new Engine_ProxyObject($this, Engine_Api::_()->getDbtable('tags', 'core'));
  }

  public function comments()
  {
    return new Engine_ProxyObject($this, Engine_Api::_()->getDbtable('comments', 'core'));
  }

  public function likes()
  {
    return new Engine_ProxyObject($this, Engine_Api::_()->getDbtable('likes', 'core'));
  }   
}
