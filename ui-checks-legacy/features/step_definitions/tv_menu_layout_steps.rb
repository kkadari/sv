Then /^I am presented with a customised footer with Threatvine specific links$/ do
  visit_and_benchmark HomePage do |home|
    fail('Footer could not be found') unless home.footer?

    links = ['Get Involved', 'Share an incident on Threatvine', 'Share tips and techniques', 'Join groups and start discussion', 'Getting the most out of Threatvine', 'Follow the Threatvine Blog', 'How We Can Help', 'Official Publications', 'Alerts & Advisories', 'Threatvine Services', 'Support', 'Getting Started', 'Frequently Asked Questions', 'Contact Us', 'Members', 'Member Directory', 'My Profile', 'My Inbox', 'Email Preferences']

    links.each do |link|
      fail('Expected to find ' + link + ' in footer') unless home.text.include? link
    end
  end
end
