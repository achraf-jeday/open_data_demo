<?php
/**
 * @file
 * Theme and preprocess functions for breadcrumbs, messages, tabs..etc.
 */

/**
 * Implements hook_css_alter().
 */
function nuboot_radix_css_alter(&$css) {
  // Remove dkan button styles so we can use our own.
  unset($css[drupal_get_path('module', 'dkan_dataset') . '/css/dkan_dataset_btn.css']);
}

/**
 * Implements template_preprocess_page().
 */
function nuboot_radix_preprocess_page(&$variables) {
  // Logo file -- assumes default file is logo.svg.
  $logo = theme_get_setting('toggle_logo');
  $theme = variable_get('theme_default');
  $default = theme_get_setting('default_logo');
  $logo_fid = theme_get_setting('svg_logo');
  $logo_file = !empty($logo_fid) ? file_load($logo_fid) : FALSE;
  if ($logo) {
    if ($default) {
      $svg = drupal_get_path('theme', $theme ) . '/logo.svg';
      if (file_exists($svg)) {
        $variables['logo'] = '/' . drupal_get_path('theme', $theme ) . '/logo.svg';
      }
      else {
        $variables['logo'] = '/' . drupal_get_path('theme', $theme ) . '/logo.png'; 
      }
    }
    elseif($logo_file) {
      $logo_uri = $logo_file->uri;
      $variables['logo'] = file_create_url($logo_uri);
    }
    else {
      $variables['logo'] = file_create_url(theme_get_setting('logo_path'));
    }
  }
  // Add copyright to theme.
  if ($copyright = theme_get_setting('copyright')) {
    $variables['copyright'] = isset($copyright['value']) ? check_markup($copyright['value'], $copyright['format']) : t('Powered by <a href="http://nucivic.com/dkan">DKAN</a>, a project of <a href="http://nucivic.com">NuCivic</a>'); 
  }
  if (drupal_is_front_page()) {
    $variables['title'] = '';
    unset($variables['page']['content']['system_main']['default_message']);
  }
  // Remove title on dataset edit and creation pages.
  if (!empty($variables['node']) && in_array($variables['node']->type, array('dataset', 'resource'))) {
    $variables['title'] = '';
  }
  // Add external css files.
  $external_css = array(
    '#attached' => array(
      'css' => array(
        '//fonts.googleapis.com/css?family=Open+Sans::400,300,700' => array(
          'type' => 'external'),
      ),
    ),
  );
  drupal_render($external_css);
}
