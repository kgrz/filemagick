require 'forwardable'

module Filemagick
  class File
    extend Forwardable
    attr_reader :file, :validator, :given_extension

    EXTENSION_ABSENT = <<EOS
The file provided doesn't seem to have an extension associated with it.
The current version of the gem requires the file to have an extension inorder
to validate the file. In later versions, a more thorough validation scheme will
be introduced.

The file types currently supported for validation are those having the
extensions:

#{Signatures.instance.known_extensions.sort}
EOS

    def_delegators :@file, :path, :read, :rewind, :close
    def_delegators :@validator, :valid?

    def initialize(path_or_io)
      init_file!(path_or_io)

      @given_extension = ::File.extname(path_or_io)
      raise EXTENSION_ABSENT if given_extension.empty?

      @validator ||= Filemagick::Validator.new(file)
    end

    def valid?
      @validator.valid?
    end

    private

    def init_file!(path_or_io)

      if path_or_io.is_a?(IO)
        raise FILE_UNREADABLE unless ::File.readable?(path_or_io)
        @file = path_or_io
        @file.rewind
      else
        raise INVALID_FILE unless ::File.exists?(path_or_io)
        @file = ::File.new(path_or_io)
      end
    end
  end
end
