<div class="container">
		<div class="floatcont">
			<span class="ynresponsive_copyright">
			Copyright &copy; <?php echo $this->translate('%s Rentstarz', date('Y')) ?>
			</span>
			<span class="ynresponsive_menus">
			<?php foreach( $this->navigation as $item ):
				$attribs = array_diff_key(array_filter($item->toArray()), array_flip(array(
					'reset_params', 'route', 'module', 'controller', 'action', 'type',
					'visible', 'label', 'href'
				)));
				?>
				<?php echo $this->htmlLink($item->getHref(), $this->translate($item->getLabel()), $attribs) ?>
			<?php endforeach; ?>
			</span>
		</div>
		<span class="ynresponsive_languges">
		<?php if( 1 !== count($this->languageNameList) ): ?>
				<form method="post" action="<?php echo $this->url(array('controller' => 'utility', 'action' => 'locale'), 'default', true) ?>" style="display:inline-block">
					<?php $selectedLanguage = $this->translate()->getLocale() ?>
					<?php echo $this->formSelect('language', $selectedLanguage, array('onchange' => '$(this).getParent(\'form\').submit();'), $this->languageNameList) ?>
					<?php echo $this->formHidden('return', $this->url()) ?>
				</form>
		<?php endif; ?>
		</span>
		<?php if( !empty($this->affiliateCode) ): ?>
			<div class="affiliate_banner">
				<?php
					echo $this->translate('Powered by %1$s',
						$this->htmlLink('http://www.socialengine.com/?source=v4&aff=' . urlencode($this->affiliateCode),
						$this->translate('SocialEngine Community Software'),
						array('target' => '_blank')))
				?>
			</div>
		<?php endif; ?>
		<div class="wrap-scroll">
				<button class="scrollTop"></button>
		</div>
</div>

<script>
	(function( $ ) {
		$(function() {
			$(".scrollTop").click(function(){
				var body = $("html, body");
				body.animate({scrollTop:0}, '500', 'swing');
			});
		});
	})(jQuery);
</script>
