<?php
define('YNRESPONSIVE', 'responsive1');
class Ynresponsive1_Bootstrap extends Engine_Application_Bootstrap_Abstract
{
    function _initBootstrap3()
    {
        //check theme active and get name theme
        $themes   = Engine_Api::_()->getDbtable('themes', 'core')->fetchAll();
        $activeTheme = $themes->getRowMatching('active', 1);
        $name_theme = $activeTheme -> name;
        if(substr($name_theme, 0, 12) != 'ynresponsive') 
        {
            $name_theme = 'ynresponsive1';
        }
		
        define('YNRESPONSIVE_ACTIVE', $name_theme);
        
        $session = new Zend_Session_Namespace('mobile');
        if (!$session -> mobile)
        {
            require_once APPLICATION_PATH . '/application/modules/Ynresponsive1/Engine/ContentDecoratorTitle.php';
            require_once APPLICATION_PATH . '/application/modules/Ynresponsive1/Engine/BootHelper.php';
            require_once APPLICATION_PATH . '/application/modules/Ynresponsive1/Engine/Pages.php';
            require_once APPLICATION_PATH . '/application/modules/Ynresponsive1/Engine/Container.php';
            
                    
            $view =  Zend_Registry::get('Zend_View');
            if(Engine_Api::_()->ynresponsive1()->isMobile())
            {
                $mode = Engine_Api::_()->getApi('settings', 'core')->getSetting('form.mode', 0);
                if($mode){                                      
                    $view->addHelperPath(APPLICATION_PATH .'/application/modules/Ynresponsive1/View/Helper/YNHtml5', 'Ynresponsive1_View_Helper_YNHtml5');                                                  
                }
                else{
                    $view->addHelperPath(APPLICATION_PATH .'/application/modules/Ynresponsive1/View/Helper/YNTinyMce', 'Ynresponsive1_View_Helper_YNTinyMce');  
                }                   
            }
            else{
                $view->addHelperPath(APPLICATION_PATH .'/application/modules/Ynresponsive1/View/Helper/YNTinyMce', 'Ynresponsive1_View_Helper_YNTinyMce');
            }   
                                
            $view->addHelperPath(APPLICATION_PATH .'/application/modules/Ynresponsive1/View/Helper', 'Ynresponsive1_View_Helper_FormYnResCalendarSimple');
            
            // Setup and register viewRenderer
            // @todo we may not need to override zend's

            if (Zend_Registry::isRegistered("Engine_Content"))
            {
                // Save to registry
                $content = Zend_Registry::get('Engine_Content');
                $contentTable = new Ynresponsive1_Model_DbTable_Pages;
                $content -> setStorage($contentTable);
            }

            $helper = new Ynresponsive1_BootHelper();

            Zend_Controller_Action_HelperBroker::getStack() -> offsetSet(-79, $helper);
        }
    }
}