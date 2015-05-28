class PeoplePage
  include PageObject
  extend UrlFactory

  page_url(peoplepage)

  link(:user1_profile_link, :title => 'View Your Profile')

  text_area(:search, :name => 'query')

end
