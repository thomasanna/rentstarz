<?php

class Ynresponsivepurity_Widget_EventGridController extends Engine_Content_Widget_Abstract
{
    public function indexAction()
    {
        if (substr(YNRESPONSIVE_ACTIVE, 0, 18) != 'ynresponsivepurity' || (!Engine_Api::_() -> hasModuleBootstrap('event') && !Engine_Api::_() -> hasModuleBootstrap('ynevent'))) {
            return $this->setNoRender(true);
        }
        $type = $this -> _getParam('type', 'upcoming');
        $num_events = $this -> _getParam('num_events', 3);

        // Get events
        $table = Engine_Api::_()->getItemTable('event');
        $select = $table->select()
            ->where('search = ?', 1);

        switch($type)
        {
            case 'most-view':
                $select->order('view_count DESC');
                break;
            case 'most-member':
                $select->order('member_count DESC');
                break;
            case 'recent':
                $select->order('event_id DESC');
                break;
            case 'upcoming':
                $select
                    ->where("`endtime` > FROM_UNIXTIME(?)", time())
                    ->order("starttime ASC");
                break;
            case 'past':
                $select
                    -> where("endtime < FROM_UNIXTIME(?)", time())
                    -> order("starttime ASC");
                break;
        }

        $this->view->events = $paginator = Zend_Paginator::factory($select);

        // Set item count per page and current page number
        $paginator->setItemCountPerPage($num_events);
        $paginator->setCurrentPageNumber($this->_getParam('page', 1));

        // Hide if nothing to show
        if( $paginator->getTotalItemCount() <= 0 ) {
            return $this->setNoRender();
        }
    }
}
