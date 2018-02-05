<h2>
  <?php echo $this->translate("Manage Property Requests") ?>
  <?php $viewer     = Engine_Api::_()->user()->getViewer(); ?>
</h2>

<div class='admin_search'>
  <?php echo $this->formFilter->render($this) ?>
</div>

<div class='admin_results'>
	
  <div>
    <?php $count = $this->paginator->getTotalItemCount() ?>
    <?php echo $this->translate(array("%s Property Request found", "%s Property Requests found", $count),
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
     
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('id', 'DESC');"><?php echo $this->translate("ID") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('property_name', 'ASC');"><?php echo $this->translate("Property Name") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('displayname', 'ASC');"><?php echo $this->translate("Renter Name") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('landlord_approve', 'ASC');"><?php echo $this->translate("Landlord approve") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('admin_approve', 'ASC');"><?php echo $this->translate("Admin Approve") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('created_at', 'ASC');"><?php echo $this->translate("Requested Date") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('admin_approve_date', 'ASC');"><?php echo $this->translate("Admin Approved Date") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('landlord_approve_date', 'ASC');"><?php echo $this->translate("Landlord Approved Date") ?></a></th>
        
         <th style='width: 1%;' class='admin_table_options' colspan="2"><?php echo $this->translate("Options") ?></th>
      </tr>
             
    </thead>
    <tbody>
      
       <?php if( count($this->paginator) ): ?>
        <?php foreach( $this->paginator as $item ):
            
          ?>
        <tr>
       <td><?php echo $item['id']; ?></td>
       <td><?php echo $item['property_name']; ?></td>
       <td><?php echo $item['displayname']; ?></td>
       <td><?php echo $item['landlord_approve']; ?></td>
       <td><?php echo $item['admin_approve']; ?></td>
       <?php date_default_timezone_set($viewer->timezone);
       $created_date = $this->timestamp($item['created_at']);
       ?>
       <td><?php echo $created_date; ?></td>
        <?php date_default_timezone_set($viewer->timezone);
       $admin_approve_date = $this->timestamp($item['admin_approve_date']);
       ?>
       <td><?php if($item['admin_approve'] == 1): echo $admin_approve_date; endif;?></td>
       <?php date_default_timezone_set($viewer->timezone);
       $landlord_approve_date = $this->timestamp($item['landlord_approve_date']);
       ?>
       <td><?php if($item['landlord_approve'] == 1): echo $landlord_approve_date; endif;?></td>

       <td> <a class='smoothbox'  href='<?php echo $this->url(array('action' => 'editpropertyrequest', 'id' => $item['id']));?>'>
                     <?php 
                if($item['admin_approve'] ==1):
                  
                echo $this->translate("Disable"); 
                  
                else:
                  
                echo $this->translate("Enable") ;
                   
                endif;
                  ?>
                </a></td>
              
       <td> <a class='smoothbox'  href='<?php echo $this->url(array('action' => 'deletepropertyrequest', 'id' => $item['id']));?>'>
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
