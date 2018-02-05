<?php return array (
  'package' => 
  array (
    'type' => 'module',
    'name' => 'yntheme',
    'version' => '4.04p1',
    'path' => 'application/modules/Yntheme',
    'title' => 'YN - Themes Core',
    'description' => 'Manage YouNet Themes',
    'author' => '<a href="http://socialengine.younetco.com/" title="YouNet Company" target="_blank">YouNet Company</a>',
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
      0 => 'application/modules/Yntheme',
    ),
    'files' => 
    array (
      0 => 'application/languages/en/yntheme.csv',
    ),
  ),
  'routes' => array(
    'core_changetheme' => array(
      'route' => 'admin/themes/change/*',
      'defaults' => array(
        'module' => 'yntheme',
        'controller' => 'admin-themes',
        'action' => 'change'
      ),
    ),
   ),
); ?>