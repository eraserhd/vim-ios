
module IOS
  module Vim

    class RTypeClassifier

      def initialize(filename)
        @filename = filename
      end

      def type
        return :spec if @filename =~ /(?:Spec|Test)\.(?:m|h)$/
        :code
      end

    end

  end
end
