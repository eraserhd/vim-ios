module IOS
    module Vim
        module XCommands

            def command_Xadd path, targets
                XcodeprojInterface.instance.add_file(
                    VIM::Buffer.current.name,
                    path,
                    targets.split(/,/)
                )
            rescue Exception => e
                print e.to_s
            end

            def command_Xbuild
                begin
                    build_file = File.open("#{Dir.pwd}/.build") 
                    build_params = build_file.read.gsub("\n","  ")
                rescue
                    build_params = nil
                end

                XcodeBuilder.new.build(build_params)
            end

            # Public: Install an iOS application.
            #
            # platform - A required value that must be either "device" or
            #            "simulator". Simulator support is actually not yet
            #            implemented but will be soon.
            def command_Xinstall(platform=nil)
                if (platform.nil?)
                    # A platform was not supplied. Notify the user that a valid
                    # platform must be supplied.
                    VIM.command('echo "A platform (\"device\" or \"simulator\") must be supplied."')
                    return
                elsif (platform.casecmp("device") || platform.casecmp("simulator"))
                    # Determine where the application bundle is.
                    platform_folder = platform.casecmp("device") ? "iphoneos" : "iphonesimulator"

                    # Retrive the path to the ARM application bundle.
                    app_path = app_in_directory("#{Dir.pwd}/build/Debug-#{platform_folder}/")

                    # Install the application to a connected device.
                    XcodeBuilder.new.install(app_path, platform)
                end
            end

            def command_Xdebug(platform=nil)

                if (platform.casecmp("device"))
                    app_path = app_in_directory("#{Dir.pwd}/build/Debug-iphoneos/")
                    XcodeRunner.new.debug(app_path)
                end
            end

            private

            def app_in_directory(directory)
                Dir.foreach(directory) do |item|
                    if File.extname(item) == ".app"
                        return "#{directory}/#{item}"
                    end
                end
            end
        end
    end
end
