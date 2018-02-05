<h2>
  <?php echo $this->translate("Landlords") ?>
  <?php $viewer     = Engine_Api::_()->user()->getViewer(); ?>
</h2>

<div><select id="property" name="formproperty" >
<option value="">Select...</option>
<option value="Rented" id="rented">Rented</option>
<option value="Available" id="available">Available</option>
</select><span style="margin-left:12px;"><button id="exl">Download</button></span></br></div>

<div class="admin_table_form" id="content">

  <table class='admin_table'>
    <thead>
      <tr>     
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('displayname', 'DESC');"><?php echo $this->translate("Name") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('email', 'DESC');"><?php echo $this->translate("Email") ?></a></th> 
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('count_property', 'DESC');"><?php echo $this->translate("No of Properties") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('available_property', 'DESC');"><?php echo $this->translate("Available properties") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('rented_property', 'DESC');"><?php echo $this->translate("Rented properties") ?></a></th> 
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('id', 'DESC');"><?php echo $this->translate("Properties") ?></a></th>
   </tr>
             
    </thead>
    <tbody>
      
    
        <?php foreach( $this->landlordpropertyData as $item ):?>
        <tr>
       <td><?php echo $item['displayname']; ?></td>
       <td><?php echo $item['email']; ?></td> 
       <td><?php echo $item['count_property']; ?></td>     
       <td><?php echo  $item['available_property']; ?></td>
       <td><?php echo  $item['rented_property']; ?></td> 
       <td>
	   <?php if($item['count_property']>0): ?>
	   <a href='<?php echo $this->url(array('action' => 'landlordproperties', 'id' => $item['user_id']));?>'>
       <?php echo $this->translate("Properties") ?></a>
       <?php endif; ?>
       </td>
       <?php endforeach; ?>

   </table>
  
  <br />	
</div>   


   
<script>

jQuery('select').on('change', function() {
  var status=this.value ;
	
    if(status=="Available"){
		
		var formURL    = '<?php echo $this->url(array('action' => 'available'));?>';
		
     }
   else if(status=="Rented"){	
	  
	var formURL    = '<?php echo $this->url(array('action' => 'rented'));?>';
	
   }
   else
   {
	
	  location.reload();
	
   }	
	jQuery.ajax( {
						url : formURL,
						dataType: 'json',						
						success: function (data) { 
						    jQuery(".admin_table_form").html('');
							var html   = jQuery(data.html);
								
								jQuery(".admin_table_form").append(html);
							
							},
							error: function(e){  
						   
						}
    });	
})
</script>
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

<script type="text/javascript">
jQuery(document).ready(function() {
  jQuery("#exl").click(function(e) {
    e.preventDefault();
    //getting data from our table
    var data_type = 'data:application/vnd.ms-excel';
    var table_div = document.getElementById('content');
    var table_html = table_div.outerHTML.replace(/ /g, '%20');
    var a = document.createElement('a');
    a.href = data_type + ', ' +
     table_html;
    a.download = 'exported_table_' + Math.floor((Math.random() * 9999999) + 1000000) + '.xls';
    a.click();
  });
});
</script>  
