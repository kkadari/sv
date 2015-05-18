require_relative '../modules/nav_ribbon'

class ViewIncidentReportPage
  include PageObject
  include NavRibbon
  include DataMagic
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
    @browser.link(:text => 'Write a review').when_present.click
    @browser.link(:css => 'a[title="Toggle HTML mode"]').when_present.click
    populate_page_with data_for(:ViewIncidentReportPage, data)
    @browser.button(:name => 'post').when_present.click
  end

  def add_review_anonymously(data={})
    @browser.div(:class => 'jive-content-avgrating').wait_until_present
    @browser.link(:css => 'div[class="jive-content-userrating-score"] a:nth-child(3)').when_present.click
    @browser.link(:text => 'Write a review').when_present.click
    @browser.link(:css => 'a[title="Toggle HTML mode"]').when_present.click
    populate_page_with data_for(:ViewIncidentReportPage, data)
    @browser.send_keys :tab
    @browser.send_keys :space
    @browser.button(:name => 'post').when_present.click
  end

  def add_anon_comment_mentioning_tim
    @browser.link(:text => 'Add a comment').when_present.click
    @browser.link(:id => 'wysiwyg_id_0_html').when_present.click
    @browser.textarea(:class => 'usertext').set "This is a comment mentioning " + '<body><p><a class="jive_macro jive_macro_user" href="javascript:;" jivemacro="user" ___default_attr="2002" data-objecttype="3" data-orig-content="Tim Durden">Tim Durden</a></p></body>'
    @browser.send_keys :tab
    @browser.send_keys :space
    @browser.button(:name => 'post').when_present.click
  end

  def add_anon_comment_mentioning_simonwi
    @browser.link(:text => 'Add a comment').when_present.click
    @browser.link(:id => 'wysiwyg_id_0_html').when_present.click
    @browser.textarea(:class => 'usertext').set "This is a comment mentioning " + '<body><p><a class="jive_macro jive_macro_user" href="javascript:;" jivemacro="user" ___default_attr="2013" data-objecttype="3" data-orig-content="simonwhi@surevine">simonwhi@surevine</a></p></body>'
    @browser.send_keys :tab
    @browser.send_keys :space
    @browser.button(:name => 'post').when_present.click
  end
end
