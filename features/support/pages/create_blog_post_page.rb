require_relative '../modules/create_content_type_items'

class CreateBlogPostPage
  include PageObject
  include CreateContentTypeItems
  extend UrlFactory

  page_url(blogpostpage)

end
