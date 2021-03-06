@api
Feature: Dataset Features
  In order to realize a named business value
  As an explicit system actor
  I want to gain some beneficial outcome which furthers the goal

  Additional text...


  Background:
    Given users:
      | name    | mail                | roles                |
      | John    | john@example.com    | site manager         |
      | Badmin  | admin@example.com   | site manager         |
      | Gabriel | gabriel@example.com | editor               |
      | Jaz     | jaz@example.com     | editor               |
      | Katie   | katie@example.com   | content creator      |
      | Martin  | martin@example.com  | editor               |
      | Celeste | celeste@example.com | editor               |
    Given groups:
      | title    | author  | published |
      | Group 01 | Badmin  | Yes       |
      | Group 02 | Badmin  | Yes       |
      | Group 03 | Badmin  | No        |
    And group memberships:
      | user    | group    | role on group        | membership status |
      | Gabriel | Group 01 | administrator member | Active            |
      | Katie   | Group 01 | member               | Active            |
      | Jaz     | Group 01 | member               | Pending           |
      | Admin   | Group 02 | administrator member | Active            |
      | Celeste | Group 02 | member               | Active            |
    And "Tags" terms:
      | name     |
      | price    |
      | election |
    And datasets:
      | title      | publisher | author  | published | tags     | description |
      | Dataset 01 | Group 01  | Gabriel | Yes       | price    | Test 01     |
      | Dataset 02 | Group 01  | Gabriel | Yes       | election | Test 02     |
      | Dataset 03 | Group 01  | Katie   | Yes       | price    | Test 03     |
      | Dataset 04 | Group 02  | Celeste | No        | election | Test 04     |
      | Dataset 05 | Group 01  | Katie   | No        | election | Test 05     |
    And "format" terms:
      | name |
      | csv  |
      | html |
    And resources:
      | title       | publisher | format | author | published | dataset    | description |
      | Resource 01 | Group 01  | csv    | Katie  | Yes       | Dataset 01 | Test R1     |
      | Resource 02 | Group 01  | html   | Katie  | Yes       | Dataset 01 | Test R2     |
      | Resource 03 | Group 01  | html   | Katie  | Yes       | Dataset 02 | Test R3     |

  @noworkflow
  Scenario: Edit any dataset
    Given I am logged in as "John"
    And I am on "Dataset 03" page
    When I click "Edit"
    And I fill in "title" with "Dataset 03 edited"
    And I press "Finish"
    Then I should see "Dataset Dataset 03 edited has been updated"

  @noworkflow
  Scenario: Delete any dataset
    Given I am logged in as "John"
    And I am on "Dataset 03" page
    When I click "Edit"
    And I press "Delete"
    And I press "Delete"
    Then I should see "Dataset Dataset 03 has been deleted"

  @noworkflow
  Scenario: Publish any dataset
    Given I am logged in as "John"
    And I am on "Dataset 05" page
    When I click "Edit"
    And I check the box "Published"
    And I press "Finish"
    Then I should see "Dataset Dataset 05 has been updated"

  # https://github.com/Behat/Behat/issues/834
  @dummy
  Scenario: Dummy test
    Given I am on "/"
