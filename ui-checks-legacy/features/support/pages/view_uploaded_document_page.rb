require_relative './shared/shared_summary_items'

class ViewUploadedDocumentPage
  include PageObject
  include SharedSummaryItems
  extend UrlFactory

  page_url(viewuploadeddocumentpage)

  link(:comment, :text => 'Add a comment')
  div(:document, :class => 'jive-rendered-content')

  h1(:title, :css => '.doc-page h1')

end
