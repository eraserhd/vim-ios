require 'rubygems'

module IOS
  module Vim

    class NoXcodeprojInterface
    end

    class RealXcodeprojInterface
    end

    def self.xcodeproj_interface
      begin
        gem 'zerg_xcode', '~> 0.4.0'
        RealXcodeprojInterface.new
      rescue LoadError => e
        NoXcodeprojInterface.new
      end
    end

  end
end
