<script type="text/javascript">
    function multiDelete()
    {
        return confirm("<?php echo $this->translate('Are you sure you want to delete the selected items?'); ?>");
    }

    en4.core.runonce.add(function(){
		$$('th.admin_table_short input[type=checkbox]').addEvent('click', function(){ 
			$$('td.checksub input[type=checkbox]').each(function(i){
	 			i.checked = $$('th.admin_table_short input[type=checkbox]')[0].checked;
			});
		});
		$$('td.checksub input[type=checkbox]').addEvent('click', function(){
			var checks = $$('td.checksub input[type=checkbox]');
			var flag = true;
			for (i = 0; i < checks.length; i++) {
				if (checks[i].checked == false) {
					flag = false;
				}
			}
			if (flag) {
				$$('th.admin_table_short input[type=checkbox]')[0].checked = true;
			}
			else {
				$$('th.admin_table_short input[type=checkbox]')[0].checked = false;
			}
		});
	});
</script>
<h2><?php echo $this->translate("YouNet Responsive Purity Plugin") ?></h2>

<?php if (count($this->navigation)): ?>
    <div class='tabs'>
        <?php
        // Render the menu
        echo $this->navigation()->menu()->setContainer($this->navigation)->render()
        ?>
    </div>
<?php endif; ?>

<?php if ($this->paginator->getTotalItemCount() == 5): ?>
	<div class="tip">
		<span><?php echo $this -> translate('You have reached the item slider limitation.');?></span>
	</div>
<?php else:?>
<div style="padding: 5px">  
<?php echo $this->htmlLink(array('route' => 'admin_default', 'module' => 'ynresponsivepurity', 'controller' => 'manage-slider', 'action' => 'create'), $this->translate('Add New Item'), array(
      'class' => 'smoothbox buttonlink',
      'style' => 'background-image: url(application/modules/User/externals/images/friends/add.png);')) ?>
</div>
<?php endif;?>

<br />
<?php if (count($this->paginator)): ?>
    <form id='multidelete_form' method="post" action="<?php echo $this->url(); ?>" onSubmit="return multiDelete()">
        <div class="table_scroll">
            <table class='admin_table' style="position: relative;">
                <thead>
                    <tr>
                        <th class='admin_table_short'><input type='checkbox' class='checkbox' /></th>
                        <th style="width: 20%">
                             <?php echo $this->translate("Title") ?>
                        </th>
                        <th style="width: 20%">
                            <?php echo $this->translate("Link") ?>
                        </th>
                        <th style="width: 40%">
                            <?php echo $this->translate("Description") ?>
                        </th>
                        <th style="width: 10%">
                            <?php echo $this->translate("Photo") ?>
                        </th>
                        <th style="width: 10%">
                             <?php echo $this->translate("Options") ?>
                        </th>
                    </tr>
                </thead>
                <tbody id="demo-list">
                    <?php foreach ($this->paginator as $item):?>
                        <tr id='slider_item_<?php echo $item->getIdentity() ?>'>
                            <td class="checksub"><input type='checkbox' class='checkbox' name='delete_<?php echo $item->getIdentity(); ?>' value='<?php echo $item -> getIdentity(); ?>' /></td>
                            <td><?php echo $item -> title?></td>
                            <td><?php echo $item -> link?></td>
                            <td><?php echo $item -> description?></td>
                            <td>
                        		<?php $image_url = $item -> getPhotoUrl("thumb.icon");?>
                        		<img width="100px" src="<?php echo $image_url;?>" />
                            </td>
                            <td>
                                <?php
                                echo $this->htmlLink(array('route' => 'admin_default', 'module' => 'ynresponsivepurity', 'controller' => 'manage-slider', 'action' => 'edit', 'id' => $item -> getIdentity()), $this->translate('edit'), array('class' => 'smoothbox'));
                                ?>
                                |
                                <?php
                                echo $this->htmlLink(array('route' => 'admin_default', 'module' => 'ynresponsivepurity', 'controller' => 'manage-slider', 'action' => 'delete', 'id' => $item -> getIdentity()), $this->translate('delete'), array('class' => 'smoothbox'));
                                ?>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        </div>
        <br />

        <div class='buttons'>
            <button type='submit'><?php echo $this->translate("Delete Selected") ?></button>
        </div>
    </form>
    <br />
    <div>
        <?php echo $this->paginationControl($this->paginator); ?>
    </div>
    <script type="text/javascript">
        window.addEvent('domready', function() {
            new Sortables('demo-list', {
                contrain: false,
                clone: true,
                handle: 'span',
                opacity: 0.5,
                revert: true,
                onComplete: function(){
                    new Request.JSON({
                        url: '<?php echo $this->url(array('controller'=>'manage-slider','action'=>'sort'), 'admin_default') ?>',
                        noCache: true,
                        data: {
                            'format': 'json',
                            'order': this.serialize().toString(),
                        }
                    }).send();
                }
            });
        });
    </script>
<?php else: ?>
    <div class="tip">
        <span>
            <?php echo $this->translate("There are no slider items yet.") ?>
        </span>
    </div>
<?php endif; ?>
