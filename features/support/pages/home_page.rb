require_relative '../modules/create_modal'
require_relative '../modules/search_box'
require_relative '../modules/title_creator'
require_relative '../modules/group_request'

class HomePage
  include PageObject
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
    wait_until do
      @browser.html.include? search
    end
    @browser.link(:text, /#{search}/).click
  end

  def navigate_to_discussion_named(subject)
    search = subject[6..50]
    click_discussions
    wait_until do
      @browser.html.include? search
    end
    @browser.link(:text, /#{search}/).click
  end

  def create(type)
    @browser.link(:id => 'navCreate').when_present.click
    @browser.div(:id => 'menuCreate').wait_until_present
    click_to_create_type(type)
  end

  def open_preferences
    @browser.link(:id => 'j-satNav').when_present.click
    @browser.link(:href => '/user-preferences!input.jspa').when_present.click
  end

  def verify_cannot_create(type)
    @browser.link(:id => 'navCreate').when_present.click
    @browser.div(:id => 'menuCreate').wait_until_present
    case type
      when 'group'
        fail 'User should not have option to create group.' if @browser.link(:text => 'Group').present?
      when 'space'
        fail 'User should not have option to create space.' if @browser.link(:text => 'Space').present?
      else
        fail 'Supplied link type not defined.'
    end
  end

end
