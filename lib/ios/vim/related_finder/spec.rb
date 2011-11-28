require 'ios/vim/related_finder/common_methods'

module IOS
  module Vim
    class RelatedFinder

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

    end
  end
end

