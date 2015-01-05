require_relative '../modules/nav_ribbon'
require_relative '../modules/user_modal'
require_relative '../modules/mention_module'

class ViewDiscussionPage
  include PageObject
  include FigNewton
  include NavRibbon
  include UserModal
  include DataMagic
  include MentionModule

  page_url(/#{FigNewton.base_url}thread\/\d+/)
  link(:reply, :title => "Reply to this message")
  link(:edit, :id => "wysiwygtext1_html")
  text_area(:comment_content, :class => 'usertext')
  button(:submit, :class => "jive-form-button-save j-btn-callout")
  checkbox(:anon, :id => "notAttributable")

  def add_discussion_comment(data={})
    @browser.link(:title => "Reply to this message").when_present.click
    @browser.link(:id => "wysiwygtext1_html").when_present.click
    populate_page_with data_for(:ViewDiscussionPage, data)
    @browser.element(:xpath => '//*[@id="postform"]/div[5]/input[1]').when_present.click
    sleep 3
  end

  def comment_anonymously_on_discussion(data={})
    @browser.link(:title => "Reply to this message").when_present.click
    @browser.link(:id => "wysiwygtext1_html").when_present.click
    populate_page_with data_for(:ViewDiscussionPage, data)
    #TODO: Find a better way of clicking the Anonymous checkbox. ~TD
    #@browser.checkbox(:id => 'notAttributable').set
    sleep 1
    @browser.send_keys :tab
    sleep 1
    @browser.send_keys :space
    sleep 1
    @browser.element(:xpath => '//*[@id="postform"]/div[5]/input[1]').when_present.click
    sleep 3
  end

  def comment_on_comment(data={})
    sleep 2
    @browser.link(:title => "Reply to this message", :index => 1).when_present.click
    @browser.link(:id => "wysiwygtext1_html").when_present.click
    populate_page_with data_for(:ViewDiscussionPage, data)
    @browser.element(:xpath => '//*[@id="postform"]/div[5]/input[1]').when_present.click
    sleep 3
  end

  def comment_anonymously_on_comment(data={})
    sleep 2
    @browser.link(:title => "Reply to this message", :index => 1).when_present.click
    @browser.link(:id => "wysiwygtext1_html").when_present.click
    populate_page_with data_for(:ViewDiscussionPage, data)
    #TODO: Find a better way of clicking the Anonymous checkbox. ~TD
    #@browser.checkbox(:id => 'notAttributable').set
    sleep 1
    @browser.send_keys :tab
    sleep 1
    @browser.send_keys :space
    sleep 1
    @browser.element(:xpath => '//*[@id="postform"]/div[5]/input[1]').when_present.click
    sleep 3
  end

  def verify_content_exists(title)
    wait_until { @browser.html.to_s.include? title[15] }
    #Ratings widget causes delay in logout link being accessible. Wait for it to fully load. ~TD
    @browser.div(:class => 'jive-content-avgrating-score').wait_until_present
  end
end