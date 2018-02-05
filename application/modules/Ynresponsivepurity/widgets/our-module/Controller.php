<?php

class Ynresponsivepurity_Widget_OurModuleController extends Engine_Content_Widget_Abstract
{
    public function indexAction()
    {
        if (substr(YNRESPONSIVE_ACTIVE, 0, 18) != 'ynresponsivepurity') {
            return $this->setNoRender(true);
        }
        $number_of_module = $this->_getParam('number_of_module', 10);
        $this->view->title = $this->_getParam('title', '');
        $this->view->short_description = $this->_getParam('short_description', '');
        $this->view->description = $this->_getParam('description', '');
        $this->view->modules = Engine_Api::_()->getDbTable('modules', 'ynresponsivepurity')->getModulePaginator();
        $this->view->modules->setItemCountPerPage($number_of_module);
        $this->view->number_of_module = $number_of_module;
        $this->getElement()->removeDecorator('Title');
    }

    public function getCacheKey()
    {
    }
}
