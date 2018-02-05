<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: User.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class User_View_Helper_User extends Zend_View_Helper_Abstract
{
  public function user($identity)
  {
    $user = Engine_Api::_()->user()->getUser($identity);
    if( !$user )
    {
      throw new Zend_View_Exception('User does not exist');
    }
    return $user;
  }
  

  public function onlineusers(){
	  
    $table = Engine_Api::_()->getItemTable('user');
    $onlineTable = Engine_Api::_()->getDbtable('online', 'user');
    
    $tableName = $table->info('name');
    $onlineTableName = $onlineTable->info('name');

    
    $viewer = Engine_Api::_()->user()->getViewer();
    $viewerId	=	$viewer->getIdentity();

    $online_select = $table->select()
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

   
   

   $online_user_id = array();
   foreach($online_users_Data as $row):

   $online_user_id[]=$row['user_id'];
   endforeach;
  
   return $online_user_id;
  
   }

  	public function getpropertycountries(){
		

	  $aResult	=	array();
	
	  $country_table   =  Engine_Api::_()->getDbtable('propertycountry', 'user');
	  $country_list = $country_table->fetchAll(); 
    $i=0;
    foreach($country_list as $list)
    {
		$aResult[$i]['id']	=	$list['country_id'];
		$aResult[$i]['country']	=	$list['prty_country'];
		$i++;
	}
   return $aResult;
    
	}
  
  	public function getpropertystates(){
		
	 
	  $aResult	=	array();
	  $id	=	1; //united states
	  
	  $state_table   = Engine_Api::_()->getDbtable('propertystate', 'user');
	  $state_list = $state_table->fetchAll(array(	
      'country_id = ?' => $id,
    )); 
    $i=0;
    foreach($state_list as $list)
    {
		$aResult[$i]['id']	    =	$list['state_id'];
		$aResult[$i]['state']	=	$list['prty_state'];
		$i++;
	}
	return $aResult;
  //  echo json_encode($aResult);
	}
	public function getmemberpackage($userId){
		$userPackagesTable             =  Engine_Api::_()->getDbtable('Userpackages', 'user');
		$userPackagesData              = $userPackagesTable->fetchRow($userPackagesTable->select()
		                                     ->where('user_id = ?', $userId)
		                                     ->where('status = ?', 'active')
		                                     ->order('payment_id DESC')
		                                     );
       return $userPackagesData;
		
	}

	public function getpropertycount($userId){
  	$propertyTable      =  Engine_Api::_()->getDbtable('propertylist', 'user');
    $propertylists       = $propertyTable->fetchAll($propertyTable->select()->where('property_owner_id = ?', $userId));
    return count($propertylists);
   }
   public function getscoutcount($userId){
      $FeedPreferenceUnitTable            = Engine_Api::_()->getDbtable('Feedpreferenceunit', 'user');
      $FeedPreferenceUnitDataSelect       = $FeedPreferenceUnitTable->select()
                                              ->where('userid = ?', $userId);
     $FeedPreferenceUnitData = $FeedPreferenceUnitTable->fetchAll($FeedPreferenceUnitDataSelect);
     return count($FeedPreferenceUnitData);

  }
  	
  	public function getuserDetails($userId)
  	{
		
		$aResult	=	array();

		if($userId):
		
		//echo  $userId;exit;
		$userTable      = Engine_Api::_()->getDbtable('users', 'user');
        $userDetails   = $userTable->fetchRow($userTable->select()->where('user_id = ?', $userId));
		date_default_timezone_set($userDetails->timezone);
		
		 //profile type 
     	$fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($userDetails); 

		if( !empty($fieldsByAlias['profile_type']) )
		{
		  $optionId = $fieldsByAlias['profile_type']->getValue($userDetails);
		   $profile_type_id = $optionId->value; 
		}
		
		if($profile_type_id  == 4){ //profile type is landlord or not
			$is_landlord = 1;
			$aResult['profile_type'] ='landlord';
		}
		if($profile_type_id  == 1){ //profile type is tenant or not
			$is_landlord = 1;
			$aResult['profile_type'] ='tenant';
		}
	    
		// package
		$userPackagesTable             =  Engine_Api::_()->getDbtable('Userpackages', 'user');
		$userPackagesData              = $userPackagesTable->fetchRow($userPackagesTable->select()
		                                     ->where('user_id = ?', $userId)
		                                     ->where('status = ?', 'active')
		                                     ->order('payment_id DESC')
		                                     );
		$aResult['user_package']       =     $userPackagesData->package_type;                                

       
       
		// video payment
		$current_date=date("Y-m-d");
		$videoPaymentTable =  Engine_Api::_()->getDbtable('Videopayment', 'user');
	    $videoPayment_select = $videoPaymentTable->select()
	                                             ->where('user_id = ?', $userId)
	                                             ->where('DATE(created_at) = ?',$current_date )
	    ;	
	    $videoPaymentData = $videoPaymentTable->fetchAll($videoPayment_select);

        if(count($videoPaymentData)>0)
        {
             $aResult['video_payment'] ="paid";
		}else{
			
		     $aResult['video_payment'] ="not_paid";
		}

		endif;
		return $aResult;

	 
	
	}

	
}
