require 'rubygems'

module IOS
  module Vim

    class XcodeprojInterface

      def self.instance
        gem 'zerg_xcode', WANTED_ZERG_XCODE_VERSION
        XcodeprojInterface.new
      rescue LoadError => e
        raise LoadError.new("This feature requires zerg_xcode #{WANTED_ZERG_XCODE_VERSION}.")
      end
    end

  end
end
