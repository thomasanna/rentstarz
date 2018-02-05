<script>
function goBack() {
    window.history.back();
}


var bodyid = jQuery('body').attr("id") ; 

</script>


<?php



    $current_url = explode("?", $_SERVER['REQUEST_URI']);
    $page_url=$this->view->page_url=$page_url = $current_url[0] ; 

?>
<?php /*if($page_url == '/addproperty'):?>

<div class="header_img"><img src="/application/modules/User/externals/images/header_image_3.jpg"></div>

<?php endif;?>

<?php if($page_url == '/myproperties' || $page_url == '/propertyrequestslist' || $page_url == '/property/approved'):?>

<div class="header_img"><img src="/application/modules/User/externals/images/header_image_1.jpeg"></div>

<?php endif;?>

<?php if($page_url == '/scheduler' || $page_url == '/scheduler/meetings' || $page_url == '/scheduler/meetings/requests' || $page_url == '/scheduler/meetings/joined'):?>

<div class="header_img"><img src="/application/modules/User/externals/images/header_image_4.jpg"></div>

<?php endif;?>
<?php */ ?>
<?php 
	$img ="";
	
	
	if($page_url == '/addproperty'):
     $text = "Add Property";
     $img ="add_property.svg";
     elseif($page_url == '/myproperties'): 
     $text= "My Properties";
     $img ="my_properties.svg";
     elseif($page_url == '/documents' || $page_url == '/documents/sharedwithme' || $page_url == '/documents/requests'|| $page_url == '/documents/special'):
     $text=  "Documents ";
    
   
    
     $img ="icon9.png";
     
     elseif($page_url == '/scheduler/meetings/joined'  || $page_url == '/scheduler/meetings/requests' || $page_url == '/scheduler/meetings' || $page_url == '/scheduler'):
     $text=  "Scheduler";
     $img ="scheduler-icon.png";
     elseif($page_url == '/renter/update'):
          $text=  "Update your Transunion background checks";
     $img ="transunionicon.png";
     
     elseif($page_url == '/propertyrequestslist'):
     $text= "Rental Applications";
     $img ="";
     elseif($page_url == '/property/approved'):
     $text= "Accepted Applications";
     $img ="";
     elseif($page_url == '/property/requests'):
     $text= "";
     $img ="";
     elseif($page_url == '/property/requests/approved'):
     $text= "";
     $img ="";
     elseif($page_url == '/property/requirement'):
   //  $text= "Add a post to the scout board";
     $img ="/landingimage/scout.png";
     elseif($page_url == '/rentalapplication/create'):
     $text= "";
     $img ="";
     elseif($page_url == '/properties'):
     $text= "Browse Properties";
     $img ="";
     elseif($page_url == '/tenants' || $page_url == '/landlords' || $page_url == '/services' ):
     $text= "Browse Members";
     $img ="";
     elseif($page_url == '/renter/create'):
     $text= "Create your Transunion background checks";
     $img ="transunionicon.png";
     elseif($page_url == '/fcra'):
     $text= "FCRA Agreement";
     $img ="";
    endif;?>

<?php if($page_url == '/albums' || $page_url == '/albums/manage' || $page_url == '/albums/upload'):?> 

<div class="generic_layout_container layout_album_browse_menu">
	
	<!--<div class="back_icon" onclick="goBack();" title="Go Back"><i class="fa fa-arrow-left" aria-hidden="true"></i><span style="font-size: 15px;margin-left: 12px;"> Go Back</span></div>-->
<div class="headline">
  <h2>
    Photo Galleries  </h2>
      <div class="tabs">
      <ul class="navigation">
    <li class="active">
        <a class="menu_album_main album_main_browse" href="/albums">Browse Photos</a>
    </li>
    <li>
        <a class="menu_album_main album_main_manage" href="/albums/manage">My Galleries</a>
    </li>
    <li>
        <a class="menu_album_main album_main_upload" href="/albums/upload">Add New Photos</a>
    </li>
</ul>    </div>
  </div></div>


<?php else:?>   
   
<?php if($img !=""):?>
<div class="generic_layout_container layout_user_browse_menu">
<!--<div class="back_icon" onclick="goBack();" title="Go Back"><i class="fa fa-arrow-left" aria-hidden="true"></i><span style="font-size: 15px;margin-left: 12px;"> Go Back</span></div>-->
<div class="headline">

  
  <!--<span class="page_icon"><img style="padding-bottom: 7px;float: left;" src="/application/modules/User/externals/images/<?php //echo $img;?>" ></span>-->
   <span class="page_icon"><img src="/application/modules/User/externals/images/<?php echo $img;?>" ></span>
  <?php if($page_url == '/property/requirement'): ?>
  <div>
   <h2> 
  Scout Board
 </h2>
 </div>
  <?php endif; ?>
  <div class="header-align">
  <h2><?php echo $text;?>	</h2>
  </div>
      <?php  if($page_url == '/documents' || $page_url == '/documents/sharedwithme' || $page_url == '/documents/requests'|| $page_url == '/documents/special'): ?>
    
  <div class="doc-heading">
    <h2>
<?php
    	$viewer     = Engine_Api::_()->user()->getViewer();
		
     	$fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($viewer); 
		if( !empty($fieldsByAlias['profile_type']) )
		{
		  $optionId = $fieldsByAlias['profile_type']->getValue($viewer);
		   $profile_type_id = $optionId->value; 
		}
		
		if($profile_type_id  == 4){ //profile type is landlord or not
			echo "Share Documents with Renters";
		}
		if($profile_type_id  == 1){ //profile type is tenant or not
			echo "Share Documents with Landlords";
		}
     ?>

 </h2>
  

  </div>
    
 <?php endif; ?>
</div>

</div>
<?php endif;?>
<?php if($img ==""):?>
<div class="generic_layout_container layout_user_browse_menu">
<!--<div class="back_icon back_icon_noimg" onclick="goBack();" title="Go Back"><i class="fa fa-arrow-left" aria-hidden="true"></i><span style="font-size: 15px;margin-left: 12px;"> Go Back</span></div>-->
<div class="headline">
  <h2 class="h2_noimg">
	  <?php echo $text;?>
	
  </h2>
  
 
</div>
</div>


<?php endif;?>

<?php endif;?>

<script>

<?php if($page_url == '/albums/manage' ){?>
	
	jQuery( ".layout_album_browse_menu ul li:nth-child(2)" ).addClass( "active" );
	jQuery( ".layout_album_browse_menu ul li:nth-child(1)" ).removeClass( "active" );
	jQuery( ".layout_album_browse_menu ul li:nth-child(3)" ).removeClass( "active" );

<?php } ?>
<?php if($page_url == '/albums/upload' ){?>
	
	jQuery( ".layout_album_browse_menu ul li:nth-child(2)" ).removeClass( "active" );
	jQuery( ".layout_album_browse_menu ul li:nth-child(1)" ).removeClass( "active" );
	jQuery( ".layout_album_browse_menu ul li:nth-child(3)" ).addClass( "active" );

<?php } ?>
</script>
