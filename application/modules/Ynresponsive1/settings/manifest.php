<?php return array (
  'package' => 
  array (
    'type' => 'module',
    'name' => 'ynresponsive1',
    'version' => '4.05',
    'path' => 'application/modules/Ynresponsive1',
    'title' => 'YN - Responsive Core',
    'description' => 'YouNet Responsive Module',
    'author' => '<a href="http://socialengine.younetco.com/" title="YouNet Company" target="_blank">YouNet Company</a>',
    'callback' => 
    array (
      'class' => 'Engine_Package_Installer_Module',
    ),
    'dependencies' => array(
      array(
         'type' => 'module',
         'name' => 'younet-core',
         'minVersion' => '4.02',
      ),
    ),
    'callback' =>
    array (
      'class' => 'Engine_Package_Installer_Module',
    ),
    'actions' => 
    array (
      0 => 'install',
      1 => 'upgrade',
      2 => 'refresh',
      3 => 'enable',
      4 => 'disable',
    ),
    'directories' => 
    array (
      0 => 'application/modules/Ynresponsive1',
      1 => 'application/widgets/advancedhtmlblock',
      2 => 'externals/tinymceres',
      3 => 'externals/wysihtml5',
    ),
    'files' => 
    array (
      0 => 'application/languages/en/ynresponsive1.csv',
      1 => 'application/modules/Core/Form/Admin/Younetadvancedhtmlblock.php',      
      2 => 'application/modules/Core/views/scripts/_location_search.tpl',
      3 => 'application/modules/User/views/scripts/_location_search.tpl',      
    ),
  ),
  'routes' => array(
    'core_editwidget' => array(
      'route' => 'admin/content/widget/*',
      'defaults' => array(
        'module' => 'ynresponsive1',
        'controller' => 'admin-content',
        'action' => 'widget'
      ),
    ),
    'ynresponsive_general' => array(
      'route' => 'responsive/:action/*',
      'defaults' => array(
        'module' => 'ynresponsive1',
        'controller' => 'index',
        'action' => 'event'
      ),
    ),
    /*'dashboard_general' => array(
      'route' => 'dashboard',
      'defaults' => array(
        'module' => 'ynresponsive1',
        'controller' => 'index',
        'action' => 'dashboard'
      ),*/
    'dashboard_general' => array(
      'route' => 'members/home',
      'defaults' => array(
        'module' => 'ynresponsive1',
        'controller' => 'index',
        'action' => 'dashboard'
      ),
    ),
  ),
); ?>
