module IOS
  module Vim

    class RelatedFinder

      def initialize(filename)
        @filename = filename
        @classifier = RTypeClassifier.new @filename
      end

      class SpecFinder
        def initialize(filename, classifier)
          @filename = filename
          @classifier = classifier
        end

        def find
          return @filename if @classifier.type == :spec
          candidates.detect{|e| File.exists? e} || default
        end

        def candidates
          [
            "#{@classifier.stem}Spec.mm",
            default,
            "#{@classifier.stem}Test.m" 
          ]
        end
        private :candidates

        def default
          "#{@classifier.stem}Spec.m"
        end
        private :default
      end

      def spec
        SpecFinder.new(@filename, @classifier).find
      end

      def impl
        return @filename if @classifier.type == :impl
        impl_candidates.detect{|e| File.exists? e} || default_impl
      end

      def impl_candidates
        [
          "#{@classifier.stem}.mm",
          default_impl,
          "#{@classifier.stem}.h"
        ]
      end
      private :impl_candidates

      def default_impl
        "#{@classifier.stem}.m"
      end
      private :default_impl

    end

  end
end
