Then /^I am presented with a customised footer with Threatvine specific links$/ do
  visit_and_benchmark HomePage do |home|
    fail('Footer could not be found') unless home.footer?

    links = ['Get Involved', 'Share an incident on Threatvine', 'Share tips and techniques', 'Join groups and start discussion', 'Getting the most out of Threatvine', 'Follow the Threatvine Blog', 'How we can Help', 'Official Publications', 'Alerts & Advisories', 'Threatvine Services', 'Support', 'Getting Started', 'Frequently Asked Questions', 'Contact Us', 'Members', 'Member directory', 'My profile', 'My Inbox', 'Email preferences']

    links.each do |link|
      fail('Expected to find ' + link + ' in footer') unless home.text.include? link
    end
  end
end
