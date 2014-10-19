# This class handles the extraction of the bytes, comparision and returning
# the result
module Filemagick
  class Validator
    attr_reader :file, :signatures_object
    attr_reader :extracted_starting_signature

    def initialize(file)
      @file = file
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
      valid_starting_signature?
    end

    private

    def valid_starting_signature?
      extractor = Extractor.new(file)
      extractor.process!
      signatures = Signature.for_file(file)
      extracted_signature = extractor.extracted_signature

      extracted_signature =~ signature
    end

    # This method returns the max number of bytes required to validate the
    # signature. That is, if an extension has multiple valid signatures, like
    # in the case of the jpeg and related file types, this method will return
    # the maximum number of bytes to out of all the bytes signatures to ensure
    # correct identification
    def bytes_to_read_from_start
      starting_hex_codes.map(&:length).max
    end

    def starting_byte_offset
      @signatures_object["signatures"]["starting"]["offset"]
    end

    def starting_hex_codes
      @signatures_object["signatures"]["starting"]["hexcodes"]
    end
  end
end
