And /^I have changed my time zone preferences$/ do
  visit PreferencesPage do |pref|
    pref.timezone = 'America/Bogota'
    pref.save
  end
end

Then /^I export the (blog|discussion|incident report) to PDF$/ do |type|
  pending("PDF exports cannot be verified, as they are an missing EOF file marker.")
  case type
    when 'blog'
      on(BlogPostSummaryPage).export_to_pdf
      fail "#{text} not found in PDF" unless @browser.html.include? @subject
    when 'discussion'
      on(DiscussionSummaryPage).export_to_pdf
      fail "#{text} not found in PDF" unless @browser.html.include? @subject
    when 'incident report'
      on(DiscussionSummaryPage).export_to_pdf
      fail "#{text} not found in PDF" unless @browser.html.include? @subject
    else
      fail 'Cannot export content of that type.'
  end 
end

Then /^I can export the blog to PDF with the correct timestamp$/ do
  pending("CISP-910 - TZ change not respected in PDF export.")
  utc_offset = -5
  zone = ActiveSupport::TimeZone[utc_offset].name
  text = DateTime.now.in_time_zone(zone).strftime("%b %d, %Y %H")
  visit ContentPage do |content|
    content.content_items_elements.each do |link|
      if link.text.include? @content
        link.click
        break
      end
    end
  end
  on(BlogPostSummaryPage).export_to_pdf

  fail "#{text} not found in PDF" unless @browser.html.include? text

  visit PreferencesPage do |pref|
    pref.timezone = 'Europe/London'
    pref.save
  end

  on(GlobalNav).home
end

Then /^I can export the discussion to PDF with the correct timestamp$/ do
  pending("CISP-910 - TZ change not respected in PDF export.")
  utc_offset = -5
  zone = ActiveSupport::TimeZone[utc_offset].name
  text = DateTime.now.in_time_zone(zone).strftime("%b %d, %Y %H")
  on(GlobalNav).content
  on(ContentPage).discussions.click
  visit ContentPage do |content|
    content.content_items_elements.each do |link|
      if link.text.include? @content
        link.click
        break
      end
    end
  end
  on(DiscussionSummaryPage).export_to_pdf

  fail "#{text} not found in PDF" unless @browser.html.include? text

  visit PreferencesPage do |pref|
    pref.timezone = 'Europe/London'
    pref.save
  end

  on(GlobalNav).home
end

Then /^I can export the ir to PDF with the correct timestamp$/ do
  pending("CISP-910 - TZ change not respected in PDF export.")
  utc_offset = -5
  zone = ActiveSupport::TimeZone[utc_offset].name
  text = DateTime.now.in_time_zone(zone).strftime("%b %d, %Y %H")
  on(GlobalNav).content
  visit ContentPage do |content|
    content.content_items_elements.each do |link|
      if link.text.include? @content
        link.click
        break
      end
    end
  end
  on(IncidentReportSummaryPage).export_to_pdf

  fail "#{text} not found in PDF" unless @browser.html.include? text

  visit PreferencesPage do |pref|
    pref.timezone = 'Europe/London'
    pref.save
  end

  on(GlobalNav).home
end