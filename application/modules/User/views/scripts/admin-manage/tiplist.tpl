<h2>
  <?php echo $this->translate("Manage Tips") ?>
</h2>

<div class='admin_results'>
	<div><a href="<?php echo $this->url(array('action' => 'createtip'));?>">Create Tip</a></div>
	<!--<div><a href="<?php echo $this->url(array('action' => 'createtip'));?>">Create Tip</a></div>-->
	<div><a class='smoothbox'  href='<?php echo $this->url(array('action' => 'tipduration'));?>'>
                  <?php echo $this->translate("Change Tip Duration") ?>
    </a></div>
  </div>
<br />
<div class="admin_table_form">

 <table class='admin_table'>
    <thead>
      <tr>
     
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('id', 'DESC');"><?php echo $this->translate("ID") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('title', 'ASC');"><?php echo $this->translate("Type") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('content', 'ASC');"><?php echo $this->translate("Content") ?></a></th>
         <th style='width: 1%;' class='admin_table_options' colspan="2"><?php echo $this->translate("Options") ?></th>
      </tr>
             
    </thead>
    <tbody>
      
       <?php if( count($this->tipData) ): ?>
        <?php foreach( $this->tipData as $item ):?>
        <tr>
       <td><?php echo $item['id']; ?></td>
       <td><?php echo $item['type']; ?></td>
       <td><?php echo $item['content']; ?></td>
       <td> <a class='smoothbox'  href='<?php echo $this->url(array('action' => 'tipedit', 'id' => $item['id']));?>'>
                  <?php echo $this->translate("edit") ?>
                </a></td>
       <td> <a class='smoothbox'  href='<?php echo $this->url(array('action' => 'tipdelete', 'id' => $item['id']));?>'>
                  <?php echo $this->translate("delete") ?>
                </a></td>
       </tr>

     <?php endforeach; ?>
      <?php endif; ?>
    </tbody>
  </table>
  <br />	
</div>   
