
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
        filename_without_extension.gsub(/(?:Spec|Test)$/, "")
      end

      def filename_without_extension
        @filename.gsub(/\.[^\.]*$/, "")
      end
      private :filename_without_extension

    end

  end
end
