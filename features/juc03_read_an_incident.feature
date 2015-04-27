@JUC3
Feature: JUC3 - Read an incident

  @JUC3.1 @CISP-188 @JUC3.4 @CISP-583
  Scenario: Participant views an anonymous incident report
    Given I have logged in as "participant A" 
    And I have quickly raised a white incident report anonymously in a private group
    When I have logged in as "participant B" 
    Then I can view the anonymous incident report

  @JUC3.2 @CISP-185
  Scenario: Author views an anonymous incident report
    Given I have logged in as "participant A"
    And I have quickly raised a white incident report anonymously in a private group
    Then I will be able to view my recently created report
    
  @JUC3.3 @CISP-192
  Scenario: Admin views an anonymous incident report
    Given I have logged in as "participant A"
    And I have quickly raised a white incident report anonymously in a private group
    When I have logged in as "admin"
    Then I as an admin can view the anonymous incident report
    
  @JUC3.5 @CISP-585
  Scenario: Participant attempts to view an Incident Report without required permissions
    Given I have logged in as "participant B"
    And I have quickly raised an amber incident report in a secret group
    When I have logged in as "participant A"
    Then I can not directly access the incident report if I am not in that group
    
  @JUC3.6 @CISP-586
  Scenario: Participant searches for incident report by ID using spotlight search
    Given I have logged in as "participant A"
    And I have quickly raised a white incident report anonymously in a private group
    Then I can search for the incident report by ID and view the incident report

  @JUC3.7 @CISP-587
  Scenario: Participant searches for an Incident Report to which they have no access
    Given I have logged in as "participant B"
    And I have quickly raised an amber incident report in a secret group
    When I have logged in as "participant A"
    Then I can not find the incident report in search if I am not in that group
