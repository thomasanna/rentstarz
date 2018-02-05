<h2>
  <?php echo $this->translate("Manage Stripe") ?>
</h2>


<div class="admin_table_form">

  <table class='admin_table'>
    <thead>
      <tr>
     
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('id', 'DESC');"><?php echo $this->translate("ID") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('interval', 'ASC');"><?php echo $this->translate("Payment Duration  (days)") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('amount', 'ASC');"><?php echo $this->translate("Credit and background payment amount") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('amount', 'ASC');"><?php echo $this->translate("Credit and background + eviction payment amount") ?></a></th>
        <th style='width: 1%;'><a href="javascript:void(0);" onclick="javascript:changeOrder('amount', 'ASC');"><?php echo $this->translate("Deduction per each payment") ?></a></th>
        <th style='width: 1%;' class='admin_table_options' colspan="1"><?php echo $this->translate("Options") ?></th>
      </tr>
             
    </thead>
    <tbody>
      

        <tr>
       <td><?php echo $this->StripeSettingsData->id; ?></td>
       <td><?php echo $this->StripeSettingsData->payment_duration; ?></td>
       <td><?php echo $this->StripeSettingsData->credit_and_background_payment_amount; ?></td>
       <td><?php echo $this->StripeSettingsData->creditbackground_eviction_payment_amount; ?></td>
       <td><?php echo $this->StripeSettingsData->creditscore_payment_amount; ?></td>
       <td><?php echo $this->StripeSettingsData->deduction_per_each_payment; ?></td>

       <td> <a class='smoothbox'  href='<?php echo $this->url(array('action' => 'editpaymentsettings', 'id' => $this->StripeSettingsData->id ));?>'>
                  <?php echo $this->translate("edit") ?>
       </a></td>
     
       </tr>


    </tbody>
  </table>
  <br />	
</div>    
