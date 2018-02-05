<?php
// YouNet Responsive Purity
return array(
    array(
        'title' => 'Mini Menu vs Logo',
        'description' => 'Shows the site-wide mini menu and (main logo or title). You can edit its contents in your menu editor. Images are uploaded via the <a href="admin/files" target="_blank">File Media Manager</a>.',
        'category' => 'YouNet Responsive Purity',
        'type' => 'widget',
        'name' => 'ynresponsivepurity.mini-menu',
        'adminForm' => 'Ynresponsive1_Form_Admin_LogoMainMenu',
        'requirements' => array('header-footer'
        ),
    ),
    array(
        'title' => 'Main Menu',
        'description' => 'Shows the site-wide main menu. You can edit its contents in your menu editor.',
        'category' => 'YouNet Responsive Purity',
        'type' => 'widget',
        'name' => 'ynresponsivepurity.main-menu',
        'requirements' => array('header-footer'
        ),
        'adminForm' => array(
            'elements' => array(
                array(
                    'Text',
                    'limit',
                    array(
                        'label' => 'How many main menus will be shown. The rest will be laid on More menu',
                    )
                ),
            )
        ),
    ),
    array(
        'title' => 'Footer Menu',
        'description' => 'Shows footer menu.',
        'category' => 'YouNet Responsive Purity',
        'type' => 'widget',
        'name' => 'ynresponsivepurity.footer-menu',
        'requirements' => array(),
    ),
    array(
        'title' => 'Slider',
        'description' => 'Slider (only for width 100% screen landing page). Background images are uploaded via the <a href="admin/files" target="_parent">File Media Manager</a>.',
        'category' => 'YouNet Responsive Purity',
        'type' => 'widget',
        'name' => 'ynresponsivepurity.slider',
        'isPaginated' => false,
        'requirements' => array(),
        'adminForm' => 'Ynresponsivepurity_Form_Admin_Widget_Slider'
    ),
    array(
        'title' => 'Welcome',
        'description' => 'Welcome widget',
        'category' => 'YouNet Responsive Purity',
        'type' => 'widget',
        'name' => 'ynresponsivepurity.welcome',
        'requirements' => array(),
    ),
    array(
        'title' => 'Our Modules',
        'description' => 'Show our modules',
        'category' => 'YouNet Responsive Purity',
        'type' => 'widget',
        'name' => 'ynresponsivepurity.our-module',
        'requirements' => array(),
        'adminForm' => array(
            'elements' => array(
                array(
                    'Text',
                    'title',
                    array(
                        'label' => 'Title',
                    )
                ),
                array(
                    'Text',
                    'short_description',
                    array(
                        'label' => 'Short Description',
                    )
                ),
                array(
                    'Textarea',
                    'description',
                    array(
                        'label' => 'Description',
                    )
                ),
                array(
                    'Integer',
                    'number_of_module',
                    array(
                        'label' => 'Number of Modules',
                        'value' => 10,
                        'validators' => array(
                            array('Between',true,array(1,10)),
                        )
                    )
                ),
            )
        ),
    ),
    array(
        'title' => 'Events Grids Container',
        'description' => 'Events Grids Container',
        'category' => 'YouNet Responsive Purity',
        'type' => 'widget',
        'name' => 'ynresponsivepurity.event-grid',
        'isPaginated' => false,
        'requirements' => array(),
        'autoEdit' => true,
        'adminForm' => 'Ynresponsivepurity_Form_Admin_Widget_EventsGrids',
    ),
    array(
        'title' => 'Photos Grids Container',
        'description' => 'Events Grids Container',
        'category' => 'YouNet Responsive Purity',
        'type' => 'widget',
        'name' => 'ynresponsivepurity.photo-grid',
        'isPaginated' => false,
        'requirements' => array(),
        'autoEdit' => true,
        'adminForm' => 'Ynresponsivepurity_Form_Admin_Widget_PhotosGrids',
    ),
    array(
        'title' => 'Groups Grids Container',
        'description' => 'Groups Grids Container',
        'category' => 'YouNet Responsive Purity',
        'type' => 'widget',
        'name' => 'ynresponsivepurity.group-grid',
        'isPaginated' => false,
        'requirements' => array(),
        'autoEdit' => true,
        'adminForm' => 'Ynresponsivepurity_Form_Admin_Widget_GroupsGrids',
    ),
);
