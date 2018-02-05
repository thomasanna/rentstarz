
<div class="headline">
  <h2>
    <?php if ($this->viewer->isSelf($this->user) ):?>
      <?php echo $this->translate('Edit My Profile');?>
    <?php else:?>
      <?php echo $this->translate('%1$s\'s Profile', $this->htmlLink($this->user->getHref(), $this->user->getTitle()));?>
    <?php endif;?>
  </h2>
  <div class="tabs">
    <?php
      // Render the menu
      echo $this->navigation()
        ->menu()
        ->setContainer($this->navigation)
        ->render();
    ?>
  </div>
</div>
 <div class="generic_layout_container layout_left">
<?php
echo $this->content()->renderWidget('user.home-photo');
echo $this->content()->renderWidget('user.home-links');
?>
</div>
 <div class="generic_layout_container layout_middle">
<div class="document_list">
<?php if(count($this->docRequests) >0): ?>	
<ul>


<?php foreach($this->docRequests as $reqsts): ?>

<li><a href="<?php echo $this->baseUrl().'/profile/'.$reqsts['doc_requested_user_id'] ?>"><?php echo $reqsts['displayname']; ?></a> has sent request to access your document '<?php echo $reqsts['doc_name'];?>'
<?php if($reqsts['doc_owner_approve'] == 0):?>
<span style="float: right;">
<button class="docreq_approve_btn docreq_approve_btn_<?php echo $reqsts['id']; ?>" req-id = <?php echo $reqsts['id']; ?>>Approve</button>
<button class="docreq_rejectbtn docreq_rejectbtn_<?php echo $reqsts['id']; ?>" req-id = <?php echo $reqsts['id']; ?>>Reject</button>
</span>
<?php endif;?>
</li>

<?php endforeach;?>
</ul>
<?php else:?>
<div class="notfound">No Documents</div>
<?php endif;?>
</div>
</div>



<script>

jQuery( ".docreq_approve_btn" ).click(function() {
	
	var req_id = jQuery(this).attr('req-id'); 
	var oData       = new Object();
    oData.req_id       = req_id;
    var host	=	window.location.host;
    var url	=	'<?php echo $this->baseUrl()?>' + '/user/index/docrequestapprove';
			  jQuery.ajax({
						url:  url,
						data: oData,						
						dataType: 'json',
						type: 'POST',
					 success: function (data) {
                        jQuery(".docreq_approve_btn_"+req_id).fadeOut();                            
                        jQuery(".docreq_rejectbtn_"+req_id).fadeOut();                            
					 },
					   error: function(e){  alert('Error: '+e);  }  
					}); 
	
	
});

</script>








