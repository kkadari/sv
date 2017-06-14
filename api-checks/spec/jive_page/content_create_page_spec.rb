require 'spec_helper'

describe 'Creating content' do

  it 'should return a 200 when creating a discussion' do

    attack = %w(DDoS phishing logic-bomb trojan).sample
    system = Faker::Company.catch_phrase.downcase
    content =  Faker::Lorem.paragraph(50,false,50)
    subject = "Let's talk about #{attack} attacks on #{system} systems"

    payload = DiscussionPayload
                  .new(subject,
                       false,
                       content,
                       'red',
                       Hash[:type => 'community'],
                       'test, test1',
                       false).payload

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/discussion/',payload,{:cookie => @authorisation,:content_type => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when creating a blog post' do

    attack = %w(DDoS phishing logic-bomb trojan).sample
    system = Faker::Company.catch_phrase.downcase
    content =  Faker::Lorem.paragraph(50,false,50)
    subject = "My thoughts on #{system} #{attack} attacks"

    payload = BlogPayload
                  .new(subject,
                       content,
                       'amber',
                       'test1, test2, test3').payload

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/blogPosts/',payload,{:cookie => @authorisation,:content_type => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when creating an incident report' do

    attack = %w(DDoS phishing logic-bomb trojan).sample
    system = Faker::Company.catch_phrase.downcase
    content =  Faker::Lorem.paragraph(50,false,50)
    subject = "We just experienced a #{attack} attack on our #{system} system"

    payload = IncidentReportPayload
                  .new(subject,
                       false,
                       content,
                       'red',
                       Hash[:type => 'community'],
                       'test, test2',
                       false).payload

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/incidentReports/',payload,{:cookie => @authorisation,:content_type => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when creating a document' do
    payload = DocumentPayload
                  .new(Faker::Lorem.words(10).join(','),
                       Faker::Lorem.paragraph(50,false,50),
                       'red',
                       'test.jpg').payload

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/document/upload',payload,{:cookie => @authorisation,:content_type => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end


  it 'should return a 200 when requesting the create discussion page' do
    RestClient.get(ENV['base_url'] + '/discussion/create.jspa?sr=crmenu&containerType=-1&containerID=-1',:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when requesting the create blog post page' do
    RestClient.get(ENV['base_url'] + '/blog/create-post.jspa?sr=cmenu&containerType=14&containerID=1',:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when requesting the create incident report page' do
    RestClient.get(ENV['base_url'] + '/incidentreports/create-incidentreport.jspa!input?sr=crmenu&containerType=14&containerID=1',:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when requesting the create document page' do
    RestClient.get(ENV['base_url'] + '/document/upload.jspa?sr=crmenu&containerType=14&containerID=1',:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

end
