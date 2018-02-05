<h2>
  <?php echo $this->translate("Renters") ?>
  <?php $viewer     = Engine_Api::_()->user()->getViewer(); ?>
</h2>


<div class='admin_search'>
  <?php echo $this->formFilter->render($this) ?>
</div>

<div class='admin_results'>
	
  <div>
    <?php $count = $this->paginator->getTotalItemCount() ?>
    <?php echo $this->translate(array("%s Renters found", "%s Renters found", $count),
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

<button id="exl">Download</button>

<div class="admin_table_form" id="content">

  <table class='admin_table'>
    <thead>
      <tr>
     
        <th style='width: 1%;'><a href="javascript:void(0);" id="mylink" onclick="javascript:changeOrder('user_id', 'DESC');"><?php echo $this->translate("ID") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" id="mylink" onclick="javascript:changeOrder('displayname', 'ASC');"><?php echo $this->translate("Renter Name") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('email', 'ASC');"><?php echo $this->translate("Email") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('state', 'ASC');"><?php echo $this->translate("State") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('city', 'ASC');"><?php echo $this->translate("City") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('created_at', 'ASC');"><?php echo $this->translate("Created On") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('created_at', 'ASC');"><?php echo $this->translate("Admin Enable") ?></a></th>

       
        
         <th style='width: 1%;text-align:center;' class='admin_table_options' colspan="4"><?php echo $this->translate("") ?></th>
      </tr>
             
    </thead>
    <tbody>
      
       <?php if( count($this->paginator) ): ?>
        <?php foreach( $this->paginator as $item ):
            
          ?>
        <tr>
       <td><?php echo $item['user_id']; ?></td>
       <td><?php echo $item['displayname']; ?></td>
       <td><?php echo $item['email']; ?></td>
       <td><?php echo $item['state']; ?></td>
       <td><?php echo $item['city']; ?></td>
       <?php date_default_timezone_set($viewer->timezone);
       $created_date = $this->timestamp($item['creation_date']);
       ?>
       <td><?php echo $created_date; ?></td>
       <td><?php echo $item['enabled']; ?></td>

       <td> <a class='smoothbox'  href='<?php echo $this->url(array('action' => 'editproperty', 'pid' => $item['user_id']));?>'>
                </a></td>		
		<td></td>
       </tr>

     <?php endforeach; ?>
      <?php endif; ?>
    </tbody>
  </table>
  <br />	
</div>    


<script type="text/javascript">
jQuery(document).ready(function() {
  jQuery("#exl").click(function(e) {
    e.preventDefault();
    //getting data from our table
    var data_type = 'data:application/vnd.ms-excel';
    var table_div = document.getElementById('content');
    var table_html = table_div.outerHTML.replace(/ /g, '%20');
    var a = document.createElement('a');
    document.body.appendChild(a);  // You need to add this line
    a.href = data_type + ', ' +
     table_html;
    a.download = 'exported_table_' + Math.floor((Math.random() * 9999999) + 1000000) + '.xls';
    a.click();
  });
});
</script>  


<script type="text/javascript">
  var currentOrder = '<?php echo $this->order ?>';
  var currentOrderDirection = '<?php echo $this->order_direction ?>';
  var changeOrder = function(order, default_direction){
    if( order == currentOrder ) {
      $('order_direction').value = ( currentOrderDirection == 'ASC' ? 'DESC' : 'ASC' );
    } else {
      $('order').value = order;
      $('order_direction').value = default_direction;
    }
  }
</script>  
