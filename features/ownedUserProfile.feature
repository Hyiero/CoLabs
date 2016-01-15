@ignore
Feature: Owned user profile

  As a user
  I want to view and manage my profile
  So that I can make sure my information is up-to-date

  @ignore
  Scenario: Resend email verification
    Given I am a logged in, unverified user
    Given I am at the profile page
    When I click on the verify email button
    Then I see a success toast containing "sent"
  
  @ignore
  Scenario: Email verified message
    Given I am a logged in, verified user
    Given I am on the profile page
    Then I should see the
  
  @ignore
  Scenario: Add a tag
    Given I am a logged in user
    Given I am on the profile page
    When I click on the edit button
    Then I should see the edit profile form
    When I enter in a tag name
    Then I should see a new tag
    Then remove the tag # how do teardowns?
    
  