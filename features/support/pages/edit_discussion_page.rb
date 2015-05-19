require_relative '../modules/create_content_type_items'

class EditDiscussionPage
  include PageObject
  include CreateContentTypeItems
  extend UrlFactory

  page_url(discussioneditpage)

end