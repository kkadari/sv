@ui
Feature: New menu layout

  Scenario: New menu and submenu options
    Given I have logged in as "participant A"
    Then I will see a menu option name "Content" with the following submenu options
      | All             |
      | Recently Viewed |
      | Following       |
      | Authored        |
      | Participated    |
    And I will see a menu option name "Members" with the following submenu options
      | All             |
      | Recently Viewed |
      | Following       |
      | Followers       |
      | Colleagues      |
    And I will see a menu option name "Places" with the following submenu options
      | All       |
      | Following |
      | Member    |
      | Owner     |

  Scenario: 'Recently viewed' submenu population
    Given I have logged in as "participant A"
    And I've visited various groups and places
    When I open the Places menu
    Then I will see a list of groups and places I've recently visited
    And clicking on view more takes me to the recently viewed places page

  Scenario: 'Colleagues' submenu option
    Given I have logged in as "participant A"
    When I click on the menu item Colleagues in the Members menu
    Then I am taken to a peoples list that is filtered by people in my organisation

  Scenario: Custom footer layout
    Given I have logged in as "participant A"
    Then I am presented with a customised footer with CISP specific links
