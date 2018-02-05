<?php

class Advancedarticles_Widget_TrendingArticlesController extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
    $perpage = $this->_getParam('perpage', 5);
	
	$articles = Engine_Api::_()->advancedarticles()->gettrendingarticles(0, 'advancedarticles', array());

	if (!is_object($articles)) return $this->setNoRender();
		
    $paginator = Zend_Paginator::factory($articles);
    $paginator->setItemCountPerPage($perpage);
    $paginator->setCurrentPageNumber(1);
	$this->view->paginator = $paginator;
	
	if (!$paginator->getTotalItemCount()) return $this->setNoRender();
	
	
	$viwer_id=Engine_Api::_()->user()->getViewer()->getIdentity(); 
			                                           
    $articleTable = Engine_Api::_()->getDbtable('artarticles', 'advancedarticles');			                                           
			                                          
	$savedArticleSelect   =   $articleTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('article'=>'engine4_advancedarticles_artarticles',))
                        ->joinLeft(array('article_like'=>'engine4_article_likes'),'article_like.articleId=article.artarticle_id',null)                                                                            
                        ->where('article_like.likedBy =?' , $viwer_id); 
                        
    $this->view->savedArticleData  = $savedArticleData=$articleTable->fetchAll($savedArticleSelect);                    

  }    
}  
