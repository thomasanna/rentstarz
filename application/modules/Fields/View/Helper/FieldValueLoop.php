<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Fields
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: FieldValueLoop.php 10103 2013-10-25 14:33:33Z ivan $
 * @author     John
 */

/**
 * @category   Application_Core
 * @package    Fields
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @author     John
 */
class Fields_View_Helper_FieldValueLoop extends Fields_View_Helper_FieldAbstract
{
  public function fieldValueLoop($subject, $partialStructure,$stat)
  {
    if( empty($partialStructure) ) {
      return '';
    }

    $viewer = Engine_Api::_()->user()->getViewer();
    if( !($subject instanceof Core_Model_Item_Abstract) || !$subject->getIdentity() ) {
      return '';
    }
    
    // Calculate viewer-subject relationship
    $usePrivacy = ($subject instanceof User_Model_User);
    if( $usePrivacy ) {
      $relationship = 'everyone';
      if( $viewer && $viewer->getIdentity() ) {
        if( $viewer->getIdentity() == $subject->getIdentity() ) {
          $relationship = 'self';
        } else if( $viewer->membership()->isMember($subject, true) ) {
          $relationship = 'friends';
        } else {
          $relationship = 'registered';
        }
      }
    }
    
    // Generate
    $content = '';
    $lastContents = '';
    $lastHeadingTitle = null; //Zend_Registry::get('Zend_Translate')->_("Missing heading");
    $show_hidden = $viewer->getIdentity()
                 ? ($subject->getOwner()->isSelf($viewer) || 'admin' === Engine_Api::_()->getItem('authorization_level', $viewer->level_id)->type)
                 : false;

    foreach( $partialStructure as $map ) {

      // Get field meta object
      $field = $map->getChild();
      $value = $field->getValue($subject);
      if( !$field || $field->type == 'profile_type' ) continue;
      if( !$field->display && !$show_hidden ) continue;
      $isHidden = !$field->display;
      
      // Get first value object for reference
      $firstValue = $value;
      if( is_array($value) && !empty($value) ) {
        $firstValue = $value[0];
      }
      
      // Evaluate privacy
      if( $usePrivacy && !empty($firstValue->privacy) && $relationship != 'self' ) {
        if( $firstValue->privacy == 'self' && $relationship != 'self' ) {
          $isHidden = true; //continue;
        } else if( $firstValue->privacy == 'friends' && ($relationship != 'friends' && $relationship != 'self') ) {
          $isHidden = true; //continue;
        } else if( $firstValue->privacy == 'registered' && $relationship == 'everyone' ) {
          $isHidden = true; //continue;
        }
      }
      
      // Render
      if( $field->type == 'heading' ) {
        // Heading
        if( !empty($lastContents) ) {
			if($stat ==1){
				$content .= $this->_buildLastContentsAdmin($lastContents, $lastHeadingTitle);
			}
			else{
          $content .= $this->_buildLastContents($lastContents, $lastHeadingTitle);
	  }
          $lastContents = '';
        }
        $lastHeadingTitle = $this->view->translate($field->label);
      } else {
        // Normal fields
        
        if($field->field_id == 16){
			
			if($subject -> creditscore_view_status == 0){
			break; }
		}
        $tmp = $this->getFieldValueString($field, $value, $subject, $map, $partialStructure);
        if( !empty($firstValue->value) && !empty($tmp) ) {

          $notice = $isHidden && $show_hidden
                  ? sprintf('<div class="tip"><span>%s</span></div>',
                      $this->view->translate('This field is hidden and only visible to you and admins:'))
                  : '';
          if( !$isHidden || $show_hidden ) {
			  
			if($field->field_id == 13){
				 
				 $bio = $tmp;
			} 
			  
			if($field->field_id == 33 || $field->field_id == 53|| $field->field_id == 75){
				
				 $country_table   =  Engine_Api::_()->getDbtable('countries', 'user');
		         $country_list = $country_table->fetchRow($country_table->select()->where('id = ?', $tmp));
		         $tmp= $country_list['country'];
				
			}  
			if($field->field_id == 30 || $field->field_id == 54|| $field->field_id == 76){
				
				$state_table   =  Engine_Api::_()->getDbtable('state', 'user');
	            $state_list = $state_table->fetchRow($state_table->select()->where('state_id = ?', $tmp));
		        $tmp= $state_list['state'];
				
			}  
			if($field->field_id == 31 || $field->field_id == 55|| $field->field_id == 77){
				
				$city_table   =  Engine_Api::_()->getDbtable('city', 'user');
	            $city_list = $city_table->fetchRow($city_table->select()->where('city_id = ?', $tmp));
		        $tmp= $city_list['city'];
				
			}
			if($field->field_id == 66){
				
				$coverletter_table =  Engine_Api::_()->getDbtable('coverletter', 'user');
				$cover_list = $coverletter_table->fetchRow($coverletter_table->select()->where('id = ?', $tmp));
				$tmp= $cover_list['content'];
			}  
            $label = $this->view->translate($field->label);
            if($stat ==1){
				$lastContents .= <<<EOF
  <li data-field-id={$field->field_id} style="margin-bottom: 12px;">
    {$notice}
    <span class="qwerty" style="float: left;
width: 49%;
font-weight: 500;
text-align: left;
margin-right: 10px;
margin-bottom: 15px;">
      {$label}
    </span><span class="sep" style="float: left;margin-bottom: 15px;"> : </span>
    <span class="xyz" style="width: 40%;
float: left;
margin-left: 4px;margin-bottom: 15px;">
      {$tmp}
    </span>
  </li>
EOF;
				
			}
			else{
				
	if($field->field_id != 13 && $field->field_id != 74){		// if not bio	& not birthday of landlord
            $lastContents .= <<<EOF
  <li class="jjj" data-field-id={$field->field_id}>
    {$notice}
    <span>
      {$label}
    </span>
    <span class="info_data">
      {$tmp}
    </span>
  </li>
 
EOF;
 }
 
}
          }
        }
      }
      
    }
    
    

    if( !empty($lastContents) ) {
	if($stat ==1){
      $content .= $this->_buildLastContentsAdmin($lastContents, $lastHeadingTitle);
    }else{
      $content .= $this->_buildLastContents($lastContents, $lastHeadingTitle);}
    }
   if($bio !=''){
    
    $content .='<div class="bio_info"><b>Bio</b>  :'.$bio.'</div>';
    }
    return $content;
  }

  public function getFieldValueString($field, $value, $subject, $map = null,
      $partialStructure = null)
  {
    if( (!is_object($value) || !isset($value->value)) && !is_array($value) ) {
      return null;
    }
    
    // @todo This is not good practice:
    // if($field->type =='textarea'||$field->type=='about_me') $value->value = nl2br($value->value);

    $helperName = Engine_Api::_()->fields()->getFieldInfo($field->type, 'helper');
    if( !$helperName ) {
      return null;
    }

    $helper = $this->view->getHelper($helperName);
    if( !$helper ) {
      return null;
    }

    $helper->structure = $partialStructure;
    $helper->map = $map;
    $helper->field = $field;
    $helper->subject = $subject;
    $tmp = $helper->$helperName($subject, $field, $value);
    unset($helper->structure);
    unset($helper->map);
    unset($helper->field);
    unset($helper->subject);
    
    return $tmp;
  }

  protected function _buildLastContents($content, $title)
  {
    if( !$title ) {
      return '<ul>' . $content . '</ul>';
    }
    return <<<EOF
        <div class="profile_fields">
          <h4>
            <span>{$title}</span>
          </h4>
          <ul>
            {$content}
          </ul>
        </div>
EOF;
  }
  protected function _buildLastContentsAdmin($content, $title)
  {
    if( !$title ) {
      return '<ul>' . $content . '</ul>';
    }
    return <<<EOF
        <div class="profile_fields" style="margin-top: 12px;clear: both;">
          <h4>
            <span>{$title}</span>
          </h4>
          <ul style="list-style-type: none;">
            {$content}
          </ul>
        </div>
EOF;
  }
}
