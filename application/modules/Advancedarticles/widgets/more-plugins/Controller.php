<?php

class Advancedarticles_Widget_MorePluginsController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {

   // Zend_Feed required DOMDocument
    // @todo add to sanity check
    if( !class_exists('DOMDocument', false) ) {
      $this->view->badPhpVersion = true;
      return;
      //return $this->setNoRender();
    }

    $rss = Zend_Feed::import('http://spur-i-t.com/get_more_plugins_info.php?nick=SpurIT');
	
    $channel = array(
      'title'       => $rss->title(),
      'link'        => $rss->link(),
      'description' => $rss->description(),
      'items'       => array()
    );

    // Loop over each channel item and store relevant data
	$installed_plugin = array();
	$not_installed_plugin = array();
	$not_installed_plugin_free = array();
    foreach( $rss as $item )
    {
	  $install = $this->getPlugins('spurit', trim($item->title()) );
	  if ( $install ) {
	    
		if ( $item->version() != '' && $item->version() != $install['version']  )
		  $action = true;
		else $action = false;  
		  
	    $installed_plugin[] = array(
          'title'       => $item->title(),
          'description' => $item->description(),
          'version'     => $install['version'],
          'price'       => $item->price(),
          'link'        => $item->link(),
          'status'      => $item->status(),
		  'last_version'=> $item->version(),
		  'action'	  => $action ? '<a style="font-weight:bold; color:#FF0000" href='.$item->link().' target="_blank">get upgrade</a>' : ($item->status() == 1 ? '<a style="font-weight:bold; color:#FF0000" href='.$item->link().'>'.Zend_Registry::get('Zend_Translate')->_('NEW!').'</a>' : ''),	
        );
	    //unset();
	  }
	  elseif ($item->price() != '0') {
	    $not_installed_plugin[] = array(
          'title'       => $item->title(),
          'description' => $item->description(),
          'version'     => $item->version(),
          'price'       => $item->price(),
          'link'        => $item->link(),
          'status'      => $item->status() == 1 ? '<a style="font-weight:bold; color:#FF0000" href='.$item->link().' target="_blank">'.Zend_Registry::get('Zend_Translate')->_('NEW!').'</a>' : '',	
        );	    
	  }	 
	  else {
	    $not_installed_plugin_free[] = array(
          'title'       => $item->title(),
          'description' => $item->description(),
          'version'     => $item->version(),
          'price'       => $item->price(),
          'link'        => $item->link(),
          'status'      => $item->status() == 1 ? '<a style="font-weight:bold; color:#FF0000" href='.$item->link().' target="_blank">'.Zend_Registry::get('Zend_Translate')->_('NEW!').'</a>' : '',	
        );	    
	  }		   	
    }
	//Installed Plugin
	$this->view->installed_plugin = $installed_plugin; 
	
	//Not Installed Paid Plugins
	$this->view->not_installed_plugin = $not_installed_plugin;
	
	//Not Installed Free Plugins
	$this->view->not_installed_plugin_free = $not_installed_plugin_free;	    
  }
  
  public function getPlugins($author, $title_word)
  {
	$packageManager = new Engine_Package_Manager(array(
        'basePath' => APPLICATION_PATH,
    ));
    Zend_Registry::set('Engine_Package_Manager', $packageManager);
	$packageManager->checkTemporaryPaths();
    if( !is_writeable(APPLICATION_PATH . '/application/packages') ) {
      throw new Engine_Exception('application/packages folder is not writeable; Please CHMOD this directory to 777 and refresh this page.');
    }
    $dbState = array();
	$table = Engine_Api::_()->getDbtable('modules', 'core');
    $select = $table->select();
    foreach( $table->fetchAll() as $row ) {
      $dbState[$row->name] = $row->toArray();
    }

	$DbInfo = array();
	foreach( $packageManager->listInstalledPackages(array('caching' => false)) as $installedPackage ) {
      // Get database state
      if( isset($dbState[$installedPackage->getName()]) ) {
	  
	    $DbInfo[] = $dbState[$installedPackage->getName()];
		$packegInfo[] = $installedPackage;
      }
	}
	
	foreach( $packegInfo as $package ) {
      // Get database state
	  if ( !stristr(strip_tags(join(', ', $package->getMeta()->getAuthors())), $author) ) continue;
      if ( !stristr($package->getMeta()->getTitle(), $title_word) ) continue;      
	  $installed = array(
        'title'       => $package->getMeta()->getTitle(),
	    'version'     => $package->getVersion(),
	  );
	} 	
    if (isset($installed))
	  return $installed;
	else false;  	 
  }  
}  