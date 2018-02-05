<?php
class Ynresponsivepurity_AdminManageModuleController extends Core_Controller_Action_Admin {
    public function init() {
        $this -> view -> navigation =  Engine_Api::_() -> getApi('menus', 'core') -> getNavigation('ynresponsivepurity_admin_main', array(), 'ynresponsivepurity_admin_main_manage_module');
    }

    public function indexAction() {
        if ($this -> getRequest() -> isPost()) {
            $values = $this -> getRequest() -> getPost();
            foreach ($values as $key => $value) {
                if ($key == 'delete_' . $value) {
                    $photo = Engine_Api::_() -> getItem('ynresponsivepurity_module', $value);
                    if ($photo) {
                        $photo -> delete();
                    }
                }
            }
        }
        $page = $this -> _getParam('page', 1);
        $this -> view -> paginator = Engine_Api::_() -> getDbTable('modules', 'ynresponsivepurity') -> getModulePaginator();
        $this -> view -> paginator -> setItemCountPerPage(10);
        $this -> view -> paginator -> setCurrentPageNumber($page);
    }

    public function deleteAction() {
        // In smoothbox
        $this -> _helper -> layout -> setLayout('admin-simple');
        $id = $this -> _getParam('id');
        $this -> view -> photo_id = $id;
        // Check post
        if ($this -> getRequest() -> isPost()) {
            $db = Engine_Db_Table::getDefaultAdapter();
            $db -> beginTransaction();

            try {
                $module = Engine_Api::_() -> getItem('ynresponsivepurity_module', $id);
                $module -> delete();
                $db -> commit();
            } catch (Exception $e) {
                $db -> rollBack();
                throw $e;
            }

            $this -> _forward('success', 'utility', 'core', array('smoothboxClose' => 10, 'parentRefresh' => 10, 'messages' => array('')));
        }
        // Output
        $this -> renderScript('admin-manage-module/delete.tpl');
    }

    public function createAction() {
        // In smoothbox
        $this -> _helper -> layout -> setLayout('admin-simple');
        if (!$this -> _helper -> requireUser -> isValid())
            return;
        // Create form
        $this -> view -> form = $form = new Ynresponsivepurity_Form_Admin_Module_Create();
        // Not post/invalid
        if (!$this -> getRequest() -> isPost()) {
            return;
        }

        if (!$form -> isValid($this -> getRequest() -> getPost())) {
            return;
        }
        $values = $form -> getValues();
		$table = Engine_Api::_() -> getDbtable('modules', 'ynresponsivepurity');
        $db = $table -> getAdapter();
        $db -> beginTransaction();

        try {
            // Create event
            $module = $table -> createRow();
            $module -> setFromArray($values);
            $module -> save();

            if (!empty($values['photo'])) {
                $module -> setIcon($form -> photo);
            }
            if (!empty($values['hover_photo'])) {
                $module -> setHoverIcon($form -> hover_photo);
            }

            // Commit
            $db -> commit();

            $this -> _forward('success', 'utility', 'core', array('smoothboxClose' => 10, 'parentRefresh' => 10, 'messages' => array(Zend_Registry::get('Zend_Translate') -> _('The module item was added successfully.'))));
        } catch( Engine_Image_Exception $e ) {
            $db -> rollBack();
            $form -> addError(Zend_Registry::get('Zend_Translate') -> _('The image you selected was too large.'));
        } catch( Exception $e ) {
            $db -> rollBack();
            throw $e;
        }
    }

    public function editAction() {
        // In smoothbox
        $this -> _helper -> layout -> setLayout('admin-simple');
        $module_id = $this -> getRequest() -> getParam('id');
        $module = Engine_Api::_() -> getItem('ynresponsivepurity_module', $module_id);
        // Create form
        $this -> view -> form = $form = new Ynresponsivepurity_Form_Admin_Module_Edit();
        if (!$this -> getRequest() -> isPost()) {
            $form -> populate($module -> toArray());
			$this -> renderScript('admin-manage-module/create.tpl');
            return;
        }

        if (!$form -> isValid($this -> getRequest() -> getPost())) {
        	$this -> renderScript('admin-manage-module/create.tpl');
            return;
        }

        // Process
        $values = $form -> getValues();

        // Process
        $db = Engine_Api::_() -> getItemTable('ynresponsivepurity_module') -> getAdapter();
        $db -> beginTransaction();

        try {
            if (!empty($values['photo'])) {
                $module -> setIcon($form -> photo);
            }
            if (!empty($values['hover_photo'])) {
                $module -> setHoverIcon($form -> hover_photo);
            }
            $module -> setFromArray($values);
            $module -> save();
            // Commit
            $db -> commit();
        } catch( Engine_Image_Exception $e ) {
            $db -> rollBack();
            $form -> addError(Zend_Registry::get('Zend_Translate') -> _('The photo you selected was too large.'));
        } catch( Exception $e ) {
            $db -> rollBack();
            throw $e;
        }
        $this -> _forward('success', 'utility', 'core', array('smoothboxClose' => 10, 'parentRefresh' => 10, 'messages' => array(Zend_Registry::get('Zend_Translate') -> _('The module item was edited successfully.'))));
   		$this -> renderScript('admin-manage-module/create.tpl');
    }
    public function sortAction() {
        $table = Engine_Api::_() -> getDbtable('modules', 'ynresponsivepurity');
        $modules = $table -> getModulePaginator();
        $modules -> setItemCountPerPage(100);
        $order = explode(',', $this -> getRequest() -> getParam('order'));
        foreach ($order as $i => $item) {
            $module_id = substr($item, strrpos($item, '_') + 1);
            foreach ($modules as $module) {
                if ($module -> getIdentity() == $module_id) {
                    $module -> order = $i;
                    $module -> save();
                }
            }
        }
    }

}
