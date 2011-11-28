module IOS
  module Vim

    class RelatedFinder

      def initialize(filename)
        @filename = filename
        @classifier = RTypeClassifier.new @filename
      end

      def spec
        return @filename if @classifier.type == :spec
        existing_spec_candidates.detect{|e| File.exists? e} || kiwi_spec
      end
      
      def impl
        return @filename if @classifier.type == :impl
        return "#{@classifier.stem}.mm" if File.exists? "#{@classifier.stem}.mm"
        "#{@classifier.stem}.m"
      end

      def existing_spec_candidates
        [
          "#{@classifier.stem}Spec.mm",
          kiwi_spec,
          "#{@classifier.stem}Test.m" 
        ]
      end
      private :existing_spec_candidates

      def kiwi_spec
        "#{@classifier.stem}Spec.m"
      end
      private :kiwi_spec

    end

  end
end
