<?php return array(
  'package' => array(
    'type' => 'library',
    'name' => 'scaffold',
    'version' => '4.8.10',
    'revision' => '$Revision: 10171 $',
    'path' => 'application/libraries/Scaffold',
    'repository' => 'socialengine.com',
    'title' => 'CSS Scaffold',
    'author' => 'Webligo Developments',
    'changeLog' => array(
    '4.8.10' => array(
        'manifest.php' => 'Incremented version',
        'modules/Absolute_Urls/Absolute_Urls.php ' => 'Fixed Scaffold issue with absolute URLs'
     ),
    '4.8.8' => array(
        'manifest.php' => 'Incremented version',
        'libraries/Scaffold/modules/ScanInclude/ScanInclude.php' => 'Fixed issue with CSS of disabled modules that was being loaded on windows based server.',
        'libraries/Scaffold/Scaffold.php' => 'Resolved notice of E_DEPRECATED appearing on websites having PHP version less than 5.3.0',
      ),
      '4.8.7' => array(
        'manifest.php' => 'Incremented version',
        'libraries/Scaffold/modules/ScanInclude/ScanInclude.php' => 'Added code to exclude CSS of disabled modules from rendering on website',
        'libraries/Scaffold/Scaffold.php' => ' Disabled "DEPRECATED" warnings when a website is in development mode',
      ),
      '4.8.1' => array(
        'manifest.php' => 'Incremented version',
        'libraries/Scaffold/Scaffold.php' => 'Added Content-Length to compressed output',
      ),
      '4.5.0' => array(
        'manifest.php' => 'Incremented version',
        'views/scaffold_error.php' => 'Fixed potential XSS',
      ),
      '4.1.1' => array(
        'manifest.php' => 'Incremented version',
        'modules/Absolute_Urls.php' => 'Added hack to send expires flush counter to images in the stylesheets'
      ),
      '4.0.3' => array(
        'libraries/Scaffold/Scaffold.php' => 'Fix for open_basedir warning',
        'manifest.php' => 'Incremented version',
      ),
      '4.0.2' => array(
        'libraries/Scaffold/Scaffold.php' => 'Fix for open_basedir warning',
        'manifest.php' => 'Incremented version',
      ),
    ),
    'directories' => array(
      'application/libraries/Scaffold',
    )
  )
) ?>