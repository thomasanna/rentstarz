<?php
class Ynresponsive1_Form_Admin_LogoMainMenu extends Core_Form_Admin_Widget_Standard
{
  public function init()
  {
    parent::init();
    // Set form attributes
    $this
      ->setTitle('Edit Logo & Site Name')
      ->setDescription('Shows your site-wide main logo or title. Images are uploaded via the File Media Manager.')
      ;

    // Get available files
    $logoOptions = array('' => 'Text-only (No logo)');
    $imageExtensions = array('gif', 'jpg', 'jpeg', 'png');

    $it = new DirectoryIterator(APPLICATION_PATH . '/public/admin/');
    foreach( $it as $file ) {
      if( $file->isDot() || !$file->isFile() ) continue;
      $basename = basename($file->getFilename());
      if( !($pos = strrpos($basename, '.')) ) continue;
      $ext = strtolower(ltrim(substr($basename, $pos), '.'));
      if( !in_array($ext, $imageExtensions) ) continue;
      $logoOptions['public/admin/' . $basename] = $basename;
    }

    $this->addElement('Select', 'logo', array(
      'label' => 'Site Logo',
      'multiOptions' => $logoOptions,
    ));
	
	$this->addElement('Text', 'logo_link', array(
      'label' => 'Link of Logo',
    ));
	
	$this->addElement('Text', 'site_name', array(
      'label' => 'Site Name',
    ));
	
	$this->addElement('Text', 'site_link', array(
      'label' => 'Link of Site Name',
    ));
  }
}