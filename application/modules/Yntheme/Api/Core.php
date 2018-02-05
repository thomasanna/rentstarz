<?php

class Yntheme_Api_Core {
	
	public function getActiveTheme(){
		$model =  Engine_Api::_()->getDbTable('Themes','Core');
		$select =  $model->select()->where('active=?',1);
		$theme =  $model->fetchRow($select);
		if(is_object($theme)){
			return $theme->name;
		}
		return 'default';
		
	}
	
	
	/**
	 * @see     engine4_core_page
	 * @param   string|int  $page page_id or name
	 * @return  Core_Model_Page 
	 */
	public function getPage($page_name){
		$model =  Engine_Api::_()->getDbTable('Pages','Core');
		$select = $model->select()->where('page_id=?', $page_name)->orWhere('name=?',$page_name);
		$page = $model->fetchRow($select);
		return $page;
	}
	
	/**
	 * @param   Core_Model_Page   $page
	 * @return  Array
	 */
	public function getContent($page){
	if($page)
	{
		$model =  Engine_Api::_()->getDbTable('Content','Core');
		$select =  $model->select()->where('page_id=?', $page->getIdentity())->order('parent_content_id')->order('order');
		$contents = $model->fetchAll($select);
		
		return $contents->toArray();
		}
	}
	
	
	/**
	 * @param   string|int  $page_name  page_id or name 
	 * @see     engine4_core_page
	 */
	public function getStructure($page_name){

		$page =  $this->getPage($page_name);
		$contents =  $this->getContent($page);
		$result = array();
		
		foreach($contents as $content){
			if($content['parent_content_id'] != NULL){
				continue;
			}
			$result[] =  $this->contentToRow($contents, $content);
		}
		return $result;
	}
	
	protected function contentToRow($contents, $content){
		return array(
			$content['page_id'],
			$content['type'],
			$content['name'],
			$content['order'],
			(string) $content['params'],
			(string) $content['attribs'],
			$this->getChildrenContent($contents, $content)
		);
	}
	
	/**
	 * @param  Array   $contents
	 * @param  Core_Model_Content $parent_content  $parent_content
	 * @return array 
	 */
	protected function getChildrenContent($contents, $parent_content){
		
		if($parent_content['type'] != 'container'){
			return array();
		}
		
		
		$result =  array();
		
		$parent_content_id =  $parent_content['content_id'];
		
		foreach($contents as $content){
			if($content['parent_content_id'] == $parent_content_id){
				$result[] =  $this->contentToRow($contents, $content);
			}
		}
		return $result;
	}
	
	public function getManifest($theme){
	  	$filename =  APPLICATION_PATH . '/application/themes/'. $theme . '/manifest.php';
		$config = array();
		if(file_exists($filename) && is_readable($filename)){
			$config  = include $filename;
		}
		return $config;
	}
	
	
	public function getInstallFilename($theme, $file =  'reset.php'){
		
		$dir = APPLICATION_PATH . '/application/themes/configure';
		
		if(!is_dir($dir)){
			@mkdir($dir,0777);
		}
		
		$dir  = $dir .'/' . $theme;
		
		if(!is_dir($dir)){
			@mkdir($dir,0777);
		}
		return  $dir .'/'.  $file;
	}
	
	public function exportStructure($theme,$file = 'reset.php'){
		$manifest =  $this->getManifest($theme);
		$pages = array(1,2,3,4);
		
		if(isset($manifest['pages'])){
			$pages = $manifest['pages'];
		}
		
		$structure = array();
		foreach($pages as $page){
			$structure[$page] =  $this->getStructure($page);
		}
		$content = var_export($structure, true);
		$filename =  $this->getInstallFilename($theme,$file);
		echo $filename;
		$fp =  fopen($filename, 'w');
		fwrite($fp, '<?php return ');
		fwrite($fp, $content);
		fwrite($fp, ' ?>');
		fclose($fp);
	}
	
	/**
	 * @param   int|string  $page_id
	 */
	public function cleanStruture($model, $page_id){
		$model->delete('page_id = '. $page_id);
	}
	
	public function importStructure($theme, $old_theme = null){
		if($old_theme == NULL){
			$old_theme = $this->getActiveTheme();
		}
		
		$old_manifest = $this->getManifest($old_theme);
		
		if($old_manifest['package']['author'] == 'Webligo Developments'){
			$this->exportStructure('default','reset.php');
		}else{
			$this->exportStructure($old_theme,'reset.php');
		}

		$filename =  $this->getInstallFilename($theme,'backup.php');
			
		if(!is_file($filename)){
			$filename =  $this->getInstallFilename($theme,'reset.php');
		}
		
		if(!is_file($filename)){
			$filename =  $this->getInstallFilename('default','reset.php');
		}
		
		if(!is_file($filename)){
			return ;
		}
		
		$model =  Engine_Api::_()->getDbTable('Content','Core');		
		
		if(!file_exists($filename)){
			return false;
		}
		
		$structure =  include $filename;
		
		foreach($structure as $page_id=>$contents){
			$this->cleanStruture($model, $page_id);
			foreach($contents as $config){
				$this->importContent($model, NULL, $config);
			}
		}
	}

	public function importContent($model, $parent_content_id, $config){
		
		if(!is_array($config) || count($config) <6){
			return ;
		}
		list($page_id, $type, $name, $order, $params, $attribs, $children ) = $config;
		$content =  $model->fetchNew();
		
		$content->setFromArray(array(
			'page_id'=>$page_id,
			'type'=>$type,
			'name'=>$name,
			'parent_content_id'=>$parent_content_id,
			'order'=>$order,
			'params'=>$params,
			'attribs'=>$attribs
		));
		
		$content->save();
		
		if(is_array($children) && count($children)){
			foreach($children as $child){
				$this->importContent($model, $content->content_id, $child);
			}
		}
	}
}
