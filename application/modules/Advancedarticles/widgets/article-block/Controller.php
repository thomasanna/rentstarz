<?php

class Advancedarticles_Widget_ArticleBlockController extends Engine_Content_Widget_Abstract {

    public function indexAction() {
        $front = Zend_Controller_Front::getInstance();
        $art_id = (int) $front->getRequest()->getParam('art_id', 0);
        if (!$art_id)
            return $this->setNoRender();

        $article = Engine_Api::_()->getItem('artarticle', $art_id);

        if (!is_object($article))
            return $this->setNoRender();

        // Get subject
        if ($art_id && $article instanceof Advancedarticles_Model_Artarticle && !Engine_Api::_()->core()->hasSubject()) {
            Engine_Api::_()->core()->setSubject($article);
        }

        $this->view->category = $category = Engine_Api::_()->getItem('advancedarticles_category', $article->category_id);

        //View Count Increment
        $viewer = Engine_Api::_()->user()->getViewer();

        if ($viewer->getIdentity() != $article->owner_id)
            $article->num_views++;
        $article->save();
        $this->view->article = $article;

        $photos = $article->getAlbum();

        // Load questions
        $view = $this->view;
        $view->addHelperPath(APPLICATION_PATH . '/application/modules/Fields/View/Helper', 'Fields_View_Helper');
        $fields = Engine_Api::_()->fields()->getFieldsStructurePartial($article);
        $this->view->questions = $questions = $this->view->fieldValueLoop($article, $fields);

        $settings = Engine_Api::_()->getApi('settings', 'core');
        $perpage = isset($settings->art_photo) ? $settings->art_photo : 4;
        $this->view->paginator = $paginator = $photos->getCollectiblesPaginator();
        $paginator->setItemCountPerPage($perpage);
        $paginator->setCurrentPageNumber(1);
        $this->view->totalPhotos = $paginator->getTotalItemCount();

        $this->view->photo_upload = $photos->authorization()->isAllowed($viewer, 'art_photo');
        $this->view->photo_edit = $photos->authorization()->isAllowed($viewer, 'art_photo_edit');
    }

}

