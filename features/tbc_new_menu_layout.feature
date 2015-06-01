@manual
Feature: New menu layout

  Scenario: New menu and submenu options
    Given I have logged in as "participant A"
    Then I will see a menu option name "Communities & Nodes" with the following submenu options
      | All              |
      | Following        |
      | Member of        |
      | Owner of         |
      | My Recent Places |
    And I will see a menu option name "Members" with the following submenu options
      | All             |
      | I'm Following   |
      | My Followers    |
      | Recently viewed |
      | My Colleagues   |
    And I will see a menu option name "Browse" with the following submenu options
      | All                  |
      | Recently Viewed      |
      | Following            |
      | Authored             |
      | Support              |
      | Alerts & Advisories  |
      | CERT-UK Publications |
      | CiSP Services        |

    Scenario: 'Recently viewed' submenu population
      Given I have logged in as "participant A"
      And I've visited various groups and places
      When I open the "Communities & Nodes" menu
      Then I will see a list of groups and places I've recently visited
      And clicking on "Show more..." takes me to the recently viewed places page

    Scenario: 'My colleagues' submenu option
      Given I have logged in as "participant A"
      When I click on the menu item "My Colleagues" in the "Members" menu
      Then I am taken to a peoples list that is filtered by people in my organisation

    Scenario: Custom footer layout
      Given I have logged in as "participant A"
      Then I am presented with a customised footer with CISP specific links