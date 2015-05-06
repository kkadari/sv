module PublishBar
  include PageObject

  radio_button(:place, :id => 'js-place')
  radio_button(:people, :id => 'js-people')
  radio_button(:community, :id => 'js-all')
  text_area(:where, :id => 'js-publishbar-place-input')
  link(:browse, :id => 'js-publishbar-place-browse')
  link(:testing, :href => /create\.jspa\?sr\=cmenu\&containerType0\=14\&containerID\=1\#/)

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
        publish_to(FigNewton.custom_group)
      when 'secret group'
        publish_to(FigNewton.secret_group)
      when 'space'
        publish_to(FigNewton.custom_space)
      else
        fail 'Something went wrong. Sorry about that.'
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
    @browser.link(:text,/#{group}/).click
  end
end
