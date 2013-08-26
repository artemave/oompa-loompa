@javascript
Feature: view list of accounts
  In order to choose what suits me best
  I want to see what accounts there are to follow

  Scenario: view list of accounts
    Given there are accounts "RProgramming150" and "Hn200"
    When I visit ooompa site
    Then I should see "RProgramming150" and "Hn200"
    And I should be able to follow them
