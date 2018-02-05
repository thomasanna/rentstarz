<h2>
  <?php echo $this->translate("Manage Price") ?>
</h2>

<div class='admin_results'>
	<div><a href="<?php echo $this->url(array('action' => 'addprice'));?>">Add Price</a></div>
	
  </div>
<br />
<div class="admin_table_form">

 <table class='admin_table'>
    <thead>
      <tr>
     
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('id', 'DESC');"><?php echo $this->translate("ID") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('title', 'ASC');"><?php echo $this->translate("Price range from") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('content', 'ASC');"><?php echo $this->translate("Price range to") ?></a></th>
         <th style='width: 1%;' class='admin_table_options' colspan="2"><?php echo $this->translate("Options") ?></th>
      </tr>
             
    </thead>
    <tbody>
      
       <?php if( count($this->priceData) ): ?>
        <?php foreach( $this->priceData as $item ):?>
        <tr>
       <td><?php echo $item['id']; ?></td>
       <td><?php echo $item['price_from']; ?></td>
       <td><?php echo $item['price_to']; ?></td>
       <td> <a class='smoothbox'  href='<?php echo $this->url(array('action' => 'editprice', 'id' => $item['id']));?>'>
                  <?php echo $this->translate("edit") ?>
                </a></td>
       <td> <a class='smoothbox'  href='<?php echo $this->url(array('action' => 'deleteprice', 'id' => $item['id']));?>'>
                  <?php echo $this->translate("delete") ?>
                </a></td>
       </tr>

     <?php endforeach; ?>
      <?php endif; ?>
    </tbody>
  </table>
  <br />	
</div>   
