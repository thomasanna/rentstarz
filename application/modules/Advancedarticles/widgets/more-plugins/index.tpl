<br /><p>
<?php echo $this->translate("Below information about plugins from SpurIT") ?> 
</p>
<br />
<div class="admin_home_news"> 
<?php if( !empty($this->installed_plugin) ): ?>
  <h3 class="sep">
    <span><?php echo $this->translate("Installed Plugins") ?></span>
  </h3>
    <ul>
      <?php foreach( $this->installed_plugin as $item ): ?>
        <li>
          <div class="admin_home_news_date" style="width:150px;">
			<div style="font-weight:bold; text-align:center; width:150px; font-size:14px;"><?php echo $item['price'] == '0' ?  $this->translate("Free") : $item['price']; ?></div>
			<div style="text-align:center; width:150px;"><span style="font-size:11px;"><?php echo $this->translate("your version:")?></span> <span style="font-weight:bold"><?php echo $item['version']; ?></span></div>
			<div style="text-align:center; width:150px;"><span style="font-size:11px;"><?php echo $this->translate("last version:")?></span> <span style="font-weight:bold"><?php echo empty($item['last_version']) ? $this->translate("N/A") : $item['last_version']; ?></span></div>
			<div style="font-weight:bold; text-align:center; width:150px;"><?php echo $item['action']; ?></div>
          </div>
          <div class="admin_home_news_info">
            <a href="<?php echo $item['link'] ?>" target="_blank">
              <?php echo $item['title'] ?>
            </a>
            <span class="admin_home_news_blurb">
              <?php echo $this->string()->truncate($this->string()->stripTags($item['description']), 350) ?>
			  &#187; <a href="<?php echo $item['link'] ?>" target="_blank"><?php echo $this->translate("More...") ?></a>
            </span>
          </div>
        </li>
      <?php endforeach; ?>
    </ul>
<?php endif; ?>
<br/ ><br />
<?php if( !empty($this->not_installed_plugin) ): ?>
  <h3 class="sep">
    <span><?php echo $this->translate("Not Installed Paid Plugins") ?></span>
  </h3>
    <ul>
      <?php foreach( $this->not_installed_plugin as $item ): ?>
        <li>
          <div class="admin_home_news_date" style="width:150px;">
			<div style="font-weight:bold; text-align:center; width:150px; font-size:14px;"><?php echo $item['price'] == '0' ?  $this->translate("Free") : $item['price']; ?></div>
			<div style="text-align:center; width:150px;"><span style="font-size:11px;"><?php echo $this->translate("last version:")?></span> <span style="font-weight:bold"><?php echo empty($item['version']) ? $this->translate("N/A") : $item['version']; ?></span></div>
			<div style="font-weight:bold; text-align:center; width:150px;"><?php echo $item['status']; ?></div>
          </div>
          <div class="admin_home_news_info">
            <a href="<?php echo $item['link'] ?>" target="_blank">
              <?php echo $item['title'] ?>
            </a>
            <span class="admin_home_news_blurb">
              <?php echo $this->string()->truncate($this->string()->stripTags($item['description']), 350) ?>
			  &#187; <a href="<?php echo $item['link'] ?>"><?php echo $this->translate("More...") ?></a>
            </span>
          </div>
        </li>
      <?php endforeach; ?>
    </ul>  
<?php endif; ?>  
<br/ ><br />
<?php if( !empty($this->not_installed_plugin_free) ): ?>
  <h3 class="sep">
    <span><?php echo $this->translate("Not Installed Free Plugins") ?></span>
  </h3>  
    <ul>
      <?php foreach( $this->not_installed_plugin_free as $item ): ?>
        <li>
          <div class="admin_home_news_date" style="width:150px;">
			<div style="font-weight:bold; text-align:center; width:150px; font-size:14px;"><?php echo $item['price'] == '0' ?  $this->translate("Free") : $item['price']; ?></div>
			<div style="text-align:center; width:150px;"><span style="font-size:11px;"><?php echo $this->translate("last version:")?></span> <span style="font-weight:bold"><?php echo empty($item['version']) ? $this->translate("N/A") : $item['version']; ?></span></div>
			<div style="font-weight:bold; text-align:center; width:150px;"><?php echo $item['status']; ?></div>
          </div>
          <div class="admin_home_news_info">
            <a href="<?php echo $item['link'] ?>" target="_blank">
              <?php echo $item['title'] ?>
            </a>
            <span class="admin_home_news_blurb">
              <?php echo $this->string()->truncate($this->string()->stripTags($item['description']), 350) ?>
			  &#187; <a href="<?php echo $item['link'] ?>"><?php echo $this->translate("More...") ?></a>
            </span>
          </div>
        </li>
      <?php endforeach; ?>
    </ul>   
<?php endif; ?>  
</div>