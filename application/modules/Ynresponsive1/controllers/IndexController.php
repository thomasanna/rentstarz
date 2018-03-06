<?php
class Ynresponsive1_IndexController extends Core_Controller_Action_Standard
{
  public function dashboardAction()
  {
   if( !Engine_Api::_()->user()->getViewer()->getIdentity() ) {
      return $this->_helper->redirector->gotoRoute(array(), 'default', true);
     }
     $viewer = Engine_Api::_() -> user() -> getViewer();

     $fieldsByAlias   = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
             if( !empty($fieldsByAlias['profile_type']) ){
              $optionId        = $fieldsByAlias['profile_type']->getValue($viewer);
              $profile_type_id = $optionId->value;
           }
     if($profile_type_id == 34 || $profile_type_id == 32){
		 $this->_helper->redirector->gotoRoute(array('controller'=>'profile' ,'action' => 'index' ,'id' =>$viewer->getIdentity()), 'user_profile', true);
		
		       //      return $this->_forward('notfound');
	 }      
     $this->view->metaTitle     = 'Member Home Page';
    // Render
    $this->_helper->content
        ->setNoRender()
        ->setEnabled()
        ;
  }
  
  // Notification
	public function cancelFriendAction()
	{
		// Get Viewer
		$viewer = Engine_Api::_() -> user() -> getViewer();
		if (!$viewer -> getIdentity())
		{
			// Set Norender if user is not logged on
			return false;
		}
		$resource_id = $this -> getRequest() -> getParam('resource_id');
		$user = Engine_Api::_() -> getItem('user', $resource_id);
		$this -> view -> status = false;
		$this -> view -> resource_id = $resource_id;
		if ($resource_id)
		{
			$uid = $viewer -> getIdentity();
			$userTb = Engine_Api::_() -> getDbTable('membership', 'user');
			$db = $userTb -> getAdapter();
			$db -> beginTransaction();
			$select = $userTb -> select() -> where("(user_id = $uid AND resource_id = $resource_id)
                                    OR (user_id = $resource_id AND resource_id = $uid)") -> where("active = 0");
			$rows = $userTb -> fetchAll($select);
			try
			{
				if (count($rows))
				{
					foreach ($rows as $row)
					{
						$row -> delete();
					}
					// Set the requests as handled
					$notification = Engine_Api::_() -> getDbtable('notifications', 'activity') -> getNotificationBySubjectAndType($viewer, $user, 'friend_request');
					if ($notification)
					{
						$notification -> mitigated = true;
						$notification -> read = 1;
						$notification -> save();
					}
					$notification = Engine_Api::_() -> getDbtable('notifications', 'activity') -> getNotificationBySubjectAndType($viewer, $user, 'friend_follow_request');
					if ($notification)
					{
						$notification -> mitigated = true;
						$notification -> read = 1;
						$notification -> save();
					}
					$db -> commit();
					$this -> view -> status = true;
				}
			}
			catch (Exception $e)
			{
				$db -> rollBack();
				throw $e;
			}
		}
	}

	public function confirmFriendAction()
	{
		// Get Viewer
		$viewer = Engine_Api::_() -> user() -> getViewer();
		if (!$viewer -> getIdentity())
		{
			// Set Norender if user is not logged on
			return false;
		}
		$resource_id = $this -> getRequest() -> getParam('resource_id');
		$this -> view -> status = false;
		$this -> view -> resource_id = $resource_id;
		$user = Engine_Api::_() -> getItem('user', $resource_id);
		if ($resource_id)
		{
			$uid = $viewer -> getIdentity();
			$userTb = Engine_Api::_() -> getDbTable('membership', 'user');
			$db = $userTb -> getAdapter();
			$db -> beginTransaction();
			$select = $userTb -> select() -> where("(user_id = $uid AND resource_id = $resource_id)
                                    OR (user_id = $resource_id AND resource_id = $uid)") -> where("active = 0");
			$rows = $userTb -> fetchAll($select);
			try
			{
				if (count($rows))
				{
					foreach ($rows as $row)
					{
						$row -> active = 1;
						$row -> user_approved = 1;
						$row -> resource_approved = 1;
						$row -> save();
					}
					// Add activity
					if (!$user -> membership() -> isReciprocal())
					{
						Engine_Api::_() -> getDbtable('actions', 'activity') -> addActivity($user, $viewer, 'friends_follow', '{item:$subject} is now following {item:$object}.');
					}
					else
					{
						Engine_Api::_() -> getDbtable('actions', 'activity') -> addActivity($user, $viewer, 'friends', '{item:$object} is now friends with {item:$subject}.');
						Engine_Api::_() -> getDbtable('actions', 'activity') -> addActivity($viewer, $user, 'friends', '{item:$object} is now friends with {item:$subject}.');
					}

					// Add notification
					if (!$user -> membership() -> isReciprocal())
					{
						Engine_Api::_() -> getDbtable('notifications', 'activity') -> addNotification($user, $viewer, $user, 'friend_follow_accepted');
					}
					else
					{
						Engine_Api::_() -> getDbtable('notifications', 'activity') -> addNotification($user, $viewer, $user, 'friend_accepted');
					}
					// Set the requests as handled
					$notification = Engine_Api::_() -> getDbtable('notifications', 'activity') -> getNotificationBySubjectAndType($viewer, $user, 'friend_request');
					if ($notification)
					{
						$notification -> mitigated = true;
						$notification -> read = 1;
						$notification -> save();
					}
					$notification = Engine_Api::_() -> getDbtable('notifications', 'activity') -> getNotificationBySubjectAndType($viewer, $user, 'friend_follow_request');
					if ($notification)
					{
						$notification -> mitigated = true;
						$notification -> read = 1;
						$notification -> save();
					}
					$db -> commit();
					$this -> view -> status = true;
				}
			}
			catch (Exception $e)
			{
				$db -> rollBack();
				throw $e;
			}
		}
	}

	/**
	 * Message alert
	 * @todo get message
	 * @access public
	 */
	public function messageAction()
	{
		// Get Viewer
		$viewer = Engine_Api::_() -> user() -> getViewer();
		if (!$viewer -> getIdentity())
		{
			// Set Norender if user is not logged on
			return false;
		}
		$notificationsTable = Engine_Api::_() -> getDbtable('notifications', 'activity');
		$db = $notificationsTable -> getAdapter();
		$db -> beginTransaction();
		try
		{
			// Get notification
			$notifications = $notificationsTable -> fetchAll("`user_id` = {$viewer->getIdentity()} AND `type` = 'message_new' AND `mitigated` = 0");
			if ($notifications)
			{
				foreach ($notifications as $notification)
				{
					$notification -> mitigated = 1;
					$notification -> save();
				}
				$db -> commit();
			}
		}
		catch (Exception $e)
		{
			$db -> rollBack();
			throw $e;
		}
		// Get Message
		$table = Engine_Api::_() -> getItemTable('messages_conversation');
		$rName = Engine_Api::_() -> getDbtable('recipients', 'messages') -> info('name');
		$cName = $table -> info('name');
		$select = $table -> select() -> from($cName) -> joinRight($rName, "`{$rName}`.`conversation_id` = `{$cName}`.`conversation_id`", null) -> where("`{$rName}`.`user_id` = ?", $viewer -> getIdentity()) -> where("`{$rName}`.`inbox_deleted` = ?", 0) -> order('inbox_read ASC') -> order(new Zend_Db_Expr('inbox_updated DESC')) -> limit(5);
		$this -> view -> messages = $messages = $table -> fetchAll($select);

		$this -> _helper -> layout -> disableLayout();
	}

	/**
	 * Notification alert
	 * @todo get notification
	 * @access public
	 */
	public function notificationAction()
	{
		// Get Viewer
		$viewer = Engine_Api::_() -> user() -> getViewer();
		if (!$viewer -> getIdentity())
		{
			// Set Norender if user is not logged on
			return false;
		}
	    date_default_timezone_set($viewer->timezone);
		$notificationsTable = Engine_Api::_() -> getDbtable('notifications', 'activity');
		$db = $notificationsTable -> getAdapter();
		$db -> beginTransaction();
		try
		{
			// Get notification
			$notifications = $notificationsTable -> fetchAll("`user_id` = {$viewer->getIdentity()} AND `type` NOT  IN ('friend_request','message_new') AND `mitigated` = 0");
			if ($notifications)
			{
				foreach ($notifications as $notification)
				{
					$notification -> mitigated = 1;
					$notification -> save();
				}
				$db -> commit();
			}
		}
		catch (Exception $e)
		{
			$db -> rollBack();
			throw $e;
		}
		// Get notifications
		$select = Engine_Api::_() -> getDbTable('notifications', 'activity') -> select() -> where("`user_id` = ?", $viewer -> getIdentity()) -> where("`type` NOT IN ('friend_request','message_new')") -> order('read ASC') -> order('notification_id DESC') -> limit(5);
		$this -> view -> updates = Engine_Api::_() -> getDbTable('notifications', 'activity') -> fetchAll($select);
		$this -> _helper -> layout -> disableLayout();
	}

	public function markreadAction()
	{
		$this->_helper->viewRenderer->setNoRender(true);
        $this->_helper->layout->disableLayout();
		$request = Zend_Controller_Front::getInstance() -> getRequest();
		$action_id = $request -> getParam('actionid', 0);
		$viewer = Engine_Api::_() -> user() -> getViewer();
		$notificationsTable = Engine_Api::_() -> getDbtable('notifications', 'activity');
		$db = $notificationsTable -> getAdapter();
		$db -> beginTransaction();

		try
		{
			$notification = Engine_Api::_() -> getItem('activity_notification', $action_id);
			$notification -> read = 1;
			$notification -> save();
			// Commit
			$db -> commit();
			$aResult['status']  = true;
		}
		catch( Exception $e )
		{
			$db -> rollBack();
			throw $e;
			$aResult['status']  = false;
		}
		 echo json_encode($aResult['status']);
	}

	/**
	 * Friend request alert
	 * @todo get friend request
	 * @access public
	 */
	public function friendAction()
	{
		$viewer = Engine_Api::_() -> user() -> getViewer();
		if (!$viewer -> getIdentity())
		{
			return false;
		}
		// Mark read action
		$notificationsTable = Engine_Api::_() -> getDbtable('notifications', 'activity');
		$db = $notificationsTable -> getAdapter();
		$db -> beginTransaction();
		try
		{
			// Get friend request notifications
			$notifications = $notificationsTable -> fetchAll("`user_id` = {$viewer->getIdentity()} AND `type` = 'friend_request' AND `read` = 0");
			if ($notifications)
			{
				foreach ($notifications as $notification)
				{
					$notification -> read = 1;
					$notification -> save();
				}
				$db -> commit();
			}
		}
		catch (Exception $e)
		{
			$db -> rollBack();
			throw $e;
		}
		// Get Friend request but not confirm yet
		$userTb = Engine_Api::_() -> getDbTable('membership', 'user');
		$select = $userTb -> select() -> where("user_id = ?", $viewer -> getIdentity()) -> where("active = 0 AND resource_approved = 1 AND user_approved = 0");
		$this -> view -> freqs = $userTb -> fetchAll($select);
		$this -> _helper -> layout -> disableLayout();
	}
	// get all friend requests
	public function friendRequestsAction()
	{
		if (!$this -> _helper -> requireUser -> isValid())
			return;
		$viewer = Engine_Api::_() -> user() -> getViewer();
		$notificationsTable = Engine_Api::_() -> getDbtable('notifications', 'activity');
		$notifi_name = $notificationsTable -> info('name');
		$select = $notificationsTable -> select() -> from($notifi_name) -> where("$notifi_name.`user_id` = {$viewer->getIdentity()} AND `type` = 'friend_request' AND `mitigated` = 0") -> order('notification_id DESC');
		$this -> view -> requests = $requests = Zend_Paginator::factory($select);
		$requests -> setCurrentPageNumber($this -> _getParam('page'));
	}
	// get all notifications
	public function notificationsAction()
	{
		if (!$this -> _helper -> requireUser -> isValid())
			return;
		$viewer = Engine_Api::_() -> user() -> getViewer();
        date_default_timezone_set($viewer->timezone);
		$select = Engine_Api::_() -> getDbTable('notifications', 'activity') -> select() -> where("`user_id` = ?", $viewer -> getIdentity()) -> where("`type` NOT IN ('friend_request','message_new')") -> order('read ASC') -> order('notification_id DESC');
		$this -> view -> notifications = $notifications = Zend_Paginator::factory($select);
		$notifications -> setCurrentPageNumber($this -> _getParam('page'));

		// Force rendering now
		$this -> _helper -> viewRenderer -> postDispatch();
		$this -> _helper -> viewRenderer -> setNoRender(true);

		$this -> view -> hasunread = false;

		// Now mark them all as read
		$ids = array();
		foreach ($notifications as $notification)
		{
			$ids[] = $notification -> notification_id;
		}
	}
	
	// view more notifications
	public function pulldownAction()
	{
		$page = $this -> _getParam('page');
		$viewer = Engine_Api::_() -> user() -> getViewer();
        date_default_timezone_set($viewer->timezone);
		$select = Engine_Api::_() -> getDbTable('notifications', 'activity') -> select() -> where("`user_id` = ?", $viewer -> getIdentity()) -> where("`type`NOT IN ('friend_request','message_new')") -> order('notification_id DESC');
		$this -> view -> notifications = $notifications = Zend_Paginator::factory($select);
		$notifications -> setCurrentPageNumber($page);
         $this -> _helper -> layout -> disableLayout();
		/*if ($notifications -> getCurrentItemCount() <= 0 || $page > $notifications -> getCurrentPageNumber())
		{
			$this -> _helper -> viewRenderer -> setNoRender(true);
			return;
		}
		// Force rendering now
		$this -> _helper -> viewRenderer -> postDispatch();
		$this -> _helper -> viewRenderer -> setNoRender(true);*/
	}
	public function clearnotificationsAction(){
		
		$this->_helper->layout->disableLayout();
        $this->_helper->viewRenderer->setNoRender(true);
        $aData             =   $this->_request->getPost();
		$notificatioIds    =   $aData['notificatioIds'];		
		
		try {
         for($i=0;$i< count($notificatioIds) ; $i++){
		
		   Engine_Db_Table::getDefaultAdapter()->delete('engine4_activity_notifications', array('notification_id = ?'=>$notificatioIds[$i]) );
		 }
		 $aResult['status'] = true;
       } catch( Exception $e ) {
         $aResult['status'] = false;
      }
      echo json_encode($aResult);
	}
	
	
}
