<?php $current_url = explode("?", $_SERVER['REQUEST_URI']);
      $page_url=$this->view->page_url=$page_url = $current_url[0] ;
      $settings = Engine_Api::_()->getApi('settings', 'core');
      $viewHelperObj  = $this->getHelper('SmartmoveApi');
      $StateArray     = $viewHelperObj->getState();
      $userHelperObj                          =  $this->getHelper('User');
      $logincount     = $this->logincount;
      $introstatus    =   $_SESSION['introstatus'];

?>
<?php  if($this->viewer->getIdentity() || $page_url!='/addproperty'):?>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAAWRDCCJZYbD17HwNNUMK-6DzyHziKhN8&libraries=places" async defer></script>
<script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/scripts/autocomplete_address_googleapi.js"></script>
<?php endif ;  ?>

 <?php
    $useragent=$_SERVER['HTTP_USER_AGENT'];
    $iPod = stripos($_SERVER['HTTP_USER_AGENT'],"iPod");
    $iPhone = stripos($_SERVER['HTTP_USER_AGENT'],"iPhone");
    $iPad = stripos($_SERVER['HTTP_USER_AGENT'],"iPad");
    $Android = stripos($_SERVER['HTTP_USER_AGENT'],"Android");
    if( $iPod || $iPhone || $iPad || $Android)  {
        $dev_type= 1; // mobile
    }
    else{
        $dev_type= 2; // system
    }
    if($iPhone){
        $device_name = 'iPhone';
    }
    elseif($Android){
        $device_name = 'Android';
    }
    else{
        $device_name = 'Web';
    }
    $userHelperObj  = $this->getHelper('User');
    $memberPackage  = $userHelperObj->getmemberpackage($this->viewer->getIdentity());
    $package_type   = $memberPackage ->package_type;
    $scoutCount     = $userHelperObj->getscoutcount($this->viewer->getIdentity());
    $userdetails    = $userHelperObj->getuserDetails($this->viewer->getIdentity());
    $profileType    = $userdetails['profile_type'];
    $settings                         = Engine_Api::_()->getApi('settings', 'core');
    $user_premiumLevelProvision       = $settings->user_premiumLevelProvision;
    $user_basicPropertyLimit          = $settings->user_basicPropertyLimit;
    $user_landlordProPropertyLimit    = $settings->user_landlordProPropertyLimit;
    $user_basicScoutLimit             = $settings->user_basicScoutLimit;
    $user_landlordProScoutLimit       = $settings->user_landlordProScoutLimit;
    $introHelperObj  = $this->getHelper('Intro');
    $introText      = $introHelperObj->introtext($profileType);
     

  ?>


 <!-- For tichat -->
        <?php
            $tichat_viewer        =   Engine_Api::_()->user()->getViewer();
            if($tichat_viewer->getIdentity()):
                $tichat_viewHelperObj      =   $this->getHelper('ItemPhoto');
                $tichat_profileNoPicInfo   =   $tichat_viewHelperObj->getNoPhoto($viewer);
                $tichat_type               =   'thumb.icon';
                $tichat_safeName           =   ( $tichat_type ? str_replace('.', '_', $tichat_type) : 'main' );
                $tichat_src                =   $tichat_viewer->getPhotoUrl($type);
                if($tichat_src):
                $tichat_src                =   $tichat_src;
                else:
                $tichat_src                =   $tichat_viewHelperObj->getNoPhoto($tichat_viewer,$tichat_safeName);
                endif;
        ?>
                <script>
                    var viewerId            =   '<?php echo $tichat_viewer->getIdentity();?>';
                    var viewerName          =   '<?php echo $tichat_viewer->displayname;?>';
                    var viewerProfilePic    =   '<?php echo $tichat_src ?>';
                    var viewer_identity     =    viewerId;
                    var devType             =   '<?php echo $dev_type ?>';
                    var baseUrl             =   '<?php echo $this->baseUrl(); ?>';
                    var viewer_profile_type =   '<?php echo $userdetails['profile_type']; ?>';
                    var viewer_video_payment=   '<?php echo $userdetails['video_payment']; ?>';  //alert(viewer_video_payment);
                    var viewer_package_type =   '<?php echo $package_type; ?>';
                    var user_premiumLevelProvision =   '<?php echo $user_premiumLevelProvision; ?>'; //if value is 1 ->promotion time,if value is 2->not promotion time
                    var scoutCount                 =   '<?php echo $scoutCount;?>';
                    var user_basicScoutLimit       =   '<?php echo $user_basicScoutLimit;?>';
                </script>

                <link rel='stylesheet' href='/application/modules/User/externals/chat/css/style.css' type='text/css'/>
                <link rel='stylesheet' href='/application/modules/User/externals/chat/css/responsive-style.css' type='text/css'/>
                <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/jquery.perfect-scrollbar/0.7.0/css/perfect-scrollbar.min.css' type='text/css'/>

                <script src="/application/modules/User/externals/chat/js/sails.io.js"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.perfect-scrollbar/0.7.0/js/perfect-scrollbar.jquery.min.js"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-mousewheel/3.1.13/jquery.mousewheel.min.js"></script>
                <script src="/application/modules/User/externals/chat/js/config.js"></script>
                <script src="/application/modules/User/externals/chat/js/helper.js"></script>
                <script src="/application/modules/User/externals/chat/js/chatFunctions.js"></script>
                <script src="/application/modules/User/externals/chat/js/websocketRequest.js"></script>
                <script src="/application/modules/User/externals/chat/js/websocket.js"></script>
                <script src="/application/modules/User/externals/chat/js/chatPageScripts.js"></script>
                <?php
                    $iPod       = stripos($_SERVER['HTTP_USER_AGENT'],"iPod");
                    $iPhone     = stripos($_SERVER['HTTP_USER_AGENT'],"iPhone");
                    $iPad       = stripos($_SERVER['HTTP_USER_AGENT'],"iPad");
                    if($iPod || $iPhone || $iPad) {

                    } else {
                ?>
                    <script src="https://cdnjs.cloudflare.com/ajax/libs/adapterjs/0.15.0/adapter.min.js"></script>
                <?php } ?>
                <script src="/application/modules/User/externals/chat/js/webrtc.js"></script>

        <?php endif;?>

    <!-- For tichat -->

 <!-- For Intro -->  
<?php if($page_url == '/members/home' && $dev_type == 2):?>
<script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/scripts/intro.js"></script>
<link rel='stylesheet' href='/application/modules/User/externals/styles/intro/demo.css' type='text/css'/>
<link rel='stylesheet' href='/application/modules/User/externals/styles/intro/introjs.css' type='text/css'/>
<?php endif;?>
 <!-- For Intro --> 


<?php $viewer = $this->viewer(); ?>
    <?php
    $useragent=$_SERVER['HTTP_USER_AGENT'];
    $iPod = stripos($_SERVER['HTTP_USER_AGENT'],"iPod");
    $iPhone = stripos($_SERVER['HTTP_USER_AGENT'],"iPhone");
    $iPad = stripos($_SERVER['HTTP_USER_AGENT'],"iPad");
    $Android = stripos($_SERVER['HTTP_USER_AGENT'],"Android");
    if( $iPod || $iPhone || $iPad || $Android)  { $dev_type= 1; }// mobile
    else{   $dev_type= 2; }// system

    if($iPhone)     { $device_name = 'iPhone';  }
    elseif($Android){ $device_name = 'Android'; }
    else            { $device_name = 'Web';     }
    ?>
<?php
// member type
$viewer = Engine_Api::_()->user()->getViewer();
    $fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer);
    if( !empty($fieldsByAlias['profile_type']) )
    {
      $optionId = $fieldsByAlias['profile_type']->getValue($viewer);
      $profile_type_id = $optionId->value;
    }
?>
<div class="main_menu_div clearfix">
        <div class="navbar-header">
           <a  href="#"><img src="public/admin/condense-logo.png" class="mob_bar" style="max-height: 40px;"></a>
           <a class="navbar-brand 5511" href="#" ><img src="public/admin/rent2-starz-landing-page-logo.png" class="mob_bar_disable"></a>
              <a class="navbar-brand" href="#">
                    <span class="ybo_logo 11">
                    </span>
            </a>
        </div>

        <div class="sub_header_dropdown  mob_bar_enable_partcular_pages col-sm-2 ">


        </div>

          <!--<div class="group-mini-menu start">-->
        <div class="header_mini_menu_icons">
        <?php
            // Reverse the navigation order (they're floating right)
            $count = count($this->navigation);
            foreach( $this->navigation->getPages() as $item ) $item->setOrder(--$count);
            $route = array('route'=>'user_logout', 'action'=>'logout');
        ?>
        <div class="ynadvmenu_notification" id="ynadvmenu_notification">
            <?php if($this->viewer->getIdentity()):?>
            <div class="header_statitics_online_menu_div ynadvmenu_mini_wrapper mob_bar_disable" style="display:none;">
              <a class="header_statitics_online_menu"  href="javascript:void(0)" title="Snapshot">
                <img src="/application/modules/User/externals/images/arrow.png" width="14px" height="10px" >
                </a>
            </div>
            <div id="verified_header_icon" class="ynadvmenu_mini_wrapper"></div>
        <?php if( $profile_type_id == 4):?>
        <div id="fdg" class="ynadvmenu_mini_wrapper mob_bar_disable_particular_pages">
        <a href="javascript:void(0)" class="liked_users_list" title="Saved Renters" data-toggle="modal" data-target="#likeUserModal" ><i class="fa fa-heart" aria-hidden="true" style="color: #f58410;"></i></a>
        </div>
        <?php endif; ?>
        <?php if( $profile_type_id == 1):?>
        <div id="fdg" class="ynadvmenu_mini_wrapper mob_bar_disable_particular_pages">
        <a href="javascript:void(0)" class="liked_property_list" title="Saved Properties" data-toggle="modal" data-target="#likePropertyModal"><i class="fa fa-heart" aria-hidden="true" style="color: #f58410;"></i></a>
        </div>
        <?php endif; ?>
 <!--noti and msg-->
                      <div id="ynadvmenu_MessagesUpdates" class="ynadvmenu_mini_wrapper mob_bar_disable_particular_pages">
                        <a href="/tichat/inbox" class="ynadvmenu_NotifiIcon" id="ynadvmenu_messages1" title="Messages">
                           <img src="/application/modules/User/externals/images/message.png" class="msgNtfnIcon" width="20px" height="16x">
                           <span id="ynadvmenu_ChatNotifyCount" class="ynadvmenu_NotifiIconWrapper"></span>
                        </a>
                     </div>


                    <div id="ynadvmenu_NotificationsUpdates" class="ynadvmenu_mini_wrapper mob_bar_disable_particular_pages">
                        <a href="javascript:void(0);" class="ynadvmenu_NotifiIcon" id = "ynadvmenu_updates" title="Notifications">
                        <img src="/application/modules/User/externals/images/notificationicon.png" width="20px" height="20px">
                        <span id="ynadvmenu_NotifyIconCount" class="ynadvmenu_NotifiIconWrapper" style="display: none;"><span id="ynadvmenu_NotifyCount"></span></span>
                    </a>
                    <div class="ynadvmenuMini_dropdownbox" id="ynadvmenu_notificationUpdates" style="display: none;">
                        <div class="ynadvmenu_dropdownHeader">
                            <div class="ynadvmenu_dropdownArrow"></div>
                        </div>
                        <div class="ynadvmenu_dropdownTitle">
                            <h3><?php echo $this->translate("Notifications") ?> </h3>
                        </div>
                        <div class="ynadvmenu_dropdownContent" id="ynadvmenu_updates_content">
                            <!-- Ajax get and out contetn to here -->
                        </div>
                        <div class="ynadvmenu_dropdownFooter">
                        <a class="ynadvmenu_seeMore" href="<?php echo $this->url(array('action' => 'notifications'),'ynresponsive_general')?>">
                                <span><?php echo $this->translate("See All Notifications") ?> </span>
                            </a>
                        </div>
                    </div>
                </div> <!--noti and msg-->
                
                <div title="<?php if($userdetails['profile_type'] == 'landlord' ): echo "Search for renters"; else: echo "Search for landlords"; endif;?>" id="fdg" class="ynadvmenu_mini_wrapper mob_bar_disable_particular_pages searchusers" data-toggle="modal" data-target="#searchUserModal" style="cursor:pointer;">
				<i class="fa fa-search" aria-hidden="true" style="font-size: 18px;padding: 2px 5px 0px 5px;"></i>
				</div>
            <?php endif; ?>
            <div class="user-profile dropdown">
            <?php
            if($this->viewer->getIdentity()) :
                { ?>
                    <?php
                    $img = $this->itemPhoto($this->viewer(), 'thumb.icon');
                    if($this->viewer()->getTitle() == 'admin')
                    {
                        echo "<div data-toggle='collapse' data-target='.user-profile-submenu' id='user-profile-info' class='user-profile-info collapsed '>" .$img. "<span>".$this->translate('Admin') . "</span><i class='ynicon-setting-w'></i></div>";
                     }
                    else
                    {
                       // echo "<div data-toggle='collapse' data-target='.user-profile-submenu' id='user-profile-info' class='user-profile-info collapsed mob_bar_iphone_ipad_disable'> <a href='".$this->baseUrl()."/profile/".$viewer->getIdentity()."'>  " .$img. "</a><span>".strip_tags($this->string()->truncate($this->viewer()->getTitle(), 20))."</span><i class='ynicon-setting-w'></i></div>";
                        echo "<div data-toggle='collapse' data-target='.user-profile-submenu' id='user-profile-info' class='user-profile-info collapsed'>" .$img. "<span>".strip_tags($this->string()->truncate($this->viewer()->getTitle(), 20))."</span><i class='ynicon-setting-w'></i></div>";
                    }
                }
                ?>

                <ul id="user-profile-submenu1" class="user-profile-submenu collapse dropdown-menu">

                    <?php foreach( $this->navigation as $item ): ?>
                    <li <?php if ($viewer && !$viewer->getIdentity()): ?> class="Login" <?php endif;?>>
                    <?php if($item->getLabel() == 'Sign Out'):?>
                     <?php echo $this->htmlLink($item->getHref(), $this->translate($item->getLabel()), array_filter(array(
                        'class' => ( !empty($item->class) ? $item->class.' tichatLogout' : null),
                        'alt' => ( !empty($item->alt) ? $item->alt : null ),
                        'target' => ( !empty($item->target) ? $item->target : null ),
                        ))) ?>
                    <?php else:  ?>
                        <?php echo $this->htmlLink($item->getHref(), $this->translate($item->getLabel()), array_filter(array(
                        'class' => ( !empty($item->class) ? $item->class : null ),
                        'alt' => ( !empty($item->alt) ? $item->alt : null ),
                        'target' => ( !empty($item->target) ? $item->target : null ),
                        ))) ?>
                    <?php endif;?>
                    </li>
                    <?php endforeach; ?>
                </ul>
            <?php else : ?>
                <?php if(Engine_Api::_() -> hasModuleBootstrap('social-connect')):?>
                    <div class="ynres-purity-social-connect">
                        <?php
                            $providers = Engine_Api::_() -> getDbTable('Services', 'SocialConnect') -> getServices(100, 1);
                            $base_path = $this -> layout() -> staticBaseUrl;
                            $numberOfShow = 3;
                            $total = $providers -> count();
                            $count = 0;
                            foreach ($providers as $o):
                                if($count < $numberOfShow):?>
                                <a class = "ynres-purity-icon-<?php echo $o -> name?>" title = "<?php echo $o -> title ?>" href="javascript: void(0);" onclick="javascript: sopopup('<?php echo $o -> getHref()?>')">
                                </a>
                        <?php endif; $count ++; endforeach;
                            if($total > $numberOfShow):
                                $count = 0;?>
                                <span class="ynres_purity_social_icon_more"><?php echo $this -> translate("more")?></span>
                                <ul class="ynres_purity_social_icons_sub">
                                    <?php foreach ($providers as $o):
                                        if($count >= $numberOfShow):?>
                                        <a class = "ynres-purity-icon-<?php echo $o -> name?>" title = "<?php echo $o -> title ?>" href="javascript: void(0);" onclick="javascript: sopopup('<?php echo $o -> getHref()?>')">
                                        </a>
                                    <?php endif; $count ++; endforeach;?>
                                </ul>
                        <?php endif;
                        ?>
                    </div>
                <?php endif;?>
                 <ul class="landing-navbar landing-white landing-card-2" id="myNavbar">
               <li><a href="/signup"><i class="fa fa-sign-in"></i> SIGN UP</a><a href="/login/return_url/64-Lw%3D%3D"><i class="fa fa-sign-in" style="padding-left:15px;"></i> SIGN IN</a></li>

                 </ul>
            <?php endif; ?>
        </div>
        <?php if ($viewer->getIdentity()): ?>
        <div class="mob_navbar">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
        </div>
        <?php endif;?>
        </div>
</div>
<!--<group mini menu end>-->
    <div class="navbar_header_middile_menus">
    <div class="collapse navbar-collapse col-lg-8 " id="myNavbar">
          <!-- Collect the nav links, forms, and other content for toggling -->
  <?php /* ============================ <div class="collapse navbar-collapse navbar-ex8-collapse"> ========================*/ ?>
  <!--<div class="header_main_menus">-->
    <ul class="nav navbar-nav " >
        <?php if (!$viewer->getIdentity()): ?>
            <?php if($this->search_check):?>
                <li class="global_search_form_nologin">
                    <form action="<?php echo $this->url(array('controller' => 'search'), 'default', true) ?>" method="get">
                        <input type='text' class='text suggested' name='query' size='20' maxlength='100' placeholder="<?php echo $this->translate('Enter keyword to search') ?>" />
                    </form>
                </li>
            <?php endif;?>
        <?php endif;?>
        <?php $count = 0;
        $limit = $this -> limit;
        if($this->viewer->getIdentity()) :
    ?>
      <li  class="my_profile"><a class="mob_bar_iphone_ipad menu_core_main" href="<?php echo $this->baseUrl().'/profile/'.$viewer->getIdentity(); ?>">MY PROFILE</a></li>

<?php foreach( $this->navigationMain as $item ): ?>
        <?php    if($profile_type_id == 4): ?>
        <?php    if($item->getLabel()=="Property"): ?>
        <li class="dropdown property-dropdown" >
          <a class="dropdown-toggle find_menu" data-toggle="dropdown" data-backdrop="static" data-keyboard="false" href="javascript:void(0)"  data-step="3" data-intro="<?php echo $introText['propertyText'];?>">
              <span class="caret1"><img src="/application/modules/User/externals/images/find.png" width="13px" height="13px" style="padding-bottom:2px;" class="mob_bar_iphone_ipad_disable"></span><?php echo strtoupper(" Property");?>
              <img src="/application/modules/User/externals/images/arrow.png" width="14px" height="10px" style="float: right; margin-top: 12px;"  class="mob_bar_iphone_ipad">
         </a>
          <ul class="dropdown-menu find_nav">
            <li><a href="<?php echo $this->baseUrl().'/addproperty'; ?>">Add Property</a></li>
            <li><a href="<?php echo $this->baseUrl().'/myproperties'; ?>">My Properties</a></li>
          </ul>
        </li>
        <?php endif; ?>
        <?php endif; ?>
        <?php    if($profile_type_id == 1): ?>
        <?php    if($item->getLabel()=="Application"): ?>
        <li class="dropdown application-dropdown">
          <a class="dropdown-toggle find_menu" data-toggle="dropdown" data-backdrop="static" data-keyboard="false" href="javascript:void(0)"  data-step="3" data-intro="<?php echo $introText['applicationText'];?>">
              <span class="caret1"><img src="/application/modules/User/externals/images/find.png" width="13px" height="13px" style="padding-bottom:2px;" class="mob_bar_iphone_ipad_disable"></span><?php echo strtoupper(" Application");?>
              <img src="/application/modules/User/externals/images/arrow.png" width="14px" height="10px" style="float: right; margin-top: 12px;"  class="mob_bar_iphone_ipad">
         </a>
          <ul class="dropdown-menu find_nav">
            <?php if($this->smartmoveRenterApiStatus == 1):?>
            <li><a href="<?php echo $this->baseUrl().'/credit/background'; ?>"> Credit and Background check</a></li>
            <?php else:?>
             <li><a href="<?php echo $this->baseUrl().'/renter/create'; ?>"> Credit and Background check </a></li>
             <?php endif; ?>
            <li><a href="<?php echo $this->baseUrl().'/property/requests'; ?>">My Rental Applications</a></li>
          </ul>
        </li>
        <?php endif; ?>
        <?php endif; ?>
            <?php    if($item->getLabel()!=="Find" && $item->getLabel()!=="Add Property"&& $item->getLabel()!=="Property" && $item->getLabel()!=="Application" ): ?>
            <?php
            $check_active = $item->active;
            $request = Zend_Controller_Front::getInstance()->getRequest();
            $module = $request->getModuleName();
            $module_class = explode("_", $item->class);
            if(end($module_class) == $module && $module != 'user' && $module != 'core')
            {
                $check_active = true;
            }
            if($count < $limit):
                 $attribs = array_diff_key(array_filter($item->toArray()), array_flip(array(
                    'reset_params', 'route', 'module', 'controller', 'action', 'type',
                    'visible', 'label', 'href'
                    )));
                ?>
             <li<?php echo($check_active?' class="active"':'')?>>
                <?php echo $this->htmlLink($item->getHref(), $this->translate(strtoupper($item->getLabel())), $attribs) ?>
            </li>
    <?php else:?>
         <?php if($count == $limit):?>
            <li class="dropdown">
                    <a href="#" class="dropdown-toggle" id="purity-dopdown-position" data-toggle="dropdown"><?php echo $this -> translate("More");?>
                        <span class="glyphicon glyphicon-chevron-down btn-xs"></span>
                    </a>
                    <ul class="dropdown-menu find_nav">
            <?php endif;?>
            <?php $attribs = array_diff_key(array_filter($item->toArray()), array_flip(array(
                        'reset_params', 'route', 'module', 'controller', 'action', 'type',
                        'visible', 'label', 'href'
                        )));
                    ?>
                 <li<?php echo($check_active?' class="active"':'')?>>
                    <?php echo $this->htmlLink($item->getHref(), $this->translate($item->getLabel()), $attribs) ?>
                </li>
            <?php if($count > $limit && $count == count($this->navigationMain)):?>
            </ul>
         </li>
            <?php endif;?>
            <?php endif;?>
        <?php endif;
        $count ++;
        endforeach;?>
      <li  class="support"><a class="mob_bar_iphone_ipad menu_core_main" href="<?php echo $this->baseUrl().'/support'; ?>">SUPPORT</a></li>
      <li  class="settings"><a class="mob_bar_iphone_ipad menu_core_main" href="<?php echo $this->baseUrl().'/members/settings/general'; ?>">SETTINGS</a></li>
      <li  class="logout"><a class="mob_bar_iphone_ipad menu_core_main tichatLogout" href="<?php echo $this->baseUrl().'/logout'; ?>">SIGN OUT</a></li>
       <?php endif;?>
    </ul>
    <?php
     $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
    ?>
     </div>
     </div>
     <?php if($this->viewer->getIdentity()) :?>
     <?php  if($dev_type == 1):?>
      <?php endif; ?>
      <?php endif; ?>
   </div>
<?php if($this->viewer->getIdentity()) :?>
        <div class="header_menu_statiticts_online mob_bar_disable" style="display:none">
        <div id="global_content" >
           <div class="ynadvmenu_notification"></div>
           <div class="statitics_bar" style="display:none"></div>
        </div>
        <div class="ynadvmenu_notification"></div>
    <div class="onlineusers_bar" style="display:none">
    <?php  if(count($this->paginator) > 0): ?>
     <?php
     $i=0;
     foreach( $this->paginator as $user ):
     $i= $i+1;
     if($i>40): break; endif;
     ?>
    <div class='whosonline_thumb'>
         <div class="led-green"></div>
      <?php echo $this->htmlLink($user->getHref(), $this->itemPhoto($user, 'thumb.icon', $user->getTitle()), array('title'=>$user->getTitle())) ?>
    </div>
  <?php endforeach; ?>
  <?php if($i>40):?>
  <div class="online_members_view_more"><a href="javascript:void(0)">View More</a></div>
   <?php endif; ?>
  <?php else: ?>
 <div style="margin-top: 12px;float: left;"> No Online Members </div>
  <?php endif; ?>
   <div class="online_icon" title="Online Members"><!--<i class="fa fa-ellipsis-h" aria-hidden="true" style="color: #f58410;;font-size: 21px;"></i>--><img src="/application/modules/User/externals/images/arrow.png" width="20px"></div>
    </div>
</div>
<!---- feed preference bar start -->
<?php if($page_url == '/members/home'):?>
<?php if(($userdetails['profile_type'] == 'landlord' ) && ($package_type == 'landlord_pro_package' || $package_type =='management_gold_package')): ?>
    <div class="feed_preference_content premium_user_feed_bar"  data-spy="affix" data-offset-top="100">
<?php else:?>
    <div class="feed_preference_content 11"  data-spy="affix" data-offset-top="100">
<?php endif;?>
    <div id="global_content" class="subheader_global_content">
    <div class="feed_preference_div landlord" >

    <?php if($dev_type== 2): // premium logo only for web?>
    
        <div style="float:left;    margin-top: 8px;"><a class="btn btn-large showmehow_btn mob_bar_disable" href="javascript:void(0);" onclick="javascript:introJs().start();">Show me how</a></div>
        <?php if(($userdetails['profile_type'] == 'landlord' ) && ($package_type == 'landlord_pro_package')): ?>
        <div style="float:left" title="Landlord Pro" class="premium_logo mob_bar_disable"><img src="/application/modules/User/externals/images/landlord_pro_logo.png"  width="50px" style="float: left;"></div>
       <?php endif;?>
        <?php if(($userdetails['profile_type'] == 'landlord' ) && ($package_type == 'management_gold_package')): ?>
        <div style="float:left" title="Management Gold" class="premium_logo mob_bar_disable"><img src="/application/modules/User/externals/images/management_gold_logo.png"  width="50px" style="float: left;"></div>
       <?php endif;?>

    <?php endif;?>
    <div class="feed_preference_div_inner">
         <?php //if($device_name != 'iPhone'):?>
        <div class="scout_board_div mob_bar_disable">Scoutboard</div>
        <?php //endif;?>
        <div class="create_preference_div" data-step="1" data-intro="<?php echo $introText['newScoutText'];?>">
        

        
                    <div  class="matches" data-toggle="modal" data-target="#matchesModal" style="float: left;cursor:pointer" title="Create Preference"><img src="/application/modules/User/externals/images/orangeandblack.jpg"  width="30px" style="float: left;">
                    <div style="float: left;padding-top: 7px;color: #f58410;" class="mob_bar_disable">New Scout</div>
                    </div>
               
       </div>


             <div class="feed_filtering_icon " style="padding: 6px 0px 0px 12px !important;" data-step="2" data-intro="<?php echo $introText['selectScoutText'];?>"> <!-- feed preference unit-->
                 <?php   if(($package_type == '' && $profile_type_id == 4 && $user_premiumLevelProvision == 2) || ($package_type == '' && $profile_type_id == 1)):?>
                           <div class="feedpreferenceunit_filtering" title="Search By Preference" data-toggle="modal" data-target="#preferenceModal"><?php if(isset($_SESSION['matching_array']['preference_name'])): echo $_SESSION['matching_array']['preference_name']; else: echo "Select Scout"; endif;?></div>
                  <?php else:?>
                           <div class="feedpreferenceunit_filtering" title="Search By Preference"  data-toggle="modal" data-target="#preferenceModalForPackageUpgraded"><?php if(isset($_SESSION['matching_array']['preference_name'])): echo $_SESSION['matching_array']['preference_name']; else: echo "Select Scout"; endif;?></div>

                <?php endif;?>
            </div>
         <?php // if(($userdetails['profile_type'] == 'tenant') ||($userdetails['profile_type'] == 'landlord' && ($package_type == 'landlord_pro_package' || $package_type == 'management_gold_package')) || ($user_premiumLevelProvision == 1)):?>
         <div class="prefernce_separator"> | </div>

       
        
        <!-- start location filter-->
        <div class="location_filter_dropdown_mobile"> 
        <?php if($this->location_text != ''):?>
            <?php if($dev_type == 1):?>
                     <div class="prefered_location_div change_location"  data-toggle="modal" data-target="#locationPreferenceDeviceModal">
                     <div class="prefered_location" title="Search By Location"><?php echo $this->location_text;?></div> <div class="prefered_location_img mob_bar_disable"><img src="/application/modules/User/externals/images/LOCATION.png"></div>
                    </div>
            <?php else: ?>
                    <div class="prefered_location_div change_location">
                     <div class="prefered_location" title="Search By Location"><?php echo $this->location_text;?></div> <div class="prefered_location_img"><img src="/application/modules/User/externals/images/LOCATION.png"></div>
                    </div>
            <?php endif;?>
        <?php else: ?>
        <?php if($dev_type == 1):?>
          <div  data-toggle="modal" data-target="#locationPreferenceDeviceModal" class="prefered_location_div change_location" title="Search By Location"><div class="prefered_location"> United States </div><div class="prefered_location_img mob_bar_disable"><img src="/application/modules/User/externals/images/LOCATION.png"></div></div>
         <?php else: ?>
         <div class="prefered_location_div change_location" title="Search By Location"><div class="prefered_location"> United States </div><div class="prefered_location_img"><img src="/application/modules/User/externals/images/LOCATION.png"></div></div>
        <?php endif;?>
         <?php endif; ?>
        <input type="hidden" class="location_country_name" value="<?php echo $_SESSION['country_name']?>">
        <input type="hidden" class="location_state_name" value="<?php echo $_SESSION['state_name'];?>">
        <input type="hidden" class="location_city_name" value="<?php echo $_SESSION['city_name'];?>">
        <input type="hidden" class="location_countryId" value="<?php echo $_SESSION['countryId']?>">
        <input type="hidden" class="location_stateId" value="<?php echo $_SESSION['stateId']; ?>">
        <input type="hidden" class="location_cityId" value="<?php echo $_SESSION['cityId'];?>">
        <input type="hidden" class="location_zipcode" value="<?php echo $_SESSION['zipcode'];?>">
        <input type="hidden" class="location_county" value="<?php echo  $_SESSION['county_name'];?>">
        <input type="hidden" class="location_neighborhood" value="<?php echo $_SESSION['neighborhood_name'];?>">
        <input type="hidden" class="location_set_to_usa" value="<?php echo $_SESSION['set_to_usa'];?>">
        <div class="filter_dropdown_mobile mob_bar_iphone_ipad" style="float: left;cursor: pointer;"><img src="/application/modules/User/externals/images/arrow.png" width="20px"></div>
        </div> <!-- end location filter-->
        
         <!-- start  price pets  no of bed rooms filter-->
            <div class="feed_filtering_icon_span mob_bar_iphone_ipad_disable"> 
             <ul class="feed_filtering_icon "> <!-- price icon-->
               <li class="side-padded margin_left">
                            <img src="/application/modules/User/externals/images/price_icon.png"  width="10px">
                            <span></span>
                               <select id="price_filtering_icon">
                                            <option value="">Price</option>

                                            <?php foreach($this->priceData as $data):?>
                                            <option value="<?php echo $data->price_from."-".$data->price_to ;?>"><?php echo $data->price_from." - ".$data->price_to;?></option>
                                            <?php endforeach; ?>
                               </select>
                    </li>
            </ul>
            <ul class="feed_filtering_icon "> <!-- pets-->
               <li class="side-padded margin_left">
                               <img src="/application/modules/User/externals/images/pets.png" width="15px">
                            <span></span>
                               <select id = "typeofpets_filtering_icon">
                                             <option value="">Pets</option>
                                             <option value="Cats">Cats</option>
                                             <option value="Dogs">Dogs</option>
                                             <option value="Cats & Dogs">Cats & Dogs</option>
                                             <option value="Birds">Birds</option>
                                             <option value="Small pets">Small pets</option>
                            </select>
                    </li>
            </ul>
             <ul class="feed_filtering_icon "> <!-- no of bed rooms-->
             <li class="side-padded margin_left">
                               <img src="/application/modules/User/externals/images/feed_bedroom.png" width="20px" >
                            <span></span>
                             <select id="noofbedrooms_filtering_icon">
                                             <option value="">bedroom</option>
                                             <option value="1">1</option>
                                             <option value="2">2</option>
                                             <option value="3">3</option>
                                             <option value="4">4</option>
                                             <option value="4+">4+</option>
                            </select>
                    </li>
            </ul>
            </div> <!-- end  price pets  no of bed rooms filter-->
            <?php //endif; ?>
            
         </div>
 </div>
 </div>
 </div>
<?php endif; ?>
<!-- feed preference bar end -->
<?php endif; ?>
<div class="modal fade" id="likeUserModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">

  <div class="modal-dialog" role="document">
    <div class="modal-content-new">
      <div class="modal-header">
        <span class="modal-title" id="exampleModalLabel">Saved Renters</span>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
       <div class="modal-body">
        <div class="error_msg" style="color:red"></div>
<?php if($profile_type_id==4): ?>
        <?php if(count($this->likeuserData) == 0):?>
            <div class="user_li">
            No Saved Renters
            </div>
        <?php else:?>
                <?php foreach($this->likeuserData as $data):?>
                <div class="user_li">
                    <span class="user_profile">
                    <?php $userTable = Engine_Api::_()->getDbtable('users', 'user');
                     $userData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $data['object_id']));
                   ?>
                   <?php echo $this->htmlLink($userData->getHref(), $this->itemPhoto($userData, 'thumb.icon', $userData->getTitle()), array('title'=>$userData->getTitle())) ?>

                   </span>

                   <span class="user_title">    <?php echo $userData->displayname;?> </span>
                   <div class="remove_saved_renter" user_id="<?php echo $data['object_id'];?>" title="Unsave"><i class="fa fa-times" aria-hidden="true"></i></div>
                   <hr>
                </div>

                <?php endforeach;?>

        <?php endif;?>
        <?php endif;?>
      </div>
    </div>
  </div>
</div>
<!-- like property modal start-->
<div class="modal fade" id="likePropertyModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content-new">
      <div class="modal-header">
        <span class="modal-title" id="exampleModalLabel">Saved Properties</span>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
       <div class="modal-body">
        <div class="error_msg" style="color:red"></div>
<?php  if($profile_type_id==1): ?>
        <?php if(count($this->likepropertyData) == 0):?>
            <div class="user_li">
            No Saved Properties
            </div>
        <?php else:?>
                <?php  foreach($this->likepropertyData as $data):?>
                <div class="property_li">
           <span class="feed_property_name">
         <?php
        $propertyTable =  Engine_Api::_()->getDbtable('propertylist', 'user');
        $propertyData =  $propertyTable->fetchRow($propertyTable->select()->where('id = ?', $data['object_id']));

        ?>

                        <a class="feed_property_name_link" href="<?php echo $this->baseUrl().'/property/'.$propertyData->id; ?>" title="View Property"><?php echo $propertyData->property_name;?> </a>


       </span>
      <span class="remove_saved_property" style="float:right;" property_id="<?php echo $data['object_id'];?>" title="Unsave"><i class="fa fa-times" aria-hidden="true"></i></span>
      <hr>
                </div>
                <?php endforeach; ?>
        <?php endif; ?>
        <?php endif;  ?>
      </div>
    </div>
  </div>
</div>

<!--end -->

<!--matches Modal start-->

<div class="modal fade" id="matchesModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content-new">
      <div class="modal-header">
        <span class="modal-title" id="exampleModalLabel"><a href="javascript:void(0)" target="_blank">New Scout</a></span>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
       <div class="modal-body">
            <div class="message" style="color:#333;padding: 0px 0px 8px 0px;display:block;">
          <?php if($profile_type_id == 4): ?>
            <?php if($user_premiumLevelProvision == 2):  // if premium level provision to all users disabled?>

                 <?php if($package_type == '' || $package_type == 'landlord_pro_package'): ?>
                 To continue, please upgrade your package. <a href="/support?page=upgradePackage">Upgrade Package</a>
                 <?php endif;?>

            <?php endif;?>
           <?php endif;?>
            </div>
            <div class="err_msg" style="color:red"></div>
<div class="matches_div">
    <input type="hidden" name="scoutcount" value="<?php echo $scoutCount;?>" class="scoutcount">
    <div class="pro_field_wrapper" style="margin-bottom:5px;" >
        <div class="prty_lablel pro_label scount_name_mob" style="padding-bottom:12px;">Scout Name <span style="color:red;font-weight: bolder;">*</span>  </div>
        <input type="text" name="scout_name" value="" class="scout_name prty_field">

   </div>
   <!--<br>-->
    <div class="pro_field_wrapper">
        <div class="prty_lablel pro_label scount_name_mob top_space_mob" style="padding-bottom:12px;">Housing Type</div>
        <input type="radio" name="housing_type" value="Apartment" style="margin-right:3px;margin-top: 4px;">
        <label class="radio_label" for="Apartment">Apartment</label>
        <input type="radio" name="housing_type" value="Room" style="margin-right:3px;margin-top: 4px;">
        <label class="radio_label" for="Room">Room</label>
        <input type="radio" name="housing_type" value="House" style="margin-right:3px;margin-top: 4px;">
        <label class="radio_label" for="House">House</label>
        <input type="radio" name="housing_type" value="Villa" style="margin-right:3px;margin-top: 4px;">
        <label class="radio_label" for="Villa">Villa</label>
   </div> <br>
   <!--<br>-->
    <div class="pro_field_wrapper top_space_mob"><div class="prty_lablel pro_label">Pets</div>  <select name="is_petsallowd" id="is_petsallowd"  class="prty_field" onchange="petsType()">
                                             <option value="">Select</option>
                                             <option value="Yes">Yes</option>
                                             <option value="No">No</option>
    </select></div>   <br>
    <div class="pets_type_wrapper" style="display:none">
    <div class="pro_field_wrapper"><div class="prty_lablel pro_label">Type of pets</div>
                             <select name="pets_type" id="pets_type"  class="prty_field">
                                             <option value="">Select pets type</option>
                                             <option value="Cats">Cats</option>
                                             <option value="Dogs">Dogs</option>
                                             <option value="Cats & Dogs">Cats & Dogs</option>
                                             <option value="Birds">Birds</option>
                                             <option value="Small pets">Small pets</option>
                             </select>
                             </div>   <br>
        </div>
    <div class="pro_field_wrapper"><div class="prty_lablel pro_label">Number Of Bedrooms</div>

    <select id="number_of_rooms" class="prty_field">

                                             <option value="">Select</option>
                                             <option value="1">1</option>
                                             <option value="2">2</option>
                                             <option value="3">3</option>
                                             <option value="4">4</option>
                                             <option value="4+">4+</option>
    </select>
    </div>   <br>
    <div class="pro_field_wrapper" style="overflow: hidden;"><div class="prty_lablel pro_label">Rent per Month</div>
    <input type="text" class="price_range_from prty_field" style="float:left" placeholder="Price">
    <span class="price_range_to_div" style="display:none">
        <span class="to_span">To</span>
     <input type="text" class="price_range_to prty_field" placeholder="Price">
     </span>
        <div class="price_range_span_link" style="float:left;padding-top: 3px;margin-left: 4px;">
            <a href="javascript:void(0)" class="price_range_link">
                        <img src="/application/modules/User/externals/images/add_range.png" alt="" title="Add Range" >
            </a>
        </div>

        </div> <br>

       <?php if($page_url == '/members/home'):?>

        <div class="pro_field_wrapper">
         <div class="prty_lablel pro_label">Location<span style="color:red;font-weight: bolder;">*</span> </div>
        <input id="autocomplete1" class="preference_place prty_field" placeholder="Enter Location" type="text">
        <input type="hidden" class="new_preference_street" id="street_number" ></input>
        <input type="hidden" class="new_preference_route" id="route"></input>
        <input type="hidden" class="new_preference_neighborhood" id="neighborhood" ></input>
        <input type="hidden" class="new_preference_city" id="locality"></input>
        <input type="hidden" class="new_preference_sublocality_level_1 county" id="sublocality_level_1"></input>
        <input type="hidden" class="new_preference_state" id="administrative_area_level_1">
        <input type="hidden" class="new_prefernce_zip" id="postal_code">
        <input type="hidden" class="new_preference_country" id="country">
        <input type="hidden" class="new_preference_latitude" id="latitude">
        <input type="hidden" class="new_preference_longitude" id="longitude">
        </div> <br>
        <?php endif;?>
      </div>

       <div class="matches_btn_div"><input class="submit_matches" type="button" value="Save" name=""></div>

      </div>
            <div class="loader submit_matches_loader" style="display:none"></div>
    </div>
  </div>
</div>

<!--matches Modal end-->
<!-- gallery add photo modal start-->
<div class="modal fade" id="addphotoModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content-new">
      <div class="modal-header">
        <span class="modal-title" id="exampleModalLabel">Add Photo</span>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
       <div class="modal-body">
           <div class="error_msg" style="color:red"></div>

            <form method="POST" enctype="multipart/form-data" action="<?php echo $this->baseUrl().'/user/index/savegalleryphoto' ?>" class="photo_upload_frm">
                <div class="folder_name_input">
                    <input type="hidden" class="subject_id" name="subject_id" value="<?php echo $this->subjectId;?>">
                    <div>Title</div>
                    <div style="margin-bottom: 12px;margin-top: 2px;">
                    <input type="text" class="upload_image_title" name="upload_image_title" maxlength="30">
                    </div>
                    <input type="file" class="upload_image" name="upload_image">
                    <div>only JPG, JPEG, and PNG  files are allowed.</div>
                    <div class="confirm_btns" style="text-align: left;">
                    <input type="submit" value="Save" class="image_upload_submit_btn" style="width: 134px;">
                   </div>
                   </div>
            </form>
        <div class="loader" style="display:none;width: 81px;height: 46px;"></div>
      </div>
    </div>
  </div>
</div>
<!-- gallery add photo modal end-->
<!-- gallery manage photo modal start-->
<div class="modal fade" id="deletephotoModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content-new">
      <div class="modal-header">
        <span class="modal-title" id="exampleModalLabel">Manage Photo</span>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
       <div class="modal-body">
           <div class="error_msg" style="color:red"></div>
           <div class="modal-body-content">
           </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary yes_btn yes_delete_photo">Delete</button>
        <div class="loader" style="display:none;width: 81px;height: 46px;"></div>
      </div>
    </div>
  </div>
</div>
<!-- gallery manage photo modal end-->

<!--preference modal -->
 <div class="modal fade" id="preferenceModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content-new">
      <div class="modal-header">
        <span class="modal-title" id="exampleModalLabel">Select Scout</span>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
       <div class="modal-body">
           <div class="message" style="color:#333;padding: 0px 0px 8px 0px;">
           <?php if($profile_type_id == 4):?>

             <?php if($user_premiumLevelProvision == 2):  //if premium level provision to all users disabled  ?>
                 <?php if($package_type == '' || $package_type == 'landlord_pro_package'): ?>
                 Please upgrade your package to create more scout. <a href="/support?page=upgradePackage">Upgrade Package</a>
                 <?php endif;?>
             <?php endif;?>

           <?php endif;?>
           </div>
        <div class="error_msg" style="color:red"></div>
           <?php if(!empty($this->FeedPreferenceUnitData)):
           $i=0;
           foreach($this->FeedPreferenceUnitData as $data):
            $i++;
            ?>
            <div class="preference_li preference_li_<?php echo $data['id']; ?>" >
           <div class="preference_unit preference_unit_<?php echo $i;?>" style="float:left;cursor: pointer;" value="<?php echo $i;?>" preference_number="<?php echo $i;?>" feedpreferenceunitid = "<?php echo $data['id'];?>">
                <?php echo $data['scout_name'];?>
           </div>
           <div class="scout_options">
           <div data-toggle="modal" data-target="#editPreferenceModal" class="edit_preference" li_count="<?php echo $i;?>" preferenceId = "<?php echo $data['id']; ?>">Edit</div>

           <div class="remove_preference" preferencename= "<?php echo 'Preference '.$i;?>" remove_preference_id="<?php echo $data['id']; ?>" style="float:right;cursor: pointer;"><i class="fa fa-times" aria-hidden="true"></i></div>
           </div>
            <hr style="clear:both">
            <br>
            </div>
            <?php endforeach; ?>
            <?php endif;?>
            <span class="preference_msg">
            <?php
             if(count($this->FeedPreferenceUnitData)==0):
            echo "No Preferences";
            endif;
              ?>
           </span>
      </div>
    </div>
  </div>
</div>

<!--preference modal end -->

<!--preferenceModalForPackageUpgraded  modal -->
<div class="modal fade" id="preferenceModalForPackageUpgraded" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content-new">
      <div class="modal-header">
        <div class="modal-title" id="exampleModalLabel">Select Scout</div>
        <div class="search_content">
          <?php if($profile_type_id == 4):?>
                <?php if(($user_premiumLevelProvision == 1) || ($package_type == 'management_gold_package') ): ?>
                 <div class="scout_filter" style="text-align: right;">
                     <span class="prty_lablel">Scout Name </span>
                      <input id="scouttags" type="text">
                 </div>
               <?php endif;?>
             <?php endif;?>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">

          <span aria-hidden="true">&times;</span>
        </button>
        </div>
      </div>


       <div class="modal-body">
            <div class="location_fields"></div>
           <?php if($profile_type_id == 4):?>
           <div class="message" style="color:#333;padding: 0px 0px 8px 0px;">
               <?php if($user_premiumLevelProvision == 2):  //if premium level provision to all users disabled  ?>
                 <?php if($package_type == '' || $package_type == 'landlord_pro_package'): ?>
                 Please upgrade your package to create more scout. <a href="/support?page=upgradePackage">Upgrade Package</a>
                 <?php endif;?>
               <?php endif;?>
           </div>
           <?php endif;?>
        <div class="error_msg" style="color:green"></div>
        <?php /* if($profile_type_id == 4):?>
         <?php if($user_premiumLevelProvision == 1 || $package_type == 'management_gold_package'):  //if premium level provision to all users disabled  ?>

               <div style="padding: 12px;">
                   <div class="pro_field_wrapper" style="margin-bottom: 12px;">
                                <span class="prty_lablel pro_label">Property Name </span>
                                    <select name="preference_property_id" id="preference_property_id"  class="prty_field input-box">
                                         <option value="">Select property</option>
                                         <?php foreach($this->propertyListsData as $lists):?>
                                         <option value="<?php echo $lists['id']?>"><?php echo $lists['property_name'];?></option>
                                         <?php endforeach;?>
                                    </select>

                   </div>
                   <div class="pro_field_wrapper" style="margin-bottom: 12px;">
                                <span class="prty_lablel pro_label">Address </span>
                                <input name="preference_addess" type="text" maxlength="65" placeholder="Address" id="autocomplete3" class="prty_field input-box" autofocus="">
                   </div>
                   <div class="pro_field_wrapper">
                        <span class="prty_lablel pro_label" style="color:#fff">Address </span>
                        <input class="but_submit_preference" type="button" value="Filter" name="">
                   </div>
               </div>

              <?php endif;?>
            <?php endif;*/?>
           <div class="package_head">
               <div style="float:left">
               <?php
                    if($package_type == 'landlord_pro_package'):
                      echo "Landlord Pro";
                     endif;
                     if($package_type == 'management_gold_package'):
                      echo "Management Gold";
                     endif;

                    ?>
               </div>

           </div>
           <div class="preference_content">

           <?php
            $i=0;
            foreach($this->FeedPreferenceUnitData as $data):
            $i++;
            ?>
            <div class="preference_li preference_li_<?php echo $data['id']; ?>" >
              <div class="preference_scout_name preference_scout_name_<?php echo $i; ?>"><?php echo $data['scout_name'] ." :"?></div>
              <div class="preference_unit preference_unit_<?php echo $i; ?>" style="float:left;cursor: pointer;" value="<?php echo $i;?>" preference_number="<?php echo $i;?>" feedpreferenceunitid = "<?php echo $data['id'];?>">
             <?php if($data['stateName']  != '' || $data['cityName']  != ''  || $data['countyName']  != '' || $data['neighborhoodName']  != ''):?>
              <span style="margin-right: 12px;">
                <?php if($data['stateName']  != '' ):
                      echo $data['stateName'] ." ";
                      endif;
                      if($data['cityName']  != '' && $data['cityName'] != $data['stateName']):
                      echo $data['cityName']." ";
                      endif;
                      if($data['countyName']  != '' && $data['countyName'] != $data['cityName']):
                      echo $data['countyName']." ";
                      endif;
                      if($data['neighborhoodName']  != '' ):
                      echo $data['neighborhoodName']." ";
                      endif;
                 ?>

              </span>
              <?php endif;?>
               <?php if($data['number_of_rooms']  != ''  || $data['housing_type']  != ''): ?>
              <span style="margin-right: 12px;">
                  <?php if($data['number_of_rooms']  != '' ):
                       echo $data['number_of_rooms']." ";
                       endif;
                       if($data['housing_type']  != '' ):
                       echo $data['housing_type']." ";
                       endif;
                   ?>
            </span>
            <?php endif;?>
            <?php if($data['is_petsallowd']  != '' ):?>
             <span style="margin-right: 12px;">
                 <?php
                       if($data['is_petsallowd']  != '' ):
                           if($data['is_petsallowd'] == 'No'):
                              echo "No pets";
                           else:
                             echo "Pets";
                           endif;
                       endif;
                     ?>
              </span>
              <?php endif;?>
              <?php  if($data['pets_type']  != '' ):?>
              <span style="margin-right: 12px;">
                  <?php
                       if($data['pets_type']  != '' ):
                       echo $data['pets_type'];
                       endif;
                     ?>
              </span>
              <?php endif;?>
              <?php  if($data['price']  != '0' ):?>
              <span style="margin-right: 12px;">
                  <?php
                       if($data['price']  != '' && $data['price_to'] == '0'):
                       echo " $".$data['price'];
                       endif;
                       if($data['price']  != '' && $data['price_to'] != '0'):
                       echo " $".$data['price']." - $".$data['price_to'];
                       endif;
                     ?>
              </span>
              <?php endif;?>
           </div>
           <div class="scout_options">
           <div data-toggle="modal" data-target="#editPreferenceModal" class="edit_preference" li_count="<?php echo $i;?>" preferenceId = "<?php echo $data['id']; ?>">Edit</div>
           <div class="remove_preference" preferencename= "<?php echo 'Preference '.$i;?>" remove_preference_id="<?php echo $data['id']; ?>" style="float:right;cursor: pointer;"><i class="fa fa-times" aria-hidden="true"></i></div>
           </div>
            <br>
            </div>
            <?php endforeach; ?>

            <?php if(count($this->FeedPreferenceUnitData)==0): ?>
              <div class="preference_msg" style="padding:12px">
                 No Preferences
              </div>
             <?php endif; ?>

              </div>


      </div>
    </div>
  </div>
</div>
<!--preference modal end -->

<!-- edit preference Modal-->

<div class="modal fade" id="editPreferenceModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content-new">
      <div class="modal-header">
        <span class="modal-title" id="exampleModalLabel"><a href="javascript:void(0)" target="_blank">Edit Scout</a></span>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
       <div class="modal-body">
          <div class="message" style="padding:12px 0px 12px 0px;color:#008000"></div>
      <div class="matches_div">



      </div>
       <?php if($page_url == '/members/home'):?>
       <div class="pro_field_wrapper">
         <div class="prty_lablel pro_label">Location<span style="color:red;font-weight: bolder;">*</span>  </div>
        <input id="autocomplete4" class="edit_preference_place prty_field" placeholder="Enter Location" type="text">
        <input type="hidden" class="new_preference_street" id="street_number" ></input>
        <input type="hidden" class="new_preference_route" id="route"></input>
        <input type="hidden" class="new_preference_neighborhood" id="neighborhood" ></input>
        <input type="hidden" class="new_preference_city" id="locality"></input>
        <input type="hidden" class="new_preference_sublocality_level_1 county" id="sublocality_level_1"></input>
        <input type="hidden" class="new_preference_state" id="administrative_area_level_1">
        <input type="hidden" class="new_prefernce_zip" id="postal_code">
        <input type="hidden" class="new_preference_country" id="country">
        <input type="hidden" class="new_preference_latitude" id="latitude">
        <input type="hidden" class="new_preference_longitude" id="longitude">
        </div> <br>
        <?php endif;?>
       <div class="matches_btn_div">
             <div class="pro_field_wrapper"><div class="prty_lablel pro_label" style="color:#fff">zfxvs</div>
           <input class="edit_preference_submit" type="button" value="Save" name="">

           </div>
           </div>

      </div>
            <div class="loader submit_matches_loader" style="display:none"></div>
    </div>
  </div>
</div>

<!-- edit preference Modal-->


<!--fcra modal-->

<div class="modal fade" id="fcraModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content-new">
      <div class="modal-header">
        <span class="modal-title" id="exampleModalLabel">MANDATORY TERMS FOR EACH CONSUMER</span>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
       <?php if($page_url=='/addproperty' ||  strpos( $page_url, "/property/edit/")!== false || $page_url=='/renter/create' || $page_url=='/renter/update'):
       echo $this->render('fcra.tpl');
        endif;
        ?>
      </div>
</div>
</div>
</div>
<!--end fcra modal-->
<!--delete requirement modal start-->
<div class="modal fade" id="requirementDeleteModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <span class="modal-title" id="exampleModalLabel">Confirm</span>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        </div>
        <div class="modal-body">
          Do you want to delete this property requirement?
        </div>
        <div class="modal-footer">
        <button type="button" class="btn btn-primary yes_btn yes_delete_requirement">Yes</button>
      </div>
    </div>
  </div>
</div>
<!--delete requirement modal end-->

<!--delete feed comment delete modal start-->
<div class="modal fade" id="DeletecommentModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <span class="modal-title" id="exampleModalLabel">Confirm</span>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        </div>
        <div class="modal-body">
          Do you want to delete this comment?
        </div>
        <div class="modal-footer">
        <button type="button" class="btn btn-primary yes_btn yes_delete_comment">Yes</button>
      </div>
    </div>
  </div>
</div>
<!--delete feed comment delete modal end-->
<!--success modal-->

<div class="modal fade" id="successModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content-new">
      <div class="modal-header">
        <span class="success_message" id="exampleModalLabel" style="text-align:center;"></span>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>

</div>
</div>
</div>
<!--end success modal-->
<!--searchUserModal modal-->
<div class="modal fade" id="searchUserModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <span class="modal-title" id="exampleModalLabel"><?php if($userdetails['profile_type'] == 'landlord' ): echo "Search for renters"; else: echo "Search for landlords"; endif;?></span>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        </div>
        <div class="modal-body">
           <div class="pro_field_wrapper" style="text-align: center;float:none">
			   
              <input id="user_search_input" class="prty_field input-box" type="text" placeholder ="<?php if($userdetails['profile_type'] == 'landlord' ): echo "Search for renters"; else: echo "Search for landlords"; endif;?>">
              </div>
        </div>
        
    </div>
  </div>
</div>
<!--end searchUserModal modal-->
<!--check smartmove renter modal start-->
<div class="modal fade" id="SmartmoverenterModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <span class="modal-title" id="exampleModalLabel">Confirm</span>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        </div>
        <div class="modal-body">
          Please create valid renter record and then try to submit application
        </div>
        <div class="modal-footer">
        <button type="button" class="btn btn-primary yes_btn yes_smartmoverenter">Yes</button>
      </div>
    </div>
  </div>
</div>
<!--check smartmove renter modal end-->




<!--check onetime Application Modal  start-->
<div class="modal fade" id="onetimeApplicationModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <span class="modal-title" id="exampleModalLabel">Confirm</span>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        </div>
        <div class="modal-body">
          Please complete the one time application
        </div>
        <div class="modal-footer">
        <button type="button" class="btn btn-primary yes_btn yes_onetimeApplication">Yes</button>
      </div>
    </div>
  </div>
</div>
<!--check onetime Application Modal  end-->
<!--location preference device modal-->
<div class="modal fade" id="locationPreferenceDeviceModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <span class="modal-title" id="exampleModalLabel">Enter Location</span>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        </div>
            <div class="modal-body">
                <div class="message" style="color:red"></div>
              <div class="map_location_div_location" style="padding: 4px;">

              </div>
              <div class="pro_field_wrapper" style="margin-bottom:5px;">
         <div class="prty_lablel pro_label scount_name_mob" style="padding-bottom:12px;">Location</div>
        <input id="autocomplete2" class="locationPreference_place prty_field" placeholder="Enter Location" type="text">
         </div>
              <div class="pro_field_wrapper" style="margin-top: 12px;">
                  <input type="checkbox" name="set_to_usa" value="2" id="set_to_usa" style="width: 21px;">
              <span class="prty_lablel">&nbsp;Reset to USA </span></div>
            <div class="modal-footer" style="padding: 0px;">
                 <div class="map_options">
                    <div class="set_location_btn_div"><input class="set_location" type="button" value="Save" name=""></div>
                    <div class="set_location_loader loader" style="display:none"></div>
               </div>
          </div>
    </div>
  </div>
</div>
</div>
<!--location preference device modal  end-->


<!--video payment modal-->

<div class="modal fade" id="videopaymentModal" style="z-index: 1000;" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content-new">

     <div class="modal-header" style="text-align:center;">
        <span class="modal-title" id="exampleModalLabel">Payment Process</span>
        <span class="package_message" id="exampleModalLabel" style="text-align:center;"></span>

        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>

      </div>

      <div class="modal-body">

                <div class="package1 landlord_pro_package">
                     <div class="part2">
                      <span style="font-size: 20px;"><?php  echo '$' . $settings->user_videoPrice ; ?></span><br>
                      <span style="color: #999;">per month </span>
                    </div>
                </div>
        <div class="payment-errors" style="color:red;text-align:center"></div>

                <div class="payment_content_div">



    <form method="POST" id="payment-form">


    <div class="pro_field_wrapper">

                    <input name="cardholder_name" type="text" maxlength="65" placeholder="First Name" id="cardholder_name" class="prty_field input-box" autofocus data-stripe="name">
                    <span class="device_star" style="color:red;font-weight: bolder;">*</span>
    </div> <br>
    <div class="pro_field_wrapper">

                    <input name="last_name" type="text" maxlength="65" placeholder="Last Name" id="last_name" class="prty_field input-box" autofocus data-stripe="number">
                    <span class="device_star" style="color:red;font-weight: bolder;">*</span>
     </div> <br>

    <div class="pro_field_wrapper">
                <select name="LandlordState" id="LandlordState"   class="prty_field input-box">
                    <option value="">Select State</option>

                    <?php  foreach($StateArray as $key =>$value):?>
                                                         <option value="<?php echo $key;?>"><?php echo $value;?></option>
                    <?php endforeach;  ?>



                </select>
              <span class="device_star" style="color:red;font-weight: bolder;">*</span>

    </div> <br>
        <div class="pro_field_wrapper">

                <select name="LandlordCity" id="LandlordCity"  class="prty_field input-box" maxlength="50">
                <option value="">Select City</option>
                    </select>
                <span class="device_star" style="color:red;font-weight: bolder;">*</span>
    </div> <br>

    <div class="pro_field_wrapper">
                    <input name="street" type="text" maxlength="65" placeholder="Street" id="street" class="prty_field input-box" autofocus data-stripe="number">
                    <span class="device_star" style="color:red;font-weight: bolder;">*</span>
    </div> <br>


    <div class="pro_field_wrapper">
                    <input name="zipcode" type="text" maxlength="5" placeholder="Zipcode" id="zipcode" class="prty_field input-box" autofocus data-stripe="number">
                    <span class="device_star" style="color:red;font-weight: bolder;">*</span>
    </div> <br>

    <div class="pro_field_wrapper">
                    <input name="card_number" type="text" maxlength="65" placeholder="Card Number" id="card_number" class="prty_field input-box" autofocus data-stripe="number">
                   <span class="device_star" style="color:red;font-weight: bolder;">*</span>
    </div> <br>
    <div class="pro_field_wrapper">
                    <input name="expiration_month" type="text" maxlength="2" placeholder="Expiration (MM)" id="expiration_month" class="prty_field input-box" autofocus size="2" data-stripe="exp_month">
                   <span class="device_star" style="color:red;font-weight: bolder;">*</span>
                   </div> <br>
      <div class="pro_field_wrapper">
                   <input name="expiration_year" type="text" placeholder="Expiration (YY)" id="expiration_year" maxlength="2" size="2" data-stripe="exp_year" class="prty_field input-box">
                   <span class="device_star" style="color:red;font-weight: bolder;">*</span>
    </div> <br>
    <div class="pro_field_wrapper">
                    <input name="expiration" type="text" maxlength="4" placeholder="CVC" id="expiration" class="prty_field input-box" autofocus size="4" data-stripe="cvc">
                    <span class="device_star" style="color:red;font-weight: bolder;">*</span>
    </div> <br>

    <input type="hidden" value="" name="selected_packagerate" class="selected_packagerate">
    <input type="hidden" value="" name="selected_package" class="selected_package">
    <input type="hidden" value="0" name="score" class="score">

    <div class="pro_field_wrapper">
    <span class="prty_lablel pro_label"></span>
   <input type="submit" class="submit submit_payment" value="Submit Payment">
   <div class="loader" style="display:none;"></div>


    </form>

     </div>
    </div>
    </div>
    <div style="text-align: center;padding: 12px;">
    <img src="/application/modules/User/externals/images/mc_vrt_opt_pos_73_1x.png" width="" height="" >
    <img src="/application/modules/User/externals/images/visa-us-vector-logo.png" width="62px" height="" >
    </div>
    <!-- Begin DigiCert site seal HTML and JavaScript -->
		<div id="DigiCertClickID_g3wGrxJ9" data-language="en">
		     <a href="https://www.digicert.com/ev-ssl-certification.htm"></a>
		</div>
  </div>
 </div>
</div>
<!--end video payment modal-->







<!--start scheduler modal-->
<?php if($page_url=='/scheduler/meetings/requests' || $page_url=='/scheduler/meetings'): ?>
<div class="modal fade" id="schedulerModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content-new">
      <div class="modal-header">
        <span class="modal-title" id="exampleModalLabel">Schedule meeting</span>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
       <div class="modal-body">
           <div class="error_msg" style="color:red"></div>


       <form method="POST" enctype="multipart/form-data" action="<?php echo $this->baseUrl().'/user/index/schedulemeeting' ?>" class="photo_upload_frm">
            <div class="message" style=color:red></div>

            <div class="pro_field_wrapper">
            <span class="prty_lablel pro_label" ></span>
              <!--  <input type="text" id="datepicker" class="prty_field" placeholder="date">-->

            <div class="demo pro_field_wrapper">
                <div class="inner_wrapper">
                <span class="demo pro_field_wrapper" id="datepicker"></span>
                </div>
            </div>
            </div>
            <br>
             <div class="pro_field_wrapper">

                 <span class="prty_lablel pro_label" ></span>
                  <input type="text" id="timepicker" class="prty_field" placeholder="time">
                  <span class="hidden_values">
                  <input type="hidden" id="meetingscheduled_with">
                  <input type="hidden" id="meetingrescheduledby_renter">
                  <input type="hidden" id="data_id">
                  <input type="hidden" id="property_id">
                  </span>
            </div>
            <br>
            <div class="pro_field_wrapper">
                <span class="prty_lablel pro_label"></span>
            <button class="scheduler_submit_btn" type="button" value="Save" style="background-color: #F5840F !important;" name="">Submit</button>
            </div><br>
       </form>


        <div class="loader" style="display:none;width: 81px;height: 46px;"></div>
      </div>
    </div>
  </div>
</div>
<?php endif; ?>
<!--end scheduler modal-->

<!--intro confirm modal start-->
<div class="modal fade" id="introModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <span class="modal-title" id="exampleModalLabel">Confirm</span>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        </div>
        <div class="modal-body" style="text-align: center">
          Would you like to see a walkthrough ?
        </div>
        <div class="modal-footer" style="text-align: center !important;">
        <button type="button" class="btn btn-primary yes_btn yes_intro">Yes</button>
        <button type="button" class="btn btn-primary yes_btn skip_intro">Skip</button>
      </div>
    </div>
  </div>
</div>
<!--intro confirm modal end-->

<script type="text/javascript">
     var __dcid = __dcid || [];__dcid.push(["DigiCertClickID_g3wGrxJ9", "10", "m", "black", "g3wGrxJ9"]);
     (function(){var cid=document.createElement("script");
     cid.async=true;
     cid.src="https://seal.digicert.com/seals/cascade/seal.min.js";
     var s = document.getElementsByTagName("script");
     var ls = s[(s.length - 1)];
     ls.parentNode.insertBefore(cid, ls.nextSibling);
     }());
</script>



<script type="text/javascript" src="https://js.stripe.com/v2/"></script>
<script type='text/javascript'>
var jQueryclick=jQuery.noConflict();

var dev_type='<?php echo $dev_type; ?>';
jQuery( ".layout_ynresponsivepurity_mini_menu #global_search_form .glyphicon-search" ).click(function() {
   jQuery('#global_search_form').submit();
});
 var profile_type_id='<?php echo $profile_type_id; ?>';
 var viewer ='<?php echo $viewer->getIdentity(); ?>';

jQuery('body').on('click', '.header_statitics_online_menu', function(event){
    if(!jQuery('.header_statitics_online_menu').hasClass('active')){
    jQuery('.header_menu_statiticts_online').css('display','block');
    jQuery('.onlineusers_bar').css('display','none');
    jQuery('.statitics_bar').css('display','block');
    jQuery('.header_statitics_online_menu').addClass('active');
    jQuery('.online_icon').removeClass('active');
    }
    else{
    jQuery('.header_menu_statiticts_online').css('display','none');
    jQuery('.onlineusers_bar').css('display','none');
    jQuery('.statitics_bar').css('display','none');
    jQuery('.header_statitics_online_menu').removeClass('active');
    }
});
jQuery('body').on('click', '.online_icon', function(event){
    if(!jQuery('.online_icon').hasClass('active')){
    jQuery('.header_menu_statiticts_online').css('display','block');
    //jQuery('.statitics_bar').css('display','none');
    jQuery('.onlineusers_bar').css('display','block');
    jQuery('.online_icon').addClass('active');
    }
    else{
    jQuery('.statitics_bar').css('display','block');
    jQuery('.onlineusers_bar').css('display','none');
    jQuery('.online_icon').removeClass('active');
    }
});
jQuery('body').on('click', '.online_members_view_more', function(event){
    jQuery('.online_members_view_more').fadeOut();
    jQuery('.layout_user_online_members').css('display','block');
});

jQuery(document).ready(function(){


    //var details=userpackagestatus(viewerId);
    //console.log(details);
    //alert(details);
    //alert(details.video_payment);
//  var viewer_video_payment=details.video_payment;
//  alert(viewer_video_payment);




    jQuery('.navbar_header_middile_menus #myNavbar').css('display','none');
    jQuery('.layout_core_statistics .ybo_headline h3').append('<span class="arrow2 stat"><img style="width: 20px; margin-left: 7px; " src="application/modules/User/externals/images/down-arrow.svg"></span>');
    jQuery('.layout_core_statistics > ul').css('display','none');
    <?php if( $profile_type_id == 4):?>
    var Renters = '<?php echo $this->tenantsCount;?>';
    var Propertymatch = '<?php echo $this->matching_requirementsCount;?>';
    var mypropertiesCount = '<?php echo $this->mypropertiesCount;?>';
    var mydocumentsCount = '<?php echo $this->mydocumentsCount;?>';
    jQuery('.statitics_bar').append('<span class="heading">Snapshot</span><span class="sub_heding">Renters : </span><span class="count">'+ Renters + '</span><span class="sub_heding"> Post match</span><span class="count"> : '+Propertymatch+ '</span><span class="sub_heding"> Properties :</span><span class="count"> '+ mypropertiesCount + '</span>');
    <?php elseif( $profile_type_id == 1):?>
    var landlordCount = '<?php echo $this->landlordCount;?>';
    var matchingPropertiesCount = '<?php echo $this->matchingPropertiesCount;?>';
    var propertyCount = '<?php echo $this->propertyCount;?>';
    var mydocumentsCount = '<?php echo $this->mydocumentsCount;?>';
    jQuery('.statitics_bar').append('<span class="heading">Snapshot</span><span class="sub_heding">Landlords : </span><span class="count">'+ landlordCount + '</span><span class="sub_heding"> Post match</span><span class="count"> : '+matchingPropertiesCount+ '</span><span class="sub_heding"> Properties :</span><span class="count"> '+ propertyCount + '</span>');
    <?php else:?>
    var member_count = '<?php echo $this->member_count;?>';
    var landlordCount = '<?php echo $this->landlordCount;?>';
    var tenantsCount = '<?php echo $this->tenantsCount;?>';
    jQuery('.statitics_bar stat').append('<span class="heading">Snapshot</span><span class="sub_heding">Members : </span><span class="count">'+ member_count + '</span><span class="sub_heding"> Landlords</span><span class="count"> : '+landlordCount+ '</span><span class="sub_heding"> Renters :</span><span class="count"> '+ tenantsCount + '</span>');
    <?php endif;?>
    jQuery('.statitics_bar').append('<span class="online_icon" title="Online Members"><i style="font-size: 16px;"><img src="/application/modules/User/externals/images/arrow.png" width="14px"></i></span>');
    jQuery( ".filter_dropdown_mobile" ).click(function() {
        if(jQuery( ".filter_dropdown_mobile" ).hasClass("mobile_dropdown")){
             jQuery('.feed_filtering_icon_span.mob_bar_iphone_ipad_disable').css('display', 'none');
            jQuery( ".filter_dropdown_mobile" ).removeClass("mobile_dropdown");
        }
        else
        {
            jQuery( ".filter_dropdown_mobile" ).addClass("mobile_dropdown");
             jQuery('.feed_filtering_icon_span.mob_bar_iphone_ipad_disable').css('display', 'block');
        }
    });
    

});

var current_url = '<?php echo $page_url;?>';
 if(current_url == '/tenants' || current_url == '/landlords' || current_url == '/services' || current_url == '/properties' ){
     jQuery( ".dropdown.find-dropdown" ).addClass( "active" );
 }


if(current_url == '/landlords'){
    jQuery( ".dropdown.find-dropdown li:first-child" ).addClass( "active" );
}
if(current_url == '/tenants'){
    jQuery( ".dropdown.find-dropdown li:nth-child(2)" ).addClass( "active" );
}
if(current_url == '/services'){
    jQuery( ".dropdown.find-dropdown li:nth-child(3)" ).addClass( "active" );
}
if(current_url == '/properties'){
    jQuery( ".dropdown.find-dropdown li:nth-child(4)" ).addClass( "active" );
}
if(current_url == '/addproperty'){
    jQuery( ".dropdown.property-dropdown li:nth-child(1)" ).addClass( "active" );
    jQuery( ".dropdown.property-dropdown" ).addClass( "active" );
}
if(current_url == '/myproperties'){
    jQuery( ".dropdown.property-dropdown li:nth-child(2)" ).addClass( "active" );
    jQuery( ".dropdown.property-dropdown" ).addClass( "active" );
}
if(current_url == '/renter/update' || current_url == '/renter/create'|| current_url == '/credit/background'){
    jQuery( ".dropdown.application-dropdown li:nth-child(1)" ).addClass( "active" );
    jQuery( ".dropdown.application-dropdown" ).addClass( "active" );
}
if(current_url == '/property/requests'){
    jQuery( ".dropdown.application-dropdown li:nth-child(2)" ).addClass( "active" );
    jQuery( ".dropdown.application-dropdown" ).addClass( "active" );
}
if(current_url == '/logout'){
    jQuery( ".logout" ).addClass( "active" );
}
if(current_url == '/members/settings/general'){
    jQuery( ".settings" ).addClass( "active" );
}
var profile_url='<?php echo '/profile/'.$viewer->getIdentity()?>';
if(current_url == profile_url){
    jQuery( ".my_profile" ).addClass( "active" );
}

    jQuery('body').on('click', '.remove_saved_renter', function(event){
        var user_id =parseInt(jQuery(this).attr('user_id'));
        var oData       = new Object();
        oData.user_id = user_id;
        var url = '<?php echo $this->baseUrl().'/user/index/unlikeuser' ?>';
        jQuery.ajax({
                        url:  url,
                        data: oData,
                        dataType: 'json',
                        type: 'POST',
                        success: function (data) {
                        if(data.status == true){
                            jQuery('.save_btn_div_'+user_id).html('');
                            //jQuery('.like_user_'+user_id).html('<i class="fa fa-heart" aria-hidden="true" ></i>');
                            jQuery('.save_btn_div_'+user_id).html('<button class="like_user like_user_'+user_id+'" user_id ="'+user_id+'" title="Save">Save</button>');
                            var url = '<?php echo $this->baseUrl().'/user/index/getlikedusers' ?>';
                        jQuery.ajax({
                            url:  url,
                            data: oData,
                            dataType: 'json',
                            type: 'POST',
                            success: function (result) { console.log(result.html);
                                jQuery('#likeUserModal .modal-body').html(result.html);
                                },
                           error: function(e){ }
                        });
                        }
                     },
                       error: function(e){ }
                    });
    });

 jQuery( "#PreferenceCountry" ).change(function() {

  var url = '<?php echo $this->baseUrl(); ?>' + '/user/index/getpropertystates';
  var countryid =   jQuery('#PreferenceCountry').val();
    jQuery('#PreferenceState').html('');
    jQuery('#PreferenceCity').html('');
          jQuery.ajax({
                     url:  url,
                    data: "countryId="+countryid,
                    dataType: 'json',
                    type: 'POST',
                 success: function (data) { console.log(data);
                    jQuery('#PreferenceState').append('<option value="">Select</option>');
                    jQuery.each(data, function (i, item) {
                    jQuery('#PreferenceState').append(jQuery('<option>', {
                        value: item.id,
                        text : item.state
                    }));
                });},
                   error: function(e){   }
                });
});
 jQuery( "#PreferenceState" ).change(function() {

  var url = '<?php echo $this->baseUrl(); ?>' + '/user/index/getpropertycity';
  var stateid   =   jQuery('#PreferenceState').val();
    jQuery('#PreferenceCity').html('');
          jQuery.ajax({
                     url:  url,
                    data: "stateId="+stateid,
                    dataType: 'json',
                    type: 'POST',
                 success: function (data) { console.log(data);
                    jQuery('#PreferenceCity').append('<option value="">Select</option>');
                    jQuery.each(data, function (i, item) {
                    jQuery('#PreferenceCity').append(jQuery('<option>', {
                        value: item.id,
                        text : item.city
                    }));
                });},
                   error: function(e){   }
                });
});
jQuery('body').on('click', '.feedpreferenceunit_filtering', function(event){

     var package_type = "<?php echo $package_type;?>";
     var profile_type_id = "<?php echo $profile_type_id;?>";
     var user_premiumLevelProvision = "<?php echo $user_premiumLevelProvision;?>";
     if((package_type == '' && profile_type_id == 4 && user_premiumLevelProvision == 2) || (package_type == '' && profile_type_id == 1)){
    //  jQuery("#preferenceModal").modal('show');
     }
     else{
       //  jQuery("#preferenceModalForPackageUpgraded").modal('show');
        jQuery('#preferenceModalForPackageUpgraded .modal-body .location_fields').html('');

         jQuery('#preferenceModalForPackageUpgraded .modal-body .location_fields').html(
        '<input type= "hidden" class="field" id="street_number" ></input>'+
        ' <input  type= "hidden" class="field" id="route"></input>'+
        '<input type= "hidden" class="field" id="neighborhood" ></input>  '+
        '<input type= "hidden" class="field" id="locality"></input>'+
        '<input type= "hidden" class="field" id="sublocality_level_1"></input>'+
        '<input type= "hidden" class="field" id="administrative_area_level_1" ></input>'+
        '<input type= "hidden" class="field" id="postal_code"></input>'+
        '<input type= "hidden" class="field" id="country"></input>'+
        '<input type= "hidden" class="field" id="latitude"></input>'+
        '<input type= "hidden" class="field" id="longitude"></input>');

          initAutocomplete3();
      }

});
jQuery('body').on('click', '.remove_preference', function(event){
  jQuery("#preferenceModalForPackageUpgraded .error_msg").text('');
  var oData           = new Object();
  var user_id    =oData.user_id='<?php echo $viwer_id ?>';
  var preference_id =  oData.preference_id =parseInt(jQuery(this).attr('remove_preference_id'));
  var preferencename =  oData.preferencename =jQuery(this).attr('preferencename');
  var formURL    = '<?php echo $this->baseUrl(); ?>' + '/user/index/deletepreference';
    jQuery.ajax( {
                        url : formURL,
                        type: "POST",
                        dataType: 'json',
                        data : oData,
                        success: function (data) {
                             jQuery( ".preference_li_"+preference_id ).css('display','none');
                             jQuery("#matchesModal .scoutcount").val(data.preference_count);
                             jQuery("#preferenceModalForPackageUpgraded .error_msg").text('Succesfully deleted');
                              setTimeout(function(){
                                   jQuery("#preferenceModalForPackageUpgraded .error_msg").text('');
                                    }, 2000);


                            if(data.preference_count==0)
                            {
                                jQuery('#preferenceModalForPackageUpgraded .preference_content').append('<div class="preference_msg" style="padding:12px"> No Preferences</div>');
                                jQuery('#preferenceModal .preference_msg').text('No Preferences');

                                jQuery("#matchesModal .scoutcount").val(data.preference_count);
                            }
                            else{
                                    var scoutname ='';
                                    var oData       = new Object();
                                    oData.scoutname   = scoutname;
                                    var url = '<?php echo $this->baseUrl().'/user/index/getpreferencebyscoutname' ?>';
                                    jQuery.ajax({
                                                    data: oData,
                                                    url:  url,
                                                    dataType: 'json',
                                                    type: 'POST',
                                                    success: function (data) {
                                                        jQuery("#preferenceModalForPackageUpgraded .preference_content").html(data.html);
                                                 },
                                                   error: function(e){ }
                                        });

                            }
                          },
                            error: function(e){
                        }
    });
});

jQuery('body').on('click', '.mob_navbar button', function(event){
    if(jQuery('.mob_navbar button').hasClass('clicked')){
        jQuery('.mob_navbar button').removeClass('clicked');
        jQuery('.navbar_header_middile_menus').css('width','auto');
        jQuery('.navbar_header_middile_menus #myNavbar').css('display','none');
    }
    else{
        jQuery('.navbar_header_middile_menus').css('float','left !important');
        jQuery('.navbar_header_middile_menus').css('width','100%');
        jQuery('.navbar_header_middile_menus #myNavbar').css('display','block');
        jQuery('.mob_navbar button').addClass('clicked');
    }
});
jQuery('body').on('click', '.dropdown.find-dropdown', function(event){
        if(jQuery( ".dropdown.find-dropdown" ).hasClass("opendropdown")){
             jQuery( ".dropdown.find-dropdown" ).removeClass("opendropdown");
             jQuery('.dropdown.find-dropdown .dropdown-menu.find_nav').css('display', 'none');
        }
        else
        {
            jQuery( ".dropdown.find-dropdown" ).addClass("opendropdown");
             jQuery('.dropdown.find-dropdown .dropdown-menu.find_nav').css('display', 'block');
        }
});
jQuery('body').on('click', '.dropdown.application-dropdown', function(event){
        if(jQuery( ".dropdown.application-dropdown" ).hasClass("opendropdown")){

             jQuery( ".dropdown.application-dropdown" ).removeClass("opendropdown");
             jQuery('.dropdown.application-dropdown .dropdown-menu.find_nav').css('display', 'none');
        }
        else
        {
            jQuery( ".dropdown.application-dropdown" ).addClass("opendropdown");
             jQuery('.dropdown.application-dropdown .dropdown-menu.find_nav').css('display', 'block');
        }
});
jQuery('body').on('click', '.dropdown.property-dropdown', function(event){
        if(jQuery( ".dropdown.property-dropdown" ).hasClass("opendropdown")){
             jQuery( ".dropdown.property-dropdown" ).removeClass("opendropdown");
             jQuery('.dropdown.property-dropdown .dropdown-menu.find_nav').css('display', 'none');
        }
        else
        {
            jQuery( ".dropdown.property-dropdown" ).addClass("opendropdown");
             jQuery('.dropdown.property-dropdown .dropdown-menu.find_nav').css('display', 'block');
        }
});
jQuery('body').on('click', '.fcra a', function(event){
      jQuery("#fcraModal").modal('show');
});

jQuery( ".menu_core_main.core_main_dashboard" ).click(function(event) {
        event.preventDefault();
        var url = '<?php echo $this->baseUrl().'/user/index/unsetsessions' ?>';
        var oData       = new Object();
        jQuery.ajax({
                        data: oData,
                        url : url,
                        dataType: 'json',
                        type: 'POST',
                        success: function (data) {
                        location.href = '<?php echo $this->baseUrl(); ?>' + '/members/home';
                     },
                       error: function(e){ }
            });

});

    jQuery('body').on('click', '.remove_saved_property', function(event){
        var property_id =parseInt(jQuery(this).attr('property_id'));
        var oData       = new Object();
        oData.property_id = property_id;
        var url = '<?php echo $this->baseUrl().'/user/index/unlikeproperty' ?>';
        jQuery.ajax({
                        data: oData,
                        url:  url,
                        dataType: 'json',
                        type: 'POST',
                        success: function (data) {
                        if(data.status == true){
                            jQuery('.save_btn_div_'+property_id).html('');
                            jQuery('.save_btn_div_'+property_id).html('<button class="like_property like_property_'+property_id+'" property_id ="'+property_id+'" title="Save">Save</button>');
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
                       error: function(e){ }
            });
    });
jQuery('body').on('click', '.matches', function(event){
initAutocomplete1();
});


    jQuery('body').on('click', '.but_submit_preference', function(event){
       var preference_property_id   = jQuery('#preference_property_id').val();
       var preference_addess        = jQuery('#autocomplete3').val();
       var oData       = new Object();
       var PreferenceCountry                        = oData.PreferenceCountry =jQuery.trim(jQuery("#country").val());
       var PreferenceState                          = oData.PreferenceState =jQuery.trim(jQuery("#administrative_area_level_1").val());
       var PreferenceCity                           = oData.PreferenceCity =jQuery.trim(jQuery("#locality").val());
       if(PreferenceCity == ''){
       var PreferenceCity     = oData.PreferenceCity =jQuery.trim(jQuery("#sublocality_level_1").val());
       }

       var PreferenceCounty          = oData.PreferenceCounty =jQuery.trim(jQuery("#sublocality_level_1").val());
       var PreferencNeighborhood     = oData.PreferenceNeighborhood =jQuery.trim(jQuery("#neighborhood").val());
       var PreferenceZip             = oData.PreferenceZip =jQuery.trim(jQuery("#postal_code").val());
       var Preferencelatitude        = oData.Preferencelatitude =jQuery.trim(jQuery("#latitude").val());
       var Preferencelongitude       = oData.Preferencelongitude =jQuery.trim(jQuery("#longitude").val());

        if(preference_property_id != ''){
            preference_addess = '';
        }
        oData.preference_property_id   = preference_property_id;
        oData.preference_addess        = preference_addess;
        var url = '<?php echo $this->baseUrl().'/user/index/matchingrequirementpreferences' ?>';
        jQuery.ajax({
                        data: oData,
                        url:  url,
                        dataType: 'json',
                        type: 'POST',
                        success: function (data) {
                            jQuery("#preferenceModalForPackageUpgraded .preference_content").html(data.html);

                     },
                       error: function(e){ }
            });


    });
jQuery('body').on('click', '.edit_preference', function(event){
     jQuery("#editPreferenceModal .message").html('');
     var preference_id = jQuery(this).attr('preferenceId');
     var li_count      = jQuery(this).attr('li_count');
     var oData       = new Object();
     oData.preference_id =preference_id;
     var url = '<?php echo $this->baseUrl().'/user/index/getpreferencebyid' ?>';
        jQuery.ajax({
                        data: oData,
                        url:  url,
                        dataType: 'json',
                        type: 'POST',
                        success: function (data) {
                            jQuery("#editPreferenceModal .modal-body .matches_div").html(data.html);
                            jQuery("#editPreferenceModal .modal-body .matches_div").append('<input type="hidden" value="'+preference_id+'" class="edit_preference_id">');
                            jQuery("#editPreferenceModal .modal-body .matches_div").append('<input type="hidden" value="'+li_count+'" class="li_count">');

                     },
                       error: function(e){ }
            });
       initAutocomplete4();
      //jQuery("#editPreferenceModal").modal('show');

});

jQuery('body').on('click', '.edit_preference_submit', function(event){
    var oData       = new Object();
    var edit_preference_id = oData.edit_preference_id     = jQuery.trim(jQuery(".edit_preference_id").val());
    var edit_preference_place = oData.edit_preference_place     = jQuery.trim(jQuery(".edit_preference_place").val());
    var edit_scout_name  = oData.edit_scout_name     = jQuery.trim(jQuery(".edit_scout_name").val());
    var li_count = oData.li_count     = jQuery.trim(jQuery("#editPreferenceModal .li_count").val());
    var edit_housing_type    = oData.edit_housing_type    =   jQuery('input[name="edit_housing_type"]:checked').val();
    var edit_pets_type        = oData.edit_pets_type     = jQuery.trim(jQuery(".edit_pets_type").val());
    var edit_price            = oData.edit_price         =  jQuery.trim(jQuery("#editPreferenceModal .price_range_from").val());
    var edit_price_to          =oData.edit_price_to       =  jQuery.trim(jQuery("#editPreferenceModal .edit_price_to").val());
    var neighborhood           =oData.neighborhood        =  jQuery.trim(jQuery("#neighborhood").val());
    var cityName               =oData.cityName            =  jQuery.trim(jQuery("#locality").val());
    var countyName             =oData.countyName          =  jQuery.trim(jQuery("#sublocality_level_1").val());


     stateName              = oData.stateName           =  jQuery.trim(jQuery("#administrative_area_level_1").val());
     postal_code            = oData.postal_code         =  jQuery.trim(jQuery("#postal_code").val());
     country                =oData.country             =  jQuery.trim(jQuery("#country").val());
     edit_is_petsallowd     = oData.edit_is_petsallowd  =  jQuery.trim(jQuery("#editPreferenceModal .edit_is_petsallowd").val());
     edit_number_of_rooms  = oData.edit_number_of_rooms =  jQuery.trim(jQuery("#editPreferenceModal .edit_number_of_rooms").val());
     var is_validate = true;

    /*if(edit_housing_type == '' && edit_pets_type == '' && edit_price == '' && neighborhood == '' &&  cityName == '' &&  countyName == '' &&

     stateName == '' && postal_code == '' && country == '' && edit_is_petsallowd == '' && edit_number_of_rooms == ''){
          is_validate = false;
     }*/

     if(edit_preference_place == ''){
         jQuery('#editPreferenceModal .edit_preference_place').css('border-color','#dd1616');
         is_validate = false;
     }
     else{
         jQuery('#editPreferenceModal .edit_preference_place').css('border-color','#b2c6cd');
         is_validate = true;
     }
     if(is_validate == true){
     if(country == '' && stateName == '' && cityName == ''){
         jQuery('#editPreferenceModal .edit_preference_place').css('border-color','#dd1616');
         is_validate = false;
     }
     else{
         jQuery('#editPreferenceModal .edit_preference_place').css('border-color','#b2c6cd');
         is_validate = true;
     }

     }
     if(is_validate == true){
     if(edit_scout_name == ''){
         jQuery('#editPreferenceModal .edit_scout_name').css('border-color','#dd1616');
         is_validate = false;
     }
     else{
         jQuery('#editPreferenceModal .edit_scout_name').css('border-color','#b2c6cd');
         is_validate = true;
     }

     }
     if(is_validate == true){
         if(edit_price == '' && edit_price_to !=''){
            jQuery('#editPreferenceModal .price_range_from').css('border-color','#dd1616');
            is_validate = false;
         }
         else{
            jQuery('#editPreferenceModal .price_range_from').css('border-color','#b2c6cd');
            is_validate = true;
         }
      }
     if(is_validate == true){
         if(edit_price != '' && edit_price_to !=''){
             if(parseInt(edit_price_to) < parseInt(edit_price)){
                jQuery('#editPreferenceModal .price_range_from').css('border-color','#dd1616');
                is_validate = false;
             }
             else{
               jQuery('#editPreferenceModal .price_range_from').css('border-color','#b2c6cd');
               is_validate = true;
             }

         }
      }

    if(is_validate == true){
    if(edit_price ==''){

        oData.edit_price = 0;
    }
    if(edit_price_to ==''){

        oData.edit_price_to = 0;
    }


     var url = '<?php echo $this->baseUrl().'/user/index/editpreference' ?>';
        jQuery.ajax({
                        data: oData,
                        url:  url,
                        dataType: 'json',
                        type: 'POST',
                        success: function (data) {

                            if(data.status == true){
                               jQuery("#editPreferenceModal .message").html('Your preference has been updated');
                               jQuery(".preference_unit_"+li_count).html(data.content);
                               jQuery(".preference_scout_name_"+li_count).html(data.scoutname);
                               setTimeout(function(){
                                   jQuery('#editPreferenceModal .close').trigger("click");
                                    }, 3000);

                            }
                            else{

                            }

                     },
                       error: function(e){ }
            });
    }
});

/*
var jQueryclick=jQuery.noConflict();
jQueryclick(document).on('click', '.video-call-symbol', function(event){
      if(viewer_profile_type=="landlord" ){
       if(user_premiumLevelProvision==2){
           if(viewer_package_type=='' && viewer_video_payment=="not_paid" ) {
           jQueryclick("#videopaymentModal").modal('show');
           }
       }
      }

});

*/

function userpackagestatus(userid){
    var oData       = new Object();
    var user_id    =oData.user_id=userid;
    var formURL    = '<?php echo $this->baseUrl(); ?>' + '/user/index/userpackagestatus';
   return jQuery.ajax( {
                        url : formURL,
                        type: "POST",
                        dataType: 'json',
                        data : oData,
                        success: function (data) {
                              // alert(data.video_payment);
                            viewer_video_payment=data.video_payment;

                   //        return data;
                            },
                            error: function(e){

                        }
    });
}





jQuery( "#LandlordState" ).change(function() {
  var url = '<?php echo $this->baseUrl(); ?>' + '/user/index/getcitywithstateabbreviations';
  var state_abbr    =   jQuery('#LandlordState').val();
    jQuery('#LandlordCity').html('');
          jQuery.ajax({
                     url:  url,
                    data: "state_abbr="+state_abbr,
                    dataType: 'json',
                    type: 'POST',
                 success: function (data) { console.log(data);
                    jQuery('#LandlordCity').append('<option value="">Select City</option>');
                    jQuery.each(data, function (i, item) {
                    jQuery('#LandlordCity').append(jQuery('<option>', {
                        value: item.city,
                        text : item.city
                    }));
                });},
                   error: function(e){   }
                });
});
Stripe.setPublishableKey('<?php echo $this->params['public_live_key']; ?>');
//Stripe.setPublishableKey('<?php echo $this->params['public_test_key']; ?>');
var form = jQuery('#payment-form');
form.submit(function(event) {
 event.preventDefault();
            var card_number                = jQuery('#card_number').val();
            var expiration_month           = jQuery('#expiration_month').val();
            var expiration_year            = jQuery('#expiration_year').val();
            var expiration                 = jQuery('#expiration').val();
            var cardholder_name            = jQuery('#cardholder_name').val();
            var last_name                  = jQuery('#last_name').val();
            var street                     = jQuery('#street').val();
            var city                       = jQuery('#LandlordCity').val();
            var state                      = jQuery('#LandlordState').val();
            var zipcode                    = jQuery('#zipcode').val();
            var validated = true;


            jQuery('#cardholder_name').css('border-color','#b2c6cd');
            jQuery('#last_name').css('border-color','#b2c6cd');
            jQuery('#street').css('border-color','#b2c6cd');
            jQuery('#LandlordCity').css('border-color','#b2c6cd');
            jQuery('#LandlordState').css('border-color','#b2c6cd');
            jQuery('#zipcode').css('border-color','#b2c6cd');
            jQuery('#card_number').css('border-color','#b2c6cd');
            jQuery('#expiration_month').css('border-color','#b2c6cd');
            jQuery('#expiration_year').css('border-color','#b2c6cd');
            jQuery('#expiration').css('border-color','#b2c6cd');




            if(cardholder_name == ''){
                jQuery('.payment-errors').text('Please enter cardholder name');
                jQuery('#cardholder_name').css('border-color','#e62828');
                validated = false;
            }
            else if(last_name == ''){
                jQuery('.payment-errors').text('Please enter last name');
                jQuery('#last_name').css('border-color','#e62828');
                validated = false;
            }
            else if(state == ''){
                jQuery('.payment-errors').text('Please enter state');
                jQuery('#LandlordState').css('border-color','#e62828');
                validated = false;
            }
            else if(city == ''){
                jQuery('.payment-errors').text('Please enter city');
                jQuery('#LandlordCity').css('border-color','#e62828');
                validated = false;
            }
            else if(street == ''){
                jQuery('.payment-errors').text('Please enter street');
                jQuery('#street').css('border-color','#e62828');
                validated = false;
            }
            else if(zipcode == ''){
                jQuery('.payment-errors').text('Please enter zipcode');
                jQuery('#zipcode').css('border-color','#e62828');
                validated = false;
            }

            else if(card_number == ''){
                jQuery('.payment-errors').text('Please enter card number');
                jQuery('#card_number').css('border-color','#e62828');
                validated = false;
            }
            else if(expiration_month == ''){
                jQuery('.payment-errors').text('Please enter expiration month');
                jQuery('#expiration_month').css('border-color','#e62828');
                validated = false;
            }
            else if(expiration_year == ''){
                jQuery('.payment-errors').text('Please enter expiration year');
                jQuery('#expiration_year').css('border-color','#e62828');
                validated = false;
            }
            else if(expiration == ''){
                jQuery('.payment-errors').text('Please enter cvc');
                jQuery('#expiration').css('border-color','#e62828');
                validated = false;
            }
            else{
                validated = true;
            }

              //Zip validation
     if(validated ==  true){
        if(zipcode != ''){
             jQuery('.payment-errors').text('');
            if(/([0-9]{5})+$/.test(zipcode)) {
             validated =true;
            }
            else {
             jQuery(".payment-errors").text('Please enter valid zipcode');
             jQuery('#zipcode').css('border-color','#e62828');
             validated =false;
            }
        }
    }

            if(validated == true){
            // Disable the submit button to prevent repeated clicks:
            form.find('.submit').prop('disabled', true);
            jQuery('.submit').hide();
            jQuery('.loader').css('display','block');
            // Request a token from Stripe:
            Stripe.card.createToken(form, stripeResponseHandler);
             // Prevent the form from being submitted:
            return false;
            }

});



function stripeResponseHandler(status, response) {
      // Grab the form:
      var form = jQuery('#payment-form'); console.log(form);




      if (response.error) { // Problem!


        if(response.error.message=="The card number is not a valid credit card number.")
        {
             jQuery('#card_number').css('border-color','#e62828');
        }else{
                jQuery('#card_number').css('border-color','#b2c6cd');
        }

        if(response.error.message=="Your card's expiration month is invalid.")
        {
             jQuery('#expiration_month').css('border-color','#e62828');
        }else{
                jQuery('#expiration_month').css('border-color','#b2c6cd');
        }
        if(response.error.message=="Your card's security code is invalid.")
        {
             jQuery('#expiration').css('border-color','#e62828');
        }else{
                jQuery('#expiration').css('border-color','#b2c6cd');
        }


        console.log(response.error.message);
        // Show the errors on the form:
        jQuery('.payment-errors').text(response.error.message);
        form.find('.submit').prop('disabled', false); // Re-enable submission
        jQuery('.submit').show();
        jQuery('.loader').css('display','none');

      } else { // Token was created!

        // Get the token ID:
        var token = response.id;

        // Insert the token ID into the form so it gets submitted to the server:
        form.append(jQuery('<input type="hidden" name="stripeToken" id="stripeToken">').val(token));

        // Submit the form:
       // form.get(0).submit();

             var oData       = new Object();
             oData.card_number                = jQuery('#card_number').val();
             oData.expiration_month           = jQuery('#expiration_month').val();
             oData.expiration_year            = jQuery('#expiration_year').val();
             oData.expiration                 = jQuery('#expiration').val();
             oData.cardholder_name            = jQuery('#cardholder_name').val();
             oData.last_name                  = jQuery('#last_name').val();
             oData.street                     = jQuery('#street').val();
             oData.city                       = jQuery('#LandlordCity').val();
             oData.state                      = jQuery('#LandlordState').val();
             oData.zipcode                    = jQuery('#zipcode').val();
             oData.stripeToken                = jQuery('#stripeToken').val();
      var url    =   '<?php echo $this->baseUrl()?>' + '/user/index/videopayment';
      jQuery.ajax({
                        url:  url,
                        data: oData,
                        dataType: 'json',
                        type: 'POST',
                        success: function (data) {
                        if(data.status == true){

                                jQueryclick('.loader').css('display','none');
                                jQueryclick("#videopaymentModal").modal('hide');
                                jQueryclick("#successModal .success_message").text('');
                                jQueryclick("#successModal .success_message").text('Payment successfull');
                                jQueryclick("#successModal").modal('show');

                                var details=userpackagestatus(viewerId);
                               // alert("pay success   "+details.video_payment);
                              //  viewer_video_payment
                               // location.reload();
                        }
                        else{

                  jQuery('.payment-errors').text('connection error');
                  jQueryclick('.loader').css('display','none');
                  form.find('.submit').prop('disabled', false)
                  jQuery('.submit').show();
                        }
                     },
                       error: function(e){}
                });
      }
    }

jQuery(".user-profile.dropdown").hover(function(){
jQuery("#user-profile-submenu1").addClass('in');
});
jQuery( ".user-profile.dropdown" ).mouseleave(function() {
  jQuery("#user-profile-submenu1").removeClass('in');
});

jQuery('body').on('click', '.price_range_link', function(event){
    jQuery('#matchesModal .price_range_to_div').css('display','block');
    jQuery('#matchesModal .price_range_from').addClass('pricerange_enabled');
    jQuery('#matchesModal .price_range_to').addClass('pricerange_enabled');
    jQuery('#matchesModal .price_range_span_link').html('<a href="javascript:void(0)" class="price_cancel_range_link"><img src="/application/modules/User/externals/images/cancel_add_range.png" alt="" title="Cancel"</a>');

});
jQuery('body').on('click', '.price_cancel_range_link', function(event){
    jQuery('#matchesModal .price_range_to_div').css('display','none');
     jQuery('#matchesModal .price_range_from').removeClass('pricerange_enabled');
    jQuery('#matchesModal .price_range_to').removeClass('pricerange_enabled');
    jQuery('#matchesModal .price_range_to').val('');
    jQuery('#matchesModal .price_range_span_link').html('<a href="javascript:void(0)" class="price_range_link"><img src="/application/modules/User/externals/images/add_range.png" alt="" title="Add Range"></a>');

});
jQuery( "#scouttags" ).autocomplete({

               source: function (request, response) {

                  // alert(request.term);
                jQuery.ajax({
                    type: "POST",
                    //contentType: "application/json; charset=utf-8",
                    url: "<?php echo $this->baseUrl()?>" + "/user/index/autocompletescout",
                    data: "inputTerm="+request.term,
                    dataType: "json",
                    success: function (output) {console.log(output);
                       response(output);
                    },
                    error: function (errormsg) {
                        alert(errormsg.responseText);
                    }
                });
            },
            select: function( event, ui ) {
                    var scoutname =ui.item.value;
                    var oData       = new Object();
                    oData.scoutname   = scoutname;
                    var url = '<?php echo $this->baseUrl().'/user/index/getpreferencebyscoutname' ?>';
                    jQuery.ajax({
                                    data: oData,
                                    url:  url,
                                    dataType: 'json',
                                    type: 'POST',
                                    success: function (data) {
                                        jQuery("#preferenceModalForPackageUpgraded .preference_content").html(data.html);

                                 },
                                   error: function(e){ }
                        });

            }
 });

 jQuery( "#scouttags" ).keyup(function() {
      var len = jQuery(this).val().length;

      if(len == 0){
          var scoutname ='';
                    var oData       = new Object();
                    oData.scoutname   = scoutname;
                    var url = '<?php echo $this->baseUrl().'/user/index/getpreferencebyscoutname' ?>';
                    jQuery.ajax({
                                    data: oData,
                                    url:  url,
                                    dataType: 'json',
                                    type: 'POST',
                                    success: function (data) {
                                        jQuery("#preferenceModalForPackageUpgraded .preference_content").html(data.html);

                                 },
                                   error: function(e){ }
                        });

      }
     });
     
     
jQuery( "#user_search_input" ).autocomplete({

               source: function (request, response) {

                jQuery.ajax({
                    type: "POST",
                    url: "<?php echo $this->baseUrl()?>" + "/user/index/autocompleteusers",
                    data: "inputTerm="+request.term,
                    dataType: "json",
                    success: function (output) {console.log(output);
                       response(output);
                    },
                    error: function (errormsg) {
                        alert(errormsg.responseText);
                    }
                });
            },
            select: function( event, ui ) {
				    event.preventDefault();
				    jQuery("#user_search_input").val(ui.item.label);
                    var userid =ui.item.value; 
                    location.href ="<?php echo $this->baseUrl()?>"+ "/profile/"+userid;                    
            },
            focus: function (event, ui) {
				 event.preventDefault();
                 jQuery("#user_search_input").val(ui.item.label);
            }
 });   
     
     
     
     

jQuery('body').on('click', '#set_to_usa', function(){
        if (jQuery(this).is(':checked')) {
            jQuery("#country").val('');
            jQuery("#administrative_area_level_1").val('');
            jQuery("#locality").val('');
            jQuery("#sublocality_level_1").val('');
            jQuery("#neighborhood").val('');
            jQuery("#street_number").val('');
            jQuery("#postal_code").val('');
            jQuery("#latitude").val('');
            jQuery("#longitude").val('');
            jQuery("#pac-input1").val('');
            jQuery("#autocomplete2").val('');
        }
    else{

    }
});

var logincount  = '<?php echo $logincount;?>'; 
var introstatus = '<?php echo $introstatus ;?>'; 
   if(logincount == 1 && introstatus != 'skipintro' && introstatus != 'yesintro' && current_url == '/members/home' && dev_type == 2){
	  jQuery("#introModal").modal('show');	   
   }
 jQuery('body').on('click', '.yes_intro', function(){
	    var url = '<?php echo $this->baseUrl().'/user/index/setintrosession' ?>';
        var oData       = new Object();
        oData.status    = 'yesintro';
        jQuery.ajax({
                        data: oData,
                        url : url,
                        dataType: 'json',
                        type: 'POST',
                        success: function (data) {
                       
                     },
                       error: function(e){ }
            });
	 jQuery( "#introModal .close" ).trigger( "click" );
	 jQuery( ".showmehow_btn" ).trigger( "click" );
 });   
 jQuery('body').on('click', '.skip_intro', function(){
	   
        var url = '<?php echo $this->baseUrl().'/user/index/setintrosession' ?>';
        var oData       = new Object();
        oData.status    = 'skipintro';
        jQuery.ajax({
                        data: oData,
                        url : url,
                        dataType: 'json',
                        type: 'POST',
                        success: function (data) {
                       
                     },
                       error: function(e){ }
            });
	 jQuery( "#introModal .close" ).trigger( "click" );
 }); 
 var  profileType = '<?php echo  $profileType;?>';
 
 if(profileType  == 'tenant'){
	 jQuery(".core_main_posttoscout").attr("data-step","4");
     jQuery(".core_main_posttoscout").attr("data-intro","<?php echo $introText['posttoscoutText'];?>");
     jQuery(".core_main_documents").attr("data-step","5");
     jQuery(".core_main_documents").attr("data-intro","<?php echo $introText['documentText'];?>");
     jQuery(".advancedarticles_article").attr("data-step","6");
     jQuery(".advancedarticles_article").attr("data-intro","<?php echo $introText['articlesText'];?>");
     jQuery(".liked_property_list").attr("data-step","7");
     jQuery(".liked_property_list").attr("data-intro","<?php echo $introText['heartIconText'];?>");
     jQuery(".searchusers").attr("data-step","8");
     jQuery(".searchusers").attr("data-intro","<?php echo $introText['searchIconText'];?>");
	 
 }
 if(profileType  == 'landlord'){
    jQuery(".core_main_documents").attr("data-step","4");
    jQuery(".core_main_documents").attr("data-intro","<?php echo $introText['documentText'];?>");
    jQuery(".advancedarticles_article").attr("data-step","5");
    jQuery(".advancedarticles_article").attr("data-intro","<?php echo $introText['articlesText'];?>");
    jQuery(".liked_users_list").attr("data-step","6");
    jQuery(".liked_users_list").attr("data-intro","<?php echo $introText['heartIconText'];?>");
    jQuery(".searchusers").attr("data-step","7");
    jQuery(".searchusers").attr("data-intro","<?php echo $introText['searchIconText'];?>");
	 
 }
 var scoutCount = jQuery.trim(jQuery(".scoutcount").val());
  if(viewer_package_type == '' && profileType == 'landlord' && user_premiumLevelProvision == 2){
	   if(scoutCount >=parseInt(user_basicScoutLimit)){
		  jQuery('#price_filtering_icon').attr('disabled', 'disabled');
		  jQuery('#price_filtering_icon').attr('title', 'To continue, please upgrade your package.');
		  jQuery('#typeofpets_filtering_icon').attr('disabled', 'disabled');
		  jQuery('#typeofpets_filtering_icon').attr('title', 'To continue, please upgrade your package.');
		  jQuery('#noofbedrooms_filtering_icon').attr('disabled', 'disabled');
		  jQuery('#noofbedrooms_filtering_icon').attr('title', 'To continue, please upgrade your package.');
		  jQuery(".prefered_location_div.change_location").removeAttr("data-target");
		  jQuery(".prefered_location_div.change_location").removeAttr("data-toggle");
		  jQuery(".prefered_location_div").removeClass("change_location");
     }
   }


</script>
