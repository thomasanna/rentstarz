<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Controller.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class User_Widget_ListSignupsController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
    $table = Engine_Api::_()->getDbtable('users', 'user');
    $table = Engine_Api::_()->getDbtable('users', 'user');
    
    
    
    
    $table = Engine_Api::_()->getItemTable('user');   
    
    $tableName = $table->info('name');
    
    $fieldsTable = Engine_Api::_()->fields()->getTable('user', 'values');
    $fieldsTableName = $fieldsTable->info('name'); 
    
    $propertyRequirementTable =  Engine_Api::_()->getDbtable('propertyrequirement', 'user');	
    $propertyRequirementTableName = $propertyRequirementTable->info('name');
    
    $propertyTable =  Engine_Api::_()->getDbtable('propertylist', 'user');	 
    $propertyTableName = $propertyTable->info('name'); 
    
    $viewer = Engine_Api::_()->user()->getViewer();
    $viewerId	=	$viewer->getIdentity();
    
    
   

    $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer); 
     
    if( !empty($fieldsByAlias['profile_type']) )
			{
			  $optionId = $fieldsByAlias['profile_type']->getValue($viewer);
			  $profile_type_id = $optionId->value; 
			} 
			
	if($profile_type_id  == 4){ // landlord
		
		
	$select_newest_matching_tenants = $table->select()
    ->from($tableName)
    ->where($tableName.'.search = ?', 1)
    ->where($tableName.'.enabled = ?', 1)
    ->order($tableName.'.creation_date DESC');

    $select_newest_matching_tenants 
    ->joinLeft($fieldsTableName, $fieldsTableName.'.item_id = '.$tableName.'.user_id', null)
    ->joinLeft($propertyRequirementTableName, $propertyRequirementTableName.'.tenant_id = '.$tableName.'.user_id', null)
    ->joinLeft($propertyTableName, "$propertyRequirementTableName.country_id = $propertyTableName.country_id
                                           AND $propertyRequirementTableName.state_id=$propertyTableName.state_id
                                           AND $propertyRequirementTableName.city_id=$propertyTableName.city_id
                                           AND $propertyRequirementTableName.housing_type=$propertyTableName.housing_type
                                           AND $propertyRequirementTableName.pets_allowed=$propertyTableName.has_pets
                                           AND $propertyRequirementTableName.pets_type=$propertyTableName.pets_type
                                           AND ($propertyRequirementTableName.budget=$propertyTableName.price 
                                           OR ($propertyTableName.price BETWEEN $propertyRequirementTableName.budget
                                           AND $propertyRequirementTableName.budget_range_to))",null)
    ->where("{$fieldsTableName}.field_id = ?", 1)
    ->where("{$fieldsTableName}.value = ?", 1)
    //->where("{$propertyTableName}.enable = ?", 1)
   // ->orWhere("{$tableName}.bg_verified = ?)", 1)
   ->where("{$propertyTableName}.landlord_enable = ?", 1)
    ->group("{$propertyRequirementTableName}.tenant_id")
    ->where("{$propertyTableName}.property_owner_id = ?", $viewerId);
     $this->view->paginator = $paginator = Zend_Paginator::factory($select_newest_matching_tenants);
    // echo $paginator->getTotalItemCount();exit;
     if($paginator->getTotalItemCount()==0){

	$select_newest_tenants = $table->select()
      ->from($tableName)
      ->where($tableName.'.search = ?', 1)
      ->where($tableName.'.enabled = ?', 1)
      ->order($tableName.'.creation_date DESC');
	$select_newest_tenants 
      ->joinLeft($fieldsTableName, $fieldsTableName.'.item_id = '.$tableName.'.user_id', null)
      ->joinLeft($propertyRequirementTableName, $propertyRequirementTableName.'.tenant_id = '.$tableName.'.user_id', null)
      ->where("{$fieldsTableName}.field_id = ?", 1)
      ->where("{$fieldsTableName}.value = ?", 1)
      ->group("{$propertyRequirementTableName}.tenant_id");
      $this->view->paginator = $paginator = Zend_Paginator::factory($select_newest_tenants);
   }
   
    }
    elseif($profile_type_id  == 1){ // tenant
      
    $select_newest_matching_landlords = $table->select()
    ->from($tableName)
    ->where($tableName.'.search = ?', 1)
    ->where($tableName.'.enabled = ?', 1)
    ->order($tableName.'.creation_date DESC');
      
    $select_newest_matching_landlords 
    ->joinLeft($fieldsTableName, $fieldsTableName.'.item_id = '.$tableName.'.user_id', null)
    ->joinLeft($propertyTableName, $propertyTableName.'.property_owner_id = '.$tableName.'.user_id', null)
    ->joinRight($propertyRequirementTableName, "$propertyRequirementTableName.country_id = $propertyTableName.country_id
                                           AND $propertyRequirementTableName.state_id=$propertyTableName.state_id
                                           AND $propertyRequirementTableName.city_id=$propertyTableName.city_id
                                           AND $propertyRequirementTableName.housing_type=$propertyTableName.housing_type
                                           AND $propertyRequirementTableName.pets_allowed=$propertyTableName.has_pets
                                           AND $propertyRequirementTableName.pets_type=$propertyTableName.pets_type
                                           AND ($propertyRequirementTableName.budget=$propertyTableName.price 
                                           OR ($propertyTableName.price BETWEEN $propertyRequirementTableName.budget
                                           AND $propertyRequirementTableName.budget_range_to))",null)
    ->where("{$fieldsTableName}.field_id = ?", 1)
    ->where("{$fieldsTableName}.value = ?", 4)
    ->where("({$propertyTableName}.enable = ?", 1)
    ->orWhere("{$tableName}.bg_verified = ?)", 1)
    ->where("{$propertyTableName}.landlord_enable = ?", 1)
    ->group("{$propertyTableName}.property_owner_id")
    ->where("{$propertyRequirementTableName}.tenant_id = ?", $viewerId);
     
   
    $this->view->paginator = $paginator = Zend_Paginator::factory($select_newest_matching_landlords);  
    if($paginator->getTotalItemCount()==0)
    { 
	$select_newest_landlords = $table->select()
    ->from($tableName)
    ->where($tableName.'.search = ?', 1)
    ->where($tableName.'.enabled = ?', 1)
    ->order($tableName.'.creation_date DESC');
	
    $select_newest_landlords //show landlord having property
    ->joinLeft($fieldsTableName, $fieldsTableName.'.item_id = '.$tableName.'.user_id', null)
    ->joinLeft($propertyTableName, $propertyTableName.'.property_owner_id = '.$tableName.'.user_id', null)
    ->where("{$fieldsTableName}.field_id = ?", 1)
    ->where("{$fieldsTableName}.value = ?", 4)
    ->where("({$propertyTableName}.enable = ?", 1)
    ->orWhere("{$tableName}.bg_verified = ?)", 1)
    ->where("{$propertyTableName}.landlord_enable = ?", 1)
    ->group("{$propertyTableName}.property_owner_id");
    $this->view->paginator = $paginator = Zend_Paginator::factory($select_newest_landlords);
   }
   
    }
    //service
    else{
		 /*$select = $table->select()
      ->from($tableName)
      ->where($tableName.'.search = ?', 1)
      ->where($tableName.'.enabled = ?', 1)
      ->order($tableName.'.creation_date DESC');
	   $select 
    ->joinLeft($fieldsTableName, $fieldsTableName.'.item_id = '.$tableName.'.user_id', null)
    ->where("{$fieldsTableName}.field_id = ?", 1)
    ->where("({$fieldsTableName}.value = ?", 1)
    ->orWhere("{$fieldsTableName}.value = ?)", 4);*/
    $this->view->paginator = $paginator = Zend_Paginator::factory($select);
	}		

 

    // Set item count per page and current page number
    $paginator->setItemCountPerPage($this->_getParam('itemCountPerPage', 4));
    $paginator->setCurrentPageNumber($this->_getParam('page', 1));

    // Do not render if nothing to show
    if( $paginator->getTotalItemCount() <= 0 ) {
      return $this->setNoRender();
    }
    
    
    
    $table = Engine_Api::_()->getItemTable('user');
    $onlineTable = Engine_Api::_()->getDbtable('online', 'user');
    
    $tableName = $table->info('name');
    $onlineTableName = $onlineTable->info('name');

    
    $viewer = Engine_Api::_()->user()->getViewer();
    $viewerId	=	$viewer->getIdentity();

    $online_select = $table->select()
      //->from($onlineTableName, null)
      //->joinLeft($tableName, $onlineTable.'.user_id = '.$tableName.'.user_id', null)
      ->from($tableName)
      ->joinRight($onlineTableName, $onlineTableName.'.user_id = '.$tableName.'.user_id', null)     
      ->where($onlineTableName.'.user_id > ?', 0)
      ->where($onlineTableName.'.active > ?', new Zend_Db_Expr('DATE_SUB(NOW(),INTERVAL 20 MINUTE)'))
      ->where($tableName.'.search = ?', 1)
      ->where($tableName.'.enabled = ?', 1)
      ->where($onlineTableName.'.user_id != ?', $viewerId) // to hide logged in user from showing in member online widget
      ->order($onlineTableName.'.active DESC')
      ->group($onlineTableName.'.user_id')
      ;
     
     $online_users_Data=$table->fetchAll($online_select);
    // print_r($online_users_Data);exit;
   
   
  $this->view->online_users =$online_users_Data;
  }

  public function getCacheKey()
  {
    $viewer = Engine_Api::_()->user()->getViewer();
    $translate = Zend_Registry::get('Zend_Translate');
	$locale = Zend_Registry::get('Locale');
    return $viewer->getIdentity() . $translate->getLocale() . $locale->toString();
  }

  public function getCacheSpecificLifetime()
  {
    return 120;
  }
}
