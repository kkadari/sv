require_relative '../modules/nav_ribbon'

require_relative '../modules/create_modal'
require_relative '../modules/search_box'
require_relative '../modules/title_creator'
require_relative '../modules/group_request'

class HomePage
  include PageObject
  include NavRibbon

  include CreateModal
  include SearchBox
  include TitleCreator
  include GroupRequest
  include DataMagic
  extend UrlFactory

  page_url(homepage)
  
  link(:connections_stream, :text => 'Connections Stream')

  def navigate_to_ir_named(subject)
    wait_until do
      @browser.form(:class,'status-morecontent-form').exists?
    end
    @browser.link(:text, subject).click
  end

  def navigate_to_content_named(subject)
    search = subject[6..50]
    @browser.link(:text, /#{search}/).click
  end

  def navigate_to_blog_post_named(subject)
    search = subject[0..20]
    click_content
    wait_until do
      @browser.html.include? search
    end
    @browser.link(:text, /#{search}/).click
  end

  def navigate_to_discussion_named(subject)
    search = subject[6..50]
    click_content
    click_discussions
    wait_until do
      @browser.html.include? search
    end
    @browser.link(:text, /#{search}/).click
  end

  def create(type)
    click_create
    click_to_create_type(type)
  end

  def open_preferences
    @browser.link(:id => 'j-satNav').when_present.click
    @browser.link(:href => '/user-preferences!input.jspa').when_present.click
  end

end
