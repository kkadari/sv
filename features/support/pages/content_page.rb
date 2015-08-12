class ContentPage
  include PageObject
  extend UrlFactory

  page_url(contentpage)
  
  link(:blogs, :text => 'Blog Posts')
  link(:documents, :text => 'Documents')
  link(:discussions, :text => 'Discussions')
  link(:polls, :text => 'Polls')
  link(:incident_reports, :text => 'Incident Reports')
  links(:content_items, :css => '#j-browse-item-grid a')
  elements(:full_content, :div, :css => '.browse-detail-div-ihm-padded')

end
