<?php
class Ynresponsive1_View_Helper_YNHtml5_FormTinyMce extends Zend_View_Helper_FormTextarea
{
    protected $_tinyMce;

    public function formTinyMce($name, $value = null, $attribs = null)
    {
 		// Disable for mobile browsers
        // $ua = $_SERVER['HTTP_USER_AGENT'];
        // if( preg_match('/Mobile/i', $ua) || preg_match('/Opera Mini/i', $ua) || preg_match('/NokiaN/i', $ua) ) {
          // return $this->formTextarea($name, $value, $attribs);
        // }    
		
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

          $this->view->tinyMce()->language = $locale;
          $this->view->tinyMce()->directionality = $directionality;
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
            $this->view->tinyMce()->setOptions($attribs['editorOptions']);
            unset($attribs['editorOptions']);
        }
				
        $this->view->tinyMce()->render($this, $id);
				
        $xhtml = '<div class="wysihtml5_area">
    <div id="toolbar_wysihtml5_'.$this->view->escape($id).'" class="toolbar_wysihtml5" style="display:none">
        <ul class="commands">
          <li data-wysihtml5-command="bold" title="Make text bold (CTRL + B)" class="command"></li>
          <li data-wysihtml5-command="italic" title="Make text italic (CTRL + I)" class="command"></li>
          <li data-wysihtml5-command="insertUnorderedList" title="Insert an unordered list" class="command"></li>
          <li data-wysihtml5-command="insertOrderedList" title="Insert an ordered list" class="command"></li>
          <li data-wysihtml5-command="createLink" title="Insert a link" class="command"></li>
          <li data-wysihtml5-command="insertImage" title="Insert an image" class="command"></li>
          <li data-wysihtml5-command="formatBlock" data-wysihtml5-command-value="h1" title="Insert headline 1" class="command"></li>
          <li data-wysihtml5-command="formatBlock" data-wysihtml5-command-value="h2" title="Insert headline 2" class="command"></li>
          <li style="display:none" data-wysihtml5-command-group="foreColor" class="fore-color" title="Color the selected text">
            <ul>
              <li data-wysihtml5-command="foreColor" data-wysihtml5-command-value="silver"></li>
              <li data-wysihtml5-command="foreColor" data-wysihtml5-command-value="gray"></li>
              <li data-wysihtml5-command="foreColor" data-wysihtml5-command-value="maroon"></li>
              <li data-wysihtml5-command="foreColor" data-wysihtml5-command-value="red"></li>
              <li data-wysihtml5-command="foreColor" data-wysihtml5-command-value="purple"></li>
              <li data-wysihtml5-command="foreColor" data-wysihtml5-command-value="green"></li>
              <li data-wysihtml5-command="foreColor" data-wysihtml5-command-value="olive"></li>
              <li data-wysihtml5-command="foreColor" data-wysihtml5-command-value="navy"></li>
              <li data-wysihtml5-command="foreColor" data-wysihtml5-command-value="blue"></li>
            </ul>
          </li>
          <li data-wysihtml5-command="insertSpeech" title="Insert speech" class="command" style="position: relative;"><div style="left: 0px; margin: 0px; opacity: 0; overflow: hidden; padding: 0px; position: absolute; top: 0px; z-index: 1; width: 40px; height: 25px;"><input x-webkit-speech="" speech="" style="cursor: inherit; font-size: 50px; height: 25px; margin-top: -25px; outline: 0px; padding: 0px; position: absolute; right: -4px; top: 50%;"></div></li>
          <li data-wysihtml5-action="change_view" title="Show HTML" class="action"></li>
        </ul>
      
    <div data-wysihtml5-dialog="createLink" style="display: none;">
      <label>
        Link:
        <input data-wysihtml5-dialog-field="href" value="http://">
      </label>
      <a data-wysihtml5-dialog-action="save">OK</a>&nbsp;<a data-wysihtml5-dialog-action="cancel">Cancel</a>
    </div>
    
    <div data-wysihtml5-dialog="insertImage" style="display: none;">
      <label>
        Image:
        <input data-wysihtml5-dialog-field="src" value="http://">
      </label>
      <label>
        Align:
        <select data-wysihtml5-dialog-field="className">
          <option value="">default</option>
          <option value="wysiwyg-float-left">left</option>
          <option value="wysiwyg-float-right">right</option>
        </select>
      </label>
      <a data-wysihtml5-dialog-action="save">OK</a>&nbsp;<a data-wysihtml5-dialog-action="cancel">Cancel</a>
    </div>
  </div>
  
  <textarea rows=24, cols=80, style="width:553px;" name="' . $this->view->escape($name) . '"'
                . ' id="' . $this->view->escape($id) . '"'
                . $disabled
                . $this->_htmlAttribs($attribs) . '>'
                . $this->view->escape($value) . '</textarea>';
												
        return $xhtml;
    }
}
