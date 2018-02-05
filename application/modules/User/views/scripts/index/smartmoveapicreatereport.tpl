<script src="/application/modules/User/externals/scripts/message_notififaction.js"></script>
<script>
<?php $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); ?>
var viewer_identity='<?php echo $viwer_id; ?>';
</script>
<div class="property_requests_content generic_layout_container layout_middle">
<div class="headline">
  <h2>Process Application</h2>
</div>
<div class="exam_content_div">
   <div class="message" style="color: red;text-align: center;margin-bottom: 12px;"><?php echo $this->message;?></div>
     <?php if($this->smartmoveapiApplicationData->IdmaVerificationStatus =='Unverified' ): ?>
      <?php if(!empty($this->QuestionArray)): ?>
       <div class="questions_content">
	
        <?php
        $i=0;
       foreach($this->QuestionArray as $Question):
            $i = $i+1;
            ?>
            <div class="pro_field_wrapper">
            <span class="prty_lablel pro_label question"  data-qid = "<?php echo $Question['Id'];?>"><?php echo $Question['Text'];?> <span style="color:red">*</span></span>
            <select name="answer"   class="prty_field answer_<?php echo $i;?>" data-qid = "<?php echo $Question['Id'];?>">
            <?php foreach($Question['Answers'] as $Answer): ?>
            <option value="<?php echo $Answer['Id'];?>"><?php echo $Answer['Text'];?></option>
            <?php endforeach;?>
            </select>
            </div> <br>
       <?php endforeach; ?>
      <div class="pro_field_wrapper">
        <span class="prty_lablel pro_label"></span>
        <button class="examevaluate_submit_btn" type="button" value="Save" name="">Submit</button>
      </div><br>
    </div>
    <?php else: ?>
    <div class="message1" style="text-align: center;">Please contact with Relationship Manager, Contact Number is 866.775.0961  </div>
    <?php endif;?>
    <?php endif;?>
    <div class="loader" style="display:none"></div>
    </div>
</div>

<script type="text/javascript">
jQuery('.examevaluate_submit_btn').on('click',function(){
    jQuery('.examevaluate_submit_btn').css('display','none');
    jQuery('.loader').css('display','block');
     var oData       = new Object();
     var qn_count = '<?php echo $i;?>';
     var answer_ids ='';
     for(var i=1; i<=qn_count; i++){
        var answer_ids = answer_ids + ','+jQuery('.answer_'+i).val();
     }
     var SmartmoveApplicationId  = '<?php echo $this->SmartmoveApplicationId;?>';
     oData.SmartmoveApplicationId = SmartmoveApplicationId;
     oData.answer_ids = answer_ids;
     var url    =   '<?php echo $this->baseUrl()?>' + '/user/index/smartmoveapireportdone';
     jQuery.ajax({
                        url:  url,
                        data: oData,
                        dataType: 'json',
                        type: 'POST',
                        success: function (data) {
                        if(data.status == true){
                            if(data.IdmaVerificationStatus == 'ManualVerificationRequired'){
                                //alert('ManualVerificationRequired');
                                jQuery('.questions_content'). css('display','none');
                                jQuery('.message').text('');
                                jQuery('.message').text('You need manual verification to generate report. Please contact with Relationship Manager with your registered email id.');
                            }
                            else{
                                if(data.Evaluation == 'Fail' || data.Evaluation == 'AdditionalQuestions'){
                                    location.reload();
                                }
                                else{                                
                                location.href = '<?php echo $this->baseUrl()?>' + '/payment';
                                }
                            }
                        }
                        else{
                            if(data.IdmaVerificationStatus == 'ManualVerificationRequired'){
                            //alert('ManualVerificationRequired');
                            jQuery('.questions_content'). css('display','none');
                            jQuery('.message').text('');
                            jQuery('.message').text('You need manual verification to generate report. Please contact with Relationship Manager with your registered email id.');
                            jQuery('.loader').css('display','none');
                            }
                            else{
								 if(data.Evaluation == 'Fail'){
									location.reload(); 
								 }
								
							}
                            //jQuery('.examevaluate_submit_btn').css('display','block');
                           // jQuery('.loader').css('display','none');
                        }
                     },
                       error: function(e){
                           jQuery('.examevaluate_submit_btn').css('display','block');
                           jQuery('.loader').css('display','none');
                          }
                    });
});
</script>
