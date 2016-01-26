Feature: Register User

  As a human
  I want to create an account
  So that I can become a user

  Scenario: Open/Close register modal
    Given I am at the splash page
    When I open the login modal
    Then The login modal appears
    When I click the register button
    Then The register form appears
    When I click the close button
    Then The register modal disappears

  Scenario: Enter non-matching passwords
    Given I am at the register form
    When I enter non-matching passwords
    Then I see a danger toast containing "Please make sure your password fields match"

  Scenario: Register user with email
    Given I am at the register form
    When I register with email
    Then I see a success toast containing "Please check your email to verify your registration"
    And I sign out

  Scenario: Enter existing username
    Given I am at the register form
    When I enter an existing username
    Then I see a danger toast containing "Username already exists"

  Scenario: Enter existing email
    Given I am at the register form
    When I enter an existing email
    Then I see a danger toast containing "Email already exists"

  Scenario: Register user without email
    Given I am at the register form
    When I register without email
    Then I see a warning toast containing "Please add an email address on your profile page"
    And I sign out

  Scenario: Clear users
    When I remove all users
    Then No users remain
