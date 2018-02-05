<div class='notifications_layout'>   
<div >
    <h3 class="sep">
      <?php $itemCount = 0;
      if($this->requests)
      	$itemCount = $this->requests->getTotalItemCount(); ?>
      <span><?php echo $this->translate(array("Friend Request (%d)","Friend Requests (%d)", $itemCount), $itemCount) ?></span>
    </h3>
    <ul class='requests'>
      <?php if( $itemCount > 0 ): ?>
        <?php foreach( $this->requests as $notification ): ?>
        <?php
          try {
            $parts = explode('.', $notification->getTypeInfo()->handler);
            echo $this->action($parts[2], $parts[1], $parts[0], array('notification' => $notification));
          } catch( Exception $e ) {
            if( APPLICATION_ENV === 'development' ) {
              echo $e->__toString();
            }
            continue;
          }
        ?>
        <?php endforeach; ?>
       <?php echo $this->paginationControl($this->requests); ?>
      <?php else: ?>
        <li>
          <?php echo $this->translate("You have no requests.") ?>
        </li>
      <?php endif; ?>
    </ul>
  </div>
  </div>