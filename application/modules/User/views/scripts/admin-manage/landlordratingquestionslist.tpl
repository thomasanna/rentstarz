<h2>
  <?php echo $this->translate("Manage Rating Questions") ?>
</h2>
<div class='admin_search'>
  <?php echo $this->formFilter->render($this) ?>
</div>
<div class='admin_results'></br>
	<div><a href="<?php echo $this->url(array('action' => 'addratingquestions'));?>">Add Rating Questions</a></div></br>
		<div class="tabs" >
		<ul class="navigation"></br>
	    <li class="active"><div><a href="<?php echo $this->url(array('action' => 'landlordratingquestionslist'));?>">Landlord</a></div></li>
	    <li><div><a href="<?php echo $this->url(array('action' => 'tenantratingquestionslist'));?>">Renter</a></div></li>
        <li><div><a href="">Service</a></div></li>
        </ul>
</div></br>
  <div>
    <?php $count = $this->paginator->getTotalItemCount() ?>
    <?php echo $this->translate(array("%s question found", "%s questions found", $count),
        $this->locale()->toNumber($count)) ?>
  </div>
  <div>
    <?php echo $this->paginationControl($this->paginator, null, null, array(
      'pageAsQuery' => true,
      //'params' => $this->formValues,
    )); ?>
  </div>
</div>

<br />

<div class="admin_table_form">

  <table class='admin_table'>
    <thead>
      <tr>
     
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('id', 'DESC');"><?php echo $this->translate("ID") ?></a></th>
       <!-- <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('profile_type', 'DESC');"><?php echo $this->translate("Profile Type") ?></a></th>-->
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('questions', 'ASC');"><?php echo $this->translate("Questions") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('status', 'ASC');"><?php echo $this->translate("Status") ?></a></th>
         <th style='width: 1%;' class='admin_table_options' colspan="2"><?php echo $this->translate("Options") ?></th>
      </tr>
             
    </thead>
    <tbody>
      
       <?php if( count($this->paginator) ): ?>
        <?php foreach( $this->paginator as $item ):
            
          ?>
        <tr>
       <td><?php echo $item['id']; ?></td>
     <?php /*   <?php if($item['profile_type'] == 1):?>
       <td>Tenant</td>
       <?php else:?>
       <td>Landlord</td>
       <?php endif;?> */ ?>
       <td><?php echo $item['questions']; ?></td>
       <?php if($item['status'] == 0):?>
       <td><?php echo "Positive"; ?></td>
       <?php else:?>
        <td><?php echo "Negative"; ?></td>
        <?php endif;?>
       <td> <a class='smoothbox'  href='<?php echo $this->url(array('action' => 'editratingquestions', 'id' => $item['id']));?>'>
                  <?php echo $this->translate("edit") ?>
                </a></td>
       <td> <a class='smoothbox'  href='<?php echo $this->url(array('action' => 'deleteratingquestions', 'id' => $item['id']));?>'>
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
