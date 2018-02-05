<?php

class User_View_Helper_Intro extends Zend_View_Helper_Abstract

{
	public function introtext($profileType){
		
		$introTextArray = array();
		
		if($profileType  == 'landlord'){
			$introTextArray['newScoutText']     = 'Create a scout to find renters, it\'s like posting a rental ad. You can name, edit and quick search your scout.';
			$introTextArray['selectScoutText']  = 'Find your scouts (rental ads) by name and edit them. ';
		    $introTextArray['propertyText']     = 'Add a property, upload photos and videos of the property. See how many people have view your property and if admin has approve your property.';
            $introTextArray['documentText']     = 'First create a folder and then upload documents. View, share, remake, copy, or delete documents.'; 
            $introTextArray['articlesText']     = 'Read and save articles.';   
            $introTextArray['heartIconText']    = 'Save renters you are interested in contacting.';  
            $introTextArray['searchIconText']   = 'Search for renters.'; 
            $introTextArray['posttoscoutText']  = '';        
            $introTextArray['applicationText']  = '';              
		}
		if($profileType  == 'tenant'){
			$introTextArray['newScoutText']     =  'Create a scout to find landlords, it\'s like posting a wanted ad. You can name, edit and quick search your scout.';
		    $introTextArray['selectScoutText']  =  'Find your scouts (wanted ads) by name and edit them.';
		    $introTextArray['applicationText']  =  'Complete a background check without or without an eviction. See if your rental application is under review or approve. Edit your application.';
	        $introTextArray['posttoscoutText']  =  'Add the features and location of the apartment you desire. Review and edit your post.';
            $introTextArray['documentText']     =  'First create a folder and then upload documents. View, share, remake, copy, or delete documents.';
            $introTextArray['articlesText']     =  'Read and save articles.';
            $introTextArray['heartIconText']    =  'Save apartments that you like.';
            $introTextArray['searchIconText']   =  'Search for landlords.';
            $introTextArray['propertyText']     =  '';
		}
		return $introTextArray;
	}
}
