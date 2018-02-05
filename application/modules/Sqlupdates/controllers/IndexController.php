<?php
/**
 * unii.com
 *
 * @category   Application_Extensions
 * @package    Poll
 * @copyright  Copyright 2012-2013 unii.com
 * @license    http://www.unii.com/license
 * @version    $Id: default.tpl 9747 2012-07-26 02:08:08Z Ti Technologies (www.titechnologies.in) $
 * @author     Ti Technologies (www.titechnologies.in)
 */

/**
 * @category   Application_Extensions
 * @package    Poll
 * @copyright  Copyright 2012-2013 unii.com
 * @license    http://www.unii.com/license
 */
class Sqlupdates_IndexController extends Core_Controller_Action_Standard
{
  public function init()
  {

  }

  public function indexAction()
  {
    // Prepare
 include('sql_changes/db_changes.php');

$query= Engine_Db_Table::getDefaultAdapter()->select()
                          ->from('engine4_sqlupdates_updates')
                            ->order('sql_id DESC')->limit(1)
                             ->query()->fetch();
echo 'Last Updated version :'.$query['sql_version'].' , on '.$query['sql_date'].'<br/>';

$last_ver=$query['sql_version'];
$count=0;
$current=0;

        try
        {
            foreach($sql as $key => $val)
            {
             $query= Engine_Db_Table::getDefaultAdapter()->select()
                                      ->from('engine4_sqlupdates_updates')
                                        ->where("sql_version =?",$key)
                                         ->query()->fetchAll();
                $current= $key;
                if(count($query)<=0)
                {
                    $new_query= preg_split("/;+(?=([^'|^\\\']*['|\\\'][^'|^\\\']*['|\\\'])*[^'|^\\\']*[^'|^\\\']$)/", $val);
                    foreach ($new_query as $q){
                        if(strlen(trim($q)) > 0)
                    Engine_Db_Table::getDefaultAdapter()->query(
                        $q);}
                         $date = new Zend_Db_Expr('NOW()');
                    $data=array(
                    'sql_version' => $key,
                    'sql_date' =>$date
                    );

                    Engine_Db_Table::getDefaultAdapter()->insert('engine4_sqlupdates_updates',$data);
                    $last_ver=$key;
                    $count++;

                }

            }
        }
        catch( Exception $e )
        {
        Engine_Db_Table::getDefaultAdapter()->rollBack();
        echo 'error on  version'.$key.'<br/>'.$e->getMessage().'<br />';
        }
echo $count.' Update(s)<br/>';
if($count!=0)
echo 'New updated version :'.$last_ver;
exit;

  }
}
