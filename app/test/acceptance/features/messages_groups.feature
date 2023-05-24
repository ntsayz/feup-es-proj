Feature: Send and receive messages
  Scenario: As a user I want to be able to send and receive messages inside my groups
    Given I am part of a group
    When I want to talk to other members of that group
    Then I go to the messages screen and can send messages to other elements


    Given I am part of a group
    When I want to arrange an event with other members
    Then I send message to other elements

    Given I want to be part of an event
    When I want to know more informations about some of the players
    Then I send a message top the other elements
