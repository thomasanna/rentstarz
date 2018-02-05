<script src="/application/modules/User/externals/scripts/message_notififaction.js"></script>
<script>
<?php $viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); ?>

var viewer_identity='<?php echo $viwer_id; ?>';	
</script>


<div class="generic_layout_container layout_user_browse_menu">
<div class="headline">
  <h2>
    Rating  </h2>
  <div class="tabs">
      </div>
</div>
</div>

<div class="rating_list_content generic_layout_container layout_middle">
	
	<div class="succes_msg" style="color:green; display:none" ></div>
	
	<div id="rating_ist_div">
		
		
	<div class="rating_title">
		
		<a href="profile/<?php echo $this->ratedbyuserData->user_id?>"><?php echo $this->ratedbyuserData->displayname?></a> rated you on Rentstarz against property '<a href="property/<?php echo $this->propertyData->id?>"><?php echo $this->propertyData->property_name?></a>'.  Here's the report in detail.
		
	</div>	
	
	<div class="rating_list">
	
	<?php foreach($this->rated_qns as $rate_qns):?>
		
		<div class="rate_qn_div"><span class="qn_count"></span><?php echo $rate_qns['questions'];?></div>
		
	    <div id="stars-green" class = "stars-green_<?php echo $rate_qns['id'];?>"  data-qnId = <?php echo $rate_qns['id']?> data-rating="<?php echo $rate_qns['qn_rate_value']?>"></div>
	    
	    <script>jQuery(".stars-green_<?php echo $rate_qns['id'];?>").rating('create',{coloron:'orange'});</script>
		<script>jQuery(".stars-green_<?php echo $rate_qns['id'];?>").children().unbind('click');</script>
		
    <?php endforeach;?>		
    
    </div>
		
    </div>
    		
    </div>	
    	
</div>		
