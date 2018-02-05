

<h2>
  <?php echo $this->translate("Rating questions Add Form") ?>
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


