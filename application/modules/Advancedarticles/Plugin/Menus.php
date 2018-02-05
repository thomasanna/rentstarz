<?php
class Advancedarticles_Plugin_Menus
{
  public function onMenuInitialize_AdvancedarticlesPageMy($row)
  {
    $viewer = Engine_Api::_()->user()->getViewer();

    if( !$viewer->getIdentity() )  return false;
    
    return array(
        'label' => $row->label,
        'route' => 'advancedarticles_general',
        'params' => array(
          'module' => 'advancedarticles',
          'controller' => 'articles',
          'action' => 'my'
        )
    );
  }
  
  public function onMenuInitialize_AdvancedarticlesPageAdd($row)
  {
    $viewer = Engine_Api::_()->user()->getViewer();

    if( !$viewer->getIdentity() ) return false;
    	
	if( !Engine_Api::_()->authorization()->isAllowed('artarticle', $viewer, 'create') ) return false;	

    return array(
        'label' => $row->label,
        'route' => 'advancedarticles_general',
        'params' => array(
          'module' => 'advancedarticles',
          'controller' => 'articles',        
          'action' => 'add',
        )
    );
  }  
}