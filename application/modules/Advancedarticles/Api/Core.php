<?php

class Advancedarticles_Api_Core extends Core_Api_Abstract {

    protected $privacyLabel = array(
        'everyone' => 'Everyone',
        'registered' => 'All Registered Members',
        'owner_network' => 'Friends and Networks',
        'owner_member_member' => 'Friends of Friends',
        'owner_member' => 'Friends Only',
        'owner' => 'Just Me'
    );
    protected $sortArticle = array(
        1 => array('created_date'),
        2 => array('featured'),
        3 => array('featured', 'sponsored'),
        4 => array('sponsored', 'created_date'),
        5 => array('sponsored', 'featured')
    );

    public function getFilterValue() {
        $front = Zend_Controller_Front::getInstance();
        // Check form
        $form = new Advancedarticles_Form_Filter(array(
                    'type' => 'artarticle'
                ));

        if (!$form->isValid($front->getRequest()->getParams())) {
            return array('values' => array(), 'form' => $form);
        }
        $values = $form->getValues();
        $values = $this->updateParams($values);
        return array('values' => array_filter($values), 'form' => $form);
    }

    public function getFirstDate($module) {
        $table = Engine_Api::_()->getDbtable('artarticles', $module);
        $aName = $table->info('name');
        $select = $table->select()
                ->from($aName, 'MIN(created_date) AS min')
                ->where("`{$aName}`.`search` = ?", 1)
                ->where("`{$aName}`.`status` = ?", 'active')
        ;
        return $table->fetchRow($select)->min;
    }

    public function getArchive($module, $start, $end, $owner = null) {
        $table = Engine_Api::_()->getDbtable('artarticles', $module);
        $aName = $table->info('name');
        $select = $table->select()
                ->from($aName)
                ->where("`{$aName}`.`created_date` >= ?", date('Y-m-d', $start))
                ->where("`{$aName}`.`created_date` <= ?", date('Y-m-d', $end))
                ->where("`{$aName}`.`search` = ?", 1)
                ->where("`{$aName}`.`status` = ?", 'active');

        if ($owner)
            $select->where("`{$aName}`.`owner_id` = ?", $owner);

        return $table->fetchAll($select);
    }

    public function getUserCategories($user) {
        $table = Engine_Api::_()->getDbtable('categories', 'advancedarticles');
        $article = Engine_Api::_()->getDbtable('artarticles', 'advancedarticles');
        $cName = $table->info('name');
        $aName = $article->info('name');
        $select = $table->select()
                ->distinct(true)
                ->from($cName)
                ->join($aName, "`{$cName}`.`category_id` = `{$aName}`.`category_id`", null)
                ->where("`{$aName}`.`owner_id` = ?", $user)
                ->where("`{$aName}`.`search` = ?", 1)
                ->where("`{$aName}`.`status` = ?", 'active')
        ;
        return $table->fetchAll($select);
    }

    public function getPrivacy() {
        return $this->privacyLabel;
    }

    public function getSort($param = null) {
        if ($param)
            return $this->sortArticle[$param];
        return $this->sortArticle;
    }

    public function setAllowed($resource, $allow, $action) {
        $privacy = Engine_Api::_()->authorization()->context;
        $privacyLabel = array('owner', 'owner_member', 'owner_member_member', 'owner_network', 'registered', 'everyone'); //array_keys($this->getPrivacy());
        $allow = $allow ? $allow : 'everyone'; // if not selected
        $slice = array_search($allow, $privacyLabel);
        foreach ($privacyLabel as $k => $role)
            $privacy->setAllowed($resource, $role, $action, ($k <= $slice));
    }

    public function createPhoto($img, $user_id, $parent_id, $type = 'artarticle', $parent_type = 'artarticle') {
        $imageObject = array();
        if ($img instanceof Zend_Form_Element_File) {
            $file = $img->getFileName();
            $fileName = basename($file);
        } else if (is_array($img) && !empty($img['tmp_name'])) {
            $file = $img['tmp_name'];
            $fileName = $img['name'];
        }
        else
            return false;

        if (!$fileName) {
            $fileName = $file;
        }
        //storage system
        $params = array(
            'type' => $type,
            'name' => $fileName,
            'parent_type' => $parent_type,
            'parent_id' => $parent_id,
            'user_id' => $user_id,
            'extension' => substr($fileName, strrpos($fileName, '.') + 1),
        );

        $extension = strtolower(ltrim(strrchr($fileName, '.'), '.'));
        $base = rtrim(substr($fileName, 0, strrpos($fileName, '.')), '.');
        $temporary = APPLICATION_PATH . DIRECTORY_SEPARATOR . 'temporary';

        $img_type = array('_m', '_p', '_n', '_i');
        $img_param = array(array(720, 720), array(200, 400), array(140, 160), array(48, 48));
        $img_child = array('thumb.profile', 'thumb.normal', 'thumb.icon');
        $create_img = Engine_Api::_()->storage();

        foreach ($img_type as $key => $type) {
            $path = $temporary . DIRECTORY_SEPARATOR . $base . $type . '.' . $extension;
            $image_tmp = Engine_Image::factory();
            $image_tmp->open($file);
            if ($type == '_i') { // if icon
                $icon_size = min($image_tmp->height, $image_tmp->width);
                $dst_x = ($image_tmp->width - $icon_size) * 0.5;
                $dst_y = ($image_tmp->height - $icon_size) * 0.5;
                $image_tmp->resample($dst_x, $dst_y, $icon_size, $icon_size, $img_param[$key][0], $img_param[$key][1]);
            }
            else
                $image_tmp->resize($img_param[$key][0], $img_param[$key][1]);
            $image_tmp->write($path);
            $image_tmp->destroy();

            $imageObject[] = $create_img->create($path, $params);
            @unlink($path);
        }

        if ($imageObject)
            foreach ($img_child as $key => $child)
                $imageObject[0]->bridge($imageObject[$key + 1], $child);

        return $imageObject[0]; //main photo
    }

    public function checkURL($url) {
        $url = preg_replace('/[^a-z0-9]+|[-]{2,}/i', '-', $url);
        return strtolower(trim($url, "- \n\r\t"));
    }

    public function getCategoryObject($cid, $module) {
        if (!$cid)
            return false;
        // Get Category object
        $table = Engine_Api::_()->getDbtable('categories', $module);
        $categoriesTableName = $table->info('name');
        $select = $table->select()
                ->from($categoriesTableName)
                ->where($categoriesTableName . '.category_id = ?', $cid)
                ->limit(1);
        $row = $table->fetchRow($select);

        return $row;
    }

    public function getCategoryID($art_id) {
        if (!$art_id)
            return false;
        // Get Category ID
        $article = Engine_Api::_()->getItem('artarticle', $art_id);
        if (!is_object($article))
            return false;

        return $article->category_id;
    }

    public function getPageObject() {
        $request = Zend_Controller_Front::getInstance()->getRequest();

        // Get page
        $action = $request->getActionName();

        // Have to un inflect
        if (is_string($action)) {
            $page = $request->getModuleName() . '_' . $request->getControllerName() . '_' . $request->getActionName();
            $actionNormal = strtolower(preg_replace('/([A-Z])/', '-\1', $action));
        }

        // Get page object
        $pageTable = Engine_Api::_()->getDbtable('pages', 'core');
        $pageSelect = $pageTable->select();

        if (is_numeric($action)) {
            $pageSelect->where('page_id = ?', $action);
        } else {
            $pageSelect
                    ->orWhere('name = ?', str_replace('-', '_', $page))
                    ->orWhere('url = ?', $actionNormal);
        }

        $pageObject = $pageTable->fetchRow($pageSelect);

        return $pageObject;
    }

    public function getArticles($id, $module = 'advancedarticles', $sort = array(), $filter = array(), $type = 'category', $limit = 0) {
        $table = Engine_Api::_()->getDbtable('artarticles', $module);
        $TableName = $table->info('name');

        $searchTable = Engine_Api::_()->fields()->getTable('artarticle', 'search');
        $searchTableName = $searchTable->info('name');

        $select = $table->select()
                ->from($TableName)
                ->joinLeft($searchTableName, "`{$searchTableName}`.`item_id` = `{$TableName}`.`artarticle_id`", null);

        if ($type != 'owner')
            $select->where("{$TableName}.search = ?", 1);

        if ($id)
            $select->where($TableName . "." . $type . "_id = ?", $id);

        // Add Owner
        if (isset($filter['owner']) && !empty($filter['owner'])) {
            $select->where("(`{$TableName}`.`owner_id` = ?)", $filter['owner']);
        }

        // Add Title
        if (isset($filter['title']) && !empty($filter['title'])) {
            $select->where("(`{$TableName}`.`title` LIKE ?)", "%{$filter['title']}%");
        }
        // Add Category
        if (isset($filter['id']) && !empty($filter['id'])) {
            $select->where("(`{$TableName}`.`category_id` = ?)", $filter['id']);
        }
        // Add Date
        if (isset($filter['start']) && !empty($filter['start'])) {
            $select->where("(`{$TableName}`.`created_date` >= ?)", date("Y-m-d", $filter['start']));
        }
        if (isset($filter['end']) && !empty($filter['end'])) {
            $select->where("(`{$TableName}`.`created_date` <= ?)", date("Y-m-d", $filter['end']));
        }
        // Add Tags
        if (isset($filter['tag']) && !empty($filter['tag'])) {
            $tagTable = Engine_Api::_()->getDbtable('TagMaps', 'core');
            $tagTableName = $tagTable->info('name');

            $select
                    ->joinLeft($tagTableName, "`{$tagTableName}`.`resource_id` = `{$TableName}`.`artarticle_id`", null)
                    ->where($tagTableName . '.tag_id = ?', $filter['tag'])
                    ->where($tagTableName . '.resource_type = ?', 'artarticle');
        }

        // Search Questions
        $questions = Engine_Api::_()->fields()->getSearchQuery('artarticle', $filter);
        foreach ($questions as $key => $value) {
            $select->where("`{$searchTableName}`.{$key}", $value);
        }

        if ($type != 'owner')
            $select
                    ->where("{$TableName}.status = ?", 'active');

        $select->group("{$TableName}.artarticle_id");
        

        foreach ($sort as $order) {
            $select->order($order . ' asc');
        }
        $select->order('position asc');
        // Add Order
        if (isset($filter['order']) && !empty($filter['order'])) {
            $a = $filter['order'] == 'title' ? ' asc' : ' desc';
            $select->order($filter['order'] . $a);
        }

        if (!in_array('created_date', $sort) || !in_array('created_date', $filter)) {
            $select->order('created_date desc');
        }
		
		if ($limit) {
			$select->limit($limit);
		}

        return $select;
    }

    public function getArticlesFor($type = 'sponsored', $sort = array('sponsored', 'created_date'), $limit = 3, $category = 0) {
        $table = Engine_Api::_()->getDbtable('artarticles', 'advancedarticles');
        $TableName = $table->info('name');

        $select = $table->select()
                ->from($TableName)
                ->where("{$TableName}.search = ?", 1)
                ->where("{$TableName}.status = ?", 'active')
                ->where($TableName . "." . $type . " = ?", 1);

        if ($category)
            $select->where("{$TableName}.category_id = ?", $category);

        foreach ($sort as $order) {
            $a = $order == 'title' ? ' asc' : ' desc';
            $select->order($order . $a);
        }

        $select
                ->limit($limit);

        return $select;
    }

    public function loadCategory($module) {
        $table = Engine_Api::_()->getDbtable('categories', $module);
        $categoryTableName = $table->info('name');
        $sql = "
		SELECT node.category_id, node.name, node.parent_id, node.sort, node.url, (COUNT(parent.name) - 1) AS depth,
							node.left_id, node.right_id
						FROM " . $categoryTableName . " AS node,
							" . $categoryTableName . " AS parent
						WHERE node.left_id BETWEEN parent.left_id AND parent.right_id
						GROUP BY node.category_id
						ORDER BY node.sort asc
	"; //node.left_id asc,

        return $table->getAdapter()->query($sql)->fetchAll();
    }

    public function checkOrder($parentId, $module) {
        $table = Engine_Api::_()->getDbtable('categories', $module);
        $categoriesTableName = $table->info('name');
        if ($parentId) {
            $select = $table->select()
                    ->from($categoriesTableName)
                    ->where($categoriesTableName . '.category_id = ?', $parentId)
                    ->limit(1);
            $row = $table->fetchRow($select);
        } else {
            $select = $table->select()
                    ->from($categoriesTableName, new Zend_Db_Expr('MAX(right_id) AS right_id'))
                    ->limit(1);
            $row = $table->fetchRow($select);
        }

        $rightId = ($parentId) ? $row->right_id : $row->right_id + 1;

        if ($rightId != null) {
            $sql = "UPDATE " . $categoriesTableName . "
							SET left_id = IF(left_id > " . $rightId . ", left_id + 2, left_id), 
								right_id = IF(right_id >= " . $rightId . ", right_id + 2, right_id)";
            $table->getAdapter()->query($sql);

            return $rightId; //left_id		
        }

        return false;
    }

    public function sortCategory($sortID, $sortIND, $module = 'advancedarticles') {
        $table = Engine_Api::_()->getItemTable($module . '_category');
        foreach ($sortID as $key => $cid) {
            if (!empty($cid)) {
                $table->update(array(
                    'sort' => $sortIND[$key],
                        ), array(
                    'category_id = ?' => $cid,
                ));
            }
        }
        return true;
    }

    public function maxSort($module = 'advancedarticles') {
        $table = Engine_Api::_()->getDbtable('categories', $module);
        $categoriesTableName = $table->info('name');
        $select = $table->select();
        $select
                ->from($categoriesTableName, new Zend_Db_Expr('MAX(sort) AS max_sort'));
        $rawData = $table->fetchRow($select);
        return $rawData->max_sort;
    }

    public function getTopPosters($limit = 5, $module = 'advancedarticles') {
        $table = Engine_Api::_()->getDbtable('artarticles', $module);
        $aTableName = $table->info('name');

        $userTable = Engine_Api::_()->getItemTable('user');
        $userTableName = $userTable->info('name');

        $select = $table->select();
        $select
                ->setIntegrityCheck(false)
                ->from($aTableName, new Zend_Db_Expr('COUNT(owner_id) AS articles_count'))
                ->join($userTableName, "`{$aTableName}`.`owner_id` = `{$userTableName}`.`user_id`", array('engine4_users.username as username', 'engine4_users.user_id as id'))
                ->where("{$aTableName}.search = ?", 1)
                ->where("{$aTableName}.status = ?", 'active')
                ->group($aTableName . '.owner_id')
                ->order('articles_count desc')
                ->limit($limit);

        return $select;
    }

    public function migrateSubdir($parentId, $module) {
        $table = Engine_Api::_()->getDbtable('categories', $module);
        $categoriesTableName = $table->info('name');
        $sql = "UPDATE " . $categoriesTableName . "
						SET parent_id = 0
						WHERE parent_id = " . $parentId;

        $table->getAdapter()->query($sql);
    }

    public function updateParams($options) {
        $tmp = array();
        foreach ($options as $k => $v) {
            if (null == $v || '' == $v || (is_array($v) && count(array_filter($v)) == 0)) {
                continue;
            } else if (false !== strpos($k, '_field_')) {
                list($null, $field) = explode('_field_', $k);
                $tmp['field_' . $field] = $v;
            } else if (false !== strpos($k, '_alias_')) {
                list($null, $alias) = explode('_alias_', $k);
                $tmp[$alias] = $v;
            } else {
                $tmp[$k] = $v;
            }
        }
        return $tmp;
    }

    public function initTinyMCE() {
        $locale = new Zend_Locale();
        $lang = $locale->getLanguage();

        // Initialaze TinyMCE
        return array(
            'mode' => "exact",
			'bbcode' => true,
			'html' => true,
            //'plugins' => "emotions, xhtmlxtras, preview, paste, style, table, fullscreen, layer",
            //'theme' => "advanced",
            //'skin' => 'o2k7',
            //'theme_advanced_buttons1' => "save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,styleselect,formatselect,fontselect,fontsizeselect",
            //'theme_advanced_buttons2' => "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,|,insertdate,inserttime,preview,|,forecolor,backcolor",
            //'theme_advanced_buttons3' => 'tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,advhr,|,fullscreen',
            'height' => "350",
            'language' => !empty($lang) ? $lang : 'en',
            'directionality' => "ltr",
            'upload_url' => Zend_Controller_Front::getInstance()->getRouter()->assemble(array('action' => 'upload'), 'advancedarticles_general', true),
            'relative_urls' => "",
            'elements' => "description",
            'width' => "580",
            'extended_valid_elements' => "object[width|height|classid|codebase],param[name|value],embed[src|type|width|height|flashvars|wmode]"
        );
    }

    public function imageTab($baseUrl, $file) {
        return '
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>{#advanced_dlg.image_title}</title>
	<script type="text/javascript" src="' . $baseUrl . '/externals/tinymce/tiny_mce_popup.js"></script>
	<script type="text/javascript" src="' . $baseUrl . '/externals/tinymce/utils/mctabs.js"></script>
	<script type="text/javascript" src="' . $baseUrl . '/externals/tinymce/utils/form_utils.js"></script>
	<script type="text/javascript" src="' . $baseUrl . '/externals/tinymce/themes/advanced/js/image.js"></script>
</head>
<body id="image" style="display: none">
<form onsubmit="ImageDialog.update();return false;" action="#">
	<div class="tabs">
		<ul>
			<li id="general_tab" class="current"><span><a href="' . $baseUrl . '/externals/tinymce/themes/advanced/image.htm" onmousedown="return false;">{#advanced_dlg.image_title}</a></span></li>
			<li id="upload_tab"><span><a href="' . $baseUrl . '/externals/tinymce/themes/advanced/upload.htm" onmousedown="return false;">Upload</a></span></li>
		</ul>
	</div>

	<div class="panel_wrapper">
		<div id="general_panel" class="panel current">
     <table border="0" cellpadding="4" cellspacing="0">
          <tr>
            <td class="nowrap"><label for="src">{#advanced_dlg.image_src}</label></td>
            <td><table border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td><input id="src" name="src" type="text" class="mceFocus" value="' . $baseUrl . '/' . $file . '" style="width:200px" onchange="ImageDialog.getImageData();" /></td>
                  <td id="srcbrowsercontainer">&nbsp;</td>
                </tr>
              </table></td>
          </tr>
		  <tr>
			<td><label for="image_list">{#advanced_dlg.image_list}</label></td>
			<td><select id="image_list" name="image_list" onchange="document.getElementById(src).value=this.options[this.selectedIndex].value;document.getElementById(alt).value=this.options[this.selectedIndex].text;"></select></td>
		  </tr>
          <tr>
            <td class="nowrap"><label for="alt">{#advanced_dlg.image_alt}</label></td>
            <td><input id="alt" name="alt" type="text" style="width: 200px" /></td>
          </tr>
          <tr>
            <td class="nowrap"><label for="align">{#advanced_dlg.image_align}</label></td>
            <td><select id="align" name="align" onchange="ImageDialog.updateStyle();">
                <option value="">{#not_set}</option>
                <option value="baseline">{#advanced_dlg.image_align_baseline}</option>
                <option value="top">{#advanced_dlg.image_align_top}</option>
                <option value="middle">{#advanced_dlg.image_align_middle}</option>
                <option value="bottom">{#advanced_dlg.image_align_bottom}</option>
                <option value="text-top">{#advanced_dlg.image_align_texttop}</option>
                <option value="text-bottom">{#advanced_dlg.image_align_textbottom}</option>
                <option value="left">{#advanced_dlg.image_align_left}</option>
                <option value="right">{#advanced_dlg.image_align_right}</option>
              </select></td>
          </tr>
          <tr>
            <td class="nowrap"><label for="width">{#advanced_dlg.image_dimensions}</label></td>
            <td><input id="width" name="width" type="text" value="" size="3" maxlength="5" />
              x
              <input id="height" name="height" type="text" value="" size="3" maxlength="5" /></td>
          </tr>
          <tr>
            <td class="nowrap"><label for="border">{#advanced_dlg.image_border}</label></td>
            <td><input id="border" name="border" type="text" value="" size="3" maxlength="3" onchange="ImageDialog.updateStyle();" /></td>
          </tr>
          <tr>
            <td class="nowrap"><label for="vspace">{#advanced_dlg.image_vspace}</label></td>
            <td><input id="vspace" name="vspace" type="text" value="" size="3" maxlength="3" onchange="ImageDialog.updateStyle();" /></td>
          </tr>
          <tr>
            <td class="nowrap"><label for="hspace">{#advanced_dlg.image_hspace}</label></td>
            <td><input id="hspace" name="hspace" type="text" value="" size="3" maxlength="3" onchange="ImageDialog.updateStyle();" /></td>
          </tr>
        </table>
		</div>
	</div>

	<div class="mceActionPanel">
		<input type="submit" id="insert" name="insert" value="{#insert}" />
		<input type="button" id="cancel" name="cancel" value="{#cancel}" onclick="tinyMCEPopup.close();" />
	</div>
</form>
</body>
</html>';
    }
    
     public function gettrendingarticles($id, $module = 'advancedarticles', $sort = array(), $filter = array(), $type = 'category', $limit = 0) {
        $table = Engine_Api::_()->getDbtable('artarticles', $module);
        $TableName = $table->info('name');

        $searchTable = Engine_Api::_()->fields()->getTable('artarticle', 'search');
        $searchTableName = $searchTable->info('name');

        $select = $table->select()
                ->from($TableName)
                ->joinLeft($searchTableName, "`{$searchTableName}`.`item_id` = `{$TableName}`.`artarticle_id`", null);
                
                $select->where("{$TableName}.trending_article = ?", 1);

        if ($type != 'owner')
            $select->where("{$TableName}.search = ?", 1);

        if ($id)
            $select->where($TableName . "." . $type . "_id = ?", $id);

        // Add Owner
        if (isset($filter['owner']) && !empty($filter['owner'])) {
            $select->where("(`{$TableName}`.`owner_id` = ?)", $filter['owner']);
        }

        // Add Title
        if (isset($filter['title']) && !empty($filter['title'])) {
            $select->where("(`{$TableName}`.`title` LIKE ?)", "%{$filter['title']}%");
        }
        // Add Category
        if (isset($filter['id']) && !empty($filter['id'])) {
            $select->where("(`{$TableName}`.`category_id` = ?)", $filter['id']);
        }
        // Add Date
        if (isset($filter['start']) && !empty($filter['start'])) {
            $select->where("(`{$TableName}`.`created_date` >= ?)", date("Y-m-d", $filter['start']));
        }
        if (isset($filter['end']) && !empty($filter['end'])) {
            $select->where("(`{$TableName}`.`created_date` <= ?)", date("Y-m-d", $filter['end']));
        }
        // Add Tags
        if (isset($filter['tag']) && !empty($filter['tag'])) {
            $tagTable = Engine_Api::_()->getDbtable('TagMaps', 'core');
            $tagTableName = $tagTable->info('name');

            $select
                    ->joinLeft($tagTableName, "`{$tagTableName}`.`resource_id` = `{$TableName}`.`artarticle_id`", null)
                    ->where($tagTableName . '.tag_id = ?', $filter['tag'])
                    ->where($tagTableName . '.resource_type = ?', 'artarticle');
        }

        // Search Questions
        $questions = Engine_Api::_()->fields()->getSearchQuery('artarticle', $filter);
        foreach ($questions as $key => $value) {
            $select->where("`{$searchTableName}`.{$key}", $value);
        }

        if ($type != 'owner')
            $select
                    ->where("{$TableName}.status = ?", 'active');

        $select->group("{$TableName}.artarticle_id");

        $select->order('position asc');

        // Add Order
        if (isset($filter['order']) && !empty($filter['order'])) {
            $a = $filter['order'] == 'title' ? ' asc' : ' desc';
            $select->order($filter['order'] . $a);
        }

        if (!in_array('created_date', $sort) || !in_array('created_date', $filter)) {
            $select->order('created_date desc');
        }
		
		if ($limit) {
			$select->limit($limit);
		}

        return $select;
    }

}
