module IOS
  module Vim
    class FileClassifier

      EXTENSIONS = {
        :header => ['h', 'hpp', 'hh', 'H', 'hxx'],
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

    end
  end
end

