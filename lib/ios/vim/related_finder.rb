module IOS
  module Vim

    class RelatedFinder

      def initialize(filename)
        @filename = filename
        @classifier = RTypeClassifier.new @filename
      end

      def spec
        return @filename if @classifier.type == :spec
        return sentestingkit_spec_name if File.exists? sentestingkit_spec_name
        "#{@classifier.stem}Spec.m"
      end

      def sentestingkit_spec_name
        "#{@classifier.stem}Test.m" 
      end
      private :sentestingkit_spec_name

    end

  end
end
