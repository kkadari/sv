class SearchPersonPicker
  include PageObject

  div(:container, :id => 'user-autocomplete-modal-container')
  link(:search_link, :css => '#jive-search-tab a.userpicker-page-link')
  text_field(:search_field, :name => 'query')
  button(:submit, :value => 'Search')
  checkbox(:user2_result, :css => 'td.jive-table-cell-checkbox > input:nth-child(1)')
end
