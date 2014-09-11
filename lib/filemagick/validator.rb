# This class handles the extraction of the bytes, comparision and returning
# the result
module Filemagick
  class Validator
    attr_reader :file, :expected_mime_type

    def initialize(file:, expected_mime_type:)
      @file = file
      @expected_mime_type  = expected_mime_type
      @signatures_for_mime = Signatures.find do |signature|
        signature.mime == expected_mime_type
      end

      read_starting_bytes!
      read_trailing_bytes!
    end

    # This method processes the file to get the magic number for the type
    # it is supposedly acting as. That is, if the `file_extension` method
    # returns 'pdf', then the file is tested to see if that magic number
    # exists in the file or not. If not, this simply returns false
    #
    # In future versions, this gets changed a bit and a new method
    # `extension_from_magic_number` (or something similar) will get added
    # so that in the case that the validation returned false, users can inspect
    # what the magic number based extension is.
    def valid?
    end

    private

    def file_extension
      ::File.extname(file).gsub('.', '')
    end

    def read_starting_bytes!
    end

    def read_trailing_bytes!
    end
  end
end
