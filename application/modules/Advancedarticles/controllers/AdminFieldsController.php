<?php
class Advancedarticles_AdminFieldsController extends Fields_Controller_AdminAbstract
{
  protected $_fieldType = 'artarticle';

  public function indexAction() 
  {
	$this->view->PluginTitle = Zend_Registry::get('Zend_Translate')->_('Advanced Articles');
	$this->view->PluginDiscr = Zend_Registry::get('Zend_Translate')->_('ADVANCED_ARTICLES_DESCRIPTION');      

    $this->view->navigation = $navigation = Engine_Api::_()->getApi('menus', 'core')
      ->getNavigation('advancedarticles_admin_main', array(), 'advancedarticles_admin_main_questions');
    parent::indexAction();
  }

  public function fieldCreateAction()
  {
    parent::fieldCreateAction();
    $this->getArticleElement($this->view->form, 'Add Article Question');
  }
    
  public function fieldEditAction()
  {
    parent::fieldEditAction();
    $this->getArticleElement($this->view->form, 'Edit Article Question');
  }  
  
  public function optionCreateAction()
  {
    parent::optionCreateAction();
  }
  
  public function getArticleElement($form, $title = null)
  {  
    if (!$form) return;
    
    $show = $form->getElement('show');
    $show->setLabel('');
    $show->setOptions(array('style' => 'visibility:hidden'));
    
    $search = $form->getElement('search');
    $search->setLabel('Show on the Search Options?');
    $search->options = array(
      0 => 'Hide on the Search Options',
      1 => 'Show on the Search Options'
    );
    
    $display = $form->getElement('display');
    $display->setLabel('Show on Article Page?');
    $display->options = array(
      0 => 'Hide on Article Page',
      1 => 'Show on Article Page'
    );
    
    if ($title)
      $form->setTitle($title);
  }  
  
}