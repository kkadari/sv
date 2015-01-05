require_relative '../modules/nav_ribbon'
require_relative '../modules/user_modal'
require_relative '../modules/mention_module'

class ViewIncidentReportPage
  include PageObject
  include FigNewton
  include NavRibbon
  include UserModal
  include DataMagic
  include MentionModule

  page_url(/#{FigNewton.base_url}view\-incidentreport\.jspa\?incidentReportID\=\d+/)
  link(:comment, :text => 'Add a comment')
  link(:edit, :id => 'wysiwyg_id_0_html')
  text_area(:comment_content, :class => 'usertext')
  button(:submit, :name => 'post')
  checkbox(:anon, :id => 'attributed-check')

  def add_comment(data={})
    @browser.link(:text => 'Add a comment').when_present.click
    @browser.link(:id => 'wysiwyg_id_0_html').when_present.click
    populate_page_with data_for(:ViewIncidentReportPage, data)
    @browser.button(:name => 'post').when_present.click
  end

  def add_comment_anonymously(data={})
    @browser.link(:text => 'Add a comment').when_present.click
    @browser.link(:id => 'wysiwyg_id_0_html').when_present.click
    populate_page_with data_for(:ViewIncidentReportPage, data)
    sleep 1
    @browser.send_keys :tab
    sleep 1
    @browser.send_keys :space
    sleep 1
    @browser.button(:name => 'post').when_present.click
  end
  
  def add_review(data={})
    @browser.div(:class => 'jive-content-avgrating').wait_until_present
    @browser.div(:class => 'jive-content-userrating-score').when_present.click
    @browser.link(:class => 'jive-icon-userrating-3 jive-icon-med jive-icon-rate-usr-on').when_present.click
    @browser.link(:text => 'Write a review').when_present.click
    @browser.link(:id => 'wysiwyg_id_0_html').when_present.click
    populate_page_with data_for(:ViewIncidentReportPage, data)
    @browser.button(:name => 'post').when_present.click
  end

  def add_review_anonymously(data={})
    @browser.div(:class => 'jive-content-avgrating').wait_until_present
    @browser.div(:class => 'jive-content-userrating-score').when_present.click
    @browser.link(:class => 'jive-icon-userrating-3 jive-icon-med jive-icon-rate-usr-on').when_present.click
    @browser.link(:text => 'Write a review').when_present.click
    @browser.link(:id => 'wysiwyg_id_0_html').when_present.click
    populate_page_with data_for(:ViewIncidentReportPage, data)
    sleep 1
    @browser.send_keys :tab
    sleep 1
    @browser.send_keys :space
    sleep 1
    @browser.button(:name => 'post').when_present.click
  end
  
  def add_comment_mentioning_tim
    @browser.link(:text => 'Add a comment').when_present.click
    @browser.link(:id => 'wysiwyg_id_0_html').when_present.click
    mention_tim
    @browser.button(:name => 'post').when_present.click
  end
  
  def add_comment_mentioning_matt
    @browser.link(:text => 'Add a comment').when_present.click
    @browser.link(:id => 'wysiwyg_id_0_html').when_present.click
    mention_matt
    @browser.button(:name => 'post').when_present.click
  end
  
  def add_anon_comment_mentioning_tim
    @browser.link(:text => 'Add a comment').when_present.click
    @browser.link(:id => 'wysiwyg_id_0_html').when_present.click
    mention_tim
    sleep 1
    @browser.send_keys :tab
    sleep 1
    @browser.send_keys :space
    sleep 1
    @browser.button(:name => 'post').when_present.click
  end
  
  def add_anon_comment_mentioning_matt
    @browser.link(:text => 'Add a comment').when_present.click
    @browser.link(:id => 'wysiwyg_id_0_html').when_present.click
    mention_matt
    sleep 1
    @browser.send_keys :tab
    sleep 1
    @browser.send_keys :space
    sleep 1
    @browser.button(:name => 'post').when_present.click
  end
end
