require_relative '../modules/shared_create_content_items'

class CreateBlogPostPage
  include PageObject
  include SharedCreateContentItems
  extend UrlFactory

  page_url(blogpostpage)

end
