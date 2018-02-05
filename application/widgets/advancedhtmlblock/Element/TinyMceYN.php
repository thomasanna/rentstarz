<?php

class Widgets_Advancedhtmlblock_Element_TinyMceYN extends Engine_Form_Element_Textarea
{
    /**
     * Use formTextarea view helper by default
     * @var string
     */
    public $helper = 'formTinyMceYN';

    public function loadDefaultDecorators()
    {
        if ($this -> loadDefaultDecoratorsIsDisabled())
        {

            return;
        }
        $decorators = $this -> getDecorators();
        if (empty($decorators))
        {
            $this -> addDecorator('ViewHelper');
            Engine_Form::addDefaultDecorators($this);
        }
    }

    public function setView(Zend_View_Interface $view = null)
    {
        if (null !== $view)
        {
            if (false === $view -> getPluginLoader('helper') -> getPaths('Widgets_Advancedhtmlblock_View_Helper'))
            {
                $view -> addHelperPath(APPLICATION_PATH . '/application/widgets/advancedhtmlblock/View/Helper', 'Widgets_Advancedhtmlblock_View_Helper');
            }
        }
        return parent::setView($view);
    }

  
}
