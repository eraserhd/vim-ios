
module IOS
  module Vim
    class AlternateFinder

      ALTERNATE_TYPE = {
        :source => :header,
        :header => :source
      }

      def initialize filename
        @classifier = ATypeClassifier.new filename
      end

      def alternate
        counterpart_of_type alternate_type
      end

      def alternate_type
        ALTERNATE_TYPE[@classifier.type]
      end

      private
      def counterpart_of_type type
        @classifier.extensions_for_type(type).each do |ext|
          return with ext if exists_with ext
        end
        with @classifier.primary_extension_for(type)
      end

      def with(ext)
        "#{@classifier.stem}.#{ext}"
      end

      def exists_with(ext)
        File.exists?(with(ext))
      end

    end
  end
end
