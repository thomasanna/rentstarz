<h2>
  <?php echo $this->translate("Manage Transunion") ?>
  <?php $viewer     = Engine_Api::_()->user()->getViewer(); ?>
</h2>


  <div class='tabs'>
    <div class="tabs">
    <ul class="navigation">
    <li class="active">
        <a class="" href="/admin/user/manage/userpackage">View Member package</a>
    </li>
    <li >
        <a class="" href="/admin/user/manage/userpackagemanage">Package Manage</a>
    </li>
      <li>
        <a class="" href="/admin/user/manage/videopayment">Paid members of video</a>
    </li>
</ul>  </div>
  </div>

<div class='admin_search'>
  <?php echo $this->formFilter->render($this) ?>
</div>
<div class='admin_results'>
	
  <div>
    <?php $count = $this->paginator->getTotalItemCount() ?>
    <?php echo $this->translate(array("%s Payment found", "%s payments found", $count),
        $this->locale()->toNumber($count)) ?>
  </div>
  <div>
    <?php echo $this->paginationControl($this->paginator, null, null, array(
      'pageAsQuery' => true,
      'params' => $this->formValues,
    )); ?>
  </div>
</div>
<div class="admin_table_form">

  <table class='admin_table'>
    <thead>
      <tr>
     
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('payment_id', 'DESC');"><?php echo $this->translate("Payment Id") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('displayname', 'ASC');"><?php echo $this->translate("Customer Name") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('package_type', 'ASC');"><?php echo $this->translate("Package Type") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('payment_amount', 'ASC');"><?php echo $this->translate("Payment Amount") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('first_name', 'ASC');"><?php echo $this->translate("Cardholder Name") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('street', 'ASC');"><?php echo $this->translate("Street Addess") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('state', 'ASC');"><?php echo $this->translate("State") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('city', 'ASC');"><?php echo $this->translate("City") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('zipcode', 'ASC');"><?php echo $this->translate("Zipcode") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('created_at', 'ASC');"><?php echo $this->translate("Created At") ?></a></th>
       
        
      </tr>
             
    </thead>
    <tbody>
      
       <?php if( count($this->paginator) ): ?>
        <?php foreach( $this->paginator as $item ):
            
          ?>
        <tr>
       <td><?php echo $item['payment_id']; ?></td>
	       <td><?php echo $item['displayname']; ?></td>
       <td><?php echo $item['package_type']; ?></td>
       <td><?php echo $item['payment_amount'].'$'; ?></td>
       <td><?php echo $item['first_name']; ?></td>
       <td><?php echo $item['street']; ?></td>
       <td><?php echo $item['state']; ?></td>
       <td><?php echo $item['city']; ?></td>
       <td><?php echo $item['zipcode']; ?></td>     
       <?php date_default_timezone_set($viewer->timezone);
       $created_date = $this->timestamp($item['created_at']);
       ?>
       <td><?php echo $created_date; ?></td>
      

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
