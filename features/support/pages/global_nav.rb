class GlobalNav
  include PageObject

  link(:people, :text => 'people')
  link(:home, :text => 'Home')
  link(:content, :text => 'Content')
  link(:open_create, :id => 'navCreate')
  link(:request_group, :css => '#create-list-2 > li > a')
  div(:create_menu, :id => 'menuCreate')
  link(:create_discussion, :css => '#create-list-0 li:nth-child(1) a')
  link(:create_blog, :css => '#create-list-0 li:nth-child(2) a')
  link(:create_poll, :css => '#create-list-0 li:nth-child(3) a')
  link(:create_incident_report, :css => '#create-list-0 li:nth-child(5) a')
  link(:create_space, :class => 'js-createmenu-containerchooser')
  link(:create_group, :css => 'a[href*="edit-place"]')

end