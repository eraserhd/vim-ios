require 'ios/vim/related_finder/spec'
require 'ios/vim/related_finder/impl'

module IOS
  module Vim

    class RelatedFinder
      RELATED_TYPES = [ Spec, Impl ]

      def initialize(filename)
        @filename = filename
        @classifier = RTypeClassifier.new @filename
      end

      RELATED_TYPES.each do |type|
        define_method(type.name.gsub(/^.*::/, "").downcase) do
          type.new(@filename, @classifier).find
        end
      end

      def next
        next_type.new(@filename, @classifier).find
      end

      def related_type_symbols
        RELATED_TYPES.map{|e| e.name.gsub(/^.*::/, "").downcase.to_sym}
      end
      private :related_type_symbols

      def next_type
        i = related_type_symbols.index(@classifier.type)
        i = (i + 1) % RELATED_TYPES.size
        RELATED_TYPES[i]
      end
      private :next_type

    end

  end
end
