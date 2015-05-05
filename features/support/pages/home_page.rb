require_relative '../modules/nav_ribbon'
require_relative '../modules/user_modal'
require_relative '../modules/create_modal'
require_relative '../modules/search_box'
require_relative '../modules/title_creator'
require_relative '../modules/group_request'

class HomePage
  include PageObject
  include FigNewton
  include NavRibbon
  include UserModal
  include CreateModal
  include SearchBox
  include TitleCreator
  include GroupRequest
  include DataMagic

  page_url("#{FigNewton.base_url}/activity")
  
  link(:connections_stream, :text => 'Connections Stream')

  def confirm_ir_present_with(subject)
    sleep 2
    fail "Incident not visible or created" unless @browser.html.to_s.include? subject
  end

  def navigate_to_ir_named(subject)
    wait_until do
      @browser.form(:class,"status-morecontent-form").exists?
    end
    @browser.link(:text, subject).click
    sleep 2
  end

  def navigate_to_content_named(subject)
    search = subject[6..50]
    sleep 3
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

  def navigate_to_connections_stream
    connections_stream
  end
end
