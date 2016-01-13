@watch
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
  Scenario: Register user without email
    Given I am at the register form
    When I register without email
    Then I see a warning toast containing "Please add an email address on your profile page"

  @ignore
  Scenario: Register user with email
    Given I am at the register form
    When I register with email
    Then I see a success toast containing "Please check your email to verify your registration"

  @ignore
  Scenario: Enter existing username
    Given I am at the register form
    When I enter an existing username
    Then I see a danger toast containing "Username already exists"

  @ignore
  Scenario: Enter existing email
    Given I am at the register form
    When I enter an existing email
    Then I see a danger toast containing "Email already exists"

  @watch
  Scenario: Enter non-matching passwords
    Given I am at the register form
    When I enter non-matching passwords
    Then I see a danger toast containing "Please make sure your password fields match"