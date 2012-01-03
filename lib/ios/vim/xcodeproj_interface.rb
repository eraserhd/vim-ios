require 'rubygems'

module IOS
  module Vim

    def self.xcodeproj_interface
      begin
        gem 'zerg_xcode', '~> 0.4.0'
        XcodeprojInterface.new
      rescue LoadError => e
        raise LoadError.new('This feature requires the zerg_xcode gem.')
      end
    end

    class XcodeprojInterface
    end

  end
end
