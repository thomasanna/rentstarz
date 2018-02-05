<h2 style="text-align: center; margin-top: 15px;">
  <?php echo $this->translate("Rating Info - ") .$this->objectData->displayname;?>
</h2>



<div class='admin_results'>
	
  <div style= "margin-right: 11px;margin-left: 12px;">
    <?php $count = $this->paginator->getTotalItemCount() ?>
    <?php echo $this->translate(array("%s result found", "%s results found", $count),
        $this->locale()->toNumber($count)) ?>
  </div>
  <div style= "margin-right: 11px;margin-left: 12px;">
    <?php echo $this->paginationControl($this->paginator, null, null, array(
      'pageAsQuery' => true,
      //'params' => $this->formValues,
    )); ?>
  </div>
</div>

<br />


<div class="admin_table_form" style= "margin-right: 11px;margin-left: 12px;">

  <table class='admin_table'>
    <thead>
      <tr>
     
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('user_id', 'DESC');"><?php echo $this->translate("ID") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('displayname', 'DESC');"><?php echo $this->translate("User Name") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('displayname', 'DESC');"><?php echo $this->translate("Profile Type") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('rating_value', 'ASC');"><?php echo $this->translate("Average Rate") ?></a></th>

      </tr>
             
    </thead>
    <tbody>
      
       <?php if( count($this->paginator) ): ?>
        <?php foreach( $this->paginator as $item ):
            
          ?>
        <tr>

       <td><?php echo $item['subject_id']; ?></td>
      
       <td><?php echo $item['displayname']; ?></td>
       <td><?php if($item['level_id'] == 6): ?>
       
        Landlord
       <?php else:?>
       
       Tenant
       
       <?php endif;?>
       
       
       </td>
       <td><?php echo $item['rate_value']; ?></td>
      
        
        
          
       </tr>

     <?php endforeach; ?>
      <?php endif; ?>
    </tbody>
  </table>
  <br />	
</div>  
