

<h2>
  <?php echo $this->translate("Survey questions Add Form") ?>
</h2>

<?php if( count($this->navigation) ): ?>
  <div class='tabs'>
    <?php
      echo $this->navigation()->menu()->setContainer($this->navigation)->render()
    ?>
  </div>
<?php endif; ?>

  <?php echo $this->form->render($this) ?>

