<?php 
$mainimage='';$subimage='';$currentkey='0';

if(count($this->shareupload_session)>0){
foreach($this->shareupload_session as $key => $image):
if($image['primary']==1){
    $mainimage=$image['big_image'];
    $currentkey=$key;
} else {
$imagepath=$image['small_image'];
$subimage .='<li data-imageid="'.$key.'" style="background: url('.$imagepath.') center no-repeat;"><a href="javascript:void(0);" class="delete-share-image" data-imageid="'.$key.'"><i class="fa fa-times-circle" aria-hidden="true"></i></a></li>';
}
endforeach; ?>
<?php if($mainimage!=''){ ?>
<div id="share-main-image" style="background: url('<?php echo $mainimage; ?>') center no-repeat;">
     <a href="javascript:void(0);" class="delete-share-image" data-imageid="<?php echo $currentkey; ?>"><i class="icon-remove-sign" /></a>
</div>
<?php } ?>
<div class="share-images">
    <?php if($subimage!=''){ ?>
    <ul>
        <?php echo $subimage; ?>
    </ul>
    <?php } ?>
    <div class="clearfix"></div>
</div>
<div class="clearfix"></div>
<script type="text/javascript">
//jQuery(draginit);
</script>
<?php } ?>
