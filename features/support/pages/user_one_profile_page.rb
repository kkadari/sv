class UserOneProfilePage
  include PageObject
  extend UrlFactory

  page_url(useroneprofilepage)
  link(:activity, :text => 'Activity')
  link(:content, :xpath => '//*[@id="jive-content-tab"]/a')
  link(:thumbnail_view, :xpath => '//*[@id="j-item-view-toggle"]/li[1]/a')
  text_field(:filter_by, :name => 'query')

end
