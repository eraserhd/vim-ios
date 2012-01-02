Feature: Adding and removing
  In order to keep working in Vim,
  as a Vim hacker,
  I'd like to use :Xadd and :Xremove to update the Xcode project.

  @wip
  Scenario: Xadd
    Given my Xcode project has a target "Foo"
    And my Xcode project has a target "Bar"
    And my Xcode project has a target "Baz"
    And my Xcode project has a group "Classes"
    And I am editing "foo.cpp"
    When I run ":Xadd Classes Foo,Baz" in Vim
    Then "Classes/foo.cpp" will exist in Xcode project
    And "Classes/foo.cpp" will refer to "foo.cpp"
    And "Classes/foo.cpp" will be in target "Foo"
    And "Classes/foo.cpp" will be in target "Bar"
    And "Classes/foo.cpp" will not be in target "Baz"
