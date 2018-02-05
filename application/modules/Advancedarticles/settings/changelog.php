<?php

return array(
	'4.1.3' => array(
		'Api/Core.php' => 'Added compatibility with TinyMCE v4',
		'settings/manifest.php' => 'Incremented version',
		'settings/my.sql' => 'Incremented version',
	),
	'4.1.2' => array(
		'settings/manifest.php' => 'Incremented version',
		'settings/my.sql' => 'Incremented version',
		'settings/my-upgrade-4.1.1-4.1.2.sql' => 'Added. Fixed bug with longer article.',
	),
	'4.1.1' => array(
		'controllers/ArticlesController.php' => 'Added prohibition of access for inactive articles',
		'settings/manifest.php' => 'Incremented version',
		'settings/my.sql' => 'Incremented version',
	),
	'4.1.0' => array(
		'controllers/ArticlesController.php' => 'We have removed article addition in the activity feed, while saving it as a draft',
		'settings/manifest.php' => 'Incremented version',
		'settings/my.sql' => 'Incremented version',
	),
	'4.0.9' => array(
		'Api/Core.php' => 'Added articles sort "Most Recent" by default',
		'controllers/ArticlesController.php' => 'Fixed bug with edit article tags',
		'settings/manifest.php' => 'Incremented version',
		'settings/my.sql' => 'Incremented version',
	),
	'4.0.8' => array(
		'/application/languages/en/advancedarticles.csv' => 'Added translations',
		'settings/manifest.php' => 'Incremented version',
		'settings/my.sql' => 'Incremented version',
	),
	'4.0.7' => array(
		'widrets/categories-block/index.tpl' => 'Added translate functions',
		'settings/manifest.php' => 'Incremented version',
		'settings/my.sql' => 'Incremented version',
	),
	'4.0.6' => array(
		'controllers/ArticlesController.php' => 'Fixed bug with edit article (added isset($form->auth_view), isset($form->auth_comment))',
		'widrets/article-block/index.tpl' => 'Fixed bug with css style for Comment, Photos tabs',
		'settings/manifest.php' => 'Incremented version',
		'settings/my.sql' => 'Incremented version',
	),
	'4.0.5' => array(
		'Api/Core.php' => 'Removed limitation for the length of links',
		'settings/manifest.php' => 'Incremented version',
		'settings/my.sql' => 'Incremented version',
	),
	'4.0.4' => array(
		'/application/languages/en/advancedarticles.csv' => 'Added translations',
		'controllers/AdminSettingsController.php' => 'Added ability to change subdirectory link',
		'settings/manifest.php' => 'Incremented version',
		'settings/my.sql' => 'Incremented version',
		'settings/my-upgrade-4.0.3-4.0.4.sql' => 'Added.',
	),
	'4.0.3' => array(
		'/application/languages/en/advancedarticles.csv' => 'Added translations',
		'settings/manifest.php' => 'Incremented version',
		'settings/my.sql' => 'Incremented version',
	),
	'4.0.2' => array(
		'Form/Add.php' => 'Fixed bug with add article in IE',
		'Form/Edit.php' => 'Fixed bug with edit article in IE',
		'settings/manifest.php' => 'Incremented version',
		'settings/my.sql' => 'Incremented version',
	),
	'4.0.1' => array(
		'/application/languages/en/advancedarticles.csv' => 'Added translations',
		'settings/manifest.php' => 'Incremented version',
		'settings/my.sql' => 'Incremented version',
	),
)
?>