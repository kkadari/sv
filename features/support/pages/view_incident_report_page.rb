require_relative '../modules/nav_ribbon'
require_relative '../modules/user_modal'
require_relative '../modules/mention_module'

class ViewIncidentReportPage
  include PageObject
  include NavRibbon
  include UserModal
  include DataMagic
  include MentionModule
  extend UrlFactory

  page_url(viewincidentreportpage)
  
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

    # Hack for phantomjs to ensure that the checkbox is checked as populate_page doesn't appear to work
    anonCheck = @browser.checkbox(:id,'attributed-check')
    anonCheck.click if !anonCheck.set?

    @browser.button(:name => 'post').when_present.click
  end

  def add_review(data={})
    @browser.div(:class => 'jive-content-avgrating').wait_until_present
    @browser.link(:css => 'div[class="jive-content-userrating-score"] a:nth-child(3)').when_present.click
    @browser.link(:class => 'jive-icon-userrating-3 jive-icon-med jive-icon-rate-usr-on').when_present.click
    @browser.link(:text => 'Write a review').when_present.click
    @browser.link(:id => 'wysiwyg_id_0_html').when_present.click
    populate_page_with data_for(:ViewIncidentReportPage, data)
    @browser.button(:name => 'post').when_present.click
  end

  def add_review_anonymously(data={})
    @browser.div(:class => 'jive-content-avgrating').wait_until_present
    @browser.link(:css => 'div[class="jive-content-userrating-score"] a:nth-child(3)').when_present.click
    @browser.link(:class => 'jive-icon-userrating-3 jive-icon-med jive-icon-rate-usr-on').when_present.click
    @browser.link(:text => 'Write a review').when_present.click
    @browser.link(:id => 'wysiwyg_id_0_html').when_present.click
    populate_page_with data_for(:ViewIncidentReportPage, data)
    @browser.send_keys :tab
    @browser.send_keys :space
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
    @browser.send_keys :tab
    @browser.send_keys :space
    @browser.button(:name => 'post').when_present.click
  end

  def add_anon_comment_mentioning_simonwi
    @browser.link(:text => 'Add a comment').when_present.click
    @browser.link(:id => 'wysiwyg_id_0_html').when_present.click
    mention_simonwi
    @browser.send_keys :tab
    @browser.send_keys :space
    @browser.button(:name => 'post').when_present.click
  end
end
