<?php

class Ynresponsive1_View_Helper_YNHtml5_TinyMce extends Zend_View_Helper_Abstract
{
  protected $_enabled = false;
  protected $_defaultScript = 'externals/wysihtml5/html5.js';
  protected $_html = true;
  protected $_bbcode = false;
	
	protected $_element = null;
	
	protected $_elementId = null;
	
  protected $_supported = array(
    'mode' => array(
      'textareas', 'specific_textareas', 'exact', 'none'
    ),
    'theme' => array(
      'modern'
    ),
    'format' => array(
      'html', 'xhtml'
    ),
    'languages' => array(
      'ar', 'bg_BG', 'bs', 'ca', 'cs', 'cy', 'da', 'de', 'de_AT', 'el', 'en',
      'es', 'et', 'eu', 'fa', 'fi', 'fo', 'fr_FR', 'gl', 'he_IL', 'hr', 'hu_HU',
      'hy', 'id', 'it', 'ja', 'ka_GE', 'ko_KR', 'lb', 'lt', 'lv', 'nb_NO', 'nl',
      'pl', 'pt_BR', 'pt_PT', 'ro', 'ru', 'si_LK', 'sk', 'sl_SI', 'sr', 'sv_SE',
      'ta', 'ta_IN', 'tg', 'th_TH', 'tr_TR', 'ug', 'uk', 'uk_UA', 'vi', 'vi_VN',
      'zh_CN', 'zh_TW'
    ),
    'directionality' => array(
      'rtl', 'ltr',
    ),
    'plugins' => array(
      'advlist', 'anchor', 'autolink', 'autoresize', 'autosave', 'bbcode',
      'charmap', 'code', 'compat3x', 'contextmenu', 'directionality',
      'emoticons', 'example', 'example_dependency', 'fullpage', 'fullscreen',
      'hr', 'image', 'insertdatetime', 'layer', 'legacyoutput', 'link', 'lists',
      'importcss', 'media', 'nonbreaking', 'noneditable', 'pagebreak', 'paste',
      'preview', 'print', 'save', 'searchreplace', 'spellchecker', 'tabfocus',
      'table', 'template', 'textcolor', 'visualblocks', 'visualchars',
      'wordcount'
    ),
  );
  protected $_config = array(
    'mode' => 'textareas',
    'plugins' => array(
      'table', 'fullscreen', 'media', 'preview', 'paste', 'code', 'image',
      'textcolor'
    ),
    'theme' => 'modern',
    'menubar' => false,
    'statusbar' => false,
    'toolbar1' => array(
      'undo', 'redo', 'removeformat', 'pastetext', '|', 'code', 'media',
      'image', 'link', 'fullscreen', 'preview'
    ),
    'toolbar2' => '',
    'toolbar3' => '',
    'element_format' => 'html',
    'height' => '225px',
    'convert_urls' => false
  );
  protected $_scriptPath;
  protected $_scriptFile;

  public function __set($name, $value)
  {
	  $method = 'set' . $name;
	  if( !method_exists($this, $method) ) {
      //throw new Engine_Exception('Invalid tinyMce property');
    }
    $this->$method($value);
  }

  public function __get($name)
  {
    $method = 'get' . $name;
    if( !method_exists($this, $method) ) {
      throw new Engine_Exception('Invalid tinyMce property');
    }
    return $this->$method();
  }

  public function setOptions(array $options)
  {
  			
    $methods = get_class_methods($this);
    foreach( $options as $key => $value ) {
      $method = 'set' . ucfirst($key);
      if( in_array($method, $methods) ) {
        $this->$method($value);
      } else {
        $this->_config[$key] = $value;
      }
    }
    return $this;
  }

  public function TinyMce()
  {    
    return $this;
  }

  
	public function getHtml(){
		return $this->_html;
	}

  public function setHtml($value)
	
  {

    //$this->_html = (bool) $value;
    $this->_html = '';
  }

  public function setLanguage($language)
  {
    if( !in_array($language, $this->_supported['languages']) ) {
      list($language) = explode('_', $language);
      if( !in_array($language, $this->_supported['languages']) ) {
        return $this;
      }
    }

    $this->_config['language'] = $language;

    return $this;
  }

  public function setDirectionality($directionality)
  {
    if( in_array($directionality, $this->_supported['directionality']) ) {
      $this->_config['directionality'] = $directionality;
    }

    return $this;
  }

  public function setScriptPath($path)
  {
    $this->_scriptPath = rtrim($path, '/');
    return $this;
  }

  public function setScriptFile($file)
  {
    $this->_scriptFile = (string) $file;
  }

  public function render($element, $id)
  {
		  	
  	$this->_element = $element;
		$this->_elementId = $id;
  	
    if( false === $this->_enabled ) 
    {
      $this->_renderScript();
      $this->_renderEditor();
    }
    $this->_enabled = true;
  }

  protected function _renderScript()
  {
    if( null === $this->_scriptFile ) {
      $script = $this->view->baseUrl() . '/' . $this->_defaultScript;
    } else {
      if( null === $this->_scriptPath ) {
        $this->_scriptPath = $this->view->baseUrl();
      }
      $script = $this->_scriptPath . '/' . $this->_scriptFile;
    }

    $this->view->headScript()->appendFile($script);
    return $this;
  }

  protected function _renderEditor()
  {
    $script = 'en4.core.runonce.add(function(){
    	var editor = new wysihtml5.Editor(":element_id", 
    	{
		    toolbar:        "toolbar_wysihtml5_:element_id",
		    stylesheets:    "'.$this->view->baseUrl().'/application/themes/'.YNRESPONSIVE_ACTIVE.'/editor.css",
		    parserRules:    wysihtml5ParserRules
	  });})';
		
		
		$script = strtr($script, array(":element_id"=>$this->_elementId));
		
		
  
    $this->view->headScript()->appendScript($script);
    return $this;
  }
}
