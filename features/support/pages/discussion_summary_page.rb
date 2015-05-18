require_relative '../modules/nav_ribbon'

require_relative '../modules/pdf_export'
require_relative '../modules/ihm_bar'

class DiscussionSummaryPage
  include PageObject
  include NavRibbon

  include DataMagic
  include PdfExport
  include IhmBar
  extend UrlFactory

  page_url(discussionsummarypage)
  image(:avatar, :class => 'jive-avatar anonymous-avatar')

  def click_edit
    @browser.link(:text => /Edit/).when_present.click
  end

  def delete_discussion
    @browser.link(:text => /Delete/).when_present.click
    wait_until { @browser.text.include? 'Are you sure you want to delete the discussion' }
    @browser.button(:id => 'deletebutton').when_present.click
  end
      
end
