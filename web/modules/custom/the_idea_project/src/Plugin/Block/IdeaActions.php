<?php

namespace Drupal\the_idea_project\Plugin\Block;

use Drupal\Core\Block\BlockBase;
use Drupal\Core\Cache\Cache;

/**
 * Provides a block with a simple text.
 *
 * @Block(
 *   id = "the_idea_project_idea_actions",
 *   admin_label = @Translation("Idea Actions"),
 * )
 */
class IdeaActions extends BlockBase {

  /**
   * {@inheritdoc}
   */
  public function build() {
    $node = \Drupal::routeMatch()->getParameter('node');
    if ($node === null) {
      return [];
    }
    return [
      '#markup' => '<div>
<div class="field--label">I\'m interested</div>
<div>
    <a href="/node/add/project?idea=' . $node->id() . '" class="btn btn-primary" role="button" aria-disabled="true">Create new project</a>
</div>
</div>',
    ];
  }

  /**
   * {@inheritdoc}
   */
  public function getCacheTags() {
    if ($node = \Drupal::routeMatch()->getParameter('node')) {
      return Cache::mergeTags(parent::getCacheTags(), array('node:' . $node->id()));
    } else {
      return parent::getCacheTags();
    }
  }

  /**
   * {@inheritdoc}
   */
  public function getCacheContexts() {
    return Cache::mergeContexts(parent::getCacheContexts(), array('route'));
  }

}
