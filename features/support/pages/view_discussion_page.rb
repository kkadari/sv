require_relative '../modules/nav_ribbon'
require_relative '../modules/user_modal'
require_relative '../modules/mention_module'

class ViewDiscussionPage
  include PageObject
  include NavRibbon
  include UserModal
  include DataMagic
  include MentionModule
  extend UrlFactory

  page_url(viewdiscussionpage)
  
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
  end

  def comment_anonymously_on_discussion(data={})
    @browser.link(:title => "Reply to this message").when_present.click
    @browser.link(:id => "wysiwygtext1_html").when_present.click
    populate_page_with data_for(:ViewDiscussionPage, data)
    #TODO: Find a better way of clicking the Anonymous checkbox. ~TD
    #@browser.checkbox(:id => 'notAttributable').set

    @browser.send_keys :tab

    @browser.send_keys :space

    @browser.element(:xpath => '//*[@id="postform"]/div[5]/input[1]').when_present.click

  end

  def comment_on_comment(data={})
    @browser.link(:title => "Reply to this message", :index => 1).when_present.click
    @browser.link(:id => "wysiwygtext1_html").when_present.click
    populate_page_with data_for(:ViewDiscussionPage, data)
    @browser.element(:xpath => '//*[@id="postform"]/div[5]/input[1]').when_present.click
  end

  def comment_anonymously_on_comment(data={})
    @browser.link(:title => "Reply to this message", :index => 1).when_present.click
    @browser.link(:id => "wysiwygtext1_html").when_present.click
    populate_page_with data_for(:ViewDiscussionPage, data)
    #TODO: Find a better way of clicking the Anonymous checkbox. ~TD
    #@browser.checkbox(:id => 'notAttributable').set
    @browser.send_keys :tab

    @browser.send_keys :space

    @browser.element(:xpath => '//*[@id="postform"]/div[5]/input[1]').when_present.click
  end






end
