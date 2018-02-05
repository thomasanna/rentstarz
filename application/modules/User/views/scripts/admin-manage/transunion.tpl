<?php
/**
 * SocialEngine
 *
 * @category   Application_Core
 * @package    User
 * @copyright  Copyright 2006-2010 Webligo Developments
 * @license    http://www.socialengine.com/license/
 * @version    $Id: edit.tpl 9747 2012-07-26 02:08:08Z john $
 * @author     Sami
 */
?>
<h3>Manage Transunion</h3>

  <div class='tabs'>
    <div class="tabs">
    <ul class="navigation">
    <li class="active">
        <a class="" href="/admin/user/manage/transunion">Manage Transunion</a>
    </li>
    <li>
        <a class="" href="/admin/user/manage/holdingproperty">Manage Holding Property</a>
    </li>
    <li >
        <a class="" href="/admin/user/manage/smartmoveapiquestions">Manage Smartmove Api Questions</a>
    </li>
     
</ul>  </div>
  </div>
<div class='settings'>
  <?php echo $this->form->render($this) ?>
</div>
