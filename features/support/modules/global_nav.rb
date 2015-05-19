class GlobalNav
  include PageObject

  link(:people, :text => 'people')
  link(:home, :text => 'Home')
  link(:content, :text => 'Content')

end