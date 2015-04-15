require_relative '../modules/nav_ribbon'
require_relative '../modules/user_modal'
require_relative '../modules/pdf_export'
require_relative '../modules/ihm_bar'

class BlogPostSummaryPage
  include PageObject
  include NavRibbon
  include UserModal
  include DataMagic
  include PdfExport
  include IhmBar

  page_url("#{FigNewton.base_url}/people/#{/.*/}")
  
  link(:edit_blog_button, :text => /Edit/)
  link(:delete, :text => /Delete/)
  button(:confirm_delete, :id => 'blogpost-delete-submit-button')
  link(:comment, :text => 'Add a comment')
  link(:edit, :id => 'wysiwyg_id_0_html')
  text_area(:comment_content, :class => 'usertext')
  button(:submit, :name => 'post')

  def edit_blog_post
    @browser.link(:text => /Edit/).wait_until_present
    edit_blog_button
  end

  def delete_blog_post
    @browser.link(:text => /Delete/).wait_until_present
    delete
    wait_until do
      @browser.text.include? 'Are you sure you want to delete this post'
    end
    @browser.button(:id => 'blogpost-delete-submit-button').wait_until_present
    confirm_delete
    sleep 2
  end

  def add_comment(data={})
    @browser.link(:text => 'Add a comment').wait_until_present
    comment
    @browser.link(:id => 'wysiwyg_id_0_html').wait_until_present
    edit
    sleep 2
    populate_page_with data_for(:PollSummaryPage, data)
    @browser.button(:name => 'post').wait_until_present
    submit
  end

  def verify_content_exists(title)
    wait_until { @browser.html.to_s.include? title[15] }
  end
end
