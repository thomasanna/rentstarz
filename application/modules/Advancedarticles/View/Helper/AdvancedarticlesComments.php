<?php

class Advancedarticles_View_Helper_AdvancedarticlesComments extends Zend_View_Helper_Abstract
{
  public function advancedarticlesComments($article)
  {
    return 0;
  	$action = Engine_Api::_()->getDbtable('actions', 'activity')->getActionsByObject($article);
	return $action[0]->comments()->getCommentCount();
  } 
}