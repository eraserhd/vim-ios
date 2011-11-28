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

      class ImplFinder
        def initialize(filename, classifier)
          @filename = filename
          @classifier = classifier
        end

        def find
          return @filename if @classifier.type == :impl
          candidates.detect{|e| File.exists? e} || default
        end

        def candidates
          [
            "#{@classifier.stem}.mm",
            default,
            "#{@classifier.stem}.h"
          ]
        end
        private :candidates

        def default
          "#{@classifier.stem}.m"
        end
        private :default
      end

      def impl
        ImplFinder.new(@filename, @classifier).find
      end

    end

  end
end
