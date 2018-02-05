<?php
class Ynresponsive1_View_Helper_FormYnResCalendarSimple extends Zend_View_Helper_FormElement
{
    private static $_loaded = false;

    public function formYnResCalendarSimple($name, $value = null, $attribs = null, $options = null, $listsep = "<br />\n")
    {

        $info = $this -> _getInfo($name, $value, $attribs, $options, $listsep);
        $onSelect = 'false';

        if (isset($attribs['onSelect']))
        {
            $onSelect = $attribs['onSelect'];
        }
        extract($info);
        // name, value, attribs, options, listsep, disable

        $dateFormat = 'mdy';

        // Get use military time
        if (isset($attribs['useMilitaryTime']))
        {
            $useMilitaryTime = $attribs['useMilitaryTime'];
            //unset($attribs['useMilitaryTime']);
        }
        else
        {
            $useMilitaryTime = true;
        }

        // Prepare javascript

        // Prepare month and day names
        $localeObject = Zend_Registry::get('Locale');

        $months = Zend_Locale::getTranslationList('months', $localeObject);
        if ($months['default'] == NULL)
        {
            $months['default'] = "wide";
        }
        $months = $months['format'][$months['default']];

        $days = Zend_Locale::getTranslationList('days', $localeObject);
        if ($days['default'] == NULL)
        {
            $days['default'] = "wide";
        }
        $days = $days['format'][$days['default']];

        $calendarFormatString = trim(preg_replace('/\w/', '$0/', $dateFormat), '/');
        $calendarFormatString = str_replace('y', 'Y', $calendarFormatString);

        // Append files and script
        $dateId = $name . '-date';
        $toggleId = $name . '-toggle-date';
        $baseUrl = $this -> view -> baseUrl();

        if (!self::$_loaded)
        {
            $this->view->headScript()->appendFile($baseUrl . '/application/modules/Ynresponsive1/externals/scripts/yncalendar.js');
            self::$_loaded = true;
        }

        $this -> view -> headScript() -> appendScript("en4.core.runonce.add(function() {
        new Picker.Date('{$dateId}', {
            startDay: 0,
            format: '%Y-%m-%d',
            pickerClass: 'datepicker_jqui',
            startView: 'days',
            draggable: false,
            yearPicker: false,
            onSelect: $onSelect,
            invertAvailable: true,
            togglesOnly: false,
            toggle: $('{$toggleId}')});});");

        return '<div class="event_calendar_container" style="display:inline">' . $this -> view -> formText($name, @$value, array_merge(array(
            'class' => 'calendar-date',
            'id' => $dateId,
            'style' => 'width:120px'
        ), (array)@$attribs['dateAttribs'])) . '<span class="yncalendar_button_span" id="' . $toggleId . '">&nbsp;' . '</span>' . '</div>';
    }

}
