require 'ios/vim/related_finder/common_methods'

module IOS
  module Vim

    class RelatedFinder

      def initialize(filename)
        @filename = filename
        @classifier = RTypeClassifier.new @filename
      end

      class Spec
        include CommonMethods

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

      class Impl
        include CommonMethods

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

      [ Spec, Impl ].each do |type|
        define_method(type.name.gsub(/^.*::/, "").downcase) do
          type.new(@filename, @classifier).find
        end
      end

    end

  end
end
