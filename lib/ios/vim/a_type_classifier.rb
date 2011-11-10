module IOS
  module Vim
    class ATypeClassifier

      EXTENSIONS = {
        :header => ['h', 'hh', 'hpp', 'H', 'hxx'],
        :source => ['m', 'mm', 'cpp', 'cc', 'C', 'cxx']
      }

      def initialize filename
        @filename = Filename.new filename
      end

      def type
        EXTENSIONS.each {|t, es| return t if es.include? @filename.extension}
        :unknown
      end

      EXTENSIONS.keys.each do |key|
        define_method("#{key}?") {type == key}
      end

      def stem
        @filename.stem
      end

      def extensions_for_type type
        EXTENSIONS[type]
      end

      def primary_extension_for type
        EXTENSIONS[type][0]
      end

    end
  end
end

