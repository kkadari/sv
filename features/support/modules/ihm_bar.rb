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

end