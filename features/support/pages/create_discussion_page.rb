require_relative '../modules/create_content_type_items'

class CreateDiscussionPage
  include PageObject
  include CreateContentTypeItems
  extend UrlFactory

  page_url(discussionpage)

  checkbox(:as_question,:id => 'mq01')

end