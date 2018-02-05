<?php
/**
 * SocialEngine
 *
 * @category   Application_Extensions
 * @package    Group
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: Topics.php 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */

/**
 * @category   Application_Extensions
 * @package    Group
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Group_Model_DbTable_Topics extends Engine_Db_Table
{
  protected $_rowClass = 'Group_Model_Topic';
  
  public function getChildrenSelectOfGroup($group, $params)
  {
    $select = $this->select()->where('group_id = ?', $group->group_id);
    return $select;
  }
}