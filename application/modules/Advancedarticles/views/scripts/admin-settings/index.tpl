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
    <?php
      echo $this->navigation()->menu()->setContainer($this->navigation)->render()
    ?>
  </div>
<?php endif; ?>

<?php echo $this->form->render($this) ?>

<p>
  <?php echo $this->translate("ADVANCED_ARTICLES_DRAGDROP") ?>
</p>
<br />
<div class="admin_results">
  <div>
            <a href='<?php echo $this->url(array('action' => 'addcategory')) ?>' class="buttonlink smoothbox icon_add">
              <?php echo $this->translate("Add New Category") ?>
            </a>  
  </div>
  <div>
    <?php $categoriesCount = count($this->categories); ?>
    <?php echo $this->translate(array("%d category found","%d categories found", $categoriesCount), $categoriesCount); ?>
  </div>
  <div>
  </div>
</div>

<br />
<table class='admin_table' style="width: 100%;">
  <thead>
    <tr>
      <th style="width: 50%;">
        <?php echo $this->translate("Category Name") ?>
      </th>
      <th style="width: 45%;"></th>      
      <th style="width: 5%;">ID</th>
    </tr>
  </thead>
</table>  
<table class='admin_table' id='categoryTable' style="width: 100%;">
<tbody>
            <?php foreach ($this->categories as $category) : 
			$category = (object) $category;
			?>
			<tr id="beet_<?php echo $category->category_id; ?>" class='beet'>
				<td id='<?php echo $category->parent_id; ?>'><span id="row_draggable"></span><span class="action"></span></td>
				<td></td>
				<td></td>
			</tr>			
			<tr id="<?php echo $category->category_id; ?>" class="<?php echo $category->parent_id; ?>" >
				<td class='drop' style="padding-left: <?php echo 10+40 * $category->depth; ?>px; width: 50%;">
				<?php 
				$bold = 'bold';
				if ($category->parent_id) {
				  $bold = "noraml";
				}
				?>
					<span id="row_draggable" style="cursor:move; font-weight:<?php echo $bold?>;"><?php echo $category->name; ?></span>
					
					<span class="action" id="category_action_<?php echo $category->category_id; ?>" style="display: none; position:relative; z-index:10000; ">

						<a href="<?php echo $this->url(array('action' => 'editcategory', 'id' => $category->category_id)) ?>" class="smoothbox"><?php echo $this->translate('edit'); ?></a> | 

						<a href="<?php echo $this->url(array('action' => 'deletecategory', 'id' => $category->category_id)) ?>" class="smoothbox"><?php echo $this->translate('delete'); ?></a>

					</span>
				</td>
				
				<td style="width: 45%;"></td>
				<td style="width: 5%;"><?php echo $category->category_id; ?></td>
			</tr>
            <?php endforeach; ?>
</tbody>			
</table>

<script type="text/javascript">
window.addEvent('domready', function(){

$$('#categoryTable tr').addEvent('mouseover', function(event){
    event.stop();
    var el = this;
    if (el.id == 0 || el.get('class') == 'beet') return;
    el.getElement('span.action').setStyles({display: 'inline'});
    el.setStyles({background: '#f8f8f8'});
});

$$('#categoryTable tr').addEvent('mouseout', function(event){
    event.stop();
    var el = this;
    if (el.id == 0 || el.get('class') == 'beet') return;
    el.getElement('span.action').setStyles({display: 'none'});
    el.setStyles({background: 'none'});
});
  $$('#categoryTable tr').addEvent('mousedown', function(event){
    event.stop();
    if (this.id == 0 || this.get('class') == 'beet') return;
    // `this` refers to the element with the .item class
    var shirt = this;
    var beet = $('beet_'+this.id);
    
    var clone = shirt.clone().setStyles(shirt.getCoordinates()).setStyles({
      opacity: 0.7,
      position: 'absolute',
	  width: 300
    }).inject(document.body);

	var dragContainer = $('categoryTable');

	var dragHandle = $('row_draggable');

   var drag = new Drag.Move(clone, {
	  
	  container: dragContainer,
      droppables: $$('#categoryTable tr'),
	  handle: dragHandle,

      onDrop: function(dragging, cart){

        dragging.destroy();

        if (cart != null){
          if (cart.get('class') == 'beet' && 'beet_'+cart.id != shirt.id && shirt.id != cart.getFirst().id) {
            updateCategory(shirt);
            left = 10;
            weight = 'bold';
            if (cart.getFirst().id > 0) {
              weight='normal';
              left=50;
            }
            shirt.getFirst().setStyle('padding-left', left);
            shirt.getFirst().getFirst().setStyle('font-weight', weight);
            shirt.inject(cart, 'before');
            beet.inject(shirt, 'before');
            beet.getFirst().id = cart.id.replace('beet_', '');
            shirt.set('class', cart.getFirst().id); //parent_id
            cart.highlight('#7389AE', '#FFF');
            
            Sort.send('id=' + shirt.id + '&parent_id=' + shirt.get('class') + sortCategory());
          }          

          if (cart.get('class') == 0 && cart.id != shirt.id) {
            updateCategory(shirt);            
            shirt.set('class', cart.id); //parent_id
            shirt.getFirst().setStyle('padding-left', 50);
            shirt.getFirst().getFirst().setStyle('font-weight', 'normal');
            shirt.inject(cart, 'after');
            beet.inject(shirt, 'before');
            beet.getFirst().id = cart.id;
            cart.highlight('#7389AE', '#FFF');
            
            Sort.send('id=' + shirt.id + '&parent_id=' + shirt.get('class') + sortCategory());
          }
        }
      },
      onEnter: function(dragging, cart){
        cart.tween('background-color', '#98B5C1');
        if (cart.get('class') > 0 && cart.id != 0)
            clone.tween('background-color',  '#ff0000');
        if (cart.get('class') == 'beet')
            cart.tween('background-color',  '#9fd7b8');    
      },
      onLeave: function(dragging, cart){
        cart.tween('background-color', '#FFF');
        clone.tween('background-color', '#FFF');
      },
      onCancel: function(dragging){
        dragging.destroy();
      }
    });
    drag.start(event);

	});


  //Sort
  Sort = new Request({
    url: "<?php echo $this->url(array('action' => 'sort'), 'advancedarticles_admin_categoties') ?>",
    method: 'post',
    onSuccess: function(responseText){
    }
  });
});

function updateCategory(shirt) {
            tr = $('categoryTable').getElements('tr');
            tr.each(function(item) {
                if (item.getFirst().id == shirt.id)
                  item.getFirst().id = 0;
                if (item.get('class') == shirt.id) {
                  item.set('class', 0);
                  item.getFirst().setStyle('padding-left', 10);
                  item.getFirst().getFirst().setStyle('font-weight', 'bold');
                }
            });
}

function sortCategory() {
            sort_id = '';
            sort_ind = '';
            i=1;
            tr = $('categoryTable').getElements('tr');
            tr.each(function(item) {
                if (item.get('class') != 'beet') {
                  sort_id = sort_id + item.id+',';
                  sort_ind = sort_ind + i +',';
                  i++;
                }  
            });
            
            return '&sortID='+sort_id+'&sortIND='+sort_ind;
}
</script>