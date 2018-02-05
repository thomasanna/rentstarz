<h2>
  <?php echo $this->translate("Manage Rating") ?>
</h2>
<div class='admin_search'>
  <?php echo $this->formFilter->render($this) ?>
</div>
<div class='admin_results'>
	
  <div>
    <?php $count = $this->paginator->getTotalItemCount() ?>
    <?php echo $this->translate(array("%s result found", "%s results found", $count),
        $this->locale()->toNumber($count)) ?>
  </div>
  <div>
    <?php echo $this->paginationControl($this->paginator, null, null, array(
      'pageAsQuery' => true,
      //'params' => $this->formValues,
    )); ?>
    
    Rating Interval : <?php echo $this->ratinginterval; ?> days
  <a class='smoothbox' href='<?php echo $this->url(array('action' => 'editratinginterval'));?>'>
                <?php echo $this->translate('Change rating interval') ?>
              </a>
  </div>
  
        
  
</div>

<br />

<div class="admin_table_form">

  <table class='admin_table'>
    <thead>
      <tr>
     
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('user_id', 'DESC');"><?php echo $this->translate("ID") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('displayname', 'DESC');"><?php echo $this->translate("Displayname") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('rating_value', 'ASC');"><?php echo $this->translate("Total Average Rate") ?></a></th>
         <th style='width: 1%;' class='admin_table_options' colspan="2"><?php echo $this->translate("Options") ?></th>
      </tr>
             
    </thead>
    <tbody>
      
       <?php if( count($this->paginator) ): ?>
        <?php foreach( $this->paginator as $item ):
            
          ?>
        <tr>

       <td><?php echo $item['user_id']; ?></td>
      
       <td><?php echo $item['displayname']; ?></td>
       <td><?php echo $item['rating_value']; ?></td>
      
        <td> <a class='smoothbox'  href='<?php echo $this->url(array('action' => 'enablerating', 'id' => $item['user_id']));?>'>
       
                  <?php 
                if($item['enable_rating_value'] ==1):
                  
                echo $this->translate("Disable"); 
                  
                else:
                  
                echo $this->translate("Enable") ;
                   
                endif;
                  ?>
                </a></td>
                
        <td>
        
         <a class='smoothbox' href='<?php echo $this->url(array('action' => 'ratinginfo', 'id' => $item->user_id));?>'>
                <?php echo $this->translate('View Details') ?>
              </a>
        
        
        </td>        
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
