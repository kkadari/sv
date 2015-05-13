And /^I have changed my time zone preferences$/ do
  on(HomePage).open_preferences
  on(PreferencesPage).change_timezone_to("America/Bogota")
end

Then /^I export the (blog|discussion|incident report) to PDF$/ do |type|
  pending("PDF exports cannot be verified, as they are an missing EOF file marker.")
  case type
    when 'blog'
      on(BlogPostSummaryPage).export_to_pdf
      on(BlogPostPdfPage).pdf_includes(@subject)
    when 'discussion'
      on(DiscussionSummaryPage).export_to_pdf
      on(DiscussionPdfPage).pdf_includes(@subject)
    when 'incident report'
      on(DiscussionSummaryPage).export_to_pdf
      on(DiscussionPdfPage).pdf_includes(@subject)
    else
      fail 'Cannot export content of that type.'
  end 
end

Then /^I can export the blog to PDF with the correct timestamp$/ do
  pending("CISP-910 - TZ change not respected in PDF export.")
  utc_offset = -5
  zone = ActiveSupport::TimeZone[utc_offset].name
  text = DateTime.now.in_time_zone(zone).strftime("%b %d, %Y %H")
  on(HomePage).click_content
  on(ContentPage).navigate_to_content_named(@subject)
  on(BlogPostSummaryPage).export_to_pdf

  on(BlogPostPdfPage).pdf_includes text
  visit(Homepage)
  on(HomePage).open_preferences
  on(PreferencesPage).change_timezone_to "Europe/London"

  on(PreferencesPage).click_home
end

Then /^I can export the discussion to PDF with the correct timestamp$/ do
  pending("CISP-910 - TZ change not respected in PDF export.")
  utc_offset = -5
  zone = ActiveSupport::TimeZone[utc_offset].name
  text = DateTime.now.in_time_zone(zone).strftime("%b %d, %Y %H")
  on(HomePage).click_content
  on(ContentPage).click_discussions
  on(ContentPage).navigate_to_content_named @subject
  on(DiscussionSummaryPage).export_to_pdf

  on(DiscussionPdfPage).pdf_includes text
  visit(Homepage)
  on(HomePage).open_preferences
  on(PreferencesPage).change_timezone_to "Europe/London"

  on(PreferencesPage).click_home
end

Then /^I can export the ir to PDF with the correct timestamp$/ do
  pending("CISP-910 - TZ change not respected in PDF export.")
  utc_offset = -5
  zone = ActiveSupport::TimeZone[utc_offset].name
  text = DateTime.now.in_time_zone(zone).strftime("%b %d, %Y %H")
  on(HomePage).click_content
  on(ContentPage).navigate_to_ir_named @subject
  on(IncidentReportSummaryPage).export_to_pdf

  on(IncidentReportPdfPage).pdf_includes text
  visit(Homepage)
  on(HomePage).open_preferences
  on(PreferencesPage).change_timezone_to "Europe/London"

  on(PreferencesPage).click_home
end