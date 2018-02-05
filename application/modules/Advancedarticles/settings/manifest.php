<?php

//Get Route
try {
    $settings = Engine_Api::_()->getApi('settings', 'core');
} catch (Engine_Loader_Exception $e) {
    
}
$route = isset($settings->art_route) ? $settings->art_route : 'articles';

return array(
    // Package -------------------------------------------------------------------
    'package' => array(
        'type' => 'module',
        'name' => 'advancedarticles',
        'version' => '4.1.3',
        'revision' => '',
        'path' => 'application/modules/Advancedarticles',
        'repository' => 'spur-i-t.com',
        'title' => 'Advanced Articles',
        'description' => 'Advanced Articles plugin allows to post articles with photos, comments and have a wide range of additional features.',
        'author' => '<a href="http://spur-i-t.com" style="text-decoration:underline;">SpurIT</a>',
        'changeLog' => 'settings/changelog.php',
        'actions' => array(
            'install',
            'upgrade',
            'refresh',
            'enable',
            'disable',
        ),
        'callback' => array(
            'class' => 'Engine_Package_Installer_Module',
        ),
        'directories' => array(
            'application/modules/Advancedarticles',
        ),
        'files' => array(
            'application/languages/en/advancedarticles.csv',
        ),
    ),
    // Hooks ---------------------------------------------------------------------
    'hooks' => array(
    ),
    // Items ---------------------------------------------------------------------
    'items' => array(
        'artarticle',
        'advancedarticles_category',
        'advancedarticles_album',
        'advancedarticles_photo',
    ),
    // Routes --------------------------------------------------------------------
    'routes' => array(
        // Front Main
        'advancedarticles_category_specific' => array(
            'route' => $route . '/:action/:id/*',
            'defaults' => array(
                'module' => 'advancedarticles',
                'controller' => 'articles',
                'action' => 'category',
            ),
            'reqs' => array(
                'id' => '\d+',
            ),
        ),
        'advancedarticles_general' => array(
            'route' => $route . '/:action',
            'defaults' => array(
                'module' => 'advancedarticles',
                'controller' => 'articles',
                'action' => 'browse'
            ),
            'reqs' => array(
                'action' => '(browse|category|add|upload|my|status|tagscloud|view)',
            )
        ),
        'advancedarticles_article' => array(
            'route' => $route . '/:art_id/*',
            'defaults' => array(
                'module' => 'advancedarticles',
                'controller' => 'articles',
                'action' => 'article'
            ),
            'reqs' => array(
                'art_id' => '\d+',
            ),
        ),
        'advancedarticles_photo' => array(
            'route' => $route . '/:action/:art_id/:photo_id/*',
            'defaults' => array(
                'module' => 'advancedarticles',
                'controller' => 'articles',
                'action' => 'view'
            ),
            'reqs' => array(
                'art_id' => '\d+',
                'photo_id' => '\d+',
            ),
        ),
        // Admin
        'advancedarticles_admin_categoties' => array(
            'route' => '/admin/advancedarticles/settings/:action/*',
            'defaults' => array(
                'module' => 'advancedarticles',
                'controller' => 'admin-settings',
                'action' => 'index',
            //'id' => 0
            )
        ),
        'advancedarticles_extended_level' => array(
            'route' => 'admin/advancedarticles/settings/level/:level_id',
            'defaults' => array(
                'module' => 'advancedarticles',
                'controller' => 'admin-settings',
                'action' => 'level',
            )
        ),
    )
);
?>