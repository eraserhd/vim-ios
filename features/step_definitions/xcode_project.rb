
Given /^my Xcode project has a target "([^"]*)"$/ do |target_name|
  add_xcode_target target_name
end

Given /^my Xcode project has a group "([^"]*)"$/ do |group_name|
  add_xcode_group group_name
end

Then /^"([^"]*)" will exist in Xcode project$/ do |path_name|
  group_path_exists?(path_name).should be_true
end

Then /^"([^"]*)" will refer to "([^"]*)"$/ do |group_path, physical_path|
  physical_path_for_group_path(arg1).should == physical_path
end

Then /^"([^"]*)" will be in target "([^"]*)"$/ do |group_path, target_name|
  in_target?(group_path, target_name).should be_true
end

Then /^"([^"]*)" will not be in target "([^"]*)"$/ do |group_path, target_name|
  in_target?(group_path, target_name).should be_false
end

Before do
  nuke_temporary_directory
end
