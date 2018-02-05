<?php

class Advancedarticles_Model_Artarticle extends Core_Model_Item_Abstract
{

	protected $_type = 'artarticle';
	protected $_owner_type = 'user';
	protected $_parent_type = 'user';
	protected $_parent_is_owner = true;
	protected $_moduleName = 'advancedarticles';

	public function getHref( $adv_params = array() )
	{
		$params = array(
			'art_id' => $this->artarticle_id
		);
		$params = array_merge( $params, $adv_params );
		$seo = !empty( $this->url ) ? '/' . $this->url : '';
		return Zend_Controller_Front::getInstance()->getRouter()->assemble( $params, 'advancedarticles_article', true ) . $seo;
	}

	public function getTitle()
	{
		if ( isset( $this->title ) && '' !== trim( $this->title ) ) return $this->title;
	}

	public function getBody()
	{
		if ( isset( $this->body ) && '' !== trim( $this->body ) ) return $this->body;
	}

	public function getDescription()
	{
		$description = '';
		if ( isset( $this->description ) ) {
			$description = substr( $this->description, 0, 250 );
		}

		return $description;
	}

	public function getAllTags()
	{
		$tag_map = $this->tags()->getTagMaps( $this );
		$keywords = '';
		$separator = '';
		foreach ( $tag_map as $tag ) {
			$keywords .= $separator . $tag->getTag()->getTitle();
			$separator = ', ';
		}
		return $keywords;
	}

	public function getAraticleTags()
	{
		return $this->tags()->getTagMaps( $this );
	}

	public function getArticleUserTags( $user )
	{
		$mapTags = $this->tags()->getMapTable();
		$select = $mapTags->select()
			->where( 'resource_type = ?', $this->getType() )
			->where( 'tagger_type = ?', $user->getType() )
			->where( 'tagger_id = ?', $user->getIdentity() )
			->where( 'tag_type = ?', 'core_tag' )
			->order( 'tag_id asc' );

		$tags_id = array();
		foreach ( $mapTags->fetchAll( $select ) as $tag ) {
			$tags_id[ ] = $tag->tag_id;
		}

		return Engine_Api::_()->getItemMulti( 'core_tag', array_unique( $tags_id ) );
	}

	public function getRelatedArticles( $module = 'advancedarticles' )
	{
		$related_tags = array();
		foreach ( $this->getAraticleTags() as $tag ) {
			$related_tags[ ] = $tag->getTag()->tag_id;
		}
		$table = Engine_Api::_()->getDbtable( 'artarticles', $module );
		$TableName = $table->info( 'name' );

		$tagTable = Engine_Api::_()->getDbtable( 'TagMaps', 'core' );
		$tagTableName = $tagTable->info( 'name' );

		$select = $table->select()
			->from( $TableName )
			->joinLeft( $tagTableName, "`{$tagTableName}`.`resource_id` = `{$TableName}`.`artarticle_id`", null )
			->where( "{$TableName}.search = ?", 1 )
			->where( "{$TableName}.status = ?", 'active' )
			->where( $tagTableName . '.tag_id IN(?)', (array)$related_tags )
			->where( $tagTableName . '.resource_type = ?', 'artarticle' )
			->where( $tagTableName . '.resource_id != ?', $this->getIdentity() )
			->order( $TableName . '.created_date' );

		return $select;
	}

	public function addPhoto( $photo_id = 0, $module = 'advancedarticles' )
	{
		$viewer = Engine_Api::_()->user()->getViewer();
		$table = Engine_Api::_()->getDbtable( 'photos', $module );
		$album = $this->getAlbum();

		$photo = $table->createRow();
		$photo->album_id = $photo->collection_id = $album->getIdentity();
		$photo->created_date = $photo->updated_date = date( 'Y-m-d H:i:s' );
		$photo->file_id = $photo_id;
		$photo->owner_id = $viewer->getIdentity();
		$photo->owner_type = $viewer->getType();
		$photo->artarticle_id = $this->getIdentity();
		$photo->save();
	}

	public function deleteAll( $article = 0, $module = 'advancedarticles' )
	{
		Engine_Api::_()->getDbtable( 'albums', $module )->delete( array(
			'artarticle_id = ?' => $article,
		) );
		Engine_Api::_()->getDbtable( 'photos', $module )->delete( array(
			'artarticle_id = ?' => $article,
		) );
	}

	public function getAlbum( $module = 'advancedarticles' )
	{
		$viewer = Engine_Api::_()->user()->getViewer();
		$table = Engine_Api::_()->getDbtable( 'albums', $module );
		$select = $table->select()
			->where( 'artarticle_id = ?', $this->getIdentity() )
			->limit( 1 );
		$row = $table->fetchRow( $select );
		// Save
		if ( null == $row ) {
			$row = $table->createRow();
			$row->title = $this->getTitle();
			$row->artarticle_id = $this->getIdentity();
			$row->created_date = $row->updated_date = date( 'Y-m-d H:i:s' );
			$row->owner_id = $viewer->getIdentity();
			$row->owner_type = $viewer->getType();
			$row->save();
		}

		return $row;
	}

	public function getOwnerArticle()
	{
		$article = Engine_Api::_()->getDbtable( 'artarticles', 'advancedarticles' );
		$aName = $article->info( 'name' );
		$select = $article->select()
			->from( $aName, 'artarticle_id' )
			->where( "`{$aName}`.`owner_id` = ?", $this->owner_id )
			->where( "`{$aName}`.`search` = ?", 1 )
			->where( "`{$aName}`.`status` = ?", 'active' );
		return $article->fetchAll( $select );
	}

	public function isActive()
	{
		return $this->status == 'active' ? true : false;
	}

	public function tags()
	{
		return new Engine_ProxyObject( $this, Engine_Api::_()->getDbtable( 'tags', 'core' ) );
	}

	public function comments()
	{
		return new Engine_ProxyObject( $this, Engine_Api::_()->getDbtable( 'comments', 'core' ) );
	}

	public function likes()
	{
		return new Engine_ProxyObject( $this, Engine_Api::_()->getDbtable( 'likes', 'core' ) );
	}

}
