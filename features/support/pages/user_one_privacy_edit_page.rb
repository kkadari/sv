class UserOnePrivacyEditPage
  include PageObject
  extend UrlFactory

  page_url(useroneprivacyeditpage)

  select(:security_level,:name => 'nameSecurityLevelID')
  button(:save, :name => 'save')

end
