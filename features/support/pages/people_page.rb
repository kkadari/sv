class PeoplePage
  include PageObject
  extend UrlFactory

  page_url(peoplepage)

  link(:user1_profile, :title => TestConfig.user1_uname)
  link(:user1_profile_link, :href => "/people/" + TestConfig.user1_id)

  text_area(:search, :name => 'query')

end
