class CustomGroupPage
  include PageObject
  extend UrlFactory

  page_url(customgrouppage)

  link(:content_page, :href => "/groups/#{TestConfig.custom_group}/content")

  def follow_in_connections_stream
    follow = @browser.link(:id => 'jive-link-socialgroup-startFollowing')
    following = @browser.link(:id => 'jive-link-socialgroup-following')

    follow.click unless following.present?
  end

end
