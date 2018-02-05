
<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: _browseUsers.tpl 9979 2013-03-19 22:07:33Z john $
 * @author     John
 */
?>


<link rel="stylesheet" href="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/styles/online.css" type="text/css">
<script >
    jQuery( function() {
  var $winHeight = jQuery( window ).height()
  jQuery( '.container' ).height( $winHeight );
    });
</script>
 <?php
   $online_users=$this->online_users;
   $status = 'false';
   $online_user_id = array();
   foreach($online_users as $row):

   $online_user_id[]=$row['user_id'];
   endforeach;

?>
<div class='browsemembers_results' id='browsemembers_results11'>
<h3>
  <?php echo 'LANDLORDS  : '. $this->translate(array('%s member found', '%s members found', $this->totalUsers),$this->locale()->toNumber($this->totalUsers)) ?>
</h3>


<div class="results-pane">

<?php $viewer = Engine_Api::_()->user()->getViewer();?>

<?php if( count($this->users) ): ?>


<ul>

    <?php foreach( $this->users as $user ): ?>
    <?php // print_r($user); exit;?>
<li class="results_pane_li">

    <div class="scrolling-row-inner">

        <?php if(in_array($user['user_id'],$online_user_id)): ?>
       <div class="led-green" style="top: 86px; margin-left: 51px;"></div>
        <?php endif; ?>

        <div class="profile_image">
            <?php echo $this->htmlLink($user->getHref(), $this->itemPhoto($user, '', array('class' => 'photo')),array('title'=>$user->getTitle())) ?>

            <?php if($viewer->getIdentity()!=$user['user_id']): ?>

            <?php
                $tichat_viewHelperObj      =   $this->getHelper('ItemPhoto');
                $profileNoPicInfo   =   $tichat_viewHelperObj->getNoPhoto($user);
                $type               =   'thumb.icon';
                $safeName           =   ( $type ? str_replace('.', '_', $type) : 'main' );
                $src                =   $user->getPhotoUrl($type);
                if($src):
                $src                =   $src;
                else:
                $src                =   $tichat_viewHelperObj->getNoPhoto($user,$safeName);
                endif;
            ?>

             <span onClick="popUpChatClick('<?php echo $user['user_id'] ?>','<?php echo $user['displayname'] ?>','<?php echo $src ?>','<?php echo $status ?>')">
                 <h3 class="single_popupchat_click" id="user_id^<?php echo $user['user_id'].'^'. $user['displayname']?>">Message</h3>
              </span>
            <?php endif; ?>
        </div>

        <div class="scrolling-row-intro player-info">



            <h2 class="vcard">
            <span class="hover-card-parent">

                <span class="url">
                    <!--<img class="photo" src="https://d13yacurqjgara.cloudfront.net/users/13307/avatars/normal/Mike3.jpg?1382537343"> Mike | Creative Mints-->

<?php  $attribs = Array('title'=>'View Profile'); ?>


                     <?php echo $this->htmlLink($user->getHref(), ucwords($user->getTitle()),$attribs) ?>

                </span>

            </span>

        <span class="meta locality">
            <?php echo "USA" . " , ";  if($user['state'] !=''):?><?php echo $user['state']?>, <?php endif;?> <?php echo $user['city']?>
        </span>
        </h2>


        <?php

            $propertyTable =  Engine_Api::_()->getDbtable('propertylist', 'user');

            $propertyImageSelect   =   $propertyTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('plist'=>'engine4_property_list',))
                        ->joinLeft(array('pimages'=>'engine4_property_images'),'plist.id=pimages.property_id',array('image'))
                        ->joinLeft(array('user'=>'engine4_users',),'plist.property_owner_id=user.user_id',array('displayname'))
                        ->where('plist.property_owner_id=?' , $user['user_id'])
                        ->where('pimages.type =?' , 'image')
                        ->where('(plist.enable = ?', 1)
                        ->orWhere('user.bg_verified  = ?)', 1)
                        ->where('plist.landlord_enable=?' , 1)
                        ->group('plist.id')
                        ->order('plist.id DESC');

            $propertyImageSelectData=$propertyTable->fetchAll($propertyImageSelect);
            ?>

        <div class="property-prompt">
        <span style="float: left;">
          <?php if($viewer->getIdentity()==$user['user_id']): ?>
          <a href="<?php echo $this->baseUrl().'/myproperties' ;?>" ><img src="<?php echo $this->baseUrl().'/application/modules/User/externals/images/Forma-3.png'?>"></a>
          <?php else:?>
          <a href="<?php echo $this->baseUrl().'/properties/'.$user['user_id'] ;?>" ><img src="<?php echo $this->baseUrl().'/application/modules/User/externals/images/Forma-3.png'?>"></a>
          <?php endif ;?>
          </span>
              <span>
              <?php if($viewer->getIdentity()==$user['user_id']): ?>
              <div class="property_count"><a href="<?php echo $this->baseUrl().'/myproperties' ;?>" ><span class="count"><?php echo count($propertyImageSelectData);?></span><span class="property_label">Properties</span></a></div>
              <?php else:?>
              <div class="property_count"><a href="<?php echo $this->baseUrl().'/properties/'.$user['user_id'] ;?>" ><span class="count"><?php echo count($propertyImageSelectData);?></span><span class="property_label">Properties</span></a></div>
              <?php endif ;?>

              </span>

        </div>




        <?php /*<div class='browsemembers_results_links'>
                    <?php
        $table = Engine_Api::_()->getDbtable('block', 'user');
        $select = $table->select()
          ->where('user_id = ?', $user->getIdentity())
          ->where('blocked_user_id = ?', $viewer->getIdentity())
          ->limit(1);
        $row = $table->fetchRow($select);
        ?>
        <?php if( $row == NULL ): ?>
          <?php if( $this->viewer()->getIdentity() ): ?>

            <?php echo $this->userFriendship($user) ?>

        <?php endif; ?>
        <?php endif; ?>
        </div> */ ?>

        </div>
        <div class="property_images">



            <?php $i=0;?>
            <?php foreach($propertyImageSelectData as $pimages):?>
            <?php if($i<2):?>

            <div class="dribbble zoom-effect-container">

                <div class="dribbble-img image-card">

                    <a href="<?php echo $this->baseUrl().'/property/'.$pimages['id']?>"><img  alt="" src="<?php echo $this->baseUrl().'/'.$pimages['image']?>" title="<?php echo $pimages[property_name]; ?>" width=200px; height=210px></a>

                </div>

            </div>
            <?php $i++;?>
            <?php endif;?>
            <?php endforeach;?>


      </div>

    </div>
</li>


<?php endforeach; ?>

</ul>

<?php endif; ?>

</div>



<?php if( $this->users ):
    $pagination = $this->paginationControl($this->users, null, null, array(
      'pageAsQuery' => true,
      'query' => $this->formValues,
    ));
  ?>
  <?php if( trim($pagination) ): ?>
    <div class='browsemembers_viewmore' id="browsemembers_viewmore">
      <?php echo $pagination ?>
    </div>
  <?php endif ?>
<?php endif; ?>

</div>


<script type="text/javascript">
  page = '<?php echo sprintf('%d', $this->page) ?>';
  totalUsers = '<?php echo sprintf('%d', $this->totalUsers) ?>';
  userCount = '<?php echo sprintf('%d', $this->userCount) ?>';

</script>
