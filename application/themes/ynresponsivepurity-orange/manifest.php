<?php return array (
  'package' => 
  array (
    'type' => 'theme',
    'name' => 'ynresponsivepurity-orange',
    'version' => '4.01',
    'path' => 'application/themes/ynresponsivepurity-orange',
    'repository' => 'younetco.com',
    'title' => 'YN - Responsive Purity Template - Orange',
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
      0 => 'application/themes/ynresponsivepurity-orange',
      1 => 'application/themes/configure/default',
      2 => 'application/themes/configure/ynresponsivepurity-orange',
    ),
    'description' => 'Responsive Purity Template - Blue',
  ),
  'files' => 
  array (
    0 => 'theme.css',
    1 => 'constants.css',
  ),
); ?>