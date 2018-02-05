<?php

class Ynresponsivepurity_Widget_GroupGridController extends Engine_Content_Widget_Abstract
{
    public function indexAction()
    {
        if (substr(YNRESPONSIVE_ACTIVE, 0, 18) != 'ynresponsivepurity' || (!Engine_Api::_() -> hasModuleBootstrap('group') && !Engine_Api::_() -> hasModuleBootstrap('advgroup'))) {
            return $this->setNoRender(true);
        }
        $type = $this -> _getParam('type', 'recent');
        $num_groups = $this -> _getParam('num_groups', 3);

        // Get groups
        $table = Engine_Api::_()->getItemTable('group');
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
            default:
                $select->order('group_id DESC');
                break;
        }
        $this->view->groups = $paginator = Zend_Paginator::factory($select);

        // Set item count per page and current page number
        $paginator->setItemCountPerPage($num_groups);
        $paginator->setCurrentPageNumber($this->_getParam('page', 1));

        // Hide if nothing to show
        if( $paginator->getTotalItemCount() <= 0 ) {
            return $this->setNoRender();
        }
    }

}
