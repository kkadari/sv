class UserOneProfilePage
  include PageObject
  extend UrlFactory

  page_url(useroneprofilepage)
  link(:activity, :text => 'Activity')
  link(:content, :css => '.j-tabbar > li:nth-child(3) a')
  link(:thumbnail_view, :xpath => '//*[@id="j-item-view-toggle"]/li[1]/a')
  div(:organisation, :class => 'j-connections-orgchart')
  div(:skills, :class => 'j-expertise')
  div(:profile, :class => 'j-extended-profile')
  text_field(:filter_by, :name => 'query')

end
