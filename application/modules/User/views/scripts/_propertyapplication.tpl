 <?php
   $online_users=$this->online_users;
   $online_user_id = array();
   foreach($online_users as $row):
   $online_user_id[]=$row['user_id'];
   endforeach;
?>
<?php if(count($this->propertyRequestList) > 0 ) {?>

<?php
foreach($this->propertyRequestList as $key => $value) {?>

<div class="property_name_<?php echo $value['property_id'];?>" >
    <div class="title_color">
    <a href="<?php echo $this->baseUrl().'/property/'.$value['property_id'] ?>"><?php echo $value['property_name'];?></a>
    </div>

<ul id="property_list">

<?php for($i=0;$i<count($value);$i++){?>

		<?php if($value[$i]['id'] !=''):?>

				<?php if(in_array( $value[$i]['tenantuser_id'],$online_user_id)): ?>
				<div class="led-green" style="top: 60px; margin-left: 46px;"></div>
				<?php endif; ?>

		<div  class="request_<?php echo $value[$i]['id'];?> prty_reqsts_li">
		<div>
			<?php  $userTable = Engine_Api::_()->getDbtable('users', 'user');
				  $tenantData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $value[$i]['tenantuser_id']));?>
			<?php echo $this->htmlLink($tenantData->getHref(), $this->itemPhoto($tenantData, 'thumb.icon', array('class' => 'photo'))) ?>
		<div class="position">

			<div class="user_profile col-md-3 col-sm-3 col-xs-12">
			<div>
			<a href="<?php echo $this->baseUrl().'/profile/'.$value[$i]['tenantuser_id'] ?>"><?php echo $value[$i]['tenantdisplay_name'];?></a>
			</div>
		 <div> <?php echo $this->timestamp(date("d-m-Y", strtotime($value[$i]['created_at']))); ?>
		 </div>
		 </div>

		 <div class="view_app col-md-3 col-sm-3 col-xs-12" style="float:left;"><a href="<?php echo $this->baseUrl().'/rentalapplication/'.$value[$i]['id'] ?>" class="view_application" data-requestid =<?php echo $value[$i]['id']?> data-tenantid=<?php echo $value[$i]['tenantuser_id']?> > <img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/images/view_profile.png">&nbsp;&nbsp;View Application &nbsp;</a></div>
         <div class="request_status_<?php echo $value[$i]['id'];?> col-md-3 col-sm-3 col-xs-12" style="float:left;">
		 <?php if($value[$i]['landlord_approve'] == 0):?>
		 Waiting for approval
		 <?php endif;?>
		 <?php if($value[$i]['landlord_approve'] == 1):?>
		 Approved
		 <?php endif;?>
		 <?php if($value[$i]['landlord_approve'] == 2):?>
		 Rejected
		 <?php endif;?>
		 </div>
		<?php if($value[$i]['landlord_approve'] == '0'):?>
		<div class="col-md-3 col-sm-3 col-xs-12" style="float:left;">
		 <a title="approve" class="req_approve_btn req_approve_btn_<?php echo $value[$i]['id'];?>" data-property="<?php echo $value[$i]['property_id'];?>" data-tenant="<?php echo $value[$i]['tenantuser_id'];?>" data-req="<?php echo $value[$i]['id'];?>" href="javascript:void(0)" class="view_coverletter" data-tenantid=<?php echo $value[$i]['tenantuser_id']?> > &nbsp;<img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/images/accept.svg" width="20px"> </a>

		 <a title="reject" class="req_reject_btn req_reject_btn_<?php echo $value[$i]['id'];?>" data-property="<?php echo $value[$i]['property_id'];?>" data-tenant="<?php echo $value[$i]['tenantuser_id'];?>" data-req="<?php echo $value[$i]['id'];?>" href="javascript:void(0)" class="view_coverletter" data-tenantid=<?php echo $value[$i]['tenantuser_id']?> > &nbsp;<img src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/images/reject.svg"  width="20px"> </a>
		</div>
		<div class="loader loader_<?php echo $value[$i]['id'];?>" style="display:none"></div>

		<?php endif;?>
		</div>

		</div>

		</div>
		<?php endif;?>
<?php }?>



</ul>
<hr style="clear: both;">
</div>


<?php }//endforeach;
} else {  ?>
    <div class="notfound notfoundbox">No property requests</div>
    <?php } ?>
