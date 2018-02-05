<div class="block_event layout_ynresponsivepurity_blkcont">
<ul class="clearfix ynresponsivepurity_eventgrid">
	<?php foreach($this -> events as $item):?>
		<li>
			<?php
				$thumb_profile = $item -> getPhotoUrl();
				if(!$thumb_profile)
					$thumb_profile = $this -> layout() -> staticBaseUrl.'application/modules/Ynresponsivepurity/externals/images/no_thumb.png';
			?>
			<div class="event_thumbnail">
				<a class="thumbimg" href="<?php echo $item -> getHref()?>">
					<span style="background-image:url('<?php echo $thumb_profile?>')"></span>
				</a>
				<?php
				$start_time = strtotime($item -> starttime);
				$oldTz = date_default_timezone_get();
				if($this->viewer() && $this->viewer()->getIdentity())
				{
					date_default_timezone_set($this -> viewer() -> timezone);
				}
				else
				{
					date_default_timezone_set( $this->locale() -> getTimezone());
				}?>
				 <div class="time">
					<?php echo date("h:i", $start_time); ?>
					<span><?php echo date("A", $start_time);?></span>
				</div>
				<div class="date">
					<?php echo date("d", $start_time); ?>
					<span><?php echo date("F", $start_time);?></span>
				</div>
				<?php date_default_timezone_set($oldTz);?>
				<div class="event_desc">
					<?php echo $this->string()->truncate(strip_tags($item->description), 100); ?>
				</div>
			</div>
			<div class="event_moreinfo">
				<?php echo $this->htmlLink($item->getHref(), $this -> translate($item->getTitle())) ?>
				<?php if($item -> location):?>
					<span class="location">
						<?php echo $item -> location; ?>
					</span>
				<?php endif;?>
			</div>
		</li>
	<?php endforeach;?>
</ul>
</div>
