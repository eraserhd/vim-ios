module IOS
  module Vim

    class RelatedFinder

      def initialize(filename)
        @filename = filename
        @classifier = RTypeClassifier.new @filename
      end

      def spec
        return @filename if @classifier.type == :spec
        spec_candidates.detect{|e| File.exists? e} || kiwi_spec
      end

      def spec_candidates
        [
          "#{@classifier.stem}Spec.mm",
          kiwi_spec,
          "#{@classifier.stem}Test.m" 
        ]
      end
      private :spec_candidates

      def kiwi_spec
        "#{@classifier.stem}Spec.m"
      end
      private :kiwi_spec

      def impl
        return @filename if @classifier.type == :impl
        impl_candidates.detect{|e| File.exists? e} || "#{@classifier.stem}.m"
      end

      def impl_candidates
        [
          "#{@classifier.stem}.mm",
          "#{@classifier.stem}.m",
          "#{@classifier.stem}.h"
        ]
      end
      private :impl_candidates

    end

  end
end
