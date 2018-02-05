<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Video
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Global.php 10213 2014-05-13 17:37:19Z andres $
 * @author     Jung
 */

/**
 * @category   Application_Extensions
 * @package    Video
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Video_Form_Admin_Global extends Engine_Form
{
  public function init()
  {
    $this
      ->setTitle('Global Settings')
      ->setDescription('These settings affect all members in your community.');

    $this->addElement('Text', 'video_ffmpeg_path', array(
      'label' => 'Path to FFMPEG',
      'description' => 'Please enter the full path to your FFMPEG installation. (Environment variables are not present)',
      'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('video.ffmpeg.path', ''),
    ));

    $this->addElement('Checkbox', 'video_html5', array(
      'description' => 'HTML5 Video Support',
      'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('video.html5', false),
    ));
    
    $description = 'While posting videos on your site, users can choose YouTube as a source. This requires a valid YouTube API key.<br>To learn how to create that key with correct permissions, read our <a href="http://support.socialengine.com/php/customer/portal/articles/2018371-create-your-youtube-api-key" target="_blank">KB Article</a>';

    $currentYouTubeApiKey = '******';
    if( !_ENGINE_ADMIN_NEUTER ) {
      $currentYouTubeApiKey = Engine_Api::_()->getApi('settings', 'core')->getSetting('video.youtube.apikey');
    }
    $this->addElement('Text', 'video_youtube_apikey', array(
      'label' => 'YouTube API Key',
      'description' => $description,
      'filters' => array(
        'StringTrim',
      ),
      'value' => $currentYouTubeApiKey,
    ));
    $this->video_youtube_apikey->getDecorator('Description')->setOption('escape', false);

    $this->addElement('Text', 'video_jobs', array(
      'label' => 'Encoding Jobs',
      'description' => 'How many jobs do you want to allow to run at the same time?',
      'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('video.jobs', 2),
    ));

    $this->addElement('Text', 'video_page', array(
      'label' => 'Listings Per Page',
      'description' => 'How many videos will be shown per page? (Enter a number between 1 and 999)',
      'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('video.page', 10),
    ));

    $this->addElement('Radio', 'video_embeds', array(
      'label' => 'Allow Embedding of Videos?',
      'description' => 'Enabling this option will give members the ability to '
          . 'embed videos on this site in other pages using an iframe (like YouTube).',
      'value' => Engine_Api::_()->getApi('settings', 'core')->getSetting('video.embeds', 1),
      'multiOptions' => array(
        '1' => 'Yes, allow embedding of videos.',
        '0' => 'No, do not allow embedding of videos.',
      ),
    ));
    
    // Add submit button
    $this->addElement('Button', 'submit', array(
      'label' => 'Save Changes',
      'type' => 'submit',
      'ignore' => true
    ));
  }
}