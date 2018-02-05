

<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    Activity
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: _activityText.tpl 10194 2014-05-01 17:41:40Z mfeineman $
 * @author     Jung
 */
?>

<?php

 $current_url = explode("?", $_SERVER['REQUEST_URI']);
 $page_url = $current_url[0] ;

$useragent=$_SERVER['HTTP_USER_AGENT'];

$iPod = stripos($_SERVER['HTTP_USER_AGENT'],"iPod");
$iPhone = stripos($_SERVER['HTTP_USER_AGENT'],"iPhone");
$iPad = stripos($_SERVER['HTTP_USER_AGENT'],"iPad");
$Android = stripos($_SERVER['HTTP_USER_AGENT'],"Android");
$webOS = stripos($_SERVER['HTTP_USER_AGENT'],"webOS");
$status = 'false';
$viewer_id=$this->viewer()->getIdentity();
//if(preg_match('/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino/i',$useragent)||preg_match('/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i',substr($useragent,0,4))){
if( $iPod || $iPhone || $iPad || $Android)  {
    $dev_type= 1; // mobile

}
else{

    $dev_type= 2; // system
}
// member type
$viewer = Engine_Api::_()->user()->getViewer();
date_default_timezone_set($viewer->timezone);
    $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
    if( !empty($fieldsByAlias['profile_type']) )
    {
      $optionId = $fieldsByAlias['profile_type']->getValue($viewer);
      $this->view->profiletype = $profile_type_id = $optionId->value;
      $viewerProfileType = $profile_type_id;
    }
    if( Engine_Api::_()->core()->hasSubject() ) {
      // Get subject
       $subject = Engine_Api::_()->core()->getSubject();
       $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($subject);
       if( !empty($fieldsByAlias['profile_type']) )
        {
          $optionId = $fieldsByAlias['profile_type']->getValue($subject);
          $subjectProfileType = $optionId->value;
        }


  }
?>



<?php if( empty($this->actions) ) {
  echo $this->translate("The action you are looking for does not exist.");
  return;
} else {
   $actions = $this->actions;
} ?>

<?php $this->headScript()
        ->appendFile($this->layout()->staticBaseUrl . 'application/modules/Activity/externals/scripts/core.js')
        ->appendFile($this->layout()->staticBaseUrl . 'externals/flowplayer/flowplayer-3.2.13.min.js')
        ->appendFile($this->layout()->staticBaseUrl . 'externals/html5media/html5media.min.js')?>

<script type="text/javascript">
  var CommentLikesTooltips;
//  en4.core.runonce.add(function() {
    // Add hover event to get likes
    jQuery('.comments_comment_likes').mouseover(function(event) {
      var el = $(event.target);
      if( !el.retrieve('tip-loaded', false) ) {
        el.store('tip-loaded', true);
       // el.store('tip:title', '<?php echo  $this->string()->escapeJavascript($this->translate('Loading...')) ?>');

        el.store('tip:text', '');
        var id = el.get('id').match(/\d+/)[0];
        // Load the likes
        var url = '<?php echo $this->url(array('module' => 'activity', 'controller' => 'index', 'action' => 'get-likes'), 'default', true) ?>';
        var req = new Request.JSON({
          url : url,
          data : {
            format : 'json',
            //type : 'core_comment',
            action_id : el.getParent('li').getParent('li').getParent('li').get('id').match(/\d+/)[0],
            comment_id : id
          },
          onComplete : function(responseJSON) {
            el.store('tip:title', responseJSON.body);
            el.store('tip:text', '');
            CommentLikesTooltips.elementEnter(event, el); // Force it to update the text
          }
        });
        req.send();
      }
    });
    // Add tooltips
   /* CommentLikesTooltips = new Tips(jQuery('.comments_comment_likes'), {
      fixed : true,
      className : 'comments_comment_likes_tips',
      offset : {
        'x' : 48,
        'y' : 16
      }
    });*/
    // Enable links in comments
   // jQuery('.comments_body').enableLinks();
 // });
</script>


<?php

if(empty(Engine_Api::_()->core()->hasSubject())){ //  home feed

    if($viewerProfileType == 4 ){  //check  landlord

        $checkhomefeedtype = 'landlordfeed';

    }
    elseif($viewerProfileType == 1 ){ //check  tenant

        $checkhomefeedtype = 'tenantfeed';
    }
    else{

        $checkhomefeedtype = 'servicefeed';
    }
}
else{

        $checkhomefeedtype = '';
}

if(Engine_Api::_()->core()->hasSubject()){  //  profile feed

    if($subjectProfileType ==4){ //check  landlord

        $checkprofilefeedtype = 'landlordfeed';
    }
    elseif($subjectProfileType == 1){  // tenant

        $checkprofilefeedtype = 'tenantfeed';
    }
    else{

        $checkprofilefeedtype = 'servicefeed';
    }
}
else{

        $checkprofilefeedtype = '';
}


?>

<?php if( !$this->getUpdate ): ?>

<div>
<ul class='feed' id="activity-feed">
<?php endif ?>

<?php



if($checkhomefeedtype == 'tenantfeed' || $checkprofilefeedtype =='landlordfeed'):
$licount =0;
  foreach( $actions as $action ): // (goes to the end of the file)
    try { // prevents a bad feed item from destroying the entire page
      // Moved to controller, but the items are kept in memory, so it shouldn't hurt to double-check
      if( !$action->getTypeInfo()->enabled ) continue;
      if( !$action->getSubject() || !$action->getSubject()->getIdentity() ) continue;
      if( !$action->getObject() || !$action->getObject()->getIdentity() ) continue;

      ob_start();

      $licount = $licount+1;



    ?>
  <?php if( !$this->noList ): ?><li  class="activity_item_li activity_item_li_<?php echo $licount?>" licount=<?php echo $licount;?> id="activity-item-<?php echo $action->action_id ?>" data-activity-feed-item="<?php echo $action->action_id ?>"><?php endif; ?>
    <?php $this->commentForm->setActionIdentity($action->action_id) ?>
    <script type="text/javascript">
      (function(){
        var action_id = '<?php echo $action->action_id ?>';
       // en4.core.runonce.add(function(){
          $('activity-comment-body-' + action_id).autogrow();
          en4.activity.attachComment($('activity-comment-form-' + action_id));
    //    });
      });
    </script>

    <?php // User's profile photo ?>



   <!-- <div class='feed_item_photo'><?php //echo $this->htmlLink($action->getSubject()->getHref(),
     // $this->itemPhoto($action->getSubject(), 'thumb.icon', $action->getSubject()->getTitle())
    //) ?>
    <?php //echo $this->htmlLink($action->getSubject()->getHref(), $this->itemPhoto($action->getSubject(), '', array('class' => 'photo')),array('title'=>$action->getSubject()->getTitle())) ?>






    </div>-->


    <div class='feed_item_body feed_item_body_<?php echo $licount?>' licount=<?php echo $licount;?> >

      <?php // Main Content ?>
   <?php /*   <span class="<?php echo ( empty($action->getTypeInfo()->is_generated) ? 'feed_item_posted' : 'feed_item_generated' ) ?>">
      <?php if($action->getSubject()->level_id == 6){
               $type = 'Landlord';
               } else if($action->getSubject()->level_id == 7){
               $type = 'Tenant';
               } else if($action->getSubject()->level_id == 8 && $action->getSubject()->services_type_id    ==  1){
                        $type = 'Leagal Aide';
                   } else if($action->getSubject()->level_id == 8 && $action->getSubject()->services_type_id    ==  2)
                   {
                       $type = 'Process Server';
                   } else if($action->getSubject()->level_id == 8 && $action->getSubject()->services_type_id    ==  3)
                   {
                       $type = 'Lawyer';
                   } else if($action->getSubject()->level_id == 8 && $action->getSubject()->services_type_id    ==  4)
                   {
                       $type = 'Paralegal';
                   }
               ?>
               <?php if($action->getTypeInfo()->type == 'signup'){ ?>
        A new <?php echo $type.' '; } ?><?php echo $action->getContent()?>

        </span> */?>
        <!----------- new property feed ----------------------->


       <?php

       $propertyTable =  Engine_Api::_()->getDbtable('propertylist', 'user');

        $propertyRequirementTable =  Engine_Api::_()->getDbtable('propertyrequirement', 'user');

       if($action->getTypeInfo()->type == 'property'): ?>

       <?php



        $propertySelect   =   $propertyTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('plist'=>'engine4_property_list',))
                        ->joinLeft(array('country'=>'engine4_property_countries',),'plist.prty_country_id=country.country_id',array('prty_country'))
                        ->joinLeft(array('state'=>'engine4_property_states',),'plist.prty_state_id=state.state_id',array('prty_state'))
                        ->joinLeft(array('city'=>'engine4_property_city',),'plist.prty_city_id=city.city_id',array('prty_city','latitude','longitude'))
                        ->where('plist.action_id=?' ,  $action->action_id);



        $propertyData=$propertyTable->fetchRow($propertySelect);




            //landlord id,name and path
    $userTable = Engine_Api::_()->getDbtable('users', 'user',array('display_name','user_id'));

    $UserData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $propertyData->property_owner_id));

    //echo  $display_name=$UserData->displayname;

    //echo    $UserData['user_id'];
    $viewHelperObj      =   $this->getHelper('ItemPhoto');

                 if($viewer->getIdentity()!=$UserData['user_id']):


                $profileNoPicInfo   =   $viewHelperObj->getNoPhoto($user);
                $type               =   'thumb.icon';
                $safeName           =   ( $type ? str_replace('.', '_', $type) : 'main' );
                $src                =   $UserData->getPhotoUrl($type);
                if($src):
                $src                =   $src;
                else:
                $src                =   $viewHelperObj->getNoPhoto($user,$safeName);
                endif;

        endif;
      //echo $src;


        ?>

        <div class="feed_property_locality">

        <div class="feed_property_name"><a class="feed_property_name_link" href="<?php echo $this->baseUrl().'/property/'.$propertyData->id ?>" title="View Property"><?php echo $propertyData->property_name;?>

        </a></div>
         <div class="timestamp feed_timestamp">Posted on: <?php echo $this->timestamp($action->getTimeValue()) ?></div>
        <div class="feed_property_locality_meta">
        <?php if($propertyData->prty_country !=''):?>
        <?php echo $propertyData->prty_country." , ".$propertyData->prty_state." , ".$propertyData->prty_city ;?>
		 
		 <?php if($propertyData->prty_county !=''):?>
		 <?php echo " , ".$propertyData->prty_county; ?>
		 <?php endif;?>
		 <?php if($propertyData->prty_neighborhood !=''):?>
		 <?php echo " , ".$propertyData->prty_neighborhood; ?>
		 <?php endif;?>
       
        <?php if($dev_type == 1): // mobile?>
        <a href="<?php echo $this->baseUrl().'/property/map/'.$propertyData->id ?>" target="_blank"><img src= "/application/modules/User/externals/images/LOCATION.png" style="margin-top: -4px;"></a>
        <?php else:?>
        <span class="location_icon" data-city= "<?php echo $propertyData->prty_city;?>" data-id ="<?php echo $propertyData->id;?>" data-type= "<?php echo $action->getTypeInfo()->type;?>" data-lat=<?php echo $propertyData->latitude;?> data-lng= <?php echo $propertyData->longitude;?>><img src= "/application/modules/User/externals/images/LOCATION.png" style="margin-top: -4px;"></span>
        <?php endif;?>
        <?php endif;?>
        </div>

        </div>



        <?php // Attachments ?>
      <?php if( $action->getTypeInfo()->attachable && $action->attachment_count > 0 ): // Attachments ?>
        <div class='feed_item_attachments'>
          <?php if( $action->attachment_count > 0 && count($action->getAttachments()) > 0 ): ?>
            <?php if( count($action->getAttachments()) == 1 &&
                    null != ( $richContent = current($action->getAttachments())->item->getRichContent()) ): ?>
              <?php echo $richContent; ?>
            <?php else: ?>
              <?php foreach( $action->getAttachments() as $attachment ): ?>
                <span class='feed_attachment_<?php echo $attachment->meta->type ?>'>
                <?php if( $attachment->meta->mode == 0 ): // Silence ?>
                <?php elseif( $attachment->meta->mode == 1 ): // Thumb/text/title type actions ?>
                  <div class="feed_property_div">
                    <?php
                      if ($attachment->item->getType() == "core_link")
                      {
                        $attribs = Array('target'=>'_blank');
                      }
                      else
                      {
                        $attribs = Array('title'=>'View Property');
                      }
                    ?>
                    <?php if( $attachment->item->getPhotoUrl() ): ?>

                    <div class="feed_property_image_div">
                    <?php echo $this->htmlLink($this->baseUrl().'/property/'.$propertyData->id, $this->itemPhoto($attachment->item, 'feed_property_image', $attachment->item->getTitle()), $attribs) ?>
                    <?php //echo $this->htmlLink($attachment->item->getHref(), $this->itemPhoto($attachment->item, 'feed_property_image', $attachment->item->getTitle()), $attribs) ?>
                    </div>

                    <?php endif; ?>

                    <div class="property_description">

                        <?php
                        $description  = strip_tags($propertyData->description);
                        if(strlen($description)<=300)
                          {
                            echo $description;
                          }
                          else
                          {
                            $y=substr($description,0,300) . '...';
                            echo $y;
                          }?>



                    </div>


                        <?php /* if($propertyData->rental_type == 'Lease'):?>

                    <span><img src="/application/modules/User/externals/images/lease.png" alt="" class="feed_property_rentaltype_image"> </span>

                    <?php else:?>
                    <span><img src="/application/modules/User/externals/images/rent.png" alt="" class="feed_property_rentaltype_image"> </span>

                    <?php endif; */?>
                    <div class="feed_property_details">

                    <div class="property_list_spl"><span class="qwerty"><img src="/application/modules/User/externals/images/apartments.svg"></span>  <span class="qwerty_label"><?php echo $propertyData->housing_type;?></span></div>
                    <div class="property_list_spl"><span class="qwerty"><img src="/application/modules/User/externals/images/price.png"></span><span class="qwerty_label"> <?php echo $propertyData->price;?></span></div>
                    <div class="property_list_spl"><span class="qwerty"><img src="/application/modules/User/externals/images/bedroom.png"></span><span class="qwerty_label"> <?php echo $propertyData->no_of_rooms;?> Bedroom</span></div>
                    <div class="property_list_spl"><span class="qwerty">
                        <?php if($propertyData->has_pets == 'No'):?>
                        <img src="/application/modules/User/externals/images/nopet.png"></span><span class="qwerty_label"> No </span>
                        <?php else:?>
                        <?php if($propertyData->pets_type == 'Dogs'):?>
                        <img src="/application/modules/User/externals/images/dog.svg"></span><span class="qwerty_label"> Dog </span>
                        <?php elseif($propertyData->pets_type == 'Cats'):?>
                        <img src="/application/modules/User/externals/images/cat.svg"></span><span class="qwerty_label"> Cat </span>
                        <?php elseif($propertyData->pets_type == 'Cats & Dogs'):?>
                        <img src="/application/modules/User/externals/images/catndog.png"></span><span class="qwerty_label"> Cats & Dogs </span>
                        <?php elseif($propertyData->pets_type == 'Birds'):?>
                        <img src="/application/modules/User/externals/images/bird.svg"></span><span class="qwerty_label"> Birds </span>
                        <?php elseif($propertyData->pets_type == 'Small pets'):?>
                        <img src="/application/modules/User/externals/images/tortoise.svg"></span><span class="qwerty_label"> Small pets </span>
                        <?php endif;?>
                        <?php endif;?>
                    </div>



                    </div>




                    <div>
                      <div class='feed_item_link_title'>
                        <?php
                       // echo $attachment->item->getHref();
                       // echo $attachment->item->getIdentity();



                          echo $this->htmlLink($attachment->item->getHref(), $attachment->item->getTitle() ? $attachment->item->getTitle() : '', $attribs);
                        ?>
                      </div>
                      <div class='feed_item_link_desc'>
                        <?php //$attachmentDescription = $attachment->item->getDescription()?>
                        <?php //if ($action->body != $attachmentDescription): ?>
                          <?php //echo $this->viewMore($attachmentDescription) ?>
                        <?php //endif; ?>
                      </div>
                    </div>
                  </div>
                <?php elseif( $attachment->meta->mode == 2 ): // Thumb only type actions ?>
                  <div class="feed_attachment_photo">
                    <?php echo $this->htmlLink($attachment->item->getHref(), $this->itemPhoto($attachment->item, 'thumb.normal', $attachment->item->getTitle()), array('class' => 'feed_item_thumb')) ?>
                  </div>
                <?php elseif( $attachment->meta->mode == 3 ): // Description only type actions ?>
                  <?php echo $this->viewMore($attachment->item->getDescription()); ?>
                <?php elseif( $attachment->meta->mode == 4 ): // Multi collectible thingy (@todo) ?>
                <?php endif; ?>
                </span>

                <?php if($action->getTypeInfo()->type == "property"): break; endif;?>
              <?php endforeach; ?>
              <?php endif; ?>
          <?php endif; ?>

        </div>
        <?php
         $likepropertyTable =  Engine_Api::_()->getDbtable('likeuser', 'user');

         $likepropertyData = $likepropertyTable->fetchRow($likepropertyTable->select()->where('type = ?', 'property')
        ->where('object_id = ?', $propertyData->id)
        ->where('subject_id = ?',$viewer_id ));

        ?>

         <?php if(count($likepropertyData) == 0):?>
   <!--   <div class="save_btn_div save_btn_div_<?php //echo $propertyData->id;?>"><button class="like_property like_property_<?php echo $propertyData->id;?>" onclick="Like_Property('<?php //echo $propertyData->id; ?>')" property_id="<?php //echo $propertyData->id; ?>" title="Save">Save</button></div>-->
      <div class="save_btn_div save_btn_div_<?php echo $propertyData->id;?>"><button class="like_property like_property_<?php echo $propertyData->id;?>" property_id="<?php echo $propertyData->id; ?>" title="Save">Save</button></div>
      <span class="loader loader_<?php echo $propertyData->id;?>" style="display:none;float:right"></span>
         <?php else: ?>
          <div class="save_btn_div save_btn_div_<?php echo $propertyData->id;?>"><button class="unlike_property like_user_<?php echo $propertyData->id;?>" property_id ="<?php echo $propertyData->id;?>" >Save</button></div>
         <?php endif; ?>
      <?php endif; ?>
                       <!-----------end new property feed ----------------------->

       <?php


       elseif($action->getTypeInfo()->type == 'property_requirement'):?>


       <?php


        $propertyRequirementSelect   =   $propertyRequirementTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('property_req'=>'engine4_property_requirement',))
                        ->joinLeft(array('country'=>'engine4_property_countries',),'property_req.country_id=country.country_id',array('prty_country'))
                        ->joinLeft(array('state'=>'engine4_property_states',),'property_req.state_id=state.state_id',array('prty_state'))
                        ->joinLeft(array('city'=>'engine4_property_city',),'property_req.city_id=city.city_id',array('prty_city','latitude','longitude'))
                        ->where('property_req.action_id=?' ,  $action->action_id);



        $propertyRequirementData=$propertyRequirementTable->fetchRow($propertyRequirementSelect);

        ?>

       <div class='feed_item_attachments'>

       <div class="feed_property_requirement_div">

       <?php /* <div class="feed_property_requirement_image_div">
                    <img src="/application/modules/User/externals/images/property_requiremnet.png" alt="" >
        </div>



     <div class="feed_property_requirement_details">

                    <div class="property_list_spl"><span class="qwerty"><img src="/application/modules/User/externals/images/Forma-3.png"></span>  <span class="qwerty_label"><?php echo $propertyRequirementData->housing_type;?></span></div>
                    <div class="property_list_spl"><span class="qwerty"><img src="/application/modules/User/externals/images/Vector-Smart-Object-1.png"></span>
                    <?php if($propertyRequirementData->budget !='' && $propertyRequirementData->budget_range_to !='' ):?>
                    <span class="qwerty_label"> <?php echo $propertyRequirementData->budget ." - ". $propertyRequirementData->budget_range_to ;?></span>
                    <?php else:?>
                    <span class="qwerty_label"> <?php echo $propertyRequirementData->budget;?></span>
                    <?php endif;?>
                    </div>
                    <div class="property_list_spl"><span class="qwerty"><img src="/application/modules/User/externals/images/Vector-Smart-Object.png"></span><span class="qwerty_label"> <?php echo $propertyRequirementData->no_of_rooms;?> Bedroom</span></div>
                    <div class="property_list_spl"><span class="qwerty">
                        <?php if($propertyRequirementData->pets_allowed == 'No'):?>
                        <img src="/application/modules/User/externals/images/Forma-2.png"></span><span class="qwerty_label"> No </span>
                        <?php else:?>
                        <?php if($propertyRequirementData->pets_type == 'Dogs'):?>
                        <img src="/application/modules/User/externals/images/dog.png"></span><span class="qwerty_label"> Dog </span>
                        <?php elseif($propertyRequirementData->pets_type == 'Cats'):?>
                        <img src="/application/modules/User/externals/images/cat.png"></span><span class="qwerty_label"> Cat </span>
                        <?php elseif($propertyRequirementData->pets_type == 'Cats & Dogs'):?>
                        <img src="/application/modules/User/externals/images/Layer-18.png"></span><span class="qwerty_label"> Cats & Dogs </span>
                        <?php elseif($propertyRequirementData->pets_type == 'Birds'):?>
                        <img src="/application/modules/User/externals/images/bird.png"></span><span class="qwerty_label"> Birds </span>
                        <?php elseif($propertyRequirementData->pets_type == 'Small pets'):?>
                        <img src="/application/modules/User/externals/images/tortoise.png"></span><span class="qwerty_label"> Small pets </span>
                        <?php endif;?>
                        <?php endif;?>
                    </div>


       <div class="feed_property_requirement_locality">
        <?php if($propertyRequirementData->prty_country !=''):?>
        <?php echo $propertyRequirementData->prty_country." , ".$propertyRequirementData->prty_state." , ".$propertyRequirementData->prty_city ;?>
        <?php if($dev_type == 1): // mobile?>
        <a href="<?php echo $this->baseUrl().'/property/requirement/map/'.$propertyRequirementData->id ?>" target="_blank"><img src= "/application/modules/User/externals/images/LOCATION.png" style="margin-top: -4px;"></a>
        <?php else:?>
        <span class="location_icon" data-city= "<?php echo $propertyRequirementData->prty_city;?>"  data-id ="<?php echo $propertyRequirementData->id;?>" data-type= "<?php echo $action->getTypeInfo()->type;?>" data-lat=<?php echo $propertyRequirementData->latitude;?> data-lng= <?php echo $propertyRequirementData->longitude;?>><img src= "/application/modules/User/externals/images/LOCATION.png" style="margin-top: -4px;"></span>
        <?php endif;?>

       <?php endif;?>
       </div>
       </div>
       </div> */ ?>
       <?php

        // Get table info
        $userTable = Engine_Api::_()->getDbtable('users', 'user');


        $userDataSelect   =   $userTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('user'=>'engine4_users',))
                        ->joinLeft(array('search_field'=>'engine4_user_fields_search'),'search_field.item_id=user.user_id',null)
                        ->joinLeft(array('fields_value'=>'engine4_user_fields_values'),'fields_value.item_id=user.user_id',array('value'))
                        ->joinLeft(array('state'=>'engine4_state_list',),'state.state_id=search_field.field_76',array('state'))
                        ->joinLeft(array('city'=>'engine4_city_list',),'city.city_id=search_field.field_77',array('city'))
                        ->where('user.search=?' , 1)
                        ->where('user.enabled=?' , 1)
                        ->where('search_field.profile_type =?' , '1')
                        ->where('fields_value.field_id=?' , 13)
                        ->where('user.user_id=?' , $action->getSubject()->getIdentity())
                        ->group('user.user_id');

                        $userData = $userTable->fetchRow($userDataSelect);

       ?>

       <div class="scrolling-row-intro player-info">

            <h2 class="vcard">
            <span class="hover-card-parent">

                <span class="url">

                    <?php  $attribs = Array('title'=>'View Profile'); ?>


                     <?php echo $this->htmlLink($action->getSubject()->getHref(), ucwords($action->getSubject()->getTitle()),$attribs) ?>

                </span>

            </span>

        <span class="meta locality">
            <?php echo "USA" . " , ";  if($userData->state !=''):?><?php echo $userData->state?>, <?php endif;?> <?php echo $userData->city?>
        </span>
        </h2>


        <a href="javascript:void(0)" class="feed_message_btn">Message</a>
        </div>

       </div>

   <?php else:?>
    <?php // Attachments ?>
      <?php if( $action->getTypeInfo()->attachable && $action->attachment_count > 0 ): // Attachments ?>
        <div class='feed_item_attachments'>
          <?php if( $action->attachment_count > 0 && count($action->getAttachments()) > 0 ): ?>
            <?php if( count($action->getAttachments()) == 1 &&
                    null != ( $richContent = current($action->getAttachments())->item->getRichContent()) ): ?>
              <?php echo $richContent; ?>
            <?php else: ?>
              <?php foreach( $action->getAttachments() as $attachment ): ?>
               <li>
            <?php echo $this->timestamp($action->getTimeValue()) ?>
          </li>
                <span class='feed_attachment_<?php echo $attachment->meta->type ?>'>
                <?php if( $attachment->meta->mode == 0 ): // Silence ?>
                <?php elseif( $attachment->meta->mode == 1 ): // Thumb/text/title type actions ?>
                  <div>
                    <?php
                      if ($attachment->item->getType() == "core_link")
                      {
                        $attribs = Array('target'=>'_blank');
                      }
                      else
                      {
                        $attribs = Array();
                      }
                    ?>
                    <?php if( $attachment->item->getPhotoUrl() ): ?>
                      <?php echo $this->htmlLink($attachment->item->getHref(), $this->itemPhoto($attachment->item, 'thumb.normal', $attachment->item->getTitle()), $attribs) ?>
                    <?php endif; ?>

                    <div>
                      <div class='feed_item_link_title'>
                        <?php
                          echo $this->htmlLink($attachment->item->getHref(), $attachment->item->getTitle() ? $attachment->item->getTitle() : '', $attribs);
                        ?>
                      </div>
                      <div class='feed_item_link_desc'>
                          <?php if ($attachment->item->getType() == "core_link"):?>
                        <?php $attachmentDescription = $attachment->item->getDescription()?>
                        <?php if ($action->body != $attachmentDescription): ?>
                          <?php echo $this->viewMore($attachmentDescription) ?>
                        <?php endif; ?>
                        <?php endif; ?>
                      </div>
                    </div>
                  </div>
                <?php elseif( $attachment->meta->mode == 2 ): // Thumb only type actions ?>
                  <div class="feed_attachment_photo">
                    <?php echo $this->htmlLink($attachment->item->getHref(), $this->itemPhoto($attachment->item, 'thumb.normal', $attachment->item->getTitle()), array('class' => 'feed_item_thumb')) ?>
                  </div>
                <?php elseif( $attachment->meta->mode == 3 ): // Description only type actions ?>
                  <?php echo $this->viewMore($attachment->item->getDescription()); ?>
                <?php elseif( $attachment->meta->mode == 4 ): // Multi collectible thingy (@todo) ?>
                <?php endif; ?>
                </span>

              <?php endforeach; ?>
              <?php endif; ?>
          <?php endif; ?>
        </div>
      <?php endif; ?>
      <?php endif; ?>

      <div id='comment-likes-activity-item-<?php echo $action->action_id ?>'>

      <?php // Icon, time since, action links ?>
      <?php
        $icon_type = 'activity_icon_'.$action->type;
        list($attachment) = $action->getAttachments();
        if( is_object($attachment) && $action->attachment_count > 0 && $attachment->item ):
          $icon_type .= ' item_icon_'.$attachment->item->getType() . ' ';
        endif;
        $canComment = ( $action->getTypeInfo()->commentable &&
            $this->viewer()->getIdentity() &&
            Engine_Api::_()->authorization()->isAllowed($action->getCommentableItem(), null, 'comment') &&
            !empty($this->commentForm) );
      ?>
      <div class='feed_item_date feed_item_icon <?php echo $icon_type ?>'>
        <ul>
         <!-- <li>
            <?php //echo $this->timestamp($action->getTimeValue()) ?>
          </li>-->
           <?php if($action->getTypeInfo()->type == 'property'):?>
          <?php if( $canComment ): ?>

            <?php if( $this->viewAllComments ): ?>
              <script type="text/javascript">
              //  en4.core.runonce.add(function() {
                  document.getElementById('<?php echo $this->commentForm->getAttrib('id') ?>').style.display = "";
                  document.getElementById('<?php echo $this->commentForm->submit->getAttrib('id') ?>').style.display = "block";
                  document.getElementById('<?php echo $this->commentForm->body->getAttrib('id') ?>').focus();
             //   });
              </script>
            <?php endif ?>
          <?php endif; ?>

            <?php endif; ?>
          <?php if( $this->viewer()->getIdentity() && (
                $this->activity_moderate || (
                ($this->viewer()->getIdentity() == $this->activity_group) || (
                  $this->allow_delete && (
                    ('user' == $action->subject_type && $this->viewer()->getIdentity() == $action->subject_id) ||
                    ('user' == $action->object_type && $this->viewer()->getIdentity()  == $action->object_id)
                  )
                )
               )
            ) ): ?>

            <li class="feed_item_option_edit">
                <span>-</span>
                <?php if($action->getTypeInfo()->type == 'property'):
                $propertyData = $propertyTable->fetchRow($propertyTable->select()->where('action_id = ?', $action->action_id));
                ?>
                <?php echo $this->htmlLink($this->baseUrl().'/property/edit/'.$propertyData->id, $this->translate('Edit')) ?>
                <?php elseif($action->getTypeInfo()->type == 'property_requirement'):
                $propertyrequirementData = $propertyRequirementTable->fetchRow($propertyRequirementTable->select()->where('action_id = ?', $action->action_id));
                ?>
                <?php echo $this->htmlLink($this->baseUrl().'/property/requirement/edit/'.$propertyrequirementData->id, $this->translate('Edit')) ?>
                <?php else:?>
                <?php echo $this->htmlLink(array(
                            'route'=>'default',
                            'module'    => 'activity',
                            'controller'=> 'index',
                            'action'    => 'editpost',
                            'action_id' => $action->action_id,
                            ), $this->translate('Edit'), array('class' => 'smoothbox')) ?>

                <?php endif; ?>
              </li>


            <li class="feed_item_option_delete">
              <span>-</span>
              <?php echo $this->htmlLink(array(
                'route' => 'default',
                'module' => 'activity',
                'controller' => 'index',
                'action' => 'delete',
                'action_id' => $action->action_id
              ), $this->translate('Delete'), array('class' => 'smoothbox')) ?>
            </li>

          <?php endif; ?>
          <?php if($action->getTypeInfo()->type == 'property_requirement' && ($this->viewer()->getIdentity() != $action->subject_id)):?>
           <li> <a href="javascript:void(0)" >&nbsp;&nbsp;Contact</a></li>

          <?php endif; ?>

          <?php // Share ?>
          <?php if( $action->getTypeInfo()->shareable && $this->viewer()->getIdentity() ): ?>
            <?php if( $action->getTypeInfo()->shareable == 1 && $action->attachment_count >= 1 && ($attachment = $action->getFirstAttachment()) ): ?>
              <li class="feed_item_option_share">
                <span>-</span>
                <?php if($action->getTypeInfo()->type == 'property' && $profile_type_id == 1): ?>
					<?php if($dev_type == 1): // mobile?> 
						 <a href="<?php echo $this->baseUrl().'/tichat/inbox'; ?>" >&nbsp;&nbsp;Contact</a>
					  <?php else: ?>
						<span onClick="popUpChatClick('<?php echo $UserData['user_id'] ?>','<?php echo $UserData['displayname'] ?>','<?php echo $src ?>','<?php echo $status ?>')">
							<a href="javascript:void(0)" >&nbsp;&nbsp;Contact</a>
					 <?php endif; ?>
                      <li> <a href="javascript:void(0)" class="feed_comment" action_id="<?php echo $action->action_id; ?>" >&nbsp;&nbsp;Comment</a></li>
    <div class="feed_comment_post feed_comment_post_<?php echo $action->action_id?>" style="display:none">
    <form>
    <textarea class="feed_comment_body feed_comment_body_<?php echo $action->action_id;?>" ></textarea>

    <input type="button" value="Post" class="comment_post_btn" status="<?php echo 'post_comment' ?>" action_id="<?php echo $action->action_id;?>" viewer_id="<?php echo $viewer_id ;?>" actionSubjectId = "<?php echo $action->getSubject()->getIdentity();?>">
    </form>
    </div>
    <span class="loader loader_<?php echo $action->action_id;?>" style="display:none;float:right !important"></span>
                </span>

                <?php else: ?>
                <?php echo $this->htmlLink(array('route' => 'default', 'module' => 'activity', 'controller' => 'index', 'action' => 'share', 'type' => $attachment->item->getType(), 'id' => $attachment->item->getIdentity(), 'format' => 'smoothbox'), $this->translate('Share'), array('class' => 'smoothbox', 'title' => 'Share')) ?>

                <?php endif; ?>

              </li>
            <?php elseif( $action->getTypeInfo()->shareable == 2 ): ?>
              <li class="feed_item_option_share">
                <span>-</span>
                <?php echo $this->htmlLink(array('route' => 'default', 'module' => 'activity', 'controller' => 'index', 'action' => 'share', 'type' => $subject->getType(), 'id' => $subject->getIdentity(), 'format' => 'smoothbox'), $this->translate('Share'), array('class' => 'smoothbox', 'title' => 'Share')) ?>
              </li>
            <?php elseif( $action->getTypeInfo()->shareable == 3 ): ?>
              <li class="feed_item_option_share">
                <span>-</span>
                <?php echo $this->htmlLink(array('route' => 'default', 'module' => 'activity', 'controller' => 'index', 'action' => 'share', 'type' => $object->getType(), 'id' => $object->getIdentity(), 'format' => 'smoothbox'), $this->translate('Share'), array('class' => 'smoothbox', 'title' => 'Share')) ?>
              </li>
            <?php elseif( $action->getTypeInfo()->shareable == 4 ): ?>
              <li class="feed_item_option_share">
                <span>-</span>
                <?php echo $this->htmlLink(array('route' => 'default', 'module' => 'activity', 'controller' => 'index', 'action' => 'share', 'type' => $action->getType(), 'id' => $action->getIdentity(), 'format' => 'smoothbox'), $this->translate('Share'), array('class' => 'smoothbox', 'title' => 'Share')) ?>
              </li>
            <?php endif; ?>
          <?php endif; ?>
        </ul>
      </div>

      <?php if($action->getTypeInfo()->type == 'property'):?>
      <!--</div> End of Comment-Likes -->

      <?php if( $action->getTypeInfo()->commentable ): // Comments - likes ?>
        <div class='comments comments_<?php echo $action->action_id;?>'>
          <ul>
            <?php if( $action->likes()->getLikeCount() > 0 && (count($action->likes()->getAllLikesUsers())>0) ): ?>
              <li>
                <div></div>
                <div class="comments_likes">
                  <?php if( $action->likes()->getLikeCount() <= 3 || $this->viewAllLikes ): ?>
                    <?php echo $this->translate(array('%s likes this.', '%s like this.', $action->likes()->getLikeCount()), $this->fluentList($action->likes()->getAllLikesUsers()) )?>

                  <?php else: ?>
                    <?php /* echo $this->htmlLink($action->getSubject()->getHref(array('action_id' => $action->action_id, 'show_likes' => true)),
                      $this->translate(array('%s person likes this', '%s people like this', $action->likes()->getLikeCount()), $this->locale()->toNumber($action->likes()->getLikeCount()) )
                    ) */ ?>
                  <?php endif; ?>
                </div>
              </li>
            <?php endif; ?>

<?php $postcommentTable =  Engine_Api::_()->getDbtable('Postcomments', 'user');

    $postcommentData = $postcommentTable->fetchAll($postcommentTable->select()
     ->where('actionId = ?',$action->action_id )
      ->order('commentId DESC')
     ->limit(2)
     );

?>
<ul class="comment_ul comment_ul_<?php echo $action->action_id; ?>">
<?php foreach($postcommentData as $data):?>
<li class="comment_li comment_li_<?php echo $data['commentId'] ;?>">
<?php $userTable = Engine_Api::_()->getDbtable('users', 'user');
      $userData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $data['posterId']));
                   ?>
<?php if(!empty($userData)) : ?>
<div class="comment_auther_photo">

    <?php echo $this->htmlLink($userData->getHref(), $this->itemPhoto($userData, 'thumb.icon', $userData->getTitle()), array('title'=>$userData->getTitle())) ?>

</div>
<div class="comments_info">
<span class="comments_author"><a href="<?php echo $this->baseUrl().'/profile/'.$data['posterId'] ?>"><?php echo $userData->getTitle();?></a></span>
<span class="comment_content"><?php echo $data['body'];?></span>
<div class="comment_timestamp" comment_time="<?php echo $data['created_at']; ?>"><?php echo $this->timestamp($data['created_at']); ?></div>

<?php if(($viewer_id == $data['posterId']) || ($viewer_id == $action->getSubject()->getIdentity())): ?>
<span class="delete_feed_comment" comment_id="<?php echo $data['commentId'] ?>" action_id="<?php echo $action->action_id; ?>" poster_id="<?php echo $data['posterId'] ?>">
<a href="javascript:void(0)">Delete</a>
</span>
<?php endif;?>
</div>
<?php endif ; ?>
</li>
</br>
<?php endforeach;?>

      <?php
     $postcommentTable =  Engine_Api::_()->getDbtable('Postcomments', 'user');
     $allpostcommentData = $postcommentTable->fetchAll($postcommentTable->select()
     ->where('actionId = ?',$action->action_id )
      ->order('commentId DESC')
     );
      $comment_count= count($allpostcommentData);
      ?>
            <?php if( $comment_count > 2): ?>

                 <div class="feed_view_comment">
                 <a href="javascript:void(0)" class="comments_Load_more comments_Load_more_<?php echo $action->action_id; ?>" action_id="<?php echo $action->action_id; ?>" status="<?php echo 'view_more' ?>" resource_id="<?php echo $attachment->item->getIdentity(); ?>">View more</a>
                </div>


            <?php endif; ?>
</ul>

              <?php
               // $commentLikes = $action->getCommentsLikes($comments, $this->viewer());
              ?>
          <?php if( $canComment ) echo $this->commentForm->render() /*
          <form>
            <textarea rows='1'>Add a comment...</textarea>
            <button type='submit'>Post</button>
          </form>
          */ ?>
        </div>
      <?php endif; ?>

      </div>
      <?php endif; ?><!-- End of Comment Likes -->


    </div>
  <?php if( !$this->noList ): ?></li><?php endif; ?>

<?php
      ob_end_flush();
    } catch (Exception $e) {
      ob_end_clean();
      if( APPLICATION_ENV === 'development' ) {
        echo $e->__toString();
      }
    };
   if($checkprofilefeedtype =='landlordfeed'){

   $purl = '/updates/'.$subject->getIdentity();

   if($page_url != $purl){

         if($licount >= 2 ){

         break;

          }
     }
    }
  endforeach;

 if( !$this->getUpdate ): ?>
</ul>
   <?php

   if($checkprofilefeedtype =='landlordfeed'){

   $purl = '/updates/'.$subject->getIdentity();

   if($page_url != $purl){

         if($licount >= 2 ){
    ?>
        <a href="updates/<?php echo $subject->getIdentity();?>" style="float: right;">View More</a>

    <?php }

    }
}

    ?>


</div>
<?php endif; ?>
<?php endif; ?>
<script>

    var page_url =  '<?php echo $page_url; ?>';

jQuery( ".feed_item_option_like" ).click(function() {
    var oData       = new Object();

    var action_id=oData.action_id ='<?php echo $action->getIdentity() ?>';

    var action=oData.action ='<?php echo "like" ?>';

    var formURL    = '<?php echo $this->baseUrl(); ?>' + '/activity/index/like';

    jQuery.ajax( {
                        url : formURL,
                        type: "POST",
                        dataType: 'json',
                        data : oData,
                        success: function (data) {

                                    //alert(data.status);
                                    //location.href = '<?php echo $this->baseUrl(); ?>' + '/members/home';


                            },
                            error: function(e){

                        }
    });

});




</script>



<script>



jQuery('body').on('click', '.like_property', function(event){


var oData       = new Object();

var property_id =oData.property_id =parseInt(jQuery(this).attr('property_id'));

jQuery('.loader_'+property_id).css('display','block');
jQuery('.like_property_'+property_id).css('display','none');

jQuery('.save_btn_div_'+property_id).html('');

        var url = '<?php echo $this->baseUrl().'/user/index/likeproperty' ?>';
            jQuery.ajax( {
                        url : url,
                        type: "POST",
                        dataType: 'json',
                        data : oData,
                        success: function (data) {

                                   if(data.status==true)
                                   {
                        jQuery('.save_btn_div_'+property_id).html('');

                        jQuery('.save_btn_div_'+property_id).html('<button class="unlike_property like_property_'+property_id+'" user_id ="'+property_id+'" title="Unsave">Save</button>');
                        jQuery('.loader_'+property_id).css('display','none');

                        var url = '<?php echo $this->baseUrl().'/user/index/getlikedproperties' ?>';
                        jQuery.ajax({

                            url:  url,
                            data: oData,
                            dataType: 'json',
                            type: 'POST',
                            success: function (result) { console.log(result.html);

                                jQuery('#likePropertyModal .modal-body').html(result.html);


                                },
                           error: function(e){ }
                        });





                                   }


                            },
                            error: function(e){

                        }
    });

    });


    jQuery('body').on('click', '.comments_Load_more', function(event){

    var action_id =parseInt(jQuery(this).attr('action_id'));
    var status =jQuery(this).attr('status');
    var oData           = new Object();
    var status   = oData.status =status;
    var action_id    = oData.action_id =action_id;
    if(jQuery( ".comments_Load_more").hasClass("comments_Load_more_"+action_id)){

    var formURL    = '<?php echo $this->baseUrl(); ?>' + '/user/index/viewcomments';

    jQuery.ajax( {
                        url : formURL,
                        type: "POST",
                        dataType: 'json',
                        data : oData,
                        success: function (data) {

                            jQuery('.comment_ul_'+action_id+'').html(data.html);
                        },
                            error: function(e){

                        }
    });
}




    });








    jQuery('body').on('click', '.feed_comment', function(event){

    var action_id =parseInt(jQuery(this).attr('action_id'));

        if(jQuery( ".feed_comment" ).hasClass("show_comment")){
             jQuery('.feed_comment_post_'+action_id+'').css('display','none');
            jQuery( ".feed_comment" ).removeClass("show_comment");
        }

        else
        {
            jQuery( ".feed_comment" ).addClass("show_comment");
            jQuery('.feed_comment_post_'+action_id+'').css('display','block');
        }

});


    jQuery('body').on('click', '.comment_post_btn', function(event){
    var action_id =parseInt(jQuery(this).attr('action_id'));

    var poster_id       =parseInt(jQuery(this).attr('viewer_id'));
    var actionSubjectId =parseInt(jQuery(this).attr('actionSubjectId'));


    var oData              = new Object();
    var action_id          = oData.action_id =action_id;
    var poster_id          = oData.poster_id =poster_id;
    var actionSubjectId    = oData.actionSubjectId =actionSubjectId;
    jQuery('.loader_'+action_id).css('display','block');
                                    jQuery('.feed_comment_post_'+action_id+'').css('display','none');
                                jQuery( ".feed_comment" ).removeClass("show_comment");

    var feed_comment_body = jQuery('.feed_comment_body_'+action_id+'').val();

    var feed_comment_body    = oData.feed_comment_body =feed_comment_body;


    var formURL    = '<?php echo $this->baseUrl(); ?>' + '/user/index/postfeedcomment';

            jQuery.ajax( {
                        url : formURL,
                        type: "POST",
                        dataType: 'json',
                        data : oData,
                        success: function (data) {

                        console.log(data.commenthtml);
                            jQuery('.comment_ul_'+action_id+'').html(data.html);

                            jQuery('.feed_comment_body_'+action_id+'').val('');
                            jQuery('.loader_'+action_id).css('display','none');
                            },
                            error: function(e){

                        }
    });


    });




   jQuery('body').on('click', '.delete_feed_comment', function(event){

   var comment_id =parseInt(jQuery(this).attr('comment_id'));

   var poster_id =parseInt(jQuery(this).attr('poster_id'));
   var action_id    = parseInt(jQuery(this).attr('action_id'));
   var oData           = new Object();

   var comment_id    = oData.comment_id =comment_id;
   var poster_id    = oData.poster_id =poster_id;
   var action_id    = oData.action_id =action_id;

   oData.status =status;

   jQuery("#DeletecommentModal").modal('show');

    var URL    = '<?php echo $this->baseUrl(); ?>' + '/user/index/deletecomment';
   jQuery('body').on('click', '.yes_delete_comment', function(event){

       jQuery.ajax( {
                        url : URL,
                        type: "POST",
                        dataType: 'json',
                        data : oData,
                        success: function (data) {

                         jQuery("#DeletecommentModal").modal('hide');
                         jQuery(".comment_li_"+comment_id+"").css('display','none');


                        var formURL    = '<?php echo $this->baseUrl(); ?>' + '/user/index/viewcomments';


                            var status       = "view_less";
                            var status       = oData.status    = status;

                     jQuery.ajax( {
                                                url : formURL,
                                                type: "POST",
                                                dataType: 'json',
                                                data : oData,
                                                success: function (data) {
                                        jQuery('.comment_ul_'+action_id+'').html(data.html);

                                                    },
                                                    error: function(e){

                                                }
                            });


                            },
                            error: function(e){

                        }
    });


    });

    });



  jQuery('body').on('click', '.comments_Less', function(event){

    var action_id =parseInt(jQuery(this).attr('action_id'));
    var status =jQuery(this).attr('status');
    var oData           = new Object();
    var status   = oData.status =status;
    var action_id    = oData.action_id =action_id;
    jQuery('.comments_Load_more_'+action_id).remove();

    var formURL    = '<?php echo $this->baseUrl(); ?>' + '/user/index/viewcomments';

    jQuery.ajax( {
                        url : formURL,
                        type: "POST",
                        dataType: 'json',
                        data : oData,
                        success: function (data) {

                            jQuery('.comment_ul_'+action_id+'').html(data.html);
                        },
                            error: function(e){

                        }
    });


    });

</script>
