<?php

class Advancedarticles_Api_Connections extends Core_Api_Abstract
{

public function getarticlecomments($viewer_id,$article_id){
			
		$view = Zend_Registry::get('Zend_View');
        $view = clone $view;
        $view->clearVars();	
        
        
        $articlecommentTable =  Engine_Api::_()->getDbtable('Articlecomments', 'user');
		
		$articlecommentData = $articlecommentTable->fetchAll($articlecommentTable->select()
			
			                                           ->where('articleId = ?', $article_id));
			                                           
	   	
	    
	    $view->articlecommentData =$articlecommentData;
	    
	    $content = $view->render('_articlecommentlist.tpl');
	    
	    
	    $coment_post_content = '';
	    $coment_post_content = $coment_post_content.'<form>';
	    $coment_post_content = $coment_post_content.'<textarea class="article_comment_body article_comment_body_'.$article_id.'"></textarea>';
	    $coment_post_content = $coment_post_content.'<input type="button" value="Post" class="comment_post_btn" article_id="'.$article_id.'">';
        $coment_post_content = $coment_post_content.'</form>';
        
      
	    $result = array('html'=>$content,'commentcount' =>count($articlecommentData),'coment_post_content'=>$coment_post_content); 
        echo json_encode($result);
	}
	
	
	public function getsavedarticles($viewer_id){
		
		$view = Zend_Registry::get('Zend_View');
        $view = clone $view;
        $view->clearVars();	
        
        $articleTable = Engine_Api::_()->getDbtable('artarticles', 'advancedarticles');			                                           
			                                          
	    $savedArticleSelect   =   $articleTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('article'=>'engine4_advancedarticles_artarticles',))
                        ->joinLeft(array('article_like'=>'engine4_article_likes'),'article_like.articleId=article.artarticle_id',null)                                                                            
                        ->where('article_like.likedBy =?' , $viewer_id); 
                        
        $savedArticleData=$articleTable->fetchAll($savedArticleSelect);   
        
        $view->savedArticleData =$savedArticleData;
	    
	    $content = $view->render('_articlesavedlist.tpl');  
	    
	    $result = array('html'=>$content,'savedcount' =>count($savedArticleData)); 
	    
        echo json_encode($result);                   
		
	}
}
