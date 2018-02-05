
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

<div class='browsemembers_results' id='browsemembers_results'>
<h3>
  <?php echo 'SERVICES  : '. $this->translate(array('%s member found', '%s members found', $this->totalUsers),$this->locale()->toNumber($this->totalUsers)) ?>
</h3>
<?php $viewer = Engine_Api::_()->user()->getViewer();?>




<div class="results-pane">
	
<?php $viewer = Engine_Api::_()->user()->getViewer();?>

<?php if( count($this->users) ): ?>
	
	
<ul>
	
	<?php foreach( $this->users as $user ): ?>

<li class="results_pane_li">
	
	<div class="scrolling-row-inner">
		
	    <?php if(in_array($user['user_id'],$online_user_id)): ?>
	    <div class="led-green" style="top: 71px; margin-left: 57px;"></div>
		<?php endif; ?>
		<div class="profile_image"> <?php echo $this->htmlLink($user->getHref(), $this->itemPhoto($user, '', array('class' => 'photo')),array('title'=>$user->getTitle())) ?> </div>
	
		<div class="scrolling-row-intro player-info">
			<h2 class="vcard">
			<span class="hover-card-parent">
				
				<span class="url">
				
					 <?php $attribs=Array('title'=>'View Profile') ;?>
					 <?php echo $this->htmlLink($user->getHref(), ucwords($user->getTitle()),$attribs) ?>
					
				</span>
			
			</span>
						
		<span class="meta locality">
<?php echo "USA" . " , "; if($user['state'] !=''):?><?php echo $user['state']?>, <?php endif;?> <?php echo $user['city']?>
        </span>
		
	
        </h2>
        
       
		<?php /* <div class='browsemembers_results_links'>
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
		
		 </div>	*/ ?>
		 </div>
		 <div class="company_div">
		<?php if($user['value']!=""):?>
				<span class="orange"><?php echo "Company Name:" ?>&nbsp;&nbsp;&nbsp;&nbsp;</span>
				<?php endif; ?>
			<div class="service_company_container">
					<?php echo $user['value'];?>
			</div>	

		</div>	
	</div>
</li>	


<?php endforeach;?>
	
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
