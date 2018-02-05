<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Video
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Video.php 10223 2014-05-15 17:02:17Z andres $
 * @author     Jung
 */

/**
 * @category   Application_Extensions
 * @package    Video
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Video_Model_Video extends Core_Model_Item_Abstract
{
  protected $_parent_type = 'user';

  protected $_owner_type = 'user';

  protected $_parent_is_owner = true;

  public function getHref($params = array())
  {
    $params = array_merge(array(
      'route' => 'video_view',
      'reset' => true,
      'user_id' => $this->owner_id,
      'video_id' => $this->video_id,
      'slug' => $this->getSlug(),
    ), $params);
    $route = $params['route'];
    $reset = $params['reset'];
    unset($params['route']);
    unset($params['reset']);
    return Zend_Controller_Front::getInstance()->getRouter()
      ->assemble($params, $route, $reset);
  }

  public function getRichContent($view = false, $params = array())
  {
    $session = new Zend_Session_Namespace('mobile');
    $mobile = $session->mobile;

    // if video type is youtube
    if ($this->type == 1){
      $videoEmbedded = $this->compileYouTube($this->video_id, $this->code, $view, $mobile);
    }
    // if video type is vimeo
    if ($this->type == 2){
      $videoEmbedded = $this->compileVimeo($this->video_id, $this->code, $view, $mobile);
    }

    // if video type is uploaded
    if ($this->type ==3) {
      $storage_file = Engine_Api::_()->storage()->get($this->file_id, $this->getType());
      $video_location = $storage_file->getHref();
      if ($storage_file->extension === 'flv') {
        $videoEmbedded = $this->compileFlowPlayer($video_location, $view);
      } else {
        $videoEmbedded = $this->compileHTML5Media($video_location, $view);
      }
    }

    // $view == false means that this rich content is requested from the activity feed
    if($view==false){

      // prepare the duration
      //
      $video_duration = "";
      if( $this->duration ) {
        if( $this->duration >= 3600 ) {
          $duration = gmdate("H:i:s", $this->duration);
        } else {
          $duration = gmdate("i:s", $this->duration);
        }
        $duration = ltrim($duration, '0:');

        $video_duration = "<span class='video_length'>".$duration."</span>";
      }

      // prepare the thumbnail
      $thumb = Zend_Registry::get('Zend_View')->itemPhoto($this, 'thumb.video.activity');

      if( $this->photo_id ) {
        $thumb = Zend_Registry::get('Zend_View')->itemPhoto($this, 'thumb.video.activity');
      } else {
        $thumb = '<img alt="" src="' . Zend_Registry::get('StaticBaseUrl') . 'application/modules/Video/externals/images/video.png">';
      }

      if( !$mobile ){
        $thumb = '<a id="video_thumb_'.$this->video_id.'" style="" href="javascript:void(0);" onclick="javascript:var myElement = $(this);myElement.style.display=\'none\';var next = myElement.getNext(); next.style.display=\'block\';">
                  <div class="video_thumb_wrapper">'.$video_duration.$thumb.'</div>
                  </a>';
      } else {
        $thumb = '<a id="video_thumb_'.$this->video_id.'" class="video_thumb" href="' . $this->getHref() . '">
                  <div class="video_thumb_wrapper">'.$video_duration.$thumb.'</div>
                  </a>';
      }

      // prepare title and description
      $title = "<a href='".$this->getHref($params)."'>$this->title</a>";
      $tmpBody = strip_tags($this->description);
      $description = "<div class='video_desc'>".(Engine_String::strlen($tmpBody) > 255 ? Engine_String::substr($tmpBody, 0, 255) . '...' : $tmpBody)."</div>";

      $videoEmbedded = $thumb.'<div id="video_object_'.$this->video_id.'" class="video_object">'.$videoEmbedded.'</div><div class="video_info">'.$title.$description.'</div>';
 
    }

    return $videoEmbedded;
  }

  public function getEmbedCode(array $options = null)
  {
    $options = array_merge(array(
      'height' => '525',
      'width' => '525',
    ), (array) $options);
    
    $view = Zend_Registry::get('Zend_View');
    $url = 'http://' . $_SERVER['HTTP_HOST']
      . Zend_Controller_Front::getInstance()->getRouter()->assemble(array(
        'module' => 'video',
        'controller' => 'video',
        'action' => 'external',
        'video_id' => $this->getIdentity(),
      ), 'default', true) . '?format=frame';
    return '<iframe '
      . 'src="' . $view->escape($url) . '" '
      . 'width="' . sprintf("%d", $options['width']) . '" '
      . 'height="' . sprintf("%d", $options['width']) . '" '
      . 'style="overflow:hidden;"'
      . '>'
      . '</iframe>';
  }

  public function compileYouTube($video_id, $code, $view, $mobile = false)
  {
    $autoplay = !$mobile && $view;

    $embedded = '
    <iframe
    title="YouTube video player"
    id="videoFrame'.$video_id.'"
    class="youtube_iframe'.($view?"_big":"_small").'"'.
    'src="//www.youtube.com/embed/'.$code.'?wmode=opaque'.($autoplay?"&autoplay=1":"").'"
    frameborder="0"
    allowfullscreen=""
    scrolling="no">
    </iframe>
    <script type="text/javascript">
        en4.core.runonce.add(function() {
        var doResize = function() {
            var aspect = 16 / 9;
            var el = document.id("videoFrame'.$video_id.'");
            var parent = el.getParent();
            var parentSize = parent.getSize();
            el.set("width", parentSize.x);
            el.set("height", parentSize.x / aspect);
        }
        window.addEvent("resize", doResize);
        doResize();
        });
    </script>
    ';

    return $embedded;
  }

  public function compileVimeo($video_id, $code, $view, $mobile = false)
  {
      $autoplay = !$mobile && $view;

      $embedded = '
        <iframe
        title="Vimeo video player"
        id="videoFrame'.$video_id.'"
        class="vimeo_iframe'.($view?"_big":"_small").'"'.
        ' src="//player.vimeo.com/video/'.$code.'?title=0&amp;byline=0&amp;portrait=0&amp;wmode=opaque'.($autoplay?"&amp;autoplay=1":"").'"
        frameborder="0"
        allowfullscreen=""
        scrolling="no">
        </iframe>
        <script type="text/javascript">
          en4.core.runonce.add(function() {
            var doResize = function() {
              var aspect = 16 / 9;
              var el = document.id("videoFrame'.$video_id.'");
              var parent = el.getParent();
              var parentSize = parent.getSize();
              el.set("width", parentSize.x);
              el.set("height", parentSize.x / aspect);
            }
            window.addEvent("resize", doResize);
            doResize();
          });
        </script>
        ';

    return $embedded;
  }

  public function compileFlowPlayer($location, $view)
  {
    $embedded = "
    <div id='videoFrame".$this->video_id."'></div>
    <script type='text/javascript'>
    en4.core.runonce.add(function(){\$('video_thumb_".$this->video_id."').removeEvents('click').addEvent('click', function(){flashembed('videoFrame$this->video_id',{src: '".Zend_Registry::get('StaticBaseUrl')."externals/flowplayer/flowplayer-3.1.5.swf', width: ".($view?"480":"420").", height: ".($view?"386":"326").", wmode: 'opaque'},{config: {clip: {url: '$location',autoPlay: ".($view?"false":"true").", duration: '$this->duration', autoBuffering: true},plugins: {controls: {background: '#000000',bufferColor: '#333333',progressColor: '#444444',buttonColor: '#444444',buttonOverColor: '#666666'}},canvas: {backgroundColor:'#000000'}}});})});
    </script>";

    return $embedded;
  }

  public function compileHTML5Media($location, $view)
  {
    $embedded = "
    <video id='video".$this->video_id."' controls preload='auto' width='".($view?"480":"420")."' height='".($view?"386":"326")."'>
      <source type='video/mp4;' src=".$location.">
    </video>";
    return $embedded;
  }

  public function getKeywords($separator = ' ')
  {
    $keywords = array();
    foreach( $this->tags()->getTagMaps() as $tagmap ) {
      $tag = $tagmap->getTag();
      $keywords[] = $tag->getTitle();
    }

    if( null === $separator ) {
      return $keywords;
    }

    return join($separator, $keywords);
  }

  // Interfaces

  /**
   * Gets a proxy object for the comment handler
   *
   * @return Engine_ProxyObject
   **/
  public function comments()
  {
    return new Engine_ProxyObject($this, Engine_Api::_()->getDbtable('comments', 'core'));
  }

  /**
   * Gets a proxy object for the like handler
   *
   * @return Engine_ProxyObject
   **/
  public function likes()
  {
    return new Engine_ProxyObject($this, Engine_Api::_()->getDbtable('likes', 'core'));
  }

  /**
   * Gets a proxy object for the tags handler
   *
   * @return Engine_ProxyObject
   **/
  public function tags()
  {
    return new Engine_ProxyObject($this, Engine_Api::_()->getDbtable('tags', 'core'));
  }
}
