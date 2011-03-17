Feature: Glossary
  In order to edit the client's glossary
  As a project member
  I want to browse and create new translations

  Scenario: Storing a sentence with translation
    When I go to "http://worx.example.com"
    Given a translator exists
    Given I am signed in as translator
    # TODO: Project membership
    When I go to "http://worx.example.com/glossary"
    And I follow "Add a sentence"
    And I fill in "Text" with "Base"
    And I select "ar" from "Language" within "#translations"
    And I fill in "Text" with "قاعدة" within "#translations"
    When I press "Create Sentence"
    Then a sentence should exist with text: "Base"
    And the sentence should have 1 translations
    Then I should see "Sentence was successfully created"
    
  Scenario: Browsing sentences
    When I go to "http://worx.example.com"
    Given a translator exists
    Given I am signed in as translator
    Given a sentence with translation exists with text: "Chicken"
    When I go to "http://worx.example.com/glossary"
    And I fill in "Enter part of a sentence to search" with "Chicken"
    And I press "Search"
    Then I should see "Chicken" within "#glossary-sentences"
  
  Scenario: Deleting a translation
    When I go to "http://worx.example.com"
    Given an admin exists
    Given I am signed in as admin
    # TODO: Project membership
    Given a sentence with translation: "chicken" exists with text: "Chicken"
    When I go to the glossary sentence page for the sentence: "chicken"
    And I follow "Delete"
    Then a sentence should not exist with text: "Chicken"
    
  Scenario: A translator cannot delete translations
    When I go to "http://worx.example.com"
    Given a translator exists
    Given I am signed in as translator
    # TODO: Project membership
    Given a sentence with translation: "chicken" exists with text: "Chicken"
    When I go to the glossary sentence page for the sentence: "chicken"
    Then I should not see "Delete"
  
  Scenario: Flagging a translation
    When I go to "http://worx.example.com"
    Given a translator exists
    Given I am signed in as translator
    # TODO: Project membership
    Given a sentence with translation: "chicken" exists with text: "Chicken"
    When I go to the glossary sentence page for the sentence: "chicken"
    And I follow "Flag sentence"
    Then show me the page
    Then the sentence: "chicken" should be flagged