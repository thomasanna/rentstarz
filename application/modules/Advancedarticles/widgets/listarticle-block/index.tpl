<script src="/application/modules/User/externals/scripts/message_notififaction.js"></script>
<?php $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); ?>
<script>
	
	<?php if( !count($this->paginator) && !$this->filter ): ?>
	jQuery(".generic_layout_container.layout_left").css('display','none');
	jQuery(".generic_layout_container.layout_right").css('display','none');
	<?php endif;?>
var viewer_identity='<?php echo $viwer_id; ?>';	
</script>
<!--<h3 class="sep">
    <span><?php//echo isset($this->category) ? $this->category->getTitle() : $this->translate('All Categories') ?></span>
</h3>-->
<?php if( !count($this->paginator) && !$this->filter ): ?>
    <div class="tip123">
      <span style="padding: 10px 26px 10px 26px;">
        <?php echo $this->translate('No articles.');?>
        <?php if ($this->art_create):?>
          <?php echo $this->translate('Get started by %1$sposting%2$s a new article!', '<a href="'.$this->url(array('action' => 'add'), "advancedarticles_general").'">', '</a>'); ?>
        <?php endif; ?>
      </span>
    </div>
<?php return; endif; ?>
<?php if( !count($this->paginator) && $this->filter ): ?>
    <div class="tip">
      <span>
        <?php echo $this->translate('Nobody has created a article with that criteria.');?>
        <?php if ($this->art_create):?>
          <?php echo $this->translate('Be the first to %1$sadd%2$s a new article!', '<a href="'.$this->url(array('action' => 'add'), "advancedarticles_general").'">', '</a>'); ?>
        <?php endif; ?>
      </span>
    </div>
<?php return; endif; ?>
 <?php $space = ''; foreach( $this->paginator as $item ): ?> 
 <?php
 $feedBody   = substr(strip_tags($item->description),0,1000) . '...';
 $feedBody   = trim(preg_replace('/[\r\n]+/', ' ',$feedBody));
 $feedBody   = str_replace('"', "'", $feedBody);
 $feedBody   = str_replace("'", "\'", $feedBody);
 $tagtext    = $item->getTitle();
 $detailUrl  = $item->getHref();

 $type               =   '';
 $safeName           =   ( $type ? str_replace('.', '_', $type) : 'main' );
 $src                =   $item->getPhotoUrl($type);
 
 $src = substr($src, 0, strpos($src, "?"));

 if($src):
 $src                =   $src;
 else:
 $src                =   '/application/modules/Advancedarticles/externals/images/no_art_icon.jpg';
 endif;
 $feed_image =      $src; 
 ?>
 
 
 <div class="article_li"> 
 <div class="article_image"> 
    <?php
            if( $item->photo_id ) echo $this->htmlLink($item->getHref(), $this->itemPhoto($item, '', array('class' => 'thumb1')));
            else echo $this->htmlLink($item->getHref(), '<img alt="" src="application/modules/Advancedarticles/externals/images/no_art_icon.jpg">');
    ?>
 </div>
 <div class="article_description">	 
	<div class="article_title">
		 <h3><?php echo $this->htmlLink($item->getHref(), $this->string()->truncate($item->getTitle(), 50)) ?></h3>
	</div>	 
	<div class="article_time">	 
	  <span style="font-weight: 700;">Time description</span>
	  <span style="color: #999;"><?php echo $this->timestamp($item->created_date); ?> </span>	 
	</div>	
	<div class="article_body">		
		<?php echo substr(strip_tags($item->description),0,1000) . '...';?>  
	</div>
 </div> 
 <div class="article_options">	
	<div class="read_more">
		 <a href="articles/<?php echo $item->artarticle_id?>/<?php echo $item->url?>">Read More ></a>		 
	</div>
	<div class="likecomment_div"> 
	<div class="like_div like_div_<?php echo $item->artarticle_id;?>">		
	<?php 	
	$articlelikeTable =  Engine_Api::_()->getDbtable('Articlelike', 'user');			
	$articlelikeData = $articlelikeTable->fetchRow($articlelikeTable->select()			
			                                           ->where('likedBy = ?', $viwer_id)
			                                           ->where('articleId = ?', $item->artarticle_id));  			                                           
			                                           
	$articlecommentTable =  Engine_Api::_()->getDbtable('Articlecomments', 'user');		
	$articlecommentData = $articlecommentTable->fetchAll($articlecommentTable->select()			
			                                           ->where('articleId = ?',$item->artarticle_id));	                                          
	
	?>
	
	<?php if(count($articlelikeData) > 0 ):?>	
	    <a href="javascript:void(0)" class="unlike_article like_article_<?php echo $item->artarticle_id;?>" title="Unlike" article_id="<?php echo $item->artarticle_id;?>"><i class="fa fa-heart" aria-hidden="true" style="color: #eee;"></i></a>	
	<?php else:?>	
	<a href="javascript:void(0)" class="like_article like_article_<?php echo $item->artarticle_id;?>" title="Like" article_id="<?php echo $item->artarticle_id;?>"><i class="fa fa-heart" aria-hidden="true" style="color: #f58410;"></i></a>
	<?php endif;?>
		<span class="like_count"><?php echo count($articlelikeData);?></span>
	</div>
	<div class="comment_div comment_div_<?php echo $item->artarticle_id;?>">	
	<a href="javascript:void(0)" class="comment_article comment_article_<?php echo $item->artarticle_id;?>"  article_id="<?php echo $item->artarticle_id;?>">Comments</a>
    <span class="comment_count comment_count_<?php echo $item->artarticle_id;?>"><?php echo count($articlecommentData);?></span>    
	</div>
	<input type="hidden" class="feedBody_<?php echo $item->artarticle_id;?>" value= "<?php echo $feedBody; ?>">
	<div class="fbsharediv"  onClick="fbShare('<?php echo  $item->artarticle_id; ?>','<?php echo $tagtext ?>','<?php echo $feed_image; ?>','<?php echo $detailUrl; ?>')">
	<i class="fa fa-facebook-square"  style="color: #3b5998;"> </i><span style="color: #f58410;margin-left: 4px;">Share</span>
	</div>	
	<div class="fbsharediv"  onClick="twitterShare('<?php echo $item->artarticle_id; ?>','<?php echo $tagtext ?>','<?php echo $feed_image; ?>','<?php echo $detailUrl; ?>')">
	<i class="fa fa-twitter" style="color: #00aced;"></i><span style="color: #f58410;margin-left: 4px;">Share</span>
	</div>	
	</div>	
	</div>	
	<div class="comment_area">
	<div class="comment_list comment_list_<?php echo $item->artarticle_id;?>">		
	</div>
	<div class="comment_post_area comment_post_area_<?php echo $item->artarticle_id;?>">
	</div>
	</div>
 </div>
 <?php  $space = 'space';  endforeach;?>
<div id="fb-root"></div>
<script type="text/javascript">
	jQuery('body').on('click', '.like_article', function(event){		
		var article_id =parseInt(jQuery(this).attr('article_id'));		
		if(!jQuery('.like_article_'+article_id).hasClass('clicked')){			
		jQuery('.like_article_'+article_id).addClass('clicked');		
		var oData       = new Object();		
		oData.article_id = article_id;		
		var url = '<?php echo $this->baseUrl().'/advancedarticles/articles/articlelike' ?>';		
		jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					    success: function (data) { console.log(data);						
						if(data.status == true){						
						var url = '<?php echo $this->baseUrl().'/advancedarticles/articles/getarticlelikedusers' ?>';		
						jQuery.ajax({
							url:  url,
							data: oData,						
							dataType: 'json',
							type: 'POST',
							success: function (result) {
							jQuery('.like_div_'+article_id).html('<a href="javascript:void(0)" class="unlike_article like_article_'+article_id+'" title="Unlike" article_id="'+article_id+'"><i class="fa fa-heart" aria-hidden="true" style="color: #eee;"></i></a><span class="like_count">'+result.likecount+'</span>');							
                                var url = '<?php echo $this->baseUrl().'/advancedarticles/articles/getsavedarticles' ?>';		
								jQuery.ajax({
									url:  url,
									data: oData,						
									dataType: 'json',
									type: 'POST',
									success: function (savedarticlelist) { console.log(savedarticlelist.html);									
									jQuery('.saved_article_list').html(savedarticlelist.html);   
									},
								   error: function(e){ }  
								}); 
							},
						   error: function(e){ }  
						}); 	
					   }
					 },
					   error: function(e){ }  
					}); 				
				}
		else{			
			jQuery('.like_article_'+article_id).removeClass('clicked');			
		}		
	});
	jQuery('body').on('click', '.unlike_article', function(event){
		var article_id   = parseInt(jQuery(this).attr('article_id'));		
		var oData        = new Object();		
		oData.article_id = article_id;		
		var url = '<?php echo $this->baseUrl().'/advancedarticles/articles/articleunlike' ?>';		
		jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					    success: function (data) { 						
						if(data.status == true){							
						var url = '<?php echo $this->baseUrl().'/advancedarticles/articles/getarticlelikedusers' ?>';		
						jQuery.ajax({
							url:  url,
							data: oData,						
							dataType: 'json',
							type: 'POST',
							success: function (result) {
							jQuery('.like_div_'+article_id).html('<a href="javascript:void(0)" class="like_article like_article_'+article_id+'" title="Like" article_id="'+article_id+'"><i class="fa fa-heart" aria-hidden="true" style="color: #f58410;"></i></a><span class="like_count">'+result.likecount+'</span>');					
						    var url = '<?php echo $this->baseUrl().'/advancedarticles/articles/getsavedarticles' ?>';		
												jQuery.ajax({
													url:  url,
													data: oData,						
													dataType: 'json',
													type: 'POST',
													success: function (savedarticlelist) { console.log(savedarticlelist.html);													
													jQuery('.saved_article_list').html(savedarticlelist.html);  
													},
												   error: function(e){ }  
												}); 
							},
						   error: function(e){ }  
						}); 
	
					   }
					  },
					   error: function(e){ }  
					}); 
	});
	
	jQuery('body').on('click', '.comment_post_btn', function(event){
		
		var article_id           = parseInt(jQuery(this).attr('article_id'));  
		var article_comment_body = jQuery('.article_comment_body_'+article_id).val(); 		
		if(article_comment_body != ''){		
		var oData                = new Object();		
		oData.article_id         = article_id;
		oData.article_comment_body = article_comment_body;		
		var url                    = '<?php echo $this->baseUrl().'/advancedarticles/articles/postcomment' ?>';		
		jQuery.ajax({
				url:  url,
				data: oData,						
				dataType: 'json',
				type: 'POST',
				success: function (data) { 						
				if(data.status == true){							
				var url = '<?php echo $this->baseUrl().'/advancedarticles/articles/getarticlecomments' ?>';		
				jQuery.ajax({
					url:  url,
					data: oData,						
					dataType: 'json',
					type: 'POST',
					success: function (result) { console.log(result.html);							
					jQuery('.comment_list_'+article_id).html(result.html);							
					jQuery('.comment_count_'+article_id).html(result.commentcount);										
					jQuery('.article_comment_body_'+article_id).val('');							
					},
				   error: function(e){ }  
				});
			   }
			  },
			   error: function(e){ }  
			});
	    }
	});
	
	jQuery('body').on('click', '.comment_article', function(event){		
		var article_id =parseInt(jQuery(this).attr('article_id'));
		if(!jQuery('.comment_article_'+article_id).hasClass('clicked')){			
			jQuery('.comment_article_'+article_id).addClass('clicked');
			var oData       = new Object();		
			oData.article_id = article_id;	
			var url          = '<?php echo $this->baseUrl().'/advancedarticles/articles/getarticlecomments' ?>';		
			jQuery.ajax({
				url:  url,
				data: oData,						
				dataType: 'json',
				type: 'POST',
				success: function (result) { console.log(result.html);
				jQuery('.comment_list_'+article_id).html(result.html);
				jQuery('.comment_post_area_'+article_id).html(result.coment_post_content);						
				},
				error: function(e){ }  
			   }); 
		}
		else{			
			jQuery('.comment_article_'+article_id).removeClass('clicked');		
			jQuery('.comment_list_'+article_id).html('');
			jQuery('.comment_post_area_'+article_id).html('');		
		}		
	});


</script>

<script type="text/javascript">


   // this loads the Facebook API
    (function (d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) { return; }
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/en_US/sdk.js";
        fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));

    window.fbAsyncInit = function () {
        var appId = '317350178671936';
        FB.init({
            appId: appId,
            status : true, // check login status
			cookie : true, // enable cookies to allow the server to access the session
			xfbml : true, // parse XFBML
            version: 'v2.11'
        });
    };

    // FB Share with custom OG data.


function fbShare(id,tagText,shareImage,detailedurl){

            var shareBody = jQuery('.feedBody_'+id).val();
            
            var image = 'http://rentstarz.com'+shareImage;	
	        var url   = 'http://rentstarz.com'+detailedurl; 

                // Dynamically gather and set the FB share data. 
                var FBDesc      = shareBody;
                var FBTitle     = tagText;
                var FBLink      = url;
                var FBPic       = image;

                // Open FB share popup
                FB.ui({
                    method: 'share_open_graph',
                    action_type: 'og.shares',
                    action_properties: JSON.stringify({
                        object: {
                            'og:url': FBLink,
                            'og:title': FBTitle,
                            'og:description': FBDesc,
                            'og:image': FBPic
                        }
                    })
                },
                function (response) {
                // Action after response
                })
      }


function twitterShare(id,tagText,shareImage,detailedurl){
	

    var redirectUrl;
    var image = 'http://rentstarz.com'+shareImage;

	var url = 'http://rentstarz.com'+detailedurl;
	redirectUrl = url.replace('&','%26');
    // Get the fact text
   // var factText = $('#fact').text();
    var factText = tagText;
    
    // Convert to string
    var factStr = factText.toString();
    
    // Fact length
    var factLen = factText.length;
    
    // Formats "facts" that are too long... remove if not needed
    if (factLen > 103) { // max chacters allowed
        // trim, and allow space for '...'"
        var trimFact = factStr.substring(0, 70);
        var trimFact = trimFact.trim(); //<-- ensures the last character isnt ' '
        factStr = trimFact + "...";
    }
    // Update the link
    var linkRef = " https://twitter.com/share?text= " + factStr +"&url="+ redirectUrl +"&hashtags=rentstarz, article";
    window.open(linkRef, 'mywin','left=20,top=20,width=500,height=500,toolbar=1,resizable=0')
    
    jQuery('#factLink').attr('href', linkRef);

}
</script>












<?php /*<table class='art_table' id="art_table" width="100%">
  <thead>
    <tr>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
      <?php $space = ''; foreach( $this->paginator as $item ): ?>
		<tr class="<?php echo $space ?>">
		<td width=1%></td>
		<td></td>
		</tr>	  
        <tr>
          <td valign="top">
          <?php
            if( $item->photo_id ) echo $this->htmlLink($item->getHref(), $this->itemPhoto($item, 'thumb.normal', array('class' => 'thumb')));
            else echo $this->htmlLink($item->getHref(), '<img alt="" src="application/modules/Advancedarticles/externals/images/no_art.png">');
          ?>		  
		  </td>
          <td valign="top">
		    <div class="art_title"><h3><?php echo $this->htmlLink($item->getHref(), $this->string()->truncate($item->getTitle(), 50)) ?>
			<?php if ( $item->featured ) : ?><img title="<?php echo $this->translate('featured') ?>" class="art_featured" src="application/modules/Advancedarticles/externals/images/featured.png" />
			<?php endif; ?>
			<?php if ( $item->sponsored ) : ?><img title="<?php echo $this->translate('sponsored') ?>" class="art_sponsored" src="application/modules/Advancedarticles/externals/images/sponsored.png" />
			<?php endif; ?>			
			</h3>

			</div>
				<div class="article_info_line"><?php echo $this->timestamp($item->created_date) ?>  <?php //echo $this->translate('posted by'); ?> <?php //echo $this->advancedarticlesUser($item->owner_id) ?>  <?php //echo $this->translate(array('%s view', '%s views', $item->num_views),$this->locale()->toNumber($item->num_views)) ?>  <?php //echo $this->translate(array('%s comment', '%s comments', $this->advancedarticlesComments($item) + $item->comments()->getCommentCount()), $this->locale()->toNumber($this->advancedarticlesComments($item) + $item->comments()->getCommentCount())) ?>  <?php //echo $this->translate(array('%s like', '%s likes', $this->advancedarticlesLikes($item) + $item->likes()->getLikeCount()),$this->locale()->toNumber($this->advancedarticlesLikes($item) + $item->likes()->getLikeCount())) ?></div>

			<!--<div class="description"><?php // echo $this->string()->truncate($item->description, 300) ?></div>-->
		  </td>
        </tr>
		<tr style="height:15px">
		<td></td>
		<td></td>
		</tr>		
      <?php $space = 'space'; endforeach; ?>
  </tbody>
</table> */ ?>
<br />
<?php echo $this->paginationControl($this->paginator, null, null, array(
      'pageAsQuery' => true,
      'query' => $this->formValues,
));
?>	
