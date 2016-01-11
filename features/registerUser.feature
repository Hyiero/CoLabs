Feature: Register User

  As a human
  I want to create an account
  So that I can become a user
  
  @ignore
  Scenario: Close register modal
    Given I am at the register form
    When I click the close button
    Then The register modal disappears

  @ignore
  Scenario: Properly register user
    Given I am at the register form
    When I register correctly
    Then I have an account

  @ignore
  Scenario: Enter existing username
    Given I am at the register form
    When I enter an existing username
    Then I see an error toast containing "Username already exists"

  @ignore
  Scenario: Enter existing email
    Given I am at the register form
    When I enter an existing email
    Then I see a warning
    
  @ignore
  Scenario: Enter non-matching passwords
    Given I am at the register form
    When I enter non-matching passwords
    Then I see an error toast containing "Please make sure your password fields match"