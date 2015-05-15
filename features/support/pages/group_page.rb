class GroupPage
  include PageObject
  include DataMagic
  extend UrlFactory

  page_url(grouppage)
  
  text_field(:name, :id => 'jive-socialgroup-name-input')
  text_area(:description, :id => 'jive-socialgroup-desc')
  text_field(:tags, :id => 'jive-tags')
  link(:advanced, :text => 'Advanced options')
  radio_button(:open, :id => 'jive-socialgroup-type-OPEN')
  radio_button(:members_only, :id => 'jive-socialgroup-type-MEMBER_ONLY')
  radio_button(:private, :id => 'jive-socialgroup-type-PRIVATE')
  radio_button(:secret, :id => 'jive-socialgroup-type-SECRET')
  button(:save, :name => 'save')
  div(:content_header, :css => '#jive-body-intro-content h1')

  def complete_group(data = {})
    populate_page_with data_for(:GroupPage, data)
    save
  end

  def type_is (type = 'private')
    advanced
    case type
      when 'open'
        select_open
      when 'members-only'
        select_member_only
      when 'private'
        select_private
      when 'secret'
        select_secret
      else
        raise "Incorrect type selection: #{type}"
    end
  end

end
