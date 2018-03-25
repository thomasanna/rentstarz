<?php

class User_Widget_LandlordTaskController extends Engine_Content_Widget_Abstract {

public function indexAction()  {
	
  $subject = Engine_Api::_()->core()->getSubject('user');
  $viewer = Engine_Api::_()->user()->getViewer();
    

 $TasksTable     = Engine_Api::_()->getDbtable('Tasks', 'user');
 
 $maintenaceLogSelect = $TasksTable->select()
                                ->setIntegrityCheck(false)
                                ->from(array('tasks'=>'engine4_tasks',))
                        ->joinLeft(array('users'=>'engine4_users',),'users.user_id=tasks.task_created_by',array('user_id as renter_id','displayname as renter_name','email as renter_email'))
                        ->where('tasks.task_created_to = ?', $subject->getIdentity())
                        ->order('tasks.created_at DESC');
  $maintenaceLog = $TasksTable->fetchAll($maintenaceLogSelect);
  $this->view->maintenaceLog = $maintenaceLog;
        
 
 
 $newtask_select = $TasksTable->select()
				->setIntegrityCheck(false)
				->from(array('tasks'=>'engine4_tasks',))
		->joinLeft(array('users'=>'engine4_users',),'users.user_id=tasks.task_created_by',array('user_id as renter_id','displayname as renter_name','email as renter_email'))
		->where('tasks.status = ?', 'pending')
		->where('tasks.task_created_to = ?', $subject->getIdentity());
 $newtaskData = $TasksTable->fetchAll($newtask_select);

 $this->view->newtaskData = $newtaskData;
 $table = Engine_Api::_()->getItemTable('user');
 
 // test server 102,103 ,32
 // local server 87,88 ,34


 $repairAgentSelect   =   $table->select()
                        ->setIntegrityCheck(false)
                        ->from(array('user'=>'engine4_users',))
                        ->joinLeft(array('search_field'=>'engine4_user_fields_search'),'search_field.item_id=user.user_id',null)
                        ->joinLeft(array('fields_value'=>'engine4_user_fields_values'),'fields_value.item_id=user.user_id',array('value'))
                        ->joinLeft(array('state'=>'engine4_state_list',),'state.state_id=search_field.field_102',array('state'))
                        ->joinLeft(array('city'=>'engine4_city_list',),'city.city_id=search_field.field_103',array('city'))
                        ->where('user.search=?' , 1)
                        ->where('user.enabled=?' , 1)
                        ->where('search_field.profile_type =?' , '32')
                        ->where('fields_value.field_id=?' , 93)
                        ->group('user.user_id');
 /*$repairAgentSelect   =   $table->select()
                        ->setIntegrityCheck(false)
                        ->from(array('user'=>'engine4_users',))
                        ->joinLeft(array('search_field'=>'engine4_user_fields_search'),'search_field.item_id=user.user_id',null)
                        ->joinLeft(array('fields_value'=>'engine4_user_fields_values'),'fields_value.item_id=user.user_id',array('value'))
                        ->joinLeft(array('state'=>'engine4_state_list',),'state.state_id=search_field.field_87',array('state'))
                        ->joinLeft(array('city'=>'engine4_city_list',),'city.city_id=search_field.field_88',array('city'))
                        ->where('user.search=?' , 1)
                        ->where('user.enabled=?' , 1)
                        ->where('search_field.profile_type =?' , '34')
                        ->where('fields_value.field_id=?' , 93)
                        ->group('user.user_id');*/

 $repairAgentData = $table->fetchAll($repairAgentSelect);
 
 $this->view->repairAgentData = $repairAgentData;
 //echo "<pre>"; print_r($repairAgentData); exit;
 
 $linksTable      = Engine_Api::_()->getDbtable('Mylinks', 'user');
 $linksData = $linksTable->fetchAll($linksTable->select()
                                      ->where('status = ?', 1)
                                      ->where('invited_by = ?', $subject->getIdentity())
                                      ->group('user_id')

                                      );



 $this->view->linksData = $linksData;
}
}
