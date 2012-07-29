module IOS
  module Vim

    class ClangCompleterizer

      def initialize(libclang_finder=LibclangFinder.new)
        @libclang_finder = libclang_finder
      end

      def configure_environment
        VIM.command configure_command
      rescue IOError => e
      end

      def configure_command
        "let g:clang_library_path = #{clang_library_path.inspect}"
      end
      private :configure_command

      def clang_library_path
        File.dirname(@libclang_finder.find)
      end
      private :clang_library_path

    end

  end
end
