module IOS
  module Vim

    class RelatedFinder

      def initialize(filename)
        @filename = filename
        @classifier = RTypeClassifier.new @filename
      end

      module CommonTypeFinderMethods
        def initialize(filename, classifier)
          @filename = filename
          @classifier = classifier
        end

        def my_type
          self.class.name.downcase.to_sym
        end
      end

      class Spec
        include CommonTypeFinderMethods

        def find
          return @filename if @classifier.type == my_type
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
        Spec.new(@filename, @classifier).find
      end

      class Impl
        include CommonTypeFinderMethods

        def find
          return @filename if @classifier.type == my_type
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
        Impl.new(@filename, @classifier).find
      end

    end

  end
end
