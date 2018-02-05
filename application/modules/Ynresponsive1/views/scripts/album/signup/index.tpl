<?php
$this -> form -> setAction($this -> url(array(), 'user_signup'));
echo $this->partial($this->script[0], $this->script[1], array(
  'form' => $this->form
)); 
?>

<script type="text/javascript">
  jQuery.noConflict();
  if( $("user_signup_form") ) $("user_signup_form").getElements(".form-errors").destroy();
  
  function skipForm() {
    document.getElementById("skip").value = "skipForm";
    $('SignupForm').submit();
  }
  
  function finishForm() {
    document.getElementById("nextStep").value = "finish";
  }
</script>