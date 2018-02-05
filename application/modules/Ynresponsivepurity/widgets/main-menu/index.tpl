<?php $viewer = $this->viewer();?>

<?php $current_url = explode("?", $_SERVER['REQUEST_URI']);
       $page_url=$this->view->page_url=$page_url = $current_url[0] ; 

    

?>


<nav class="navbar navbar-default" role="navigation">
  <!-- Brand and toggle get grouped for better mobile display -->
  <div class="navbar-header">
    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex8-collapse">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
    </button>
	<?php
		$site_name = Engine_Api::_()->getApi('settings', 'core')->getSetting('core_general_site_title', $this->translate('_SITE_TITLE'));
		$route = $this->viewer()->getIdentity()? array('route'=>'user_general', 'action'=>'home'): array('route'=>'default');
		echo $this->htmlLink($route, $site_name, array('class' => 'navbar-brand'));
	?>
  </div>

  <!-- Collect the nav links, forms, and other content for toggling -->
  <div class="collapse navbar-collapse navbar-ex8-collapse">
    <ul class="nav navbar-nav">
		<?php if (!$viewer->getIdentity()): ?>
			<?php if($this->search_check):?>
				<li class="global_search_form_nologin">
					<form action="<?php echo $this->url(array('controller' => 'search'), 'default', true) ?>" method="get">
						<input type='text' class='text suggested' name='query' size='20' maxlength='100' placeholder="<?php echo $this->translate('Enter keyword to search') ?>" />
					</form>
				</li>
			<?php endif;?>
		<?php endif;?>
		<?php $count = 0;
		$limit = $this -> limit;
		foreach( $this->navigationMain as $item ): ?>
			<?php
			$check_active = $item->active;
			$request = Zend_Controller_Front::getInstance()->getRequest();
			$module = $request->getModuleName();
			$module_class = explode("_", $item->class);
            if(end($module_class) == $module && $module != 'user' && $module != 'core')
			{
				$check_active = true;
			}
			if($count < $limit):
				 $attribs = array_diff_key(array_filter($item->toArray()), array_flip(array(
			        'reset_params', 'route', 'module', 'controller', 'action', 'type',
			        'visible', 'label', 'href'
			        )));
				?>
		     <li<?php echo($check_active?' class="active"':'')?>>
          		<?php echo $this->htmlLink($item->getHref(), $this->translate($item->getLabel()), $attribs) ?>
        	</li>
    <?php else:?>
    	 <?php if($count == $limit):?>
    	 		<li class="dropdown">
	        		<a href="#" class="dropdown-toggle" id="purity-dopdown-position" data-toggle="dropdown"><?php echo $this -> translate("More");?>
	        			<span class="glyphicon glyphicon-chevron-down btn-xs"></span>
	        		</a>
        			<ul class="dropdown-menu">
    	 	<?php endif;?>
    	 	<?php $attribs = array_diff_key(array_filter($item->toArray()), array_flip(array(
				        'reset_params', 'route', 'module', 'controller', 'action', 'type',
				        'visible', 'label', 'href'
				        )));
					?>
			     <li<?php echo($check_active?' class="active"':'')?>>
	          		<?php echo $this->htmlLink($item->getHref(), $this->translate($item->getLabel()), $attribs) ?>
	        	</li>
    	 	<?php if($count > $limit && $count == count($this->navigationMain)):?>
    	 	</ul>
    	 </li>
    	 	<?php endif;?>
		<?php endif;
		$count ++;
		endforeach;?>
    </ul>
  </div><!-- /.navbar-collapse -->
</nav>


<script type="text/javascript">
	/*window.addEvent('domready', function() {
	    var pos = $('purity-dopdown-position').getPosition();
	    var x_pos = pos.x;

	    if(x_pos < 200){
	    	$('purity-dopdown-position').getParent('.dropdown').addClass('purity-dopdown-position');
	    }
	});*/
	

var current_url = '<?php echo $page_url;?>';
 if(current_url == '/tenants'){
	 jQuery( ".layout_ynresponsivepurity_main_menu .navbar-default ul li:nth-child(3)" ).addClass( "active" );
 }
 if(current_url == '/landlords'){
	 jQuery( ".layout_ynresponsivepurity_main_menu .navbar-default ul li:nth-child(2)" ).addClass( "active" );
 }
 if(current_url == '/services'){
	 jQuery( ".layout_ynresponsivepurity_main_menu .navbar-default ul li:nth-child(4)" ).addClass( "active" );
 }
  

</script>
