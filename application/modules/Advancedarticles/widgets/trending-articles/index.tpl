
<div class="article_tabs">
	
	<div class="article_tab active">Articles</div>
	<div class="saved_article_tab">Saved</div>

</div>

<div class="article_lists">
<div class="a_comments">
<ul>
  <?php foreach($this->paginator as $item) : ?>
  <li>
    <?php 
      if ($item->photo_id) echo $this->htmlLink($item->getHref(), $this->itemPhoto($item, 'thumb.icon'), array('class' => 'a_comments_thumb'));
      else echo $this->htmlLink($item->getHref(), '<img class="thumb_icon item_photo_artarticle thumb_icon" src="application/modules/Advancedarticles/externals/images/no_art_icon.jpg">', array('class' => 'a_comments_thumb'));
    ?>
      <div class='a_comments_info'>
        <div class='a_comments_title'>
          <?php echo $this->htmlLink($item->getHref(), $this->string()->truncate($item->getTitle(), 25)) ?>
        </div>
        
      </div>    
  </li>
  <hr> 
  <?php endforeach; ?>
</ul>
</div>
</div>

<div class="saved_article_list" style="display:none">

<div class="a_comments">
	
<ul>
	<?php if(count($this->savedArticleData) > 0):?>
	
    <?php foreach($this->savedArticleData as $item):?>


    <li>
        <?php 
		  if ($item->photo_id) echo $this->htmlLink($item->getHref(), $this->itemPhoto($item, 'thumb.icon'), array('class' => 'a_comments_thumb'));
		  else echo $this->htmlLink($item->getHref(), '<img class="thumb_icon item_photo_artarticle thumb_icon" src="application/modules/Advancedarticles/externals/images/no_art_icon.jpg">', array('class' => 'a_comments_thumb'));
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

</div>



<script>

jQuery('body').on('click', '.article_tab', function(event){

	jQuery('.article_tab').addClass('active');
	jQuery('.saved_article_tab').removeClass('active');
	jQuery('.article_lists').css('display','block');
	jQuery('.saved_article_list').css('display','none');
	
});

jQuery('body').on('click', '.saved_article_tab', function(event){

	jQuery('.saved_article_tab').addClass('active');
	jQuery('.article_tab').removeClass('active');
	jQuery('.saved_article_list').css('display','block');
	jQuery('.article_lists').css('display','none');
	
});



</script>
