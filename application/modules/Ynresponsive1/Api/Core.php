<?php
class Ynresponsive1_Api_Core extends Core_Api_Abstract {

    protected $_isMobile = null;
    function isMobile() {
        if (null === $this -> _isMobile) {
            if (isset($_SERVER['HTTP_USER_AGENT'])) {
                $user_agent = $_SERVER['HTTP_USER_AGENT'];
                if (preg_match('/(android|iphone|ipad|mini 9.5|vx1000|lge |m800|e860|u940|ux840|compal|wireless| mobi|ahong|lg380|lgku|lgu900|lg210|lg47|lg920|lg840|lg370|sam-r|mg50|s55|g83|t66|vx400|mk99|d615|d763|el370|sl900|mp500|samu3|samu4|vx10|xda_|samu5|samu6|samu7|samu9|a615|b832|m881|s920|n210|s700|c-810|_h797|mob-x|sk16d|848b|mowser|s580|r800|471x|v120|rim8|c500foma:|160x|x160|480x|x640|t503|w839|i250|sprint|w398samr810|m5252|c7100|mt126|x225|s5330|s820|htil-g1|fly v71|s302|-x113|novarra|k610i|-three|8325rc|8352rc|sanyo|vx54|c888|nx250|n120|mtk |c5588|s710|t880|c5005|i;458x|p404i|s210|c5100|teleca|s940|c500|s590|foma|samsu|vx8|vx9|a1000|_mms|myx|a700|gu1100|bc831|e300|ems100|me701|me702m-three|sd588|s800|8325rc|ac831|mw200|brew |d88|htc\/|htc_touch|355x|m50|km100|d736|p-9521|telco|sl74|ktouch|m4u\/|me702|8325rc|kddi|phone|lg |sonyericsson|samsung|240x|x320vx10|nokia|sony cmd|motorola|up.browser|up.link|mmp|symbian|smartphone|midp|wap|vodafone|o2|pocket|kindle|mobile|psp|treo)/i', $user_agent)) {
                    $this -> _isMobile = true;
                }

            } else {
                $this -> _isMobile = false;
            }
        }
        return $this -> _isMobile;
    }

    public function getGroupTimeAgo($group) {
        $view = Zend_Registry::get("Zend_View");
        $now = time();
        $timeAgo = "Active ";
        $date = strtotime($group -> creation_date);
        $years = date('Y', $now) - date("Y", $date);
        $months = date('n', $now) - date("n", $date);
        $days = date('j', $now) - date("j", $date);
        if ($months < 0) {
            $months = 12 + $months;
            $years = $years - 1;
        }
        if ($days < 0) {
            $days = 30 + $days;
            $months = $months - 1;
        }
        if ($years) {
            $timeAgo .= $view -> translate(array("%s year ago", "%s years ago", $years), $years);
            return $timeAgo;
        } else if ($months) {
            $timeAgo .= $view -> translate(array("%s month ago", "%s months ago", $months), $months);
            return $timeAgo;
        } else if ($days) {
            $timeAgo .= $view -> translate(array("%s day ago", "%s days ago", $days), $days);
            return $timeAgo;
        } else
            return $view -> translate("Active today");
    }
	/**
     * @return Array/ Rowset of $type
     */
    function getSliderContent($type, $params = null) {
        $method = '_getSlideContent_' . $type;
        if (method_exists($this, $method)) {
            return $this -> {$method}($params);
        }
        return null;
    }

    function _getSupportedSliderContent() {
        $engine_api = Engine_Api::_();

        $return = array();

        if ($engine_api -> hasItemType('event')) {
            $return['ynresponsive1_latest_events'] = 'Latest Events';
            $return['ynresponsive1_viewed_events'] = 'Most Viewed Events';
        }

        if ($engine_api -> hasItemType('blog')) {
            $return['ynresponsive1_recent_blogs'] = 'Recent Blogs';
            $return['ynresponsive1_viewed_blogs'] = 'Most Viewed Blogs';
        }

        if ($engine_api -> hasModuleBootstrap('album')) {
            $return['ynresponsive1_latest_photos'] = 'Recent Photos';
            $return['ynresponsive1_viewed_photos'] = 'Most Viewed Photos';
        }

        return $return;
    }

    function getAllSupportedSliderContent() {
        $modules = Engine_Api::_() -> getDbTable('modules', 'core') -> getEnabledModuleNames();

        $all = $this -> _getSupportedSliderContent();

        foreach ($modules as $module) {
            $m = str_replace("-", " ", $module);
            $m = ucwords($m);
            $m = str_replace(" ", "", $m);
            $class_name = $m . '_' . ucfirst($type = 'api') . '_' . ucfirst($resource = 'core');

            if (class_exists($class_name)) {
                $api = new $class_name();

                if (method_exists($api, 'getSupportedSliderContent')) {
                    $all = array_merge($all, $api -> getSupportedSliderContent());
                }
            }
        }
        return $all;
    }

    /********** support default plugins *********/
    /**
     * get latest events
     * @type Event
     */
    function _getSlideContent_latest_events($params) {
        return $this -> _getContentItems_event('latest', $params);
    }

    /**
     * get most viewed events
     * @type Event
     */
    function _getSlideContent_viewed_events($params) {
        return $this -> _getContentItems_event('view', $params);
    }

    /**
     * @param string $sort_order
     * @type Event
     * @return Array
     */
    function _getContentItems_event($sort_order, $params) {
        $table_events = Engine_Api::_() -> getItemTable('event');
        ;
        if ($table_events) {
            $name = $table_events -> info('name');
            switch($sort_order) {
                case 'latest' :
                    $params['order'] = "$name.creation_date";
                    break;
                case 'view' :
                    $params['order'] = "$name.view_count";
                    break;
                    break;
            }

            $params['search_text'] = '';
            $select = $table_events -> getEventSelect($params);
            $select -> where("$name.photo_id > 0");
            if (isset($params['itemCountPerPage']) && $params['itemCountPerPage']) {
                $select -> limit($params['itemCountPerPage']);
            }
            return $table_events -> fetchAll($select);
        } else
            return null;
    }

    /****** ---------- *******/
    /**
     * get recent blogs
     * @type Blog
     */
    function _getSlideContent_recent_blogs($params) {
        return $this -> _getContentItems_blog('recent', $params);
    }

    /**
     * get viewed blogs
     * @type Blog
     */
    function _getSlideContent_viewed_blogs($params) {
        return $this -> _getContentItems_blog('view', $params);
    }

    /**
     * @param string $sort_order
     * @type Blog
     * @return Array
     */
    function _getContentItems_blog($sort_order, $params) {
        $table_blogs = null;
        if (Engine_Api::_() -> hasModuleBootstrap('blog')) {
            $table_blogs = Engine_Api::_() -> getDbTable('blogs', 'blog');
        } else {
            $table_blogs = Engine_Api::_() -> getDbTable('blogs', 'ynblog');
        }

        if ($table_blogs) {
            $select = $table_blogs -> select();
            $name = $table_blogs -> info('name');
            switch($sort_order) {
                case 'recent' :
                    $select -> order("$name.creation_date DESC");
                    break;
                case 'view' :
                    $select -> order("$name.view_count DESC");
                    break;
            }
            if (isset($params['itemCountPerPage']) && $params['itemCountPerPage']) {
                $select -> limit($params['itemCountPerPage']);
            }
            return $table_blogs -> fetchAll($select);
        } else
            return null;
    }

    /**
     * get latest photos
     * @type Photo
     */
    function _getSlideContent_latest_photos($params) {
        return $this -> _getContentItems_photo('latest', $params);
    }

    /**
     * get most viewed photos
     * @type Photo
     */
    function _getSlideContent_viewed_photos($params) {
        return $this -> _getContentItems_photo('view', $params);
    }

    /**
     * @param string $sort_order
     * @type Photo
     * @return Array
     */
    function _getContentItems_photo($sort_order, $params) {
        $table_photos = Engine_Api::_() -> getDbTable('photos', 'album');
        ;
        if ($table_photos) {
            $name = $table_photos -> info('name');
            switch($sort_order) {
                case 'latest' :
                    $params['order'] = "$name.creation_date DESC";
                    break;
                case 'view' :
                    $params['order'] = "$name.view_count DESC";
                    break;
                    break;
            }

            $params['search_text'] = '';
            $select = $table_photos -> select();
			$select -> order($params['order']);
            if (isset($params['itemCountPerPage']) && $params['itemCountPerPage']) {
                $select -> limit($params['itemCountPerPage']);
            }
            return $table_photos -> fetchAll($select);
        } else
            return null;
    }
}
