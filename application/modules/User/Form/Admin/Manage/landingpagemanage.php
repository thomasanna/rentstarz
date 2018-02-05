
<?php
class User_Form_Admin_Manage_Landingpagemanage extends Engine_Form
{
  public function init()
  {
	    // Element: body
    $editorOptions = array(
        'html' => (bool) true,
        'mode' => "exact",
        'forced_root_block' => false,
        'force_p_newlines' => false,
        'elements' => 'bodyhtml',
        'plugins' => array(
            'table', 'fullscreen', 'preview', 'paste',
            'code', 'image', 'textcolor', 'link'
        ),
        'toolbar1' => array(
            'undo', 'redo', 'removeformat', 'pastetext', '|', 'code',
            'image', 'link', 'fullscreen',
            'preview'
    ));

    $this->addElement('TinyMce', 'bodyhtml', array(
      'label' => 'Landingpage Body',
      'editorOptions' => $editorOptions,
    ));
     $this->addElement('Checkbox', 'showLandingpagearticlesection', array(
      'label' => 'Show article section in landingpage',
	  'value' => 0,
    ));
    // Element: submit
    $this->addElement('Button', 'submit', array(
      'label' => 'Save Changes',
      'type' => 'submit',
      'ignore' => true,
    ));
  }
  
}

?>
