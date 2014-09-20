module Filemagick
  module Errors
    class CannotDetermineSignature < StandardError
      MESSAGE = <<-EOF
Unable to determine the signatures for the file due to the length of the file \
being less than the minimum required size for the provided mime type.

This usually means that the provided file is an empty text file, but not always.
EOF

      def message
        MESSAGE
      end
    end
  end
end
