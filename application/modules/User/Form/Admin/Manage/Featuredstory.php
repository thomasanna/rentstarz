
<?php
class User_Form_Admin_Manage_Featuredstory extends Engine_Form
{
  public function init()
  {
	 $this
      ->setAttrib('enctype', 'multipart/form-data')
       ->setAttrib('name', 'featuredstory');
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
    
     $this->addElement('Text', 'featuredstoryTitle', array(
      'label' => 'Title',
      'allowEmpty' => false,
      'required' => true,
    ));

    $this->addElement('TinyMce', 'bodyhtml', array(
      'label' => 'Description',
      'editorOptions' => $editorOptions,
       'allowEmpty' => false,
        'required' => true,
    ));
    
    $this->addElement('File', 'FeaturedstoryImage', array(
      'label' => 'Change image',
      'description'=>'Supported file types : jpg,png,gif,jpeg',
      'multiFile' => 1,
      'validators' => array(
        array('Count', false, 1),
        array('Size', false, array('min' => 612000)),
        array('Extension', false, 'jpg,jpeg,png,gif'),
      ),
    ));
     $this->addElement('Checkbox', 'showLandingpageFeaturedstory', array(
      'label' => 'Show this featured story in landingpage',
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
