<?php

class User_Widget_HeaderController extends Engine_Content_Widget_Abstract {

public function indexAction()  {
     $this->view->viewer = $viewer = Engine_Api::_()->user()->getViewer();

}
}

