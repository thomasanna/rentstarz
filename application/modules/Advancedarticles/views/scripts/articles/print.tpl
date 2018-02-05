<div class="art_print">
<br /><br />
<h4 class="sep">
<div class="print_link">
<a href="javascript:void(0);" onclick="printArticle(); return false;" class="buttonlink icon_art_print" id="print"><?php echo $this->translate("Take Print") ?></a>
</div>
<div class="print_header"><?php echo $this->layout()->siteinfo['title'] ?> - <?php echo $this->translate($this->article->getTitle()) ?></div>
</h4>
<br /><br />
<h3><?php echo $this->translate($this->article->getTitle()) ?>
			<?php if ( $this->article->featured ) : ?><img title="<?php echo $this->translate('featured') ?>" class="art_featured" src="application/modules/Advancedarticles/externals/images/featured.png" />
			<?php endif; ?>
			<?php if ( $this->article->sponsored ) : ?><img title="<?php echo $this->translate('sponsored') ?>" class="art_sponsored" src="application/modules/Advancedarticles/externals/images/sponsored.png" />
			<?php endif; ?>
</h3>
<div class="article_info_line">
<?php echo $this->translate('Posted by'); ?> <?php echo $this->htmlLink($this->article->getHref(), $this->advancedarticlesUser($this->article->owner_id)) ?> <?php echo $this->timestamp($this->article->created_date) ?>
</div>
<div class="art_body" id="art_body"><?php echo htmlspecialchars_decode($this->article->getBody()); ?></div>
</div>

<script type="text/javascript">
function printArticle() {
  window.addEvent('domready', function(){  
    $('print').set('style', 'display:none');
    window.print();
    $('print').set('style', 'display:block');
  });  
}
</script>