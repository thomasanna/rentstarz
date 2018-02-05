<?php
/**
 * SocialEngine
 *
 * @category   Engine
 * @package    Engine_Date
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */

/**
 * @category   Engine
 * @package    Engine_Date
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Engine_Date
{

  static public function parseISO8601($iso_duration, $allow_negative = true)
  {
    // Parse duration parts
    $matches = array();
    preg_match('/^(-|)?P([0-9]+Y|)?([0-9]+M|)?([0-9]+D|)?T?([0-9]+H|)?([0-9]+M|)?([0-9]+S|)?$/', $iso_duration, $matches);
    if (empty($matches)) {
      return false;
    }
    // Strip all but digits and -
    foreach ($matches as &$match) {
      $match = preg_replace('/((?!([0-9]|-)).)*/', '', $match);
    }
    // Fetch min/plus symbol
    $result['symbol'] = ($matches[1] == '-') ? $matches[1] : '+'; // May be needed for actions outside this function.
    // Fetch duration parts
    $m = ($allow_negative) ? $matches[1] : '';
    $result['year'] = intval($m . $matches[2]);
    $result['month'] = intval($m . $matches[3]);
    $result['day'] = intval($m . $matches[4]);
    $result['hour'] = intval($m . $matches[5]);
    $result['minute'] = intval($m . $matches[6]);
    $result['second'] = intval($m . $matches[7]);
    return $result;
  }

  static public function convertISO8601IntoSeconds($iso_duration)
  {
    if (class_exists('DateInterval')) {
      $Duration = new DateInterval($iso_duration);
      $d1 = new DateTime();
      $d2 = new DateTime();
      $d2->add($Duration);
      return $d2->getTimestamp() - $d1->getTimestamp();
    }

    $duration = self::parseISO8601($iso_duration, false);
    if ($duration) {
      extract($duration);
      $dparam = $symbol; // plus/min symbol
      $dparam .= (!empty($year)) ? $year . 'Year' : '';
      $dparam .= (!empty($month)) ? $month . 'Month' : '';
      $dparam .= (!empty($day)) ? $day . 'Day' : '';
      $dparam .= (!empty($hour)) ? $hour . 'Hour' : '';
      $dparam .= (!empty($minute)) ? $minute . 'Minute' : '';
      $dparam .= (!empty($second)) ? $second . 'Second' : '';
      $date = '19700101UTC';
      return strtotime($date . $dparam) - strtotime($date);
    } else {
      // Not a valid iso duration
      return false;
    }
  }
}
