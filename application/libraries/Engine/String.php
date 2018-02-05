<?php
/**
 * SocialEngine
 *
 * @category   Engine
 * @package    Engine_String
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @todo       documentation
 */

/**
 * @category   Engine
 * @package    Engine_String
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 */
class Engine_String
{
  static protected $_isNative;

  static public function isNative()
  {
    if( null === self::$_isNative )
    {
      self::$_isNative = function_exists('mb_strpos');
    }
    return self::$_isNative;
  }

  static public function strlen($string)
  {
    // Native
    if( self::isNative() )
    {
      return mb_strlen($string);
    }

    // Custom
    return strlen(preg_replace('/./u', ' ', $string));
  }

  static public function substr($string, $start, $length = null)
  {
    // Native
    if( self::isNative() )
    {
      return mb_substr($string, $start, $length);
    }

    // Custom
    $strlen = self::strlen($string);
    if( $start < 0 ) $start += $strlen;
    if( func_num_args() <= 2 ) $length = $strlen - $start;
    if( $length < 0 ) $length += $strlen - $start;

    $regex = '/^' . ( $start > 0 ? '.{'.$start.'}' : '' ) . '(.{0,'.$length.'})/u';
    preg_match($regex, $string, $m);

    if( !empty($m[1]) ) {
      return $m[1];
    } else {
      return $string;
    }
  }

  static public function strpos($haystack, $needle, $offset = null)
  {
    // Native
    if( self::isNative() )
    {
      return mb_strpos($haystack, $needle, $offset);
    }

    // Custom
    $regex = '/^(';
    if( $offset > 0 ) $regex .= '.{'.$offset.'}';
    $regex .= '.*?)'.preg_quote($needle).'.*$/u';
    if( !preg_match($regex, $haystack) ) return false;
    return self::strlen(preg_replace($regex, ' ', $haystack));
  }

  static public function strip_tags($str, $allowable_tags = null)
  {
    return strip_tags($str, $allowable_tags);
    
    // @todo this might not actually be necessary
    $str = htmlentities($str, ENT_NOQUOTES, 'UTF-8');
    $str = strip_tags($str, $allowable_tags);
    $str = html_entity_decode($str, ENT_NOQUOTES, 'UTF-8');
    return $str;
  }

  static public function ucfirst($str)
  {
    if( self::isNative() ) {
      return mb_strtoupper(mb_substr($str, 0, 1), 'UTF-8') . mb_substr($str, 1);
    } else {
//      if( !preg_match('/^(.)(.*?)$/u') ) {
//        return $str;
//      } else {
//
//      }
      // No support?
      return ucfirst($str);
    }
  }
  
  static public function str_random($length = 10)
  {
    $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    $countCharacters = self::strlen($characters);
    $randomString = '';    
    for ($i = 0; $i < $length; $i++) {
      $randomString .= $characters[rand(0, $countCharacters - 1)];
    }
    return $randomString;
  }

  static public function slug($string, $max_length = 64)
  {
    if (self::strlen($string) > $max_length) {
      $string = self::substr($string, 0, $max_length);
    }

    $search = array('À', 'Á', 'Â', 'Ã', 'Ä', 'Å', 'Æ', 'Ç', 'È', 'É', 'Ê', 'Ë', 'Ì', 'Í', 'Î', 'Ï', 'Ð', 'Ñ', 'Ò', 'Ó', 'Ô', 'Õ', 'Ö', 'Ø', 'Ù', 'Ú', 'Û', 'Ü', 'Ý', 'ß', 'à', 'á', 'â', 'ã', 'ä', 'å', 'æ', 'ç', 'è', 'é', 'ê', 'ë', 'ì', 'í', 'î', 'ï', 'ñ', 'ò', 'ó', 'ô', 'õ', 'ö', 'ø', 'ù', 'ú', 'û', 'ü', 'ý', 'ÿ', 'Ā', 'ā', 'Ă', 'ă', 'Ą', 'ą', 'Ć', 'ć', 'Ĉ', 'ĉ', 'Ċ', 'ċ', 'Č', 'č', 'Ď', 'ď', 'Đ', 'đ', 'Ē', 'ē', 'Ĕ', 'ĕ', 'Ė', 'ė', 'Ę', 'ę', 'Ě', 'ě', 'Ĝ', 'ĝ', 'Ğ', 'ğ', 'Ġ', 'ġ', 'Ģ', 'ģ', 'Ĥ', 'ĥ', 'Ħ', 'ħ', 'Ĩ', 'ĩ', 'Ī', 'ī', 'Ĭ', 'ĭ', 'Į', 'į', 'İ', 'ı', 'Ĳ', 'ĳ', 'Ĵ', 'ĵ', 'Ķ', 'ķ', 'Ĺ', 'ĺ', 'Ļ', 'ļ', 'Ľ', 'ľ', 'Ŀ', 'ŀ', 'Ł', 'ł', 'Ń', 'ń', 'Ņ', 'ņ', 'Ň', 'ň', 'ŉ', 'Ō', 'ō', 'Ŏ', 'ŏ', 'Ő', 'ő', 'Œ', 'œ', 'Ŕ', 'ŕ', 'Ŗ', 'ŗ', 'Ř', 'ř', 'Ś', 'ś', 'Ŝ', 'ŝ', 'Ş', 'ş', 'Š', 'š', 'Ţ', 'ţ', 'Ť', 'ť', 'Ŧ', 'ŧ', 'Ũ', 'ũ', 'Ū', 'ū', 'Ŭ', 'ŭ', 'Ů', 'ů', 'Ű', 'ű', 'Ų', 'ų', 'Ŵ', 'ŵ', 'Ŷ', 'ŷ', 'Ÿ', 'Ź', 'ź', 'Ż', 'ż', 'Ž', 'ž', 'ſ', 'ƒ', 'Ơ', 'ơ', 'Ư', 'ư', 'Ǎ', 'ǎ', 'Ǐ', 'ǐ', 'Ǒ', 'ǒ', 'Ǔ', 'ǔ', 'Ǖ', 'ǖ', 'Ǘ', 'ǘ', 'Ǚ', 'ǚ', 'Ǜ', 'ǜ', 'Ǻ', 'ǻ', 'Ǽ', 'ǽ', 'Ǿ', 'ǿ', 'ð');
    $replace = array('A', 'A', 'A', 'A', 'A', 'A', 'AE', 'C', 'E', 'E', 'E', 'E', 'I', 'I', 'I', 'I', 'D', 'N', 'O', 'O', 'O', 'O', 'O', 'O', 'U', 'U', 'U', 'U', 'Y', 's', 'a', 'a', 'a', 'a', 'a', 'a', 'ae', 'c', 'e', 'e', 'e', 'e', 'i', 'i', 'i', 'i', 'n', 'o', 'o', 'o', 'o', 'o', 'o', 'u', 'u', 'u', 'u', 'y', 'y', 'A', 'a', 'A', 'a', 'A', 'a', 'C', 'c', 'C', 'c', 'C', 'c', 'C', 'c', 'D', 'd', 'D', 'd', 'E', 'e', 'E', 'e', 'E', 'e', 'E', 'e', 'E', 'e', 'G', 'g', 'G', 'g', 'G', 'g', 'G', 'g', 'H', 'h', 'H', 'h', 'I', 'i', 'I', 'i', 'I', 'i', 'I', 'i', 'I', 'i', 'IJ', 'ij', 'J', 'j', 'K', 'k', 'L', 'l', 'L', 'l', 'L', 'l', 'L', 'l', 'l', 'l', 'N', 'n', 'N', 'n', 'N', 'n', 'n', 'O', 'o', 'O', 'o', 'O', 'o', 'OE', 'oe', 'R', 'r', 'R', 'r', 'R', 'r', 'S', 's', 'S', 's', 'S', 's', 'S', 's', 'T', 't', 'T', 't', 'T', 't', 'U', 'u', 'U', 'u', 'U', 'u', 'U', 'u', 'U', 'u', 'U', 'u', 'W', 'w', 'Y', 'y', 'Y', 'Z', 'z', 'Z', 'z', 'Z', 'z', 's', 'f', 'O', 'o', 'U', 'u', 'A', 'a', 'I', 'i', 'O', 'o', 'U', 'u', 'U', 'u', 'U', 'u', 'U', 'u', 'U', 'u', 'A', 'a', 'AE', 'ae', 'O', 'o', 'd');

    $string = str_replace($search, $replace, $string);
    $string = preg_replace('/([a-z])([A-Z])/', '$1 $2', $string);
    $string = strtolower($string);
    $string = preg_replace('/[^a-z0-9-]+/i', '-', $string);
    $string = preg_replace('/-+/', '-', $string);
    $string = trim($string, '-');
    if (!$string) {
      $string = '-';
    }
    return $string;
  }
}
