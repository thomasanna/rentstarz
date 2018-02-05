<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Video
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Composer.php 9747 2012-07-26 02:08:08Z john $
 * @author     Jung
 */

/**
 * @category   Application_Extensions
 * @package    Video
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Video_Plugin_Composer extends Core_Plugin_Abstract
{
  public function onAttachVideo($data)
  {
    if( !is_array($data) || empty($data['video_id']) ) {
      return;
    }

    $video = Engine_Api::_()->getItem('video', $data['video_id']);
    // update $video with new title and description
    $video->title = $data['title'];
    $video->description = $data['description'];

    // Set parents of the video
    if(Engine_Api::_()->core()->hasSubject()){
      $subject      = Engine_Api::_()->core()->getSubject();
      $subject_type = $subject->getType();
      $subject_id   = $subject->getIdentity();

      $video->parent_type = $subject_type;
      $video->parent_id = $subject_id;
    }
    $video->search = 1;
    $video->save();
    
    if( !($video instanceof Core_Model_Item_Abstract) || !$video->getIdentity() )
    {
      return;
    }

    return $video;
  }
}