require 'ios/vim/related_finder/spec'
require 'ios/vim/related_finder/impl'

module IOS
  module Vim

    class RelatedFinder
      RELATED_TYPES = [ Spec, Impl ]
      RELATED_TYPE_SYMBOLS = RELATED_TYPES.map{|e| e.name.gsub(/^.*::/, "").downcase.to_sym}

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

      def next_type
        i = RELATED_TYPE_SYMBOLS.index(@classifier.type)
        i = (i + 1) % RELATED_TYPE_SYMBOLS.size
        RELATED_TYPES[i]
      end
      private :next_type

    end

  end
end
