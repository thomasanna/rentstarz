<?php return array (
  'package' => 
  array (
    'type' => 'theme',
    'name' => 'ynresponsivepurity-blue',
    'version' => '4.01',
    'path' => 'application/themes/ynresponsivepurity-blue',
    'repository' => 'younetco.com',
    'title' => 'YN - Responsive Purity Template - Blue',
    'thumb' => 'theme.jpg',
    'author' => 'YouNet Company',
    'actions' => 
    array (
      0 => 'install',
      1 => 'upgrade',
      2 => 'refresh',
      3 => 'remove',
    ),
    'callback' => 
    array (
      'class' => 'Engine_Package_Installer_Theme',
    ),
    'dependencies' => 
    array (
      0 => 
      array (
        'type' => 'module',
        'name' => 'ynresponsivepurity',
        'minVersion' => '4.01',
      ),
      1 => 
      array (
        'type' => 'module',
        'name' => 'ynresponsive1',
        'minVersion' => '4.05',
      ),
    ),
    'directories' => 
    array (
      0 => 'application/themes/ynresponsivepurity-blue',
      1 => 'application/themes/configure/default',
      2 => 'application/themes/configure/ynresponsivepurity-blue',
    ),
    'description' => 'Responsive Purity Template - Blue',
  ),
  'files' => 
  array (
    0 => 'theme.css',
    1 => 'constants.css',
  ),
); ?>