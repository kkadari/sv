require_relative '../modules/create_content_type_items'

class EditBlogPostPage
  include PageObject
  include CreateContentTypeItems
  extend UrlFactory

  page_url(blogposteditpage)
  
end