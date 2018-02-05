<?php

class User_Widget_LandingpageArticleController extends Engine_Content_Widget_Abstract {

public function indexAction()  {
	
	$settings = Engine_Api::_()->getApi('settings', 'core'); 
	if($settings->user_showLandingpagearticlesection == 0){
		return $this->setNoRender();
	}
	$articleTable = Engine_Api::_()->getDbtable('artarticles', 'advancedarticles');			                                           
			                                          
	$landingpageArticleDataSelect   =   $articleTable->select()
                        ->setIntegrityCheck(false)
                        ->from(array('article'=>'engine4_advancedarticles_artarticles',))                                                                                              
                        ->where('article.landingpage_article =?' ,1)
                        ->order('article.artarticle_id DESC')
                        ->limit(3);
                        
    $landingpageArticleData=$articleTable->fetchAll($landingpageArticleDataSelect); 
    
    if(count($landingpageArticleData) == 0): 
       return $this->setNoRender();
    endif;  
    
    $this->view->landingpageArticleData =  $landingpageArticleData;
} 
}


?>
