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
				   
				   <span class="remove_saved_renter" user_id="<?php echo $data['object_id'];?>" title="Unsave"><i class="fa fa-times" aria-hidden="true"></i></span>
				   <hr>
				</div>	
				
				<?php endforeach;?>

        <?php endif;?>
