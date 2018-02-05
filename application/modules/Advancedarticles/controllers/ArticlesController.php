<?php

class Advancedarticles_ArticlesController extends Core_Controller_Action_Standard {

    protected $module;
    protected $ucfirst_module;
    protected $_perPage;

    public function init() {
        $settings = Engine_Api::_()->getApi('settings', 'core');
        $this->module = $this->getRequest()->getModuleName();
        $this->ucfirst_module = ucfirst($this->module);
        $this->_perPage = isset($settings->art_per_page) ? $settings->art_per_page : 10;
    }

    public function tagscloudAction() {
        // Render
        $this->_helper->content->setNoRender()->setEnabled();
    }

    public function printAction() {
        if (!Engine_Api::_()->getApi('settings', 'core')->getSetting('art.public', 1) && !$this->_helper->requireUser()->isValid())
            return;
        $front = Zend_Controller_Front::getInstance();
        $art_id = (int) $this->_getParam('id', 0);

        $article = Engine_Api::_()->getItem('artarticle', $art_id);

        // Get subject
        if ($art_id && $article instanceof Advancedarticles_Model_Artarticle && !Engine_Api::_()->core()->hasSubject()) {
            Engine_Api::_()->core()->setSubject($article);
        }

        if (!$this->_helper->requireAuth()->setAuthParams($article, null, 'view')->isValid())
            return;

        $this->view->category = $category = Engine_Api::_()->getItem('advancedarticles_category', $article->category_id);

        //View Count Increment
        $viewer = Engine_Api::_()->user()->getViewer();

        $this->view->article = $article;
    }

    public function browseAction() {
        // Render
        
        if( !$this->_helper->requireUser()->isValid() ) {
		  return;
		}	
        $this->_helper->content->setNoRender()->setEnabled();
        $this->view->metaTitle        = 'Articles';	 
    }

    public function categoryAction() {
        // Render
        $this->_helper->content->setNoRender()->setEnabled();
    }

    public function articleAction() {
		
		if( !$this->_helper->requireUser()->isValid() ) {
		  return;
		}
		
        if (!Engine_Api::_()->getApi('settings', 'core')->getSetting('art.public', 1) && !$this->_helper->requireUser()->isValid())
            return;
        $art_id = (int) $this->_getParam('art_id', 0);

        $article = Engine_Api::_()->getItem('artarticle', $art_id);  
        if (!is_object($article)) {
            return $this->_forward('notfound');
        }
        // Get subject
        if ($art_id && $article instanceof Advancedarticles_Model_Artarticle && !Engine_Api::_()->core()->hasSubject()) {
            Engine_Api::_()->core()->setSubject($article);
        }

        //If Not Activate
        if ($article->status == 'inactive' && (Engine_Api::_()->user()->getViewer()->getIdentity() != $article->owner_id)) {
            return $this->_forward('requireauth', 'error', 'core');
        }
        
       // if (!$this->_helper->requireAuth()->setAuthParams($article, null, 'view')->isValid())
       //     return;
     
        // Render
        $this->_helper->content->setNoRender()->setEnabled();
         $this->view->metaTitle        = $article->title;	
    }

    public function viewAction() {
        $art_id = (int) $this->_getParam('art_id', 0);
        $photo_id = (int) $this->_getParam('photo_id', 0);
        if (!$art_id || !$photo_id)
            return $this->_forward('notfound');

        $photos = Engine_Api::_()->getItem('advancedarticles_photo', $photo_id);
        $this->view->article = $article = Engine_Api::_()->getItem('artarticle', $art_id);
        if (!is_object($photos) || !is_object($article))
            return $this->_forward('notfound');

        // Get subject
        if ($photos && !Engine_Api::_()->core()->hasSubject()) {
            Engine_Api::_()->core()->setSubject($photos);
        }

        $this->view->viewer = $viewer = Engine_Api::_()->user()->getViewer();
        $this->view->art_photo = $photo = Engine_Api::_()->core()->getSubject();
        $this->view->art_album = $art_album = $photo->getCollection();
        $this->view->photo_upload = $art_album->authorization()->isAllowed($viewer, 'art_photo');
        $this->view->photo_edit = $art_album->authorization()->isAllowed($viewer, 'art_photo_edit');
        $this->view->photo_delete = $art_album->authorization()->isAllowed($viewer, 'art_photo_delete');
    }

    public function myAction() {
        if (!$this->_helper->requireUser()->isValid())
            return;

        $viewer = Engine_Api::_()->user()->getViewer();
        $this->view->art_create = $this->_helper->requireAuth()->setAuthParams('artarticle', null, 'create')->checkRequire();
        $_module = $this->module;

        $settings = Engine_Api::_()->getApi('settings', 'core');
        $sort = Engine_Api::_()->$_module()->getSort(isset($settings->art_sort) ? $settings->art_sort : 5);

        $form_array = Engine_Api::_()->advancedarticles()->getFilterValue();
        $articles = Engine_Api::_()->$_module()->getArticles($viewer->getIdentity(), $_module, $sort, $form_array['values'], 'owner');

        // Build paginator
        $page = (int) $this->_getParam('page', 1);
        $paginator = Zend_Paginator::factory($articles);
        $paginator->setItemCountPerPage($this->_perPage);
        $paginator->setCurrentPageNumber($page);

        $this->view->paginator = $paginator;
        $this->view->totalArticles = $paginator->getTotalItemCount();
        $this->view->formValues = $form_array['values'];
        $this->view->filter = $filter = isset($form_array['values']['isFilter']) ? $form_array['values']['isFilter'] : 0;

        $this->view->photo_upload = $this->_helper->requireAuth()->setAuthParams('artarticle', null, 'art_photo')->checkRequire();
        $this->view->art_edit = $this->_helper->requireAuth()->setAuthParams('artarticle', null, 'edit')->checkRequire();
        $this->view->art_delete = $this->_helper->requireAuth()->setAuthParams('artarticle', null, 'art_delete')->checkRequire();
    }

    public function addAction() {
        $viewer = Engine_Api::_()->user()->getViewer();

        if (!$this->_helper->requireUser()->isValid())
            return;
        if (!$this->_helper->requireAuth()->setAuthParams('artarticle', null, 'create')->isValid())
            return;

        $_module = $this->module;
        $this->view->max_upload = Engine_Api::_()->authorization()->getPermission($viewer->level_id, 'artarticle', 'art_max');
        $select = Engine_Api::_()->$_module()->getArticles($viewer->getIdentity(), $_module, array(), array(), 'owner');
        $paginator = Zend_Paginator::factory($select);
        $this->view->total_articles = $paginator->getTotalItemCount();

        $class = $this->ucfirst_module . '_Form_Add';
        $form = $this->view->form = new $class();
        $_module = $this->module;

        if ($this->getRequest()->isPost() && $form->isValid($this->getRequest()->getPost())) {
            $table = $this->_helper->api()->getDbtable('artarticles', $this->module);
            $db = $table->getAdapter();
            $db->beginTransaction();

            try {
                $values = $form->getValues();

                $body = htmlspecialchars($values['description']);
                $values['description'] = strip_tags($values['description']);
                $values['url'] = Engine_Api::_()->$_module()->checkURL($values['title']);

                $article = $table->createRow();
                $article->setFromArray($values);
                $article->created_date = $article->updated_date = date('Y-m-d H:i:s');
                $article->owner_id = $article->updated_user_id = $viewer->getIdentity();
                $article->owner_type = $viewer->getType();
                $article->body = $body;

                $draft = $this->getRequest()->getPost('saveasdraft');

                if (isset($draft)) {
                    $article->status = 'draft';
                }
                else {
                    $article->activate_date = date('Y-m-d H:i:s');
                    $article->activate_user_id = $viewer->getIdentity();
                }
                $article->save();

                //save article questions
                $questions = $form->getSubForm('questions');
                $questions->setItem($article);
                $questions->saveValues();

                //Photo
                if ($values['art_photo']) {
                    $photo_id = Engine_Api::_()->$_module()->createPhoto($form->art_photo, $viewer->getIdentity(), $article->artarticle_id)->file_id;
                    $article->addPhoto($photo_id, $_module);
                }

                $article->photo_id = isset($photo_id) ? $photo_id : 0;
                $article->save();
                // Commit
                $db->commit();
            } catch (Exception $e) {
                $db->rollBack();
                throw $e;
            }

            //Privacy
            //art_view
            Engine_Api::_()->$_module()->setAllowed($article, isset($values['auth_view']) ? $values['auth_view'] : '', 'view');
            //art_comment
            Engine_Api::_()->$_module()->setAllowed($article, isset($values['auth_comment']) ? $values['auth_comment'] : '', 'comment');
            //Tags
            if (!empty($values['tags_info'])) {
                $tags_info = preg_split('/[,]+/', $values['tags_info']);
                $tags_temp = array();
                foreach ($tags_info as $val) {
                    $val = trim($val);
                    if (!empty($val))
                        $tags_temp[] = $val;
                }
                $tags_info = $tags_temp;
                $art_tag = new Engine_ProxyObject($article, Engine_Api::_()->getDbtable('tags', 'core'));
                $art_tag->addTagMaps($viewer, $tags_info);
            }
            
            //Activity
            if (!isset($draft)) {
                $activity = Engine_Api::_()->getDbtable('actions', 'activity')->addActivity($viewer, $article, 'artarticle');
                if ($activity)
                    Engine_Api::_()->getDbtable('actions', 'activity')->attachActivity($activity, $article);
            }

            return $this->_forward('success', 'utility', 'core', array(
                        'messages' => array(Zend_Registry::get('Zend_Translate')->_('Article has been added.')),
                        'redirect' => $this->getFrontController()->getRouter()->assemble(array('action' => 'my'), 'advancedarticles_general', true)
                    ));
        }

        $this->view->tinyMce()->setOptions(Engine_Api::_()->$_module()->initTinyMCE());
    }

    public function editAction() {
        $viewer = Engine_Api::_()->user()->getViewer();
        if (!$this->_helper->requireUser()->isValid())
            return;

        $class = $this->ucfirst_module . '_Form_Edit';
        $_module = $this->module;

        $id = $this->_getParam('id', 0);
        $article = Engine_Api::_()->getItem('artarticle', $id);

        // Get subject
        if ($article && !Engine_Api::_()->core()->hasSubject()) {
            Engine_Api::_()->core()->setSubject($article);
        }

       // if (!$this->_helper->requireAuth()->setAuthParams(null, null, 'edit')->isValid())
        //    return;
        $this->view->form = $form = new $class();

        if (!$this->getRequest()->isPost()) {
            $values_edit = $article->toArray();
            $values_edit['description'] = htmlspecialchars_decode($values_edit['body']);
            $values_edit['tags_info'] = $article->getAllTags();
            $form->populate($values_edit);
            $form->cancel->setAttrib('href', $article->getHref());

            $auth = Engine_Api::_()->authorization()->context;
            $roles = array_keys(Engine_Api::_()->$_module()->getPrivacy());
            krsort($roles);
            foreach ($roles as $role) {
                if ($auth->isAllowed($article, $role, 'view') === 1) {
                    if (isset($form->auth_view))
                        $form->auth_view->setValue($role);
                }
                if ($auth->isAllowed($article, $role, 'comment') === 1) {
                    if (isset($form->auth_comment))
                        $form->auth_comment->setValue($role);
                }
            }
            $this->view->tinyMce()->setOptions(Engine_Api::_()->$_module()->initTinyMCE());
            return;
        }

        if ($this->getRequest()->isPost() && $form->isValid($this->getRequest()->getPost())) {

            $table = $this->_helper->api()->getDbtable('artarticles', $this->module);
            $db = $table->getAdapter();
            $db->beginTransaction();

            try {
                $values = $form->getValues();

                $body = htmlspecialchars($values['description']);
                $values['description'] = strip_tags($values['description']);
                $values['url'] = Engine_Api::_()->$_module()->checkURL($values['title']);

                $article->setFromArray($values);
                $article->updated_date = date('Y-m-d H:i:s');
                $article->updated_user_id = $viewer->getIdentity();
                $article->body = $body;

		         $trending_articles = $table->fetchAll($table->select()->where('trending_article = ?', '1')); 
		         /*if(count($trending_articles) >= 5){
					  $article->trending_article = 0;
				 }*/

                $article->save();

                //save article questions
                $questions = $form->getSubForm('questions');
                $questions->saveValues();

                //Privacy
                //art_view
                Engine_Api::_()->$_module()->setAllowed($article, isset($values['auth_view']) ? $values['auth_view'] : '', 'view');
                //art_comment
                Engine_Api::_()->$_module()->setAllowed($article, isset($values['auth_comment']) ? $values['auth_comment'] : '', 'comment');

                $actionTable = Engine_Api::_()->getDbtable('actions', 'activity');
                foreach ($actionTable->getActionsByObject($article) as $action) {
                    $actionTable->resetActivityBindings($action);
                }
                //Tags
                if (!empty($values['tags_info'])) {
                    $tags_info = preg_split('/[,]+/', $values['tags_info']);
                    $tags_temp = array();
                    foreach ($tags_info as $val) {
                        $val = trim($val);
                        if (!empty($val))
                            $tags_temp[] = $val;
                    }
                    $tags_info = $tags_temp;

                    $art_tag = new Engine_ProxyObject($article, Engine_Api::_()->getDbtable('tags', 'core'));
                    $art_tag->setTagMaps($viewer, $tags_info);
                }

                // Commit
                $db->commit();
            } catch (Exception $e) {
                $db->rollBack();
                throw $e;
            }

            return $this->_forward('success', 'utility', 'core', array(
                        'messages' => array(Zend_Registry::get('Zend_Translate')->_('Article has been edited.')),
                        //'redirect' => $article->getHref()
                        'redirect' => $this->getFrontController()->getRouter()->assemble(array('module'=>'advancedarticles','controller'=>'settings','action' => 'articles'), 'admin_default', true)
                    ));
        }
    }

    public function deleteAction() {
        $viewer = Engine_Api::_()->user()->getViewer();
        if (!$this->_helper->requireUser()->isValid())
            return;

        $class = $this->ucfirst_module . '_Form_Delete';
        $this->view->form = $form = new $class();
        $id = (int) $this->_getParam('id', 0);

        $article = Engine_Api::_()->getItem('artarticle', $id);
        // Get subject
        if ($article && !Engine_Api::_()->core()->hasSubject()) {
            Engine_Api::_()->core()->setSubject($article);
        }
        if (!$this->_helper->requireAuth()->setAuthParams(null, null, 'art_delete')->isValid())
            return;

        if ($this->getRequest()->isPost()) {
            $table = $this->_helper->api()->getDbtable('artarticles', $this->module);
            $db = $table->getAdapter();
            $db->beginTransaction();

            try {
                // delete article
                $article->delete();

                //delete other
                $article->deleteAll($id);

                // commit
                $db->commit();

                // Forward
                return $this->_forward('success', 'utility', 'core', array(
                            'smoothboxClose' => true,
                            'parentRedirect' => $this->getFrontController()->getRouter()->assemble(array('action' => 'my'), 'advancedarticles_general', true),
                            'format' => 'smoothbox',
                            'messages' => array('Article has been deleted.')
                        ));
            } catch (Exception $e) {
                $db->rollBack();
                throw $e;
            }
        }
    }

    public function uploadAction() {
        if (!$this->_helper->requireUser()->isValid())
            return;

        if (!isset($_FILES['Filedata']))
            return;

        $viewer = Engine_Api::_()->user()->getViewer();
        $_module = $this->module;
        $mainUrl = Engine_Api::_()->$_module()->createPhoto($_FILES['Filedata'], $viewer->getIdentity(), $viewer->getIdentity(), 'artarticle', 'user')->storage_path;
        echo Engine_Api::_()->$_module()->imageTab($this->view->baseUrl(), $mainUrl);
        exit;
    }

    public function statusAction() {
        if (!$this->_helper->requireUser()->isValid())
            return;

        $id = (int) $this->_getParam('id', 0);
        $viewer = Engine_Api::_()->user()->getViewer();

        $article = Engine_Api::_()->getItem('artarticle', $id);

        if (!is_object($article))
            return;

        $subclass = '';
        $label = '';
        switch ($article->status) {
            case 'active':
                $article->status = 'inactive';
                $subclass = 'icon_activate';
                $label = $this->view->translate('Activate');
                $article->save();
                break;
            default:
                if ($article->status == 'draft') {
                    $activity = Engine_Api::_()->getDbtable('actions', 'activity')->addActivity($viewer, $article, 'artarticle');
                    if ($activity)
                        Engine_Api::_()->getDbtable('actions', 'activity')->attachActivity($activity, $article);
                }
                $article->status = 'active';
                $article->activate_date = date('Y-m-d H:i:s');
                $article->activate_user_id = $viewer->getIdentity();
                $subclass = 'icon_deactivate';
                $label = $this->view->translate('Deactivate');
                $article->save();
                break;
        }

        $this->view->subclass = $subclass;
        $this->view->label = $label;
    }

    public function photoAction() {
        $viewer = Engine_Api::_()->user()->getViewer();
        $this->view->art_create = $this->_helper->requireAuth()->setAuthParams('artarticle', null, 'create')->checkRequire();
        $_module = $this->module;
    }

    public function allphotoAction() {
        $art_id = (int) $this->_getParam('id', 0);
        $page = (int) $this->_getParam('page', 1);
        if (!$art_id)
            return $this->_forward('notfound');

        $this->view->article = $article = Engine_Api::_()->getItem('artarticle', $art_id);
        if (!is_object($article))
            return $this->_forward('notfound');

        // Get subject
        if ($art_id && $article instanceof Advancedarticles_Model_Artarticle && !Engine_Api::_()->core()->hasSubject()) {
            Engine_Api::_()->core()->setSubject($article);
        }

        $photos = $article->getAlbum();

        $this->view->photo_upload = Engine_Api::_()->authorization()->isAllowed('artarticle', null, 'art_photo');
        $this->view->photo_edit = Engine_Api::_()->authorization()->isAllowed('artarticle', null, 'art_photo_edit');

        $settings = Engine_Api::_()->getApi('settings', 'core');
        $this->view->paginator = $paginator = $photos->getCollectiblesPaginator();
        $paginator->setCurrentPageNumber($page);
        $paginator->setItemCountPerPage($settings->getSetting('art_photo_page', 25));
        $this->view->totalPhotos = $paginator->getTotalItemCount();
    }

    public function editphotoAction() {
        if (!$this->_helper->requireUser()->isValid())
            return;

        $art_id = (int) $this->_getParam('id', 0);
        $page = (int) $this->_getParam('page', 1);
        if (!$art_id)
            return $this->_forward('notfound');

        $this->view->article = $article = Engine_Api::_()->getItem('artarticle', $art_id);
        if (!is_object($article))
            return $this->_forward('notfound');

        // Get subject
        if ($art_id && $article instanceof Advancedarticles_Model_Artarticle && !Engine_Api::_()->core()->hasSubject()) {
            Engine_Api::_()->core()->setSubject($article);
        }

      //  if (!$this->_helper->requireAuth()->setAuthParams(null, null, 'art_photo_edit')->isValid())
//return;

        $photos = $article->getAlbum();
        $this->view->photo_upload = $this->_helper->requireAuth()->setAuthParams('artarticle', null, 'art_photo')->checkRequire();

        $this->view->paginator = $paginator = $photos->getCollectiblesPaginator();
        $paginator->setCurrentPageNumber($page);
        $paginator->setItemCountPerPage(10);
        $this->view->totalPhotos = $paginator->getTotalItemCount();

        if ($this->getRequest()->isPost()) {
            $values = $this->getRequest()->getPost();
            $deletedFiles = array();
            foreach ($paginator as $item) {
                if (isset($values[$item->getGuid()]['delete']) && $values[$item->getGuid()]['delete']) {
                    //delete storage file...
                    $deletedFiles[] = $item->deleteStorage();
                    $item->delete();
                } else {
                    $item->setFromArray($values[$item->getGuid()]);
                    $item->save();
                }
            }
            if (isset($values['art_cover']) && !empty($values['art_cover'])) {
                if (in_array($values['art_cover'], $deletedFiles)) { //if cover deleted
                    $all_photos = $photos->getCollectibles();
                  //  $article->photo_id = $all_photos ? $all_photos[0]->file_id : 0;
                    $article->photo_id =0;
                }
                else
                    $article->photo_id = $values['art_cover'];
                $article->save();
            }
          //  return $this->_helper->redirector->gotoRoute(array('action' => 'allphoto', 'id' => $article->getIdentity()), "advancedarticles_category_specific", true);
        //return $this->_helper->redirector->gotoUrl($article->getHref(), array('prependBase' => false));
        return $this->_helper->redirector->gotoRoute(array('module'=>'advancedarticles','controller'=>'settings','action' => 'articles'), 'admin_default', true);
        }
    }

    public function photoEditAction() {
        if (!$this->_helper->requireAuth()->setAuthParams('artarticle', null, 'art_photo_edit')->isValid())
            return;

        $photo_id = (int) $this->_getParam('id', 0);
        if (!$photo_id)
            return $this->_forward('notfound');

        $this->view->photo = $photo = Engine_Api::_()->getItem('advancedarticles_photo', $photo_id);
        if (!is_object($photo))
            return $this->_forward('notfound');

        $class = $this->ucfirst_module . '_Form_PhotoEdit';
        $form = $this->view->form = new $class();

        $form->populate($photo->toArray());

        if ($this->getRequest()->isPost() && $form->isValid($this->getRequest()->getPost())) {

            $table = $this->_helper->api()->getDbtable('photos', $this->module);
            $db = $table->getAdapter();
            $db->beginTransaction();

            try {
                $values = $form->getValues();
                $photo->setFromArray($values);
                $photo->updated_date = date('Y-m-d H:i:s');

                $photo->save();
                // Commit
                $db->commit();
            } catch (Exception $e) {
                $db->rollBack();
                throw $e;
            }

            // Forward
            return $this->_forward('success', 'utility', 'core', array(
                        'smoothboxClose' => true,
                        'parentRefresh' => true,
                        'format' => 'smoothbox',
                        'messages' => array(Zend_Registry::get('Zend_Translate')->_('Your changes have been saved.')),
                    ));
        }
    }

    public function photoDeleteAction() {
        if (!$this->_helper->requireAuth()->setAuthParams('artarticle', null, 'art_photo_delete')->isValid())
            return;
        $class = $this->ucfirst_module . '_Form_PhotoDelete';
        $this->view->form = $form = new $class();
        $id = (int) $this->_getParam('id', 0);

        $photo = Engine_Api::_()->getItem('advancedarticles_photo', $id);

        if ($this->getRequest()->isPost()) {
            $article = $photo->artarticle_id;
            $art = Engine_Api::_()->getItem('artarticle', $article);
            $table = $this->_helper->api()->getDbtable('photos', $this->module);
            $db = $table->getAdapter();
            $db->beginTransaction();

            try {
                // delete photo
                $cover_id = $photo->deleteStorage();
                $photo->delete();

                if ($art->photo_id == $cover_id) { //if cover deleted
                    $photos = $art->getAlbum();
                    $all_photos = $photos->getCollectibles();
                    $art->photo_id = $all_photos ? $all_photos[0]->file_id : 0;
                    $art->save();
                }

                // commit
                $db->commit();

                // Forward
                return $this->_forward('success', 'utility', 'core', array(
                            'smoothboxClose' => true,
                            'parentRedirect' => $this->getFrontController()->getRouter()->assemble(array('action' => 'allphoto', 'id' => $article), "advancedarticles_category_specific", true),
                            'format' => 'smoothbox',
                            'messages' => array(Zend_Registry::get('Zend_Translate')->_('Photo has been deleted.'))
                        ));
            } catch (Exception $e) {
                $db->rollBack();
                throw $e;
            }
        }
    }

    public function addphotoAction() {
        if (!$this->_helper->requireAuth()->setAuthParams('artarticle', null, 'art_photo')->isValid())
            return;

        if (isset($_GET['ul']) || isset($_FILES['Filedata']))
            return $this->_forward('upload-photo', null, null, array('format' => 'json'));

        $viewer = Engine_Api::_()->user()->getViewer();
        $id = (int) $this->_getParam('id', 0);
        $_module = $this->module;

        $this->view->article = $article = Engine_Api::_()->getItem('artarticle', $id);

        $class = $this->ucfirst_module . '_Form_AddPhoto';
        $this->view->form = $form = new $class();

        // Get subject
        if ($id && $article instanceof Advancedarticles_Model_Artarticle && !Engine_Api::_()->core()->hasSubject()) {
            Engine_Api::_()->core()->setSubject($article);
        }

        if ($this->getRequest()->isPost() && $form->isValid($this->getRequest()->getPost())) {
            $values = $form->getValues();

            foreach ($values['file'] as $fid) {
                if (!$article->photo_id) {
                    $article->photo_id = $fid;
                    $article->save();
                }
                $article->addPhoto($fid);
            }

            // redirect to article page
            return $this->_helper->redirector->gotoUrl($article->getHref(), array('prependBase' => false));
        }
    }

    public function uploadPhotoAction() {
        if (!$this->_helper->requireAuth()->setAuthParams('artarticle', null, 'art_photo')->isValid())
            return;

        if (!$this->_helper->requireUser()->checkRequire()) {
            $this->view->status = false;
            $this->view->error = Zend_Registry::get('Zend_Translate')->_("Max file size limit exceeded (probably).");
            return;
        }

        if (!$this->getRequest()->isPost()) {
            $this->view->status = false;
            $this->view->error = Zend_Registry::get('Zend_Translate')->_("Invalid request method");
            return;
        }

        $values = $this->getRequest()->getPost();
        /*if (empty($values['Filename'])) {
            $this->view->status = false;
            $this->view->error = Zend_Registry::get('Zend_Translate')->_("No file");
            return;
        }*/

        if (!isset($_FILES['Filedata']) || !is_uploaded_file($_FILES['Filedata']['tmp_name'])) {
            $this->view->status = false;
            $this->view->error = Zend_Registry::get('Zend_Translate')->_("Invalid Upload");
            return;
        }
        $viewer = Engine_Api::_()->user()->getViewer();
        $_module = $this->module;
        $id = (int) $this->_getParam('id', 0);

        $photo_id = Engine_Api::_()->$_module()->createPhoto($_FILES['Filedata'], $viewer->getIdentity(), $id)->file_id;

        $this->view->status = true;
        $this->view->name = $_FILES['Filedata']['name'];
        $this->view->photo_id = $photo_id;
        
    }
    
    public function addnewphotoAction()
    {
		if (!$this->_helper->requireAuth()->setAuthParams('artarticle', null, 'art_photo')->isValid())
            return;

        if (isset($_GET['ul']) || isset($_FILES['Filedata']))
           // return $this->_forward('upload-photo', null, null, array('format' => 'json'));

        $viewer = Engine_Api::_()->user()->getViewer();
        $id = (int) $this->_getParam('id', 0);
        $_module = $this->module;

        $this->view->article = $article = Engine_Api::_()->getItem('artarticle', $id);

        $class = $this->ucfirst_module . '_Form_AddNewPhoto';
        $this->view->form = $form = new $class();

        // Get subject
        if ($id && $article instanceof Advancedarticles_Model_Artarticle && !Engine_Api::_()->core()->hasSubject()) {
            Engine_Api::_()->core()->setSubject($article);
        }
        
        
        if (!$this->_helper->requireAuth()->setAuthParams('artarticle', null, 'art_photo')->isValid())
            return;

        if (!$this->_helper->requireUser()->checkRequire()) {
            $this->view->status = false;
            $this->view->error = Zend_Registry::get('Zend_Translate')->_("Max file size limit exceeded (probably).");
            return;
        }

        if (!$this->getRequest()->isPost()) {
            $this->view->status = false;
            $this->view->error = Zend_Registry::get('Zend_Translate')->_("Invalid request method");
            return;
        }

        $values = $this->getRequest()->getPost();

        if (!isset($_FILES['Filedata']) || !is_uploaded_file($_FILES['Filedata']['tmp_name'])) {
            $this->view->status = false;
            $this->view->error = Zend_Registry::get('Zend_Translate')->_("Invalid Upload");
            return;
        }
        
        
         if ($this->getRequest()->isPost() && $form->isValid($this->getRequest()->getPost())) {
			 
			 

        $viewer = Engine_Api::_()->user()->getViewer();
        $_module = $this->module;
        $id = (int) $this->_getParam('id', 0);

         $photo_id = Engine_Api::_()->$_module()->createPhoto($_FILES['Filedata'], $viewer->getIdentity(), $id)->file_id; 
			 

        $values = $form->getValues();
        if (!$article->photo_id) {
                    $article->photo_id = $photo_id;
                    $article->save();
                }
                $article->addPhoto($photo_id);

         //  return $this->_helper->redirector->gotoUrl($article->getHref(), array('prependBase' => false));
           return $this->_helper->redirector->gotoRoute(array('module'=>'advancedarticles','controller'=>'settings','action' => 'articles'), 'admin_default', true);
        }
		
	}
	public function articlelikeAction(){
		

		
		$this->_helper->viewRenderer->setNoRender(true);
		$this->_helper->layout->disableLayout();
		
		$viewer_id  = Engine_Api::_()->user()->getViewer()->getIdentity();
		
		if( $this->getRequest()->isPost()){
			
			$aData       = $this->_request->getPost();
			
			
			$article_id   = $aData['article_id'];
			
			$articlelikeTable =  Engine_Api::_()->getDbtable('Articlelike', 'user');
			
			$articlelikeTableid=   $articlelikeTable->insert(array(
					
					'articleId'    => $article_id,
					'likedBy'     => $viewer_id,
					'created_at'      => date('Y-m-d H:i:s'),
					'updated_at'      => date('Y-m-d H:i:s'),
					
					));

			
			$aResult['status'] =true; 
			
			
		}
		else{
			$aResult['status'] =false; 
		}
		
		echo json_encode($aResult);
		
	
		
	}
	
	public function getarticlelikedusersAction(){
		
		$this->_helper->viewRenderer->setNoRender(true);
		$this->_helper->layout->disableLayout();
		
		$viewer_id  = Engine_Api::_()->user()->getViewer()->getIdentity();
		
	   if( $this->getRequest()->isPost()){
			
			$aData       = $this->_request->getPost();
			
			
			$article_id   = $aData['article_id'];
			
			$articlelikeTable =  Engine_Api::_()->getDbtable('Articlelike', 'user');
			
			$articlelikeData = $articlelikeTable->fetchAll($articlelikeTable->select()
			
			                                           ->where('articleId = ?', $article_id));   
			                                           
			                                           	  

			$aResult['likecount'] =count($articlelikeData);
			
		}
	    
		 
        echo json_encode($aResult);
        
      
		
	}
    public function articleunlikeAction(){
		
		$this->_helper->viewRenderer->setNoRender(true);
		$this->_helper->layout->disableLayout();
		
		$viewer_id  = Engine_Api::_()->user()->getViewer()->getIdentity();
		if( $this->getRequest()->isPost()){
			
		$aData       = $this->_request->getPost();

		$article_id   = $aData['article_id'];
			
	    Engine_Db_Table::getDefaultAdapter()->delete('engine4_article_likes', array('articleId = ?'=>$article_id,'likedBy = ?'=>$viewer_id) );
        
        $aResult['status'] =true; 
			
		}
		else{
			
			$aResult['status'] =false; 
		}
		echo json_encode($aResult);
		
	}
	
	
	
	public function postcommentAction(){
		 
		$this->_helper->viewRenderer->setNoRender(true);
		$this->_helper->layout->disableLayout();
		
		$viewer_id  = Engine_Api::_()->user()->getViewer()->getIdentity();
		if( $this->getRequest()->isPost()){
			
		$aData       = $this->_request->getPost();

		$article_id   = $aData['article_id'];
		$article_comment_body   = $aData['article_comment_body'];
		
		
		$articlecommentTable =  Engine_Api::_()->getDbtable('Articlecomments', 'user');
		
		$articlecommentTableId=   $articlecommentTable->insert(array(
					
					'articleId'       => $article_id,
					'posterId'        => $viewer_id,
					'body'            => $article_comment_body,
					'created_at'      => date('Y-m-d H:i:s'),
					'updated_at'      => date('Y-m-d H:i:s'),
					
					));

			
		$aResult['status'] =true; 
		
		
	    }
	    else{
			$aResult['status'] =false; 
		}
		
		echo json_encode($aResult);
		 
		 
	}
	
	public function getarticlecommentsAction(){
		
		
		$this->_helper->viewRenderer->setNoRender(true);
		$this->_helper->layout->disableLayout();
		
		$viewer_id  = Engine_Api::_()->user()->getViewer()->getIdentity();
		if( $this->getRequest()->isPost()){
			
		$aData       = $this->_request->getPost();

		$article_id   = $aData['article_id'];
		
        $connectionApi  =   Engine_Api::_()->getApi('connections', 'advancedarticles'); 
		
		$aResult       =   $connectionApi->getarticlecomments($viewer_id,$article_id);
		 
        
	    }
	    
	    


		return $aResult;
		//echo json_encode($aResult);
	}
	
	public function getsavedarticlesAction(){
		
		
		$this->_helper->viewRenderer->setNoRender(true);
		$this->_helper->layout->disableLayout();
		
		$viewer_id  = Engine_Api::_()->user()->getViewer()->getIdentity();
		

		
        $connectionApi  =   Engine_Api::_()->getApi('connections', 'advancedarticles'); 
		
		$aResult       =   $connectionApi->getsavedarticles($viewer_id);
		 
		return $aResult;
		//echo json_encode($aResult);
	}

}
