<?php

class User_Widget_RenterTaskController extends Engine_Content_Widget_Abstract {

public function indexAction()  {

    $subject = Engine_Api::_()->core()->getSubject('user');
	$viewer = Engine_Api::_()->user()->getViewer();
    $this->view->subjectId = $subject->getIdentity();
	$this->view->viewerId = $viewer->getIdentity();
    $TasksTable     = Engine_Api::_()->getDbtable('Tasks', 'user');
    $task_select = $TasksTable->select()
                                ->setIntegrityCheck(false)
                                ->from(array('tasks'=>'engine4_tasks',))
                        ->joinLeft(array('users'=>'engine4_users',),'users.user_id=tasks.task_created_to',array('user_id as landlord_id','displayname as landlord_name','email as landlord_email'))
                        ->where('tasks.task_created_by = ?', $viewer->getIdentity());
    $this->view->mytasks = $mytasks = $TasksTable->fetchAll($task_select);
    $linksTable      = Engine_Api::_()->getDbtable('Mylinks', 'user');
    $linksData = $linksTable->fetchAll($linksTable->select()
                                      ->where('status = ?', 1)
                                      ->where('invited_by = ?', $subject->getIdentity())
                                      ->group('user_id')

                                      );



    $this->view->linksData = $linksData;    

	
}
}


