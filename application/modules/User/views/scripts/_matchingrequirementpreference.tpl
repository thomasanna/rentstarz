  <?php 
  
  if(count($this->matchingFeedPreferenceUnitData) > 0): 
            $i=0;
            foreach($this->matchingFeedPreferenceUnitData as $data):  
            $i++;
            ?>
            <div class="preference_li preference_li_<?php echo $data['id']; ?>" >
            <div class="preference_scout_name"><?php echo $data['scout_name'] ." :"?></div>
           <div class="preference_unit preference_unit_<?php echo $i; ?>" style="float:left;cursor: pointer;font-weight: 700;" value="<?php echo $i;?>" preference_number="<?php echo $i;?>" feedpreferenceunitid = "<?php echo $data['id'];?>">
              <?php if($data['stateName']  != '' || $data['cityName']  != ''  || $data['countyName']  != '' || $data['neighborhoodName']  != ''):?>
              <span style="margin-right: 12px;">
                <?php if($data['stateName']  != '' ):
                      echo $data['stateName'] ." ";
                      endif;
                      if($data['cityName']  != '' && $data['cityName'] != $data['stateName']):
                      echo $data['cityName']." ";
                      endif;
                      if($data['countyName']  != ''  && $data['countyName'] != $data['cityName']):
                      echo $data['countyName']." ";
                      endif;
                      if($data['neighborhoodName']  != '' ):
                      echo $data['neighborhoodName']." ";
                      endif;
                 ?>

              </span>
              <?php endif;?>
               <?php if($data['number_of_rooms']  != ''  || $data['housing_type']  != ''): ?>
              <span style="margin-right: 12px;">
                  <?php if($data['number_of_rooms']  != '' ):
                       echo $data['number_of_rooms']." ";
                       endif;
                       if($data['housing_type']  != '' ):
                       echo $data['housing_type']." ";
                       endif;
                   ?>
            </span>
            <?php endif;?>
            <?php if($data['is_petsallowd']  != '' ):?>
             <span style="margin-right: 12px;">
                 <?php
                       if($data['is_petsallowd']  != '' ):
                           if($data['is_petsallowd'] == 'No'):
                              echo "No pets";
                           else:
                             echo "Pets";
                           endif;
                       endif;
                     ?>
              </span>
              <?php endif;?>
              <?php  if($data['pets_type']  != '' ):?> 
              <span style="margin-right: 12px;">
                  <?php
                       if($data['pets_type']  != '' ):
                       echo $data['pets_type'];
                       endif;
                     ?>
              </span>
              <?php endif;?>
                 <?php  if($data['price']  != '0' ):?> 
              <span style="margin-right: 12px;">
                  <?php
                       if($data['price']  != '' && $data['price_to'] == '0'):
                       echo " $".$data['price'];
                       endif;
                       if($data['price']  != '' && $data['price_to'] != '0'):
                       echo " $".$data['price']." - $".$data['price_to'];
                       endif;
                     ?>
              </span>
              <?php endif;?>
           </div>
           <div class="scout_options">
           <div  data-toggle="modal" data-target="#editPreferenceModal" class="edit_preference"  li_count="<?php echo $i;?>" preferenceId = "<?php echo $data['id']; ?>">Edit</div>

           <div class="remove_preference" preferencename= "<?php echo 'Preference '.$i;?>" remove_preference_id="<?php echo $data['id']; ?>" style="float:right;cursor: pointer;"><i class="fa fa-times" aria-hidden="true"></i></div>
          </div>
            <br>
            </div>
            <?php  endforeach;  ?>
    <?php else:?>  
    
    <div style="padding: 12px;">No matches found</div>  
    
    <?php endif;?>    
