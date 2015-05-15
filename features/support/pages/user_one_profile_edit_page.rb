require_relative '../modules/nav_ribbon'
require_relative '../modules/user_modal'

class UserOneProfileEditPage
  include PageObject
  include DataMagic
  include NavRibbon
  include UserModal
  extend UrlFactory

  page_url(useroneprofileeditpage)

  link(:privacy_settings, :text => 'Privacy Settings')
  #text_field(:main_phone, :name => /profile\[\d+\]\.phoneNumbers\[\d+\]\.phoneNumber$/)
  #text_field(:alt_email, :name => /profile\[\d+\]\.emails\[\d+\]\.email$/)
  #text_area(:email, :name => 'email')
  #text_field(:street_1, :name => /profile\[\d+\]\.addresses\[\d+\]\.street1$/)
  #text_field(:city, :name => /profile\[\d+\]\.addresses\[\d+\]\.city/)
  #text_field(:post_code, :name => /profile\[\d+\]\.addresses\[\d+\]\.postalCode/)
  #text_field(:country, :name => /profile\[\d+\]\.addresses\[\d+\]\.country/)
  #text_field(:bio, :name => /profile\[\d+\]\.value/)
  text_field(:title, :css => '.jive-edit-profile tr:nth-child(7) input')
  button(:save, :name => 'save')

  def update_profile(data = {})
    populate_page_with data_for(:UserOneProfilePage, data)
    @browser.button(:name => 'save').when_present.click
  end

  def edit_privacy_settings
    @browser.link(:text => 'Privacy Settings').when_present.click
  end
end
