
 <table class='admin_table admin_table_available'>
    <thead>
      <tr>
     
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('id', 'DESC');"><?php echo $this->translate("Name") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('id', 'DESC');"><?php echo $this->translate("Email") ?></a></th> 
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('id', 'DESC');"><?php echo $this->translate("Rented properties") ?></a></th>
       
      </tr>
             
    </thead>
    <tbody>
      
      <?php if( count($this->rented_property) ): ?>
        <?php foreach( $this->rented_property as $item ):?>
        <tr>
       <td><?php echo $item['displayname']; ?></td>
       <td><?php echo $item['email']; ?></td>          
       <td>  <?php echo $item['count_rented']; ?>  </td>
       </tr>

     <?php endforeach; ?>
      <?php endif; ?> 
    </tbody>
  </table>
  <br />	

