<?php

class Advancedarticles_View_Helper_AdvancedarticlesUser extends Zend_View_Helper_Abstract
{
  public function advancedarticlesUser($uid)
  {
    $user = Engine_Api::_()->user()->getUser((int)$uid);
	return $user;
  }
}