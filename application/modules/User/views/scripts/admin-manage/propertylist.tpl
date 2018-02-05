<h2>
  <?php echo $this->translate("Manage Properties") ?>
  <?php $viewer     = Engine_Api::_()->user()->getViewer(); ?>
</h2>

<div class='admin_search'>
  <?php echo $this->formFilter->render($this) ?>
</div>

<div class='admin_results'>
	
  <div>
    <?php $count = $this->paginator->getTotalItemCount() ?>
    <?php echo $this->translate(array("%s Property found", "%s Properties found", $count),
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
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('displayname', 'ASC');"><?php echo $this->translate("Landlord Name") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('rental_type', 'ASC');"><?php echo $this->translate("Rental Type") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('price', 'ASC');"><?php echo $this->translate("Price") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('country', 'ASC');"><?php echo $this->translate("Country") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('state', 'ASC');"><?php echo $this->translate("State") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('city', 'ASC');"><?php echo $this->translate("City") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('created_at', 'ASC');"><?php echo $this->translate("Created On") ?></a></th>
       
        
         <th style='width: 1%;text-align:center;' class='admin_table_options' colspan="4"><?php echo $this->translate("Options") ?></th>
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
       <td><?php echo $item['rental_type']; ?></td>
       <td><?php echo $item['price']; ?></td>
       <td><?php echo $item['country']; ?></td>
       <td><?php echo $item['state']; ?></td>
       <td><?php echo $item['city']; ?></td>
       <?php date_default_timezone_set($viewer->timezone);
       $created_date = $this->timestamp($item['created_at']);
       ?>
       <td><?php echo $created_date; ?></td>
      
       <td> <a class='smoothbox'  href='<?php echo $this->url(array('action' => 'editproperty', 'pid' => $item['id']));?>'>
       
                  <?php 
                if($item['enable'] ==1):
                  
                echo $this->translate("Disable"); 
                  
                else:
                  
                echo $this->translate("Enable") ;
                   
                endif;
                  ?>
                </a></td>
       <td> <a class='smoothbox'  href='<?php echo $this->url(array('action' => 'deleteproperty', 'pid' => $item['id'],'action_id' =>$item['action_id']));?>'>
                  <?php echo $this->translate("delete") ?>
                </a></td>
                
	   <td> <a href='<?php echo $this->baseUrl();?>/property/edit/<?php echo $item['id'];?>'>
		  <?php echo $this->translate("edit") ?>
		</a></td>
		
		<td> <a href='<?php echo $this->baseUrl();?>/property/<?php echo $item['id'];?>/admin/1'>
		  <?php echo $this->translate("view details") ?>
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
