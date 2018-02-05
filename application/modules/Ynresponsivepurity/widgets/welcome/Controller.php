<?php

class Ynresponsivepurity_Widget_WelcomeController extends Engine_Content_Widget_Abstract
{
    public function indexAction()
    {
        if (substr(YNRESPONSIVE_ACTIVE, 0, 18) != 'ynresponsivepurity') {
            return $this->setNoRender(true);
        }
        $this->view->welcomes = Engine_Api::_()->getDbTable('welcomes', 'ynresponsivepurity')->getWelcomePaginator();
        $this->view->welcomes->setItemCountPerPage(3);
    }
}