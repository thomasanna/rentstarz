<?php
$mainimage='';$subimage='';
if(count($this->shareupload)>0)	{
foreach($this->shareupload as $key => $image):
if($image['primary']==1){
    $mainimage=$image['big_image'];
    $currentkey=$key;
} else {
$imagepath=$image['small_image'];
$subimage .='<li data-imageid="'.$key.'" style="background: url('.$imagepath.') center no-repeat;"><a href="javascript:void(0);" class="delete-share-image" data-imageid="'.$key.'"><i class="fa fa-times-circle" aria-hidden="true"></i></a></li>';
}
endforeach; ?>
<?php if($mainimage!=''){ ?>
<!--<div id="share-main-image" style="background: url('<?php echo $mainimage; ?>') center no-repeat;width:47px; height:58px">-->
<div id="share-main-image" style="background: url('<?php echo $mainimage; ?>')">
     <a href="javascript:void(0);" class="delete-share-image" data-imageid="<?php echo $currentkey; ?>"><i class="fa fa-times-circle" aria-hidden="true"></i></a>
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
