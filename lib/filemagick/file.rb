require 'forwardable'

module Filemagick
  class File
    extend Forwardable
    attr_reader :file, :validator, :expected_mime_type

    INVALID_MIME_TYPE = <<EOS
Provide a valid mime type. You provided a mime type which is
not either currently supported or is an invalid one. If it's the latter,
try again with a valid mime type. Following are the mime types currently
supported for validation:

#{Signatures.instance.known_mime_types.sort}
EOS

    def_delegators :@file, :path, :read, :rewind, :close
    def_delegators :@validator, :valid?

    def initialize(path_or_io:, expected_mime_type:)
      @expected_mime_type = expected_mime_type
      raise INVALID_MIME_TYPE unless valid_mime_type?(expected_mime_type)

      read_file!(path_or_io)

      @validator ||= Validator.new(
        file: file,
        expected_mime_type: expected_mime_type
      )
    end

    def valid?
      @validator.valid?
    end

    private

    def read_file!(path_or_io)
      if path_or_io.is_a?(IO)
        @file = path_or_io
        @file.rewind
      else
        @file = ::File.new(path_or_io)
      end
    end

    def valid_mime_type?(expected_mime_type)
      signatures = Signatures.instance.known_mime_types
      signatures.member?(expected_mime_type)
    end
  end
end
