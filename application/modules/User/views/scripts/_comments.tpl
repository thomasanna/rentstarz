<?php 	$userTable             =  Engine_Api::_()->getDbtable('users', 'user'); ?>
<?php foreach($this->postcommentData as $commentData ):?>
<?php $commentedUserData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $commentData['posterId'])); ?>
<?php if($commentedUserData):?>
<div class="modal-body">
	<div class="media">
		<div class="media-left">
			<?php echo $this->htmlLink($commentedUserData->getHref(), $this->itemPhoto($commentedUserData, 'thumb.icon', $commentedUserData->getTitle()), array('title'=>$commentedUserData->getTitle()));?>
		</div>
		<div class="media-body comments">
			<h5><?php echo $commentedUserData->getTitle();?></h5>
			<p><?php echo $commentData['body']; ?></p>
			<div class="row">
				<div class="col-sm-6"><a href="#"><i class="fa fa-reply"></i>&nbsp;Reply</a>&nbsp;&nbsp; <a href="#"><i class="fa fa-heart"></i>&nbsp;Like</a></div>
				<div class="col-sm-6 text-right">Post on:  <?php echo $this->timestamp($commentData['created_at']) ?></div>
			</div>

		</div>
		
	</div> 
</div>
<?php endif;?>
<?php endforeach;?>
