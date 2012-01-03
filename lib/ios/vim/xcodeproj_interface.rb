require 'rubygems'

module IOS
  module Vim

    def self.xcodeproj_interface
      begin
        gem 'zerg_xcode', '~> 0.4.0'
        RealXcodeprojInterface.new
      rescue LoadError => e
        NoXcodeprojInterface.new
      end
    end

    class NoXcodeprojInterface
      def method_missing *args
        raise LoadError.new('This feature requires the zerg_xcode gem.') 
      end
    end

    class RealXcodeprojInterface
    end

  end
end
