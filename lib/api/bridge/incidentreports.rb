class IncidentReports

  def self.get_irs(auth)
    RestClient.get(ENV['bridge_url'] + '/incidentreports', :authorization => auth){|response|
      @response = response
    }
  end

  def self.get_ir(id, auth)
    RestClient.get(ENV['bridge_url'] + '/incidentreports/' + id, :authorization => auth){|response|
      @response = response
    }
  end

  def self.post_ir(payload, auth)
    RestClient.post(ENV['bridge_url'] + '/incidentreports', payload, {:authorization => auth,:content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 201
      @response = response
    }
  end

  def self.update_ir(id, payload, auth)
    RestClient.put(ENV['bridge_url'] + '/incidentreports/' + id, payload, {:authorization => auth,:content_type => 'application/json'}){|response|
      @response = response
    }
  end

  def self.delete_ir(id, auth)
    RestClient.delete(ENV['bridge_url'] + '/incidentreports/' + id, :authorization => auth){|response|
      @response = response
    }
  end

end