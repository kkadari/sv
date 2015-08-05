class SearchPersonPicker
  include PageObject

  div(:container, :id => 'user-autocomplete-modal-container')
  link(:alpha_link, :css => '#jive-people-resultbar-alphabetical > span:nth-child(21) > a')
  checkbox(:simon_user, :id => 'userChk-2013')

end