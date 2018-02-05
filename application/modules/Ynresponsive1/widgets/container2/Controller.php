<?php

class Ynresponsive1_Widget_Container2Controller extends Engine_Content_Widget_Abstract
{
  public function indexAction()
  {
    // Set up element
    $element = $this -> getElement();

    $element -> clearDecorators()
    -> addDecorator('Container');

    // Iterate over children
    $widgets = array();
    $childrenContent = '';

    $max_child = 2;

    foreach ($element->getElements() as $child)
    {
      // Set specific class name
      $child_class = $child -> getDecorator('Container') -> getParam('class');
      $child -> getDecorator('Container') -> setParam('class', $child_class . ' tab_' . $child -> getIdentity());

      // Remove title decorator

      // Render to check if it actually renders or not
      $childrenContent .= $child -> render() . PHP_EOL;

      // Get title and childcount
      $title = $child -> getTitle();

      $content = $child -> render();

      // If it does render, add it to the tab list
      if (!$child -> getNoRender())
      {
        $widgets[] = array(
          'id' => $child -> getIdentity(),
          'name' => $child -> getName(),
          'containerClass' => $child -> getDecorator('Container') -> getClass(),
          'title' => $title,
          'content' => $content,
        );
      }

      // generate for max overall top 2.
      if (count($widgets) == $max_child)
      {
        break;
      }
    }

    if (count($widgets) < $max_child)
    {
      return $this -> setNoRender();
    }

    $this -> view -> widgets = $widgets;

    $container_split = $this -> _getParam('container_split','2.2');
    
    list($col1, $col2) = explode('.', $container_split);

    $col1 = intval($col1);
    $col2 = intval($col2);

    $this -> view -> cols_class = array(
      'col-md-' . ($col1 * 12 / ($col1 + $col2)),
      'col-md-' . ($col2 * 12 / ($col1 + $col2))
    );
  }

}
