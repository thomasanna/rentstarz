<h2>
  <?php echo $this->translate("Manage SmartMove Api Question Answer") ?>
</h2>
<div class='admin_search'>
  <?php echo $this->formFilter->render($this) ?>
</div>
<div class='admin_results'>
	
	<div><h2>Question   :    <?php echo $this->smartmoveapiquestionsData->qtext;?></h2></div>

    <div style="display: block;margin-left: 0px;">
    <?php $count = $this->paginator->getTotalItemCount() ?>
    <?php echo $this->translate(array("%s answer found", "%s answers found", $count),
        $this->locale()->toNumber($count)) ?>
    </div>
    <div>
    <?php echo $this->paginationControl($this->paginator, null, null, array(
      'pageAsQuery' => true,
      //'params' => $this->formValues,
    )); ?>
    </div>

</div>

<br />

<div class="admin_table_form">

  <table class='admin_table'>
    <thead>
      <tr>
     
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('qid', 'DESC');"><?php echo $this->translate("ID") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('answer_text', 'DESC');"><?php echo $this->translate("Answertext") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('answer_description', 'ASC');"><?php echo $this->translate("AnswerDescription") ?></a></th>

         <th style='width: 1%;' class='admin_table_options' colspan="3"><?php echo $this->translate("Options") ?></th>
      </tr>
             
    </thead>
    <tbody>
      
       <?php if( count($this->paginator) ): ?>
        <?php foreach( $this->paginator as $item ):
            
          ?>
        <tr>

       <td><?php echo $item['qid']; ?></td>
       <td><?php echo $item['answer_text']; ?></td>
       <td><?php echo $item['answer_description']; ?></td>


       <td> <a class='smoothbox'  href='<?php echo $this->url(array('action' => 'editsmartmoveapiquestionanswer', 'aid' => $item['id']));?>'>
                  <?php echo $this->translate("edit") ?>
                </a></td>
       <td> <a class='smoothbox'  href='<?php echo $this->url(array('action' => 'deletesmartmoveapiquestionanswer', 'aid' => $item['id']));?>'>
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
