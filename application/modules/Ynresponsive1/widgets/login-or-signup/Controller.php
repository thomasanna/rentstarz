<?php
class Ynresponsive1_Widget_LoginOrSignupController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
  	if(YNRESPONSIVE_ACTIVE != 'ynresponsive-metro' && YNRESPONSIVE_ACTIVE != 'ynresponsive-photo')
	{
		return $this -> setNoRender(true);
	}
  	$this-> view -> socialconnect_enable = Engine_Api::_() -> hasModuleBootstrap("social-connect");
    // Do not show if logged in
    if( Engine_Api::_()->user()->getViewer()->getIdentity() ) {
      $this->setNoRender();
      return;
    }
    
    // Display form
    $form = $this->view->form = new User_Form_Login();
    $form->setTitle(null)->setDescription(null);
    $form->return_url->setValue('64-' . base64_encode($_SERVER['REQUEST_URI']));
    $form->removeElement('forgot');

  }
  
  public function getCacheKey()
  {
    return false;
  }
}
