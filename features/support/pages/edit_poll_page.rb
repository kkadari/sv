require_relative '../modules/create_content_type_items'

class EditPollPage
  include PageObject
  include CreateContentTypeItems
  extend UrlFactory

  page_url(polleditpage)
end