<?php $viewer = Engine_Api::_()->user()->getViewer();?>
<?php foreach($this->postcommentData as $data):?>
<li class="comment_li comment_li_<?php echo $data['commentId'] ;?>">
<?php $userTable = Engine_Api::_()->getDbtable('users', 'user');
                     $userData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $data['posterId']));
                   ?>

<div class="comment_auther_photo">

    <?php echo $this->htmlLink($userData->getHref(), $this->itemPhoto($userData, 'thumb.icon', $userData->getTitle()), array('title'=>$userData->getTitle())) ?>

</div>
<div class="comments_info">
<span class="comments_author"><a href="<?php echo $this->baseUrl().'/profile/'.$data['posterId'] ?>"><?php echo $userData->getTitle();?></a></span>
<span class="comment_content"><?php echo $data['body'];?></span>
<div class="comment_timestamp" comment_time="<?php echo $data['created_at']; ?>"><?php echo $this->timestamp($data['created_at']); ?></div>
<?php if(($viewer->getIdentity() == $data['posterId']) || ($viewer->getIdentity() == $this->actionSubjectId)): ?>
<span class="delete_feed_comment" comment_id="<?php echo $data['commentId'] ?>" action_id="<?php echo $data['actionId']; ?>"  data-toggle="modal" data-target="#DeletecommentModal"><a href="javascript:void(0)">Delete</a></span>
<?php endif;?>
</div>
</li>

<?php endforeach; ?>

<?php if($this->comment_count > 2):?>

<?php if($this->status == 'view_more'):?>

<div class="feed_view_comment">
<a href="javascript:void(0)" class="comments_Less comments_Less_<?php echo $this->action_id; ?>" action_id="<?php echo $this->action_id; ?>" status="<?php echo 'view_less' ?>" >View less</a>
</div>

<?php else:?>

<div class="feed_view_comment">
<a href="javascript:void(0)" class="comments_Load_more comments_Load_more_<?php echo $this->action_id; ?>" action_id="<?php echo $this->action_id; ?>" status="<?php echo 'view_more' ?>" >View more</a>
</div>
<?php endif;?>

<?php endif;?>



