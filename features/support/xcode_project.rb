require 'fileutils'
require 'zerg_xcode'

module XcodeProjectHelpers

  def nuke_temporary_directory
    FileUtils.rm_rf 'tmp'
  end

  def add_xcode_target(target_name)
    with_the_xcode_project do |project|
    end
  end

  def add_xcode_group(group_name)
    with_the_xcode_project do |project|
      #FIXME: push into zerg_xcode 0.4.1 (mkdir, mkdir_p)
      group = project['mainGroup']
      group_name.split('/').each do |section|
        next_group = group['children'].detect {|child| child['name'] == section}
        if next_group
          group = next_group
          next
        end

        next_group = ZergXcode::Objects::PBXGroup.new 'name' => section,
                                                      'children' => [],
                                                      'sourceTree' => "<group>"
        group.children << next_group
        group = next_group
      end
    end
  end

  def group_path_exists?(path_name)
    with_the_xcode_project do |project|
      #FIXME: push into zerg_xcode 0.4.1 (exists?)
      dir = project['mainGroup']
      path_name.split('/').each do |section|
        dir = dir['children'].detect {|child| child['name'] == section}
        return false if dir.nil?
      end
      true
    end
  end

  def physical_path_for_group_path(path_name)
    with_the_xcode_project do |project|
    end
  end

  def with_the_xcode_project
    initialize_project unless File.exist? 'tmp/Project.xcodeproj/project.pbxproj'
    project = ZergXcode.load 'tmp/Project.xcodeproj/project.pbxproj'
    result = yield project
    project.save!
    result
  end
  private :with_the_xcode_project

  def initialize_project
    FileUtils.mkdir_p 'tmp/Project.xcodeproj'
    File.open('tmp/Project.xcodeproj/project.pbxproj', 'w') do |f|
      f.write <<EOF
// !$*UTF8*$!
{
	archiveVersion = 1;
	classes = {
	};
	objectVersion = 45;
	objects = {
		19C28FACFE9D520D11CA2CBB /* Products */ = {
			isa = PBXGroup;
			children = (
			);
			name = Products;
			sourceTree = "<group>";
		};
		29B97314FDCFA39411CA2CEA /* CustomTemplate */ = {
			isa = PBXGroup;
			children = (
				19C28FACFE9D520D11CA2CBB /* Products */,
			);
			name = CustomTemplate;
			sourceTree = "<group>";
		};
		29B97313FDCFA39411CA2CEA /* Project object */ = {
			isa = PBXProject;
			buildConfigurationList = C01FCF4E08A954540054247B /* Build configuration list for PBXProject "Project" */;
			compatibilityVersion = "Xcode 3.1";
			developmentRegion = English;
			hasScannedForEncodings = 1;
			knownRegions = (
				en,
			);
			mainGroup = 29B97314FDCFA39411CA2CEA /* CustomTemplate */;
			projectDirPath = "";
			projectRoot = "";
			targets = (
			);
		};
		C01FCF4F08A954540054247B /* Debug */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ARCHS = "$(ARCHS_STANDARD_32_BIT)";
				"CODE_SIGN_IDENTITY[sdk=iphoneos*]" = "iPhone Developer";
				GCC_C_LANGUAGE_STANDARD = c99;
				GCC_WARN_ABOUT_RETURN_TYPE = YES;
				GCC_WARN_UNUSED_VARIABLE = YES;
				ONLY_ACTIVE_ARCH = YES;
				PREBINDING = NO;
				SDKROOT = iphoneos2.2.1;
			};
			name = Debug;
		};
		C01FCF5008A954540054247B /* Release */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ARCHS = "$(ARCHS_STANDARD_32_BIT)";
				"CODE_SIGN_IDENTITY[sdk=iphoneos*]" = "iPhone Developer";
				GCC_C_LANGUAGE_STANDARD = c99;
				GCC_WARN_ABOUT_RETURN_TYPE = YES;
				GCC_WARN_UNUSED_VARIABLE = YES;
				PREBINDING = NO;
				SDKROOT = iphoneos2.2.1;
			};
			name = Release;
		};
		C01FCF4E08A954540054247B /* Build configuration list for PBXProject "Project" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				C01FCF4F08A954540054247B /* Debug */,
				C01FCF5008A954540054247B /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
	};
	rootObject = 29B97313FDCFA39411CA2CEA /* Project object */;
}
EOF
    end
  end
  private :initialize_project

end

World(XcodeProjectHelpers)

