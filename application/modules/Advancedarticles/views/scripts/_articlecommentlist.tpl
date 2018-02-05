
<ul class="comment_ul">
<?php foreach($this->articlecommentData as $data):?>

<li class="comment_li">
<?php $userTable = Engine_Api::_()->getDbtable('users', 'user');  
					 $userData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $data['posterId']));
				   ?>
			
<div class="comment_auther_photo">

	<?php echo $this->htmlLink($userData->getHref(), $this->itemPhoto($userData, 'thumb.icon', $userData->getTitle()), array('title'=>$userData->getTitle())) ?>

</div>
<div class="comments_info">
<span class="comments_author"><a href="<?php echo $this->baseUrl().'/profile/'.$data['posterId'] ?>"><?php echo $userData->getTitle();?></a></span>
<span class="comment_content"><?php echo $data['body'];?></span>
<div class="comment_timestamp"><?php echo $this->timestamp($data['created_at']); ?></div>

</div>
</li>

<?php endforeach;?>

</ul>
