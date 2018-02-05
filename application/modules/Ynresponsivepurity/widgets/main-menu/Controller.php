<?php

class Ynresponsivepurity_Widget_MainMenuController extends Engine_Content_Widget_Abstract
{
    public function indexAction()
    {
        if (substr(YNRESPONSIVE_ACTIVE, 0, 18) != 'ynresponsivepurity') {
            return $this->setNoRender(true);
        }

        $this->view->navigationMain = $navigation = Engine_Api::_()
            ->getApi('menus', 'core')
            ->getNavigation('core_main');

        $this -> view -> limit = $this -> _getParam('limit', 12);

        $this->view->viewer = $viewer = Engine_Api::_()->user()->getViewer();
        $require_check = Engine_Api::_()->getApi('settings', 'core')->getSetting('core.general.browse', 1);

        if (!$require_check && !$viewer->getIdentity()) {
            $navigation->removePage($navigation->findOneBy('route', 'user_general'));
        }

        //Search
        $require_check = Engine_Api::_() -> getApi('settings', 'core') -> core_general_search;
        if (!$require_check)
        {
            if ($viewer -> getIdentity())
            {
                $this -> view -> search_check = true;
            }
            else
            {
                $this -> view -> search_check = false;
            }
        }
        else
            $this -> view -> search_check = true;
    }

    public function getCacheKey()
    {
    }
}