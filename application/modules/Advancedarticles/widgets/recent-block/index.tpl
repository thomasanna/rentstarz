<?php if( !count($this->paginator) ): ?>
    <div class="tip">
      <span>
        <?php echo $this->translate('Nobody has created an article yet.');?>
        <?php if ($this->art_create):?>
          <?php echo $this->translate('Get started by %1$sposting%2$s a new article!', '<a href="'.$this->url(array('action' => 'add'), "advancedarticles_general").'">', '</a>'); ?>
        <?php endif; ?>
      </span>
    </div>
<?php return; endif; ?>
<table class='art_table' id="art_table" width="100%">
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
		    <div class="art_title"><h3><?php echo $this->htmlLink($item->getHref(), $this->string()->truncate($item->getTitle(), 40)) ?>
			<?php if ( $item->featured ) : ?><img title="<?php echo $this->translate('featured') ?>" class="art_featured" src="application/modules/Advancedarticles/externals/images/featured.png" />
			<?php endif; ?>
			<?php if ( $item->sponsored ) : ?><img title="<?php echo $this->translate('sponsored') ?>" class="art_sponsored" src="application/modules/Advancedarticles/externals/images/sponsored.png" />
			<?php endif; ?>			
			</h3>

			</div>
				<div class="article_info_line"><?php echo $this->timestamp($item->created_date) ?> - <?php echo $this->translate('posted by'); ?> <?php echo $this->htmlLink($item->getHref(), $this->advancedarticlesUser($item->owner_id)) ?> - <?php echo $this->translate(array('%s view', '%s views', $item->num_views),$this->locale()->toNumber($item->num_views)) ?> - <?php echo $this->translate(array('%s comment', '%s comments', $this->advancedarticlesComments($item) + $item->comments()->getCommentCount()), $this->locale()->toNumber($this->advancedarticlesComments($item) + $item->comments()->getCommentCount())) ?> - <?php echo $this->translate(array('%s like', '%s likes', $this->advancedarticlesLikes($item) + $item->likes()->getLikeCount()),$this->locale()->toNumber($this->advancedarticlesLikes($item) + $item->likes()->getLikeCount())) ?></div>			

			<div class="description"><?php echo $this->string()->truncate($item->description, 300) ?></div>
		  </td>
        </tr>
		<tr style="height:15px">
		<td></td>
		<td></td>
		</tr>		
      <?php $space = 'space'; endforeach; ?>
  </tbody>
</table>
<br />