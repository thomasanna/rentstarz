<?php return array (
  'package' =>
  array (
    'type' => 'module',
    'name' => 'cometchat',
    'version' => '1.0.0',
    'path' => 'application/modules/Cometchat',
    'title' => 'CometChat',
    'description' => 'Add text, voice and video chat to your site in minutes.',
    'author' => 'CometChat',
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
      0 => 'application/modules/Cometchat',
    ),
    'files' =>
    array (
      0 => 'application/languages/en/cometchat.csv',
    ),
  ),
    'hooks' => array(
      array(
        'event' => 'onRenderLayoutDefault',
        'resource' => 'Cometchat_Plugin_Core'
      ),
    array(
        'event' => 'onMessagesMessageCreateAfter',
        'resource' => 'Cometchat_Plugin_Core'
      )
     ),
); ?>