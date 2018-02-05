
<h2>
  <?php echo $this->translate("Manage Documents") ?>
  <?php $viewer     = Engine_Api::_()->user()->getViewer(); ?>
</h2>
  <div class='tabs'>
    <div class="tabs">
    <ul class="navigation">
    <li >
        <a class="" href="/admin/user/manage/documents">Documents</a>
    </li>
    <li class="active">
        <a class="" href="/admin/user/manage/specialdocuments">Special Documents</a>
    </li>
    <li >
        <a class="" href="/admin/user/manage/addspecialdocuments">Add New Special Documents</a>
    </li>
</ul>  </div>
  </div>
