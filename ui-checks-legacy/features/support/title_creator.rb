class TitleCreator

  def self.create_title_for(type)
    attack = %w(DDoS phishing logic-bomb trojan).sample
    system = Faker::Company.catch_phrase.downcase
    appname = Faker::App.name.camelize
    case type
      when 'blog'
        $subject = "My thoughts on #{system} #{attack} attacks"
      when 'poll'
        $subject = "What is more important to users of #{system} systems?"
      when 'incident'
        $subject = "We just experienced a #{attack} attack on our #{system} system"
      when 'discussion'
        $subject = "Let's talk about #{attack} attacks on #{system} systems"
      when 'group'
        $subject = "#{appname} Group"
      when 'space'
        $subject = "#{appname} Space"
      else
        raise 'Incorrect content type supplied to title creator'
    end
  end

end
