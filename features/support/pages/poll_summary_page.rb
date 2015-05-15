require_relative '../modules/nav_ribbon'
require_relative '../modules/user_modal'
require_relative '../modules/ihm_bar'

class PollSummaryPage
  include PageObject
  include NavRibbon
  include UserModal
  include DataMagic
  include IhmBar
  extend UrlFactory

  page_url(pollsummarypage)
  
  link(:edit_poll_button, :text => /Edit/)
  link(:delete, :text => 'Delete')
  button(:confirm_delete, :id => 'poll-delete-submit-button')
  link(:comment, :text => 'Add a comment')
  link(:edit, :id => 'wysiwyg_id_0_html')
  text_area(:comment_content, :class => 'usertext')
  button(:submit, :name => 'post')
  link(:testing_breadcrumb, :href => "/groups/#{TestConfig.custom_group}/content?filterID=contentstatus[published]~objecttype~objecttype[poll]")
  link(:archive, :text => /Archive/)
  button(:confirm_archive, :id => 'poll-archive-submit-button')
  button(:vote, :id => 'vote')
  h1(:title, :css => '.j-poll-title h1')

  def edit_poll
    @browser.link(:text => /Edit/).when_present.click
  end

  def delete_poll
    @browser.link(:text => 'Delete').when_present.click
    wait_until do
      @browser.text.include? 'Warning: This will delete the poll and all of its comments'
    end
    @browser.button(:id => 'poll-delete-submit-button').when_present.click
  end

  def add_comment(data={})
    @browser.link(:text => 'Add a comment').when_present.click
    @browser.link(:id => 'wysiwyg_id_0_html').when_present.click
    populate_page_with data_for(:PollSummaryPage, data)
    @browser.button(:name => 'post').when_present.click
  end

  def follow_breadcrumb
    wait_until do
      @browser.ul(:id,'jive-action-sidebar-tab-list_poll-actions-tab').present?
    end
    
    testing_breadcrumb
  end

  def archive_poll
    @browser.link(:text => /Archive/).when_present.click
    wait_until do
      @browser.text.include? 'Archiving expires a poll and removes it from the active polls list'
    end
    @browser.button(:id => 'poll-archive-submit-button').when_present.click
  end


  def wait_for_poll_archived
    wait_until do
      @browser.div(:id,'j-poll-ended').present?
    end
  end

  def vote_on_poll
    @browser.element(:xpath => '//*[@id="jive-poll-vote"]/ul[1]/li[1]/a[1]').when_present.click
    @browser.button(:id => 'vote').when_present.click
  end

  def confirm_vote
    wait_until { @browser.element(:xpath => '//*[@id="jive-poll-vote"]/ul[2]/li[1]/span[@class="j-vote-box j-ui-elem j-check"]') }
  end

  def verify_content_exists(title)
    wait_until { @browser.html.to_s.include? title[15] }
    #Ratings widget causes delay in logout link being accessible. Wait for it to fully load. ~TD
    @browser.div(:class => 'jive-content-avgrating-score').wait_until_present
  end
end
