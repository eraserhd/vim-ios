module IOS
  module Vim

    class RelatedFinder

      def initialize(filename)
        @filename = filename
        @classifier = RTypeClassifier.new @filename
      end

      def spec
        return @filename if @classifier.type == :spec
        spec_candidates.detect{|e| File.exists? e} || default_spec
      end

      def spec_candidates
        [
          "#{@classifier.stem}Spec.mm",
          default_spec,
          "#{@classifier.stem}Test.m" 
        ]
      end
      private :spec_candidates

      def default_spec
        "#{@classifier.stem}Spec.m"
      end
      private :default_spec

      def impl
        return @filename if @classifier.type == :impl
        impl_candidates.detect{|e| File.exists? e} || default_impl
      end

      def impl_candidates
        [
          "#{@classifier.stem}.mm",
          default_impl,
          "#{@classifier.stem}.h"
        ]
      end
      private :impl_candidates

      def default_impl
        "#{@classifier.stem}.m"
      end
      private :default_impl

    end

  end
end
