require_relative '../modules/shared_create_content_items'

class CreatePollPage
  include PageObject
  include SharedCreateContentItems
  extend UrlFactory

  page_url(pollpage)

  text_field(:option1, :name => 'options[0].text')
  text_field(:option2, :name => 'options[1].text')

end
