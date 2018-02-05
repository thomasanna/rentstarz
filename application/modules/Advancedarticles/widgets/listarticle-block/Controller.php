<?php

class Advancedarticles_Widget_ListArticleBlockController extends Engine_Content_Widget_Abstract {

    public function indexAction() {
        $front = Zend_Controller_Front::getInstance();
        $_module = $front->getRequest()->getModuleName();
        $id = (int) $front->getRequest()->getParam('id', 0);

        $settings = Engine_Api::_()->getApi('settings', 'core');
        $sort = Engine_Api::_()->$_module()->getSort(isset($settings->art_sort) ? $settings->art_sort : 5);

        $form_array = Engine_Api::_()->advancedarticles()->getFilterValue();

        $articles = Engine_Api::_()->$_module()->getArticles($id, $_module, $sort, $form_array['values']);
        if (!is_object($articles))
            return $this->setNoRender();

        // Build paginator
        $perPage = isset($settings->art_per_page) ? $settings->art_per_page : 10;
        $page = (int) $front->getRequest()->getParam('page', 1);
        $paginator = Zend_Paginator::factory($articles);
        $paginator->setItemCountPerPage($perPage);
        $paginator->setCurrentPageNumber($page);

        $auth = new Authorization_Controller_Action_Helper_RequireAuth();
        $this->view->art_create = $auth->setAuthParams('artarticle', null, 'create')->checkRequire();

        $this->view->category = Engine_Api::_()->getItem('advancedarticles_category', $id);
        $this->view->paginator = $paginator;
        $this->view->totalArticles = $paginator->getTotalItemCount();

        $this->view->filter = $filter = isset($form_array['values']['isFilter']) ? $form_array['values']['isFilter'] : 0;
        $this->view->formValues = $form_array['values'];
    }

}

