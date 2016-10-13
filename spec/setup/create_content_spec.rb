require 'spec_helper'

describe 'Create incident reports in the community' do

  it 'should return 200 when creating a red incident report' do

    attack = %w(DDoS phishing logic-bomb trojan).sample
    system = Faker::Company.catch_phrase.downcase
    content =  Faker::Lorem.paragraph(50,false,50)
    @subject = "We just experienced a #{attack} attack on our #{system} system"

    payload = IncidentReportPayload.new(@subject, false, '<strong>Auto-generated content:</strong><br /><br />' + content, 'red', {:type => 'community'}, '', false).payload

    response = CreateContent.create_incident_report(payload, @authorisation)
    @incident_id = response['redirect'][/[0-9]+/,0].to_s
    @incident_url = ENV['base_url'] + '/view-incidentreport.jspa?incidentReportID=' + response['redirect']

  end

  it 'should return 200 when creating an amber incident report' do

    attack = %w(DDoS phishing logic-bomb trojan).sample
    system = Faker::Company.catch_phrase.downcase
    content =  Faker::Lorem.paragraph(50,false,50)
    @subject = "We just experienced a #{attack} attack on our #{system} system"

    payload = IncidentReportPayload.new(@subject, false, '<strong>Auto-generated content:</strong><br /><br />' + content, 'amber', {:type => 'community'}, '', false).payload

    response = CreateContent.create_incident_report(payload, @authorisation)
    @incident_id = response['redirect'][/[0-9]+/,0].to_s
    @incident_url = ENV['base_url'] + '/view-incidentreport.jspa?incidentReportID=' + response['redirect']

  end

  it 'should return 200 when creating a green incident report' do

    attack = %w(DDoS phishing logic-bomb trojan).sample
    system = Faker::Company.catch_phrase.downcase
    content =  Faker::Lorem.paragraph(50,false,50)
    @subject = "We just experienced a #{attack} attack on our #{system} system"

    payload = IncidentReportPayload.new(@subject, false, '<strong>Auto-generated content:</strong><br /><br />' + content, 'green', {:type => 'community'}, '', false).payload

    response = CreateContent.create_incident_report(payload, @authorisation)
    @incident_id = response['redirect'][/[0-9]+/,0].to_s
    @incident_url = ENV['base_url'] + '/view-incidentreport.jspa?incidentReportID=' + response['redirect']

  end

  it 'should return 200 when creating a white incident report' do

    attack = %w(DDoS phishing logic-bomb trojan).sample
    system = Faker::Company.catch_phrase.downcase
    content =  Faker::Lorem.paragraph(50,false,50)
    @subject = "We just experienced a #{attack} attack on our #{system} system"

    payload = IncidentReportPayload.new(@subject, false, '<strong>Auto-generated content:</strong><br /><br />' + content, 'white', {:type => 'community'}, '', false).payload

    response = CreateContent.create_incident_report(payload, @authorisation)
    @incident_id = response['redirect'][/[0-9]+/,0].to_s
    @incident_url = ENV['base_url'] + '/view-incidentreport.jspa?incidentReportID=' + response['redirect']

  end
end