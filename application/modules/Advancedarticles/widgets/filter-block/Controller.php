<?php

class Advancedarticles_Widget_FilterBlockController extends Engine_Content_Widget_Abstract
{
  public function indexAction() 
  {
    $form_array = Engine_Api::_()->advancedarticles()->getFilterValue();
    
    $this->view->form = $form_array['form'];
    $this->view->formValues = $form_array['values'];
  }
}  