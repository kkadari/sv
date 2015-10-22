class Payload

  def convert_bool(bool) bool ? 'true' : 'false' end

  def set_ihm_level(color)
    case color
      when 'red'
        return '1'
      when 'amber'
        return '2'
      when 'green'
        return '3'
      when 'white'
        return '4'
      when 'random'
        %w(1 2 3 4).sample
      else
        raise "Allowed combinations are red, amber, green, white and random.  You chose: #{color}"
    end
  end

  def set_publish_bar(publication)
    case publication[:type]
      when 'community'
        return '{"visibility":"all"}'
      when 'space'
        return '{"visibility":"place","container":{"objectType":"14","objectID":"2009"}}'
      when 'private group'
        return '{"visibility":"place","container":{"objectType":"700","objectID":"1004"}}'
      when 'secret group'
        return '{"visibility":"place","container":{"objectType":"700","objectID":"1005"}}'
      when 'specific group'
        return '{"visibility":"place","container":{"objectType":"700","objectID":"' + publication[:id] + '"}}'
      when 'specific space'
        return '{"visibility":"place","container":{"objectType":"14","objectID":"' + publication[:id] + '"}}'
      else
        raise "Allowed publications are community, private group, secret group and space.  You chose: #{publication[:type]}"
    end
  end

end
