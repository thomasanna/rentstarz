<?php if(count($this->likepropertyData) == 0):?>
		    
		    <div class="user_li">
            No Saved Properties
            </div>
            
		<?php else:?>  
				<?php foreach($this->likepropertyData as $data):?> 
				
				<div class="property_li">
				   
	<span class="feed_property_name">          
         <?php 
        $propertyTable =  Engine_Api::_()->getDbtable('propertylist', 'user');

        $propertyData =  $propertyTable->fetchRow($propertyTable->select()->where('id = ?', $data['object_id']));
        echo $propertyData->property_name; 
 
        ?>
       </span>
      <span class="remove_saved_property" style="float:right;" property_id="<?php echo $data['object_id'];?>" title="Unsave"><i class="fa fa-times" aria-hidden="true"></i></span>
      <hr> 
				</div>	
				
				<?php endforeach; ?>

        <?php endif;?>

