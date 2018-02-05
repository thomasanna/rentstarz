<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: index.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     John
 */
?>

<?php echo $this->fieldValueLoop($this->subject(), $this->fieldStructure) ?>

<?php  $subject = Engine_Api::_()->core()->getSubject(); 

$fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($subject); 
    if( !empty($fieldsByAlias['profile_type']) )
    {
      $optionId = $fieldsByAlias['profile_type']->getValue($subject);
      $this->view->profiletype = $profile_type_id = $optionId->value; 
      $subjectProfileType = $profile_type_id;
    }







?>
<script>
var member_creation_date = '<?php echo  $this->timestamp($subject->creation_date);?>';
var subjectProfileType = '<?php echo $subjectProfileType ; ?>';

if(subjectProfileType == 1){

 jQuery('.layout_user_profile_fields .profile_fields:nth-child(2) ul'). append('<li><span>Member Since</span><span class="info_data"> '+member_creation_date+' </span></li>');

}
else{
	
 jQuery('.layout_user_profile_fields .profile_fields').append('<div class="profile_fields"><h4><span>Personal Details</span></h4><ul><li><span>Member Since</span><span class="info_data"> '+member_creation_date+' </span></li></ul></div>');

}
</script>
