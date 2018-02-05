<?php

class Advancedarticles_View_Helper_AdvancedarticlesLikes extends Zend_View_Helper_Abstract
{
  public function advancedarticlesLikes($article)
  {
    return 0;
  	$action = Engine_Api::_()->getDbtable('actions', 'activity')->getActionsByObject($article);
	return $action[0]->likes()->getLikeCount();
  } 
}