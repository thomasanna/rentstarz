<?php
class Cometchat_Plugin_Core extends Core_Plugin_Abstract
{
    public function onRenderLayoutDefault($event, $mode = null){

        $view = $event->getPayload();
        $view1 = Zend_Registry::get('Zend_View');
        if( !($view instanceof Zend_View_Interface) ) {
            return;
        }
        $viewer = Engine_Api::_()->user()->getViewer();
        $user_id = $viewer->getIdentity();
        $per_table = Engine_Api::_()->getDbtable('permissions', 'authorization');
        $per_select = $per_table->select()
        ->where('type = ?', 'hide_cometchat')
        ->where('level_id = ?', 101);
        $type = $per_table->fetchRow($per_select);
        if($type['value'] == 1){
            return;
        }
        if($user_id > 0){
            $level_id = $viewer->offsetGet('level_id');
            $permission_table = Engine_Api::_()->getDbtable('permissions','authorization');
            $permission_select = $permission_table->select()
            ->where('type = ?', 'CometChat')
            ->where('level_id = ?', $level_id);
            $userlevel = $permission_table->fetchRow($permission_select);
            if($userlevel['value'] == 1){
                $view->headLink()->appendStylesheet($view1->baseUrl()."/cometchat/cometchatcss.php");
                $view->headScript()->appendFile($view1->baseUrl()."/cometchat/cometchatjs.php");
            }
        }else{
            $view->headLink()->appendStylesheet($view1->baseUrl()."/cometchat/cometchatcss.php");
            $view->headScript()->appendFile($view1->baseUrl()."/cometchat/cometchatjs.php");
        }
    }
    public function onMessagesMessageCreateAfter($event){
        $per_table = Engine_Api::_()->getDbtable('permissions', 'authorization');
        $per_select = $per_table->select()
        ->where('type = ?', 'cometchat')
        ->where('level_id = ?', 100);
        $type = $per_table->fetchRow($per_select);
        if($type->value == 0){
            return;
        }
        $viewer = Engine_Api::_()->user()->getViewer();
        $user_id = $viewer->getIdentity();
        if(isset($_REQUEST['body']) && isset($_REQUEST['submit'])){
            $msgbody = trim($_REQUEST['body']);
            if(isset($_REQUEST['toValues'])){
                $check = $msgbody.$user_id;
                $toval = $_REQUEST['toValues'];
                $toval = explode(",", $toval);
                foreach($toval as $to){
                    $query=Engine_Db_Table::getDefaultAdapter()->insert('cometchat',array(
                        'from' => $user_id,
                        'to' => $to,
                        'message' => $msgbody,
                        'sent' => time()
                        ));
                    $attachment = '';
                    if(isset($_REQUEST['attachment'])){
                        $attachment = $_REQUEST['attachment']['uri'];
                    }
                    if($attachment != ''){
                        $a_msg = "<a href=".$attachment." target='_blank'>".$attachment."</a>";
                        $query=Engine_Db_Table::getDefaultAdapter()->insert('cometchat',array(
                            'from' => $user_id,
                            'to' => $to,
                            'message' => $a_msg,
                            'sent' => time()
                            ));
                    }
                }
            }elseif(isset($_REQUEST['body'])){
                $msg_table = Engine_Api::_()->getDbtable('messages','messages');
                $last_msg = $msg_table->select()
                ->query()
                ->fetchAll(Zend_Db::FETCH_COLUMN);
                $last = end($last_msg);
                $msg_r = $msg_table->select()
                ->where('message_id = ?',$last);
                $msg = $msg_table->fetchRow($msg_r);
                $convid = $msg['conversation_id'];
                if(!empty($convid)){
                    $conv_table = Engine_Api::_()->getDbtable('recipients','messages');
                    $conv_select = $conv_table->select()
                    ->where('conversation_id = ?',$convid)
                    ->where('user_id != ?',$user_id);
                    $todetail = $conv_table->fetchRow($conv_select);
                    $to = $todetail['user_id'];
                    $query=Engine_Db_Table::getDefaultAdapter()->insert('cometchat',array(
                        'from' => $user_id,
                        'to' => $to,
                        'message' => $msgbody,
                        'sent' => time()
                        ));
                    $attachment = '';
                    if(isset($_REQUEST['attachment'])){
                        $attachment = $_REQUEST['attachment']['uri'];
                    }
                    if($attachment != ''){
                        $a_msg = "<a href=".$attachment." target='_blank'>".$attachment."</a>";
                        $query=Engine_Db_Table::getDefaultAdapter()->insert('cometchat',array(
                            'from' => $user_id,
                            'to' => $to,
                            'message' => $a_msg,
                            'sent' => time()
                            ));
                    }
                }
            }
        }
    }
}
?>