require 'ios/vim/file_classifier'

module IOS
  module Vim
    class AlternateFinder

      ALTERNATE_TYPE = {
        :source => :header,
        :header => :source
      }

      def initialize classifier
        @classifier = classifier
      end

      def alternate
        counterpart_of_type alternate_type
      end

      def alternate_type
        ALTERNATE_TYPE[@classifier.type]
      end
      private :alternate_type

      def counterpart_of_type type
        "#{@classifier.stem}.#{FileClassifier::EXTENSIONS[type].first}"
      end
      private :counterpart_of_type

    end
  end
end
