<h2>
  <?php echo $this->translate("Manage Tips") ?>
</h2>

<div class='admin_results'>
	<div><a href="<?php echo $this->url(array('action' => 'addsurveyquestions'));?>">Create Survey Question</a></div>
<div><a class='smoothbox'  href='<?php echo $this->url(array('action' => 'surveyrespondlaterduration'));?>'>
                  <?php echo $this->translate("Survey Respond Later Duration") ?>
    </a></div>
  </div>
<br />
<div class="admin_table_form">

 <table class='admin_table'>
    <thead>
      <tr>
     
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('id', 'DESC');"><?php echo $this->translate("ID") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('title', 'ASC');"><?php echo $this->translate("Questions") ?></a></th>
         <th style='width: 1%;' class='admin_table_options' colspan="3"><?php echo $this->translate("Options") ?></th>
      </tr>
             
    </thead>
    <tbody>
      
       <?php if( count($this->surveyData) ): ?>
        <?php foreach( $this->surveyData as $item ):?>
        <tr>
       <td><?php echo $item['id']; ?></td>
       <td><?php echo $item['questions']; ?></td>
       <td> <a class='smoothbox'  href='<?php echo $this->url(array('action' => 'addsurveyansweroptions', 'id' => $item['id']));?>'>
                  <?php echo $this->translate("Add Answer Options") ?>
                </a></td>
       <td> <a class='smoothbox'  href='<?php echo $this->url(array('action' => 'editsurveyquestion', 'id' => $item['id']));?>'>
                  <?php echo $this->translate("edit") ?>
                </a></td>
       <td> <a class='smoothbox'  href='<?php echo $this->url(array('action' => 'deletesurveyquestion', 'id' => $item['id']));?>'>
                  <?php echo $this->translate("delete") ?>
                </a></td>
       </tr>

     <?php endforeach; ?>
      <?php endif; ?>
    </tbody>
  </table>
  <br />	
</div>   
