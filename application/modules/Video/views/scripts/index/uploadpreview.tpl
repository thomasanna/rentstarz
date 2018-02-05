<div class="linkbox">
	
	
	<div class="linkimgbox">
		
		<ul style="width: 100%;float: left;">
			<?php
			$file_ids = '';
			
			
			foreach($this->videoResult as $vresult)  { ?>
		<li id="img-0" style="background:url('<?php echo $vresult['storage_path']; ?>'); width:100px; height:100px;background-size: cover; ">
		<a href="javascript:void(0);" class="delete-share-video" data-imagepath="<?php echo $vresult['storage_path']; ?>" data-fileid="<?php echo $vresult['parent_file_id']; ?>" data-videoid="<?php echo $vresult['parent_id']; ?>"><i class="fa fa-times-circle" aria-hidden="true"></i></a>
		<img src="<?php echo $this->baseUrl().'/application/modules/User/externals/images/video-play.png'?>" style="margin-top: 24px;margin-left: 20px;" >
	    </li>
<?php 


//array_push($file_ids, $vresult['parent_file_id']);

if($file_ids ==''){
	$file_ids = $vresult['parent_file_id'];
}
else{
	$file_ids = $file_ids.','.$vresult['parent_file_id'];
}


?>

				<?php } ?></ul>
				
	<input type="hidden" id="file_id" value="<?php echo $file_ids; ?>">		    
				<input type="hidden" id="upload_type" value="<?php echo $vresult['parent_type']; ?>">
    </div>
	<!--<div class="linkcontbox">	
		

	</div>-->
	
</div>


	<!--<div id="img-0" style="position:absolute;width: 166px;line-height:120px; background:url('<?php echo $vresult['storage_path']; ?>')">
	<a href="javascript:void(0);" class="delete-share-video" data-imagepath="<?php echo $vresult['storage_path']; ?>" data-fileid="<?php echo $vresult['parent_file_id']; ?>" data-videoid="<?php echo $vresult['parent_id']; ?>"><i class="icon-remove-sign" /></a>
	<img src="css/studently/images/studentlyhome/video-play.png" >
	</div>-->
