<?php
class Ynresponsivepurity_Form_Admin_Widget_Slider extends Core_Form_Admin_Widget_Standard
{
    function init()
    {
        $this->addElement('text', 'background_image', array('label' => 'Background Image', 'description' => 'Set url of background image for slider.'));
        $this->background_image->getDecorator('Description')->setOption('placement', 'append');
        $this->addElement('select', 'show_title', array('label' => 'Show Title', 'value' => '1', 'multiOptions' => array('1' => 'Yes', '0' => 'No')));
        $this->addElement('select', 'show_description', array('label' => 'Show Description', 'value' => '1', 'multiOptions' => array('1' => 'Yes', '0' => 'No')));
    }
}
