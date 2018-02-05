<?php

class Advancedarticles_Model_Album extends Core_Model_Item_Collection
{
  protected $_collectible_type = "advancedarticles_photo";
  protected $_parent_type = 'artarticle';
  protected $_owner_type = 'artarticle';
  protected $_children_types = array('advancedarticles_photo');
  public function getAuthorizationItem()
  {
    return $this->getParent('artarticle');
  }  
}
