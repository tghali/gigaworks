Feature: Glossary comments
  In order to comment on how a sentence can be translated
  As a project member
  I want to comment on a sentence

  Scenario: Storing a sentence with translation
    When I go to "http://worx.example.com"
    Given a translator exists
    Given I am signed in as translator
    # TODO: Project membership
    Given a sentence with translation: "chicken" exists with text: "Chicken"
    When I go to the glossary sentence page for the sentence: "chicken"
    # And I follow "Add Comment" # Simply unhides the form
    And I fill in "Comment" with "Some lengthy comment about the translation"
    When I press "Create Comment"
    Then a comment should exist with comment: "Some lengthy comment abut the translation"
    And the sentence should have 1 comments