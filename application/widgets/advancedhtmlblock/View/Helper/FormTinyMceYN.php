<?php

class Widgets_Advancedhtmlblock_View_Helper_FormTinyMceYN extends Zend_View_Helper_FormTextarea
{
    protected $_tinyMce;

    public function formTinyMceYN($name, $value = null, $attribs = null)
    {
        // Disable for mobile browsers
        $ua = $_SERVER['HTTP_USER_AGENT'];
        if( preg_match('/Mobile/i', $ua) || preg_match('/Opera Mini/i', $ua) || preg_match('/NokiaN/i', $ua) ) {
          return $this->formTextarea($name, $value, $attribs);
        }

        $info = $this->_getInfo($name, $value, $attribs);
        extract($info); // name, value, attribs, options, listsep, disable
        $disabled = '';
        if ($disable) {
            $disabled = ' disabled="disabled"';
        }

        if( Zend_Registry::isRegistered('Locale') ) {
          $locale = Zend_Registry::get('Locale');
          if( method_exists($locale, '__toString') ) {
            $locale = $locale->__toString();
          } else {
            $locale = (string) $locale;
          }
          $localeData = Zend_Locale_Data::getList($locale, 'layout');
          $directionality = ( @$localeData['characters'] == 'right-to-left' ? 'rtl' : 'ltr' );

          //Checking SE version
          $manifest = Zend_Registry::get('Engine_Manifest');
          if (version_compare($manifest['core']['package']['version'], '4.7.0', '<'))
          {
          	$this->view->tinyMceYN()->language = $locale;
          	$this->view->tinyMceYN()->directionality = $directionality;
          }	
          else
          {
          	$this->view->tinyMceYN1()->language = $locale;
          	$this->view->tinyMceYN1()->directionality = $directionality;
          }	
          
        }

        if (empty($attribs['rows'])) {
            $attribs['rows'] = (int) $this->rows;
        }
        if (empty($attribs['cols'])) {
            $attribs['cols'] = (int) $this->cols;
        }
        if (isset($attribs['editorOptions'])) {
            if ($attribs['editorOptions'] instanceof Zend_Config) {
                $attribs['editorOptions'] = $attribs['editorOptions']->toArray();
            }
            
            if (version_compare($manifest['core']['package']['version'], '4.7.0', '<'))
            {
            	$this->view->tinyMceYN()->setOptions($attribs['editorOptions']);
            }
            else
            {
            	$this->view->tinyMceYN1()->setOptions($attribs['editorOptions']);
            }
            
            
            unset($attribs['editorOptions']);
        }
        
        if (version_compare($manifest['core']['package']['version'], '4.7.0', '<'))
        {
        	$this->view->tinyMceYN()->render();
        }
        else
        {
        	$this->view->tinyMceYN1()->render();
        }
        
        
        $xhtml = '<textarea rows=24, cols=80, style="width:553px;" name="' . $this->view->escape($name) . '"'
                . ' id="' . $this->view->escape($id) . '"'
                . $disabled
                . $this->_htmlAttribs($attribs) . '>'
                . $this->view->escape($value) . '</textarea>';

        return $xhtml;
    }
}
