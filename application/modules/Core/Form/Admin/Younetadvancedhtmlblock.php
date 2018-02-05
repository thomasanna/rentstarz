<?php

class Core_Form_Admin_Younetadvancedhtmlblock extends Engine_Form
{
    public function getDefaultLanguage()
    {
        $translate = Zend_Registry::get('Zend_Translate');

        // Prepare language list
        $languageList = $translate -> getList();

        $view = Zend_Registry::get('Zend_View');

        // Prepare default langauge
        $defaultLanguage = Engine_Api::_() -> getApi('settings', 'core') -> getSetting('core.locale.locale', 'en');
        if (!in_array($defaultLanguage, $languageList))
        {
            if ($defaultLanguage == 'auto' && isset($languageList['en']))
            {
                $defaultLanguage = 'en';
            }
            else
            {
                $defaultLanguage = null;
            }
        }
        return $defaultLanguage;
    }

    public function getLanguegeList()
    {

        $translate = Zend_Registry::get('Zend_Translate');

        // Prepare language list
        $languageList = $translate -> getList();

        $view = Zend_Registry::get('Zend_View');

        // Prepare default langauge
        $defaultLanguage = Engine_Api::_() -> getApi('settings', 'core') -> getSetting('core.locale.locale', 'en');
        if (!in_array($defaultLanguage, $languageList))
        {
            if ($defaultLanguage == 'auto' && isset($languageList['en']))
            {
                $defaultLanguage = 'en';
            }
            else
            {
                $defaultLanguage = null;
            }
        }
        $view -> defaultLanguage = $defaultLanguage;

        // Init default locale
        $localeObject = Zend_Registry::get('Locale');

        $languages = Zend_Locale::getTranslationList('language', $localeObject);
        $territories = Zend_Locale::getTranslationList('territory', $localeObject);

        $localeMultiOptions = array();
        foreach ($languageList as $key)
        {
            $languageName = null;
            if (!empty($languages[$key]))
            {
                $languageName = $languages[$key];
            }
            else
            {
                $tmpLocale = new Zend_Locale($key);
                $region = $tmpLocale -> getRegion();
                $language = $tmpLocale -> getLanguage();
                if (!empty($languages[$language]) && !empty($territories[$region]))
                {
                    $languageName = $languages[$language] . ' (' . $territories[$region] . ')';
                }
            }

            if ($languageName)
            {
                $localeMultiOptions[$key] = $languageName . ' [' . $key . ']';
            }
            else
            {
                $localeMultiOptions[$key] = $view -> translate('Unknown') . ' [' . $key . ']';
            }
        }
        $localeMultiOptions = array_merge(array($defaultLanguage => $defaultLanguage), $localeMultiOptions);

        return $localeMultiOptions;

    }

    public function init()
    {
        $defaultLanguage = $this -> getDefaultLanguage();
        $languages = $this -> getLanguegeList();
        $this -> addPrefixPath('Widgets_Advancedhtmlblock_Element_', APPLICATION_PATH . '/application/widgets/advancedhtmlblock/Element', 'element');

        $this -> addElement('Select', 'language_code', array(
            'label' => 'Language',
            'multiOptions' => $languages,
            'onChange' => 'var edi=tinyMCE.get(\'body\'); var edi1=tinyMCE.get(\'tablet\'); var edi2=tinyMCE.get(\'mobile\');  var last =  this.form.last.value; if(!last){last=\'en\';}; var cur = this.options[this.selectedIndex].value; this.form.last.value = cur;this.form[\'body_\'+last].value = edi.getContent(); var ele =  this.form[\'body_\'+cur];if(ele != undefined && ele != null){ edi.setContent(ele.value);} this.form[\'tablet_\'+last].value = edi1.getContent(); var ele1 =  this.form[\'tablet_\'+cur]; if(ele1 != undefined && ele1 != null){ edi1.setContent(ele1.value);} this.form[\'mobile_\'+last].value = edi2.getContent(); var ele2 =  this.form[\'mobile_\'+cur];if(ele2 != undefined && ele2 != null){edi2.setContent(ele2.value);} this.form[\'title_\'+last].value=this.form.title0.value;var ele3 =  this.form[\'title_\'+cur]; if(ele3 != undefined && ele3!=null){this.form.title0.value = ele3.value;}',
        ));

        $this -> addElement('Text', 'title', array(
            'label' => 'Title',
            'decorators' => array('ViewHelper'),
            'style' => 'display:none'
        ));
        $this -> addElement('Text', 'title0', array('label' => 'Title'));
		//Add custom work
		// Element: levels
        $levels = Engine_Api::_()->getDbtable('levels', 'authorization')->fetchAll();
		$this->addElement('dummy', 'lbl_level',array(
    		'label' => 'Who can view this block',
    	));
        foreach ($levels as $level) 
        {
        	$this->addElement('Select', 'level_'.$level->getIdentity(), array(
	            'label' => $level->getTitle(),
	            'MultiOptions' => array('0' => 'No', '1' => 'Yes'),
	            'value' => 1
	        ));
        }
		//end custom work
		
		$this->addElement('dummy', 'lbl_desktop',array(
    		'label' => 'Content for Desktop',
    	));
        $this -> addElement('TinyMceYN', 'body', array(
            'label' => 'Desktop', 
            'decorators' => array(
                'ViewHelper',
                array(
                    'HtmlTag',
                    array(
                        'tag' => 'div',
                        'class' => 'form-element',
                        'style' => 'padding-top: 15px'
                    )
                )
            ),
                     
        ));
		$this->addElement('dummy', 'lbl_tablet',array(
    		'label' => 'Content for Tablet',
    	));
		$this -> addElement('TinyMceYN', 'tablet', array(
            'label' => 'Tablet',
            'decorators' => array(
                'ViewHelper',
                array(
                    'HtmlTag',
                    array(
                        'tag' => 'div',
                        'class' => 'form-element',
                        'style' => 'padding-top: 15px'
                    )
                )
            ),
            
        ));
		
		$this->addElement('dummy', 'lbl_mobile',array(
    		'label' => 'Content for Mobile',
    	));
		$this -> addElement('TinyMceYN', 'mobile', array(
             'label' => 'Mobile',
            'decorators' => array(
                'ViewHelper',
                array(
                    'HtmlTag',
                    array(
                        'tag' => 'div',
                        'class' => 'form-element',
                        'style' => 'padding-top: 15px'
                    )
                )
            ),
           
        ));
		
        if (count($languages) < 2)
        {
            $this -> removeElement('language_code');
        }
        else
        {
            foreach (array_keys($languages) as $key)
            {
                $this -> addElement('text', 'body_' . $key, array(
                    'value' => '',
                    'decorators' => array('ViewHelper'),
                    'style' => 'visibility:hidden;display:none;',
                ));
				
				$this -> addElement('text', 'tablet_' . $key, array(
                    'value' => '',
                    'decorators' => array('ViewHelper'),
                    'style' => 'visibility:hidden;display:none;',
                ));
				
				$this -> addElement('text', 'mobile_' . $key, array(
                    'value' => '',
                    'decorators' => array('ViewHelper'),
                    'style' => 'visibility:hidden;display:none;',
                ));
				
                $this -> addElement('text', 'title_' . $key, array(
                    'value' => '',
                    'decorators' => array('ViewHelper'),
                    'style' => 'visibility:hidden;display:none;',
                ));
            }
            $this -> addElement('text', 'last', array(
                'value' => $defaultLanguage,
                'style' => 'visibility:hidden;display:none;',
                'decorators' => array('ViewHelper'),
            ));
        }
    }

    // populate then save data to setting or what ever well.
    public function getValues()
    {
        $values = parent::getValues();
        $languageCode = isset($values['language_code']) ? $values['language_code'] : '';
        
        if ($languageCode)
        {
            $values['body_'.$languageCode] = $values['body'];
            $values['tablet_'.$languageCode] = $values['tablet'];
            $values['mobile_'.$languageCode] = $values['mobile'];
            $values['title_'.$languageCode] = $values['title0'];
        }
        unset($values['title']);
        return $values;
    }
}
