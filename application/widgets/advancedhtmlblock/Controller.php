<?php

class Widget_AdvancedhtmlblockController extends Engine_Content_Widget_Abstract
{
    public function indexAction()
    {
    	require_once 'Mobile_Detect.php';
		$detect = new Mobile_Detect;
		
		$this->view->isTablet = 0;
		// Any tablet device.
		if($detect->isTablet()){			
			$this->view->isTablet = 1;
		}
		$this->view->isMobile = 0;
		// Any mobile device 
		if($detect->isMobile() && !$detect->isTablet()){
			$this->view->isMobile = 1;
		}
        // check data then get the correct locale.
        $locale = $this -> view -> locale() -> getLocale();

		//get body of desktop
        $name = 'body_' . $locale;
        $body = $this -> _getParam($name, '');
        
        if ($body == '')
        {
            $body = $this -> _getParam('body', '');
        }
		//get body of tablet
        $tablet = 'tablet_' . $locale;
        $tablet = $this -> _getParam($tablet, '');
        
        if ($tablet == '')
        {
            $tablet = $this -> _getParam('tablet', '');
        }
		
		//get body of tablet
        $mobile = 'mobile_' . $locale;
        $mobile = $this -> _getParam($mobile, '');
        
        if ($mobile == '')
        {
            $mobile = $this -> _getParam('mobile', '');
        }

        $name = 'title_' . $locale;
        $title = $this -> _getParam($name, '');

        if ($title =='')
        {
            $title = $this -> _getParam('title0', '');
        }		
		
		//Add custom work
		$viewer = Engine_Api::_()->user()->getViewer();
		$can_view= true;
		if(!$viewer -> getIdentity())
		{
			$can_view = $this -> _getParam('level_5', 1);
		}
		else {
			$can_view = $this -> _getParam('level_'.$viewer -> level_id, 1);
		}
		
		if(!$can_view)
		{
			$this -> setNoRender();
		}
		//end custom work
		
        $this -> view -> title_data = htmlspecialchars_decode(trim($title));
        $this -> view -> body_data = htmlspecialchars_decode($body);
		$this -> view -> tablet_data = htmlspecialchars_decode($tablet);
		$this -> view -> mobile_data = htmlspecialchars_decode($mobile);
    }

}
