require_relative '../modules/shared_create_content_items'

class CreateDiscussionPage
  include PageObject
  include SharedCreateContentItems
  extend UrlFactory

  page_url(discussionpage)

  checkbox(:as_question,:id => 'mq01')

end