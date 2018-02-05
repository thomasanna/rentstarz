<?php

/**
* @category   Application_Core
* @package    Cometchat
* @copyright  CometChat
* @license    http://www.socialengine.com/license/
*/
class Cometchat_AdminManageController extends Core_Controller_Action_Admin
{
    public function indexAction()
    {
        $rootPath = dirname(dirname(dirname(dirname(dirname(__FILE__)))));
        $baseUrl = Zend_Controller_Front::getInstance()->getBaseUrl();
        $baseUrl = str_replace("/index.php", "", $baseUrl);
        $this->view->formFilter = $formFilter = new Cometchat_Form_Admin_Manage_General();
        $settings = Engine_Api::_()->getApi('settings', 'core');
        $values = $settings->cometchat;
        if( !$this->getRequest()->isPost() ) {
            return;
        }
        if( !$formFilter->isValid($this->getRequest()->getPost()) ) {
            return;
        }
// Process
        $values = $formFilter->getValues();
        if(empty($values['cometchatzip'])) {
            $formFilter->addError($this->view->translate('*  Please upload CometChat zip file - it is required.'));
        }else {
// Save settings
            $settings->cometchat = $values;
            if($values['cometchatzip'] != 'cometchat.zip'){
                $formFilter->addError($this->view->translate('*  Please upload valid CometChat zip file. You can download it from cometchat.com'));
            }else{

                $path = $_FILES["cometchatzip"]["tmp_name"];

                $path = explode("/",$path);
                $paths = array();
                for ($i =0;$i<count($path)-1;$i++){
                    $paths[] = $path[$i];
                }
                $path = implode("/", $paths);
                $path .= "/".$values['cometchatzip'];
                $zip = new ZipArchive;
                $res = $zip->open($path);
                if ($res === TRUE) {
                    $zip->extractTo($rootPath.'/');
                    $zip->close();
                    exec ("find ".$rootPath."/"." -type d -exec chmod 0755 {} +");
                    exec ("find ".$rootPath."/"." -type f -exec chmod 0644 {} +");
                    echo "<iframe id='install_cometchat' src='".$baseUrl."/cometchat/install.php' height='1' width='1'></iframe>";
                    header("Refresh:0");
                } else {
                    $formFilter->addError($this->view->translate(' The file is not uploaded'));
                }
            }
        }
    }
    public function advanceAction(){
        $permission_table = Engine_Api::_()->getDbtable('permissions','authorization');
        $user_id = Engine_Api::_()->user()->getViewer()->getIdentity();
        $rootPath = dirname(dirname(dirname(dirname(dirname(__FILE__)))));
        $baseUrl = Zend_Controller_Front::getInstance()->getBaseUrl();
        $baseUrl = str_replace("/index.php", "", $baseUrl);
        $this->view->formFilter = $formFilter = new Cometchat_Form_Admin_Manage_Advance();
        $settings = Engine_Api::_()->getApi('settings', 'core');
        $values = $settings->cometchat;
        if( !$this->getRequest()->isPost() ) {
            return;
        }
        if( !$formFilter->isValid($this->getRequest()->getPost()) ) {
            return;
        }
// Process
        $values = $formFilter->getValues();
        if(isset($values['inbox_sync'])){
            $val = $values['inbox_sync'];
            $inbox = $permission_table->update(array(
                'value' => $val,
                ), array(
                'type = ?' => 'cometchat','level_id = ?' => 100,
                ));
            unlink(dirname(dirname(dirname(dirname(dirname(__FILE__)))))."/cometchat/cache/cache.storage.".$_SERVER['HTTP_HOST']."/aW/aW5ib3hfc3luY2NjX18.txt");
        }
        if(isset($values['hide_bar'])){
            $val = $values['hide_bar'];
            $inbox = $permission_table->update(array(
                'value' => $val,
                ), array(
                'type = ?' => 'hide_cometchat','level_id = ?' => 101,
                ));
        }

        if(isset($values['displayable'])){
            foreach( Engine_Api::_()->getDbtable('levels', 'authorization')->fetchAll() as $level ) {
                $count = $permission_table->update(array(
                    'value' => 1,
                    ), array(
                    'type = ?' => 'CometChat','level_id = ?' => $level->getIdentity(),
                    ));
            }
            foreach ($values['displayable'] as $key) {
                $count = $permission_table->update(array(
                    'value' => 0,
                    ), array(
                    'type = ?' => 'CometChat','level_id = ?' => $key,
                    ));
            }
        }
    }
    public function upgradeAction(){
        $rootPath = dirname(dirname(dirname(dirname(dirname(__FILE__)))));
        $baseUrl = Zend_Controller_Front::getInstance()->getBaseUrl();
        $baseUrl = str_replace("/index.php", "", $baseUrl);
        $this->view->formFilter = $formFilter = new Cometchat_Form_Admin_Manage_Upgrade();
        $settings = Engine_Api::_()->getApi('settings', 'core');
        $values = $settings->cometchat;
        if( !$this->getRequest()->isPost() ) {
            return;
        }
        if( !$formFilter->isValid($this->getRequest()->getPost()) ) {
            return;
        }
// Process
        $values = $formFilter->getValues();
        if(empty($values['cometchatzip'])) {
            $formFilter->addError($this->view->translate('*  Please upload CometChat zip file - it is required.'));
        }else {
// Save settings
            $settings->cometchat = $values;
            if($values['cometchatzip'] != 'cometchat.zip'){
                $formFilter->addError($this->view->translate('*  Please upload valid CometChat zip file. You can download it from cometchat.com'));
            }else{
                if(file_exists($rootPath.'/cometchat/integration.php')){
                    rename($rootPath.'/cometchat/',$rootPath.'/cometchat_'.time().'/');
                }
                $path = $_FILES["cometchatzip"]["tmp_name"];
                $path = explode("/",$path);
                $paths = array();
                for ($i =0;$i<count($path)-1;$i++){
                    $paths[] = $path[$i];
                }
                $path = implode("/", $paths);
                $path .= "/".$values['cometchatzip'];
                $zip = new ZipArchive;
                $res = $zip->open($path);
                if ($res === TRUE) {
                    $zip->extractTo($rootPath.'/');
                    $zip->close();
                    exec ("find ".$rootPath."/"." -type d -exec chmod 0755 {} +");
                    exec ("find ".$rootPath."/"." -type f -exec chmod 0644 {} +");
                    echo "<iframe id='install_cometchat' src='".$baseUrl."/cometchat/install.php' height='1' width='1'></iframe>";
                    $formFilter->addNotice(' The CometChat upgraded successfully');
                } else {
                    $formFilter->addError($this->view->translate(' The file is not uploaded'));
                }
            }
        }
    }
}

?>