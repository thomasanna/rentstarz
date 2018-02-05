

<h2>
  <?php echo $this->translate("City Add Form") ?>
</h2>

<?php if( count($this->navigation) ): ?>
  <div class='tabs'>
    <?php
      echo $this->navigation()->menu()->setContainer($this->navigation)->render()
    ?>
  </div>
<?php endif; ?>

<div class='admin_search'>
  <?php echo $this->form->render($this) ?>
</div>
 <div class="groups_photo">
      </div>
<br />


<br />

<script type="text/javascript">

jQuery( document ).ready(function() {
	
	 var base_path = "<?php echo $this->basePath;?>/";
	var country_id	=	jQuery('#country').val();
	jQuery('#state').html('');
		  jQuery.ajax({
					 url:  base_path + "getstates",
					data: "countryId="+country_id,
					dataType: 'json',
					type: 'POST',
				 success: function (data) { 
                   
					jQuery.each(data, function (i, item) {
					
					jQuery('#state').append(jQuery('<option>', { 
						value: item.id,
						text : item.state 
					}));
				});},
				   error: function(e){  alert('Error: '+e);  }  
				});
    
});	

jQuery( "#country" ).change(function() {
  var base_path = "<?php echo $this->basePath;?>/";
	var country_id	=	jQuery('#country').val();
	jQuery('#state').html('');
		  jQuery.ajax({
					 url:  base_path + "getstates",
					data: "countryId="+country_id,
					dataType: 'json',
					type: 'POST',
				 success: function (data) { 
                   
					jQuery.each(data, function (i, item) {
					
					jQuery('#state').append(jQuery('<option>', { 
						value: item.id,
						text : item.state 
					}));
				});},
				   error: function(e){  alert('Error: '+e);  }  
				});
});
</script>
