module SharedCreateContentItems
  include PageObject

  text_field(:subject, :name => 'subject')

  # Body related items
  text_area(:body, :class => 'usertext')
  link(:enable_html_mode, :id => 'wysiwygtext_html')

  # Publish bar related items
  radio_button(:place, :id => 'js-place')
  radio_button(:people, :id => 'js-people')
  radio_button(:community, :id => 'js-all')
  text_area(:where, :id => 'js-publishbar-place-input')
  link(:browse, :id => 'js-publishbar-place-browse')
  link(:testing, :href => /create\.jspa\?sr\=cmenu\&containerType0\=14\&containerID\=1\#/)
  link(:change_place, :id => 'js-publishbar-changePlace')

  text_field(:tags, :class => 'js-tag-input')
  button(:save, :id => 'submitButton')
  checkbox(:anonymous,:id => 'notAttributable')

  def set_publish_level(level)
    case level
      when /In a place/
        area = level[/(?<=\+)(.*?)(?=\+)/]
        puts "Functionality pending, would have shared in #{area}"
        select_community
      #select_place
      #where = area
      when /Specific people/
        people = level[/(?<=\+)(.*?)(?=\+)/]
        puts "Functionality pending, would have shared only with #{people}"
        select_community
      when 'community'
        select_community
      when 'private group'
        publish_to(TestConfig.custom_group)
      when 'secret group'
        publish_to(TestConfig.secret_group)
      when 'space'
        publish_to(TestConfig.custom_space)
      else
        raise 'Something went wrong. Sorry about that.'
    end
  end

  def publish_to(name)
    @browser.radio(:id => 'js-place').when_present.click
    # If a place is already selected, change to the required location.
    if @browser.link(:id => 'js-publishbar-changePlace').present?
      @browser.link(:id => 'js-publishbar-changePlace').click
    end
    @browser.text_field(:id => 'js-publishbar-place-input').when_present.click
    @browser.send_keys name

    # Wait for place search results popover
    @browser.div(:class => 'j-pop js-pop j-autocomplete j-placePicker popover').wait_until_present
    group = name.sub("-"," ").split.map(&:capitalize).join(' ')
    @browser.span(:text,/#{group}/).click
  end

  def set_ihm_level(color)
    case color
      when 'red'
        @browser.radio(:name => 'handlingLevel', :id => '1').when_present.click
      when 'amber'
        @browser.radio(:name => 'handlingLevel', :id => '2').when_present.click
      when 'green'
        @browser.radio(:name => 'handlingLevel', :id => '3').when_present.click
      when 'white'
        @browser.radio(:name => 'handlingLevel', :id => '4').when_present.click
      when 'random'
        %w(select_red select_amber select_green select_white).sample
      else
        raise "Incorrect IHM selection: #{color}"
    end
  end

  def edit_handling_level
    options ||= []

    wait_until(5, 'Couldn\'t find the radio buttons') do
      @browser.radio(:name => 'handlingLevel').exists?
    end

    @browser.radios(:name => 'handlingLevel').each do | radio |
      unless radio.checked?
        options << radio.id
      end
    end
    new_id = options.sample # select random option
    @browser.radio(:name => 'handlingLevel', :id => new_id).when_present.set
    case new_id
      when '1'
        new_color = 'red'
      when '2'
        new_color = 'amber'
      when '3'
        new_color = 'green'
      when '4'
        new_color = 'white'
      else
        raise 'Handling level ID incorrect.'
    end
    new_color
  end

end