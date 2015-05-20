require_relative '../modules/shared_create_content_items'

class EditDiscussionPage
  include PageObject
  include SharedCreateContentItems
  extend UrlFactory

  page_url(discussioneditpage)

end