<?php $FeedPreferenceUnitData  = $this->FeedPreferenceUnitData;?>
 <div class="pro_field_wrapper" style="margin-bottom:11px;" >
        <div class="prty_lablel pro_label" >Scout Name
         <span style="color:red;font-weight: bolder;">*</span>  
         </div>
        <input type="text" name="scout_name" value="" class="edit_scout_name prty_field">
            
   </div> 
 
    <div class="pro_field_wrapper">
        <div class="prty_lablel pro_label">Rental Type</div>
        <input type="radio" name="edit_housing_type" value="Apartment" style="margin-right:12px;    margin-bottom: 13px;">
        <label class="radio_label" for="Apartment">Apartment</label>
        <input type="radio" name="edit_housing_type" value="Room" style="margin-right:12px;    margin-bottom: 13px;">
        <label class="radio_label" for="Room">Room</label>
        <input type="radio" name="edit_housing_type" value="House" style="margin-right:12px;    margin-bottom: 13px;">
        <label class="radio_label" for="House">House</label>
        <input type="radio" name="edit_housing_type" value="Villa" style="margin-right:12px;    margin-bottom: 13px;">
        <label class="radio_label" for="Villa">Villa</label>
   </div> <br>
    <div class="pro_field_wrapper">
		<div class="prty_lablel pro_label">Pets</div>  <select name="is_petsallowd" id="is_petsallowd"  class="edit_is_petsallowd prty_field" onchange="petsType()">
                                             <option value="">Select</option>
                                             <option value="Yes">Yes</option>
                                             <option value="No">No</option>
    </select></div>   <br>
    <div class="pets_type_wrapper" style="display:block">
    <div class="pro_field_wrapper"><div class="prty_lablel pro_label">Type of pets</div>
                             <select name="pets_type" id="pets_type"  class="edit_pets_type prty_field">
                                             <option value="">Select pets type</option>
                                             <option value="Cats">Cats</option>
                                             <option value="Dogs">Dogs</option>
                                             <option value="Cats & Dogs">Cats & Dogs</option>
                                             <option value="Birds">Birds</option>
                                             <option value="Small pets">Small pets</option>
                             </select>
                             </div>   <br>
        </div>
    <div class="pro_field_wrapper"><div class="prty_lablel pro_label">Number Of Bedrooms</div>

    <select id="number_of_rooms" class="edit_number_of_rooms prty_field">

                                             <option value="">Select</option>
                                             <option value="1">1</option>
                                             <option value="2">2</option>
                                             <option value="3">3</option>
                                             <option value="4">4</option>
                                             <option value="4+">4+</option>
    </select>
    </div>   <br>
        
    <div class="pro_field_wrapper" style="overflow: hidden;"><div class="prty_lablel pro_label">Rent per Month</div>
    <input type="text" class="price_range_from edit_price prty_field" placeholder="Price"> 
    
     <span class="price_range_to_div" style="display:none">
		<span class="to_span">To</span>
     <input type="text" class="price_range_to prty_field edit_price_to" placeholder="To">
     </span>
    
        <span class="price_range_span_link">
			<a href="javascript:void(0)" class="price_range_link">
						<img src="/application/modules/User/externals/images/add_range.png" alt="" title="Add Range" >
			</a>
		</span>
        </div> <br>

<script>
function petsType(){

    var hasPet  =   jQuery('#editPreferenceModal .edit_is_petsallowd').val();
    jQuery('#editPreferenceModal .edit_pets_type').val('');
    if(hasPet   ==  'Yes')
    {
        jQuery('.pets_type_wrapper').css('display','block');
    }
    else
    {
        jQuery('.pets_type_wrapper').css('display','none');
    }
}	
	
	
	
var housing_type= '<?php echo $FeedPreferenceUnitData->housing_type;?>';
var price    = '<?php echo $FeedPreferenceUnitData->price;?>';
var price_to    = '<?php echo $FeedPreferenceUnitData->price_to;?>';
jQuery("input[name=edit_housing_type][value='"+housing_type+"']").prop("checked",true);
jQuery('.edit_scout_name').val('<?php echo $FeedPreferenceUnitData->scout_name;?>');
jQuery('.edit_is_petsallowd').val('<?php echo $FeedPreferenceUnitData->is_petsallowd;?>');
jQuery('.edit_pets_type').val('<?php echo $FeedPreferenceUnitData->pets_type;?>');
if(price != '0'){
jQuery('.edit_price').val('<?php echo $FeedPreferenceUnitData->price;?>');
}
if(price_to !='0'){
jQuery('.edit_price_to').val('<?php echo $FeedPreferenceUnitData->price_to;?>');	
}

jQuery('.edit_number_of_rooms').val('<?php echo $FeedPreferenceUnitData->number_of_rooms;?>');
jQuery('#neighborhood').val('<?php echo $FeedPreferenceUnitData->neighborhoodName;?>');
jQuery('#locality').val('<?php echo $FeedPreferenceUnitData->cityName;?>');
jQuery('#sublocality_level_1').val('<?php echo $FeedPreferenceUnitData->countyName;?>');
jQuery('#administrative_area_level_1').val('<?php echo $FeedPreferenceUnitData->stateName;?>');
jQuery('#country').val('<?php echo $FeedPreferenceUnitData->countryName;?>');
jQuery('#postal_code').val('<?php echo $FeedPreferenceUnitData->zip;?>');
jQuery('.edit_preference_place').val('<?php echo $FeedPreferenceUnitData->countryName ." ".$FeedPreferenceUnitData->stateName ." ".$FeedPreferenceUnitData->cityName;?>');

if(price_to !='0'){
	jQuery('#editPreferenceModal .price_range_to_div').css('display','block');
	jQuery('#editPreferenceModal .price_range_from').addClass('pricerange_enabled');    
    jQuery('#editPreferenceModal .price_range_to').addClass('pricerange_enabled'); 
    jQuery('#editPreferenceModal .price_range_span_link').html('<a href="javascript:void(0)" class="price_cancel_range_link"><img src="/application/modules/User/externals/images/cancel_add_range.png" alt="" title="Cancel"</a>');

}
jQuery('body').on('click', '#editPreferenceModal .price_range_link', function(event){
    jQuery('#editPreferenceModal .price_range_to_div').css('display','block');
    jQuery('#editPreferenceModal .price_range_from').addClass('pricerange_enabled');    
    jQuery('#editPreferenceModal .price_range_to').addClass('pricerange_enabled');       
    jQuery('#editPreferenceModal .price_range_span_link').html('<a href="javascript:void(0)" class="price_cancel_range_link"><img src="/application/modules/User/externals/images/cancel_add_range.png" alt="" title="Cancel"</a>');

});
jQuery('body').on('click', '#editPreferenceModal .price_cancel_range_link', function(event){
    jQuery('#editPreferenceModal .price_range_to_div').css('display','none');  
    jQuery('#editPreferenceModal .price_range_from').removeClass('pricerange_enabled');    
    jQuery('#editPreferenceModal .price_range_to').removeClass('pricerange_enabled');  
    jQuery('#editPreferenceModal .price_range_to').val('');  
    jQuery('#editPreferenceModal .price_range_span_link').html('<a href="javascript:void(0)" class="price_range_link"><img src="/application/modules/User/externals/images/add_range.png" alt="" title="Add Range"></a>');

});

</script>
