require 'ios/vim/related_finder/spec'
require 'ios/vim/related_finder/impl'

module IOS
  module Vim

    class RelatedFinder
      def initialize(filename)
        @filename = filename
        @classifier = RTypeClassifier.new @filename
      end

      [ Spec, Impl ].each do |type|
        define_method(type.name.gsub(/^.*::/, "").downcase) do
          type.new(@filename, @classifier).find
        end
      end
    end

  end
end
