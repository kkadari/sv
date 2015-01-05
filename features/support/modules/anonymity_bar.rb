module AnonymityBar
  include PageObject

  def raise_anonymously
    @browser.checkbox(:id => 'notAttributable').when_present.click
  end
  
end
