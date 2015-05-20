module SharedCreateContentItems
  include PageObject

  text_field(:subject, :name => 'subject')

  # Body related items
  text_area(:body, :class => 'usertext')
  link(:enable_html_mode, :id => 'wysiwygtext_html')

  spans(:handling, :class => 'handlinglevel-color')

  # Publish bar related items
  radio_button(:place, :id => 'js-place')
  radio_button(:people, :id => 'js-people')
  radio_button(:community, :id => 'js-all')
  text_field(:where, :id => 'js-publishbar-place-input')
  link(:browse, :id => 'js-publishbar-place-browse')
  link(:change_place, :id => 'js-publishbar-changePlace')
  div(:dropdown, :class => 'j-pop js-pop j-autocomplete j-placePicker popover')

  text_field(:tags, :class => 'js-tag-input')

  button(:save, :id => 'submitButton')
  checkbox(:anonymous,:id => 'notAttributable')

  def publish_to(name)
    wait_until do
      self.place?
    end

    self.select_place
    self.change_place.click rescue nil

    wait_until do
      self.where?
    end

    self.where
    self.where = name

    wait_until do
      self.dropdown?
    end

    group = name.sub("-"," ").split.map(&:capitalize).join(' ')
    @browser.span(:text,/#{group}/).click
  end

end