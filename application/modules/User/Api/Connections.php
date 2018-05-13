<?php

class User_Api_Connections extends Core_Api_Abstract
{


    public function searchpropertyajaxResults ($limit,$offset,$aData){



        $view = Zend_Registry::get('Zend_View');
        $view = clone $view;
        $view->clearVars();
        $user_id=Engine_Api::_()->user()->getViewer()->getIdentity();

        $propertyTable =  Engine_Api::_()->getDbtable('propertylist', 'user');
        $propertyimageTable =  Engine_Api::_()->getDbtable('propertyimages', 'user');
        $table = Engine_Api::_()->getItemTable('user');

        if($aData['is_search'] ==1){
        //print_r($aData); exit;
        $is_search = $aData['is_search'];
        $country = $aData['country'];
        $state = $aData['state'];
        $city = $aData['city'];
        $no_of_rooms = $aData['no_of_rooms'];
        $rental_type = $aData['rental_type'];
        $housing_type = $aData['housing_type'];
        $zipcode = $aData['zipcode'];
        $price = $aData['price'];
        $allowed_pets = $aData['allowed_pets'];
        $pets_type = $aData['pets_type'];
        $keyword = $aData['keyword'];


        $propertyTableName = $propertyTable->info('name');
        $propertyimageTableName = $propertyimageTable->info('name');
        $userTableName = $table->info('name');

        $select   =   $propertyTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('plist'=>'engine4_property_list',))
                        ->joinLeft(array('pimages'=>'engine4_property_images'),'plist.id=pimages.property_id',array('image'))
                        ->joinLeft(array('user'=>'engine4_users'),'plist.property_owner_id=user.user_id',array('email','displayname'))
                        ->joinLeft(array('country'=>'engine4_property_countries',),'plist.prty_country_id=country.country_id',array('prty_country'))
                        ->joinLeft(array('state'=>'engine4_property_states',),'plist.prty_state_id=state.state_id',array('prty_state'))
                        ->joinLeft(array('city'=>'engine4_property_city',),'plist.prty_city_id=city.city_id',array('prty_city','latitude','longitude'))
                        ->joinLeft(array('grant'=>'engine4_property_granted',),'grant.property_id=plist.id AND grant.end_date =""',array('granted','status'))
                        ->where('(plist.enable = ?', 1)
                        ->orWhere('user.bg_verified  = ?)', 1)
                        ->where('pimages.type=?' , 'image')
                        ->where('plist.landlord_enable=?' , 1)
                        ->group('plist.id')
                        ->order('plist.id DESC');



        $searchDefault = true;


        if( isset($country) && !empty($country) ) {

             $select->where('plist.prty_country =?' , $country);

        }
        if( isset($state) && !empty($state) ) {

            $select->where('plist.prty_state =?' , $state);

        }
        if( isset($city) && !empty($city) ) {

            $select->where('plist.prty_city =?' , $city);
        }
        if( isset($no_of_rooms) && !empty($no_of_rooms) ) {

            $select->where('plist.no_of_rooms =?' , $no_of_rooms);
        }
        if( isset($housing_type) && !empty($housing_type) ) {

            $select->where('plist.housing_type =?' , $housing_type);

        }
        if( isset($rental_type) && !empty($rental_type) ) {

            $select->where('plist.rental_type =?' , $rental_type);

        }
        if( isset($zipcode) && !empty($zipcode) ) {

            $select->where('plist.zipcode =?' , $zipcode);

        }
        if( isset($keyword) && !empty($keyword) ) {
          $select->where('plist.property_name LIKE ?' ,  "%{$keyword}%");

        }
        if( isset($price) && !empty($price) ) {

            if($price == "500 - 1,000")
                {
                  $select->where('plist.price >=?' , 500);
                  $select->where('plist.price <=?' , 1000);

               }
               elseif($price=="1,001 - 1,800")
               {
                  $select->where('plist.price >=?' , 1001);
                  $select->where('plist.price <=?' , 1800);
               }
               elseif($price=="1,801- 2,000")
               {
                  $select->where('plist.price >=?' , 1801);
                  $select->where('plist.price <=?' , 2000);
               }
               elseif($price=="2,001- 2,800")
               {
                  $select->where('plist.price >=?' , 2001);
                  $select->where('plist.price <=?' , 2800);
               }
               elseif($price=="2,801- 3,000")
               {
                  $select->where('plist.price >=?' , 2801);
                  $select->where('plist.price <=?' , 3000);
               }
               elseif($price=="3,001- 3,800")
               {
                  $select->where('plist.price >=?' , 3001);
                  $select->where('plist.price <=?' , 3800);
               }
               elseif($price=="3,801- 4,000")
               {
                  $select->where('plist.price >=?' , 3801);
                  $select->where('plist.price <=?' , 4000);
               }
               elseif($price=="4,001- 4,800")
               {
                  $select->where('plist.price >=?' , 4001);
                  $select->where('plist.price <=?' , 4800);
               }
               elseif($price=="4,801- 5,000")
               {
                  $select->where('plist.price >=?' , 4801);
                  $select->where('plist.price <=?' , 5000);
               }
               elseif($price >"5,000")
               {

                    $select->where('plist.price >?' , 5000);
               }
               else{ $select->where('plist.price >?' , 5000); }

        }
        if( isset($allowed_pets) && !empty($allowed_pets) ) {

            $select->where('plist.has_pets =?' , $allowed_pets);

        }
        if( isset($pets_type) && !empty($pets_type) ) {

            $select->where('plist.pets_type =?' , $pets_type);

        }



        $select->limit($limit,$offset);
        //$paginator = Zend_Paginator::factory($select);
        $propertyData=$propertyTable->fetchAll($select);

        $view->propertyData=$propertyData;

        }

        else{


       /* $propertySelect   =   $propertyTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('plist'=>'engine4_property_list',))
                        ->joinLeft(array('pimages'=>'engine4_property_images'),'plist.id=pimages.property_id',array('image'))
                        ->joinLeft(array('user'=>'engine4_users'),'plist.property_owner_id=user.user_id',array('email','displayname'))
                        ->where('plist.enable=?' , 1)
                        ->where('plist.landlord_enable=?' , 1)
                        ->group('plist.id')
                        ->order('plist.created_at DESC')->limit($limit,$offset); */

        $propertySelect   =   $propertyTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('plist'=>'engine4_property_list',))
                        ->joinLeft(array('pimages'=>'engine4_property_images'),'plist.id=pimages.property_id',array('image'))
                        ->joinLeft(array('user'=>'engine4_users'),'plist.property_owner_id=user.user_id',array('email','displayname'))
                        ->joinLeft(array('country'=>'engine4_property_countries',),'plist.prty_country_id=country.country_id',array('prty_country'))
                        ->joinLeft(array('state'=>'engine4_property_states',),'plist.prty_state_id=state.state_id',array('prty_state'))
                        ->joinLeft(array('city'=>'engine4_property_city',),'plist.prty_city_id=city.city_id',array('prty_city','latitude','longitude'))
                        ->joinLeft(array('grant'=>'engine4_property_granted',),'grant.property_id=plist.id AND grant.end_date =""',array('granted','status'))
                        ->where('(plist.enable = ?', 1)
                        ->orWhere('user.bg_verified  = ?)', 1)
                        ->where('pimages.type=?' , 'image')
                        ->where('plist.landlord_enable=?' , 1)
                        ->group('plist.id')
                        ->order('plist.id DESC')->limit($limit,$offset);

        $propertyData=$propertyTable->fetchAll($propertySelect);


        $view->propertyData = $propertyData;
      }

    $table = Engine_Api::_()->getItemTable('user');
    $onlineTable = Engine_Api::_()->getDbtable('online', 'user');

    $tableName = $table->info('name');
    $onlineTableName = $onlineTable->info('name');


    $viewer = Engine_Api::_()->user()->getViewer();
    $viewerId   =   $viewer->getIdentity();

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


    $view->online_users =$online_users_Data;
        $content = $view->render('_searchpropertyResult.tpl');
        $result = array('html'=>$content);
        echo json_encode($result);




    }

    public function availablepropertyData(){
        $view = Zend_Registry::get('Zend_View');
        $view = clone $view;
        $view->clearVars();

        $table = Engine_Api::_()->getItemTable('user');
        $userTableName = $table->info('name');

        $select_notgranted   =   $table->select()
                            ->setIntegrityCheck(false)
                            ->from(array('user'=>'engine4_users',array('user_id','user_name','email')))
                            ->columns(array('count_available' => new Zend_Db_Expr('COUNT(user.user_id)')))
                            ->joinLeft(array('search_field'=>'engine4_user_fields_search'),'search_field.item_id=user.user_id',null)
                            ->joinLeft(array('plist'=>'engine4_property_list',),'plist.property_owner_id=user.user_id',array('granted','property_owner_id'))
                            ->where('user.search=?' , 1)
                            ->where('plist.granted=?' , 0)
                            ->where('search_field.profile_type =?' , '4')
                            ->group('user.user_id');

        $availableproperty_Data=$table->fetchAll($select_notgranted);

        $view->available_property =$availableproperty_Data;
        $content = $view->render('_availablepropertiesResult.tpl');
        $result = array('html'=>$content);
        echo json_encode($result);
    }


        public function rentedpropertyData(){
        $view = Zend_Registry::get('Zend_View');
        $view = clone $view;
        $view->clearVars();

        $table = Engine_Api::_()->getItemTable('user');
        $userTableName = $table->info('name');

        $select_rented   =   $table->select()
                            ->setIntegrityCheck(false)
                            ->from(array('user'=>'engine4_users',array('user_id','user_name','email')))
                            ->columns(array('count_rented' => new Zend_Db_Expr('COUNT(user.user_id)')))
                            ->joinLeft(array('search_field'=>'engine4_user_fields_search'),'search_field.item_id=user.user_id',null)
                            ->joinLeft(array('plist'=>'engine4_property_list',),'plist.property_owner_id=user.user_id',array('granted','property_owner_id'))
                            ->where('user.search=?' , 1)
                            ->where('plist.granted=?' , 1)
                            ->where('search_field.profile_type =?' , '4')
                            ->group('user.user_id');

        $rentedproperty_Data=$table->fetchAll($select_rented);

        $view->rented_property =$rentedproperty_Data;
        $content = $view->render('_rentedpropertiesResult.tpl');
        $result = array('html'=>$content);
        echo json_encode($result);
    }

    public function galleryphotoajaxResults ($aData){

        $view = Zend_Registry::get('Zend_View');
        $view = clone $view;
        $view->clearVars();
        $subjectId = $aData['subjectId'];

        $PhotogalleryTable = Engine_Api::_()->getDbtable('photogallery', 'user');

        $PhotogallerySelect = $PhotogalleryTable->select()
                                    ->where('user_id = ?', $subjectId);

        $PhotogalleryData = $PhotogalleryTable->fetchAll($PhotogallerySelect);

        $totalPhotogalleryData = count($PhotogalleryData);


        $view->PhotogalleryData =$PhotogalleryData;
        $content = $view->render('_galleryphoto.tpl');
        $result = array('html'=>$content,'totalPhotogalleryData' => $totalPhotogalleryData);
        echo json_encode($result);

    }

    public function getlikedusersajaxResults($viewer_id){


        $view = Zend_Registry::get('Zend_View');
        $view = clone $view;
        $view->clearVars();

        $likeuserTable =  Engine_Api::_()->getDbtable('likeuser', 'user');

        $likeuserData = $likeuserTable->fetchAll($likeuserTable->select()->where('type = ?', 'user')
        ->where('subject_id = ?', $viewer_id));

        $view->likeuserData =$likeuserData;
        $content = $view->render('_likedusermodal.tpl');
        $result = array('html'=>$content);
        echo json_encode($result);


    }
    public function getlikedpropertiesajaxResults($viewer_id){


        $view = Zend_Registry::get('Zend_View');
        $view = clone $view;
        $view->clearVars();

        $likepropertyTable =  Engine_Api::_()->getDbtable('likeuser', 'user');

        $likepropertyData = $likepropertyTable->fetchAll($likepropertyTable->select()->where('type = ?', 'property')
        ->where('subject_id = ?', $viewer_id));

        $view->likepropertyData =$likepropertyData;
        $content = $view->render('_likedpropertymodal.tpl');
        $result = array('html'=>$content);
        echo json_encode($result);


    }

    public function getviewallcommentsajaxResults($action_id,$poster_id,$status,$actionSubjectId){

        $view = Zend_Registry::get('Zend_View');
        $view = clone $view;
        $view->clearVars();

        $postcommentTable =  Engine_Api::_()->getDbtable('Postcomments', 'user');


        if($status=="view_more"){
        $postcommentData = $postcommentTable->fetchAll($postcommentTable->select()
        ->where('actionId = ?',$action_id )
        ->order('commentId DESC')
     //   ->where('posterId = ?',$poster_id )
        );

        }
        else
        {
          $postcommentData = $postcommentTable->fetchAll($postcommentTable->select()
        ->where('actionId = ?',$action_id )
      //  ->where('posterId = ?',$poster_id )
        ->order('commentId DESC')
        ->limit(2)
        );
        }

        $view->postcommentData =$postcommentData;
        $view->action_id       =$action_id;
        $view->status          =$status;
        $view->actionSubjectId =$actionSubjectId;


        $fetchalldata=$postcommentTable->fetchAll($postcommentTable->select()
        ->where('actionId = ?',$action_id ));
        $countcmt=count($fetchalldata);

         $view->comment_count =$countcmt;


      //  echo '<pre>'; print_r($postcommentData); exit;
        $content = $view->render('_allcomments.tpl');
        $result = array('html'=>$content);
        echo json_encode($result);




    }
    public function getrentalapplicationsearchajaxResults($viewer_id,$property_id){
		
		$view = Zend_Registry::get('Zend_View');
        $view = clone $view;
        $view->clearVars();
		
		
		
     /*   $viewer        = Engine_Api::_()->user()->getViewer();
        $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
        if( !empty($fieldsByAlias['profile_type']) ){
              $optionId        = $fieldsByAlias['profile_type']->getValue($viewer);
              $profile_type_id = $optionId->value;
        }
        if($profile_type_id != 4){ //if not landlord
            return $this->_forward('notfound');
        }*/

        $propertyRequestTable =  Engine_Api::_()->getDbtable('propertyrequest', 'user');


        if($property_id!=0){
        $propertyReq_select = $propertyRequestTable->select()
                              ->setIntegrityCheck(false)
                               ->from(array('prequest'=>'engine4_property_request',))
                               ->joinLeft(array('plist'=>'engine4_property_list',),'plist.id=prequest.property_id',array('property_name','rental_type','granted'))
                               ->joinLeft(array('user'=>'engine4_users'),'plist.property_owner_id=user.user_id',array('bg_verified'))
                               ->joinLeft(array('fields'=>'engine4_user_fields_values',),'prequest.tenant_id=fields.item_id',array('value'))
                               ->where('prequest.landlord_id = ?', $viewer_id)
                               ->where('plist.landlord_enable    = ?', 1)
                               ->where('(plist.enable = ?', 1)
                               ->orWhere('user.bg_verified   = ?)', 1)
                               ->where('plist.granted    = ?', 0)
                               ->where('fields.field_id      = ?', 13)
                               ->where('plist.id      = ?',$property_id )
                               ->order('prequest.id DESC');
       }
       else
       {
	    $propertyReq_select = $propertyRequestTable->select()
                              ->setIntegrityCheck(false)
                               ->from(array('prequest'=>'engine4_property_request',))
                               ->joinLeft(array('plist'=>'engine4_property_list',),'plist.id=prequest.property_id',array('property_name','rental_type','granted'))
                               ->joinLeft(array('user'=>'engine4_users'),'plist.property_owner_id=user.user_id',array('bg_verified'))
                               ->joinLeft(array('fields'=>'engine4_user_fields_values',),'prequest.tenant_id=fields.item_id',array('value'))
                               ->where('prequest.landlord_id = ?', $viewer_id)
                               ->where('plist.landlord_enable    = ?', 1)
                               ->where('(plist.enable = ?', 1)
                               ->orWhere('user.bg_verified   = ?)', 1)
                               ->where('plist.granted    = ?', 0)
                               ->where('fields.field_id      = ?', 13)
                               ->order('prequest.id DESC');
	   }                        
                               

        $propertyRequest    =  $propertyRequestTable->fetchAll($propertyReq_select);
        $coverletter_table  =  Engine_Api::_()->getDbtable('coverletter', 'user');
        $userTable          =  Engine_Api::_()->getDbtable('users', 'user');
        foreach($propertyRequest as $data){
            $tenantData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $data['tenant_id']));
            $req_lists[$data['property_id']]['property_name'] = $data['property_name'];
            $req_lists[$data['property_id']]['property_id']   = $data['property_id'];
            $req_lists[$data['property_id']][] =array('id'=>$data['id'],'tenantuser_id' =>$data['tenant_id'],'tenantdisplay_name' => $tenantData->displayname,
                'property_id'=>$data['property_id'],'property_name'=>$data['property_name'],
                'rental_type' =>$data['rental_type'],'created_at'=>$data['created_at'],'landlord_approve'=>$data['landlord_approve'],
                'bio'=>$data['value']);
        }        
         $view->propertyRequestList =$req_lists;




        $this->view->metaTitle           = 'Property Request List';
        $table                           = Engine_Api::_()->getItemTable('user');
        $onlineTable                     = Engine_Api::_()->getDbtable('online', 'user');
        $tableName       = $table->info('name');
        $onlineTableName = $onlineTable->info('name');
        $viewer          = Engine_Api::_()->user()->getViewer();
        $viewerId        = $viewer->getIdentity();
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
      $view->online_users =$online_users_Data;
		

		$content = $view->render('_propertyapplication.tpl');
        $result = array('html'=>$content);
        echo json_encode($result);


    }
    
        public function getapplicationsearchajaxResults($viewer_id,$property_id){
	    
	    
	    $view = Zend_Registry::get('Zend_View');
        $view = clone $view;
        $view->clearVars();
	
	    $propertyRequestTable =  Engine_Api::_()->getDbtable('propertyrequest', 'user');
	    
	    if($property_id!=0){
        $propertyReq_select   = $propertyRequestTable->select()
                              ->setIntegrityCheck(false)
                               ->from(array('prequest'=>'engine4_property_request',))
                               ->joinLeft(array('plist'=>'engine4_property_list',),'plist.id=prequest.property_id',array('property_name','rental_type'))
                               ->joinLeft(array('user'=>'engine4_users'),'plist.property_owner_id=user.user_id',array('bg_verified'))
                                ->joinLeft(array('smartmoveapi_application'=>'engine4_smartmoveapi_application'),'smartmoveapi_application.rental_application_id=prequest.id',array('SmartmoveApplicationId','ApplicationStatus','IdmaVerificationStatus','rental_application_id'))
                               ->joinLeft(array('smartmoveapi_report'=>'engine4_smartmoveapi_report'),'smartmoveapi_report. SmartmoveApplicationId=smartmoveapi_application.SmartmoveApplicationId',array('isReportRequest','isPaid','updated_at','reportResponse'))
                               ->where('prequest.landlord_id = ?', $viewer_id)
                               ->where('plist.landlord_enable    = ?', 1)
                               ->where('(plist.enable = ?', 1)
                               ->orWhere('user.bg_verified   = ?)', 1)
                               ->where('prequest.landlord_approve    = ?', 1)
                               ->where('prequest.admin_approve   = ?', 1)
                               ->where('plist.id      = ?',$property_id )
                               ->order('prequest.property_id DESC');
        }else{
		        $propertyReq_select   = $propertyRequestTable->select()
                              ->setIntegrityCheck(false)
                               ->from(array('prequest'=>'engine4_property_request',))
                               ->joinLeft(array('plist'=>'engine4_property_list',),'plist.id=prequest.property_id',array('property_name','rental_type'))
                               ->joinLeft(array('user'=>'engine4_users'),'plist.property_owner_id=user.user_id',array('bg_verified'))
                                ->joinLeft(array('smartmoveapi_application'=>'engine4_smartmoveapi_application'),'smartmoveapi_application.rental_application_id=prequest.id',array('SmartmoveApplicationId','ApplicationStatus','IdmaVerificationStatus','rental_application_id'))
                               ->joinLeft(array('smartmoveapi_report'=>'engine4_smartmoveapi_report'),'smartmoveapi_report. SmartmoveApplicationId=smartmoveapi_application.SmartmoveApplicationId',array('isReportRequest','isPaid','updated_at','reportResponse'))
                               ->where('prequest.landlord_id = ?', $viewer_id)
                               ->where('plist.landlord_enable    = ?', 1)
                               ->where('(plist.enable = ?', 1)
                               ->orWhere('user.bg_verified   = ?)', 1)
                               ->where('prequest.landlord_approve    = ?', 1)
                               ->where('prequest.admin_approve   = ?', 1)
                               ->order('prequest.property_id DESC');		
		}
        $propertyRequestApproved = $propertyRequestTable->fetchAll($propertyReq_select);
        $userTable               = Engine_Api::_()->getDbtable('users', 'user');
        foreach($propertyRequestApproved as $data){
            $tenantData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $data['tenant_id']));
            $approved_lists[$data['property_id']]['property_name'] = $data->property_name;
            $approved_lists[$data['property_id']]['property_id']   = $data['property_id'];
            $approved_lists[$data['property_id']][] =array('request_id'=>$data['id'],'user_id' =>$tenantData->user_id,'display_name' => $tenantData->displayname,'property_id'=>$data['property_id'],'property_name'=>$data->property_name,
            'SmartmoveApplicationId'=>$data->SmartmoveApplicationId,'isReportRequest'=>$data->isReportRequest,
            'isPaid'=>$data->isPaid,'reportUpdated_at'=>$data->updated_at,
            'reportResponse'=>$data->reportResponse,
            );
        }

        $view->propertyRequestApproved = $approved_lists;
        $this->view->metaTitle               = 'Property Approved Request List';
        $table                               = Engine_Api::_()->getItemTable('user');
        $onlineTable                         = Engine_Api::_()->getDbtable('online', 'user');
        $tableName                           = $table->info('name');
        $onlineTableName                     = $onlineTable->info('name');
        $viewer = Engine_Api::_()->user()->getViewer();
        $viewerId   =   $viewer->getIdentity();
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
         $view->online_users =$online_users_Data;
	    
	    
	    
	    
	    
    	$content = $view->render('_approvedapplication.tpl');
        $result = array('html'=>$content);
        echo json_encode($result);
		}
    
       public function renterfeedajaxResults ($limit,$offset,$aData){
//print_r($_SESSION['location_mode_array']); exit("ii");

        $view = Zend_Registry::get('Zend_View');
        $view = clone $view;
        $view->clearVars();
        $user_id=Engine_Api::_()->user()->getViewer()->getIdentity();
        $viewer = Engine_Api::_()->user()->getViewer();
        $propertyTable =  Engine_Api::_()->getDbtable('propertylist', 'user');
        
        $propertycountryTable       =  Engine_Api::_()->getDbtable('propertycountry', 'user');
                
        $propertycityable       =  Engine_Api::_()->getDbtable('propertycity', 'user');
          
        $locationSelect             =   $propertycountryTable->select()
                                                         ->setIntegrityCheck(false)
                                                         ->from(array('country'=>'engine4_property_countries'))
                                                         ->where('country.prty_country = ?', 'United States');
	    $locationData                   =  $propertycountryTable->fetchRow($locationSelect);

	    $country_id                     = $locationData->country_id;
        
        $propertySelect   =   $propertyTable->select()
                                ->setIntegrityCheck(false)
                                ->from(array('plist'=>'engine4_property_list',))
                                ->joinLeft(array('pcountry'=>'engine4_property_countries',),'plist.prty_country_id=pcountry.country_id',array('prty_country'))
                                ->joinLeft(array('pstate'=>'engine4_property_states',),'plist.prty_state_id=pstate.state_id',array('prty_state'))
                                ->joinLeft(array('pcity'=>'engine4_property_city',),'plist.prty_city_id=pcity.city_id',array('prty_city','latitude','longitude'))
                                ->where('plist.enable = ?', 1)
                                ->where('plist.landlord_enable=?' ,  1)
                                ->where('plist.property_type !=?' ,  'holding_property')
                                ->order('plist.created_at DESC')->limit($limit,$offset);
                                
                if(isset($_SESSION['matching_array'])){
                   //print_r($_SESSION['matching_array']);exit;
                    $this->view->filtermode = 'preference_mode';

                    $matching_array = $_SESSION['matching_array'];

                    if(!empty($matching_array)){

                        if(!empty($matching_array['housing_types'])){

                            $propertySelect->where('plist.housing_type  IN(?)' , $matching_array['housing_types']);

                        }
                        if( isset($matching_array['is_petsallowd']) && !empty($matching_array['is_petsallowd']) ) {

                            $propertySelect->where('plist.has_pets   =?' , $matching_array['is_petsallowd']);

                        }
                        if( isset($matching_array['pets_type']) && !empty($matching_array['pets_type']) ) {

                            $propertySelect->where('plist.pets_type  =?' , $matching_array['pets_type']);

                        }
                        if( isset($matching_array['no_of_bedrooms']) && !empty($matching_array['no_of_bedrooms']) ) {

                            $propertySelect->where('plist.no_of_rooms    =?' , $matching_array['no_of_bedrooms']);

                        }
                        if( isset($matching_array['price_from']) && isset($matching_array['price_to']) && !empty($matching_array['price_to']) ) 
                        {
							$price_from = (int)$matching_array['price_from'];
						    $price_to   = (int)$matching_array['price_to'];
							$propertySelect->where('plist.price >=?' , $matching_array['price_from']);
                            $propertySelect->where('plist.price <=?' , $matching_array['price_to']);							
     					}
                  
                        if( isset($matching_array['countryName']) && !empty($matching_array['countryName'])) {
                           $propertySelect->where('pcountry.prty_country      =?' ,  $matching_array['countryName']);
                        }
                        if( isset($matching_array['stateName']) && !empty($matching_array['stateName']) ) {
                            $propertySelect->where('pstate.prty_state      =?' ,  $matching_array['stateName']);
                        }
                        if(isset($matching_array['cityName']) && !empty($matching_array['cityName'])  ) {
                            $propertySelect->where('pcity.prty_city      =?' ,  $matching_array['cityName']);
                        }
                        if(isset($matching_array['countyName']) && !empty($matching_array['countyName'])  ) {
                            $propertySelect->where('plist.prty_county      =?' ,  $matching_array['countyName']);
                                            
                        }
                        if( isset($matching_array['neighborhoodName']) && !empty($matching_array['neighborhoodName']) ) {
                                         $propertySelect->where('plist.prty_neighborhood      =?' ,  $matching_array['neighborhoodName']);
                                            
                                        }
                        
                        if( isset($matching_array['zip']) && !empty($matching_array['zip']) ) {
							
							$propertySelect->where('plist.zip      =?' ,  $matching_array['zip']);
                        }
                    }
                }
                                else{

                if(isset($_SESSION['location_mode_array'])){

                $location_mode_array = $_SESSION['location_mode_array']; //print_r($_SESSION['location_mode_array']); exit;
                $this->view->filtermode = 'location_mode';

                        if($location_mode_array['set_to_usa'] != '' || $location_mode_array['countryId'] != '' || $location_mode_array['stateId'] != '' ||  $location_mode_array['cityId'] != '' || $location_mode_array['zipcode'] || $location_mode_array['county_name'] != '' || $location_mode_array['neighborhood_name'] != '' )

                        {
                        if( isset($location_mode_array['set_to_usa']) && !empty($location_mode_array['set_to_usa']) ) {
                                        $propertySelect->where('plist.prty_country_id      =?' ,  $country_id);
                        }
                        else{

                            if( isset($location_mode_array['zipcode']) && !empty($location_mode_array['zipcode']) ) {
                                            $propertySelect->where('plist.zip      =?' ,  $location_mode_array['zipcode']);
                                        }

                           if( isset($location_mode_array['neighborhood_name']) && !empty($location_mode_array['neighborhood_name']) ) {
                                       $propertySelect->where('plist.prty_neighborhood      =?' ,  $location_mode_array['neighborhood_name']);
                                            
                                        }
                            if( isset($location_mode_array['county_name']) && !empty($location_mode_array['county_name']) ) {
                                       $propertySelect->where('plist.prty_county      =?' ,  $location_mode_array['county_name']);
                                            
                                        } 
							

                            if( isset($location_mode_array['city_name']) && !empty($location_mode_array['city_name']) ) {
                                                $propertySelect->where('pcity.prty_city      =?' ,  $location_mode_array['city_name']);
                                        }

                            if( isset($location_mode_array['state_name']) && !empty($location_mode_array['state_name']) ) {
                                             $propertySelect->where('pstate.prty_state      =?' ,  $location_mode_array['state_name']);
                                        }

                             }
                            if( isset($location_mode_array['country_name']) && !empty($location_mode_array['country_name'])) {
								   $propertySelect->where('pcountry.prty_country      =?' ,  $location_mode_array['country_name']); 
                            }


                        }

                        if( isset($location_mode_array['pets_type']) && !empty($location_mode_array['pets_type']) ) {
                        $propertySelect->where('plist.pets_type  =?' , $location_mode_array['pets_type']);
                        }
                         if( isset($location_mode_array['price_from']) &&  isset($location_mode_array['price_to'])  && !empty($location_mode_array['price_to'])) 
                        {
						$price_from = (int)$location_mode_array['price_from'];
						$price_to   = (int)$location_mode_array['price_to'];
					    $propertySelect->where('plist.price >=?' , $price_from);
                        $propertySelect->where('plist.price <=?' , $price_to);						
     					}

                            if( isset($location_mode_array['no_of_bedrooms']) && !empty($location_mode_array['no_of_bedrooms']) ) {
                            $propertySelect->where('plist.no_of_rooms =?' , $location_mode_array['no_of_bedrooms']);
                            }

                    }
                    else{
                        if($viewer->prefered_location != ''){
                              if($viewer->prefered_location != 'United States' ) {
									$location   = explode(",",$viewer->prefered_location);
									$country_id = $location[0];
									$state_id   = $location[1];
									$city_id    = $location[2];

									$locationSelect   =   $propertycityable->select()
													->setIntegrityCheck(false)
													->from(array('city'=>'engine4_property_city'))
													->joinLeft(array('country'=>'engine4_property_countries'),'city.country_id=country.country_id',array('prty_country'))
													->joinLeft(array('state'=>'engine4_property_states'),'city.state_id=state.state_id',array('prty_state'))
													->where('city.city_id = ?', $location[2]);

									$locationData=$propertycityable->fetchRow($locationSelect);

									$this->view->locationData = $locationData;

									$country_id =   $locationData->country_id;
									$state_id   =  $locationData->state_id;
									$city_id    =  $locationData->city_id;
									$county     =  $viewer->prefered_county;
									$neighborhood = $viewer->prefered_neighborhood;	
										
									
                                    $propertySelect->where('plist.prty_city_id      =?' ,  $city_id);
                                    
                                    if($viewer->prefered_county != '' ) {
									
                                         $propertySelect->where('plist.prty_county      =?' ,  $county);
                                    }
                                    if($viewer->prefered_neighborhood != '' ) {
									
                                         $propertySelect->where('plist.prty_neighborhood      =?' ,   $neighborhood);
                                    }
                                    if($viewer->prefered_zipcode != '' ) {
									
                                         $propertySelect->where('plist.zip      =?' ,   $viewer->prefered_zipcode);
                                    }
                                    }

                                    else{
                                        $propertySelect->where('plist.prty_country_id      =?' ,  $country_id);
                                    }
                         }

                        else{
                            $propertySelect   =   $propertyTable->select()
                                ->setIntegrityCheck(false)
                                ->from(array('plist'=>'engine4_property_list',))
                                ->joinLeft(array('pcountry'=>'engine4_property_countries',),'plist.prty_country_id=pcountry.country_id',array('prty_country'))
                                ->joinLeft(array('pstate'=>'engine4_property_states',),'plist.prty_state_id=pstate.state_id',array('prty_state'))
                                ->joinLeft(array('pcity'=>'engine4_property_city',),'plist.prty_city_id=pcity.city_id',array('prty_city','latitude','longitude'))
                                ->where('plist.enable = ?', 1)
                                ->where('plist.landlord_enable=?' ,  1)
                                ->where('plist.property_type !=?' ,  'holding_property')
                                ->order('plist.created_at DESC')->limit($limit,$offset);

                                    
                      }
                   }
                }   
                $propertyListData = $propertyTable->fetchAll($propertySelect);     
                $view->propertyListData = $propertyListData;  
        $content = $view->render('_renterfeedajaxResults.tpl');
        $result = array('html'=>$content);
        echo json_encode($result);             
        
	  }
	  
	 public function landlordfeedajaxResults ($limit,$offset,$aData){
		$view = Zend_Registry::get('Zend_View');
        $view = clone $view;
        $view->clearVars();
        $user_id=Engine_Api::_()->user()->getViewer()->getIdentity();
        $viewer = Engine_Api::_()->user()->getViewer();
        $propertycountryTable       =  Engine_Api::_()->getDbtable('propertycountry', 'user');
                
        $propertycityable       =  Engine_Api::_()->getDbtable('propertycity', 'user');
          
        $locationSelect             =   $propertycountryTable->select()
                                                         ->setIntegrityCheck(false)
                                                         ->from(array('country'=>'engine4_property_countries'))
                                                         ->where('country.prty_country = ?', 'United States');
	    $locationData                   =  $propertycountryTable->fetchRow($locationSelect);

	    $country_id                     = $locationData->country_id;	

        
        $propertyRequirementTable =  Engine_Api::_()->getDbtable('propertyrequirement', 'user');
        $propertyRequirementSelect   =   $propertyRequirementTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('property_req'=>'engine4_property_requirement',))
                        ->joinLeft(array('pcountry'=>'engine4_property_countries',),'property_req.country_id=pcountry.country_id',array('prty_country'))
                        ->joinLeft(array('pstate'=>'engine4_property_states',),'property_req.state_id=pstate.state_id',array('prty_state'))
                        ->joinLeft(array('pcity'=>'engine4_property_city',),'property_req.city_id=pcity.city_id',array('prty_city','latitude','longitude'))
                        ->where('property_req.housing_type !=?' , '')
                        ->order('property_req.created_at DESC')->limit($limit,$offset);
        
        if(isset($_SESSION['matching_array'])){
                //   print_r($_SESSION['matching_array']); exit;
                    $matching_array = $_SESSION['matching_array'];
                        if(!empty($matching_array)){
                            $this->view->filtermode = 'preference_mode';

                            if(!empty($matching_array['housing_types'])){
                            $propertyRequirementSelect->where('property_req.housing_type  IN(?)' , $matching_array['housing_types']);
                            }
                            if( isset($matching_array['is_petsallowd']) && !empty($matching_array['is_petsallowd']) ) {
                            $propertyRequirementSelect->where('property_req.pets_allowed    =?' , $matching_array['is_petsallowd']);
                            }
                            if( isset($matching_array['pets_type']) && !empty($matching_array['pets_type']) ) {
                            $propertyRequirementSelect->where('property_req.pets_type   =?' , $matching_array['pets_type']);
                            }
                            if( isset($matching_array['no_of_bedrooms']) && !empty($matching_array['no_of_bedrooms']) ) {
                            $propertyRequirementSelect->where('property_req.no_of_rooms =?' , $matching_array['no_of_bedrooms']);
                            }
                        if( isset($matching_array['price_from']) && isset($matching_array['price_to'])  && !empty($matching_array['price_to'])) 
                        {
                            $price_from = (int)$matching_array['price_from'];
							$price_to   = (int)$matching_array['price_to'];
					        $propertyRequirementSelect->where('property_req.budget >=?' , $price_from);
                            $propertyRequirementSelect->where('property_req.budget <=?' , $price_to);	
							
     					}

                            if(isset($matching_array['countryName']) && !empty($matching_array['countryName'])) {
                                 $propertyRequirementSelect->where('pcountry.prty_country      =?' ,  $matching_array['countryName']);
                            }
                            if( isset($matching_array['stateName']) && !empty($matching_array['stateName'])) {
                                $propertyRequirementSelect->where('pstate.prty_state      =?' ,  $matching_array['stateName']);
                           }
                            if( isset($matching_array['cityName']) && !empty($matching_array['cityName']) ) {
                               $propertyRequirementSelect->where('pcity.prty_city      =?' ,  $matching_array['cityName']);
                              }
                            if( isset($matching_array['neighborhoodName']) && !empty($matching_array['neighborhoodName']) ) {
                                         $propertyRequirementSelect->where('property_req.neighborhood      =?' ,  $matching_array['neighborhoodName']);
                                            
                            }
    
					        if( isset($matching_array['countyName']) && !empty($matching_array['countyName']) ) {
                                         $propertyRequirementSelect->where('property_req.county      =?' ,  $matching_array['countyName']);
                                            
                            }
                            if( isset($matching_array['zip']) && !empty($matching_array['zip']) ) {
								
								$propertyRequirementSelect->where('property_req.zip      =?' ,  $matching_array['zip']);
                            }
                        }
             }
            else{
				
              if(isset($_SESSION['location_mode_array'])){
				//  print_r($_SESSION['location_mode_array']); exit;
                $location_mode_array = $_SESSION['location_mode_array'];
                $this->view->filtermode = 'location_mode';
                if($location_mode_array['set_to_usa'] != '' || $location_mode_array['country_name'] != '' || $location_mode_array['state_name'] != '' ||  $location_mode_array['city_name'] != '' || $location_mode_array['zipcode'] !='' )

                {
                if( isset($location_mode_array['set_to_usa']) && !empty($location_mode_array['set_to_usa']) ) {
                        $propertyRequirementSelect->where('property_req.country_id      =?' ,  $country_id);
                   }
                else{

                    if( isset($location_mode_array['zipcode']) && !empty($location_mode_array['zipcode']) ) {
                           $propertyRequirementSelect->where('property_req.zip      =?' ,  $location_mode_array['zipcode']);
                                }

                   if( isset($location_mode_array['neighborhood_name']) && !empty($location_mode_array['neighborhood_name']) ) {
                           $propertyRequirementSelect->where('property_req.neighborhood      =?' ,  $location_mode_array['neighborhood_name']);
                                            
                                        }
    
					if( isset($location_mode_array['county_name']) && !empty($location_mode_array['county_name']) ) {
                           $propertyRequirementSelect->where('property_req.county      =?' ,  $location_mode_array['county_name']);
                                            
                                        }

                    if( isset($location_mode_array['city_name']) && !empty($location_mode_array['city_name']) ) {
                          $propertyRequirementSelect->where('pcity.prty_city      =?' ,  $location_mode_array['city_name']);
                            }

                    if( isset($location_mode_array['state_name']) && !empty($location_mode_array['state_name']) ) {
                          $propertyRequirementSelect->where('pstate.prty_state      =?' ,  $location_mode_array['state_name']);
                                }

                    if( isset($location_mode_array['country_name']) && !empty($location_mode_array['country_name']) ) {
                          $propertyRequirementSelect->where('pcountry.prty_country      =?' ,  $location_mode_array['country_name']);
                              }
                }

               }

                if( isset($location_mode_array['pets_type']) && !empty($location_mode_array['pets_type']) ) {
                    $propertyRequirementSelect->where('property_req.pets_type   =?' , $location_mode_array['pets_type']);
                }
                 if( isset($location_mode_array['price_from']) && isset($location_mode_array['price_to']) && !empty($location_mode_array['price_to']) ) 
                        { //exit;
							$price_from = (int)$location_mode_array['price_from'];
							$price_to   = (int)$location_mode_array['price_to'];
					  $propertyRequirementSelect->where('property_req.budget >=?' , $price_from);
                      $propertyRequirementSelect->where('property_req.budget <=?' , $price_to);						
     				}

                            if( isset($location_mode_array['no_of_bedrooms']) && !empty($location_mode_array['no_of_bedrooms']) ) {

                            $propertyRequirementSelect->where('property_req.no_of_rooms =?' , $location_mode_array['no_of_bedrooms']);

                            }
            }
           else{
                if($viewer->prefered_location != ''){
                    if($viewer->prefered_location != 'United States' ) {
						
						$location   = explode(",",$viewer->prefered_location);
                        $country_id = $location[0];
                        $state_id   = $location[1];
                        $city_id    = $location[2];

                        $locationSelect   =   $propertycityable->select()
                                        ->setIntegrityCheck(false)
                                        ->from(array('city'=>'engine4_property_city'))
                                        ->joinLeft(array('country'=>'engine4_property_countries'),'city.country_id=country.country_id',array('prty_country'))
                                        ->joinLeft(array('state'=>'engine4_property_states'),'city.state_id=state.state_id',array('prty_state'))
                                        ->where('city.city_id = ?', $location[2]);

                        $locationData=$propertycityable->fetchRow($locationSelect);

                        $this->view->locationData = $locationData;

                        $country_id =   $locationData->country_id;
                        $state_id   =  $locationData->state_id;
                        $city_id    =  $locationData->city_id;
                        $county     =  $viewer->prefered_county;
                        $neighborhood = $viewer->prefered_neighborhood;

                          $propertyRequirementSelect->where('property_req.city_id      =?' ,  $city_id);
                          if($viewer->prefered_county != '' ) {
									
                                         $propertyRequirementSelect->where('property_req.county      =?' ,  $county);
                                    }
                          if($viewer->prefered_neighborhood != '' ) {
									
                                         $propertyRequirementSelect->where('property_req.neighborhood      =?' ,   $neighborhood);
                                    }
                          if($viewer->prefered_zipcode != '' ) {
									
                                         $propertyRequirementSelect->where('property_req.zip      =?' ,   $viewer->prefered_zipcode);
                                    }
                    }
                    else{

						   
                        $propertyRequirementSelect->where('property_req.country_id      =?' ,  $country_id);
                    }
                }

                else{
                     $propertyRequirementSelect   =   $propertyRequirementTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('property_req'=>'engine4_property_requirement',))
                        ->joinLeft(array('pcountry'=>'engine4_property_countries',),'property_req.country_id=pcountry.country_id',array('prty_country'))
                        ->joinLeft(array('pstate'=>'engine4_property_states',),'property_req.state_id=pstate.state_id',array('prty_state'))
                        ->joinLeft(array('pcity'=>'engine4_property_city',),'property_req.city_id=pcity.city_id',array('prty_city','latitude','longitude'))
                        ->where('property_req.housing_type !=?' , '')
                        ->order('property_req.created_at DESC')->limit($limit,$offset);

                    }
                }
            }
            
           $propertyReqData = $propertyRequirementTable->fetchAll($propertyRequirementSelect); 
			$smartmoveapiRenters_table =  Engine_Api::_()->getDbtable('Smartmoveapirenters', 'user');
			$likeuserTable      =  Engine_Api::_()->getDbtable('likeuser', 'user');
    $resultData                = array();
 foreach($propertyReqData as $data):
 
     $this->view->smartmoveapiRentersData = $smartmoveapiRenters = $smartmoveapiRenters_table->fetchRow($smartmoveapiRenters_table->select()->where('tenant_id = ?', $data['tenant_id']));
    if(!empty($smartmoveapiRenters)){
            $isSmartmoveRenter = 1;
    }
    else{
            $isSmartmoveRenter = 0;
    }
    $likeuserDataSelect = $likeuserTable->select()
                    ->where('subject_id = ?', $viewer -> getIdentity())
                    ->where('object_id = ?',   $data['tenant_id']);
    $likeuserData      = $likeuserTable->fetchRow($likeuserDataSelect);
    if(count($likeuserData) == 0){
        $is_like = 0;
    }
    else{
        $is_like = 1;
    }
    $tmpArray['reqId']                 =  $data['id'];
    $tmpArray['userId']                =  $data['tenant_id'];
    $tmpArray['created_at']            =  $data['created_at'];
    $tmpArray['prty_country']          =  'USA';
    $tmpArray['prty_state']            =  $data['prty_state'];
    $tmpArray['prty_city']             =  $data['prty_city'];
    $tmpArray['prty_county']           =  $data['county'];
    $tmpArray['prty_neighborhood']     =  $data['neighborhood'];
    $tmpArray['latitude']              =  $data['latitude'];
    $tmpArray['longitude']             =  $data['longitude'];
    $tmpArray['description']           =  $data['description'];
    $tmpArray['isSmartmoveRenter']     =  $isSmartmoveRenter;
    $tmpArray['vouchers']              =  $data['vouchers'];
    $tmpArray['budget']                =  $data['budget'];
    $tmpArray['no_of_rooms']           =  $data['no_of_rooms'];
    $tmpArray['housing_type']          =  $data['housing_type'];
    $tmpArray['parking']               =  $data['provide_parking'];
    $tmpArray['wheelchair']            =  $data['wheelchair_accessible'];
    $tmpArray['pets_allowed']          =  $data['pets_allowed'];
    $tmpArray['pets_type']             =  $data['pets_type'];
    $tmpArray['is_like']               =  $is_like;
    $finaltmpArray[] = $tmpArray;
 
 endforeach;
    $view->propertyReqResultData           = $propertyReqResultData = array_merge($resultData,$finaltmpArray);   
        $content = $view->render('_landlordfeedajaxResults.tpl');
        $result = array('html'=>$content);
        echo json_encode($result);                  
	 } 
  public function matchingrequirementpreferences ($aData){
	    $view = Zend_Registry::get('Zend_View');
        $view = clone $view;
        $view->clearVars();
        $viewer = Engine_Api::_()->user()->getViewer();
        $preference_property_id        = $aData['preference_property_id'];
        $preference_addess             = $aData['preference_addess'];
        $PreferenceCountry             = $aData['PreferenceCountry'];
        $PreferenceState             = $aData['PreferenceState'];
        $PreferenceCity             = $aData['PreferenceCity'];
        $PreferenceCounty           = $aData['PreferenceCounty'];
        $PreferenceNeighborhood      = $aData['PreferenceNeighborhood'];
        $PreferenceZip               = $aData['PreferenceZip'];
        
        $FeedPreferenceUnitTable            = Engine_Api::_()->getDbtable('Feedpreferenceunit', 'user');
        $FeedPreferenceUnitDataSelect       = $FeedPreferenceUnitTable->select()
                                              ->where('userid = ?', $viewer->getIdentity());
        $FeedPreferenceUnitData = $FeedPreferenceUnitTable->fetchAll($FeedPreferenceUnitDataSelect);
       // echo '<pre>'; print_r($aData); exit;
        if($preference_property_id !=''){
        

        $propertyTable       =  Engine_Api::_()->getDbtable('propertylist', 'user');
		$propertyData        =  $propertyTable->fetchRow($propertyTable->select()->where('id = ?',  $preference_property_id)); 
		
		$Propertycountry_table   =  Engine_Api::_()->getDbtable('Propertycountry', 'user');
		$Propertystate_table     =  Engine_Api::_()->getDbtable('Propertystate', 'user');
		$Propertycity_table     =  Engine_Api::_()->getDbtable('Propertycity', 'user');
		
		$preferenceUnitId = array();
		
	    foreach($FeedPreferenceUnitData as $data):
		
				$matchingrequirementpreferencesSelect =   $FeedPreferenceUnitTable->select()
								->setIntegrityCheck(false)
								->from(array('preferences'=>'engine4_feedpreference_unit'))
								-> where('preferences.id      =?' ,  $data['id']);	
				
				if($data['housing_type'] !=''){
				$matchingrequirementpreferencesSelect->where('preferences.housing_type      =?' ,  $propertyData['housing_type']);			
				}
				if($data['is_petsallowd'] !=''){
				$matchingrequirementpreferencesSelect->where('preferences.is_petsallowd      =?' ,  $propertyData['has_pets']);			
				}
				if($data['pets_type'] !=''){
				$matchingrequirementpreferencesSelect->where('preferences.pets_type      =?' ,  $propertyData['pets_type']);			
				}
				if($data['number_of_rooms'] !=''){
				$matchingrequirementpreferencesSelect->where('preferences.number_of_rooms      =?' ,  $propertyData['no_of_rooms']);			
				}
				if($data['price'] !=''){
					   $is_priced= false;
					  $pricearray =  explode('-', $data['price']);
					  $price_from      = (int)$pricearray['0'];
					  $price_to        = (int)$pricearray['1'];
					  
					  if($propertyData['price'] >=$price_from && $propertyData['price']<=$price_to){
						  $is_priced= true;
						  $matchingrequirementpreferencesSelect->where('preferences.price      =?' ,  $data['price']);	
					  }		
				}
				/*if($data['countryName'] !=''){
						$propertyCountryData        =  $Propertycountry_table->fetchRow($Propertycountry_table->select()->where('prty_country = ?',  $data['countryName'])); 
						if($propertyData['prty_country_id'] == $propertyCountryData->country_id):
							$matchingrequirementpreferencesSelect->where('preferences.countryName      =?' ,  $propertyCountryData->prty_country);			
					
						endif;  
				}*/
				if($data['stateName'] !=''){
					    $is_state= false;
						$propertyStateData        =  $Propertystate_table->fetchRow($Propertystate_table->select()->where('prty_state = ?',  $data['stateName'])); 
						if($propertyData['prty_state_id'] == $propertyStateData->state_id):
						 $is_state= true;
							$matchingrequirementpreferencesSelect->where('preferences.stateName      =?' ,  $propertyStateData->prty_state);
					
						endif;  
				}
				if($data['cityName'] !=''){
					    $is_city = false;
						$PropertycityData        =  $Propertycity_table->fetchRow($Propertycity_table->select()->where('prty_city = ?',  $data['cityName'])); 
						if($propertyData['prty_city_id'] == $PropertycityData->city_id):
						$is_city = true;
							$matchingrequirementpreferencesSelect->where('preferences.cityName      =?' ,  $PropertycityData->prty_city);	
						endif;  
				}
				if($PreferenceCountry !=''){	
							$matchingrequirementpreferencesSelect->where('preferences.countyName      =?' ,  $PreferenceCountry); 
				}
				if($PreferenceNeighborhood !=''){	
							$matchingrequirementpreferencesSelect->where('preferences.neighborhoodName      =?' ,  $PreferenceNeighborhood);      
				}
				if($PreferenceZip !=''){	
							$matchingrequirementpreferencesSelect->where('preferences.zip      =?' ,  $PreferenceZip);       
				}
				//echo $matchingrequirementpreferencesSelect."_________"; 

				if($data['housing_type'] !='' || $data['is_petsallowd'] !='' || $data['pets_type'] !='' || $data['number_of_rooms'] != '0' ||
				  $is_priced== true  || $is_state== true ||  $is_city == true || $PreferenceCountry !='' ||
				 $PreferenceNeighborhood !='' || $PreferenceZip !=''){
					 
				$FeedPreferenceUnitData123 = $FeedPreferenceUnitTable->fetchRow($matchingrequirementpreferencesSelect);
				
				if(count($FeedPreferenceUnitData123)>0){
					$preferenceUnitId[] =$FeedPreferenceUnitData123 ->id;
				}
			  }
		
		endforeach;
		
			if(!empty($preferenceUnitId)){			
			  $matchingFeedPreferenceUnitDataSelect       = $FeedPreferenceUnitTable->select()
												  ->where('id IN(?)', $preferenceUnitId); 
			 $matchingFeedPreferenceUnitData = $FeedPreferenceUnitTable->fetchAll($matchingFeedPreferenceUnitDataSelect);
			 $view->matchingFeedPreferenceUnitData =$matchingFeedPreferenceUnitData;
			}
			else{
				 $view->matchingFeedPreferenceUnitData =array();
			}
	    }
	    elseif($preference_addess !='' ){
			
			$propertyTable       =  Engine_Api::_()->getDbtable('propertylist', 'user');
			$propertyData        =  $propertyTable->fetchRow($propertyTable->select()->where('id = ?',  $preference_property_id)); 
			
			$Propertycountry_table   =  Engine_Api::_()->getDbtable('Propertycountry', 'user');
			$Propertystate_table     =  Engine_Api::_()->getDbtable('Propertystate', 'user');
			$Propertycity_table     =  Engine_Api::_()->getDbtable('Propertycity', 'user');
			
			$preferenceUnitId = array();
			
			foreach($FeedPreferenceUnitData as $data):
			
			$matchingrequirementpreferencesSelect =   $FeedPreferenceUnitTable->select()
								->setIntegrityCheck(false)
								->from(array('preferences'=>'engine4_feedpreference_unit'))
								-> where('preferences.id      =?' ,  $data['id']);	
			
			    if($PreferenceCountry !=''){
			  		$matchingrequirementpreferencesSelect->where('preferences.countryName      =?' ,  $PreferenceCountry);		

				}
				if( $PreferenceState  !=''){

							$matchingrequirementpreferencesSelect->where('preferences.stateName      =?' ,  $PreferenceState);
 
				}
				if($PreferenceCity !=''){

							$matchingrequirementpreferencesSelect->where('preferences.cityName      =?' ,  $PreferenceCity);	
				}
				if($data['countyName'] !=''){	
							$matchingrequirementpreferencesSelect->where('preferences.countyName      =?' ,  $propertyData->prty_county); 
				}
				if($data['neighborhoodName'] !=''){	
							$matchingrequirementpreferencesSelect->where('preferences.neighborhoodName      =?' ,  $propertyData->prty_neighborhood);      
				}
				if($data['zip'] !=''){	
							$matchingrequirementpreferencesSelect->where('preferences.zip      =?' ,  $propertyData->zip);       
				}					
						//	echo $matchingrequirementpreferencesSelect;		exit("kk");
						
			    if($PreferenceCountry !='' || $PreferenceState  !='' || $PreferenceCity !='' || $data['countyName'] !='' ||
			     $data['neighborhoodName'] !='' || $data['neighborhoodName'] !='' || $data['zip'] !=''){			
						
				$FeedPreferenceUnitData123 = $FeedPreferenceUnitTable->fetchRow($matchingrequirementpreferencesSelect);
			
				if(count($FeedPreferenceUnitData123)>0){
					$preferenceUnitId[] =$FeedPreferenceUnitData123 ->id;
				}
			  }
			endforeach;
			
			if(!empty($preferenceUnitId)){			
			 $matchingFeedPreferenceUnitDataSelect       = $FeedPreferenceUnitTable->select()
												  ->where('id IN(?)', $preferenceUnitId); 
			 $matchingFeedPreferenceUnitData = $FeedPreferenceUnitTable->fetchAll($matchingFeedPreferenceUnitDataSelect);
			 $view->matchingFeedPreferenceUnitData =$matchingFeedPreferenceUnitData;
			}
			else{
				 $view->matchingFeedPreferenceUnitData =array();
			}
		}
	    else{
			$view->matchingFeedPreferenceUnitData =$FeedPreferenceUnitData;
		}
        $content = $view->render('_matchingrequirementpreference.tpl');
        $result = array('html'=>$content);
        echo json_encode($result);
	 
	 }
	 
	   public function getpreferencebyidModal ($aData){
		   
		    $view = Zend_Registry::get('Zend_View');
			$view = clone $view;
			$view->clearVars();
			$preference_id        = $aData['preference_id'];
			$FeedPreferenceUnitTable            = Engine_Api::_()->getDbtable('Feedpreferenceunit', 'user');
            $FeedPreferenceUnitDataSelect       = $FeedPreferenceUnitTable->select()
                                                  ->where('id = ?', $preference_id);
            $FeedPreferenceUnitData = $FeedPreferenceUnitTable->fetchRow($FeedPreferenceUnitDataSelect);
			    $price_table =  Engine_Api::_()->getDbtable('price', 'user');
				$price_select = $price_table->select();	
				$priceData = $price_table->fetchAll($price_select);
				$this->view->priceData = $priceData; 
			
			 $view->FeedPreferenceUnitData =$FeedPreferenceUnitData;
			 $view->priceData =$priceData;
        $content = $view->render('_editpreferencemodal.tpl');
        $result = array('html'=>$content);
        echo json_encode($result);
	   }
	   public function getpreferencebyscoutnameModal ($aData){
		    $viewer = Engine_Api::_()->user()->getViewer();
		    $view = Zend_Registry::get('Zend_View');
			$view = clone $view;
			$view->clearVars();
			$scoutname        = $aData['scoutname'];
			$FeedPreferenceUnitTable            = Engine_Api::_()->getDbtable('Feedpreferenceunit', 'user');
			if($scoutname !=''){
            $FeedPreferenceUnitDataSelect       = $FeedPreferenceUnitTable->select()
                                                  ->where('scout_name = ?', $scoutname);
			}
			else{
				$FeedPreferenceUnitDataSelect       = $FeedPreferenceUnitTable->select()
				                                                   ->where('userid = ?', $viewer->getIdentity());
			}
            $FeedPreferenceUnitData = $FeedPreferenceUnitTable->fetchAll($FeedPreferenceUnitDataSelect);
			
			$view->matchingFeedPreferenceUnitData =$FeedPreferenceUnitData; // echo '<pre>';print_r($FeedPreferenceUnitData); exit;

        $content = $view->render('_matchingrequirementpreference.tpl');
        $result = array('html'=>$content);
        echo json_encode($result);
	   }
	public function getComments($aData){
    $view = Zend_Registry::get('Zend_View');
	$view = clone $view;
	$view->clearVars();
    $postcommentTable      =  Engine_Api::_()->getDbtable('Postcomments', 'user');
	$userTable             =  Engine_Api::_()->getDbtable('users', 'user');

	$postcommentData       = $postcommentTable->fetchAll($postcommentTable->select()
									 ->where('actionId = ?',$aData['id'] )
									  ->order('commentId DESC')
									 );
	$view->postcommentData =$postcommentData; 
	$content = $view->render('_comments.tpl');
    $result = array('html'=>$content);
    echo json_encode($result);
									 
    }
}
