class ViewIncidentReportPage
  include PageObject
  include DataMagic
  extend UrlFactory

  page_url(viewincidentreportpage)
  
  link(:comment, :text => 'Add a comment')
  link(:review, :text => 'Write a review')
  link(:three_star, :css => 'div[class="jive-content-userrating-score"] a:nth-child(3)')
  link(:enable_html_mode, :id => 'wysiwyg_id_0_html')
  text_area(:comment_body, :class => 'usertext')
  button(:save, :name => 'post')
  checkbox(:anonymous, :id => 'attributed-check')

  def add_review(data={})
    three_star
    review
    enable_html_mode
    comment_body =
    save
  end

  def add_review_anonymously(data={})
    three_star
    review
    enable_html_mode
    comment_body =
    check_anonymous
    save
  end

end
