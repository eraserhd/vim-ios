
module IOS
  module Vim

    class RTypeClassifier

      def initialize(filename)
        @filename = filename
      end

      def type
        return :spec if @filename =~ /(?:Spec|Test)\.[^\.]*$/
        :code
      end
      
      def stem
        @filename.gsub(/\.[^\.]*$/, "").gsub(/(?:Spec|Test)$/, "")
      end

    end

  end
end
