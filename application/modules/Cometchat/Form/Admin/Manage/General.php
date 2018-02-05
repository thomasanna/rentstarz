<?php
/**
* @category   Application_Core
* @package    Cometchat
* @copyright  CometChat
* @license    CometChat
*/
class Cometchat_Form_Admin_Manage_General extends Engine_Form
{
   public function init()
   {
    $baseUrl =Zend_Controller_Front::getInstance()->getBaseUrl();
    $baseUrl = str_replace("/index.php", "", $baseUrl);
    $rootPath = dirname(dirname(dirname(dirname(dirname(dirname(dirname(__FILE__)))))));
    if(!file_exists($rootPath."/cometchat/integration.php")){
      $this -> setTitle('Upload CometChat Zip');
      $this->addElement('File', 'cometchatzip', array(
       'label' => 'Upload CometChat zip file:',
       ));
      $this->addElement('Button', 'submit', array(
       'label' => 'Install now',
       'type' => 'submit',
       'ignore' => true,
       ));
    }else{
     $this -> setTitle('CometChat Administration Panel');
     echo "<iframe src='".$baseUrl."/cometchat/admin' height='700' width='1000'/>";
   }
  }
}