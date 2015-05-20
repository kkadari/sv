require_relative '../modules/shared_create_content_items'

class EditBlogPostPage
  include PageObject
  include SharedCreateContentItems
  extend UrlFactory

  page_url(blogposteditpage)
  
end