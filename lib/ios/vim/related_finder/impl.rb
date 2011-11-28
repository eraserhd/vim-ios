require 'ios/vim/related_finder/common_methods'

module IOS
  module Vim
    class RelatedFinder

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

    end
  end
end

