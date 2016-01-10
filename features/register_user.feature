Feature: Register User

  As a human
  I want to create an account
  So that I can become a user

  @ignore
  Scenario: Properly register user
    Given I am at the register form
    When I register correctly
    Then I have an account

  @ignore
  Scenario: Enter existing username
    Given I am at the register form
    When I enter an existing username
    Then I see a warning

  @ignore
  Scenario: Enter existing email
    Given I am at the register form
    When I enter an existing email
    Then I see a warning