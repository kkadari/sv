require 'spec_helper'

describe 'Get started page' do

  it 'should return a 200 when requesting the get started page' do
    RestClient.get(ENV['base_url'] + '/get-started',:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return 200s when requesting the onboarding popup' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/onboarding',{:cookie => @authorisation, :accept => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }

    RestClient.get(ENV['base_url'] + '/__services/v2/rest/onboarding/valueGroup',{:cookie => @authorisation, :accept => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }

    payload = '{"metricName":"AE_VC_MODAL_SELECT_VALUE_CASE","metricValues":{"valueCase":"ob"}}'

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/metric',payload,{:cookie => @authorisation, :content_type => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/onboarding/valueCase/ob','',{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end


  it 'should return a 200 when requesting and then completing "A quick overview of how the CE works"' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/onboarding/ob.cert_quick_overview',{:cookie => @authorisation,:accept => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/onboarding/ob.cert_quick_overview/complete','',{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when requesting and then completing "Take a tour of the interface"' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/onboarding/ob.cert_interface_tour',{:cookie => @authorisation,:accept => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/onboarding/ob.cert_interface_tour/complete','',{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when requesting and then completing "Find people.."' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/onboarding/ob.cert_find_people',{:cookie => @authorisation,:accept => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/onboarding/ob.cert_find_people/complete','',{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when requesting and then completing "Find groups and topics"' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/onboarding/ob.cert_find_groups_and_topics',{:cookie => @authorisation,:accept => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/onboarding/ob.cert_find_groups_and_topics/complete','',{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when requesting and then completing "Enter some profile details..."' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/onboarding/ob.cert_enter_profile_details',{:cookie => @authorisation,:accept => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/onboarding/ob.cert_enter_profile_details/complete','',{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/onboarding/profile','',{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
      assert_code_and_body(response, 204)
    }
  end

  it 'should return a 200 when requesting and then completing "Setup email notifications"' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/onboarding/ob.cert_setup_email_notifications',{:cookie => @authorisation,:accept => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/onboarding/ob.cert_setup_email_notifications/complete','',{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when requesting and then completing "See what they are how to create them"' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/onboarding/ob.cert_ir_overview',{:cookie => @authorisation,:accept => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/onboarding/ob.cert_ir_overview/complete','',{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when requesting and then completing "Browse some existing Incident Reports"' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/onboarding/ob.cert_ir_browse',{:cookie => @authorisation,:accept => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/onboarding/ob.cert_ir_browse/complete','',{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when requesting and then completing "Filter what you can see on the site.."' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/onboarding/ob.cert_create_activity_stream',{:cookie => @authorisation,:accept => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/onboarding/ob.cert_create_activity_stream/complete','',{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when requesting and then completing "Introduction to fusion cell"' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/onboarding/ob.cert_fusion_cell_intro',{:cookie => @authorisation,:accept => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/onboarding/ob.cert_fusion_cell_intro/complete','',{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when requesting and then completing "See whats new"' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/onboarding/ob.cert_whats_new',{:cookie => @authorisation,:accept => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/onboarding/ob.cert_whats_new/complete','',{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/onboarding/true','',{:cookie => @authorisation, :content_type => 'application/json', :accept => 'application/json'}){|response|
      assert_code_and_body(response, 204)
    }
  end

end
