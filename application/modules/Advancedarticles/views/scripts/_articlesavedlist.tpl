<div class="a_comments">
	
<ul>
	
	<?php if(count($this->savedArticleData) > 0):?>
	
    <?php foreach($this->savedArticleData as $item):?>


    <li>
        <?php 
		  if ($item->photo_id) echo $this->htmlLink($item->getHref(), $this->itemPhoto($item, 'thumb.icon'), array('class' => 'a_comments_thumb'));
		  else echo $this->htmlLink($item->getHref(), '<img class="thumb_icon item_photo_artarticle thumb_icon" src="application/modules/Advancedarticles/externals/images/no_art_icon.png">', array('class' => 'a_comments_thumb'));
		?>
        <div class='a_comments_info'>
        <div class='a_comments_title'>
          <?php echo $this->htmlLink($item->getHref(), $this->string()->truncate($item->getTitle(), 25)) ?>
        </div>
        
        </div> 
       
    
    </li>
 <hr>  
    <?php endforeach;?>
    
    <?php else: ?>
    
    <div style="text-align:center;">No saved articles</div>
    
    <?php endif; ?>
</ul>

</div>
