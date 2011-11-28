module IOS
  module Vim
    class RelatedFinder

      module CommonMethods

        def initialize(filename, classifier)
          @filename = filename
          @classifier = classifier
        end

        def my_type
          self.class.name.gsub(/^.*::/, "").downcase.to_sym
        end

        def file_is_my_type?
          @classifier.type == my_type
        end

        def find
          return @filename if file_is_my_type?
          candidates.detect{|e| File.exists? e} || default
        end

      end

    end
  end
end

