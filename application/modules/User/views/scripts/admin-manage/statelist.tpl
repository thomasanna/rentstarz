<h2>
  <?php echo $this->translate("Manage State") ?>
</h2>
<div class='admin_search'>
  <?php echo $this->formFilter->render($this) ?>
</div>
<div class='admin_results'>
	<div><a href="<?php echo $this->url(array('action' => 'addstate'));?>">ADD STATE</a></div>
  <div>
    <?php $count = $this->paginator->getTotalItemCount() ?>
    <?php echo $this->translate(array("%s states found", "%s states found", $count),
        $this->locale()->toNumber($count)) ?>
  </div>
  <div>
    <?php echo $this->paginationControl($this->paginator, null, null, array(
      'pageAsQuery' => true,
      'params' => $this->formValues,
    )); ?>
  </div>
</div>

<br />


<div class="admin_table_form">

  <table class='admin_table'>
    <thead>
      <tr>
     
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('state_id', 'DESC');"><?php echo $this->translate("ID") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('country', 'ASC');"><?php echo $this->translate("Country") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('state', 'ASC');"><?php echo $this->translate("State") ?></a></th>
         <th style='width: 1%;' class='admin_table_options' colspan="2"><?php echo $this->translate("Options") ?></th>
      </tr>
             
    </thead>
    <tbody>
      
       <?php if( count($this->paginator) ): ?>
        <?php foreach( $this->paginator as $item ):
            
          ?>
        <tr>
       <td><?php echo $item['state_id']; ?></td>
       <td><?php echo $item['country']; ?></td>
       <td><?php echo $item['state']; ?></td>
       <td> <a class='smoothbox'  href='<?php echo $this->url(array('action' => 'editstate', 'sid' => $item['state_id'] ,'cid'=>$item['country_id']));?>'>
                  <?php echo $this->translate("edit") ?>
                </a></td>
       <td> <a class='smoothbox'  href='<?php echo $this->url(array('action' => 'deletestate', 'sid' => $item['state_id']));?>'>
                  <?php echo $this->translate("delete") ?>
                </a></td>
       </tr>

     <?php endforeach; ?>
      <?php endif; ?>
    </tbody>
  </table>
  <br />	
</div>    
<script type="text/javascript">
  var currentOrder = '<?php echo $this->order ?>';
  var currentOrderDirection = '<?php echo $this->order_direction ?>';
  var changeOrder = function(order, default_direction){
    // Just change direction
    if( order == currentOrder ) {
      $('order_direction').value = ( currentOrderDirection == 'ASC' ? 'DESC' : 'ASC' );
    } else {
      $('order').value = order;
      $('order_direction').value = default_direction;
    }
    $('filter_form').submit();
  }
  
</script>  
