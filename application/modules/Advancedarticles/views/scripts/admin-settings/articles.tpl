<h2>
  <?php echo $this->translate("Advanced Articles") ?>
</h2>
<?php $this->headScript()->appendFile($this->baseUrl().'/application/modules/Advancedarticles/externals/scripts/formcheck-yui.js');?>
<form id="formDonate" action="https://usd.swreg.org/cgi-bin/s.cgi?s=133827&p=133827-donate80&q=1&v=0&d=0&vp=5" method="post" target="_blank">
<div class="price">
<?php echo $this->translate('If you want to contribute to the further development of free products then you can donate for this purpose any sum of money:') ?>
<input type="text" name="vp" id="summ" value="5"  class="validate['required','digit[1,1000]']" disabled="disabled" /> $ 
<input type="submit" value="" class=button_donate />
</div>
</form>

<script type="text/javascript">
window.addEvent('domready', function(){
    $('summ').disabled = '';
    $('summ').focus();
    new FormCheck('formDonate');
    $('formDonate').addEvent('submit', function(){
        this.action = 'https://usd.swreg.org/cgi-bin/s.cgi?s=133827&p=133827-donate80&q=1&v=0&d=0&vp='+$('summ');
    });
});
</script>
<p>
  <?php echo $this->translate("ADVANCED_ARTICLES_DESCRIPTION") ?>
</p>
<br/>
<?php if( count($this->navigation) ): ?>
  <div class='tabs'>
    <?php echo $this->navigation()->menu()->setContainer($this->navigation)->render() ?>
  </div>
<?php endif; ?>

<script type="text/javascript">

en4.core.runonce.add(function(){$$('th.admin_table_short input[type=checkbox]').addEvent('click', function(){ $$('input[type=checkbox]:not(:disabled)').set('checked', $(this).get('checked')); })});
function changeOrder(order, by){
    $('order').value = order;
    $('by').value = by;
    $('filter_form').submit();
}
function deleteSelected() {
  var checkboxes = $$('.admin_table tr > td input[type=checkbox]');
  var selecteditems = [];

  checkboxes.each(function(item, index){
    var checked = item.get('checked');
    var value = item.get('value');
    if (checked == true && value != 'on'){
      selecteditems.push(value);
    }
  });
  $('ids').value = selecteditems;
  if (selecteditems.length > 0)
    $('delete_selected').submit();
}
</script>

<div class='admin_search'>
<?php echo $this->formFilter->render($this) ?>
</div>
<br />
<div class='admin_results'>
  <div>
    <?php $countArt = $this->paginator->getTotalItemCount() ?>
    <?php echo $this->translate(array("%s article found", "%s articles found", $countArt),
        $this->locale()->toNumber($countArt)) ?>
  </div>
  <div>
    <?php echo $this->paginationControl($this->paginator, null, null, array(
      'pageAsQuery' => true,
      'query' => $this->values,
    )); 
    ?>
  </div>
</div>

<br />

  <table class='admin_table'>
    <thead>
      <tr>
        <th style="width: 1%;" class="admin_table_short"><input type='checkbox' class='checkbox' /></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('artarticle_id', 'DESC');"><?php echo $this->translate("ID") ?></a></th>
        <th><a href="javascript:void(0);" onclick="javascript:changeOrder('title', 'DESC');"><?php echo $this->translate("Title") ?></a></th>
        <th><?php echo $this->translate("Owner") ?></th>
        <th><a href="javascript:void(0);" onclick="javascript:changeOrder('num_views', 'DESC');"><?php echo $this->translate("Views") ?></a></th>
        <!--<th><a href="javascript:void(0);" onclick="javascript:changeOrder('comment_count', 'DESC');"><?php //echo $this->translate("Comments") ?></a></th>-->
        <!--<th><a href="javascript:void(0);" onclick="javascript:changeOrder('like_count', 'DESC');"><?php //echo $this->translate("Likes") ?></a></th>-->
        <th><a href="javascript:void(0);" onclick="javascript:changeOrder('created_date', 'DESC');"><?php echo $this->translate("Date") ?></a></th>
        <th>&nbsp;</th>
        <th><?php echo $this->translate("Options") ?></th>
      </tr>
    </thead>
    <tbody>
      <?php if( count($this->paginator) ): ?>
        <?php foreach( $this->paginator as $item ):
          $user = $this->advancedarticlesUser($item->owner_id);
          ?>
          <tr>
            <td><input value=<?php echo $item->getIdentity();?> type='checkbox' class='checkbox'></td>
            <td><?php echo $item->artarticle_id ?></td>
            <td class="admin_table_bold"><?php echo $this->htmlLink($item->getHref(), $this->string()->truncate($item->getTitle(), 40), array('target' => '_blank')) ?></td>
            <td><?php echo $this->htmlLink($user->getHref(), (isset($user->username) ? $user->username : $user->getTitle()), array('target' => '_blank')) ?></td>
            <td><?php echo $item->num_views;?></td>
            <!--<td><?php // echo $item->comment_count;?></td>
            <td><?php //echo $item->like_count;?></td>  -->                      
            <td style="font-size:11px;"><?php echo $this->timestamp($item->created_date) ?></td>
            <td>
            <?php if($item->status == 'active') : ?>
              <img title='<?php echo $this->translate("Active") ?>' src="application/modules/Advancedarticles/externals/images/art_share.png" />
            <?php endif; ?>
            <?php if($item->status == 'inactive') : ?>
              <img title='<?php echo $this->translate("Inactive") ?>' src="application/modules/Advancedarticles/externals/images/non_art_share.png" />
            <?php endif; ?>            
            <?php if ($item->status == 'draft') : ?>
              <img title='<?php echo $this->translate("Draft") ?>' src="application/modules/Advancedarticles/externals/images/draft.png" />
            <?php endif; ?>
            <?php if ($item->featured) : ?>
              <img title='<?php echo $this->translate("Featured") ?>' src="application/modules/Advancedarticles/externals/images/featured.png" />
            <?php else : ?>
              <img title='<?php echo $this->translate("Not Featured") ?>' src="application/modules/Advancedarticles/externals/images/non_featured.png" />
            <?php endif; ?>                 
            <?php if ($item->sponsored) : ?>
              <img title='<?php echo $this->translate("Sponsored") ?>' src="application/modules/Advancedarticles/externals/images/sponsored.png" />
            <?php else : ?>
              <img title='<?php echo $this->translate("Not Sponsored") ?>' src="application/modules/Advancedarticles/externals/images/non_sponsored.png" />
            <?php endif; ?>             
            
            </td>
            <td>
              <a href='<?php echo $this->url(array('action' => 'edit', 'id' => $item->artarticle_id), "advancedarticles_category_specific");?>'>
                <?php echo $this->translate("edit") ?>
              </a>
              |
              <?php echo $this->htmlLink($this->url(array('action' => 'delete', 'id' => $item->artarticle_id), "advancedarticles_admin_categoties"), $this->translate('delete'), array(
                'class' => 'smoothbox', 'title' => $this->translate('Delete')));	?>
              |
              <a href="<?php echo $this->baseUrl().'/articles/addnewphoto/'.$item->artarticle_id?>">Upload photos</a>

              |
              <a href="<?php echo $this->baseUrl().'/articles/editphoto/'.$item->artarticle_id?>">Manage photos</a>

            </td>
          </tr>
        <?php endforeach; ?>
      <?php endif; ?>
    </tbody>
  </table>
<br />  
<div class='buttons'>
  <button onclick="javascript:deleteSelected();" type='submit'>
    <?php echo $this->translate("Delete Selected") ?>
  </button>
</div>
<form id='delete_selected' method='post' action='<?php echo $this->url(array('action' =>'deleteselected')) ?>'>
  <input type="hidden" id="ids" name="ids" value=""/>
</form>
