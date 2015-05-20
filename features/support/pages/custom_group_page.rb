class CustomGroupPage
  include PageObject
  extend UrlFactory

  page_url(customgrouppage)

  link(:content_page, :href => "/groups/#{TestConfig.custom_group}/content")
  link(:follow, :id => 'jive-link-socialgroup-startFollowing')
  link(:following, :id => 'jive-link-socialgroup-following')

end
