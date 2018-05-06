<?php
$userHelperObj  = $this->getHelper('User');
$userdetails    = $userHelperObj->getuserDetails($this->viewer->getIdentity());
$profileType    = $userdetails['profile_type'];
    
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

                <link rel='stylesheet' href='<?php echo $this->baseUrl(); ?>/application/modules/User/externals/chat/css/style.css' type='text/css'/>
                <link rel='stylesheet' href='<?php echo $this->baseUrl(); ?>/application/modules/User/externals/chat/css/responsive-style.css' type='text/css'/>
                <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/jquery.perfect-scrollbar/0.7.0/css/perfect-scrollbar.min.css' type='text/css'/>

                <script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/chat/js/sails.io.js"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.perfect-scrollbar/0.7.0/js/perfect-scrollbar.jquery.min.js"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-mousewheel/3.1.13/jquery.mousewheel.min.js"></script>
                <script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/chat/js/config.js"></script>
                <script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/chat/js/helper.js"></script>
                <script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/chat/js/chatFunctions.js"></script>
                <script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/chat/js/websocketRequest.js"></script>
                <script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/chat/js/websocket.js"></script>
                <script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/chat/js/chatPageScripts.js"></script>
                <?php
                    $iPod       = stripos($_SERVER['HTTP_USER_AGENT'],"iPod");
                    $iPhone     = stripos($_SERVER['HTTP_USER_AGENT'],"iPhone");
                    $iPad       = stripos($_SERVER['HTTP_USER_AGENT'],"iPad");
                    if($iPod || $iPhone || $iPad) {

                    } else {
                ?>
                    <script src="https://cdnjs.cloudflare.com/ajax/libs/adapterjs/0.15.0/adapter.min.js"></script>
                <?php } ?>
                <script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/chat/js/webrtc.js"></script>

        <?php endif;?>

    <!-- For tichat -->
<input type="hidden" class="apartement_street" id="street_number" ></input>
        <input type="hidden" class="apartement_route" id="route"></input>
        <input type="hidden" class="apartement_neighborhood" id="neighborhood" ></input>
        <input type="hidden" class="apartement_city" id="locality"></input>
        <input type="hidden" class="apartement_sublocality_level_1 county" id="sublocality_level_1"></input>
        <input type="hidden" class="apartement_state" id="administrative_area_level_1">
        <input type="hidden" class="apartement_zip" id="postal_code">
        <input type="hidden" class="apartement_country" id="country">
        <input type="hidden" class="apartement_latitude" id="latitude">
        <input type="hidden" class="apartement_longitude" id="longitude">

  <div class="header">
        <div class="container-fluild">
            <nav class="navbar">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar2">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="index.html">
                        <img src="assets/images/logo.png" alt="">
                    </a>
                </div>
                <div id="navbar2" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav navbar-right">
						
					 <?php if($this->viewer->getIdentity()): ?>
					 
					    <?php if($profileType == 'tenant'):?>
					    <li>
                            <a href="/members/home">Home</a>
                        </li>
                        <li class="dropdown">
                                <a class="dropdown-toggle" id="menu2" type="" data-toggle="dropdown">
                                   Application
                                    <span class="caret"></span>
                                </a>
                                <ul class="dropdown-menu" role="menu" aria-labelledby="menu2">
                                    <li role="presentation">
                                        <a role="menuitem" tabindex="-1" href="/credit/background"> Credit and Background check</a>
                                    </li>
                                    <li role="presentation">
                                        <a role="menuitem" tabindex="-1" href="/property/requests">My Rental Applications</a>
                                    </li>                                  
                                </ul>
                            </li>
                        <li class="active">
                                <a href="scoutUser.html">Documents</a>
                            </li>
                        <li class="active">
                                <a href="/property/requirement">Post to scout</a>
                            </li>
                        <li>
                            <a href="/articles">Articles</a>
                        </li>
                        <li>
                                <a href="index.html">Saved Renters</a>
                            </li>
                        <li>
                                <a href="index.html">Message</a>
                            </li>
                        <li>
                            <a href="#">Notifications</a>
                        </li>
                        <li>
                                <a href="#">Search</a>
                            </li>
                        <?php endif;?>	
					    
					    <?php if($profileType == 'landlord'):?>
					    <li>
                            <a href="members/home">Home</a>
                        </li>
                        <li class="dropdown">
                                <a class="dropdown-toggle" id="menu2" type="" data-toggle="dropdown">
                                   Properties
                                    <span class="caret"></span>
                                </a>
                                <ul class="dropdown-menu" role="menu" aria-labelledby="menu2">
                                    <li role="presentation">
                                        <a role="menuitem" tabindex="-1" href="/addproperty">Add Property</a>
                                    </li>
                                    <li role="presentation">
                                        <a role="menuitem" tabindex="-1" href="/myproperties">My Properties</a>
                                    </li>                                  
                                </ul>
                            </li>
                        <li>
                            <a href="/documents">Documents</a>
                        </li>
                        <li>
                            <a href="/articles">Articles</a>
                        </li>
                        
					    
					    <?php endif;?>	
                        
                        
                        <?php else: ?>
                        <li class="active">
                            <a href="<?php echo $this->baseUrl(); ?>/signup">SIGNUP</a>
                        </li>
                        <li>
                            <a href="<?php echo $this->baseUrl(); ?>/login/return_url/64-Lw%3D%3D">LOGIN</a>
                        </li>
                        
                        <?php endif;?>
                    </ul>
                </div>
                <!--/.nav-collapse -->
            </nav>
        </div>
    </div>
  
