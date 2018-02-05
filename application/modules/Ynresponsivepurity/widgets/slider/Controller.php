<?php

class Ynresponsivepurity_Widget_SliderController extends Engine_Content_Widget_Abstract
{
    public function indexAction()
    {
        if (substr(YNRESPONSIVE_ACTIVE, 0, 18) != 'ynresponsivepurity') {
            return $this->setNoRender(true);
        }

        $this -> view -> background_image = $this -> _getParam('background_image', '');
        $this -> view -> show_title = $this -> _getParam('show_title', 1);
        $this -> view -> show_description = $this -> _getParam('show_description', 1);

        $this->view->sliders = $paginator = Engine_Api::_() -> getDbTable('sliders', 'ynresponsivepurity') -> getSliderPaginator();
        $paginator -> setItemCountPerPage(5);
    }

    public function getCacheKey()
    {
    }
}
