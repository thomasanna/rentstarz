<?php return array (
  'package' =>
  array (
    'type' => 'module',
    'name' => 'sqlupdates',
    'version' => '4.0.0',
    'path' => 'application/modules/Sqlupdates',
    'title' => 'Sqlupdates',
    'description' => 'for updating db',
    'author' => 'titechnologies.in',
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
      0 => 'application/modules/Sqlupdates',
    ),
    'files' =>
    array (
     // 0 => 'application/languages/en/polls.csv',
    ),
  ),
    // Routes --------------------------------------------------------------------
  'routes' => array(
    // User - General
    'sql_result' => array(
      'route' => 'sqlupdates',
      'defaults' => array(
        'module' => 'sqlupdates',
        'controller' => 'index',
        'action' => 'index'
      )
    )
  )
); ?>
