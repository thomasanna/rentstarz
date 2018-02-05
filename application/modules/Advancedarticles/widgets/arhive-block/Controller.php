<?php

class Advancedarticles_Widget_ArhiveBlockController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
    $front = Zend_Controller_Front::getInstance();
	$_module = $front->getRequest()->getModuleName();
	$art_id = (int) $front->getRequest()->getParam('art_id', 0);
	$article = Engine_Api::_()->getItem('artarticle', $art_id);
	$owner = null;
	if (is_object($article)) $owner = $article->owner_id;

	$art_date = @explode(" ", Engine_Api::_()->$_module()->getFirstDate($_module));
	$minDate = @explode("-", $art_date[0]);
	
    if( count($minDate) < 3 || count(array_filter($minDate)) < 3 ) {
      return $this->setNoRender();
    }	
	$minDate = mktime(0, 0, 0, $minDate[1], 1, $minDate[0]);
	$minYear = mktime(0, 0, 0, 1, 1, $minDate[0]);
	
	//Month
	$currentMonth = mktime(0, 0, 0, date("m")-1, date("d"),   date("Y"));
	$firstMonth = mktime(0, 0, 0, date("m")-11, date("d"),   date("Y"));

	$firstMonth = $minDate < $firstMonth ? $firstMonth : $minDate;

	$month = array();
	for($t = $firstMonth; $t <= $currentMonth; $t = strtotime('+1 month', $t)){
	  if ( count(Engine_Api::_()->$_module()->getArchive($_module, $t, strtotime('+1 month', $t), $owner)) )
	    $month[] = array('label' => date('F Y', $t), 'start' => $t, 'end' => strtotime('+1 month', $t));
	}
	krsort($month);
	
	//Year
	$lastYear = mktime(0, 0, 0, date("m"), date("d"),   date("Y")-1);
	$year = array();
	for($t = $minYear; $t <= $lastYear; $t = strtotime('+1 year', $t)){
	  if ( count(Engine_Api::_()->$_module()->getArchive($_module, $t, strtotime('+1 year', $t), $owner)) )	
	    $year[] = array('label' => date('F Y', $t), 'start' => $t, 'end' => strtotime('+1 year', $t));
	}
	krsort($year);
	$this->view->archive = $archives = array_merge($month, $year);	
	if (!count($archives)) return $this->setNoRender();
  }    
}  