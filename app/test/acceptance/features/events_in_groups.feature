Feature: see events in a group
  Scenario: As a user I want to be able to see what events are happenning in my groups

    Given I am a member of a group
    When I click the group
    Then I should be able to see what events are happenning
    Then I can click the button to join the event