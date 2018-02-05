<script src="/application/modules/User/externals/scripts/message_notififaction.js"></script>
<script>
<?php $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); ?>

var viewer_identity='<?php echo $viwer_id; ?>';	
</script>
<?php $this->headScript()->appendFile($this->baseUrl().'/application/modules/Advancedarticles/externals/scripts/imagezoom.js');?>
<?php if( !$this->article->isActive() ): ?>
    <div class="tip">
      <span>
          <?php echo $this->translate('No one will be able to view this article until you %1$sactive%2$s it!', '<a href="javascript:void(0);" id="art_active">', '</a>'); ?>
      </span>
    </div>
<?php endif; ?>
<h3><?php echo $this->translate($this->article->getTitle()) ?>
			<?php if ( $this->article->featured ) : ?><img title="<?php echo $this->translate('featured') ?>" class="art_featured" src="application/modules/Advancedarticles/externals/images/featured.png" />
			<?php endif; ?>
			<?php if ( $this->article->sponsored ) : ?><img title="<?php echo $this->translate('sponsored') ?>" class="art_sponsored" src="application/modules/Advancedarticles/externals/images/sponsored.png" />
			<?php endif; ?>
</h3>
<div class="article_info_line">
<?php //echo $this->translate('Posted by'); ?> <?php //echo $this->advancedarticlesUser($this->article->owner_id) ?> <?php echo $this->timestamp($this->article->created_date) ?><?php //echo $this->translate(array('%s view', '%s views', $this->article->num_views),$this->locale()->toNumber($this->article->num_views)) ?>  <?php //echo $this->translate('Filed in'); ?> <?php //echo $this->htmlLink($this->category->getHref(), $this->category->getTitle()) ?>
</div>
<div class="art_body" id="art_body"><?php echo htmlspecialchars_decode($this->article->getBody()); ?></div>
<br />
<?php if (count($this->article->getAraticleTags())) : ?>
    <b><?php echo $this->translate('Article Tags:'); ?></b>
<?php endif; ?>
<?php foreach($this->article->getAraticleTags() as $tag) :
		if (!$tag->getTag()->getTitle()) continue;
?>
 #<a href="<?php echo $this->url(array('action' => 'category'),'advancedarticles_general').'?tag='.$tag->getTag()->tag_id ?>"><?php echo $tag->getTag()->getTitle() ?></a>
<?php endforeach; ?>
<br />
<!--<div class="art_share_report">
      <?php echo $this->htmlLink(array('route' => 'default', 'module' => 'activity', 'controller' => 'index', 'action' => 'share', 'type'=>'artarticle', 'id' => $this->article->artarticle_id, 'format' => 'smoothbox'), $this->translate('Share'), array('class' => 'buttonlink icon_art_share smoothbox', 'title' => $this->translate('Share'))); ?>
	  &nbsp;&nbsp;&nbsp;
		<?php echo $this->htmlLink(array('route' => 'default', 'module' => 'core', 'controller' => 'report', 'action' => 'create', 'subject' => $this->article->getGuid()), $this->translate('Report'), array(
          'class' => 'buttonlink icon_art_report', 'title' => $this->translate('Report'), 'onclick' => "parent.Smoothbox.open(this.href); return false;"
        )); ?>
	  &nbsp;&nbsp;&nbsp;
		<?php echo $this->htmlLink($this->url(array('action' => 'print', 'id' => $this->article->getIdentity(), 'format' => 'smoothbox'), 'advancedarticles_category_specific', true), $this->translate('Print Article'),
		array('class' => 'buttonlink icon_art_print', 'target' => '_blank')); ?>        
</div>-->
<script>
var imgElement = $$('#art_body img');
imgElement.addClass('article_image');
imgElement.addEvent("click", function() {
	var imagezoom = new Imagezoom({
		image: this.src,
		startElement: this,
		rel: 'imagezoom' // or 'lightbox'
	});
	imagezoom.show();
});

//Tabs
window.addEvent('domready', function(){
  if ($('a_photos') != null) $('a_photos').set('style', 'display:none');
  if ($('a_details') != null) $('a_details').set('style', 'display:none');
  $$('#main_tabs li').addEvent('click', function(event){
	event.stop();
	var el = this;
	var tabs = el.getParent('.tabs_parent').getParent();
	tabs.getElements('ul > li').removeClass('active');
	el.addClass('active');
	a = el.getElement('a');
    if ($('a_acomments') != null) $('a_acomments').set('style', 'display:none');
    if ($('a_photos') != null) $('a_photos').set('style', 'display:none');
    if ($('a_details') != null) $('a_details').set('style', 'display:none');
	$('a_' + a.id).set('style', 'display:block');
  });
  if ($('art_active') !=null)
    $('art_active').addEvent('click', function(event){
      $$('#art_actions div[id=art_action_links] span').fireEvent('click');      
    });
});
</script>
<div class="generic_layout_container layout_core_container_tabs">
<div class="tabs_alt tabs_parent">
  <ul id="main_tabs">
  <?php /* <li class="active"><a id="acomments" href="javascript:void(0);"><?php echo $this->translate('Comments') ?></a></li> */ ?>
    <?php if (count($this->paginator)) : ?>
    <li ><a id="photos" href="javascript:void(0);"><?php echo $this->translate('Photos') ?><span>(<?php echo $this->totalPhotos ?>)</span></a></li>
    <?php endif; ?>
    <?php if ($this->questions) : ?>
    <li ><a id="details" href="javascript:void(0);"><?php echo $this->translate('Details') ?></a></li>
    <?php endif; ?>
  </ul>
</div>
</div>

<div id="a_photos">

<?php //if (count($this->paginator)) : ?>
<!--<div class="art_photo_link">
<?php // echo $this->htmlLink($this->url(array('action' => 'allphoto', 'id' => $this->article->artarticle_id), "advancedarticles_category_specific"), $this->translate('View Photos'), array('class' => 'buttonlink icon_aphoto_all')); ?>
	<?php if ($this->photo_upload) :?>
<?php echo $this->htmlLink($this->url(array('action' => 'addnewphoto', 'id' => $this->article->artarticle_id), "advancedarticles_category_specific"), $this->translate('Upload Photos'), array('class' => 'buttonlink icon_aphoto_upload')); ?>
<?php endif; ?>
<?php if ($this->photo_edit) :?>
<?php echo $this->htmlLink($this->url(array('action' => 'editphoto', 'id' => $this->article->artarticle_id), "advancedarticles_category_specific"), $this->translate('Manage Photos'), array('class' => 'buttonlink icon_aphoto_edit')); ?>
<?php endif; ?>
</div>-->
 <ul class="thumbs thumbs_nocaptions">
 <?php foreach ($this->paginator as $item) : ?>
 <li>
 <!-- <a class="thumbs_photo" href="<?php echo $item->getHref(); ?>">
  <span style="background-image: url(<?php echo $item->getPhotoUrl('thumb.normal'); ?>);"></span>
  </a>-->
  <a class="example-image-link thumbs_photo" href="<?php echo $this->baseUrl().$item->getPhotoUrl(); ?>" data-lightbox="image1"><img src= <?php echo $this->baseUrl().$item->getPhotoUrl('thumb.normal'); ?> ></a>
 </li>
 <?php endforeach; ?>
</ul>
</div>
<?php //endif; ?>
</div>

<div id="a_acomments">
<?php //echo $this->action("list", "comment", "core", array("type"=>"artarticle", "id"=>$this->article->artarticle_id)) ?>
</div>

<div id="a_details">
<?php if ($this->questions) : ?>
<div class="profile_fields">
<?php echo $this->questions ?>
</div>
<?php endif; ?>
</div>
<script src="<?php echo $this->baseUrl(); ?>/application/modules/User/externals/scripts/lightbox-plus-jquery.min.js"></script>
<script>jQuery.noConflict();</script>
