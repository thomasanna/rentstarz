<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Controller.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Core
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Core_Widget_StatisticsController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
    // members, friends
    $table = Engine_Api::_()->getItemTable('user');
    $tableName = $table->info('name');
    
    $viewer     = Engine_Api::_()->user()->getViewer();
    $viewer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); 
    
    $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer); 
		if( !empty($fieldsByAlias['profile_type']) )
		{
		  $optionId = $fieldsByAlias['profile_type']->getValue($viewer);
		   $profile_type_id = $optionId->value; 
		}
	$this->view->profile_type_id = $profile_type_id;
	
	$fieldsTable = Engine_Api::_()->fields()->getTable('user', 'values');
    $fieldsTableName = $fieldsTable->info('name'); 
    
    
    $propertyRequirementTable =  Engine_Api::_()->getDbtable('propertyrequirement', 'user');	
    $propertyRequirementTableName = $propertyRequirementTable->info('name');
    
    $propertyTable =  Engine_Api::_()->getDbtable('propertylist', 'user');	 
    $propertyTableName = $propertyTable->info('name'); 
    
    $dropboxfileTable = Engine_Api::_()->getDbtable('dropboxfiles', 'user');
    $dropboxfileTableName = $dropboxfileTable->info('name'); 
		
    if($profile_type_id == 4){ //landlord
		
	    $select = $table->select()   
	    ->from($tableName)   
	    ->joinLeft($fieldsTableName, "$tableName.user_id = $fieldsTableName.item_id",null) 
		->where("{$tableName}.enabled = ?", 1)
		->where("{$fieldsTableName}.field_id = ?", 1)
		->where("{$fieldsTableName}.value = ?", 1); 
         

      
        $tenantsData = Zend_Paginator::factory($select);
		 
	    $this->view->tenantsCount = $tenantsCount = $tenantsData->getTotalItemCount();	 
	    
	    $select_matching_requirements = $propertyRequirementTable->select()  
	                               
	        ->from($propertyRequirementTableName)   
   
            ->joinLeft($propertyTableName, "$propertyRequirementTableName.country_id = $propertyTableName.country_id
                                           AND $propertyRequirementTableName.state_id=$propertyTableName.state_id
                                           AND $propertyRequirementTableName.city_id=$propertyTableName.city_id                                          
                                           AND ($propertyRequirementTableName.budget=$propertyTableName.price 
                                           OR  ($propertyTableName.price BETWEEN $propertyRequirementTableName.budget
                                           AND $propertyRequirementTableName.budget_range_to))",null)
			->where("{$propertyTableName}.landlord_enable = ?", 1)
			->where("{$propertyTableName}.property_owner_id = ?", $viewer_id)
			->group("{$propertyRequirementTableName}.id"); 
	    
	    
	    $matching_requirementsData = Zend_Paginator::factory($select_matching_requirements); 

	    $this->view->matching_requirementsCount = $matching_requirementsCount = $matching_requirementsData->getTotalItemCount();	
	    
	    
        $mypropertySelect   =   $propertyTable->select()
								->from($propertyTableName)   
								->where("{$propertyTableName}.property_owner_id = ?", $viewer_id); 
								
        $mypropertysData = Zend_Paginator::factory($mypropertySelect);       
        
        $this->view->mypropertiesCount = $mypropertiesCount = $mypropertysData->getTotalItemCount();	 
        
        
        $mydocumentsSelect   =   $dropboxfileTable->select()
								->from($dropboxfileTableName)   
								->where("{$dropboxfileTableName}.file_owner_id = ?", $viewer_id); 
								
	    $mydocumentsData = Zend_Paginator::factory($mydocumentsSelect);    
								
	    $this->view->mydocumentsCount = $mydocumentsCount = $mydocumentsData->getTotalItemCount();	
	
		 
	}
    
    elseif($profile_type_id == 1){ // tenants
		
		/*$select = $fieldsTable->select()      
        ->where("{$fieldsTableName}.field_id = ?", 1)
        ->where("{$fieldsTableName}.value = ?", 4); */ 
        $select = $table->select()   
	    ->from($tableName)   
	    ->joinLeft($fieldsTableName, "$tableName.user_id = $fieldsTableName.item_id",null) 
		->where("{$tableName}.enabled = ?", 1)
		->where("{$fieldsTableName}.field_id = ?", 1)
		->where("{$fieldsTableName}.value = ?", 4); 
        
        $landlordsData = Zend_Paginator::factory($select);
		 
	    $this->view->landlordCount = $landlordCount = $landlordsData->getTotalItemCount();
	    
	    
	    
	    
	    $select_matching_properties = $table->select()  
	                ->from($tableName)  
					->joinLeft($propertyTableName, $propertyTableName.'.property_owner_id = '.$tableName.'.user_id', null)
					->joinRight($propertyRequirementTableName, "$propertyRequirementTableName.country_id = $propertyTableName.country_id
														   AND $propertyRequirementTableName.state_id=$propertyTableName.state_id
														   AND $propertyRequirementTableName.city_id=$propertyTableName.city_id														
														   AND ($propertyRequirementTableName.budget=$propertyTableName.price 
														   OR ($propertyTableName.price BETWEEN $propertyRequirementTableName.budget
														   AND $propertyRequirementTableName.budget_range_to))",null)

					->where("({$propertyTableName}.enable = ?", 1)
					->orWhere("{$tableName}.bg_verified = ?)", 1)
					->where("{$propertyTableName}.landlord_enable = ?", 1)   
					->where("{$propertyRequirementTableName}.tenant_id = ?", $viewer_id)
				    ->group("{$propertyTableName}.property_owner_id");
	    
	    $matchingPropertiesData = Zend_Paginator::factory($select_matching_properties);
		 
	    $this->view->matchingPropertiesCount = $matchingPropertiesCount = $matchingPropertiesData->getTotalItemCount(); 
	   
	    
	    $propertySelect   =   $propertyTable->select()
								->from($propertyTableName);   
								
								
        $propertysData = Zend_Paginator::factory($propertySelect);       
        
        $this->view->propertyCount = $propertyCount = $propertysData->getTotalItemCount();
        
        $mydocumentsSelect   =   $dropboxfileTable->select()
								->from($dropboxfileTableName)   
								->where("{$dropboxfileTableName}.file_owner_id = ?", $viewer_id); 
								
	    $mydocumentsData = Zend_Paginator::factory($mydocumentsSelect);    
								
	    $this->view->mydocumentsCount = $mydocumentsCount = $mydocumentsData->getTotalItemCount();	 
		
	}
	
	else{ //services
		
		
		 $tenantSelect = $fieldsTable->select()      
        ->where("{$fieldsTableName}.field_id = ?", 1)
        ->where("{$fieldsTableName}.value = ?", 1);  

      
        $tenantsData = Zend_Paginator::factory($tenantSelect);
		 
	    $this->view->tenantsCount = $tenantsCount = $tenantsData->getTotalItemCount();	 
	    
	    
	    $landlordSelect = $fieldsTable->select()      
        ->where("{$fieldsTableName}.field_id = ?", 1)
        ->where("{$fieldsTableName}.value = ?", 4);  
        
        $landlordsData = Zend_Paginator::factory($landlordSelect);
		 
	    $this->view->landlordCount = $landlordCount = $landlordsData->getTotalItemCount();
		
		
		
	}
    
    
    
    
    
    $info = $table->select()
      ->from($table, array(
        'COUNT(*) AS count',
        'SUM(member_count) AS friends',
      ))
      ->where('enabled = ?', true)
      ->query()
      ->fetch();
    $this->view->member_count = $info['count'];
    $this->view->friend_count = $info['friends'];

    $friendship_types = Engine_Api::_()->getDbtable('membership', 'user');
    if( $friendship_types->isReciprocal() ) {
      $this->view->friend_count = round($info['friends'] / 2);
    }

    // posts
    $table = Engine_Api::_()->getDbTable('actions', 'activity');
    $this->view->post_count = $table->select()
      ->from($table, array(
        'COUNT(*) AS count',
      ))
      ->query()
      ->fetchColumn();

    // comments
    $comment_count = 0;
    
    $table = Engine_Api::_()->getDbTable('comments', 'activity');
    $comment_count += (int) $table->select()
      ->from($table, array(
        'COUNT(*) AS count',
      ))
      ->query()
      ->fetchColumn();

    $table = Engine_Api::_()->getDbTable('comments', 'core');
    $comment_count += (int) $table->select()
      ->from($table, array(
        'COUNT(*) AS count',
      ))
      ->query()
      ->fetchColumn();

    $this->view->comment_count = $comment_count;

    // plugin hook
    $this->view->hooked_stats = array();
    $events     = Engine_Hooks_Dispatcher::getInstance()->callEvent('onStatistics');
    $events_res = $events->getResponses();
    if (is_array($events_res))
      $this->view->hooked_stats = $events_res;
  }

  public function getCacheKey()
  {
    return Zend_Registry::get('Locale')->toString();
  }
}
