<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Pages.php 9994 2013-03-25 23:18:04Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Ynresponsive1_Model_DbTable_Pages extends Engine_Db_Table implements Engine_Content_Storage_Interface
{
  protected $_rowClass = 'Core_Model_Page';
  
  protected $_name = 'core_pages';

  public function loadMetaData(Engine_Content $contentAdapter, $name)
  {
    
    $table = Engine_Api::_()->getDbtable('pages', 'core');
        
    $select = $this->select()->where('name = ?', $name)->orWhere('page_id = ?', $name);
    $page = $this->fetchRow($select);

    if( !is_object($page) ) {
      // throw?
      return null;
    }

    return $page->toArray();
  }

  public function loadContent(Engine_Content $contentAdapter, $name)
  {
    
    if( is_array($name) ) {
      $name = join('_', $name);
    }
    if( !is_string($name) && !is_numeric($name) ) {
      throw new Exception('not string');
    }
    
    $table = Engine_Api::_()->getDbtable('pages', 'core');

    $select = $table->select()->where('name = ?', $name)->orWhere('page_id = ?', $name);
    $page = $this->fetchRow($select);
	
    if( !is_object($page)) {
      return null;
    }
	
	// check to hide menus (support Business plugin)
	$business_session = new Zend_Session_Namespace('ynbusinesspages_business');
	$businessId = $business_session -> businessId;
	if($businessId)
	{
		if(in_array($name, array('header', 'header_mobi', 'footer', 'footer_mobi')))
		{
			return null;
		}
	}
	
	$page_id = $page->page_id;
	
	// Check conflict with Business plugin
	if(Engine_Api::_() -> hasModuleBootstrap('ynbusinesspages') && $name == 'ynbusinesspages_profile_index')
	{
		// check subject type and some thing else
        $page_id =  Engine_Api::_()->getDbtable('pages', 'ynbusinesspages') ->getProxyPageId($page, $name);
	}
	
	// Check conflict with Muitiple Listing plugin
	if(Engine_Api::_() -> hasModuleBootstrap('ynmultilisting'))
	{
		// check subject type and some thing else
		$pagesName = Engine_Api::_()->ynmultilisting()->getPagesName();
		if (in_array($name, $pagesName))
			$page_id =  Engine_Api::_()->getDbtable('pages', 'ynmultilisting') ->getProxyPageId($page, $name);
	}
	
    // Get all content
    $contentTable = Engine_Api::_()->getDbtable('content', 'core');
    $select = $contentTable->select()
      ->where('page_id = ?', $page_id)
      ->order('order ASC')
      ;
    $content = $contentTable->fetchAll($select);

    // Create structure
    $structure = $this->prepareContentArea($content);

    // Create element (with structure)
    $element = new Engine_Content_Element_Container(array(
      'class' => 'layout_page_' . $page->name,
      'elements' => $structure
    ));

    return $element;
  }

  public function prepareContentArea($content, $current = null)
  {
    // Get parent content id
    $parent_content_id = null;
    if( null !== $current ) {
      $parent_content_id = $current->content_id;
    }
    
    // Get children
    $children = $content->getRowsMatching('parent_content_id', $parent_content_id);
    if( empty($children) && null === $parent_content_id ) {
      $children = $content->getRowsMatching('parent_content_id', 0);
    }

    // Get struct
    $struct = array();
    foreach( $children as $child ) {
      $elStruct = $this->createElementParams($child);
      if( $elStruct ) {
        $elStruct['elements'] = $this->prepareContentArea($content, $child);
        $struct[] = $elStruct;
      }
    }

    return $struct;
  }

  public function createElementParams($row)
  {
    $data = array(
      'identity' => $row->content_id,
      'type' => $row->type,
      'name' => $row->name,
      'order' => $row->order,
    );
    $params = (array) $row->params;
    if( isset($params['title']) ) {
      $data['title'] = $params['title'];
    }
    $data['params'] = $params;
    // Check mobile here?
    if( !empty($params['nomobile'])  && Engine_Api::_()->getApi('mobile', 'ynresponsive1') -> isMobile() && !Engine_Api::_()->getApi('mobile', 'ynresponsive1') -> isTablet()) 
    {
      return false;
    }
		// Check tablet here?
    if( !empty($params['notablet']) && Engine_Api::_()->getApi('mobile', 'ynresponsive1') -> isTablet()) 
    {
      return false;
    }
			
		// Check fullsite here?
    if( !empty($params['nofullsite']) && !Engine_Api::_()->getApi('mobile', 'ynresponsive1') -> isTablet()
       && !Engine_Api::_()->getApi('mobile', 'ynresponsive1') -> isMobile()) 
    {
      return false;
    }
	
	//Update to support Business plugin
	// check to hide menus
	$business_session = new Zend_Session_Namespace('ynbusinesspages_business');
	$businessId = $business_session -> businessId;
	if($businessId)
	{
		if(in_array($row -> name, array('ynbusinesspages.main-menu')))
        {
            return FALSE;
        }
	}

    return $data;
  }

  public function deletePage(Core_Model_Page $page)
  {
    $contentTable = Engine_Api::_()->getDbtable('content', 'core');
    $contentTable->delete(array(
      'page_id = ?' => $page->page_id,
    ));
    
    $page->delete();

    return $this;
  }
}