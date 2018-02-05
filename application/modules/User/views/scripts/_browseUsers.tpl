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
	$( function() {
  var $winHeight = $( window ).height()
  $( '.container' ).height( $winHeight );
    });
</script>
 <?php 
   $online_users=$this->online_users;

   $online_user_id = array();
   foreach($online_users as $row):

   $online_user_id[]=$row['user_id'];
   endforeach;
 
?>
<h3>
  <?php echo $this->translate(array('%s member found', '%s members found', $this->totalUsers),$this->locale()->toNumber($this->totalUsers)) ?>
</h3>
<?php $viewer = Engine_Api::_()->user()->getViewer();?>

<div class="results-pane">
	
<?php $viewer = Engine_Api::_()->user()->getViewer();?>

<?php if( count($this->users) ): ?>
	
	
<ul>
	
	<?php foreach( $this->users as $user ): ?>
	<?php // print_r($user); exit;?>
<li class="results_pane_li">
	
	<div class="scrolling-row-inner">
		
		<?php if(in_array($user['user_id'],$online_user_id)): ?>
	    <div class="led-green" style="top: 122px; margin-left: 108px;"></div>
		<?php endif; ?>
		<div class="profile_image"> <?php echo $this->htmlLink($user->getHref(), $this->itemPhoto($user, 'thumb.profile', array('class' => 'photo')),array('title'=>$user->getTitle())) ?> </div>
		
		<div class="scrolling-row-intro player-info">
			<h2 class="vcard">
			<span class="hover-card-parent">
				
				<span class="url">
					
					 <?php  $attribs = Array('title'=>'View Profile'); ?>
					 <?php echo $this->htmlLink($user->getHref(), ucwords($user->getTitle()),$attribs) ?>
					
				</span>
			
			</span>
						

			
			<?php 
			
			$userTable = Engine_Api::_()->getDbtable('users', 'user');
			
			if($user['level_id'] == 7): // tenant
			
			$select   =   $userTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('user'=>'engine4_users',))  
                        ->joinLeft(array('search_field'=>'engine4_user_fields_search'),'search_field.item_id=user.user_id',null)                                                            
                        ->joinLeft(array('fields_value'=>'engine4_user_fields_values'),'fields_value.item_id=user.user_id',array('value'))                                             
                        ->joinLeft(array('state'=>'engine4_state_list',),'state.state_id=search_field.field_76',array('state'))                                  
                        ->joinLeft(array('city'=>'engine4_city_list',),'city.city_id=search_field.field_77',array('city'))                                  
                        ->where('fields_value.field_id=?' , 13) // bio
                        ->where('user.user_id=?' , $user['user_id']); 
			
			
			elseif($user['level_id'] == 6): // landlord
			
			$select   =   $userTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('user'=>'engine4_users',))
                        ->joinLeft(array('search_field'=>'engine4_user_fields_search'),'search_field.item_id=user.user_id',null)                                                             
                        ->joinLeft(array('state'=>'engine4_state_list',),'state.state_id=search_field.field_30',array('state'))                                  
                        ->joinLeft(array('city'=>'engine4_city_list',),'city.city_id=search_field.field_31',array('city'))                                  
                        ->where('user.user_id=?' , $user['user_id']);
                        
                        
            $propertyTable =  Engine_Api::_()->getDbtable('propertylist', 'user');	
			
			$propertyImageSelect   =   $propertyTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('plist'=>'engine4_property_list',))
                        ->joinLeft(array('pimages'=>'engine4_property_images'),'plist.id=pimages.property_id',array('image'))  
                        ->joinLeft(array('user'=>'engine4_users',),'plist.property_owner_id=user.user_id',array('displayname'))                      
                        ->where('plist.property_owner_id=?' , $user['user_id']) 
                        ->where('pimages.type =?' , 'image')                         
                        ->where('(plist.enable = ?', 1)
			            ->orWhere('user.bg_verified	 = ?)', 1)                     
                        ->where('plist.landlord_enable=?' , 1)                    
                        ->group('plist.id')
                        ->order('plist.id DESC');
                        
            $propertyImageSelectData=$propertyTable->fetchAll($propertyImageSelect);            
                        
                        
                       
			
			else: // services
			
			
			$select   =   $userTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('user'=>'engine4_users',))   
                        ->joinLeft(array('search_field'=>'engine4_user_fields_search'),'search_field.item_id=user.user_id',null)                                                           
                        ->joinLeft(array('fields_value'=>'engine4_user_fields_values'),'fields_value.item_id=user.user_id',array('value'))                                             
                        ->joinLeft(array('state'=>'engine4_state_list',),'state.state_id=search_field.field_54',array('state'))                                  
                        ->joinLeft(array('city'=>'engine4_city_list',),'city.city_id=search_field.field_55',array('city'))                                  
                        ->where('fields_value.field_id=?' , 62) // company name
                        ->where('user.user_id=?' , $user['user_id']); 
			
			
			endif;
			
			$data = $userTable->fetchRow($select); 
			?>
		<span class="meta locality" ><?php echo "USA" . " , "; if($data['state'] !=''):?><?php echo $data['state']?>, <?php endif;?> <?php echo $data['city']?></span>
  
        </h2>
        
        
        <?php if($user['level_id'] == 6):?>
        
        <div class="property-prompt">
		<!--<span style="float: left;">
          <img src="<?php echo $this->baseUrl().'/application/modules/User/externals/images/Forma-3.png'?>">-->
          <span style="float: left;">
		  <?php if($viewer->getIdentity()==$user['user_id']): ?>
          <a href="<?php echo $this->baseUrl().'/myproperties' ;?>" ><img src="<?php echo $this->baseUrl().'/application/modules/User/externals/images/Forma-3.png'?>"></a>
          <?php else:?>
          <a href="<?php echo $this->baseUrl().'/properties/'.$user['user_id'] ;?>" ><img src="<?php echo $this->baseUrl().'/application/modules/User/externals/images/Forma-3.png'?>"></a>
          <?php endif ;?>
          </span>
   
              <span>
		      <?php if($viewer->getIdentity()==$user['user_id']): ?>
			  <div class="property_count"><a href="<?php echo $this->baseUrl().'/myproperties' ;?>" ><span class="count"><?php echo count($propertyImageSelectData);?></a><span class="property_label">Properties</span></span></div>
              <?php else:?>
              <div class="property_count"><a href="<?php echo $this->baseUrl().'/properties/'.$user['user_id'] ;?>" ><span class="count"><?php echo count($propertyImageSelectData);?></span><span class="property_label">Properties</span></a></div>
			  <?php endif ;?>
			  
	    </span>
			  
		</div>
		
		<?php endif; ?>
		
		
		
	<?php /*	<div class='browsemembers_results_links'>
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
		
		 <?php if($user['level_id'] == 6):?>
			<div class="property_images">
            <?php $i=0;?> 
			<?php foreach($propertyImageSelectData as $pimages):?>	
			<?php if($i<2):?>
			
			<div class="dribbble zoom-effect-container">

				<div class="dribbble-img image-card">
					
					<a href="<?php echo $this->baseUrl().'/property/'.$pimages['id']?>"><img  alt="" src="<?php echo $this->baseUrl().'/'.$pimages['image']?>" title="<?php echo $pimages[property_name]; ?>" width=190px; height=180px></a>
					
			    </div>		
	
			</div>	
			<?php $i++;?>
			<?php endif;?>
			<?php endforeach;?>
			</div>

		<?php endif; ?>
		
		
		<?php if($user['level_id'] == 7):?>
		<div class="bio_div">
		<?php if ($data['value']!=""): ?>
			<span class="orange"><?php echo "Bio:" ?>&nbsp;&nbsp;&nbsp;&nbsp;</span>	
			<div class="tenant_bio_container">
				<?php if(strlen($data['value']) >460):?>				
				
					<?php echo substr($data['value'],0,460).'......';?>
					
			    <?php else:?>	
			    
			    <?php echo $data['value'];?>
			    
			    <?php endif;?>	
			</div>	

		
		
		<?php endif; ?>
		</div>
		<?php endif;?>	
		<?php if($user['level_id'] == 8):?>
		<div class="company_div">
				<span class="orange"><?php echo "Company Name:" ?>&nbsp;&nbsp;&nbsp;&nbsp;</span>	
			<div class="service_company_container">
					<?php echo $data['value'];?>
			</div>	

        </div>
		<?php endif; ?>

	</div>
</li>	


<?php  endforeach; ?>
	
</ul>	

<?php endif; ?>	



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
