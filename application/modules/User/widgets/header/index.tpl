<?php
$userHelperObj  = $this->getHelper('User');
$userdetails    = $userHelperObj->getuserDetails($this->viewer->getIdentity());
$profileType    = $userdetails['profile_type'];
    


?>

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
  
