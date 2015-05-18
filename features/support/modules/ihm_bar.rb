module IhmBar
  include PageObject

  radio_button(:red, :id => '1')
  radio_button(:amber, :id => '2')
  radio_button(:green, :id => '3')
  radio_button(:white, :id => '4')

  def correct_ihm_displayed(marking)
    case marking
      when 'red'
        fail 'IHM bar not present.' unless @browser.div(:class => 'ihmbar incidentreport.handlinglevel.1').visible?
      when 'amber'
        fail 'IHM bar not present.' unless @browser.div(:class => 'ihmbar incidentreport.handlinglevel.2').visible?
      when 'green'
        fail 'IHM bar not present.' unless @browser.div(:class => 'ihmbar incidentreport.handlinglevel.3').visible?
      when 'white'
        fail 'IHM bar not present.' unless @browser.div(:class => 'ihmbar incidentreport.handlinglevel.4').visible?
      else
        fail 'The specified marking cannot be displayed.'
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
end