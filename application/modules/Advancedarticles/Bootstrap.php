<?php

class Advancedarticles_Bootstrap extends Engine_Application_Bootstrap_Abstract
{
  public function __construct($application)
  {
    parent::__construct($application);
    $this->initViewHelperPath();
    $this->initActionHelperPath();	
  }
}
