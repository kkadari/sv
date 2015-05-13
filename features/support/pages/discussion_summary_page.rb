require_relative '../modules/nav_ribbon'
require_relative '../modules/user_modal'
require_relative '../modules/pdf_export'
require_relative '../modules/ihm_bar'

class DiscussionSummaryPage
  include PageObject
  include NavRibbon
  include UserModal
  include DataMagic
  include PdfExport
  include IhmBar
  extend UrlFactory

  page_url(discussionsummarypage)

  def click_edit
    @browser.link(:text => /Edit/).when_present.click
  end

  def delete_discussion
    @browser.link(:text => /Delete/).when_present.click
    wait_until { @browser.text.include? 'Are you sure you want to delete the discussion' }
    @browser.button(:id => 'deletebutton').when_present.click
  end

  def add_reply(data={})
    @browser.link(:text => 'Reply').when_present.click
    @browser.link(:id => 'wysiwygtext1_html').when_present.click
    populate_page_with data_for(:DiscussionPage, data)

    @browser.button(:name => 'post').when_present.click
  end
  
  def verify_anonymous
    wait_until { @browser.html.to_s.include? 'This content was posted anonymously by its author' }
  end
  
  def verify_anonymous_as_participant
    # Simple check for now, could be greatly improved.
    fail 'Discussion does not include Anonymous avatar' unless @browser.image(:class => 'jive-avatar anonymous-avatar').visible?
  end

  def verify_content_exists(title)
    wait_until { @browser.html.to_s.include? title[15] }
    #Ratings widget causes delay in logout link being accessible. Wait for it to fully load. ~TD
    @browser.div(:class => 'jive-content-avgrating-score').wait_until_present
  end
      
end
