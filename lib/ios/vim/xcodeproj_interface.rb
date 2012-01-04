require 'rubygems'

module IOS
  module Vim

    class XcodeprojInterface

      def self.instance
        begin
          gem 'zerg_xcode', '~> 0.4.0'
          XcodeprojInterface.new
        rescue LoadError => e
          raise LoadError.new('This feature requires the zerg_xcode gem.')
        end
      end
    end

  end
end
