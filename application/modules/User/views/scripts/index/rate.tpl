<script src="/application/modules/User/externals/scripts/message_notififaction.js"></script>
<script>
<?php 
$viewer     = Engine_Api::_()->user()->getViewer(); 
$viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity();
date_default_timezone_set($viewer->timezone);
 ?>

var viewer_identity='<?php echo $viwer_id; ?>';	
</script>


<div class="generic_layout_container layout_user_browse_menu">
<div class="headline">
  <h2>
	 <?php if($this->profile_type == 1):?>
     Rate Your Landlord
     <?php endif;?>
     <?php if($this->profile_type == 4):?>
     Rate your Renter
     <?php endif;?>
       </h2>
  <div class="tabs">
      </div>
</div>
</div>

<?php $property_count = count($this->propertyGrantedDAta);?>

<div class="rating_list_content generic_layout_container layout_middle">
	
	<div class="succes_msg" style="color:green; display:none" ></div>
	
	<div id="rating_ist_div">
		
		<?php $i = 1;?>
		<?php foreach($this->propertyGrantedDAta as $data):?>
		
		 <input type="hidden" class="propertyname_<?php  echo $data['property_id'];?>" value ="<?php  echo $data['property_name'];?>">
	     <input type="hidden" class="housingtype_<?php  echo $data['property_id'];?>" value ="<?php  echo $data['housing_type'];?>">
	     <input type="hidden" class="granted_date_<?php  echo $data['property_id'];?>" value ="<?php  echo $data['granted_date'];?>">
	     <input type="hidden" class="propertyid_<?php  echo $data['property_id'];?>" value ="<?php  echo $data['property_id'];?>">
		
		<div class="rating_<?php echo $i;?>">
		
		<div class="rating_title">
		 <?php if($this->profile_type == 1):?>

		<?php
		
		$userTable = Engine_Api::_()->getDbtable('users', 'user');
            
        $landlordData = $userTable->fetchRow($userTable->select()->where('user_id = ?', $data['landlord_id']));
		
		
		
		$fieldsByAlias = Engine_Api::_()->fields()->getFieldsObjectsByAlias($landlordData); //print_r($fieldsByAlias); exit("1111111");
				 $gender_id = $fieldsByAlias['gender']->getValue($landlordData); 
				if( $gender_id ) { 
				 
					$genderObj = Engine_Api::_()->fields()
					  ->getFieldsOptions($landlordData)
					  ->getRowMatching('option_id', $gender_id->value);
					  if( $genderObj ) {
					  $this->view->gender = $genderObj->label;
					  $gender = $genderObj->label;
					  
					  if($gender == 'Male'){
						  
						  $gen = 'his';
					  }
					  else{
						  
						  $gen = 'her';
					  }
					}
					  
				}?>
		 Rate your Landlord <a href="<?php echo $this->baseUrl().'/profile/'.$data['landlord_id']?>"><?php  echo $data['displayname'];?></a>&nbsp,&nbsp for <?php echo $gen;?> property <a href="<?php echo $this->baseUrl().'/property/'.$data['property_id']?>"> <?php  echo $data['property_name'];?></a>&nbsp,&nbsp you have rented since <?php  echo $this->timestamp($data['granted_date']) ;?>
		 
		 <?php endif;?>
		 
		 <?php if($this->profile_type == 4): ?>
		 
		 Rate your Renter <a href="<?php echo $this->baseUrl().'/profile/'.$data['tenant_id']?>"><?php  echo $data['displayname'];?></a>&nbsp,&nbsp who rented your property <a href="<?php echo $this->baseUrl().'/property/'.$data['property_id']?>"> <?php  echo $data['property_name'];?></a>&nbsp,&nbsp since <?php  echo $this->timestamp($data['granted_date']) ;?>
		 
		 <?php endif;?>
		</div> 
		 
		 <div class="rating_questions_list">
		 
		 <ul>
		 <?php $qn_count = 1; ?>
		 
		 <?php foreach($this->rating_questions as $rate_qns):?>
		 
		 <li>
		 
		 <div class="rate_qn_div"><span class="qn_count"><?php echo $qn_count;?></span><?php echo $rate_qns['questions'];?></div>
		
	     <?php if($this->profile_type == 1):?>
	     
	    
		 
		 <div id="stars-green" class="stars-green_<?php echo $qn_count;?>_<?php echo $data['property_id'];?>" data-qnId = <?php echo $rate_qns['id']?> ></div>
		 
		 <?php if($rate_qns['status'] == 0):?>
		 
		 <span class="stars_tooltip">Never</span>
		 
		 <script>jQuery(".stars-green_<?php echo $qn_count;?>_<?php echo $data['property_id'];?>").rating('create',{coloron:'orange',onClick:function(){ 
			
			var rating = this.attr('data-rating');
				
				if(rating == 1){
					
				if(jQuery(this). hasClass('selected')){
						
					jQuery(this).attr("data-rating", "0");
					jQuery(this). removeClass('selected');
					jQuery(this).next('.stars_tooltip').remove();
					jQuery(this).after('<span class="stars_tooltip">Never</span>');
						
					}
				else{
					jQuery(this). addClass('selected');
					jQuery(this).next('.stars_tooltip').remove();
					jQuery(this).after('<span class="stars_tooltip">Rarely</span>');
						
					}
					
				}
				if(rating == 2){
					jQuery(this).next('.stars_tooltip').remove();
					jQuery(this). removeClass('selected');
					jQuery(this).after('<span class="stars_tooltip">Sometimes</span>');
				}	
				if(rating == 3){
					jQuery(this).next('.stars_tooltip').remove();
					jQuery(this). removeClass('selected');
					jQuery(this).after('<span class="stars_tooltip">Most of the time</span>');
				}	
				if(rating == 4){
					jQuery(this).next('.stars_tooltip').remove();
					jQuery(this). removeClass('selected');
					jQuery(this).after('<span class="stars_tooltip">Always</span>');
				}
			 
			 }});</script>
			 
			 <?php else:?>
			 
			 <span class="stars_tooltip">Always</span>
		 
		 <script>jQuery(".stars-green_<?php echo $qn_count;?>_<?php echo $data['property_id'];?>").rating('create1',{coloron:'orange',onClick:function(){ 
			
			var rating = this.attr('data-rating');
				
				if(rating == 1){
					
				if(jQuery(this).hasClass('selected')){
						
					jQuery(this).attr("data-rating", "0");
					jQuery(this).removeClass('selected');
					jQuery(this).next('.stars_tooltip').remove();
					jQuery(this).after('<span class="stars_tooltip">Always</span>');
						
				}
				else{
					jQuery(this).addClass('selected');
					jQuery(this).next('.stars_tooltip').remove();
					jQuery(this).after('<span class="stars_tooltip">Most of the time</span>');
					}
				}
				if(rating == 2){
					jQuery(this).next('.stars_tooltip').remove();
					jQuery(this).removeClass('selected');
					jQuery(this).after('<span class="stars_tooltip">Sometimes</span>');
				}	
				if(rating == 3){
					jQuery(this).next('.stars_tooltip').remove();
					jQuery(this).removeClass('selected');
					jQuery(this).after('<span class="stars_tooltip">Rarely1</span>');
				}	
				if(rating == 4){
					jQuery(this).next('.stars_tooltip').remove();
					jQuery(this).removeClass('selected');
					jQuery(this).after('<span class="stars_tooltip">Never</span>');
				}
			 
			 }});</script>
		
		   <?php endif;?> 
		<?php endif;?> 
	    <?php if($this->profile_type == 4):?>
		 
		<div id="stars-green" class="stars-green_<?php echo $qn_count;?>_<?php echo $data['property_id'];?>" data-qnId = <?php echo $rate_qns['id']?>></div>
		
		<?php if($rate_qns['status'] == 0):?>
		 
		<span class="stars_tooltip">Never</span>
		<script>
			 jQuery(".stars-green_<?php echo $qn_count;?>_<?php echo $data['property_id'];?>").rating('create',{coloron:'orange',onClick:function(){
				var rating = this.attr('data-rating');
				
				if(rating == 1){
					
				if(jQuery(this).hasClass('selected')){
						
					jQuery(this).attr("data-rating", "0");
					jQuery(this).removeClass('selected');
					jQuery(this).next('.stars_tooltip').remove();
					jQuery(this).after('<span class="stars_tooltip">Never</span>');
						
				}
				else{
					jQuery(this).addClass('selected');
					jQuery(this).next('.stars_tooltip').remove();
					jQuery(this).after('<span class="stars_tooltip">Rarely</span>');
					}
				}
				if(rating == 2){
					jQuery(this).next('.stars_tooltip').remove();
					jQuery(this).removeClass('selected');
					jQuery(this).after('<span class="stars_tooltip">Sometimes</span>');
				}	
				if(rating == 3){
					jQuery(this).next('.stars_tooltip').remove();
					jQuery(this).removeClass('selected');
					jQuery(this).after('<span class="stars_tooltip">Most of the time</span>');
				}	
				if(rating == 4){
					jQuery(this).next('.stars_tooltip').remove();
					jQuery(this).removeClass('selected');
					jQuery(this).after('<span class="stars_tooltip">Always</span>');
				}	
				
			}});
		</script>
		
		<?php else:?>
		
		<span class="stars_tooltip">Always</span>
		<script>
			 jQuery(".stars-green_<?php echo $qn_count;?>_<?php echo $data['property_id'];?>").rating('create1',{coloron:'orange',onClick:function(){
				var rating = this.attr('data-rating');
				
				if(rating == 1){
					
				if(jQuery(this).hasClass('selected')){
						
					jQuery(this).attr("data-rating", "0");
					jQuery(this).removeClass('selected');
					jQuery(this).next('.stars_tooltip').remove();
					jQuery(this).after('<span class="stars_tooltip">Always</span>');
						
				}
				else{
					jQuery(this).addClass('selected');
					jQuery(this).next('.stars_tooltip').remove();
					jQuery(this).after('<span class="stars_tooltip">Most of the time</span>');
					}
				}
				if(rating == 2){
					jQuery(this).next('.stars_tooltip').remove();
					jQuery(this).removeClass('selected');
					jQuery(this).after('<span class="stars_tooltip">Sometimes</span>');
				}	
				if(rating == 3){
					jQuery(this).next('.stars_tooltip').remove();
					jQuery(this).removeClass('selected');
					jQuery(this).after('<span class="stars_tooltip">Rarely</span>');
				}	
				if(rating == 4){
					jQuery(this).next('.stars_tooltip').remove();
					jQuery(this).removeClass('selected');
					jQuery(this).after('<span class="stars_tooltip">Never</span>');
				}	
				
			}});
		</script>
		
		
		
		
		
		
		
		
		<?php endif;?> 
		<?php endif;?> 
		 
		 </li>
		 <?php $qn_count++;?>
		 
		 <?php endforeach;?>
		 </ul>
		 
		 
		 
		 
		 
		 </div>
		 
		 <div class="rate_btn_div">
			 
			<?php if($this->profile_type == 4):?>
			 
			 <button data-userid = <?php echo $data['tenant_id']; ?> data-pid = <?php echo $data['property_id']?> class="submit_rate_btn" data-list = <?php echo $i;?> >Rate</button>
		
			<?php endif;?> 
			
			<?php if($this->profile_type == 1):?>
			 
			 <button data-userid = <?php echo $data['landlord_id']; ?> data-pid = <?php echo $data['property_id']?> class="submit_rate_btn" data-list = <?php echo $i;?> >Rate</button>
			 
			<?php endif;?> 
			 
			 </div>
		
		
		 <hr>
		  <?php $i++;?>
		 </div>		
		<?php endforeach;?>
		
    </div>	
    
    <div class="loader" style="display:none"></div>	
	
</div>	
	
<!------------------------------------------------>





<script>




jQuery('body').on('click', '.submit_rate_btn', function(event){
	
	jQuery(this).css('display','none');
	
	var qn_cnt = '<?php echo count($this->rating_questions)?>';
	var user_id = jQuery(this).attr('data-userid'); 
	var list_cnt = jQuery(this).attr('data-list'); 
	var propertyid = jQuery(this).attr('data-pid'); 
	var star_array = '';
	var qn_array = '';
	var profile_type = '<?php echo $this->profile_type;?>';
	
	
	
	for(var cnt=1;cnt<=qn_cnt;cnt++){
		
		star_array = jQuery('.stars-green_'+cnt+'_'+propertyid).attr('data-rating')+','+star_array;
		
	}
	for(var cnt=1;cnt<=qn_cnt;cnt++){
		
		qn_array = jQuery('.stars-green_'+cnt+'_'+propertyid).attr('data-qnId')+','+qn_array;
		
	}

	var oData           = new Object();
    oData.user_id       = user_id;
    oData.star_array    = star_array;
    oData.qn_array    = qn_array;
    oData.profile_type    = profile_type; 
    
   
		
		var propertyname = jQuery('.propertyname_'+propertyid).val();
		var housingtype = jQuery('.housingtype_'+propertyid).val();
		var granted_date = jQuery('.granted_date_'+propertyid).val(); 
		
		
		oData.propertyname    = propertyname;
		oData.housingtype     = housingtype;
		oData.granted_date    = granted_date;
		oData.propertyid    = propertyid;
    
    var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/saverate';
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {
						 
						if(data.status == true){
							 
							jQuery('.rating_'+list_cnt).html(''); 
							 
						  var count = jQuery('.rating_title').length;  
						  jQuery(".succes_msg").css('display','block');
                          jQuery('.succes_msg').text('Succesfully rated');
						  setTimeout(function () {
							 jQuery('.succes_msg').text('');
							 jQuery('.succes_msg').css('display','none');
						  }, 2500); 
						 
						 if(count == 0){
						 var redir_url = '<?php echo $this->baseUrl()?>' + '/members/home';
                         location.href =redir_url;}
						}
         
					 },
					   error: function(e){ jQuery(this).css('display','block');  }  
					}); 
    
});


</script>
