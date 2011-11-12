module IOS
  module Vim

    class RelatedFinder

      def initialize(filename)
        @filename = filename
        @classifier = RTypeClassifier.new @filename
      end

      def spec
        return @filename if @classifier.type == :spec
        return "#{@classifier.stem}Test.m" if File.exists?("#{@classifier.stem}Test.m")
        "#{@classifier.stem}Spec.m"
      end

    end

  end
end
