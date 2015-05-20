require_relative './shared/shared_create_content_items'

class EditPollPage
  include PageObject
  include SharedCreateContentItems
  extend UrlFactory

  page_url(polleditpage)
end