When /^I navigate to the list view of people page$/ do
  People.post_set_grid_view($authorisation)

  @response = People.get_browse_people($authorisation)
end

Then /^I will see the last logged in date for each person$/ do
  fail('Last logged in date not found') unless Nokogiri::HTML.parse(@response).css('.j-td-lastloggedin')[0].text.include? 'GMT'
end

Then /^I can sort by last logged in date$/ do
  2.times do |i|
    begin
      response = People.get_order_by_date($authorisation)

      logged_in_dates = Nokogiri::HTML.parse(response).css('.j-td-lastloggedin')

      date_1 = Time.parse logged_in_dates[0].text
      date_2 = Time.parse logged_in_dates[1].text

      fail('Order by most recent date failed') unless date_1 > date_2
      break
    rescue => e
      if i < 2
        sleep(1)
      else
        fail(e)
      end
    end
  end
end
